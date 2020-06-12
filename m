Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55451F76AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFLKXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 06:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFLKWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:22:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68098C03E96F;
        Fri, 12 Jun 2020 03:22:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so4094664pfx.8;
        Fri, 12 Jun 2020 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=noIaDqzF0Hy0wDxWXCxde4St7xMeQMqL/FRpa5in1SM=;
        b=BcVsS0xJ/2gsIyBtE2ca+koozYrlg3aXsx8+9/oVbeUe+martaZOV0yydRA4arQvQv
         7VSy6fpArXlSUIPcWDctuHiCSBG/jA0XZWoDBf+4n6UvLxPglf6E3KYvtcMx+B9u5gd/
         HLcvmC9dc1kpfuICLvaO+sP/yoT3G0BR/ZUZDuImXORuk8y15CsV30uLomxeWsrDPlZ0
         p2xtvdicL41O+yUH7slDvjTsbj0wpHiqGA2LjIFncrpzZp8MczRI7tFj3lvqnH/Bv2sC
         Z143D0BIV5UiUR0p3refrlLVZpfXmv0Lza77Cy9Cn/3ZA94rcVQOk84vUBEG6F47H+BI
         Dhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=noIaDqzF0Hy0wDxWXCxde4St7xMeQMqL/FRpa5in1SM=;
        b=Mullao7Ou16ruyYlB2gnNT97wMvBymvMp2UFf453GANo6gUJLTPRf/KTNIGkDF0n9c
         GTQITDbzJheAqEjfGak0MlvC4WPoFSqD0tolywvCG4taqxN5eij8BGG/1xbiFgjr4n+q
         GcsFw2DB14Qb9FuzqcqN1cSonCi4fNKh65H4Cvn5Nhlogc3MWeqKUKtdDFO6idhv/1qa
         4qD7ZnKT77cALk1Ct2OECkLmmc6ktouBY0liYBaXC1q9OquNMZUX1xN04CjAKarFV/qh
         +PVGWnCUI11jADh/wybUAuA/zATvf0TDOZGIY97KM5vUFO/khwjtQwbuclYfBGh6D7Ov
         Z2Tg==
X-Gm-Message-State: AOAM533oqmAuxBoK6hhbGd0cUbLZXzB7gPioKcF1Rl9+GiAonFZwuX6d
        xqEyIdgf55+6CunGXfPCz4U6nflQcJM=
X-Google-Smtp-Source: ABdhPJxVR2y4IaH8q1HR7ZzBxF6FhLYrHNMJSiOBUxoR+/+FRJYk6nW5RAnpxOXqb6wjl8PLHJbUow==
X-Received: by 2002:aa7:9252:: with SMTP id 18mr11339511pfp.17.1591957357401;
        Fri, 12 Jun 2020 03:22:37 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:40d4:9829:ac15:641f? ([2404:7a87:83e0:f800:40d4:9829:ac15:641f])
        by smtp.gmail.com with ESMTPSA id f7sm5484198pje.1.2020.06.12.03.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 03:22:36 -0700 (PDT)
Subject: Re: [PATCH] exfat: remove EXFAT_SB_DIRTY flag
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200612012902epcas1p4194d6fa3b3f7c46a8becb9bb6ce23d56@epcas1p4.samsung.com>
 <20200612012834.13503-1-kohada.t2@gmail.com>
 <219a01d64094$5418d7a0$fc4a86e0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <b29d254b-212a-bfcb-ab7c-456f481b85c8@gmail.com>
Date:   Fri, 12 Jun 2020 19:22:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <219a01d64094$5418d7a0$fc4a86e0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/12 17:34, Sungjong Seo wrote:
>> remove EXFAT_SB_DIRTY flag and related codes.
>>
>> This flag is set/reset in exfat_put_super()/exfat_sync_fs() to avoid
>> sync_blockdev().
>> However ...
>> - exfat_put_super():
>> Before calling this, the VFS has already called sync_filesystem(), so sync
>> is never performed here.
>> - exfat_sync_fs():
>> After calling this, the VFS calls sync_blockdev(), so, it is meaningless
>> to check EXFAT_SB_DIRTY or to bypass sync_blockdev() here.
>> Not only that, but in some cases can't clear VOL_DIRTY.
>> ex:
>> VOL_DIRTY is set when rmdir starts, but when non-empty-dir is detected,
>> return error without setting EXFAT_SB_DIRTY.
>> If performe 'sync' in this state, VOL_DIRTY will not be cleared.
>>
>> Remove the EXFAT_SB_DIRTY check to ensure synchronization.
>> And, remove the code related to the flag.
>>
>> Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
>> ---
>>   fs/exfat/balloc.c   |  4 ++--
>>   fs/exfat/dir.c      | 16 ++++++++--------
>>   fs/exfat/exfat_fs.h |  5 +----
>>   fs/exfat/fatent.c   |  7 ++-----
>>   fs/exfat/misc.c     |  3 +--
>>   fs/exfat/namei.c    | 12 ++++++------
>>   fs/exfat/super.c    | 11 +++--------
>>   7 files changed, 23 insertions(+), 35 deletions(-)
>>
> [snip]
>>
>> @@ -62,11 +59,9 @@ static int exfat_sync_fs(struct super_block *sb, int
>> wait)
>>
>>   	/* If there are some dirty buffers in the bdev inode */
>>   	mutex_lock(&sbi->s_lock);
>> -	if (test_and_clear_bit(EXFAT_SB_DIRTY, &sbi->s_state)) {
>> -		sync_blockdev(sb->s_bdev);
>> -		if (exfat_set_vol_flags(sb, VOL_CLEAN))
>> -			err = -EIO;
>> -	}
> 
> I looked through most codes related to EXFAT_SB_DIRTY and VOL_DIRTY.
> And your approach looks good because all of them seem to be protected by
> s_lock.
> 
> BTW, as you know, sync_filesystem() calls sync_fs() with 'nowait' first,
> and then calls it again with 'wait' twice. No need to sync with lock twice.
> If so, isn't it okay to do nothing when wait is 0?

I also think  ‘do nothing when wait is 0’ as you say, but I'm still not sure.

Some other Filesystems do nothing with nowait and just return.
However, a few Filesystems always perform sync.

sync_blockdev() waits for completion, so it may be inappropriate to call with  nowait. (But it was called in the original code)

I'm still not sure, so I excluded it in this patch.
Is it okay to include it?


>> +	sync_blockdev(sb->s_bdev);
>> +	if (exfat_set_vol_flags(sb, VOL_CLEAN))
>> +		err = -EIO;
>>   	mutex_unlock(&sbi->s_lock);
>>   	return err;
>>   }
>> --
>> 2.25.1
> 
> 

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>

