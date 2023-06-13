Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908B172E718
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242918AbjFMPYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 11:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242789AbjFMPYO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:24:14 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215E1BE7;
        Tue, 13 Jun 2023 08:24:00 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id E534441C2D;
        Tue, 13 Jun 2023 11:23:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1686669838;
        bh=40s+nUN8R5Qgu61YlGIQxZXjwUmvIf+foe93wtMZLps=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=kccezytyhEARm4Ht3h3sAzJiwHnocoTeyPml2SRgvpncfqGgta7s3s+qEVqw1g4UZ
         H+E5vne7MD40jhf568I1zCOrVj3KE000dpx1WRe20dqZYOBtW/ceykZWhQMov1QA1a
         7EJJV1ADLISDrTHe5sAtfUbWQkkOfESPrqe015l5OT9cnijMYw30iK5A4XBnr5wwr+
         n3/Mos+ot2gb7UdpKJ1OsdKKgB+Xp518iQf5mCZRCAqyqw89ff8AcQE07iXfoKYXZK
         EYx0OiVCWPX9nWTWc2clW2OMa805j5lStTV3MurApz/NVCdV0DT3F/z7hfpFt9911v
         F5GDfLPwSMEFA==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 13 Jun
 2023 17:23:56 +0200
Message-ID: <5f6cdc55-ddbe-ab03-92bf-02ff0318985f@veeam.com>
Date:   Tue, 13 Jun 2023 17:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 01/11] documentation: Block Device Filtering Mechanism
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, <axboe@kernel.dk>,
        <hch@infradead.org>, <corbet@lwn.net>, <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
 <004cc6b2-1941-5aed-6e09-3bd01dfbf8e4@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <004cc6b2-1941-5aed-6e09-3bd01dfbf8e4@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D7161
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you very much, Randy, for the work you've done.
Sometimes I want to compile the documentation into bytecode, fix the warnings
and debug it in the debugger.

On 6/13/23 03:52, Randy Dunlap wrote:
> Subject:
> Re: [PATCH v4 01/11] documentation: Block Device Filtering Mechanism
> From:
> Randy Dunlap <rdunlap@infradead.org>
> Date:
> 6/13/23, 03:52
> 
> To:
> Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk, hch@infradead.org, corbet@lwn.net, snitzer@kernel.org
> CC:
> viro@zeniv.linux.org.uk, brauner@kernel.org, willy@infradead.org, dlemoal@kernel.org, wsa@kernel.org, heikki.krogerus@linux.intel.com, ming.lei@redhat.com, gregkh@linuxfoundation.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
> 
> 
> Hi--
> 
> On 6/9/23 04:58, Sergei Shtepa wrote:
>> The document contains:
>> * Describes the purpose of the mechanism
>> * A little historical background on the capabilities of handling I/O
>>   units of the Linux kernel
>> * Brief description of the design
>> * Reference to interface description
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
>> ---
>>  Documentation/block/blkfilter.rst | 64 +++++++++++++++++++++++++++++++
>>  Documentation/block/index.rst     |  1 +
>>  MAINTAINERS                       |  6 +++
>>  3 files changed, 71 insertions(+)
>>  create mode 100644 Documentation/block/blkfilter.rst
>>
>> diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkfilter.rst
>> new file mode 100644
>> index 000000000000..555625789244
>> --- /dev/null
>> +++ b/Documentation/block/blkfilter.rst
>> @@ -0,0 +1,64 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +================================
>> +Block Device Filtering Mechanism
>> +================================
>> +
>> +The block device filtering mechanism is an API that allows to attach block
>                                                   that allows {what or who} to attach
> 
> so who/what does the attach? Is it a driver or a user or admin or something else?
> and attach them to what?
> 
>> +device filters. Block device filters allow perform additional processing
>                                         allow performing ...
> 
>> +for I/O units.
>> +
>> +Introduction
>> +============
>> +
>> +The idea of handling I/O units on block devices is not new. Back in the
>> +2.6 kernel, there was an undocumented possibility of handling I/O units
>> +by substituting the make_request_fn() function, which belonged to the
>> +request_queue structure. But none of the in-tree kernel modules used this
>> +feature, and it was eliminated in the 5.10 kernel.
>> +
>> +The block device filtering mechanism returns the ability to handle I/O units.
>> +It is possible to safely attach filter to a block device "on the fly" without
>                             attach a filter
> or
>                             attach filters
> 
>> +changing the structure of block devices stack.
>                           of the block device's stack.
> 
>> +
>> +It supports attaching one filter to one block device, because there is only
>> +one filter implementation in the kernel yet.
>> +See Documentation/block/blksnap.rst.
>> +
>> +Design
>> +======
>> +
>> +The block device filtering mechanism provides registration and unregistration
>> +for filter operations. The struct blkfilter_operations contains a pointer to
>> +the callback functions for the filter. After registering the filter operations,
>> +filter can be managed using block device ioctl BLKFILTER_ATTACH,
>    a filter
> or
>    the filter                               ioctls
> 
>> +BLKFILTER_DETACH and BLKFILTER_CTL.
>> +
>> +When the filter is attached, the callback function is called for each I/O unit
>> +for a block device, providing I/O unit filtering. Depending on the result of
>> +filtering the I/O unit, it can either be passed for subsequent processing by
>> +the block layer, or skipped.
>> +
>> +The filter can be implemented as a loadable module. In this case, the filter
>> +module cannot be unloaded while the filter is attached to at least one of the
>> +block devices.
>> +
>> +Interface description
>> +=====================
>> +
>> +The ioctl BLKFILTER_ATTACH and BLKFILTER_DETACH use structure blkfilter_name.
>        ioctls
> 
>> +It allows to attach a filter to a block device or detach it.
>    It allows a driver to attach a filter ...
> ?
> 
>> +
>> +The ioctl BLKFILTER_CTL use structure blkfilter_ctl. It allows to send a
>                                                         It allows a driver to send a
> 
>> +filter-specific command.
>> +
>> +.. kernel-doc:: include/uapi/linux/blk-filter.h
>> +
>> +To register in the system, the filter creates its own account, which contains
>> +callback functions, unique filter name and module owner. This filter account is
>> +used by the registration functions.
> I'm having a problem with this "account" thingy. Can you explain more about it?
> Is there an alternate word that might be used here?
> 
>> +
>> +.. kernel-doc:: include/linux/blk-filter.h
>> +
>> +.. kernel-doc:: block/blk-filter.c
>> +   :export:
> Thanks.
> -- ~Randy
> 

fix of the blkfilter.rst document and help in Kconfig for blksnap

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/block/blkfilter.rst | 28 +++++++++++++++-------------
 drivers/block/blksnap/Kconfig     |  2 +-
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/block/blkfilter.rst b/Documentation/block/blkfilter.rst
index 555625789244..b5160d1008fd 100644
--- a/Documentation/block/blkfilter.rst
+++ b/Documentation/block/blkfilter.rst
@@ -4,8 +4,8 @@
 Block Device Filtering Mechanism
 ================================
 
-The block device filtering mechanism is an API that allows to attach block
-device filters. Block device filters allow perform additional processing
+The block device filtering mechanism provides the ability to attach block
+device filters. Block device filters allow performing additional processing
 for I/O units.
 
 Introduction
@@ -18,8 +18,8 @@ request_queue structure. But none of the in-tree kernel modules used this
 feature, and it was eliminated in the 5.10 kernel.
 
 The block device filtering mechanism returns the ability to handle I/O units.
-It is possible to safely attach filter to a block device "on the fly" without
-changing the structure of block devices stack.
+It is possible to safely attach a filter to a block device "on the fly" without
+changing the structure of the block device's stack.
 
 It supports attaching one filter to one block device, because there is only
 one filter implementation in the kernel yet.
@@ -31,7 +31,7 @@ Design
 The block device filtering mechanism provides registration and unregistration
 for filter operations. The struct blkfilter_operations contains a pointer to
 the callback functions for the filter. After registering the filter operations,
-filter can be managed using block device ioctl BLKFILTER_ATTACH,
+the filter can be managed using block device ioctls BLKFILTER_ATTACH,
 BLKFILTER_DETACH and BLKFILTER_CTL.
 
 When the filter is attached, the callback function is called for each I/O unit
@@ -46,17 +46,19 @@ block devices.
 Interface description
 =====================
 
-The ioctl BLKFILTER_ATTACH and BLKFILTER_DETACH use structure blkfilter_name.
-It allows to attach a filter to a block device or detach it.
-
-The ioctl BLKFILTER_CTL use structure blkfilter_ctl. It allows to send a
-filter-specific command.
+The ioctl BLKFILTER_ATTACH allows user-space programs to attach a block device
+filter to a block device. The ioctl BLKFILTER_DETACH allows user-space programs
+to detach it. Both ioctls use structure blkfilter_name. The ioctl BLKFILTER_CTL
+allows user-space programs to send a filter-specific command. It use structure
+blkfilter_ctl.
 
 .. kernel-doc:: include/uapi/linux/blk-filter.h
 
-To register in the system, the filter creates its own account, which contains
-callback functions, unique filter name and module owner. This filter account is
-used by the registration functions.
+To register in the system, the filter uses the blkfilter_operations structure,
+which contains callback functions, unique filter name and module owner. When
+attaching a filter to a block device, the filter creates a blkfilter structure.
+The pointer to the blkfilter structure allows the filter to determine for
+which block device the callback functions are being called.
 
 .. kernel-doc:: include/linux/blk-filter.h
 
diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
index 14081359847b..11df0886489d 100644
--- a/drivers/block/blksnap/Kconfig
+++ b/drivers/block/blksnap/Kconfig
@@ -8,5 +8,5 @@ config BLKSNAP
 	help
 	  Allow to create snapshots and track block changes for block devices.
 	  Designed for creating backups for simple block devices. Snapshots are
-	  temporary and are released then backup is completed. Change block
+	  temporary and are released when backup is completed. Change block
 	  tracking allows to create incremental or differential backups.
-- 
2.20.1
