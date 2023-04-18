Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097296E676C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjDROsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDROsK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:48:10 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE259E8;
        Tue, 18 Apr 2023 07:48:07 -0700 (PDT)
Received: from [192.168.2.142] (p4fdf4348.dip0.t-ipconnect.de [79.223.67.72])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5C2E661E4052B;
        Tue, 18 Apr 2023 16:48:04 +0200 (CEST)
Message-ID: <1dc227d0-9528-9b77-63ff-b49b0579caa1@molgen.mpg.de>
Date:   Tue, 18 Apr 2023 16:48:00 +0200
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
From:   Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <a1854604-cec1-abd5-1d49-6cf6a19ee7a1@veeam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/23 12:31, Sergei Shtepa wrote:
> 
> 
> On 4/14/23 14:34, Sergei Shtepa wrote:
>> Subject:
>> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
>> From:
>> Sergei Shtepa <sergei.shtepa@veeam.com>
>> Date:
>> 4/14/23, 14:34
>>
>> To:
>> Donald Buczek <buczek@molgen.mpg.de>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>> CC:
>> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
>>
>>
>>
>> On 4/12/23 21:38, Donald Buczek wrote:
>>> Subject:
>>> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
>>> From:
>>> Donald Buczek <buczek@molgen.mpg.de>
>>> Date:
>>> 4/12/23, 21:38
>>>
>>> To:
>>> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>>> CC:
>>> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
>>>
>>>
>>> I think, you can trigger all kind of user-after-free when userspace deletes a snapshot image or the snapshot image and the tracker while the disk device snapshot image is kept alive (mounted or just opened) and doing I/O.
>>>
>>> Here is what I did to provoke that:
>>>
>>> root@dose:~# s=$(blksnap snapshot_create -d /dev/vdb)
>>> root@dose:~# blksnap snapshot_appendstorage -i $s -f /scratch/local/test.dat
>>> device path: '/dev/block/253:2'
>>> allocate range: ofs=11264624 cnt=2097152
>>> root@dose:~# blksnap snapshot_take -i $s
>>> root@dose:~# mount /dev/blksnap-image_253\:16 /mnt
>>> root@dose:~# dd if=/dev/zero of=/mnt/x.x &
>>> [1] 2514
>>> root@dose:~# blksnap snapshot_destroy -i $s
>>> dd: writing to '/mnt/x.x': No space left on device
>>> 1996041+0 records in
>>> 1996040+0 records out
>>> 1021972480 bytes (1.0 GB, 975 MiB) copied, 8.48923 s, 120 MB/s
>>> [1]+  Exit 1                  dd if=/dev/zero of=/mnt/x.x
>>>
>> Thanks!
>> I am very glad that the blksnap tool turned out to be useful in the review.
>> This snapshot deletion scenario is not the most typical, but of course it is
>> quite possible.
>> I will need to solve this problem and add such a scenario to the test suite.
>>
> 
> Hi!
> 
> I have redesign the logic of ownership of the diff_area structure.
> See patch in attach or commit.
> Link: https://github.com/SergeiShtepa/linux/commit/7e927c381dcd2b2293be8315897a224d111b6f88
> A test script for such a scenario has been added.
> Link: https://github.com/veeam/blksnap/commit/fd0559dfedf094901d08bbf185fed288f0156433
> 
> I will be glad of any feedback.

Great, Thanks!

However, there are two leftover calls to diff_area_free() with its old prototype:

  CC [M]  drivers/block/blksnap/diff_area.o
drivers/block/blksnap/diff_area.c: In function ‘diff_area_new’:
drivers/block/blksnap/diff_area.c:283:18: error: passing argument 1 of ‘diff_area_free’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   283 |   diff_area_free(diff_area);
       |                  ^~~~~~~~~
       |                  |
       |                  struct diff_area *
drivers/block/blksnap/diff_area.c:110:34: note: expected ‘struct kref *’ but argument is of type ‘struct diff_area *’
   110 | void diff_area_free(struct kref *kref)
       |                     ~~~~~~~~~~~~~^~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:252: drivers/block/blksnap/diff_area.o] Error 1
make[3]: *** [scripts/Makefile.build:494: drivers/block/blksnap] Error 2
make[2]: *** [scripts/Makefile.build:494: drivers/block] Error 2
make[1]: *** [scripts/Makefile.build:494: drivers] Error 2
make: *** [Makefile:2025: .] Error 2

The other one:

buczek@dose:/scratch/local/linux (blksnap-test)$ make drivers/block/blksnap/tracker.o
   CALL    scripts/checksyscalls.sh
   DESCEND objtool
   INSTALL libsubcmd_headers
   CC [M]  drivers/block/blksnap/tracker.o
drivers/block/blksnap/tracker.c: In function ‘tracker_free’:
drivers/block/blksnap/tracker.c:26:25: error: passing argument 1 of ‘diff_area_free’ from incompatible pointer type [-Werror=incompatible-pointer-types]
    26 |   diff_area_free(tracker->diff_area);
       |                  ~~~~~~~^~~~~~~~~~~
       |                         |
       |                         struct diff_area *
In file included from drivers/block/blksnap/tracker.c:12:
drivers/block/blksnap/diff_area.h:116:34: note: expected ‘struct kref *’ but argument is of type ‘struct diff_area *’
   116 | void diff_area_free(struct kref *kref);
       |                     ~~~~~~~~~~~~~^~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:252: drivers/block/blksnap/tracker.o] Error 1
make[3]: *** [scripts/Makefile.build:494: drivers/block/blksnap] Error 2
make[2]: *** [scripts/Makefile.build:494: drivers/block] Error 2
make[1]: *** [scripts/Makefile.build:494: drivers] Error 2
make: *** [Makefile:2025: .] Error 2

Am I missing something?

Best
   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
