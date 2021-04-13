Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16D835E650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 20:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347670AbhDMS0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 14:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhDMS0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:26:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EDEC06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 11:26:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z1so20531556edb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gUmzsxIe9Usd79B4Ol6Ovwj7y0RVrVcb5f5DujLhjr4=;
        b=MVR0RaulAxRTS3KavGFiJnMRa4rOOhLGMpz5Oyx0Spl9UpUeonzmqZCqqUUmm/Vsl1
         1NH7MNR6MpB3mJNmBa+Xj5uO7rqSbqKovC/DqB24g8v7o2FMPgAjSGGg8Oc83fMfiQSo
         CLtjw2fWWPHU0zS7/7TMN0CivdY+ncE0f1V3EIv8hbU/hYbkcjN0PIPLWgJwCTsXjAzx
         oDT6sYIP4BmoUCXP+kyjPwaJ3o1hGpgjsXFga2Z/u18pL4smKnTh/1S4aZrmLszdri25
         2ceicyt/UnGdHZm9KTLaH08dvaBeCXM4S8na0V5cz5fDiYNSa25qve1VajGyhzTn0AKA
         KFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gUmzsxIe9Usd79B4Ol6Ovwj7y0RVrVcb5f5DujLhjr4=;
        b=pTZVv4La3/MjdjK+SjYd+LDUBJYfJQQ64JgfNd/AJCd9LOVccwOkYoqdqBpKgpHPSr
         OngNibhHTBegd/1FiPmdbGUPb3sY7tWlCSdk5JMN0ZD8yZy47lSqz7gwGdTYzqSXpX/i
         4oyMDyOR1OlLwMt1FLkSp2Tqp1u1rRNufq6fMClXN8Nta7Y0CMloPhs1vu9upUtFQpwP
         x/LIUth1D8aX0jVM1Yg7yqf+i4JDu0L+5PdnhqEK5L50QBx3M1V1kxC4ViFTjXZ2C8DM
         mMkHCDwNugP6LkKKvbNo5YqSx1gpD21H3b9pzkWuRS/5Kis61ppKD/nrxDEOtOcw4RxM
         QIrw==
X-Gm-Message-State: AOAM533ciZlKX3bP93HuaX3HS+SjQR1jYgmMMihzGD/bHVvwYJg3kfhU
        RPRohpFDuyOH3myA2t28Sd9RKfd3sdZNk/XcVQY=
X-Google-Smtp-Source: ABdhPJy7SvyslbxUDaNLIDv1BBMpbhsvXcAeoi5qDTCEQdBe4vv+UqkCJh1ZRD5tvlU1eL4u4IyrjA==
X-Received: by 2002:a05:6402:35cd:: with SMTP id z13mr36855014edc.21.1618338359704;
        Tue, 13 Apr 2021 11:25:59 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id g20sm181363edu.91.2021.04.13.11.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 11:25:59 -0700 (PDT)
Date:   Tue, 13 Apr 2021 20:25:58 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Damien Le Moal <damien.lemoal@wdc.com>, kch@kernel.org,
        sagi@grimberg.me, snitzer@redhat.com, selvajove@gmail.com,
        linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, joshi.k@samsung.com, kbusch@kernel.org,
        joshiiitr@gmail.com, hch@lst.de
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210413182558.v2lynge6aleazgbv@mpHalley.localdomain>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
 <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
 <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
 <3a52cc06-27ce-96a4-b180-60fc269719ba@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a52cc06-27ce-96a4-b180-60fc269719ba@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.04.2021 18:38, Max Gurtovoy wrote:
>
>On 4/11/2021 10:26 PM, Javier González wrote:
>>On 11.04.2021 12:10, Max Gurtovoy wrote:
>>>
>>>On 4/10/2021 9:32 AM, Javier González wrote:
>>>>>On 10 Apr 2021, at 02.30, Chaitanya Kulkarni 
>>>>><Chaitanya.Kulkarni@wdc.com> wrote:
>>>>>
>>>>>﻿On 4/9/21 17:22, Max Gurtovoy wrote:
>>>>>>>On 2/19/2021 2:45 PM, SelvaKumar S wrote:
>>>>>>>This patchset tries to add support for TP4065a ("Simple 
>>>>>>>Copy Command"),
>>>>>>>v2020.05.04 ("Ratified")
>>>>>>>
>>>>>>>The Specification can be found in following link.
>>>>>>>https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
>>>>>>>
>>>>>>>
>>>>>>>Simple copy command is a copy offloading operation and is  
>>>>>>>used to copy
>>>>>>>multiple contiguous ranges (source_ranges) of LBA's to a 
>>>>>>>single destination
>>>>>>>LBA within the device reducing traffic between host and device.
>>>>>>>
>>>>>>>This implementation doesn't add native copy offload 
>>>>>>>support for stacked
>>>>>>>devices rather copy offload is done through emulation. Possible use
>>>>>>>cases are F2FS gc and BTRFS relocation/balance.
>>>>>>>
>>>>>>>*blkdev_issue_copy* takes source bdev, no of sources, 
>>>>>>>array of source
>>>>>>>ranges (in sectors), destination bdev and destination 
>>>>>>>offset(in sectors).
>>>>>>>If both source and destination block devices are same and 
>>>>>>>copy_offload = 1,
>>>>>>>then copy is done through native copy offloading. Copy 
>>>>>>>emulation is used
>>>>>>>in other cases.
>>>>>>>
>>>>>>>As SCSI XCOPY can take two different block devices and no 
>>>>>>>of source range is
>>>>>>>equal to 1, this interface can be extended in future to 
>>>>>>>support SCSI XCOPY.
>>>>>>Any idea why this TP wasn't designed for copy offload between 2
>>>>>>different namespaces in the same controller ?
>>>>>Yes, it was the first attempt so to keep it simple.
>>>>>
>>>>>Further work is needed to add incremental TP so that we can 
>>>>>also do a copy
>>>>>between the name-spaces of same controller (if we can't 
>>>>>already) and to the
>>>>>namespaces that belongs to the different controller.
>>>>>
>>>>>>And a simple copy will be the case where the src_nsid == dst_nsid ?
>>>>>>
>>>>>>Also why there are multiple source ranges and only one dst range ? We
>>>>>>could add a bit to indicate if this range is src or dst..
>>>>One of the target use cases was ZNS in order to avoid fabric 
>>>>transfers during host GC. You can see how this plays well with 
>>>>several zone ranges and a single zone destination.
>>>>
>>>>If we start getting support in Linux through the different past 
>>>>copy offload efforts, I’m sure we can extend this TP in the 
>>>>future.
>>>
>>>But the "copy" command IMO is more general than the ZNS GC case, 
>>>that can be a private case of copy, isn't it ?
>>
>>It applies to any namespace type, so yes. I just wanted to give you the
>>background for the current "simple" scope through one of the use cases
>>that was in mind.
>>
>>>We can get a big benefit of offloading the data copy from one ns 
>>>to another in the same controller and even in different 
>>>controllers in the same subsystem.
>>
>>Definitely.
>>
>>>
>>>Do you think the extension should be to "copy" command or to 
>>>create a new command "x_copy" for copying to different destination 
>>>ns ?
>>
>>I believe there is space for extensions to simple copy. But given the
>>experience with XCOPY, I can imagine that changes will be incremental,
>>based on very specific use cases.
>>
>>I think getting support upstream and bringing deployed cases is a very
>>good start.
>
>Copying data (files) within the controller/subsystem from ns_A to ns_B 
>using NVMf will reduce network BW and memory BW in the host server.
>
>This feature is well known and the use case is well known.

Definitely.

>
>The question whether we implement it in vendor specific manner of we 
>add it to the specification.
>
>I prefer adding it to the spec :)

Agree. Let's build up on top of Simple Copy. We can talk about it
offline in the context of the NVMe TWG.
