Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC983FB9D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 18:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhH3QLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 12:11:33 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:53368 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231181AbhH3QLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:11:32 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 2C35F82132;
        Mon, 30 Aug 2021 19:10:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630339837;
        bh=EHqXGS4rmfnFPRkL3Bz0NEQ2HPIJJIscM9YFhWiT28o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e1uPBsIYZjfQGFoDJQKf5EBXOIUYzpytPsEX6PE7ZGTu7uWyl4qDX21BshQo/FPD/
         akvhvaohtc9nT0UBqt8TEOiUuhyAPKLD6YoBmhLiguocX67dsKlEUVe0dAYIwQ06z8
         B5VkLu1eIWBv555I+XzohsjZ+U5IaFuzPJyjsai0=
Received: from [192.168.211.173] (192.168.211.173) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 19:10:36 +0300
Subject: Re: [PATCH] Restyle comments to better align with kernel-doc
To:     Kari Argillander <kari.argillander@gmail.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <joe@perches.com>, <dan.carpenter@oracle.com>,
        <willy@infradead.org>, <ntfs3@lists.linux.dev>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210803115709.zd3gjmxw7oe6b4zk@kari-VirtualBox>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <22f979ec-95e5-e95a-0d58-9eb43f2038aa@paragon-software.com>
Date:   Mon, 30 Aug 2021 19:10:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210803115709.zd3gjmxw7oe6b4zk@kari-VirtualBox>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.173]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 03.08.2021 14:57, Kari Argillander wrote:
> Capitalize comments and end with period for better reading.
> 
> Also function comments are now little more kernel-doc style. This way we
> can easily convert them to kernel-doc style if we want. Note that these
> are not yet complete with this style. Example function comments start
> with /* and in kernel-doc style they start /**.
> 
> Use imperative mood in function descriptions.
> 
> Change words like ntfs -> NTFS, linux -> Linux.
> 
> Use "we" not "I" when commenting code.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> Yes I know that this patch is quite monster. That's why I try to send this
> now before patch series get merged. After that this patch probebly needs to
> be splitted more and sended in patch series.
> 
> If someone thinks this should not be added now it is ok. I have try to read
> what is kernel philosophy in case "patch to patch" but haven't found any
> good information about it. It is no big deal to add later. In my own mind I
> do not want to touch so much comments after code is in.
> 
> I also don't know how easy this kind of patch is apply top of the patch
> series.

Thanks for the patch. I've applied it to create uniform style of comments.

Also removed double line addition from patch:

@@ -269,22 +260,28 @@ enum RECORD_FLAG {
 	RECORD_FLAG_UNKNOWN	= cpu_to_le16(0x0008),
 };

-/* MFT Record structure */
+/* MFT Record structure, */
 struct MFT_REC {
 	struct NTFS_RECORD_HEADER rhdr; // 'FILE'

-	__le16 seq;		// 0x10: Sequence number for this record
-	__le16 hard_links;	// 0x12: The number of hard links to record
-	__le16 attr_off;	// 0x14: Offset to attributes
-	__le16 flags;		// 0x16: See RECORD_FLAG
-	__le32 used;		// 0x18: The size of used part
-	__le32 total;		// 0x1C: Total record size
+	__le16 seq;		// 0x10: Sequence number for this record.
+	__le16 hard_links;	// 0x12: The number of hard links to record.
+	__le16 attr_off;	// 0x14: Offset to attributes.
+	__le16 flags;		// 0x16: See RECORD_FLAG.
+	__le32 used;		// 0x18: The size of used part.
+	__le32 total;		// 0x1C: Total record size.
+
+	struct MFT_REF parent_ref; // 0x20: Parent MFT record.
+	__le16 next_attr_id;	// 0x28: The next attribute Id.

-	struct MFT_REF parent_ref; // 0x20: Parent MFT record
-	__le16 next_attr_id;	// 0x28: The next attribute Id
+	__le32 used;		// 0x18: The size of used part.
+	__le32 total;		// 0x1C: Total record size.

-	__le16 res;		// 0x2A: High part of mft record?
-	__le32 mft_record;	// 0x2C: Current mft record number
+	struct MFT_REF parent_ref; // 0x20: Parent MFT record.
+	__le16 next_attr_id;	// 0x28: The next attribute Id.
+
+	__le16 res;		// 0x2A: High part of MFT record?
+	__le32 mft_record;	// 0x2C: Current MFT record number.
 	__le16 fixups[];	// 0x30:
 };

