Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2660310C88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 20:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfEASAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 14:00:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36264 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEASAd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 14:00:33 -0400
Received: by mail-qk1-f193.google.com with SMTP id m137so10635506qke.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CWXi406PkzhQU+9UdGnKsnrqZujCyJ2gUC4Pfr8A1+A=;
        b=E4AVFO2viQI2seeFtKG1a35npNQJLByb3QSKM8xTCmV6rZIkU5talTQdbFHD6L+Ai5
         iMI79fe569b+GbG13w4ZC5bPyeiihS/5TfpSVdAgqzxvqaCs57CiHcv9AHjdCRNqZ/er
         6QMCNNa0wu9tDMC58k+KcmVEDl8PR6S643gnzDSxFvAQK4bt85r9gTnJvsQ5tTIGFC2k
         1C0T91MmVccS09qbJ85qJaGUrMaS1NYs7GvIhhF/6KxCOIcDpXeN4M2KYkdu+hWBGck1
         4AI1EYyGFjHBtaMuLdooJ0Tj8CBjnYtbJXowAH+lBhgVh/iUE5YXgXDGoVcmVT8v4eyM
         s/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWXi406PkzhQU+9UdGnKsnrqZujCyJ2gUC4Pfr8A1+A=;
        b=J+ubpTejNPOLgwpYWzBzqHXv4bma3X87QvtFXC5yHIjbJharwe6tGlZQIEQiCpdXdO
         oLrYhHfhk7x9lxpNT4bkfsYcuJfvCCKowV8ai/EsChIjvihi8gyVonzcUCqKQgri7Wpj
         npT5YhGSuzlk0f7TWJpy6UMmBmjt1ycLNEBILMm5wMnJxazULp/QuyGMNykeY1qYKpDM
         GA83AqyoXSTi6C/AP48BjyIEck1Ff71Ov3VPxrXkXjNhlPx4EqGpUbQima9WBL+3aaw8
         osOckoYVUCpj3AdrdFnLCpFjClHKbugzj9Ira9C6hQz7sV83XIIQizaDAyuBWF1qxGAn
         UZCQ==
X-Gm-Message-State: APjAAAUnmqH77OQZCiIM86ZaRwt/Y6n0u7jAc/+tMMmUrXQXdu2/v57L
        yCV28IMnVZ6JIqbJ414EvOkqoA==
X-Google-Smtp-Source: APXvYqyn3p7e1upCndsBMr8ZFBhc/gsxsqCbhHFN9BQhmLMJLdEn0d6o/DPEjXHUjE4fsWOCYqsLxQ==
X-Received: by 2002:ae9:ec07:: with SMTP id h7mr718472qkg.7.1556733632633;
        Wed, 01 May 2019 11:00:32 -0700 (PDT)
Received: from [192.168.1.10] (201-13-157-136.dial-up.telesp.net.br. [201.13.157.136])
        by smtp.gmail.com with ESMTPSA id s68sm8337799qkb.16.2019.05.01.11.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:00:31 -0700 (PDT)
Subject: Re: [RFC] [PATCH V2 0/1] Introduce emergency raid0 stop for mounted
 arrays
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>, axboe@kernel.dk,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>, kernel@gpiccoli.net,
        NeilBrown <neilb@suse.com>, dm-devel@redhat.com,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, gavin.guo@canonical.com
References: <20190418220448.7219-1-gpiccoli@canonical.com>
 <CAPhsuW4k5zz2pJBPL60VzjTcj6NTnhBh-RjvWASLcOxAk+yDEw@mail.gmail.com>
 <b39b96ea-2540-a407-2232-1af91e3e6658@canonical.com>
 <CAPhsuW65EW8JgjE8zknPQPXYcmDhX9LEhTKGb0KHywqKuZkUcA@mail.gmail.com>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Message-ID: <2823f928-d0b6-9049-73ab-b2ce0ef5da83@gpiccoli.net>
Date:   Wed, 1 May 2019 15:00:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW65EW8JgjE8zknPQPXYcmDhX9LEhTKGb0KHywqKuZkUcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 > On 5/1/19 12:33 PM, Song Liu wrote:
>> [...]
>> Indeed, fsync returns -1 in this case.
>> Interestingly, when I do a "dd if=<some_file> of=<raid0_mount>" and try
>> to "sync -f <some_file>" and "sync", it succeeds and the file is
>> written, although corrupted.
> 
> I guess this is some issue with sync command, but I haven't got time
> to look into it. How about running dd with oflag=sync or oflag=direct?
> 

Hi Song, could be some problem with sync command; using either 
'oflag=direct' or 'oflag=sync' fails the dd command instantly when a 
member is removed.


>> Do you think this behavior is correct? In other devices, like a pure
>> SCSI disk or NVMe, the 'dd' write fails.
>> Also, what about the status of the raid0 array in mdadm - it shows as
>> "clean" even after the member is removed, should we change that?
> 
> I guess this is because the kernel hasn't detect the array is gone? In
> that case, I think reducing the latency would be useful for some use
> cases.
> 

Exactly! This is the main concern here, mdadm cannot stop the array 
since it's mounted, and there's no filesystem API to quickly shutdown 
the filesystem, hence it keeps "alive" for too long after the failure.

For instance, if we have a raid0 with 2 members and remove the 1st, it 
fails much quicker than if we remove the 2nd; the filesystem will 
"realize" the device is flaw quickly if we remove the 1st member, and 
goes to RO mode. Specially, xfs seems even faster than ext4 in noticing 
the failure.

Do you have any suggestion on how could we reduce this latency? And how 
about the status exhibited by mdadm, shall it move from 'clean' to 
something more meaningful in the failure case?

Thanks again,


Guilherme

> Thanks,
> Song
> 
>>
>>
>>> Also, could you please highlight changes from V1 (if more than
>>> just rebase)?
>>
>> No changes other than rebase. Worth mentioning here that a kernel bot
>> (and Julia Lawall) found an issue in my patch; I forgot a
>> "mutex_lock(&mddev->open_mutex);" in line 6053, which caused the first
>> caveat (hung mdadm and persistent device in /dev). Thanks for pointing
>> this silly mistake from me! in case this patch gets some traction, I'll
>> re-submit with that fixed.
>>
>> Cheers,
>>
>>
>> Guilherme
>>
>> [0] https://marc.info/?l=linux-block&m=155666385707413
>>
>>>
>>> Thanks,
>>> Song
>>>
