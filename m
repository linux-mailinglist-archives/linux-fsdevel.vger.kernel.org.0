Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1D4C21C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 03:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiBXCgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 21:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiBXCgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:36:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BF2E2325F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Feb 2022 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645670132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mosce6mCx+3FrNUgxT+llyIw3dAjkfUdqQ0Qnjl3teY=;
        b=G7m/WzI67WpIMMTks74/1MVWA6iMyEI3XlIfunIL2wPuBJ7pwBOtZUGlInpNlmX7GB19KI
        bjsNT9QC1MsGhNAMj+m0bZoWl/FD5Meypfw2Fqa66DYQsjkwXMplmzkgToO+o+W3wu06M0
        8ugKqeMa9Y4ic4QY4+CNuoCjcBcWI1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-5VULfEcfP2aqeaJ0LvbtoQ-1; Wed, 23 Feb 2022 21:35:28 -0500
X-MC-Unique: 5VULfEcfP2aqeaJ0LvbtoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A31A2180FD71;
        Thu, 24 Feb 2022 02:35:26 +0000 (UTC)
Received: from localhost (ovpn-13-249.pek2.redhat.com [10.72.13.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBEEF4BC68;
        Thu, 24 Feb 2022 02:35:24 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:35:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     yingelin <yingelin@huawei.com>
Cc:     ebiederm@xmission.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zengweilin@huawei.com, chenjianguo3@huawei.com,
        nixiaoming@huawei.com, qiuguorui1@huawei.com,
        young.liuyang@huawei.com
Subject: Re: [PATCH sysctl-next] kernel/kexec_core: move kexec_core sysctls
 into its own file
Message-ID: <Yhbu6UxoYXFtDyFk@fedora>
References: <20220223030318.213093-1-yingelin@huawei.com>
 <YhXwkTCwt3a4Dn9T@MiWiFi-R3L-srv>
 <c60419f8-422b-660d-8254-291182a06cbe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c60419f8-422b-660d-8254-291182a06cbe@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/24/22 at 09:04am, yingelin wrote:
> 
> 在 2022/2/23 16:30, Baoquan He 写道:
> > On 02/23/22 at 11:03am, yingelin wrote:
> > > This move the kernel/kexec_core.c respective sysctls to its own file.
> > Hmm, why is the move needed?
> > 
> > With my understanding, sysctls are all put in kernel/sysctl.c,
> > why is kexec special?
> 
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty dishes,
> 
> this makes it very difficult to maintain. The proc sysctl maintainers do not
> want to
> 
> know what sysctl knobs you wish to add for your own piece of code, we
> 
> just care about the core logic.
> 
> This patch moves the kexec sysctls to the place where they actually belong
> to help

That seems to be an issue everything related to sysctl are all added to
kernel/sysctl.c. Do you have a pointer that someone complained about it
and people agree to scatter them into their own component code?

I understand your concern now, I am personally not confused by that
maybe because I haven't got stuff adding or changing into sysctls. My
concern is if we only care and move kexec knob, or we have plan to try
to move all of them. If there's some background information or
discussion with a link, that would be helpful.

Thanks
Baoquan

> 
> with this maintenance.
> 
> > > Signed-off-by: yingelin <yingelin@huawei.com>
> > > ---
> > >   kernel/kexec_core.c | 20 ++++++++++++++++++++
> > >   kernel/sysctl.c     | 13 -------------
> > >   2 files changed, 20 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index 68480f731192..e57339d49439 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -936,6 +936,26 @@ int kimage_load_segment(struct kimage *image,
> > >   struct kimage *kexec_image;
> > >   struct kimage *kexec_crash_image;
> > >   int kexec_load_disabled;
> > > +static struct ctl_table kexec_core_sysctls[] = {
> > > +	{
> > > +		.procname	= "kexec_load_disabled",
> > > +		.data		= &kexec_load_disabled,
> > > +		.maxlen		= sizeof(int),
> > > +		.mode		= 0644,
> > > +		/* only handle a transition from default "0" to "1" */
> > > +		.proc_handler	= proc_dointvec_minmax,
> > > +		.extra1		= SYSCTL_ONE,
> > > +		.extra2		= SYSCTL_ONE,
> > > +	},
> > > +	{ }
> > > +};
> > > +
> > > +static int __init kexec_core_sysctl_init(void)
> > > +{
> > > +	register_sysctl_init("kernel", kexec_core_sysctls);
> > > +	return 0;
> > > +}
> > > +late_initcall(kexec_core_sysctl_init);
> > >   /*
> > >    * No panic_cpu check version of crash_kexec().  This function is called
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index ae5e59396b5d..00e97c6d6576 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -61,7 +61,6 @@
> > >   #include <linux/capability.h>
> > >   #include <linux/binfmts.h>
> > >   #include <linux/sched/sysctl.h>
> > > -#include <linux/kexec.h>
> > >   #include <linux/bpf.h>
> > >   #include <linux/mount.h>
> > >   #include <linux/userfaultfd_k.h>
> > > @@ -1839,18 +1838,6 @@ static struct ctl_table kern_table[] = {
> > >   		.proc_handler	= tracepoint_printk_sysctl,
> > >   	},
> > >   #endif
> > > -#ifdef CONFIG_KEXEC_CORE
> > > -	{
> > > -		.procname	= "kexec_load_disabled",
> > > -		.data		= &kexec_load_disabled,
> > > -		.maxlen		= sizeof(int),
> > > -		.mode		= 0644,
> > > -		/* only handle a transition from default "0" to "1" */
> > > -		.proc_handler	= proc_dointvec_minmax,
> > > -		.extra1		= SYSCTL_ONE,
> > > -		.extra2		= SYSCTL_ONE,
> > > -	},
> > > -#endif
> > >   #ifdef CONFIG_MODULES
> > >   	{
> > >   		.procname	= "modprobe",
> > > -- 
> > > 2.26.2
> > > 
> > .
> 

