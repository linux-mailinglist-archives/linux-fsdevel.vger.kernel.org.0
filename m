Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9647572E324
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 14:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjFMMfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242537AbjFMMfK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:35:10 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B3BE7A;
        Tue, 13 Jun 2023 05:35:08 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id E09391B72E;
        Tue, 13 Jun 2023 15:35:06 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1686659707;
        bh=4oNmRkLesBC9RjRkU4eqkCoLnWTFT9D5was/erYZ+04=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=Y2GAhHPF7F6Nw9yN00Ft+kqym1xOwxfwE3WOYgZap+Vrl9M3uFULJMehxZEY6JTVo
         qtADvpKq2vnFKHf/2x2nX8721HIr2mGOw7LDkD2b5zd9vj2Uiue4O1cZ6DU6ZmRMx3
         XwwWX+T7jHAREJ2cnO1lyB3vfuOa4iTVqi3RSKK77D4xXAa+oci2I30A8VVgPssEOX
         xqii/Plgtwdvaw1M6F0xM2ndkWZ1nX3ew8yh83s3Z61saWXiMqkF5WQAevWFLO7MG+
         6YFdjZYux3j4VYnWRAiwWjt0LbnPJUWHi0r5qf0HKB6E0do97YsFIfes+NkLSz16/k
         pE715DtG5+Oug==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 13 Jun
 2023 14:35:05 +0200
Message-ID: <f7b67068-62c4-0977-265a-37c84f553eab@veeam.com>
Date:   Tue, 13 Jun 2023 14:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 02/11] block: Block Device Filtering Mechanism
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, <axboe@kernel.dk>,
        <hch@infradead.org>, <corbet@lwn.net>, <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "Donald Buczek" <buczek@molgen.mpg.de>
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
 <20230609115858.4737-2-sergei.shtepa@veeam.com>
 <e2f851d7-6b17-7a36-b5b3-2d60d450989d@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <e2f851d7-6b17-7a36-b5b3-2d60d450989d@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315546D7163
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/13/23 03:51, Randy Dunlap wrote:
> 
> On 6/9/23 04:58, Sergei Shtepa wrote:
>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>> index b7b56871029c..7904f157b245 100644
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -189,6 +189,9 @@ struct fsxattr {
>>   * A jump here: 130-136 are reserved for zoned block devices
>>   * (see uapi/linux/blkzoned.h)
>>   */
>> +#define BLKFILTER_ATTACH	_IOWR(0x12, 140, struct blkfilter_name)
>> +#define BLKFILTER_DETACH	_IOWR(0x12, 141, struct blkfilter_name)
>> +#define BLKFILTER_CTL		_IOWR(0x12, 142, struct blkfilter_ctl)
> 
> Please update Documentation/userspace-api/ioctl/ioctl-number.rst
> with the blkfilter ioctl number usage.

It seems to me that there is no need to change anything in the table of
numbers for 'blkfilter'. I think the existing record is enough:

0x10  20-2F  arch/s390/include/uapi/asm/hypfs.h
0x12  all    linux/fs.h
             linux/blkpg.h

Maybe it would probably be correct to specify the file 'uapi/linux/fs.h'?
And maybe we need to specify the request numbers for blksnap?

add ioctls numbers for blksnap

Asked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 176e8fc3f31b..96af64988251 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -202,6 +202,7 @@ Code  Seq#    Include File                                           Comments
 'V'   C0     linux/ivtvfb.h                                          conflict!
 'V'   C0     linux/ivtv.h                                            conflict!
 'V'   C0     media/si4713.h                                          conflict!
+'V'   00-1F  uapi/linux/blksnap.h                                    conflict!
 'W'   00-1F  linux/watchdog.h                                        conflict!
 'W'   00-1F  linux/wanrouter.h                                       conflict! (pre 3.9)
 'W'   00-3F  sound/asound.h                                          conflict!
-- 
2.20.1
