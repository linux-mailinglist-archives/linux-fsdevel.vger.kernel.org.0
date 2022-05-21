Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF052F803
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 May 2022 05:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347413AbiEUDZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 23:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiEUDZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 23:25:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E05187D8F;
        Fri, 20 May 2022 20:25:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gg20so9528989pjb.1;
        Fri, 20 May 2022 20:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=srHucyXa3M3L2xwtZzIWQdA+RV7TAlhAfzh/7sAefe8=;
        b=NTqXHE9UCcyj7Bih4sgeeQfhBLD7/niyepd8g2nJpwh3FEhdqVm1Lb13kRt+qOogHX
         owgvx4hSBva1Y9OvIwr3lxDFxN0quT7ul8Bn3r4xRK72lRAQsq+EkrgtbWmPuHWRK0NC
         F6qm2rsKnWWuIqSL0VChbsbwzF9+8rRSLV4wJALe2OQ5bShU3wXbGtUUk8INKcNplcn1
         XGKUi0cUDD5O160LpOhU91QAW8+nMiEd4JkBdWIN3tz8WsBj90ker8ZL5aTmzWWmUEtQ
         eBywN02hMHBhmc8lj22ZmpRGqb9LGM2cPYOtSdJlCd6A1zBO4dfbpedwHHcPTrYaoMFB
         KWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=srHucyXa3M3L2xwtZzIWQdA+RV7TAlhAfzh/7sAefe8=;
        b=e2lctWyqxzTYYbcOseXuDpZSnRqI2twfV/QxYmNG1qGgY/RHfF6j2jP1jEDOfwKIV2
         Qf639iy1QC65/L6731Z5T3M+kWzkSHQRTYEDX0komp7pJbJxF0Y4ALumS5J2TILHhJda
         zpABNVw5FBoh5S/X2kqS8OE29xAZ89ZffaGQnSYhDVASbLewJE4o2oruQGT+6RBecebz
         iZ7g3rEdVPa4KaTJd3XYsaoLOZc6vcoS1lM0ke4KK2n5Mt/9OnrNIYT7+cr1zSFTT2Tl
         0TX/GUhUGE4FQj/3FswiKjJVZnCowte03cDTtqQiSTPU1aszrmcj6Y4NYURSJAGxeDl7
         368g==
X-Gm-Message-State: AOAM5337xhiLphQXoBVSLa6BXG+FnCB/PGq+l5N4izXMNkp8UJGkgsbs
        fKEwbokTX3sjwbpEhchxUrc=
X-Google-Smtp-Source: ABdhPJz7hkAsuMIxzrZUQvOGLFk7XGtePhFKoNgQzk26Rbwa+SGIYLu8hqxi0XatY3eNzsWsIrWgRg==
X-Received: by 2002:a17:903:3112:b0:161:80df:f11 with SMTP id w18-20020a170903311200b0016180df0f11mr12268414plc.68.1653103512206;
        Fri, 20 May 2022 20:25:12 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902b78100b0015e8d4eb229sm448235pls.115.2022.05.20.20.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 20:25:11 -0700 (PDT)
Date:   Sat, 21 May 2022 12:24:56 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jack@suse.com,
        jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        djwong@kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Subject: Re: [PATCH RFC v6 02/21] dept: Implement Dept(Dependency Tracker)
Message-ID: <YohbiJquna5LlgVv@hyeyoo>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
 <1651652269-15342-3-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651652269-15342-3-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 04, 2022 at 05:17:30PM +0900, Byungchul Park wrote:
> CURRENT STATUS
> +/*

[...]

> + * Ensure it has been called on ON/OFF transition.
> + */
> +void dept_enirq_transition(unsigned long ip)
> +{
> +	struct dept_task *dt = dept_task();
> +	unsigned long flags;
> +
> +	if (unlikely(READ_ONCE(dept_stop) || in_nmi()))
> +		return;
> +
> +	/*
> +	 * IRQ ON/OFF transition might happen while Dept is working.
> +	 * We cannot handle recursive entrance. Just ingnore it.
> +	 * Only transitions outside of Dept will be considered.
> +	 */
> +	if (dt->recursive)
> +		return;
> +
> +	flags = dept_enter();
> +
> +	enirq_update(ip);
> +
> +	dept_exit(flags);
> +}

EXPORT_SYMBOL_GPL(dept_enirq_transition);

ERROR: modpost: "dept_enirq_transition" [arch/x86/kvm/kvm-amd.ko] undefined!
ERROR: modpost: "dept_enirq_transition" [arch/x86/kvm/kvm-intel.ko] undefined!

This function needs to be exported for modules.

Thanks.

-- 
Thanks,
Hyeonggon
