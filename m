Return-Path: <linux-fsdevel+bounces-55771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD3B0E7EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 03:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D5A3B63DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B4F15B0EF;
	Wed, 23 Jul 2025 01:07:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE6E78F26;
	Wed, 23 Jul 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753232844; cv=none; b=XtM4mPtbzaQdmPzUyHsyA5sOxXaI+DGUwZhCtklor7Gbg2bCC9Uhy6JTtdKq3r5mBsFUs/F9yuKzWIPFrAX6U86qg3c5JozJ9Jnv5sJqteJLaWubaIF6NGDBRwupLy8GR3PH/nNBKSMlr8vu3F0HNHcoE1BZwwQVFOh96oh7f6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753232844; c=relaxed/simple;
	bh=2lepuHtO3UlrzZ3SQKEL5zBkNrwEynPEgtS+XmSxbOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcqMmPiEEPM91dhGYBWIuvNZI0QFpUxbnl0FMECkd6fblnfoRo9zUZDw3kOi++N8XT73JEpHHFoZXZb00BRXXr7lccNZqBbyr7IQ69mQub3ArUFGHZqh/zH9mJ+YEqDek1cr90stAWbMC1DHetnuvoAbqtoghKRNjI+S3CaJGtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56N170sj084419;
	Wed, 23 Jul 2025 10:07:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56N170vb084413
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 23 Jul 2025 10:07:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
Date: Wed, 23 Jul 2025 10:07:01 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/23 3:08, Viacheslav Dubeyko wrote:
> So, if rec->type is OK (HFS_CDR_FIL, HFS_CDR_DIR) then we process
> a particular type of record, otherwise, we create the bad inode. So, we simply
> need to extend this logic. If rec->file.FlNum or rec->dir.DirID is equal or
> bigger than HFS_FIRSTUSER_CNID, then we can create normal inode. Otherwise,
> we need to create the bad inode. We simply need to add the checking logic
> here. Tetsuo, does it make sense to you? :) Because, if we have corrupted value
> of rec->file.FlNum or rec->dir.DirID, then it doesn't make sense to create
> the normal inode with invalid i_ino. Simply, take a look here [2]:

Something is wrong with below change; legitimate HFS filesystem images can no longer be mounted.
I guess that several reserved IDs have to be excluded from make_bad_inode() conditions.

# hformat testfile.img
# mount -t hfs -o loop testfile.img /mnt/
mount: /mnt: filesystem was mounted, but any subsequent operation failed: Operation not permitted.

--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -358,6 +358,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
                inode->i_op = &hfs_file_inode_operations;
                inode->i_fop = &hfs_file_operations;
                inode->i_mapping->a_ops = &hfs_aops;
+               if (unlikely(inode->i_ino < HFS_FIRSTUSER_CNID))
+                       make_bad_inode(inode);
                break;
        case HFS_CDR_DIR:
                inode->i_ino = be32_to_cpu(rec->dir.DirID);
@@ -368,6 +370,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
                                      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
                inode->i_op = &hfs_dir_inode_operations;
                inode->i_fop = &hfs_dir_operations;
+               if (unlikely(inode->i_ino < HFS_FIRSTUSER_CNID))
+                       make_bad_inode(inode);
                break;
        default:
                make_bad_inode(inode);

