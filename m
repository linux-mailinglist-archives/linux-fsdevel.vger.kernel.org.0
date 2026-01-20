Return-Path: <linux-fsdevel+bounces-74561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BBAD3BCBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 02:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97B52300A50F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 01:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B5C1F4606;
	Tue, 20 Jan 2026 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu9+YTZ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7B1C1F02
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871378; cv=none; b=OQpMrP1SA0y/VufQLxf6SvWaejsEaDOMnbJEeImd3jm2LLDlYQvAxqT8XTHOB6YDx+W7Vfv3+Np7c6XyIlX8lUsDa5HkV/iPenvKZ/fekWt8uoMrgeLbpUPkVc7o1hq/y4zveImp8Erw4FiydrqHjMhU7Vl7IyNCseFV301t+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871378; c=relaxed/simple;
	bh=xHEYh54sp2QgmyR/etWXWKhptaI9QZNSAcAN1hUjLZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0Em3Ex/RQsc9Y2Ue7pDpDhquXH/HFg5kcHgeR0F1ccuf8WSqnYZ5CgmEuXT4E+P/awUo27En/rWR6hbAifrRMllcccX6vikSLd1yjdaYiYWTBF58zKI88SDR/+D+WEghryo3eAg96TNC+AF4oyt83MbdMBCz0rjHl/z2DXrgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu9+YTZ9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34b75fba315so2358680a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 17:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768871376; x=1769476176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VnwBBxQbdEWEB5GZjWEywyzzqEs4JvuW16NkF6mHIxk=;
        b=mu9+YTZ92K8PvVGivVIPuA4bxtaGNksgewj6dcMpeT/KxaBtfDDM4Neua8zYY/jZ+X
         gdFerfFlVioaJpKErdIX2J001IVCWNMIdHL6ZVNiZTjDVYtzWBRKnfzySPrw2WrhyF3+
         ncDVaKARUJw8Na44kdgZ9OIrlm3RsVPQaVc7IM72BS8iRYRDvx8P564GNioNaPYAbiT+
         1bqQBeKVoGc517Lmico2mA3y1tKFsAw+xZzdRidre0Bpb/QwTfgGUkAP7ADdSyHItsqh
         XG7EG7O+mmdj6VTEgfkuxnjkeCTJqacc2pMYmZVeeWEgqtpHrxFWWEjFCt6U2tyZK9yW
         Lftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768871376; x=1769476176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnwBBxQbdEWEB5GZjWEywyzzqEs4JvuW16NkF6mHIxk=;
        b=QmPKnPWsyOX04P75H0cNOOwTdGkDXQYyLErIHm5OxDMq4rfq+CdW/U5/2ubI/tARUB
         BD4/DhzSk1A7LyNSMOCQHuQDkZXFlRZG6+Lyl54/M9Yswe/rOboenr7UHmcMYR7hnUXh
         nWtbuBCeSzbbTsY5fI+zoXwq9ymVn+eEPpIU4c5rqvyEC6JduhqQBBuJqYueNJho9vhB
         e0DtS9DhK28khEhy/AFzRLaeA2vspGr6glXDyb5DLM8Et8STX219EbvDsus3EMiGCIKS
         SGhiMiWhix5snoaCRLlu7NmHcunmNyPdKM6QaUcWkb/LsR4dEQRMARaktRxLLpCXfgyI
         b5rA==
X-Forwarded-Encrypted: i=1; AJvYcCVkXPBCvy4FmVKq9rSidTi5fFKU/Jl+86WprBXbTNdXKC82BhUBDGjzVMotCb5zViJ118N/MxPsfnoeZJlQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNBF73+kB3bSDBMA91VlzEiZH9WZePBv2gemqObjh8GuQPWAS
	NJfWyf0CFbY85R8kA9v9jWDvf0d9CWBHSBnKu4uNcsJK7JuxdfB2yaFh
X-Gm-Gg: AZuq6aI6w2sea9epqa8+K4LEAs8YVgimuyoMcyFeCLxLdnwhVoNgrH96lrVFtrjBfNL
	JzWXjnFMAQpbEmEdAEwESgF+gpajC7tR6cmH88RA/kqXlNW/o3zCT58wfls20v3Zc7PDXMqQYS2
	0mtAK6tDs5MKoyXHvAPweXmUOMKrNwg1cdAyQzOeHfBty//G75k1a6BNGB8zr4D0lSvmKG4v/A9
	MVZZTnLEQrRDtkqd/l/CdaMO+SQ+wOLft9iwYTZeXotr3ZEHXHygq/QIcIDVYwvbyMsIChtBAlb
	xbdKGuJKZfYFzpXOL8oa1Kdd5wQE5cbkSA/PKTu+3ZDoZSQ6PjyXm+dFksjAgrUht+8Tlj5l953
	l8WJ2pa6H1apP+xYwsrVthGyS4LSYt4hjPjAB77prar3zt1BTSfZhEPCKJHl4c06hds8I3FNzoX
	0E
X-Received: by 2002:a17:90b:4d8d:b0:34a:e9b:26b1 with SMTP id 98e67ed59e1d1-35272fb86b4mr11991116a91.26.1768871375558;
        Mon, 19 Jan 2026 17:09:35 -0800 (PST)
Received: from localhost ([2a12:a305:4::4073])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678af465sm12579931a91.11.2026.01.19.17.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:09:34 -0800 (PST)
Date: Tue, 20 Jan 2026 09:09:31 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com" <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Subject: Re: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
Message-ID: <aW7Vy_RpxseBC4UQ@ndev>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
 <20260113081952.2431735-1-wangjinchao600@gmail.com>
 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
 <aWcHhTiUrDppotRg@ndev>
 <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>
 <aWhgNujuXujxSg3E@ndev>
 <b718505beca70f2a3c1e0e20c74e43ae558b29d5.camel@ibm.com>
 <aWnybRfDcsUAtsol@ndev>
 <0349430786e4553845c30490e19b08451c8b999f.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0349430786e4553845c30490e19b08451c8b999f.camel@ibm.com>

On Mon, Jan 19, 2026 at 06:09:16PM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2026-01-16 at 16:10 +0800, Jinchao Wang wrote:
> > On Thu, Jan 15, 2026 at 09:12:49PM +0000, Viacheslav Dubeyko wrote:
> > > On Thu, 2026-01-15 at 11:34 +0800, Jinchao Wang wrote:
> > > > On Wed, Jan 14, 2026 at 07:29:45PM +0000, Viacheslav Dubeyko wrote:
> > > > > On Wed, 2026-01-14 at 11:03 +0800, Jinchao Wang wrote:
> > > > > > On Tue, Jan 13, 2026 at 08:52:45PM +0000, Viacheslav Dubeyko wrote:
> > > > > > > On Tue, 2026-01-13 at 16:19 +0800, Jinchao Wang wrote:
> > > > > > > > syzbot reported a hung task in hfs_mdb_commit where a deadlock occurs
> > > > > > > > between the MDB buffer lock and the folio lock.
> > > > > > > > 
> > > > > > > > The deadlock happens because hfs_mdb_commit() holds the mdb_bh
> > > > > > > > lock while calling sb_bread(), which attempts to acquire the lock
> > > > > > > > on the same folio.
> > > > > > > 
> > > > > > > I don't quite to follow to your logic. We have only one sb_bread() [1] in
> > > > > > > hfs_mdb_commit(). This read is trying to extract the volume bitmap. How is it
> > > > > > > possible that superblock and volume bitmap is located at the same folio? Are you
> > > > > > > sure? Which size of the folio do you imply here?
> > > > > > > 
> > > > > > > Also, it your logic is correct, then we never could be able to mount/unmount or
> > > > > > > run any operations on HFS volumes because of likewise deadlock. However, I can
> > > > > > > run xfstests on HFS volume.
> > > > > > > 
> > > > > > > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L324      
> > > > > > 
> > > > > > Hi Viacheslav,
> > > > > > 
> > > > > > After reviewing your feedback, I realized that my previous RFC was not in
> > > > > > the correct format. It was not intended to be a final, merge-ready patch,
> > > > > > but rather a record of the analysis and trial fixes conducted so far.
> > > > > > I apologize for the confusion caused by my previous email.
> > > > > > 
> > > > > > The details are reorganized as follows:
> > > > > > 
> > > > > > - Observation
> > > > > > - Analysis
> > > > > > - Verification
> > > > > > - Conclusion
> > > > > > 
> > > > > > Observation
> > > > > > ============
> > > > > > 
> > > > > > Syzbot report: https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2      
> > > > > > 
> > > > > > For this version:
> > > > > > > time             |  kernel    | Commit       | Syzkaller |
> > > > > > > 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |
> > > > > > 
> > > > > > Crash log: https://syzkaller.appspot.com/text?tag=CrashLog&x=12909b1a580000      
> > > > > > 
> > > > > > The report indicates hung tasks within the hfs context.
> > > > > > 
> > > > > > Analysis
> > > > > > ========
> > > > > > In the crash log, the lockdep information requires adjustment based on the call stack.
> > > > > > After adjustment, a deadlock is identified:
> > > > > > 
> > > > > > task syz.1.1902:8009
> > > > > > - held &disk->open_mutex
> > > > > > - held foio lock
> > > > > > - wait lock_buffer(bh)
> > > > > > Partial call trace:
> > > > > > ->blkdev_writepages()
> > > > > >         ->writeback_iter()
> > > > > >                 ->writeback_get_folio()
> > > > > >                         ->folio_lock(folio)
> > > > > >         ->block_write_full_folio()
> > > > > >                 __block_write_full_folio()
> > > > > >                         ->lock_buffer(bh)
> > > > > > 
> > > > > > task syz.0.1904:8010
> > > > > > - held &type->s_umount_key#66 down_read
> > > > > > - held lock_buffer(HFS_SB(sb)->mdb_bh);
> > > > > > - wait folio
> > > > > > Partial call trace:
> > > > > > hfs_mdb_commit
> > > > > >         ->lock_buffer(HFS_SB(sb)->mdb_bh);
> > > > > >         ->bh = sb_bread(sb, block);
> > > > > >                 ...->folio_lock(folio)
> > > > > > 
> > > > > > 
> > > > > > Other hung tasks are secondary effects of this deadlock. The issue
> > > > > > is reproducible in my local environment usuing the syz-reproducer.
> > > > > > 
> > > > > > Verification
> > > > > > ==============
> > > > > > 
> > > > > > Two patches are verified against the syz-reproducer.
> > > > > > Neither reproduce the deadlock.
> > > > > > 
> > > > > > Option 1: Removing `un/lock_buffer(HFS_SB(sb)->mdb_bh)`
> > > > > > ------------------------------------------------------
> > > > > > 
> > > > > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > > > > index 53f3fae60217..c641adb94e6f 100644
> > > > > > --- a/fs/hfs/mdb.c
> > > > > > +++ b/fs/hfs/mdb.c
> > > > > > @@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > > > >         if (sb_rdonly(sb))
> > > > > >                 return;
> > > > > > 
> > > > > > -       lock_buffer(HFS_SB(sb)->mdb_bh);
> > > > > >         if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
> > > > > >                 /* These parameters may have been modified, so write them back */
> > > > > >                 mdb->drLsMod = hfs_mtime();
> > > > > > @@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > > > >                         size -= len;
> > > > > >                 }
> > > > > >         }
> > > > > > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > > > >  }
> > > > > > 
> > > > > > 
> > > > > > Options 2: Moving `unlock_buffer(HFS_SB(sb)->mdb_bh)`
> > > > > > --------------------------------------------------------
> > > > > > 
> > > > > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > > > > index 53f3fae60217..ec534c630c7e 100644
> > > > > > --- a/fs/hfs/mdb.c
> > > > > > +++ b/fs/hfs/mdb.c
> > > > > > @@ -309,6 +309,7 @@ void hfs_mdb_commit(struct super_block *sb)
> > > > > >                 sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
> > > > > >         }
> > > > > >  
> > > > > > +       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > > > >         if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)->flags)) {
> > > > > >                 struct buffer_head *bh;
> > > > > >                 sector_t block;
> > > > > > @@ -340,7 +341,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > > > > >                         size -= len;
> > > > > >                 }
> > > > > >         }
> > > > > > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> > > > > >  }
> > > > > > 
> > > > > > Conclusion
> > > > > > ==========
> > > > > > 
> > > > > > The analysis and verification confirms that the hung tasks are caused by
> > > > > > the deadlock between `lock_buffer(HFS_SB(sb)->mdb_bh)` and `sb_bread(sb, block)`.
> > > > > 
> > > > > First of all, we need to answer this question: How is it
> > > > > possible that superblock and volume bitmap is located at the same folio or
> > > > > logical block? In normal case, the superblock and volume bitmap should not be
> > > > > located in the same logical block. It sounds to me that you have corrupted
> > > > > volume and this is why this logic [1] finally overlap with superblock location:
> > > > > 
> > > > > block = be16_to_cpu(HFS_SB(sb)->mdb->drVBMSt) + HFS_SB(sb)->part_start;
> > > > > off = (block << HFS_SECTOR_SIZE_BITS) & (sb->s_blocksize - 1);
> > > > > block >>= sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS;
> > > > > 
> > > > > I assume that superblock is corrupted and the mdb->drVBMSt [2] has incorrect
> > > > > metadata. As a result, we have this deadlock situation. The fix should be not
> > > > > here but we need to add some sanity check of mdb->drVBMSt somewhere in
> > > > > hfs_fill_super() workflow.
> > > > > 
> > > > > Could you please check my vision?
> > > > > 
> > > > > Thanks,
> > > > > Slava.
> > > > > 
> > > > > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L318    
> > > > > [2]
> > > > > https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/hfs_common.h#L196    
> > > > 
> > > > Hi Slava,
> > > > 
> > > > I have traced the values during the hang. Here are the values observed:
> > > > 
> > > > - MDB: blocknr=2
> > > > - Volume Bitmap (drVBMSt): 3
> > > > - s_blocksize: 512 bytes
> > > > 
> > > > This confirms a circular dependency between the folio lock and
> > > > the buffer lock. The writeback thread holds the 4KB folio lock and 
> > > > waits for the MDB buffer lock (block 2). Simultaneously, the HFS sync 
> > > > thread holds the MDB buffer lock and waits for the same folio lock 
> > > > to read the bitmap (block 3).
> > > > 
> > > > 
> > > > Since block 2 and block 3 share the same folio, this locking 
> > > > inversion occurs. I would appreciate your thoughts on whether 
> > > > hfs_fill_super() should validate drVBMSt to ensure the bitmap 
> > > > does not reside in the same folio as the MDB.
> > > 
> > > 
> > > As far as I can see, I can run xfstest on HFS volume (for example, generic/001
> > > has been finished successfully):
> > > 
> > > sudo ./check -g auto -E ./my_exclude.txt 
> > > FSTYP         -- hfs
> > > PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #56 SMP
> > > PREEMPT_DYNAMIC Thu Jan 15 12:55:22 PST 2026
> > > MKFS_OPTIONS  -- /dev/loop51
> > > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> > > 
> > > generic/001 36s ...  36s
> > > 
> > > 2026-01-15T13:00:07.589868-08:00 hfsplus-testing-0001 kernel: run fstests
> > > generic/001 at 2026-01-15 13:00:07
> > > 2026-01-15T13:00:07.661605-08:00 hfsplus-testing-0001 systemd[1]: Started
> > > fstests-generic-001.scope - /usr/bin/bash -c "test -w /proc/self/oom_score_adj
> > > && echo 250 > /proc/self/oom_score_adj; exec ./tests/generic/001".
> > > 2026-01-15T13:00:13.355795-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> > > 2026-01-15T13:00:13.355809-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():348 drVBMSt 3, part_start 0, off 0, block 3, size 8167
> > > 2026-01-15T13:00:13.355810-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355810-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355811-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355812-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355813-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355814-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355814-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355815-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355816-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355817-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355818-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355819-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355820-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355820-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355821-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.355822-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.355822-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> > > 2026-01-15T13:00:13.681527-08:00 hfsplus-testing-0001 systemd[1]: fstests-
> > > generic-001.scope: Deactivated successfully.
> > > 2026-01-15T13:00:13.681597-08:00 hfsplus-testing-0001 systemd[1]: fstests-
> > > generic-001.scope: Consumed 5.928s CPU time.
> > > 2026-01-15T13:00:13.714928-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> > > 2026-01-15T13:00:13.714942-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():348 drVBMSt 3, part_start 0, off 0, block 3, size 8167
> > > 2026-01-15T13:00:13.714943-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714944-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714945-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714945-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714946-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714946-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714947-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714948-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714949-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714949-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714950-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714951-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714951-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714952-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714953-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714954-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714954-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():356 start read volume bitmap block
> > > 2026-01-15T13:00:13.714955-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():370 volume bitmap block has been read and copied
> > > 2026-01-15T13:00:13.714956-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> > > 2026-01-15T13:00:13.716742-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():296 HFS_SB(sb)->mdb_bh buffer has been locked
> > > 2026-01-15T13:00:13.716754-08:00 hfsplus-testing-0001 kernel: hfs:
> > > hfs_mdb_commit():383 HFS_SB(sb)->mdb_bh buffer has been unlocked
> > > 2026-01-15T13:00:13.722184-08:00 hfsplus-testing-0001 systemd[1]: mnt-
> > > test.mount: Deactivated successfully.
> > > 
> > > And I don't see any issues with locking into the added debug output. I don't see
> > > the reproduction of reported deadlock. And the logic of hfs_mdb_commit() correct
> > > enough.
> > > 
> > > The main question is: how blkdev_writepages() can collide with hfs_mdb_commit()?
> > > I assume that blkdev_writepages() is trying to flush the user data. So, what is
> > > the problem here? Is it allocation issue? Does it mean that some file was not
> > > properly allocated? Or does it mean that superblock commit somehow collided with
> > > user data flush? But how does it possible? Which particular workload could have
> > > such issue?
> > > 
> > > Currently, your analysis doesn't show what problem is and how it is happened. 
> > > 
> > > Thanks,
> > > Slava.
> > 
> > Hi Slava,
> > 
> > Thank you very much for your feedback and for taking the time to 
> > review this. I apologize if my previous analysis was not clear 
> > enough. As I am relatively new to this area, I truly appreciate 
> > your patience.
> > 
> > After further tracing, I would like to share more details on how the 
> > collision between blkdev_writepages() and hfs_mdb_commit() occurs. 
> > It appears to be a timing-specific race condition.
> > 
> > 1. Physical Overlap (The "How"):
> > In my environment, the HFS block size is 512B and the MDB is located 
> > at block 2 (offset 1024). Since 1024 < 4096, the MDB resides 
> > within the block device's first folio (index 0). 
> > Consequently, both the filesystem layer (via mdb_bh) and the block 
> > layer (via bdev mapping) operate on the exact same folio at index 0.
> > 
> > 2. The Race Window (The "Why"):
> > The collision is triggered by the global nature of ksys_sync(). In 
> > a system with multiple mounted devices, there is a significant time 
> > gap between Stage 1 (iterate_supers) and Stage 2 (sync_bdevs). This 
> > window allows a concurrent task to dirty the MDB folio after one 
> > sync task has already passed its FS-sync stage.
> > 
> > 3. Proposed Reproduction Timeline:
> > - Task A: Starts ksys_sync() and finishes iterate_supers() 
> >   for the HFS device. It then moves on to sync other devices.
> > - Task B: Creates a new file on HFS, then starts its 
> >   own ksys_sync().
> > - Task B: Enters hfs_mdb_commit(), calls lock_buffer(mdb_bh) and 
> >   mark_buffer_dirty(mdb_bh). This makes folio 0 dirty.
> > - Task A: Finally reaches sync_bdevs() for the HFS device. It sees 
> >   folio 0 is dirty, calls folio_lock(folio), and then attempts 
> >   to lock_buffer(mdb_bh) for I/O.
> > - Task A: Blocks waiting for mdb_bh lock (held by Task B).
> > - Task B: Continues hfs_mdb_commit() -> sb_bread(), which attempts 
> >   to lock folio 0 (held by Task A).
> > 
> > This results in an AB-BA deadlock between the Folio Lock and the 
> > Buffer Lock.
> > 
> > I hope this clarifies why the collision is possible even though 
> > hfs_mdb_commit() seems correct in isolation. It is the concurrent 
> > interleaving of FS-level and BDEV-level syncs that triggers the 
> > violation of the Folio -> Buffer locking order.
> > 
> > I would be very grateful for your thoughts on this updated analysis.
> > 
> > 
> 
> Firs of all, I've tried to check the syzbot report that you are mentioning in
> the patch. And I was confused because it was report for FAT. So, I don't see the
> way how I can reproduce the issue on my side.
> 
> Secondly, I need to see the real call trace of the issue. This discussion
> doesn't make sense without the reproduction path and the call trace(s) of the
> issue.
> 
> Thanks,
> Slava.
There are many crash in the syz report page, please follow the specified time and version.

Syzbot report: https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2

For this version:
| time             |  kernel    | Commit       | Syzkaller |
| 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |

The full call trace can be found in the crash log of "2025/12/20 17:03", which url is:

Crash log: https://syzkaller.appspot.com/text?tag=CrashLog&x=12909b1a580000

-- 
Thanks,
Jinchao

