Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042956E7A44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 15:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjDSNFr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 09:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjDSNFp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:05:45 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F0259D5;
        Wed, 19 Apr 2023 06:05:42 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 80B4240927;
        Wed, 19 Apr 2023 09:05:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1681909539;
        bh=PBdvaByQFO7/eGwjYwOju/3gTuH/19py1gOtnj75fJo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=i+2WsxP00NUx+Vg+041BDKHE0UMxTbgobVdKBcnT0C7SZ28Nw9G2M8msObK8B3Wyi
         Q2JjhMeTKvsiU07tI6lZuMO1UaXuAedQ1+FWBcqWHjnVRs0etegnHFq0W7d1b42E6k
         uGwXmAbotzMN+Md4Q/NSe52kUnk0oxBas80k+z/2D2tiqeqziljJThh7Xu7jYSXFQ9
         BP/bQQmHE7rWbMovonPXi1qZjvbZ1Y4cY7O97BpU/DzfOzYlfyUcltTxv6HOZv2Me7
         6ARSGZbhnVFxtLflkm6fVsfWBzz0T8KCBAQbavdyiFpHr4SrjpVK12dmqbBAaQg4Gj
         IqbOJdBrDwYzA==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 19 Apr
 2023 15:05:32 +0200
Content-Type: multipart/mixed;
        boundary="------------PiDQm2ZJ7J9tIkTJ66DMrhJd"
Message-ID: <c05fd3e7-5610-4f63-9012-df1b808d9536@veeam.com>
Date:   Wed, 19 Apr 2023 15:05:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
Content-Language: en-US
To:     Donald Buczek <buczek@molgen.mpg.de>, <axboe@kernel.dk>,
        <hch@infradead.org>, <corbet@lwn.net>, <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
 <20230404140835.25166-4-sergei.shtepa@veeam.com>
 <cb0cc2f1-48cb-8b15-35af-33a31ccc922c@molgen.mpg.de>
 <86068780-bab3-2fc2-3f6f-1868be119b38@veeam.com>
 <a1854604-cec1-abd5-1d49-6cf6a19ee7a1@veeam.com>
 <1dc227d0-9528-9b77-63ff-b49b0579caa1@molgen.mpg.de>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <1dc227d0-9528-9b77-63ff-b49b0579caa1@molgen.mpg.de>
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: atlmbx02.amust.local (172.18.32.172) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A292403155467776B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--------------PiDQm2ZJ7J9tIkTJ66DMrhJd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit



On 4/18/23 16:48, Donald Buczek wrote:
> Subject:
> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
> From:
> Donald Buczek <buczek@molgen.mpg.de>
> Date:
> 4/18/23, 16:48
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
> 
> 
> On 4/18/23 12:31, Sergei Shtepa wrote:
>>
>>
>> On 4/14/23 14:34, Sergei Shtepa wrote:
>>> Subject:
>>> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
>>> From:
>>> Sergei Shtepa <sergei.shtepa@veeam.com>
>>> Date:
>>> 4/14/23, 14:34
>>>
>>> To:
>>> Donald Buczek <buczek@molgen.mpg.de>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>>> CC:
>>> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
>>>
>>>
>>>
>>> On 4/12/23 21:38, Donald Buczek wrote:
>>>> Subject:
>>>> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
>>>> From:
>>>> Donald Buczek <buczek@molgen.mpg.de>
>>>> Date:
>>>> 4/12/23, 21:38
>>>>
>>>> To:
>>>> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>>>> CC:
>>>> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
>>>>
>>>>
>>>> I think, you can trigger all kind of user-after-free when userspace deletes a snapshot image or the snapshot image and the tracker while the disk device snapshot image is kept alive (mounted or just opened) and doing I/O.
>>>>
>>>> Here is what I did to provoke that:
>>>>
>>>> root@dose:~# s=$(blksnap snapshot_create -d /dev/vdb)
>>>> root@dose:~# blksnap snapshot_appendstorage -i $s -f /scratch/local/test.dat
>>>> device path: '/dev/block/253:2'
>>>> allocate range: ofs=11264624 cnt=2097152
>>>> root@dose:~# blksnap snapshot_take -i $s
>>>> root@dose:~# mount /dev/blksnap-image_253\:16 /mnt
>>>> root@dose:~# dd if=/dev/zero of=/mnt/x.x &
>>>> [1] 2514
>>>> root@dose:~# blksnap snapshot_destroy -i $s
>>>> dd: writing to '/mnt/x.x': No space left on device
>>>> 1996041+0 records in
>>>> 1996040+0 records out
>>>> 1021972480 bytes (1.0 GB, 975 MiB) copied, 8.48923 s, 120 MB/s
>>>> [1]+  Exit 1                  dd if=/dev/zero of=/mnt/x.x
>>>>
>>> Thanks!
>>> I am very glad that the blksnap tool turned out to be useful in the review.
>>> This snapshot deletion scenario is not the most typical, but of course it is
>>> quite possible.
>>> I will need to solve this problem and add such a scenario to the test suite.
>>>
>>
>> Hi!
>>
>> I have redesign the logic of ownership of the diff_area structure.
>> See patch in attach or commit.
>> Link: https://github.com/SergeiShtepa/linux/commit/7e927c381dcd2b2293be8315897a224d111b6f88
>> A test script for such a scenario has been added.
>> Link: https://github.com/veeam/blksnap/commit/fd0559dfedf094901d08bbf185fed288f0156433
>>
>> I will be glad of any feedback.
> 
> Great, Thanks!
> 
> However, there are two leftover calls to diff_area_free() with its old prototype:
> 
>  CC [M]  drivers/block/blksnap/diff_area.o
> drivers/block/blksnap/diff_area.c: In function ‘diff_area_new’:
> drivers/block/blksnap/diff_area.c:283:18: error: passing argument 1 of ‘diff_area_free’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>   283 |   diff_area_free(diff_area);
>       |                  ^~~~~~~~~
>       |                  |
>       |                  struct diff_area *
> drivers/block/blksnap/diff_area.c:110:34: note: expected ‘struct kref *’ but argument is of type ‘struct diff_area *’
>   110 | void diff_area_free(struct kref *kref)
>       |                     ~~~~~~~~~~~~~^~~~
> cc1: some warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:252: drivers/block/blksnap/diff_area.o] Error 1
> make[3]: *** [scripts/Makefile.build:494: drivers/block/blksnap] Error 2
> make[2]: *** [scripts/Makefile.build:494: drivers/block] Error 2
> make[1]: *** [scripts/Makefile.build:494: drivers] Error 2
> make: *** [Makefile:2025: .] Error 2
> 
> The other one:
> 
> buczek@dose:/scratch/local/linux (blksnap-test)$ make drivers/block/blksnap/tracker.o
>   CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   CC [M]  drivers/block/blksnap/tracker.o
> drivers/block/blksnap/tracker.c: In function ‘tracker_free’:
> drivers/block/blksnap/tracker.c:26:25: error: passing argument 1 of ‘diff_area_free’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>    26 |   diff_area_free(tracker->diff_area);
>       |                  ~~~~~~~^~~~~~~~~~~
>       |                         |
>       |                         struct diff_area *
> In file included from drivers/block/blksnap/tracker.c:12:
> drivers/block/blksnap/diff_area.h:116:34: note: expected ‘struct kref *’ but argument is of type ‘struct diff_area *’
>   116 | void diff_area_free(struct kref *kref);
>       |                     ~~~~~~~~~~~~~^~~~
> cc1: some warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:252: drivers/block/blksnap/tracker.o] Error 1
> make[3]: *** [scripts/Makefile.build:494: drivers/block/blksnap] Error 2
> make[2]: *** [scripts/Makefile.build:494: drivers/block] Error 2
> make[1]: *** [scripts/Makefile.build:494: drivers] Error 2
> make: *** [Makefile:2025: .] Error 2
> 
> Am I missing something?

Thanks!

It seems to me that I missed something.
The biggest mystery for me is why I was able to build and test the kernel.
I think it's some kind of incremental build effect.
I was only able to see the problem after 'make clean'.

Patches in attach and https://github.com/SergeiShtepa/linux/tree/blksnap-master
--------------PiDQm2ZJ7J9tIkTJ66DMrhJd
Content-Type: text/x-patch; charset="UTF-8";
	name="blksnap_cleanup_comment.patch"
Content-Disposition: attachment; filename="blksnap_cleanup_comment.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svYmxrc25hcC9kaWZmX2FyZWEuaCBiL2RyaXZl
cnMvYmxvY2svYmxrc25hcC9kaWZmX2FyZWEuaAppbmRleCBjYjNlMDk4MDljMGYuLjg4MzEx
N2RiYTc2MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ibG9jay9ibGtzbmFwL2RpZmZfYXJlYS5o
CisrKyBiL2RyaXZlcnMvYmxvY2svYmxrc25hcC9kaWZmX2FyZWEuaApAQCAtMTM4LDYgKzEz
OCw1IEBAIGJvb2wgZGlmZl9hcmVhX2NvdyhzdHJ1Y3QgYmlvICpiaW8sIHN0cnVjdCBkaWZm
X2FyZWEgKmRpZmZfYXJlYSwKIAogYm9vbCBkaWZmX2FyZWFfc3VibWl0X2NodW5rKHN0cnVj
dCBkaWZmX2FyZWEgKmRpZmZfYXJlYSwgc3RydWN0IGJpbyAqYmlvKTsKIHZvaWQgZGlmZl9h
cmVhX3J3X2NodW5rKHN0cnVjdCBrcmVmICprcmVmKTsKLS8vdm9pZCBkaWZmX2FyZWFfdGhy
b3R0bGluZ19pbyhzdHJ1Y3QgZGlmZl9hcmVhICpkaWZmX2FyZWEpOwogCiAjZW5kaWYgLyog
X19CTEtTTkFQX0RJRkZfQVJFQV9IICovCg==
--------------PiDQm2ZJ7J9tIkTJ66DMrhJd
Content-Type: text/x-patch; charset="UTF-8";
	name="blksnap_fix_diff_area_put.patch"
Content-Disposition: attachment; filename="blksnap_fix_diff_area_put.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svYmxrc25hcC9kaWZmX2FyZWEuYyBiL2RyaXZl
cnMvYmxvY2svYmxrc25hcC9kaWZmX2FyZWEuYwppbmRleCA1YTNmNGQ3NGE5MmYuLjBlNTMw
ZDI0ZDU2MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ibG9jay9ibGtzbmFwL2RpZmZfYXJlYS5j
CisrKyBiL2RyaXZlcnMvYmxvY2svYmxrc25hcC9kaWZmX2FyZWEuYwpAQCAtMjgwLDcgKzI4
MCw3IEBAIHN0cnVjdCBkaWZmX2FyZWEgKmRpZmZfYXJlYV9uZXcoZGV2X3QgZGV2X2lkLCBz
dHJ1Y3QgZGlmZl9zdG9yYWdlICpkaWZmX3N0b3JhZ2UpCiAJfQogCiAJaWYgKHJldCkgewot
CQlkaWZmX2FyZWFfZnJlZShkaWZmX2FyZWEpOworCQlkaWZmX2FyZWFfcHV0KGRpZmZfYXJl
YSk7CiAJCXJldHVybiBFUlJfUFRSKHJldCk7CiAJfQogCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Jsb2NrL2Jsa3NuYXAvdHJhY2tlci5jIGIvZHJpdmVycy9ibG9jay9ibGtzbmFwL3RyYWNr
ZXIuYwppbmRleCA2ZDJjNzdlNGM5MGYuLmQ5ODA0OGRjNWJlZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ibG9jay9ibGtzbmFwL3RyYWNrZXIuYworKysgYi9kcml2ZXJzL2Jsb2NrL2Jsa3Nu
YXAvdHJhY2tlci5jCkBAIC0yMyw3ICsyMyw3IEBAIHZvaWQgdHJhY2tlcl9mcmVlKHN0cnVj
dCBrcmVmICprcmVmKQogCQkgTUlOT1IodHJhY2tlci0+ZGV2X2lkKSk7CiAKIAlpZiAodHJh
Y2tlci0+ZGlmZl9hcmVhKQotCQlkaWZmX2FyZWFfZnJlZSh0cmFja2VyLT5kaWZmX2FyZWEp
OworCQlkaWZmX2FyZWFfcHV0KHRyYWNrZXItPmRpZmZfYXJlYSk7CiAJaWYgKHRyYWNrZXIt
PmNidF9tYXApCiAJCWNidF9tYXBfZGVzdHJveSh0cmFja2VyLT5jYnRfbWFwKTsKIAo=

--------------PiDQm2ZJ7J9tIkTJ66DMrhJd--
