Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E2B771502
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 14:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjHFMaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Aug 2023 08:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHFMaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Aug 2023 08:30:23 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Aug 2023 05:30:19 PDT
Received: from email.cn (m218-153.88.com [110.43.218.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ADFFA;
        Sun,  6 Aug 2023 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=Date:From:To; bh=XwvT4ZuzAPUjEFNoeaoPoW3ZrSbwhJkckqLc3
        rE+ZvA=; b=bERUKlstL21R5tjOcnGCogy4zOddooRJ+JbIzmcmA1v2qgm7k3YGt
        RlZ1owQmOLCF0Z9OIcA/3LNELEPDKDlErZ7WelA65tLW/cltM/cOdML4vaxj6em8
        9MOgmPgsorNQlBaKq0I/vt8QQWD451+vN/3loBmZaLIwk9ckZJwZnw=
Received: from localhost (unknown [124.64.65.102])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCndHYPks9kZPQPAA--.22373S3;
        Sun, 06 Aug 2023 20:29:04 +0800 (CST)
Date:   Sun, 6 Aug 2023 20:29:03 +0800
From:   Liang Li <liliang6@email.cn>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v3] init: Add support for rootwait timeout parameter
Message-ID: <ZM+SD+37ZXpIXAZO@localhost>
Reply-To: Liang Li <liliang6@email.cn>
References: <20230806101217.164068-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806101217.164068-1-loic.poulain@linaro.org>
X-CM-TRANSID: GiKnCgCndHYPks9kZPQPAA--.22373S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF17uF18KrWftr15CrW3KFg_yoWrJw45pF
        WkuFZrtF97JF47KF1xArn7u34Utw1Ikw1ayrZFgw48Aw1DJrnYvw4j9rWYy3WDCrZ8Ja15
        XFs7CF1rWr1jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgab7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWUuVWrJwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkIecxEwVAFwVW5JwCF04
        k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F4UJr1UMxC20s026xCaFVCjc4AY6r1j
        6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
        AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
        2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
        C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
        UjIFyTuYvjxUf3C7UUUUU
X-Originating-IP: [124.64.65.102]
X-CM-SenderInfo: 5oloxttqjwqvhpdlzhdfq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-08-06 18:12, Loic Poulain <loic.poulain@linaro.org> wrote:
> Add an optional timeout arg to 'rootwait' as the maximum time in
> seconds to wait for the root device to show up before attempting
> forced mount of the root filesystem.
> 
> Use case:
> In case of device mapper usage for the rootfs (e.g. root=/dev/dm-0),
> if the mapper is not able to create the virtual block for any reason
> (wrong arguments, bad dm-verity signature, etc), the `rootwait` param
> causes the kernel to wait forever. It may however be desirable to only
> wait for a given time and then panic (force mount) to cause device reset.
> This gives the bootloader a chance to detect the problem and to take some
> measures, such as marking the booted partition as bad (for A/B case) or
> entering a recovery mode.
> 
> In success case, mounting happens as soon as the root device is ready,
> unlike the existing 'rootdelay' parameter which performs an unconditional
> pause.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: rebase + reword: add use case example
>  v3: Use kstrtoint instead of deprecated simple_strtoul
> 
>  .../admin-guide/kernel-parameters.txt         |  4 ++++
>  init/do_mounts.c                              | 24 +++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1457995fd41..387cf9c2a2c5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5501,6 +5501,10 @@
>  			Useful for devices that are detected asynchronously
>  			(e.g. USB and MMC devices).
>  
> +	rootwait=	[KNL] Maximum time (in seconds) to wait for root device
> +			to show up before attempting to mount the root
> +			filesystem.
> +
>  	rproc_mem=nn[KMG][@address]
>  			[KNL,ARM,CMA] Remoteproc physical memory block.
>  			Memory area to be used by remote processor image,
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 1aa015883519..98190bf34a9f 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/ramfs.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/ktime.h>
>  
>  #include <linux/nfs_fs.h>
>  #include <linux/nfs_fs_sb.h>
> @@ -71,12 +72,25 @@ static int __init rootwait_setup(char *str)
>  {
>  	if (*str)
>  		return 0;
> -	root_wait = 1;
> +	root_wait = -1;
>  	return 1;
>  }
>  
>  __setup("rootwait", rootwait_setup);
>  
> +static int __init rootwait_timeout_setup(char *str)
> +{
> +	if (kstrtoint(str, 0, &root_wait) || root_wait < 0) {
> +		pr_warn("ignoring invalid rootwait value\n");
> +		/* fallback to indefinite wait */
> +		root_wait = -1;

Will it be a little better to add the 'fallback to infinite wait' message
into pr_wran as well?

> +	}
> +
> +	return 1;
> +}
> +
> +__setup("rootwait=", rootwait_timeout_setup);
> +
>  static char * __initdata root_mount_data;
>  static int __init root_data_setup(char *str)
>  {
> @@ -384,14 +398,20 @@ void __init mount_root(char *root_device_name)
>  /* wait for any asynchronous scanning to complete */
>  static void __init wait_for_root(char *root_device_name)
>  {
> +	const ktime_t end = ktime_add_ms(ktime_get_raw(), root_wait * MSEC_PER_SEC);
> +
>  	if (ROOT_DEV != 0)
>  		return;
>  
>  	pr_info("Waiting for root device %s...\n", root_device_name);
>  
>  	while (!driver_probe_done() ||
> -	       early_lookup_bdev(root_device_name, &ROOT_DEV) < 0)
> +	       early_lookup_bdev(root_device_name, &ROOT_DEV) < 0) {

Seems like one indent issue here?

>  		msleep(5);
> +		if (root_wait > 0 && ktime_after(ktime_get_raw(), end))
> +			break;
> +	}
> +
>  	async_synchronize_full();
>  
>  }
> -- 
> 2.34.1

Regards.
Liang Li

