Return-Path: <linux-fsdevel+bounces-56448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E002FB177DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 23:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9774B6236F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE61257455;
	Thu, 31 Jul 2025 21:13:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72C11CA0;
	Thu, 31 Jul 2025 21:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996402; cv=none; b=FcGQ5Br27s65EXKYh4ohUaW6k6RsKB8nO266rbXn9sBxXJtOunYmlIvYQ6U3fl3FM5PXAQ4+LpEjxpUVhwAa5Ihs88pY75d6S2ejcW8m0fxFnNbCbpZQJwSNVifcGkL6Joqfw9TQt9XzjINQfpIqONdXIKlqQpFuUQ6b0uNeAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996402; c=relaxed/simple;
	bh=EScUSlUS+eDxumcLvA+asS4gGNX4tASN3+k0ZzYlR+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vav+l4IHo22yHQ4FFFSRCGcJVOV/NmVqQeekLZ8eV4xNsJMDS7uo7wPvM6UaoYJfVLGJR20FE//9VnpJx7+zIcoftQ6RagUjfBLNmA08UFsz/BTYmA5zIFWMY/N/9VYfoiq7qYaICDEYm5mpO6FIzLbLqxLIubIXtORrHylZg6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56VLCVUN072767;
	Fri, 1 Aug 2025 06:12:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56VLCU46072764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 1 Aug 2025 06:12:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5f0769cd-2cbb-4349-8be4-dfdc74c2c5f8@I-love.SAKURA.ne.jp>
Date: Fri, 1 Aug 2025 06:12:31 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: update sanity check of the root record
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "leocstone@gmail.com" <leocstone@gmail.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>,
        "brauner@kernel.org" <brauner@kernel.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
 <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
 <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
 <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
 <5498a57ea660b5366ef213acd554aba55a5804d1.camel@ibm.com>
 <57d65c2f-ca35-475d-b950-8fd52b135625@I-love.SAKURA.ne.jp>
 <f0580422d0d8059b4b5303e56e18700539dda39a.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <f0580422d0d8059b4b5303e56e18700539dda39a.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav202.rs.sakura.ne.jp

On 2025/08/01 3:03, Viacheslav Dubeyko wrote:
> On Thu, 2025-07-31 at 07:02 +0900, Tetsuo Handa wrote:
>> On 2025/07/31 4:24, Viacheslav Dubeyko wrote:
>>> If we considering case HFS_CDR_DIR in hfs_read_inode(), then we know that it
>>> could be HFS_POR_CNID, HFS_ROOT_CNID, or >= HFS_FIRSTUSER_CNID. Do you mean that
>>> HFS_POR_CNID could be a problem in hfs_write_inode()?
>>
>> Yes. Passing one of 1, 5 or 15 instead of 2 from hfs_fill_super() triggers BUG()
>> in hfs_write_inode(). We *MUST* validate at hfs_fill_super(), or hfs_read_inode()
>> shall have to also reject 1, 5 and 15 (and as a result only accept 2).
> 
> The fix should be in hfs_read_inode(). Currently, suggested solution hides the
> issue but not fix the problem.

Not fixing this problem might be hiding other issues, by hitting BUG() before
other issues shows up.

> Because b-tree nodes could contain multiple
> corrupted records. Now, this patch checks only record for root folder. Let's
> imagine that root folder record will be OK but another record(s) will be
> corrupted in such way.

Can the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) be something other than HFS_ROOT_CNID ?

If the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) must be HFS_ROOT_CNID, this patch itself will be
a complete fix for this problem.

> Finally, we will have successful mount but operation with
> corrupted record(s) will trigger this issue. So, I cannot consider this patch as
> a complete fix of the problem.

Did you try what you think as a fix of this problem (I guess something like
shown below will be needed for avoid hitting BUG()) using
https://lkml.kernel.org/r/a8f8da77-f099-499b-98e0-39ed159b6a2d@I-love.SAKURA.ne.jp ?

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..d60395111ed5 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -81,7 +81,8 @@ static bool hfs_release_folio(struct folio *folio, gfp_t mask)
 		tree = HFS_SB(sb)->cat_tree;
 		break;
 	default:
-		BUG();
+		pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\n",
+		       inode->i_ino);
 		return false;
 	}
 
@@ -305,11 +306,31 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	case HFS_CDR_FIL:
 		return inode->i_ino == be32_to_cpu(rec->file.FlNum);
 	default:
-		BUG();
+		pr_err("detected unknown type %u, running fsck.hfs is recommended.\n", rec->type);
 		return 1;
 	}
 }
 
+static bool is_bad_id(unsigned long ino)
+{
+	switch (ino) {
+	case 0:
+	case 3:
+	case 4:
+	case 6:
+	case 7:
+	case 8:
+	case 9:
+	case 10:
+	case 11:
+	case 12:
+	case 13:
+	case 14:
+		return true;
+	}
+	return false;
+}
+
 /*
  * hfs_read_inode
  */
@@ -348,6 +369,10 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		}
 
 		inode->i_ino = be32_to_cpu(rec->file.FlNum);
+		if (is_bad_id(inode->i_ino)) {
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_mode = S_IRUGO | S_IXUGO;
 		if (!(rec->file.Flags & HFS_FIL_LOCK))
 			inode->i_mode |= S_IWUGO;
@@ -358,9 +383,15 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
+		if (inode->i_ino < 16)
+			pr_info("HFS_CDR_FIL i_ino=%ld\n", inode->i_ino);
 		break;
 	case HFS_CDR_DIR:
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
+		if (is_bad_id(inode->i_ino)) {
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
@@ -368,6 +399,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 				      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
+		if (inode->i_ino < 16)
+			pr_info("HFS_CDR_DIR i_ino=%ld\n", inode->i_ino);
 		break;
 	default:
 		make_bad_inode(inode);
@@ -441,7 +474,8 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
 			return 0;
 		default:
-			BUG();
+			pr_err("detected unknown inode %lu, running fsck.hfs is recommended.\n",
+			       inode->i_ino);
 			return -EIO;
 		}
 	}


# for i in $(seq 0 15); do timeout 1 unshare -m ./hfs $i; done
# dmesg | grep fsck
[   52.563547] [    T479] hfs: detected unknown inode 1, running fsck.hfs is recommended.
[   56.606238] [    T255] hfs: detected unknown inode 5, running fsck.hfs is recommended.
[   66.694795] [    T500] hfs: detected unknown inode 15, running fsck.hfs is recommended.


