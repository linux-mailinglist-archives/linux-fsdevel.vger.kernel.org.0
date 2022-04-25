Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C550D68D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 03:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiDYBbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 21:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiDYBbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD3D0DE935
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Apr 2022 18:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650850092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yWGAvjQef7xMOnO4TUloUSDXWdlreZxNm5RKmGNAwQs=;
        b=fkc1/fo/uOKJ8+WUu8EP6MAnv5HuasTXU1AGvh1cpcyZjl6twxbjwb7yQZc4+Zen/a39/+
        zDJq1IdyvZR6nygK1Drn/zkb9/NNW7Ht4R+RKO2V27cDEMzOrulkUKmw1pU7VoaIwluhfV
        lln1YrPgO0iHVez9P7vAbAZPqFDJM6g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-HvICT7MBPIa_1yJKboZq2Q-1; Sun, 24 Apr 2022 21:28:07 -0400
X-MC-Unique: HvICT7MBPIa_1yJKboZq2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A5AD1C0514D;
        Mon, 25 Apr 2022 01:28:06 +0000 (UTC)
Received: from localhost (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFC6B40EC001;
        Mon, 25 Apr 2022 01:28:04 +0000 (UTC)
Date:   Mon, 25 Apr 2022 09:28:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     yingelin <yingelin@huawei.com>
Cc:     ebiederm@xmission.com, keescook@chromium.org, mcgrof@kernel.org,
        yzaikin@google.com, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenjianguo3@huawei.com, nixiaoming@huawei.com,
        qiuguorui1@huawei.com, young.liuyang@huawei.com,
        zengweilin@huawei.com
Subject: Re: [PATCH sysctl-testing v2] kernel/kexec_core: move kexec_core
 sysctls into its own file
Message-ID: <YmX5Ic8eyMQZbIxY@MiWiFi-R3L-srv>
References: <20220424025740.50371-1-yingelin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424025740.50371-1-yingelin@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/24/22 at 10:57am, yingelin wrote:
> This move the kernel/kexec_core.c respective sysctls to its own file.
> 
> kernel/sysctl.c has grown to an insane mess, We move sysctls to places
> where features actually belong to improve the readability and reduce
> merge conflicts. At the same time, the proc-sysctl maintainers can easily
> care about the core logic other than the sysctl knobs added for some feature.
> 
> We already moved all filesystem sysctls out. This patch is part of the effort
> to move kexec related sysctls out.
> 
> Signed-off-by: yingelin <yingelin@huawei.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> ---
> v2:
>   1. Add the explanation to commit log to help patch review and subsystem
>   maintainers better understand the context/logic behind the migration
>   2. Add CONFIG_SYSCTL to to isolate the sysctl
>   3. Change subject-prefix of sysctl-next to sysctl-testing
> 
> v1: https://lore.kernel.org/lkml/20220223030318.213093-1-yingelin@huawei.com/
>   1. Lack more informations in the commit log to help patch review better
>   2. Lack isolation of the sysctl
>   3. Use subject-prefix of sysctl-next
> ---
>  kernel/kexec_core.c | 22 ++++++++++++++++++++++
>  kernel/sysctl.c     | 13 -------------
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..a0456baf52cc 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -936,6 +936,28 @@ int kimage_load_segment(struct kimage *image,
>  struct kimage *kexec_image;
>  struct kimage *kexec_crash_image;
>  int kexec_load_disabled;
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table kexec_core_sysctls[] = {
> +	{
> +		.procname	= "kexec_load_disabled",
> +		.data		= &kexec_load_disabled,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		/* only handle a transition from default "0" to "1" */
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +
> +static int __init kexec_core_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", kexec_core_sysctls);
> +	return 0;
> +}
> +late_initcall(kexec_core_sysctl_init);
> +#endif
>  
>  /*
>   * No panic_cpu check version of crash_kexec().  This function is called
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index b60345cbadf0..0f3cb61a2e39 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -61,7 +61,6 @@
>  #include <linux/capability.h>
>  #include <linux/binfmts.h>
>  #include <linux/sched/sysctl.h>
> -#include <linux/kexec.h>
>  #include <linux/mount.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/pid.h>
> @@ -1712,18 +1711,6 @@ static struct ctl_table kern_table[] = {
>  		.proc_handler	= tracepoint_printk_sysctl,
>  	},
>  #endif
> -#ifdef CONFIG_KEXEC_CORE
> -	{
> -		.procname	= "kexec_load_disabled",
> -		.data		= &kexec_load_disabled,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		/* only handle a transition from default "0" to "1" */
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ONE,
> -		.extra2		= SYSCTL_ONE,
> -	},
> -#endif
>  #ifdef CONFIG_MODULES
>  	{
>  		.procname	= "modprobe",
> -- 
> 2.26.2
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

