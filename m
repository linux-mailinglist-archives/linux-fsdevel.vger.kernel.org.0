Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561DF223E07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgGQO2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 10:28:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37277 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgGQO2x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:28:53 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jwRM3-0003dJ-07
        for linux-fsdevel@vger.kernel.org; Fri, 17 Jul 2020 14:28:51 +0000
Received: by mail-il1-f197.google.com with SMTP id b2so5476744ilh.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 07:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opSIBgPYfwNfaap6wniCXarAShejk3Et5RAoHwsiOu0=;
        b=i1m/4FbAEVLXJenzYsarmZXL8KSUfZA02L94Vo5sCKlU7cHumrk3x4G2RsWbiM3cjf
         cw9Ub+Y+4+j+zwD6pcGjG1pcQEvWFY3KmCx2VHFkSM5C28xdt+jjJXWIyuG9Ey/pGLbG
         FU50a7dG+chvv1YsVuL0QBT2zCG3PrgEBkg6CMbvIPNXrYXpCegL2J/KGyxvxR5nMeur
         rGSsIc7C7Y83/bIZeDpLtlzIi8IJC3G3lVkNw10ZDMwQPy1L7W6d5QN+Mx6vJPBsD09D
         EFfzeWvJrclw55KUJ+9/Oz+FzfJCqLHES/uv1sdnBQaHqQubOXfxZ5iuwdTNmxD+daJQ
         Ev1w==
X-Gm-Message-State: AOAM531du3nzsM1Z3rWKFCrvzQANroOvwjsgO0f3IA9WHawhu0ySYkjG
        8qcSsumiVH0gWsJwT0Np13mIN5XiJ0ZyA5OW3KgQvmRqyF3hO8/jAf2VnJvel7JTSUXJ6rPLIKX
        on9Tw7yH7DmCN7x623bQHIaU3ZOiXzcKlgw2yeJKH56A=
X-Received: by 2002:a5d:9b05:: with SMTP id y5mr9884095ion.59.1594996129816;
        Fri, 17 Jul 2020 07:28:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdC7DPVagu2NfN61ekpQlS2+gH3W1pbgSQQd8yP1bW1DPYpTAoKjNrdz+Z+Q+a+AOg8vinbQ==
X-Received: by 2002:a5d:9b05:: with SMTP id y5mr9884077ion.59.1594996129517;
        Fri, 17 Jul 2020 07:28:49 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:90fa:132a:bf3e:99a1])
        by smtp.gmail.com with ESMTPSA id k3sm4275846ils.8.2020.07.17.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:28:48 -0700 (PDT)
Date:   Fri, 17 Jul 2020 09:28:48 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Alberto Milone <alberto.milone@canonical.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-fsdevel@vger.kernel.org, mingo@kernel.org
Subject: Re: [PATCH 1/1] radix-tree: do not export radix_tree_preloads as GPL
Message-ID: <20200717142848.GK3644@ubuntu-x1>
References: <20200717101848.1869465-1-alberto.milone@canonical.com>
 <20200717104300.h7k7ho25hmslvtgy@linutronix.de>
 <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
 <20200717132147.nizfehgvzsdi2tfv@linutronix.de>
 <ea8b14c7-cda9-d0c1-b36a-8f2deea3ca18@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea8b14c7-cda9-d0c1-b36a-8f2deea3ca18@canonical.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 03:45:10PM +0200, Alberto Milone wrote:
> On 17/07/2020 15:21, Sebastian Andrzej Siewior wrote:
> > On 2020-07-17 14:33:31 [+0200], Alberto Milone wrote:
> >> I checked and CONFIG_DEBUG_LOCK_ALLOC is not enabled in our kernels.
> > The access to that variable is optimized away if not for debug. I made
> > this:
> > | #include <linux/module.h>
> > | #include <linux/idr.h>
> > | 
> > | static int le_init(void)
> > | {
> > |         idr_preload_end();
> > |         return 0;
> > | }
> > | module_init(le_init);
> > | 
> > | static void le_exit(void)
> > | {
> > | }
> > | module_exit(le_exit);
> > |    
> > | MODULE_DESCRIPTION("driver");
> > | MODULE_LICENSE("prop");
> >
> > and it produced a .ko. Here the "idr_preload_end()" was reduced to
> > "preempt_enable()" as intended. No access to
> > "&radix_tree_preloads.lock".
> >
> > Sebastian
> * Subscribing Seth

Looks like the driver is not using idr_preload_end() though, it is
calling radix_tree_preload_end() which uses radix_tree_preloads whether
or not CONFIG_DEBUG_LOCK_ALLOC is enabled.

Thanks,
Seth
