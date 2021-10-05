Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7197F423128
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhJEUAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 16:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhJEUAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:00:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A17C061762
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 12:58:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j15so203115plh.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m4F7KbIKLk052E6TxP0dKBCdgkUeYdYXEOD3CSUVTIM=;
        b=XniNzJtBFvHro/VDe66WdKX8l3Za6IBuWSuno6KT9zYxbIObQx4/GX0LtST1Dn0+4w
         7KNbmA5IhdFz102EuOBTy9EJBhM9WpzMsz7QEHQK4OkIN8ggyeHsXK+xZi4niG+OJynC
         mcaeqHjTrmLl4hn5gr+PJKQQj2Kp203ryO25c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m4F7KbIKLk052E6TxP0dKBCdgkUeYdYXEOD3CSUVTIM=;
        b=1Ipv41wXUkqVMoPEYaR6WYDEnFeETxY0rimw7yrlyjOMc711b4dIpvIWaY925Rlils
         qypyNYV0+nuAB8kABp1TODT6HKPQE7u2PF3f7f/g0IMNhV5dBWPNqT0RoCBIuXwIbrDj
         Fwk4eObcYh6iZO8FHIXIwWroS/AWrpAXimOx24TB2Qz5xSTDq97ogURWaIACbn+RpP/J
         MOb0XHNrpIvKQrU7eBi1YVWQiL8YSDg8HjNi0XSTfqHaW2SDwMqs9lT5ScPpWWJbHfKd
         DrVEJEnAYNPQSAB6fNkyhkdGza8WLT5YMi1DMcSLNw78aBE6Zj4tKkR5Lv+9L3dBoI/P
         4vfw==
X-Gm-Message-State: AOAM530VgTyy15IEOyCsWwhqhQmAt0TmUBYP9am8ChGacNOdHy1mW1mk
        0RV3qGnWvryzmHRW+H1CT/o4uA==
X-Google-Smtp-Source: ABdhPJyIVFMeXSk93lanHtPKT4spKueaCZvq6pzod9uEteRYiTnP6Xzri6pyKEkb7SQhAsGmyRZgXw==
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr6010010pjj.122.1633463928380;
        Tue, 05 Oct 2021 12:58:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 23sm2915094pjc.37.2021.10.05.12.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:58:48 -0700 (PDT)
Date:   Tue, 5 Oct 2021 12:58:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/12] kernel/module: add documentation for
 try_module_get()
Message-ID: <202110051252.790B3F2F0@keescook>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-7-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:37:59AM -0700, Luis Chamberlain wrote:
> There is quite a bit of tribal knowledge around proper use of
> try_module_get() and that it must be used only in a context which
> can ensure the module won't be gone during the operation. Document
> this little bit of tribal knowledge.
> 
> I'm extending this tribal knowledge with new developments which it
> seems some folks do not yet believe to be true: we can be sure a
> module will exist during the lifetime of a sysfs file operation.
> For proof, refer to test_sysfs test #32:
> 
> ./tools/testing/selftests/sysfs/sysfs.sh -t 0032
> 
> Without this being true, the write would fail or worse,
> a crash would happen, in this test. It does not.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/module.h | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index c9f1200b2312..22eacd5e1e85 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -609,10 +609,40 @@ void symbol_put_addr(void *addr);
>     to handle the error case (which only happens with rmmod --wait). */
>  extern void __module_get(struct module *module);
>  
> -/* This is the Right Way to get a module: if it fails, it's being removed,
> - * so pretend it's not there. */
> +/**
> + * try_module_get() - yields to module removal and bumps refcnt otherwise

I find this hard to parse. How about:
	"Take module refcount unless module is being removed"

> + * @module: the module we should check for
> + *
> + * This can be used to try to bump the reference count of a module, so to
> + * prevent module removal. The reference count of a module is not allowed
> + * to be incremented if the module is already being removed.

This I understand.

> + *
> + * Care must be taken to ensure the module cannot be removed during the call to
> + * try_module_get(). This can be done by having another entity other than the
> + * module itself increment the module reference count, or through some other
> + * means which guarantees the module could not be removed during an operation.
> + * An example of this later case is using try_module_get() in a sysfs file
> + * which the module created. The sysfs store / read file operations are
> + * gauranteed to exist through the use of kernfs's active reference (see
> + * kernfs_active()). If a sysfs file operation is being run, the module which
> + * created it must still exist as the module is in charge of removing the same
> + * sysfs file being read. Also, a sysfs / kernfs file removal cannot happen
> + * unless the same file is not active.

I can't understand this paragraph at all. "Care must be taken ..."? Why?
Shouldn't callers of try_module_get() be satisfied with the results? I
don't follow the example at all. It seems to just say "sysfs store/read
functions don't need try_module_get() because whatever opened the sysfs
file is already keeping the module referenced." ?

> + *
> + * One of the real values to try_module_get() is the module_is_live() check
> + * which ensures this the caller of try_module_get() can yield to userspace
> + * module removal requests and fail whatever it was about to process.

Please document the return value explicitly.

> + */
>  extern bool try_module_get(struct module *module);
>  
> +/**
> + * module_put() - release a reference count to a module
> + * @module: the module we should release a reference count for
> + *
> + * If you successfully bump a reference count to a module with try_module_get(),
> + * when you are finished you must call module_put() to release that reference
> + * count.
> + */
>  extern void module_put(struct module *module);
>  
>  #else /*!CONFIG_MODULE_UNLOAD*/
> -- 
> 2.30.2
> 

-- 
Kees Cook
