Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618FC4385F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 02:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhJXAFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 20:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhJXAFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 20:05:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DD3C061764;
        Sat, 23 Oct 2021 17:03:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso6383022pjf.3;
        Sat, 23 Oct 2021 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=PxwtS641WYFpHkOEkJn+avDYn2BdLBo4DP4nO7ftXvU=;
        b=SL+DviOgCpxPI+EbDKx7sGamzqbXdpRsT5d2ofbPZ+yYodnja4MW8Lad1M/CNZPT64
         I+U2gmuBI0efwEGbGCqjMvnrDsJTrvKHAfycXNj9L39TUIHasPMQZ1x+J1jXtBoskT12
         jd6ViLyPLlic6RofzOWCIzMiRJpw5/SGTV+5676o48mQ3AJly+W83rNvwls+6m5Zj0SD
         r7BOd58BuvuMBpBQeMQjIg0qAsw7QELlYvKOZQI8Ik5V/wK3tHAwKCY1oz/4bvvAh0S9
         9A0DafTMwU1OJATeuQO/3rE81wt8XY4twDyn8neJ3+TdR9+V1+mAHPSkRhQOdZK2l97v
         XNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PxwtS641WYFpHkOEkJn+avDYn2BdLBo4DP4nO7ftXvU=;
        b=BUiZZUr/xKRyxbzAExQ6IfzlDpv4E17G6ID5gDNb7omarwLPC65qQvioCE7Wjf6Ely
         YOCg7CCZaMOy+g9nPYt/9PEJ+fo6ifWFMUZvASagO2Am0oNT1xf3lQojssSySYvTKk/e
         kV7ah74Z54u61n8fUyVbwsNj3GgaemkqUQjSy1ODV948/HRk+X4uDb7LgXXTBtBbdvyP
         hdoWvu4mojjLJXpEWhAgOKFbax0Fer7MudLjWZeyllmXL6oxVos5wCVlDq8IlqH0R47l
         cc2Bpu6n+Wm5cdG3nmI5OWzDCgWZ6hCDNAy75Ffj6Pp1Ozl2D8qnqEU0qnThzJchqZOM
         CFRA==
X-Gm-Message-State: AOAM530cL/Bh86SiPWs5MJ0rGvhcJiZ+yjLsAXhuhXOzGDDCy5v66BHN
        2vXYN64Z+bpMaZLnrokWC4o=
X-Google-Smtp-Source: ABdhPJyXCyLbpKo7n5tJ9eyNZbqsG3IqcrSFvApjQOyYw/gbVWMlhSJkUplRCpSeujKHRZk9IXEDUg==
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr10384183pjb.0.1635033798833;
        Sat, 23 Oct 2021 17:03:18 -0700 (PDT)
Received: from [10.1.1.26] (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id h1sm15243550pfi.168.2021.10.23.17.03.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Oct 2021 17:03:18 -0700 (PDT)
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
Message-ID: <ad1546c4-cfb7-3dd2-9592-9916c23ae164@gmail.com>
Date:   Sun, 24 Oct 2021 13:03:02 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <66655777-6f9b-adbc-03ff-125aecd3f509@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Tetsuo,

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

Took a little convincing (patch 2 didn't apply cleanly by 'git am' on 
yesterday's top of linux-next), but works just fine, thanks.

I'll submit another patch with ataflop fixes that were used in my tests, 
but nothing in that interacts with your patches at all.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>


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
