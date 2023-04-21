Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A73B6EB097
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjDURcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 13:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDURcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:32:45 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC115251;
        Fri, 21 Apr 2023 10:32:44 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id B47E542C5F;
        Fri, 21 Apr 2023 13:32:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1682098357;
        bh=M+1V4ydzTe0AfjmGTaWFeBSLPi8tCtQ5EdkpUA6ZDHI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To:From;
        b=Z14/coI3vCO/aP0mheruNc2s9l/iUzmZ0sf6rQroEwlU4nFqg/FKHBCrxfZHZYe15
         sJ73rQepbpWlN6CzLRSjU5JGQFZKqGMOlHISnr4ojcKQ0dTBTPvdU3LErBLSbMmfmf
         gd5FibSx5C5L8n/tBNHRT7i+eTnWnBhVZY7VfHuFyy/5TWfe6mC3BoosHl1UcYysIU
         a9ww1tmSih3v3+0lv2FNcpEUCMrxLSFsbVfI87bTP5rEbMcRT31VPzdarELtsvF8gz
         llghCvIPaUymOyzFGYOKh2rque0nM6YYjPIKkbkF8fjGU4eYzbsXoQWXnGBoecu1To
         QoNPnEcYtvvaA==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 21 Apr
 2023 19:32:34 +0200
Content-Type: multipart/mixed;
        boundary="------------Uz7N2hSro1BXgYQbTl7hDQWx"
Message-ID: <a670606b-ad27-ff7c-f74c-e36269f2ddfc@veeam.com>
Date:   Fri, 21 Apr 2023 19:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
Content-Language: en-US
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
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
 <b6516901-b7ba-cde9-644c-84dfdef012ad@veeam.com>
In-Reply-To: <b6516901-b7ba-cde9-644c-84dfdef012ad@veeam.com>
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554677065
X-Veeam-MMEX: True
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--------------Uz7N2hSro1BXgYQbTl7hDQWx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit



On 4/20/23 21:17, Sergei Shtepa wrote:
> Subject:
> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
> From:
> Sergei Shtepa <sergei.shtepa@veeam.com>
> Date:
> 4/20/23, 21:17
> 
> To:
> Donald Buczek <buczek@molgen.mpg.de>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
> 
> 
> 
> On 4/20/23 16:44, Donald Buczek wrote:
>> Subject:
>> Re: [PATCH v3 03/11] documentation: Block Devices Snapshots Module
>> From:
>> Donald Buczek <buczek@molgen.mpg.de>
>> Date:
>> 4/20/23, 16:44
>>
>> To:
>> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
>> CC:
>> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, kch@nvidia.com, martin.petersen@oracle.com, vkoul@kernel.org, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
>>
>>
>> On 4/19/23 21:42, Donald Buczek wrote:
>>> Dear Sergei,
>>>
>>> On 4/19/23 15:05, Sergei Shtepa wrote:
>>>> [...]
>>>>
>>>> Patches in attach and https://github.com/SergeiShtepa/linux/tree/blksnap-master
>>> Thanks. I can confirm that this fixes the reported problem and I no longer can trigger the UAF. 😄
>>>
>>> Tested-Bny: Donald Buczek <buczek@molgen.mpg.de>
>>>
>>> Maybe you can add me to the cc list for v4 as I'm not subscribed to the lists.
>>
>> Sorry, found another one. Reproducer:
>>
>> =====
>> #! /bin/bash
>> set -xe
>> modprobe blksnap
>> test -e /scratch/local/test.dat || fallocate -l 1G /scratch/local/test.dat
>> s=$(blksnap snapshot_create -d /dev/vdb)
>> blksnap snapshot_appendstorage -i $s -f /scratch/local/test.dat
>> blksnap snapshot_take -i $s
>> s2=$(blksnap snapshot_create -d /dev/vdb)
>> blksnap snapshot_destroy -i $s2
>> blksnap snapshot_destroy -i $s
>> =====
>>
>>
>> [20382.402921] blksnap-snapshot: Snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa was created
>> [20382.535933] blksnap-image: Create snapshot image device for original device [253:16]
>> [20382.542405] blksnap-snapshot: Snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa was taken successfully
>> [20382.572564] blksnap-snapshot: Snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966 was created
>> [20382.600521] blksnap-snapshot: Destroy snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966
>> [20382.602373] blksnap-snapshot: Release snapshot 4b2d571d-9a24-419d-96c2-8d64a07c4966
>> [20382.722137] blksnap-snapshot: Destroy snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa
>> [20382.724033] blksnap-snapshot: Release snapshot ff1c54f1-3e8c-4c99-bb26-35e82dc1c9fa
>> [20382.725850] ==================================================================
>> [20382.727641] BUG: KASAN: wild-memory-access in snapshot_free+0x73/0x170 [blksnap]
>> [20382.729326] Write of size 8 at addr dead000000000108 by task blksnap/8297
>> ...
> Great! Thanks.
> 
> There is no protection against re-adding a block device to the snapshot.
> I'll take care of it.
> 

Hi!

I think the fix turned out to be quite beautiful.
Now you will get an error "Device or resource busy".
Fix in attach and on github.
Link: https://github.com/SergeiShtepa/linux/commit/43a5d3dd9858f092b734187b6a62ce75acaa47c7

--------------Uz7N2hSro1BXgYQbTl7hDQWx
Content-Type: text/x-patch; charset="UTF-8";
	name="fix_no_protection_re-adding.patch"
Content-Disposition: attachment;
	filename="fix_no_protection_re-adding.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svYmxrc25hcC9zbmFwc2hvdC5jIGIvZHJpdmVy
cy9ibG9jay9ibGtzbmFwL3NuYXBzaG90LmMKaW5kZXggMWYyOGZmNTlkNzYyLi44MDYzY2M0
YjkyOWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmxvY2svYmxrc25hcC9zbmFwc2hvdC5jCisr
KyBiL2RyaXZlcnMvYmxvY2svYmxrc25hcC9zbmFwc2hvdC5jCkBAIC0yOCw3ICsyOCw3IEBA
IHN0YXRpYyB2b2lkIHNuYXBzaG90X2ZyZWUoc3RydWN0IGtyZWYgKmtyZWYpCiAKIAkJdHJh
Y2tlciA9IGxpc3RfZmlyc3RfZW50cnkoJnNuYXBzaG90LT50cmFja2Vycywgc3RydWN0IHRy
YWNrZXIsCiAJCQkJCSAgIGxpbmspOwotCQlsaXN0X2RlbCgmdHJhY2tlci0+bGluayk7CisJ
CWxpc3RfZGVsX2luaXQoJnRyYWNrZXItPmxpbmspOwogCQl0cmFja2VyX3JlbGVhc2Vfc25h
cHNob3QodHJhY2tlcik7CiAJCXRyYWNrZXJfcHV0KHRyYWNrZXIpOwogCX0KQEAgLTE2MCwx
NCArMTYwLDE3IEBAIGludCBzbmFwc2hvdF9hZGRfZGV2aWNlKGNvbnN0IHV1aWRfdCAqaWQs
IHN0cnVjdCB0cmFja2VyICp0cmFja2VyKQogCQl9CiAJfQogCWlmICghcmV0KSB7Ci0JCXRy
YWNrZXJfZ2V0KHRyYWNrZXIpOwotCQlsaXN0X2FkZF90YWlsKCZ0cmFja2VyLT5saW5rLCAm
c25hcHNob3QtPnRyYWNrZXJzKTsKKwkJaWYgKGxpc3RfZW1wdHkoJnRyYWNrZXItPmxpbmsp
KSB7CisJCQl0cmFja2VyX2dldCh0cmFja2VyKTsKKwkJCWxpc3RfYWRkX3RhaWwoJnRyYWNr
ZXItPmxpbmssICZzbmFwc2hvdC0+dHJhY2tlcnMpOworCQl9IGVsc2UKKwkJCXJldCA9IC1F
QlVTWTsKIAl9CiAJdXBfd3JpdGUoJnNuYXBzaG90LT5yd19sb2NrKTsKIAogCXNuYXBzaG90
X3B1dChzbmFwc2hvdCk7CiAKLQlyZXR1cm4gMDsKKwlyZXR1cm4gcmV0OwogfQogCiBpbnQg
c25hcHNob3RfZGVzdHJveShjb25zdCB1dWlkX3QgKmlkKQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibG9jay9ibGtzbmFwL3RyYWNrZXIuYyBiL2RyaXZlcnMvYmxvY2svYmxrc25hcC90cmFj
a2VyLmMKaW5kZXggZDk4MDQ4ZGM1YmVkLi4wMDhjYzdmMGY4MWUgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvYmxvY2svYmxrc25hcC90cmFja2VyLmMKKysrIGIvZHJpdmVycy9ibG9jay9ibGtz
bmFwL3RyYWNrZXIuYwpAQCAtNzksNiArNzksNyBAQCBzdGF0aWMgc3RydWN0IGJsa2ZpbHRl
ciAqdHJhY2tlcl9hdHRhY2goc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikKIAkJcmV0dXJu
IEVSUl9QVFIoLUVOT01FTSk7CiAJfQogCisJbXV0ZXhfaW5pdCgmdHJhY2tlci0+Y3RsX2xv
Y2spOwogCUlOSVRfTElTVF9IRUFEKCZ0cmFja2VyLT5saW5rKTsKIAlrcmVmX2luaXQoJnRy
YWNrZXItPmtyZWYpOwogCXRyYWNrZXItPmRldl9pZCA9IGJkZXYtPmJkX2RldjsKQEAgLTIz
NCwxMiArMjM1LDE3IEBAIHN0YXRpYyBpbnQgKCpjb25zdCBjdGxfdGFibGVbXSkoc3RydWN0
IHRyYWNrZXIgKnRyYWNrZXIsCiBzdGF0aWMgaW50IHRyYWNrZXJfY3RsKHN0cnVjdCBibGtm
aWx0ZXIgKmZsdCwgY29uc3QgdW5zaWduZWQgaW50IGNtZCwKIAkJICAgICAgIF9fdTggX191
c2VyICpidWYsIF9fdTMyICpwbGVuKQogeworCWludCByZXQgPSAwOwogCXN0cnVjdCB0cmFj
a2VyICp0cmFja2VyID0gY29udGFpbmVyX29mKGZsdCwgc3RydWN0IHRyYWNrZXIsIGZpbHRl
cik7CiAKIAlpZiAoY21kID4gQVJSQVlfU0laRShjdGxfdGFibGUpKQogCQlyZXR1cm4gLUVO
T1RUWTsKIAotCXJldHVybiBjdGxfdGFibGVbY21kXSh0cmFja2VyLCBidWYsIHBsZW4pOwor
CW11dGV4X2xvY2soJnRyYWNrZXItPmN0bF9sb2NrKTsKKwlyZXQgPSBjdGxfdGFibGVbY21k
XSh0cmFja2VyLCBidWYsIHBsZW4pOworCW11dGV4X3VubG9jaygmdHJhY2tlci0+Y3RsX2xv
Y2spOworCisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIHN0cnVjdCBibGtmaWx0ZXJfb3Bl
cmF0aW9ucyB0cmFja2VyX29wcyA9IHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svYmxr
c25hcC90cmFja2VyLmggYi9kcml2ZXJzL2Jsb2NrL2Jsa3NuYXAvdHJhY2tlci5oCmluZGV4
IGQwOTcyOTk0ZDUyOC4uZGJmODI5NWY5NTE4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jsb2Nr
L2Jsa3NuYXAvdHJhY2tlci5oCisrKyBiL2RyaXZlcnMvYmxvY2svYmxrc25hcC90cmFja2Vy
LmgKQEAgLTE5LDYgKzE5LDkgQEAgc3RydWN0IGRpZmZfYXJlYTsKICAqCiAgKiBAZmlsdGVy
OgogICoJVGhlIGJsb2NrIGRldmljZSBmaWx0ZXIgc3RydWN0dXJlLgorICogQGN0bF9sb2Nr
OgorICoJVGhlIG11dGV4IGJsb2NrcyBzaW11bHRhbmVvdXMgbWFuYWdlbWVudCBvZiB0aGUg
dHJhY2tlciBmcm9tIGRpZmZlcmVudAorICoJdHJlYWRzLgogICogQGxpbms6CiAgKglMaXN0
IGhlYWRlci4gQWxsb3dzIHRvIGNvbWJpbmUgdHJhY2tlcnMgaW50byBhIGxpc3QgaW4gYSBz
bmFwc2hvdC4KICAqIEBrcmVmOgpAQCAtNDEsNiArNDQsNyBAQCBzdHJ1Y3QgZGlmZl9hcmVh
OwogICovCiBzdHJ1Y3QgdHJhY2tlciB7CiAJc3RydWN0IGJsa2ZpbHRlciBmaWx0ZXI7CisJ
c3RydWN0IG11dGV4IGN0bF9sb2NrOwogCXN0cnVjdCBsaXN0X2hlYWQgbGluazsKIAlzdHJ1
Y3Qga3JlZiBrcmVmOwogCWRldl90IGRldl9pZDsK

--------------Uz7N2hSro1BXgYQbTl7hDQWx--
