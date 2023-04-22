Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D2C6EBB15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Apr 2023 22:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDVUBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Apr 2023 16:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDVUBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:01:34 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A031FE3;
        Sat, 22 Apr 2023 13:01:32 -0700 (PDT)
Received: from [192.168.1.190] (ip5b42332c.dynamic.kabel-deutschland.de [91.66.51.44])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 83D7461E4052B;
        Sat, 22 Apr 2023 22:01:29 +0200 (CEST)
Message-ID: <3972fe6d-34f4-3a9b-b939-494fd19f1bfb@molgen.mpg.de>
Date:   Sat, 22 Apr 2023 22:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org,
        ming.lei@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-4-sergei.shtepa@veeam.com>
 <cb0cc2f1-48cb-8b15-35af-33a31ccc922c@molgen.mpg.de>
 <86068780-bab3-2fc2-3f6f-1868be119b38@veeam.com>
 <a1854604-cec1-abd5-1d49-6cf6a19ee7a1@veeam.com>
 <1dc227d0-9528-9b77-63ff-b49b0579caa1@molgen.mpg.de>
 <c05fd3e7-5610-4f63-9012-df1b808d9536@veeam.com>
 <955ede49-bb69-2ab2-d256-a329fe1b728c@molgen.mpg.de>
 <3b589d44-3fbd-1f4f-8efb-9b334c26a20f@molgen.mpg.de>
 <b6516901-b7ba-cde9-644c-84dfdef012ad@veeam.com>
 <a670606b-ad27-ff7c-f74c-e36269f2ddfc@veeam.com>
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <a670606b-ad27-ff7c-f74c-e36269f2ddfc@veeam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/21/23 19:32, Sergei Shtepa wrote:
> 
> 
> On 4/20/23 21:17, Sergei Shtepa wrote:
>> Subject:
>> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
>> From:
>> Sergei Shtepa <sergei.shtepa@veeam.com>
>> Date:
>> 4/20/23, 21:17
>>
>> To:
>> Donald Buczek <buczek@molgen.mpg.de>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>> CC:
>> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
>>
>>
>>
>> On 4/20/23 16:44, Donald Buczek wrote:
>>> Subject:
>>> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
>>> From:
>>> Donald Buczek <buczek@molgen.mpg.de>
>>> Date:
>>> 4/20/23, 16:44
>>>
>>> To:
>>> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>>> CC:
>>> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
>>>
>>>
>>> On 4/19/23 21:42, Donald Buczek wrote:
>>>> Dear Sergei,
>>>>
>>>> On 4/19/23 15:05, Sergei Shtepa wrote:
>>>>> [...]
>>>>>
>>>>> Patches in attach and https://github.com/SergeiShtepa/linux/tree/blksnap-master
>>>> Thanks. I can confirm that this fixes the reported problem and I no longer can trigger the UAF. 😄
>>>>
>>>> Tested-Bny: Donald Buczek <buczek@molgen.mpg.de>
>>>>
>>>> Maybe you can add me to the cc list for v4 as I'm not subscribed to the lists.
>>>
>>> Sorry, found another one. Reproducer:
>>>
>>> =====
>>> #! /bin/bash
>>> set -xe
>>> modprobe blksnap
>>> test -e /scratch/local/test.dat || fallocate -l 1G /scratch/local/test.dat
>>> s=$(blksnap snapshot_create -d /dev/vdb)
>>> blksnap snapshot_appendstorage -i $s -f /scratch/local/test.dat
>>> blksnap snapshot_take -i $s
>>> s2=$(blksnap snapshot_create -d /dev/vdb)
>>> blksnap snapshot_destroy -i $s2
>>> blksnap snapshot_destroy -i $s
>>> =====
>>>
>>>
>>> [20382.402921] blksnap-snapshot: Snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa was created
>>> [20382.535933] blksnap-image: Create snapshot image device for original device [253:16]
>>> [20382.542405] blksnap-snapshot: Snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa was taken successfully
>>> [20382.572564] blksnap-snapshot: Snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966 was created
>>> [20382.600521] blksnap-snapshot: Destroy snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966
>>> [20382.602373] blksnap-snapshot: Release snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966
>>> [20382.722137] blksnap-snapshot: Destroy snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa
>>> [20382.724033] blksnap-snapshot: Release snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa
>>> [20382.725850] ==================================================================
>>> [20382.727641] BUG: KASAN: wild-memory-access in snapshot_free+0x73/0x170 [blksnap]
>>> [20382.729326] Write of size 8 at addr dead000000000108 by task blksnap/8297
>>> ...
>> Great! Thanks.
>>
>> There is no protection against re-adding a block device to the snapshot.
>> I'll take care of it.
>>
> 
> Hi!
> 
> I think the fix turned out to be quite beautiful.
> Now you will get an error "Device or resource busy".
> Fix in attach and on github.
> Link: https://github.com/SergeiShtepa/linux/commit/43a5d3dd9858f092b734187b6a62ce75acaa47c7

I can confirm, that this fixes the problem.

     root@dose:~# blksnap snapshot_create -d /dev/vda -d /dev/vda
     fdcd3ee3-a25f-4c2a-93d7-2d951520e938
     Operation already in progress
     root@dose:~# echo $?
     1


Tested-By: Donald Buczek <buczek@molgen.mpg.de>

Best
   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
