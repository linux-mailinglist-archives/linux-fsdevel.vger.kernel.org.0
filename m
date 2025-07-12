Return-Path: <linux-fsdevel+bounces-54756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC0B02A90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 13:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1121C21EE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 11:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BA52750E4;
	Sat, 12 Jul 2025 11:22:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E1322154A;
	Sat, 12 Jul 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752319371; cv=none; b=n+g4K7L4phg8dUqHVaD8igmTp4c5YjjQcItl8i83iwrJmXGszzF6P2B9wHRRUu4M557k6awqXntald51QEPBoarQ6HtMuTjCZxDF7Sma6rIjBaC7c84Dbgc5GPZxkvpudVVYbTTCZRj2KhwJi9D9nG+evs8Zsp1Ymg27ZixchG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752319371; c=relaxed/simple;
	bh=koT6WX80uO3QGziHota+YoACtGCCfZs+tuAmuCq2f8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dx+5DaJ6LgIJlDIeQuYnabg33nOg5oAJriGiQ4UWSD5fZU0EkWJAFEadGgxT4OkK3T+dWRqa9TD5LMRjGJq/QJVX/oXvpaiW3HpbAHqv0FefYf2/tDCaCr6HOAsz7zK6HA/2qknmaNS3tgrhTfbKVrLTGMcrCvYZFoxGxgVntUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56CBMLhC020769;
	Sat, 12 Jul 2025 20:22:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56CBMLlU020766
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 12 Jul 2025 20:22:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <b6da38b0-dc7e-4fdc-b99c-f4fbd2a20168@I-love.SAKURA.ne.jp>
Date: Sat, 12 Jul 2025 20:22:20 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfsplus: don't use BUG_ON() in
 hfsplus_create_attributes_file()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54358ab7-4525-48ba-a1e5-595f6b107cc6@I-love.SAKURA.ne.jp>
 <4ce5a57c7b00bbd77d7ad6c23f0dcc55f99c3d1a.camel@ibm.com>
 <72c9d0c2-773c-4508-9d2d-e24703ff26e1@vivo.com>
 <427a9432-95a5-47a8-ba42-1631c6238486@I-love.SAKURA.ne.jp>
 <127b250a6bb701c631bedf562b3ee71eeb55dc2c.camel@ibm.com>
 <dc0add8a-85fc-41dd-a4a6-6f7cb10e8350@I-love.SAKURA.ne.jp>
 <316f8d5b06aed08bd979452c932cbce2341a8a56.camel@ibm.com>
 <3efa3d2a-e98f-43ee-91dd-5aeefcff75e1@I-love.SAKURA.ne.jp>
 <244c8da9-4c5e-42ed-99c7-ceee3e039a9c@I-love.SAKURA.ne.jp>
 <ead8611697a8a95a80fb533db86c108ff5f66f6f.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ead8611697a8a95a80fb533db86c108ff5f66f6f.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp

On 2025/07/12 2:21, Viacheslav Dubeyko wrote:
> Frankly speaking, I still don't see the whole picture here. If we have created
> the Attribute File during mount operation, then why should we try to create the
> Attributes File during __hfsplus_setxattr() call? If we didn't create the
> Attributes File during the mount time and HFSPLUS_SB(inode->i_sb)->attr_tree is
> NULL, then how i_size_read(attr_file) != 0? Even if we are checking vhdr-
>> attr_file.total_blocks, then it doesn't provide guarantee that
> i_size_read(attr_file) is zero too. Something is wrong in this situation and
> more stricter mount time validation cannot guarantee against the situation that
> you are trying to solve in the issue. We are missing something here.

I still don't see what you are missing.

When hfsplus_iget(sb, HFSPLUS_ATTR_CNID) is called from hfsplus_create_attributes_file(sb),
hfsplus_system_read_inode(inode) from hfsplus_iget(HFSPLUS_ATTR_CNID) calls
hfsplus_inode_read_fork(inode, &vhdr->attr_file). Since hfsplus_inode_read_fork() calls
inode_set_bytes(), it is natural that i_size_read(attr_file) != 0 when returning from
hfsplus_iget(sb, HFSPLUS_ATTR_CNID).

At this point, the only question should be why hfsplus_inode_read_fork() from
hfsplus_system_read_inode(inode) from hfsplus_iget() is not called from hfsplus_fill_super()
when the Attributes File already exists and its size is not 0. And the reason is that
hfsplus_iget(sb, HFSPLUS_ATTR_CNID) from hfs_btree_open(sb, HFSPLUS_ATTR_CNID) is called
only when vhdr->attr_file.total_blocks != 0.

That is, when "vhdr" contains erroneous values (in the reproducer, vhdr->attr_file.total_blocks
is 0) that do not reflect the actual state of the filesystem (in the reproducer, inode_set_bytes()
sets non-zero value despite vhdr->attr_file.total_blocks is 0), hfsplus_fill_super() fails to call
hfs_btree_open(sb, HFSPLUS_ATTR_CNID) at mount time.

You can easily reproduce this problem by compiling and running the reproducer
at https://syzkaller.appspot.com/text?tag=ReproC&x=15f6b9d4580000 after you run
"losetup -f" which creates /dev/loop0 needed by the reproducer.

I noticed that the reason fsck.hfsplus could not detect errors is that the filesystem
image in the reproducer was compressed. If I run fsck.hfsplus on uncompressed image,
fsck.hfsplus generated the following messages.

# fsck.hfsplus hfsplus.img
** hfsplus.img
   Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
   Invalid extent entry
(4, 1)
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** Repairing volume.
   Look for links to corrupt files in DamagedFiles directory.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
   Volume bitmap needs minor repair for under-allocation
** Checking volume information.
   Invalid volume free block count
   (It should be 179 instead of 180)
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.


