Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DBE31C5EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 05:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhBPEIM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 23:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBPEH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 23:07:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BA3C061756;
        Mon, 15 Feb 2021 20:07:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fa16so4922412pjb.1;
        Mon, 15 Feb 2021 20:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=P6ogKo1A9213/gC0w2jezKdh3yW9CFSzOJActe8me/Y=;
        b=j76cpXLiJuRnmSXZFwKZCFDp+Dp1jxf/iSQkn84tJFLY3HW4KqnwHfr64qrIH19jN4
         xBVrwNKDGgFgGnp6P9AosIOJYU9sbmK3B6Z10eDiwygVIGhiEvawl1mg2QKPb6wOxiSt
         sWSvxI7wDzspmKlYj3/a101ma8VlXZJPzafaQYL23Rdf6KdrxEn4KNpubOGR6oC/QTDJ
         aJR3kcNEL53rYe6uK1/09cWS1KEPHdCg50ALarh38jCzL+r3HI8JyEI17oZ0ExE0gvf7
         AjTydmM3rqq6P0OVECLpI4hnDmiG18HrCDDNYOAbJdvo/5S182A/QjQD/kr7VVABBN3K
         8bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=P6ogKo1A9213/gC0w2jezKdh3yW9CFSzOJActe8me/Y=;
        b=Gg/6Cyw8gRtc1bqjjJpuIOGI2xZJL2aumtpySSW516iqjqby0sFV+9WMa1w0o2mwZt
         vWYP1krJnIuVqHb7WClB9HdvwZwDx0JByfrXqLSyDRHqQdiPPwzPhuSnShMuZHQ3btLB
         0izwLX2RNHru5cjNYcbcdlhcj5OnpGGMKsUGgeIGFO09XtRXaGVldVCLZTy/qEtAMU9d
         joaT9MvmnZLis3FVSz34fmGDP3MsndeyjVsbAwq/EVKwdy/Na5o60EqWiw2R2wHWoo/O
         7hecw7L3hrHKv/63KvjBVXNrNmg1k79k5YGarI/Aq3OY5LNiH4hwCFM7zfOOJi5NLGqp
         Pl/A==
X-Gm-Message-State: AOAM532y+mQq5IM2Tcz1XTZMoQLw0U3ZHkfXr3YyUvjnLhzI2OErforz
        FjmNAjravHeur2wJEkcxFBXiUhs+U75FsA==
X-Google-Smtp-Source: ABdhPJwYCyuiaUUwBT5BrzQdWIjd+s/C0WHXRA28UNUrF0TmPlDUKaOiHHsXWjCMqKNfhtfa6xVu/w==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id v11mr2178156pjr.77.1613448438104;
        Mon, 15 Feb 2021 20:07:18 -0800 (PST)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id o185sm19342621pfb.196.2021.02.15.20.07.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2021 20:07:17 -0800 (PST)
Subject: Re: [PATCH 2/2] exfat: add support FITRIM ioctl
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210215042411.119392-1-hyeongseok@gmail.com>
 <20210215042411.119392-2-hyeongseok@gmail.com>
 <BYAPR04MB4965FC5CBAF7DB2BA1DA4FB886889@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <08394066-3cde-4d0e-3c44-ea7ecf3a3844@gmail.com>
Date:   Tue, 16 Feb 2021 13:07:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965FC5CBAF7DB2BA1DA4FB886889@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Chaitanya,
Thank you for the review.

On 2/16/21 4:33 AM, Chaitanya Kulkarni wrote:
> On 2/14/21 20:28, Hyeongseok Kim wrote:
>> +
>> +int exfat_trim_fs(struct inode *inode, struct fstrim_range *range)
>> +{
>> +	struct super_block *sb = inode->i_sb;
> Reverse tree style for function variable declaration would be nice which you
> partially have it here.
So, you mean that it would be better to be somethink like this, right?

+
+int exfat_trim_fs(struct inode *inode, struct fstrim_range *range)
+{
+	unsigned int trim_begin, trim_end, count, next_free_clu;
+	u64 clu_start, clu_end, trim_minlen, trimmed_total = 0;
+	struct super_block *sb = inode->i_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	int err = 0;
+

>> +		else {
>> +			/* trim current range if it's larger than trim_minlen */
>> +			count = trim_end - trim_begin + 1;
>> +			if (count >= trim_minlen) {
>> +				err = sb_issue_discard(sb,
>> +					exfat_cluster_to_sector(sbi, trim_begin),
>> +					count * sbi->sect_per_clus, GFP_NOFS, 0);
> You are specifying the last argument as 0 to sb_issue_disacrd() i.e.
> flags == 0 this will propagate to :-
>
> sb_issue_discard()
>      blkdev_issue_discard()
>          __blkdev__issue_discard()
>
> Now blkdev_issue_disacrd() returns -ENOTSUPP in 3 cases :-
>
> 1. If flags arg is set to BLKDEV_DISCARD_SECURE and queue doesn't support
>     secure erase. In this case you have not set BLKDEV_DISCARD_SECURE that.
>     So it should not return -EOPNOTSUPP.
> 2. If queue doesn't support discard. In this case caller of this function
>     already set that. So it should not return -EOPNOTSUPP.
> 3. If q->limits.discard_granularity is not but LLD which I think caller of
>     this function already used that to calculate the range->minlen.
>
> If above is true then err will not have value of -EOPNOTSUPP ?
I think case 3. could be possible, but I agree we don't need to handle 
-EOPNOTSUPP in other way,
but better to just return it. I'll fix this in v2.
>> +		if (need_resched()) {
>> +			mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
> sb_issue_discard() ->blkdev_issue_discard() will call cond_resced().
> 1. The check for need_resched() will ever be true since
> blkdev_issue_discard()
>     is already calling cond_sched() ?
> 2. If so do you still need to drop the mutex before calling
>     sb_issue_discard() ?
I considered the case if there are no more used blocks or no more free 
blocks (no fragmentation)
to the end of the disk, then we couldn't have the chance to call 
sb_issue_discard() until this loop ends,
that would possibly take long time.
But it's not a good idea because other process can have chance to use 
blocks which were already
been ready to discard, if we release the mutex here. I'll remove this in 
v2.
>> +			cond_resched();
>> +			mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
>> +		}
>> +
..
>> +
>>   	switch (cmd) {
>> +	case FITRIM:
>> +	{
>> +		struct request_queue *q = bdev_get_queue(sb->s_bdev);
>> +		struct fstrim_range range;
>> +		int ret = 0;
>> +
>> +		if (!capable(CAP_SYS_ADMIN))
>> +			return -EPERM;
>> +
>> +		if (!blk_queue_discard(q))
>> +			return -EOPNOTSUPP;
>> +
>> +		if (copy_from_user(&range, (struct fstrim_range __user *)arg,
>> +			sizeof(range)))
>> +			return -EFAULT;
>> +
>> +		range.minlen = max_t(unsigned int, range.minlen,
>> +					q->limits.discard_granularity);
>> +
>> +		ret = exfat_trim_fs(inode, &range);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		if (copy_to_user((struct fstrim_range __user *)arg, &range,
>> +			sizeof(range)))
>> +			return -EFAULT;
>> +
>> +		return 0;
>> +	}
>> +
> Is {} really needed for switch case ?
> Also, code related to FITRIM needs to be moved to a helper otherwise it
> will bloat
> the ioctl function, unless that is the objective here.
>>   	default:
>>   		return -ENOTTY;
>>   	}
OK, I'll move it into the exfat_trim_fs().
>

