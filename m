Return-Path: <linux-fsdevel+bounces-3112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C97EFD18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 03:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC631F2405E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBA35672;
	Sat, 18 Nov 2023 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IIofTESo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C595;
	Fri, 17 Nov 2023 18:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1700273546; bh=/k6xsZAJrQge/K+7M9os/UTy9wmpwN2mfbv7SW8LR+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IIofTESoNs8J3EsglZKPDXRhS6Ig9PpXzzwQ8KnsLdgvM+PWAE+SZ+Nr/vvEimp9v
	 3TTuXCVMHTU86DNDto7uZto/2LC6u412v9C9sK2gbTXpYdtxOITVikiDmYmPjiupCS
	 vmBMJOM2W6PzApfW//A5iZ9fIZILixcOKfOWJQBs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
	id 3179A6DF; Sat, 18 Nov 2023 10:12:23 +0800
X-QQ-mid: xmsmtpt1700273543tc1pcwi6o
Message-ID: <tencent_C893AEDDAED20C8F27DD46FB92C9066E0906@qq.com>
X-QQ-XMAILINFO: Odf6WZwpq0Z+XHIHIrt9Ib/9FEa/fY1da45ioe8Q5l7gZtJcGiVfwG2nP3j19L
	 CROENrknxg4VqsqzxCehMwZxcsIAV8xjag8IyTtTrQ/1rbf4elGwxBMn2/oYvWv9Bdccmgfp5P5n
	 4KJ9oejAjiEs7+zid7RcW8Iw2MI+051g0DM9wTw3jp3vJ8Q0Yz6zw1VNrh/nZgWXKPBX1gC+hLOg
	 smf6VcMq4tU1pMxuiU3QF8RtLTKxc/2HZbIr640YHCVP8zAAGcgQ6WjGJumpllkC5sUGsRt/b9MM
	 aXWEr/ZEVJ9J55YKmnirA/t1p7weig1zXdu5GqL3Z6USiHe8Xp3w/M6t31KzTqJ1iDXiU4DeTtR8
	 FfDXvy6Y6+Zt074vBOS7zb9rYzQQd3XUW/jz0/0HJJUktG71RD4n0CpuhLcidCWpQdzbl9oAmFZy
	 g6DrjqWYgthB+59zdMiVSnCkdHqRH+EyfO8hcDkbCpfyjSu+8WpLSJhybyWmE3YCSa6BWpwwHg/P
	 q12xmeuyYdKzUWbZ6rZbvo8jAd+HZr8DIFiBN73JqP5hC6pnLY6O7QkUl5FvRX55TXLqXRDi026e
	 6Se9UwozN+EWAPFK6gi10QY8g1WjrCo0aNAaRxQQwYNyUgp83CR1c/fLv0Yeq41tZe+F6UNx9Uyv
	 aEMxL6FhGF11pLnIsnFKHpulO/ywHWnqBVvngpKKyP+h8jZuZK2IWBj65nE5a2F72B1VxOGlDU3o
	 oRsD1i9vO4/CnFycah7e8WM+xvhV7170Hd1wyfLTlrOGb/8P8zu0CT5smG8p3eCVZgVJpOHfVS3O
	 cH3N85POTPLIWukGfEMVOUqtQsW12XWzMT7gVqMbJ/lIUABLHi2alIynPFYZSJvHAIsmmwO1XqWX
	 V5obuDU50NHnTF0z3AcoRvVH05I6E/JcjAuWLVWyEHqqnW1bZQJDVdD9yFt5YuKL177elofjeD
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: phillip@squashfs.org.uk
Cc: akpm@linux-foundation.org,
	eadavis@qq.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	squashfs-devel@lists.sourceforge.net,
	syzbot+604424eb051c2f696163@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] squashfs: fix oob in squashfs_readahead
Date: Sat, 18 Nov 2023 10:12:24 +0800
X-OQ-MSGID: <20231118021223.3133094-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116151424.23597-1-phillip@squashfs.org.uk>
References: <20231116151424.23597-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 16 Nov 2023 15:14:24 +0000, Phillip Lougher wrote:
> > [Bug]
> > path_openat() called open_last_lookups() before calling do_open() and
> > open_last_lookups() will eventually call squashfs_read_inode() to set
> > inode->i_size, but before setting i_size, it is necessary to obtain file_size
> > from the disk.
> >
> > However, during the value retrieval process, the length of the value retrieved
> > from the disk was greater than output->length, resulting(-EIO) in the failure of
> > squashfs_read_data(), further leading to i_size has not been initialized,
> > i.e. its value is 0.
> >
> 
> NACK
> 
> This analysis is completely *wrong*.  First, if there was I/O error reading
> the inode it would never be created, and squasfs_readahead() would
> never be called on it, because it will never exist.
> 
> Second i_size isn't unintialised and it isn't 0 in value.  Where
> you got this bogus information from is because in your test patches,
> i.e.
[There is my debuging patch]
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 581ce9519339..1c7c5500206b 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -314,9 +314,11 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		bio_uninit(bio);
 		kfree(bio);

+		printk("datal: %d \n", length);
 		compressed = SQUASHFS_COMPRESSED(length);
 		length = SQUASHFS_COMPRESSED_SIZE(length);
 		index += 2;
+		printk("datal2: %d, c:%d, i:%d \n", length, compressed, index);

 		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
 		      compressed ? "" : "un", length);
@@ -324,6 +326,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	if (length < 0 || length > output->length ||
 			(index + length) > msblk->bytes_used) {
 		res = -EIO;
+		printk("srd: l:%d, ol: %d, bu: %d \n", length, output->length, msblk->bytes_used);
 		goto out;
 	}

patch link: https://syzkaller.appspot.com/text?tag=Patch&x=1142f82f680000

[There is my test log]
[  457.030754][ T8879] datal: 65473
[  457.034334][ T8879] datal2: 32705, c:0, i:1788
[  457.039253][ T8879] srd: l:32705, ol: 8192, bu: 1870
[  457.044513][ T8879] SQUASHFS error: Failed to read block 0x6fc: -5
[  457.052034][ T8879] SQUASHFS error: Unable to read metadata cache entry [6fa]
log link: https://syzkaller.appspot.com/x/log.txt?x=137b0270e80000

[Answer your doubts]
Based on the above test, it can be clearly determined that length=32705 is 
greater than the maximum metadata size of 8192, resulting in squashfs_read_data() failed.
This will further lead to squashfs_cache_get() returns "entry->error=entry->length=-EIO", 
followed by squashfs_read_metadata() failed, which will ultimately result in i_size not 
being initialized in squashfs_read_inode().

The following are the relevant call stacks:
  23 const struct inode_operations squashfs_dir_inode_ops = {
  24         .lookup = squashfs_lookup,
  25         .listxattr = squashfs_listxattr
  26 };
  NORMAL  +0 ~0 -0  fs/squashfs/namei.c

  path_openat()->open_last_lookups()->lookup_open()
    1         if (d_in_lookup(dentry)) {
 3455                 struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,                                                                                                                    1                                                              nd->flags);

 squashfs_lookup()->
	 squashfs_iget()->
	 squashfs_read_inode()-> 
	 init inode->i_size, example: inode->i_size = sqsh_ino->file_size;
> 
> https://lore.kernel.org/all/000000000000bb74b9060a14717c@google.com/
> 
> You have
> 
> +	if (!file_end) {
> +		printk("i:%p, is:%d, %s\n", inode, i_size_read(inode), __func__);
> +		res = -EINVAL;
> +		goto out;
> +	}
> +
> 
> You have used %d, and the result of i_size_read(inode) overflows, giving the
> bogus 0 value.
> 
> The actual value is 1407374883553280, or 0x5000000000000, which is
> too big to fit into an unsigned int.
> 
> > This resulted in the failure of squashfs_read_data(), where "SQUASHFS error:
> > Failed to read block 0x6fc: -5" was output in the syz log.
> > This also resulted in the failure of squashfs_cache_get(), outputting "SQUASHFS
> > error: Unable to read metadata cache entry [6fa]" in the syz log.
> >
> 
> NO, *that* is caused by the failure to read some other inodes which
> as a result are correctly not created.  Nothing to do with the oops here.
> 
> > [Fix]
> > Before performing a read ahead operation in squashfs_read_folio() and
> > squashfs_readahead(), check if i_size is not 0 before continuing.
> >
> 
> A third NO, it is only 0 because the variable overflowed.
> 
> Additionally, let's look at your "fix" here.
> 
> > @@ -461,6 +461,11 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
> >  	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
> >  				page->index, squashfs_i(inode)->start);
> >
> > +	if (!file_end) {
> > +		res = -EINVAL;
> > +		goto out;
> > +	}
> > +
> 
> file_end is computed by
> 
> 	int file_end = i_size_read(inode) >> msblk->block_log;
> 
> So your "fix" will reject *any* file less than msblk->block_log in
> size as invalid, including perfectly valid zero size files (empty
> files are valid too).

edward


