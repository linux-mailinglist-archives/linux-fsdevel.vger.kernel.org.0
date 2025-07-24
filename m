Return-Path: <linux-fsdevel+bounces-55919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6014B10127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1BB1C26149
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 06:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94C226D0C;
	Thu, 24 Jul 2025 06:56:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F7224891;
	Thu, 24 Jul 2025 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340180; cv=none; b=YPDcn+IHlLpzHFY4utmvr34aNGOjP25cO/kAv/AMUwqDQasmrPXLctKurHbnld2ckuyyuW92mL/7qjMmHuw1s2eAF+vJyUHCyB03eTepgPiSO5NJsKzFTxUDnTsiWMr/jG98tiHA4co4F81klDHH6I98Jhcobkc7mImH5seMaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340180; c=relaxed/simple;
	bh=d6EwIeVxZxsVQFHkH3jUKld652EUW7QYzuDNa7bok58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/u4XXkIQ14+ykiaSJNWumdjFaiBNysopzc8GlC6dph7m89MJRIzNyEfF6WP5xIhe9vEmYbh31eCEO0EsuiRv2uw9HhV3eu8xbIXg/rw7t2c3vWjpw6HiaYX/MC3JPI+8OmtNO7CyZ8Mi/NW/iSBofDGggOUTDLYMY/S48Wx6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56O6thO3025564;
	Thu, 24 Jul 2025 15:55:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56O6thHW025561
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 15:55:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
Date: Thu, 24 Jul 2025 15:55:42 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "willy@infradead.org" <willy@infradead.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
 <aH-enGSS7zWq0jFf@casper.infradead.org>
 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

Then, something like below change?

--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -318,6 +318,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
        struct hfs_iget_data *idata = data;
        struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
        hfs_cat_rec *rec;
+       /* https://developer.apple.com/library/archive/technotes/tn/tn1150.html#CNID */
+       static const u16 bad_cnid_list = (1 << 0) | (1 << 6) | (1 << 7) | (1 << 8) |
+               (1 << 9) | (1 << 10) | (1 << 11) | (1 << 12) | (1 << 13);

        HFS_I(inode)->flags = 0;
        HFS_I(inode)->rsrc_inode = NULL;
@@ -358,6 +361,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
                inode->i_op = &hfs_file_inode_operations;
                inode->i_fop = &hfs_file_operations;
                inode->i_mapping->a_ops = &hfs_aops;
+               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
+                       make_bad_inode(inode);
                break;
        case HFS_CDR_DIR:
                inode->i_ino = be32_to_cpu(rec->dir.DirID);
@@ -368,6 +373,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
                                      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
                inode->i_op = &hfs_dir_inode_operations;
                inode->i_fop = &hfs_dir_operations;
+               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
+                       make_bad_inode(inode);
                break;
        default:
                make_bad_inode(inode);



But I can't be convinced that above change is sufficient, for if I do

+		static u8 serial;
+               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
+                       inode->i_ino = (serial++) % 16;

instead of

+               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
+                       make_bad_inode(inode);

, the reproducer still hits BUG() for 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15
because hfs_write_inode() handles only 2, 3 and 4.

        if (inode->i_ino < HFS_FIRSTUSER_CNID) {
                switch (inode->i_ino) {
                case HFS_ROOT_CNID:
                        break;
                case HFS_EXT_CNID:
                        hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
                        return 0;
                case HFS_CAT_CNID:
                        hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
                        return 0;
                default:
                        BUG();
                        return -EIO;
                }
        }

Unless this is because I'm modifying in-kernel memory than filesystem image,
we will have to remove BUG() line.

On 2025/07/24 3:43, Viacheslav Dubeyko wrote:
> This could be defined in Catalog File (maybe not). I didn't find anything
> related to this in HFS specification.

https://developer.apple.com/library/archive/technotes/tn/tn1150.html#CNID
says "the CNID of zero is never used and serves as a nil value." That is,
I think we can reject inode->i_ino == 0 case.

But I'm not sure for other values up to 15, expect values noted as "introduced
with HFS Plus". We could filter values in bad_cnid_list bitmap, but filtering
undefined values might not be sufficient for preserving BUG() line.


