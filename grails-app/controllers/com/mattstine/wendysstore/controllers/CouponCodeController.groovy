

package com.mattstine.wendysstore.controllers

import com.mattstine.wendysstore.domain.CouponCode

class CouponCodeController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ couponCodeInstanceList: CouponCode.list( params ), couponCodeInstanceTotal: CouponCode.count() ]
    }

    def show = {
        def couponCodeInstance = CouponCode.get( params.id )

        if(!couponCodeInstance) {
            flash.message = "CouponCode not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ couponCodeInstance : couponCodeInstance ] }
    }

    def delete = {
        def couponCodeInstance = CouponCode.get( params.id )
        if(couponCodeInstance) {
            try {
                couponCodeInstance.delete()
                flash.message = "CouponCode ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "CouponCode ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "CouponCode not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def couponCodeInstance = CouponCode.get( params.id )

        if(!couponCodeInstance) {
            flash.message = "CouponCode not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ couponCodeInstance : couponCodeInstance ]
        }
    }

    def update = {
        def couponCodeInstance = CouponCode.get( params.id )
        if(couponCodeInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(couponCodeInstance.version > version) {
                    
                    couponCodeInstance.errors.rejectValue("version", "couponCode.optimistic.locking.failure", "Another user has updated this CouponCode while you were editing.")
                    render(view:'edit',model:[couponCodeInstance:couponCodeInstance])
                    return
                }
            }
            couponCodeInstance.properties = params
            if(!couponCodeInstance.hasErrors() && couponCodeInstance.save()) {
                flash.message = "CouponCode ${params.id} updated"
                redirect(action:show,id:couponCodeInstance.id)
            }
            else {
                render(view:'edit',model:[couponCodeInstance:couponCodeInstance])
            }
        }
        else {
            flash.message = "CouponCode not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def couponCodeInstance = new CouponCode()
        couponCodeInstance.properties = params
        return ['couponCodeInstance':couponCodeInstance]
    }

    def save = {
        def couponCodeInstance = new CouponCode(params)
        if(!couponCodeInstance.hasErrors() && couponCodeInstance.save()) {
            flash.message = "CouponCode ${couponCodeInstance.id} created"
            redirect(action:show,id:couponCodeInstance.id)
        }
        else {
            render(view:'create',model:[couponCodeInstance:couponCodeInstance])
        }
    }
}
