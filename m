Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD623A31FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 19:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFJR1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhFJR1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:27:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B0C061574;
        Thu, 10 Jun 2021 10:25:44 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id u30so28123882qke.7;
        Thu, 10 Jun 2021 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4CbH0oxqWjWybjwnc7vATc9qIBqCZvVekuNecAP/vew=;
        b=MMC3bPr+SEYnKoWDRnrnWAPVc9j3G1+TGfdLktOvSdfh79M9ynmHYiiQyu+9E3tSki
         2IQ9xigRrIUjKFMp+T7ORXimNtN/CAkn+AtoUCSsBGmJtXU2M2+Bzrm4aEdGf89SIuvi
         llZsoe22QBaNMolPCe8WGD5zw0qzFf2GBejPxw5xYuXIcat+NMC3ADqmXLByw2RJs72+
         6wpC3FPFe/nZVDjcK/st+PoOyAG/BC6Fv/dLdr1wgJzKYZpPGkV9Z9e1xMMHGoDS3NaH
         Tt7kEDLw7N7psspxptlB7HoJyf3ofIWn5Ah9qHbV+Ah0vfCHn26uONM3bAdh18fVS1SS
         axCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4CbH0oxqWjWybjwnc7vATc9qIBqCZvVekuNecAP/vew=;
        b=lUkQsjz+iTS9mHMRNL4+pc7shE3KJnvmlRAzpxpPNtwRIJmHH7j8W71W2c7Y/IkfJ0
         Fpzf6XGG+WWX2YbudhZp7Iogx2ngDDUPxxC6pe4ooWzEq/lBdTi5AQJTZ54jkUwFel+6
         6rf0uRlTomXyiLpHhm/aLMdRHKmzJMFcb/gb21Hgd7KBmVEPZ4VLgc5uAhOJBE7WWAHt
         yb+3kJKHwhJs2ZfOo0EeLITAZJefHtNSYiTP+m74vFf9cgxowhGoonYfCBqrfRIDDT3H
         hOYOyswdDohHe9EWahD4Jyb+AF2/6aLiTOVsn4vErw9O6YjWkqndOz6wN8AIKt80hq3V
         jgVw==
X-Gm-Message-State: AOAM533cji1UaBEa4VL2UNNPypshmhdEGMzZSzrdtn6vqt7KLupcOAaj
        /Od8DgvM0WVMP0CHfscPEV0DYod8x1wmapa0
X-Google-Smtp-Source: ABdhPJyR9uB8qh+MPr+c6X0rAhfgf25q3yo9yVVaHLu3A7hi4PbOnPLbS2MXt45uL4Webz+HuIj0SQ==
X-Received: by 2002:a05:620a:1662:: with SMTP id d2mr573258qko.289.1623345940302;
        Thu, 10 Jun 2021 10:25:40 -0700 (PDT)
Received: from localhost.localdomain (pool-173-48-195-35.bstnma.fios.verizon.net. [173.48.195.35])
        by smtp.gmail.com with ESMTPSA id v25sm2581889qtf.68.2021.06.10.10.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 10:25:39 -0700 (PDT)
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jaegeuk Kim <jaegeuk.kim@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
 <CAOtxgyeRf=+grEoHxVLEaSM=Yfx4KrSG5q96SmztpoWfP=QrDg@mail.gmail.com>
 <eafad7a6-4784-dd9c-cc1d-36e463370aeb@gmail.com>
 <YMJGqkwL87KczMS+@casper.infradead.org>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <97ecb393-db84-c71d-6162-d8309400b0ee@gmail.com>
Date:   Thu, 10 Jun 2021 13:25:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMJGqkwL87KczMS+@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/21 1:06 PM, Matthew Wilcox wrote:
> On Thu, Jun 10, 2021 at 12:22:40PM -0400, Ric Wheeler wrote:
>> On 6/9/21 5:32 PM, Jaegeuk Kim wrote:
>>> On Wed, Jun 9, 2021 at 11:47 AM Bart Van Assche <bvanassche@acm.org
>>> <mailto:bvanassche@acm.org>> wrote:
>>>
>>>      On 6/9/21 11:30 AM, Matthew Wilcox wrote:
>>>      > maybe you should read the paper.
>>>      >
>>>      > " Thiscomparison demonstrates that using F2FS, a flash-friendly file
>>>      > sys-tem, does not mitigate the wear-out problem, except inasmuch asit
>>>      > inadvertently rate limitsallI/O to the device"
>>>
>>>
>>> Do you agree with that statement based on your insight? At least to me, that
>>> paper is missing the fundamental GC problem which was supposed to be
>>> evaluated by real workloads instead of using a simple benchmark generating
>>> 4KB random writes only. And, they had to investigate more details in FTL/IO
>>> patterns including UNMAP and LBA alignment between host and storage, which
>>> all affect WAF. Based on that, the point of the zoned device is quite promising
>>> to me, since it can address LBA alignment entirely and give a way that host
>>> SW stack can control QoS.
>> Just a note, using a pretty simple and optimal streaming write pattern, I
>> have been able to burn out emmc parts in a little over a week.
>>
>> My test case creating a 1GB file (filled with random data just in case the
>> device was looking for zero blocks to ignore) and then do a loop to cp and
>> sync that file until the emmc device life time was shown as exhausted.
>>
>> This was a clean, best case sequential write so this is not just an issue
>> with small, random writes.
> How many LBAs were you using?  My mental model of a FTL (which may
> be out of date) is that it's essentially a log-structured filesystem.
> When there are insufficient empty erase-blocks available, the device
> finds a suitable victim erase-block, copies all the still-live LBAs into
> an active erase-block, updates the FTL and erases the erase-block.
>
> So the key is making sure that LBAs are reused as much as possible.
> Short of modifying a filesystem to make this happen, I force it by
> short-stroking my SSD.  We can model it statistically, but intuitively,
> if there are more "live" LBAs, the higher the write amplification and
> wear on the drive will be because the victim erase-blocks will have
> more live LBAs to migrate.
>
> This is why the paper intrigued me; it seemed like they were rewriting
> a 100MB file in place.  That _shouldn't_ cause ridiculous wear, unless
> the emmc device was otherwise almost full.

During the test run, I did not look at which LBA's that got written to over the 
couple of weeks.

Roughly, I tried to make sure that the file system ranged in fullness from 50% 
to 75% (did not let it get too close to full).

Any vendor (especially on the low end parts) might do something really 
primitive, but the hope I would have is similar to what you describe - if there 
is sufficient free space, the firmware should be able to wear level across all 
of the cells in the device. Overwriting in place or writing (and then 
freeing/discarded) each LBA *should* be roughly equivalent. Free space being 
defined as LBA's that are not known to the device as those without valid, 
un-discarded data.

Also important to write enough to flush through any possible DRAM/SRAM like 
cache a device might have that could absorb tiny writes.

The parts I played with ranged from what seemed to be roughly 3x write 
amplification for the workload I ran down to more like 1.3x write amplification 
(measured super coarsely as app level IO dispatched so all metadata, etc counted 
as "WA" in my coarse look). Just trying to figure out for a given IO/fs stack, 
how specific devices handle the user workload.

Regards,

Ric


