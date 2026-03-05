Return-Path: <linux-fsdevel+bounces-79483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC00EDFzqWnH7AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 13:12:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF1211615
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 13:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 638B430172ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 12:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA5C39A7E0;
	Thu,  5 Mar 2026 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O5EUwk0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3ED334C28;
	Thu,  5 Mar 2026 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712737; cv=none; b=VJ4Nyz24yucSnRr9mPLKipZmCowo34dPAOHihpVSlbhCUX+q0v682OFOgBn10UO5QCeKZ6RWctjGYdbKll5S5E6PIXgPk/DWgrYxSxfgXooW7ZMAzqdpCa5K0GwVkQNwLVRREbsBHRiCPXanopq+QZpvJMRgky+EeZtMChcTqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712737; c=relaxed/simple;
	bh=0c+/cl48xzUSzjYrm7fybWAEPBSyCp9mYNtzhGpxtpk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZP/ouvmNWFRD01Hjrbt57YPGRKuk1QndND3JiaHizRAf5x//rSGMR+HKHs9qGpOx0jcP331irn/q84qo6bFrNi7KmjlshxE1fjmdmdlUgrTz0NqshIUNGQt0lO+WgBKQ07SOt8giVdhTr0ssakHfs61x9EtUay9V2JkTJF8Ftmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O5EUwk0M; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772712732; bh=XLhUb8BciiyArELdv3LJggsSFprn8fACXGFyTDwQLVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O5EUwk0M3tHXbPJsBueX0B8TJNIsHGVgzbFEmAYGh3ZrQde/l1tV/xXyj2Lt5pil+
	 OIjBXJ7VGvuv0t0T5oMWPHAuL3Kqi0rvWro/NEctAnleDpjNzHCNZccINbJ9LAblDu
	 HHFizMBLBPOGWXs3glSp5YFuXJAUNogLut4t9BJE=
Received: from lxu-ped-host.. ([111.201.4.63])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 2B7A0A22; Thu, 05 Mar 2026 20:10:55 +0800
X-QQ-mid: xmsmtpt1772712655t9mljvqel
Message-ID: <tencent_ACFA334E9EFE1B0F4BFC1BEA2530BA52BB08@qq.com>
X-QQ-XMAILINFO: NZcTxHzy+2XTw6t6VMmhdE4ksUU5/H6G9Gfv7vYEMOhYRwfwKJhNltBLs0ZiZl
	 dHVvsBH4No9APsrV2PvH5mHA7kgf1a/SwNCRft7ktAd3UvJDSRLLBVfsXjW/BTpwuPYiqN/+8tna
	 5MzLKlGeIn2ygz/SHRDARF8mkh0x/PHjH/r9fgaDfO/swYneK8oTH23okjib6EXFPcyhtjRfFMJ3
	 LZzlS1ToJeb+1Z3riwKi1R3/IWYp84LS4qfdPaziVYy3dCiiqWMO/3akGoQQA+q2FVSVtC3CtGPj
	 jvrQcyQKqib1pK3uGVE1y3oqv1h8Zi/wkl+H1azsyNbzGHOalTH1HJhyO7mGMMyiO7adkCB0jh4S
	 UVAYpBtYMMlve7zbN3z5sQPUjQDLQOQEbOHlZGDBZGQBWHfjI8FBr20xs+3+9jrDKPU6EwFzSr/Z
	 //7Ws5PO6Zk9eKKh3tpdsvMlY2u+ZWBLNtVV8wnzi3Fq55cwzUt7XP8ob38l+cs4a1UGUZmJNmPb
	 PvrZJxU7GW2ComzU1CZlSg9TWlTOaGiY1bmGWUP17JU2F1VdJdBmdPTJVgla8haAtrdPjEgfU8kt
	 lW+IO8VCdEMQY0naA3gYzJhQk8apSMwGposeBqNgm+vYXfs3Jy1YXkl1+MVbgOH+4nzjxz0Z7GaI
	 WTFqYWHTQozoKvpfScLDhr9SZ0M/jYoGAbCCQ/lu9s54S1JD8bnhpDdyc6kHB3V6Y1bxJvq4SQCr
	 aOnXSsZqMJV0Gq6sVKU2idbVr3/ntna+rrhdEyTkyIXPA1FPrxrVNyYHpKH3zQQOwipKytXvEUbY
	 QjwMr9DBIo5jhoVwiPGSWJtRNS7r+kRJcMRbuSsY6GFOhjSQHtK16IhSK+Y21Tna/jAZ4Bd0QfJb
	 4wLWb3aT1veNBk7uIHOhAClrbHZ+WAQgK2ReGMmwnt2X3Cypd/CotRRm473eRnbRyGYPHRJSBlnB
	 024aAg4eTjL87QcWqxbXT0WFueNsE+mXbPZqDprgUFFZ12/5Wjpc98MELDMTeWhXB72k8LNsGvXk
	 3gOPYLmke3npkXWVr9MOIJE4QV4rEgQ+vBvZU1rclMiLl/gsp3ntKTO4HlKho=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Edward Adam Davis <eadavis@qq.com>
To: jack@suse.cz
Cc: brauner@kernel.org,
	eadavis@qq.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3] ext4: avoid infinite loops caused by residual data
Date: Thu,  5 Mar 2026 20:10:56 +0800
X-OQ-MSGID: <20260305121055.426662-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <uweckkartekmwpzpt2kt34bbjyn3a2a4tc3lw7qyyghkxhfl5l@st7yfcuu73f4>
References: <uweckkartekmwpzpt2kt34bbjyn3a2a4tc3lw7qyyghkxhfl5l@st7yfcuu73f4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B9BF1211615
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79483-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,qq.com,vger.kernel.org,syzkaller.appspotmail.com,googlegroups.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,1659aaaaa8d9d11265d7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 11:38:00 +0100 Jan Kara wrote:
> > On the mkdir/mknod path, when mapping logical blocks to physical blocks,
> > if inserting a new extent into the extent tree fails (in this example,
> > because the file system disabled the huge file feature when marking the
> > inode as dirty),
> 
> I don't quite understand what you mean here but I think you say that
> ext4_ext_dirty() -> ext4_mark_inode_dirty() returns error due to whatever
> corruption it has hit.
It returns -EFSCORRUPTED in following calltrace: 
ext4_ext_dirty()->
  ext4_mark_inode_dirty()->
    __ext4_mark_inode_dirty()->
      ext4_mark_iloc_dirty()->
        ext4_do_update_inode()->
	  ext4_fill_raw_inode()->
	    ext4_inode_blocks_set()->
	      if (!ext4_has_feature_huge_file(sb))
	          return -EFSCORRUPTED;
> 
> > ext4_ext_map_blocks() only calls ext4_free_blocks() to
> > reclaim the physical block without deleting the corresponding data in
> > the extent tree. This causes subsequent mkdir operations to reference
> > the previously reclaimed physical block number again, even though this
> > physical block is already being used by the xattr block. Therefore, a
> > situation arises where both the directory and xattr are using the same
> > buffer head block in memory simultaneously.
> 
> OK, this indeed looks like "not so great" error handling. Thanks for
> digging into this.
> 
> > The above causes ext4_xattr_block_set() to enter an infinite loop about
> > "inserted" and cannot release the inode lock, ultimately leading to the
> > 143s blocking problem mentioned in [1].
> >
> > By using ext4_ext_remove_space() to delete the inserted logical block
> > and reclaim the physical block when inserting a new extent fails during
> > extent block mapping, residual extent data can be prevented from affecting
> > subsequent logical block physical mappings.
> >
> > [1]
> > INFO: task syz.0.17:5995 blocked for more than 143 seconds.
> > Call Trace:
> >  inode_lock_nested include/linux/fs.h:1073 [inline]
> >  __start_dirop fs/namei.c:2923 [inline]
> >  start_dirop fs/namei.c:2934 [inline]
> >
> > Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=1659aaaaa8d9d11265d7
> > Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> > Reported-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
> > Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> ...
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index ae3804f36535..0bed3379f2d2 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -4458,19 +4458,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
> >  	if (IS_ERR(path)) {
> >  		err = PTR_ERR(path);
> >  		if (allocated_clusters) {
> > -			int fb_flags = 0;
> > -
> >  			/*
> >  			 * free data blocks we just allocated.
> >  			 * not a good idea to call discard here directly,
> >  			 * but otherwise we'd need to call it every free().
> >  			 */
> >  			ext4_discard_preallocations(inode);
> > -			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
> > -				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
> > -			ext4_free_blocks(handle, inode, NULL, newblock,
> > -					 EXT4_C2B(sbi, allocated_clusters),
> > -					 fb_flags);
> > +			ext4_ext_remove_space(inode, newex.ee_block, newex.ee_block);
> 
> So I'm concerned that if the metadata is corrupted, then trying to remove
> some extent space can do even more harm. Also in case
> EXT4_GET_BLOCKS_DELALLOC_RESERVE was passed, we now wrongly update quota
> information. So this definitely isn't a correct fix. What I'd do instead
> would be distinguishing two cases:
> 
> 1) The error is ENOSPC or EDQUOT - in this case the filesystem is fully
> consistent and we must maintain its consistency including all the
> accounting. However these errors can happen only early before we've
> inserted the extent into the extent tree. So current code works correctly
> for this case.
> 
> 2) Some other error - this means metadata is corrupted. We should strive to
> do as few modifications as possible to limit damage. So I'd just skip
> freeing of allocated blocks.
> 
> Long story short I think we should just modify the above condition:
> 
> 	if (allocated_clusters)
> 
> to
> 
> 	/*
> 	 * Gracefully handle out of space conditions. If the filesystem is
> 	 * inconsistent, we'll just leak allocated blocks to avoid causing
> 	 * even more damage.
> 	 */
> 	if (allocated_clusters && (err == -EDQUOT || err == -ENOSPC))
I have tested the modified code, and now it no longer deletes any data
for the -EFSCORRUPTED error (before applying my patch, it only deleted
the physical block and not the corresponding data in the extent tree).
This also prevents conflicts caused by data being reused by dir and
xattr.

I will release a new patch later to add the filtering you requested.

BR,
Edward


