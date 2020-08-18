Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE09247BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 03:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHRBUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 21:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgHRBUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:20:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEAC061389;
        Mon, 17 Aug 2020 18:20:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so8982306pgf.0;
        Mon, 17 Aug 2020 18:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a09loNEjTi1ZT8tZvp6nDAVhub8AhuGvplLHCmx8JQM=;
        b=PGZRNmvX8bwMS19NJ4YEf8p/kPVHQb7eEg4UkRVKnS2qGlQqkJdw8BtjhQ2f/hS2MC
         r2k/8QKfSDCdrdQ55i2r/U+T+awti4beG1EuTmMbJccnZAtgZMZAI1VvoT+QvXI2H1qM
         cMT2Oe/ZkXQkwNEu5zEljT7YJ9mXp1TPZN2xlfagEZWlDoDUal75V2rDrvZBzFe6u7qg
         AHDgcEAYGtS+GtcmUJT0DFhSIARWQaGGAZ9g7hcGbHnw7UDgkwHAiI3zr3J1gq9mJVjt
         CV3lRBbxR6XC22tPh+fUi/rbxYTkdwaSgRmZaGyhhYrNgQMcQzq7UjiNd1ikH6MSsmuu
         dJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a09loNEjTi1ZT8tZvp6nDAVhub8AhuGvplLHCmx8JQM=;
        b=hatTx/Hq3yeIxbOGgskzFwCBzEEH0AtdkOnQtmHMzaoYTmzkTc1vRkoOCvhZvQY3jM
         C6YhkQPthpfDHHTVfgrdantAX3GsKGBAorPLjCBzTJOQvzAtCDmpwNgIPGxJUPzXpO4x
         2/EQ/CxaJuwsGOrqRSTGB9KawohJYcFAf47/b4YMF8hI/yQjAiAdZxwVePiEJSFxDE9L
         fcZxAgV5Y6zhNvN009+5HLygU5wSNflSnb+Y0Y/3uleBvGKUdfLNDHJgDkqUskcWFKur
         nhV5emYEfe30MbWSFAJO9cp9Ahr52OzXtKeYAIndQIwqOWdFM+bLDNE6CHYn2wU2KQWm
         BAhw==
X-Gm-Message-State: AOAM530NmfqvwXZf1Gzj2FSW0tinqSzFhlltuEU5/ZRJvjDVFj1MQmpZ
        B3dkCxh9OoNC3STYTwI09ps=
X-Google-Smtp-Source: ABdhPJwtOAnh5plH5Gbpv2Qe1VDmsRPGn1ONSEPjKuJz01C4ukfUmRqqCBf2vWqyBQV8Mf1ha0DmEA==
X-Received: by 2002:aa7:9904:: with SMTP id z4mr13185949pff.32.1597713617238;
        Mon, 17 Aug 2020 18:20:17 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:e903:5f8c:edbb:2451? ([2404:7a87:83e0:f800:e903:5f8c:edbb:2451])
        by smtp.gmail.com with ESMTPSA id d127sm21678503pfc.175.2020.08.17.18.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 18:20:16 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: remove EXFAT_SB_DIRTY flag
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Sungjong Seo' <sj1557.seo@samsung.com>
References: <CGME20200616021816epcas1p2bb235df44c0b6f74cdec2f12072891e3@epcas1p2.samsung.com>
 <20200616021808.5222-1-kohada.t2@gmail.com>
 <414101d64477$ccb661f0$662325d0$@samsung.com>
 <aac9d6c7-1d62-a85d-9bcb-d3c0ddc8fcd6@gmail.com>
 <500801d64572$0bdd2940$23977bc0$@samsung.com>
 <c635e965-6b78-436a-3959-e4777e1732c1@gmail.com>
 <000301d66dac$07b9fc00$172df400$@samsung.com>
 <490837eb-6765-c7be-bb80-b30fe34adb55@gmail.com>
 <001501d67126$b3976df0$1ac649d0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <6a6a85b7-5cff-7bb0-98e5-4d7ece86bb19@gmail.com>
Date:   Tue, 18 Aug 2020 10:20:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <001501d67126$b3976df0$1ac649d0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your reply.

>>> Most of the NAND flash devices and HDDs have wear leveling and bad sector replacement algorithms
>> applied.
>>> So I think that the life of the boot sector will not be exhausted first.
>>
>> I'm not too worried about the life of the boot-sector.
>> I'm worried about write failures caused by external factors.
>> (power failure/system down/vibration/etc. during writing) They rarely occur on SD cards, but occur on
>> many HDDs, some SSDs and USB storages by 0.1% or more.
> Hard disk and SSD do not guarantee atomic write of a sector unit?

In the case of SD, the sector-data will be either new or old when unexpected write interruption occurs.
Almost HDD, the sector-data will be either new, old, or unreadable.
And, some SSD products have similar problem.

>> Especially with AFT-HDD, not only boot-sector but also the following multiple sectors become
>> unreadable.
> Other file systems will also be unstable on a such HW.

A well-designed FileSystems never rewrite critical regions.

>> It is not possible to completely solve this problem, as long as writing to the boot-sector.
>> (I think it's a exFAT's specification defect) The only effective way to reduce this problem is to
>> reduce writes to the boot-sector.
> exFAT's specification defect... Well..
> Even though the boot sector is corrupted, It can be recovered using the backup boot sector
> through fsck.

Exactly.
However, in order to execute fsck, it is necessary to recognize the partition/volume with broken boot-sector as exfat.
Can linux(or fsck) correctly recognize the FileSystem even if the boot-sector cannot be read?
(I don't yet know how linux recognizes FileSystem)
In fact, a certain system recognize it as 'Unknown format'.
Nowadays, exfat is often used for removable storage.
This problem is not only for linux.

BR
---
etsuhiro Kohada <kohada.t2@gmail.com>
