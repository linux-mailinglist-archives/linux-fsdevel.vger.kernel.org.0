Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229C66E9C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 21:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjDTTSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 15:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDTTSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:18:22 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280622717;
        Thu, 20 Apr 2023 12:18:20 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id D6D3D5EC2C;
        Thu, 20 Apr 2023 22:18:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1682018298;
        bh=vsr/Ac17+CKt1Rl6NRF3sVIwqaOJqgYSiqwTXnsdphI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=KHMUcCZPq5iG48/N9iQw1JOODCqqqu8sWQJ1VwWH1mTWSXRYUsDz+iHmQVY/7kWeK
         eiQTGcC9rk0wHByjmQmgVXZVVUnlwlBrPQFJZKoqq9/+GILi3lHpd0GC1DsoGyWFpP
         IXDgZOwan8Q+1tpTpV7T7TQ4/XbphuEjpSrLicR7aNPRxd527/CSG3vyv36DdPd5mp
         kpR9sk2z/w7FGSAQ/hJu31/0NgGytQQlAPnvJ8sSaondl7jOoq4pdtzYTvOJTkdqP2
         O3a7hPVC2jGtSHoDqF43RPokohbcgzAf+Mvy0OA8te7XNcxbIxqIvxl/R6pQ2jhn+g
         DJNaW4XLo8Vnw==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 20 Apr
 2023 21:18:10 +0200
Content-Type: multipart/mixed;
        boundary="------------HHEWogh5LchE01j4khkGxhzV"
Message-ID: <b6516901-b7ba-cde9-644c-84dfdef012ad@veeam.com>
Date:   Thu, 20 Apr 2023 21:17:58 +0200
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
 <c05fd3e7-5610-4f63-9012-df1b808d9536@veeam.com>
 <955ede49-bb69-2ab2-d256-a329fe1b728c@molgen.mpg.de>
 <3b589d44-3fbd-1f4f-8efb-9b334c26a20f@molgen.mpg.de>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <3b589d44-3fbd-1f4f-8efb-9b334c26a20f@molgen.mpg.de>
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: atlmbx02.amust.local (172.18.32.172) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554677167
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--------------HHEWogh5LchE01j4khkGxhzV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit



On 4/20/23 16:44, Donald Buczek wrote:
> Subject:
> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
> From:
> Donald Buczek <buczek@molgen.mpg.de>
> Date:
> 4/20/23, 16:44
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
> 
> 
> On 4/19/23 21:42, Donald Buczek wrote:
>> Dear Sergei,
>>
>> On 4/19/23 15:05, Sergei Shtepa wrote:
>>> [...]
>>>
>>> Patches in attach and https://nam10.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FSergeiShtepa%2Flinux%2Ftree%2Fblksnap-master&data=05%7C01%7Csergei.shtepa%40veeam.com%7Cccc78e2cdf7845c6c0cd08db41add281%7Cba07baab431b49edadd7cbc3542f5140%7C1%7C0%7C638175987085694967%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=RdrWqUwvk7gjfSRYvrPfz2E0%2BIOY6IQxK4xvpzJqcnk%3D&reserved=0
>>
>> Thanks. I can confirm that this fixes the reported problem and I no longer can trigger the UAF. 😄
>>
>> Tested-Bny: Donald Buczek <buczek@molgen.mpg.de>
>>
>> Maybe you can add me to the cc list for v4 as I'm not subscribed to the lists.
> 
> 
> Sorry, found another one. Reproducer:
> 
> =====
> #! /bin/bash
> set -xe
> modprobe blksnap
> test -e /scratch/local/test.dat || fallocate -l 1G /scratch/local/test.dat
> s=$(blksnap snapshot_create -d /dev/vdb)
> blksnap snapshot_appendstorage -i $s -f /scratch/local/test.dat
> blksnap snapshot_take -i $s
> s2=$(blksnap snapshot_create -d /dev/vdb)
> blksnap snapshot_destroy -i $s2
> blksnap snapshot_destroy -i $s
> =====
> 
> 
> [20382.402921] blksnap-snapshot: Snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa was created
> [20382.535933] blksnap-image: Create snapshot image device for original device [253:16]
> [20382.542405] blksnap-snapshot: Snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa was taken successfully
> [20382.572564] blksnap-snapshot: Snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966 was created
> [20382.600521] blksnap-snapshot: Destroy snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966
> [20382.602373] blksnap-snapshot: Release snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966
> [20382.722137] blksnap-snapshot: Destroy snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa
> [20382.724033] blksnap-snapshot: Release snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa
> [20382.725850] ==================================================================
> [20382.727641] BUG: KASAN: wild-memory-access in snapshot_free+0x73/0x170 [blksnap]
> [20382.729326] Write of size 8 at addr dead000000000108 by task blksnap/8297
> ...

Great! Thanks.

There is no protection against re-adding a block device to the snapshot.
I'll take care of it.

And small update. I have made a correction to the bio allocation algorithm
for saving and loading chunks. Please, see attach and commit.
Link: https://github.com/SergeiShtepa/linux/commit/2628dd193fd3d563d26d5ccc82d35b2e11bbda38
But cases of large chunks or very large disks have not yet been covered
by tests, yet. 

I also had concerns that the snapshot writing algorithm was not working
correctly. But the concerns were in vain. The new test is working.
Link: https://github.com/veeam/blksnap/blob/stable-v2.0/tests/6000-snapimage_write.sh

--------------HHEWogh5LchE01j4khkGxhzV
Content-Type: text/x-patch; charset="UTF-8";
	name="fix_page_inx_increment.patch"
Content-Disposition: attachment; filename="fix_page_inx_increment.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svYmxrc25hcC9jaHVuay5jIGIvZHJpdmVycy9i
bG9jay9ibGtzbmFwL2NodW5rLmMKaW5kZXggNzMxMTNjNzE0YWMxLi4wNmZkZDZjOTBlMGEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmxvY2svYmxrc25hcC9jaHVuay5jCisrKyBiL2RyaXZl
cnMvYmxvY2svYmxrc25hcC9jaHVuay5jCkBAIC0yODMsMjUgKzI4MywyNiBAQCB2b2lkIGNo
dW5rX3N0b3JlKHN0cnVjdCBjaHVuayAqY2h1bmspCiAJYmlvX3NldF9mbGFnKGJpbywgQklP
X0ZJTFRFUkVEKTsKIAogCXdoaWxlIChjb3VudCkgeworCQlzdHJ1Y3QgYmlvICpuZXh0Owog
CQlzZWN0b3JfdCBwb3J0aW9uID0gbWluX3Qoc2VjdG9yX3QsIGNvdW50LCBQQUdFX1NFQ1RP
UlMpOwogCQl1bnNpZ25lZCBpbnQgYnl0ZXMgPSBwb3J0aW9uIDw8IFNFQ1RPUl9TSElGVDsK
IAogCQlpZiAoYmlvX2FkZF9wYWdlKGJpbywgY2h1bmstPmRpZmZfYnVmZmVyLT5wYWdlc1tw
YWdlX2lkeF0sCi0JCQkJIGJ5dGVzLCAwKSAhPSBieXRlcykgewotCQkJc3RydWN0IGJpbyAq
bmV4dDsKKwkJCQkgYnl0ZXMsIDApID09IGJ5dGVzKSB7CisJCQlwYWdlX2lkeCsrOworCQkJ
Y291bnQgLT0gcG9ydGlvbjsKKwkJCWNvbnRpbnVlOworCQl9CiAKLQkJCW5leHQgPSBiaW9f
YWxsb2NfYmlvc2V0KGJkZXYsCi0JCQkJCWNhbGNfbWF4X3ZlY3MoY291bnQpLAorCQkvKiBD
cmVhdGUgbmV4dCBiaW8gKi8KKwkJbmV4dCA9IGJpb19hbGxvY19iaW9zZXQoYmRldiwgY2Fs
Y19tYXhfdmVjcyhjb3VudCksCiAJCQkJCVJFUV9PUF9XUklURSB8IFJFUV9TWU5DIHwgUkVR
X0ZVQSwKIAkJCQkJR0ZQX05PSU8sICZjaHVua19pb19iaW9zZXQpOwotCQkJbmV4dC0+Ymlf
aXRlci5iaV9zZWN0b3IgPSBiaW9fZW5kX3NlY3RvcihiaW8pOwotCQkJYmlvX3NldF9mbGFn
KG5leHQsIEJJT19GSUxURVJFRCk7Ci0JCQliaW9fY2hhaW4oYmlvLCBuZXh0KTsKLQkJCXN1
Ym1pdF9iaW9fbm9hY2N0KGJpbyk7Ci0JCQliaW8gPSBuZXh0OwotCQl9Ci0JCXBhZ2VfaWR4
Kys7Ci0JCWNvdW50IC09IHBvcnRpb247CisJCW5leHQtPmJpX2l0ZXIuYmlfc2VjdG9yID0g
YmlvX2VuZF9zZWN0b3IoYmlvKTsKKwkJYmlvX3NldF9mbGFnKG5leHQsIEJJT19GSUxURVJF
RCk7CisJCWJpb19jaGFpbihiaW8sIG5leHQpOworCQlzdWJtaXRfYmlvX25vYWNjdChiaW8p
OworCQliaW8gPSBuZXh0OwogCX0KIAogCWNiaW8gPSBjb250YWluZXJfb2YoYmlvLCBzdHJ1
Y3QgY2h1bmtfYmlvLCBiaW8pOwpAQCAtMzQyLDI0ICszNDMsMjYgQEAgc3RhdGljIHN0cnVj
dCBiaW8gKl9fY2h1bmtfbG9hZChzdHJ1Y3QgY2h1bmsgKmNodW5rKQogCWJpb19zZXRfZmxh
ZyhiaW8sIEJJT19GSUxURVJFRCk7CiAKIAl3aGlsZSAoY291bnQpIHsKKwkJc3RydWN0IGJp
byAqbmV4dDsKIAkJc2VjdG9yX3QgcG9ydGlvbiA9IG1pbl90KHNlY3Rvcl90LCBjb3VudCwg
UEFHRV9TRUNUT1JTKTsKIAkJdW5zaWduZWQgaW50IGJ5dGVzID0gcG9ydGlvbiA8PCBTRUNU
T1JfU0hJRlQ7CiAKIAkJaWYgKGJpb19hZGRfcGFnZShiaW8sIGNodW5rLT5kaWZmX2J1ZmZl
ci0+cGFnZXNbcGFnZV9pZHhdLAotCQkJCSBieXRlcywgMCkgIT0gYnl0ZXMpIHsKLQkJCXN0
cnVjdCBiaW8gKm5leHQ7Ci0KLQkJCW5leHQgPSBiaW9fYWxsb2NfYmlvc2V0KGJkZXYsIGNh
bGNfbWF4X3ZlY3MoY291bnQpLAotCQkJCQkJUkVRX09QX1JFQUQsIEdGUF9OT0lPLAotCQkJ
CQkJJmNodW5rX2lvX2Jpb3NldCk7Ci0JCQluZXh0LT5iaV9pdGVyLmJpX3NlY3RvciA9IGJp
b19lbmRfc2VjdG9yKGJpbyk7Ci0JCQliaW9fc2V0X2ZsYWcobmV4dCwgQklPX0ZJTFRFUkVE
KTsKLQkJCWJpb19jaGFpbihiaW8sIG5leHQpOwotCQkJc3VibWl0X2Jpb19ub2FjY3QoYmlv
KTsKLQkJCWJpbyA9IG5leHQ7CisJCQkJIGJ5dGVzLCAwKSA9PSBieXRlcykgeworCQkJcGFn
ZV9pZHgrKzsKKwkJCWNvdW50IC09IHBvcnRpb247CisJCQljb250aW51ZTsKIAkJfQotCQlw
YWdlX2lkeCsrOwotCQljb3VudCAtPSBwb3J0aW9uOworCisJCS8qIENyZWF0ZSBuZXh0IGJp
byAqLworCQluZXh0ID0gYmlvX2FsbG9jX2Jpb3NldChiZGV2LCBjYWxjX21heF92ZWNzKGNv
dW50KSwKKwkJCQkJUkVRX09QX1JFQUQsIEdGUF9OT0lPLAorCQkJCQkmY2h1bmtfaW9fYmlv
c2V0KTsKKwkJbmV4dC0+YmlfaXRlci5iaV9zZWN0b3IgPSBiaW9fZW5kX3NlY3RvcihiaW8p
OworCQliaW9fc2V0X2ZsYWcobmV4dCwgQklPX0ZJTFRFUkVEKTsKKwkJYmlvX2NoYWluKGJp
bywgbmV4dCk7CisJCXN1Ym1pdF9iaW9fbm9hY2N0KGJpbyk7CisJCWJpbyA9IG5leHQ7CiAJ
fQogCXJldHVybiBiaW87CiB9Cg==

--------------HHEWogh5LchE01j4khkGxhzV--
