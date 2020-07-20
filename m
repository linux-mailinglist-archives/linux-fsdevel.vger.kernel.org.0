Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936A8226284
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgGTOtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 10:49:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41239 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTOtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:49:53 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jxX71-0004mv-1t
        for linux-fsdevel@vger.kernel.org; Mon, 20 Jul 2020 14:49:51 +0000
Received: by mail-io1-f69.google.com with SMTP id z65so11385317iof.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2020 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UynUwfxXKtslIQGXW/Xz8Fc+e3uvcsVRgLTpCInGsDE=;
        b=sBvhk2vmLrWVixMZ5fJSy1O5wvDrtYuFacLivWtZ2ke25GKcMPXgNr+ME4rbkI2nw+
         59Y1vpT+JtMQSEEgJqoGBjk2J9xyk3c1g3JjFYHnxzpTQVhuM4veXF12rdoYTtgI0SQT
         301k7AdXaEKJeRb0VuA6BBouKmVimZqgPXhbPvYi57mu2mp9h/WVXtd3mmsyoEu/C3+H
         imXbFD7kWWRzGJc/oKWKRxsc9qJGH+yLpKyaBaWgkJgBcMgftcf9NRmEAcM0Pt0vM8kJ
         z5ng8po6SXAqv/ciwGTqQiBWihUwf+SJjSF2po2da32gu0xFzBePNa3Rc0FQV8QejX5b
         fBrQ==
X-Gm-Message-State: AOAM533m/P7xgGMEjIuJCaBlZDu+kf0+QN2YpYAVvu92cNtGFJfVIYMf
        0IZXT6Wlb8HAqm2ueWH6WbohZqbe3Cvg96BaJv/CgckWN/GsiHn3oxdhwGAySLGSEBQoK2Q60/W
        J3/DvJeZytH9q729iiB5bGydStr280Wh/AYpNJeFPl5s=
X-Received: by 2002:a05:6638:14b:: with SMTP id y11mr26726501jao.49.1595256589994;
        Mon, 20 Jul 2020 07:49:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaWVGLq9ZbulBYi6QlwzDcIE+3FU5hMSAmBSl2+5Zt0zV1nIbRaFkwohidG1LKIoheTo7HTA==
X-Received: by 2002:a05:6638:14b:: with SMTP id y11mr26726486jao.49.1595256589760;
        Mon, 20 Jul 2020 07:49:49 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:90fa:132a:bf3e:99a1])
        by smtp.gmail.com with ESMTPSA id r23sm93061iob.42.2020.07.20.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:49:49 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:49:47 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Alberto Milone <alberto.milone@canonical.com>,
        linux-fsdevel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/1] radix-tree: do not export radix_tree_preloads as GPL
Message-ID: <20200720144947.GC3644@ubuntu-x1>
References: <20200717101848.1869465-1-alberto.milone@canonical.com>
 <20200717104300.h7k7ho25hmslvtgy@linutronix.de>
 <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
 <20200717132147.nizfehgvzsdi2tfv@linutronix.de>
 <ea8b14c7-cda9-d0c1-b36a-8f2deea3ca18@canonical.com>
 <20200717142848.GK3644@ubuntu-x1>
 <20200717143439.GL3644@ubuntu-x1>
 <20200717155519.GM3644@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717155519.GM3644@ubuntu-x1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:55:19AM -0500, Seth Forshee wrote:
> On Fri, Jul 17, 2020 at 09:34:39AM -0500, Seth Forshee wrote:
> > On Fri, Jul 17, 2020 at 09:28:48AM -0500, Seth Forshee wrote:
> > > On Fri, Jul 17, 2020 at 03:45:10PM +0200, Alberto Milone wrote:
> > > > On 17/07/2020 15:21, Sebastian Andrzej Siewior wrote:
> > > > > On 2020-07-17 14:33:31 [+0200], Alberto Milone wrote:
> > > > >> I checked and CONFIG_DEBUG_LOCK_ALLOC is not enabled in our kernels.
> > > > > The access to that variable is optimized away if not for debug. I made
> > > > > this:
> > > > > | #include <linux/module.h>
> > > > > | #include <linux/idr.h>
> > > > > | 
> > > > > | static int le_init(void)
> > > > > | {
> > > > > |         idr_preload_end();
> > > > > |         return 0;
> > > > > | }
> > > > > | module_init(le_init);
> > > > > | 
> > > > > | static void le_exit(void)
> > > > > | {
> > > > > | }
> > > > > | module_exit(le_exit);
> > > > > |    
> > > > > | MODULE_DESCRIPTION("driver");
> > > > > | MODULE_LICENSE("prop");
> > > > >
> > > > > and it produced a .ko. Here the "idr_preload_end()" was reduced to
> > > > > "preempt_enable()" as intended. No access to
> > > > > "&radix_tree_preloads.lock".
> > > > >
> > > > > Sebastian
> > > > * Subscribing Seth
> > > 
> > > Looks like the driver is not using idr_preload_end() though, it is
> > > calling radix_tree_preload_end() which uses radix_tree_preloads whether
> > > or not CONFIG_DEBUG_LOCK_ALLOC is enabled.
> > 
> > Sorry, I didn't dig deep enough. I see that radix_tree_preload_end() is
> > expected to opimize away that access too. I wonder if different
> > toolchains could be ending up with different reults.
> 
> Your example gives me the same error about using radix_tree_preloads. I
> also added:
> 
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  #warn "CONFIG_DEBUG_LOCK_ALLOC enabled"
>  #endif
> 
> Nothing is printed, so the option really does appear to be off. I've
> been staring at it a while and I can't see why the module still ends up
> referencing radix_tree_preloads, but it is clearly happening.

Even ignoring what is happening with our kernels, isn't this a
regression with CONFIG_DEBUG_LOCK_ALLOC=y that should be fixed? There
have been similar cases in the past where gpl-only exports leaked out
into interfaces which were previously usable by non-gpl modules, and
they were fixed -- 31c5bda3a656089f01963d290a40ccda181f816e and
9e987b70ada27554c5d176421de1d167218c49b5 are a couple of examples I was
able to find with minimal effort. Why is this case any different?

Thanks,
Seth
