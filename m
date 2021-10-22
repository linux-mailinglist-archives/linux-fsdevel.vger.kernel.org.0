Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0992437010
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 04:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhJVCgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 22:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhJVCgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:36:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61072C061764;
        Thu, 21 Oct 2021 19:34:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i1so1687320plr.13;
        Thu, 21 Oct 2021 19:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HN3pVMGgALmpCfE1VthCVX7JXGwd42Z3MC17JzM4VqA=;
        b=AGblZ/FhMkeaQBtpk8KICsPbU/ny05lrplSOvtB8neudkLygO2Njh4s4Ro8uoAIVpi
         2p7kjGdiSBfZOFzKlFCtttn3EL7XbgE6TZtDBvA2xxeMkg7ZBPhkPnlc0dvd3BCIBlW0
         /IaB7muzsLEzNoDeJ/BhXQq6BqRXWyOY6hAGV04a1q8CrrweWmPUyYySD4bEpGm/NhpJ
         2w1mrHSRZRi7HH35UfQ7vdXA36APTM3MTFcD/CPms2VHrZXdusUK5UcqnqZ1AOaRin2w
         6Ubp/sxpulY1e8aWZGETwc+4nQ0tDa31L0SwUOe4JKoGOy05XtVWbT/+4priJXK8jdsA
         6YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=HN3pVMGgALmpCfE1VthCVX7JXGwd42Z3MC17JzM4VqA=;
        b=fSXbPCLt0NHa1gCocIdLawLR3a6Z8ERygD4djD0wNMrC/u9k9S+8tuv3NZ5Pa6w6b4
         x8CnDZTYwmBfdASO+78ZCiqNMWWkQ0Nyylpf0ite8rG5HJRhVUadfPwirMnxVawDTqHK
         3Bg7IbR/uc788OCxqcyIDuhzggvaHVcIKyFJHCIwf7RTyeuyhfitJ+jRgu7lewk3RUR1
         4nT2huQQi9c5P8fV5PTTL2uR7JBNRW3Ebh2TdArq9mXPvh/OSGKUAy/18yYOWSxlroWR
         anff2EQyxlYfzPiU8Fp7y9IR2Fva5erI/1Snlh/mLNApG5yULQIjKB5W7/gvoUHSiBgr
         /bmg==
X-Gm-Message-State: AOAM530qglKzFveRv/2Xnai+mgYdjs8mPMdFGNy6sV9OkKmepatLKea0
        fgD8EHLBfYsceNSWgDwbdsc=
X-Google-Smtp-Source: ABdhPJwRO7vlfbv9Z/FIQWuzaY+LSj8xFBKrPHRV5Qg4Q7GDRack/DgUwzhgdHI9r7PPgYcKoBHcFw==
X-Received: by 2002:a17:902:6b0c:b0:13f:aaf4:3df3 with SMTP id o12-20020a1709026b0c00b0013faaf43df3mr8927566plk.75.1634870055793;
        Thu, 21 Oct 2021 19:34:15 -0700 (PDT)
Received: from [10.1.1.26] (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id rj2sm8223974pjb.32.2021.10.21.19.34.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Oct 2021 19:34:15 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] last batch of add_disk() error handling
 conversions
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20211021163856.2000993-1-mcgrof@kernel.org>
 <66655777-6f9b-adbc-03ff-125aecd3f509@i-love.sakura.ne.jp>
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        efremov@linux.com, song@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, hare@suse.de,
        jack@suse.cz, ming.lei@redhat.com, tj@kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <83138a06-11cd-d0eb-7f15-9b01fe47de26@gmail.com>
Date:   Fri, 22 Oct 2021 15:33:58 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <66655777-6f9b-adbc-03ff-125aecd3f509@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis, Tetsuo,

I'll try to test this - still running 5.13 (need the old IDE driver for 
now), so not sure this will all apply cleanly.

Cheers,

	Michael


On 22/10/21 14:06, Tetsuo Handa wrote:
> On 2021/10/22 1:38, Luis Chamberlain wrote:
>> I rebased Tetsuo Handa's patch onto the latest linux-next as this
>> series depends on it, and so I am sending it part of this series as
>> without it, this won't apply. Tetsuo, does the rebase of your patch
>> look OK?
>
> OK, though I wanted my fix to be sent to upstream and stable before this series.
>
>>
>> If it is not too much trouble, I'd like to ask for testing for the
>> ataflop changes from Michael Schmitz, if possible, that is he'd just
>> have to merge Tetsuo's rebased patch and the 2nd patch in this series.
>> This is all rebased on linux-next tag 20211020.
>
> Yes, please.
>
> After this series, I guess we can remove "bool registered[NUM_DISK_MINORS];" like below
> due to (unit[drive].disk[type] != NULL) == (unit[drive].registered[type] == true).
> Regarding this series, setting unit[drive].registered[type] = true in ataflop_probe() is
> pointless because atari_floppy_cleanup() checks unit[i].disk[type] != NULL for calling
> del_gendisk(). And we need to fix __register_blkdev() in driver/block/floppy.c because
> floppy_probe_lock is pointless.
>
>  drivers/block/ataflop.c | 75 +++++++++++++++--------------------------
>  1 file changed, 28 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index c58750dcc685..7fedf8506335 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -299,7 +299,6 @@ static struct atari_floppy_struct {
>  				   disk change detection) */
>  	int flags;		/* flags */
>  	struct gendisk *disk[NUM_DISK_MINORS];
> -	bool registered[NUM_DISK_MINORS];
>  	int ref;
>  	int type;
>  	struct blk_mq_tag_set tag_set;
> @@ -1988,41 +1987,20 @@ static int ataflop_probe(dev_t dev)
>  	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
>  		return -EINVAL;
>
> -	if (!unit[drive].disk[type]) {
> -		err = ataflop_alloc_disk(drive, type);
> -		if (err == 0) {
> -			err = add_disk(unit[drive].disk[type]);
> -			if (err) {
> -				blk_cleanup_disk(unit[drive].disk[type]);
> -				unit[drive].disk[type] = NULL;
> -			} else
> -				unit[drive].registered[type] = true;
> +	if (unit[drive].disk[type])
> +		return 0;
> +	err = ataflop_alloc_disk(drive, type);
> +	if (err == 0) {
> +		err = add_disk(unit[drive].disk[type]);
> +		if (err) {
> +			blk_cleanup_disk(unit[drive].disk[type]);
> +			unit[drive].disk[type] = NULL;
>  		}
>  	}
>
>  	return err;
>  }
>
> -static void atari_floppy_cleanup(void)
> -{
> -	int i;
> -	int type;
> -
> -	for (i = 0; i < FD_MAX_UNITS; i++) {
> -		for (type = 0; type < NUM_DISK_MINORS; type++) {
> -			if (!unit[i].disk[type])
> -				continue;
> -			del_gendisk(unit[i].disk[type]);
> -			blk_cleanup_queue(unit[i].disk[type]->queue);
> -			put_disk(unit[i].disk[type]);
> -		}
> -		blk_mq_free_tag_set(&unit[i].tag_set);
> -	}
> -
> -	del_timer_sync(&fd_timer);
> -	atari_stram_free(DMABuffer);
> -}
> -
>  static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)
>  {
>  	int type;
> @@ -2030,13 +2008,24 @@ static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)
>  	for (type = 0; type < NUM_DISK_MINORS; type++) {
>  		if (!fs->disk[type])
>  			continue;
> -		if (fs->registered[type])
> -			del_gendisk(fs->disk[type]);
> +		del_gendisk(fs->disk[type]);
>  		blk_cleanup_disk(fs->disk[type]);
>  	}
>  	blk_mq_free_tag_set(&fs->tag_set);
>  }
>
> +static void atari_floppy_cleanup(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < FD_MAX_UNITS; i++)
> +		atari_cleanup_floppy_disk(&unit[i]);
> +
> +	del_timer_sync(&fd_timer);
> +	if (DMABuffer)
> +		atari_stram_free(DMABuffer);
> +}
> +
>  static int __init atari_floppy_init (void)
>  {
>  	int i;
> @@ -2055,13 +2044,10 @@ static int __init atari_floppy_init (void)
>  		unit[i].tag_set.numa_node = NUMA_NO_NODE;
>  		unit[i].tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>  		ret = blk_mq_alloc_tag_set(&unit[i].tag_set);
> -		if (ret)
> -			goto err;
> -
> -		ret = ataflop_alloc_disk(i, 0);
>  		if (ret) {
> -			blk_mq_free_tag_set(&unit[i].tag_set);
> -			goto err;
> +			while (--i >= 0)
> +				blk_mq_free_tag_set(&unit[i].tag_set);
> +			return ret;
>  		}
>  	}
>
> @@ -2090,10 +2076,9 @@ static int __init atari_floppy_init (void)
>  	for (i = 0; i < FD_MAX_UNITS; i++) {
>  		unit[i].track = -1;
>  		unit[i].flags = 0;
> -		ret = add_disk(unit[i].disk[0]);
> -		if (ret)
> -			goto err_out_dma;
> -		unit[i].registered[0] = true;
> +		ret = ataflop_probe(MKDEV(0, 1 << 2));
> +		if (err)
> +			goto err;
>  	}
>
>  	printk(KERN_INFO "Atari floppy driver: max. %cD, %strack buffering\n",
> @@ -2108,12 +2093,8 @@ static int __init atari_floppy_init (void)
>  	}
>  	return ret;
>
> -err_out_dma:
> -	atari_stram_free(DMABuffer);
>  err:
> -	while (--i >= 0)
> -		atari_cleanup_floppy_disk(&unit[i]);
> -
> +	atari_floppy_cleanup();
>  	return ret;
>  }
>
>
