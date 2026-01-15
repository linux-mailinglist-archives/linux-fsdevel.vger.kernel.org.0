Return-Path: <linux-fsdevel+bounces-73872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CFFD224FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 04:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F22302BA4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB77F2BD59C;
	Thu, 15 Jan 2026 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTxM/Hu9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB4200113
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768448076; cv=none; b=rLKti+HFWE9F9HjYEwoQ5OqmYvKPXN+dtv09YmT0u6ffSvl7gp89qzlQO6ArrxowREN5dk1kk4ct8D2qf9JpERNZXBb4U+Ihi7YhpCnHAV45f7Vbd+Q3II8/tWp3vf5pbtsQHHfE29YzjstFCsz89/LpZliNheaUZf8sGhJlMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768448076; c=relaxed/simple;
	bh=TgVo0YpssYH9bEiZz1EwIQbCyPcuH1+ffxTaU/WHhmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE+tLIPkkom8l0+mqD0XGBbCtmHrmMRVpW03ghjyO3ZXNII41RNwe8tQgxDHLepKOfyQjaZFUy3DFqKCn/o6DgJGz4ofVQ2VRO7e5kT5FArtZwRxWlHkzZpUNeHU3ftXqun+blhFoMFTwPy5DGRv9vY/Lwiakk8zoOwF/OG+dUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTxM/Hu9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81e9d0cd082so380799b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 19:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768448074; x=1769052874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxjY31Wg2k8545z5USR1MFEogPbC/XcNxb3Lodh6pgk=;
        b=MTxM/Hu9FrgIEQceOqabvaGxUeSDTB0WZfAxuW0my50cJ4DN7R8RufjSSbdiay31wp
         5rWsWgdaofEg5rzQ2xA7w/iSTonGUqSadFvsr/KgpP5TE6XNMTIywSq403/4aXeYqElA
         hwMHvN08mtzRGsCWJQJOjCzfYngTAnDDa7Icx0fgUPR7XKLug/QDI+Bau8b9+QI9mZ4F
         oc3HcmaVDFBQw79llRNNYGPwOzxtAXqQ8qAcM5oxOjsjtr8cjVsQJnMyTjdVUALPMFTA
         RgEO7I7YiWKtcQtnVCw9JZYPuzD9ERB1wNOjCkztSQAnPJP+xGvGAafLO2jUXqZTwqod
         IFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768448074; x=1769052874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxjY31Wg2k8545z5USR1MFEogPbC/XcNxb3Lodh6pgk=;
        b=PzUlkR8+nJDiKeH6qrf9/UEoKX+tnv5rgjTG96p1RXLskhKV81M9Y7GcVuEU4jravP
         jI5jCrzWcY0td5EKumjweRRwSArp4ba7l6W9Gib/ZwKivVt/zwzVhIjRAYQtYkP2FG5c
         v9nzFZ+0E5YzkuNS7ws+MPZY1RE+LV3mEYdRXjgRk/iDEASYQl46o8qmrbJIeAzbrMVE
         I4s9Iwcz5AOTTiHzwgyTWGEGSr/+gO3FohH840lfzwHRzwQkQN1UYnr7uR4JBCjhG3XH
         +dOEhMRgcrwqo4VYtRgY2GdawH05ABODagkMMouN3OqJHAeIe/Dj0wX1WPombHSrGw9Z
         /rkA==
X-Forwarded-Encrypted: i=1; AJvYcCXV44EvQEeihiYmpxJUK/BsDECrE9Gmh3lfq+Fj69x23oXVW4JoKsct96I8qZtunxQK6o9qIdSHnw2A95Rj@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmF4EJ+i/1fX6+sBz5mDpP3PJwbS1Ts1seX4bjn06x0jOr/40
	dIa7ohE4osJy4KSquYGnP88kXTnQ3TtfVMXo+y6q6gv0QMxDfIAtStYD
X-Gm-Gg: AY/fxX4sBDcW2SAT5xIA18DUZbqmaTGEuAsBjVduMGkHTSXd7Zge9LgCErrX6orfOab
	kMRE7OA7oWXVIy3eaQdViKIavNWdKTdGiyd28Xr8BYDfTEHqEbIZC2GHIAWpkY2OGrhFkIWeiWB
	CKyTy73bCSV7/SLO6Ebg8jzYz3Dw3hhrA0fSYPr6uKGc3oJfd7IEQfwfrb/VVdCVNK5nRIUI6EX
	NFVVj+FlrxFHGbTscwi8y5a+OL+MMHLLQjyBxTIMVIWTUWdsVGhRyFeMAivgGTZPhBfZ1t56i7L
	Q2XfQsZPJ5r1rnWEJPpzbIS/FKX171nNkt1Dww0blh3yjPjOWEBVPHGgRlGfHzKUVzsTqh9Ekz7
	AsSNaLJuNARcM8TKsCCLW00jXyXrnF+HonrOa/13N2rp0nj2CkcDgjgdNbgUD35GQKbKLomAIUj
	vTi7GQYt46VReZs2ePUoGNM72m9A==
X-Received: by 2002:a05:6a00:8011:b0:81f:38f4:d774 with SMTP id d2e1a72fcca58-81f81d0d522mr4395523b3a.27.1768448074036;
        Wed, 14 Jan 2026 19:34:34 -0800 (PST)
Received: from localhost ([45.142.165.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e676ca8sm931045b3a.50.2026.01.14.19.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 19:34:33 -0800 (PST)
Date: Thu, 15 Jan 2026 11:34:29 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com" <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Subject: Re: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
Message-ID: <aWhgNujuXujxSg3E@ndev>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
 <20260113081952.2431735-1-wangjinchao600@gmail.com>
 <a2b8144a25206fba69e59e805d93c05444080132.camel@ibm.com>
 <aWcHhTiUrDppotRg@ndev>
 <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d382b5c97a71d769598fd32bc22cae9f960fea70.camel@ibm.com>

On Wed, Jan 14, 2026 at 07:29:45PM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2026-01-14 at 11:03 +0800, Jinchao Wang wrote:
> > On Tue, Jan 13, 2026 at 08:52:45PM +0000, Viacheslav Dubeyko wrote:
> > > On Tue, 2026-01-13 at 16:19 +0800, Jinchao Wang wrote:
> > > > syzbot reported a hung task in hfs_mdb_commit where a deadlock occurs
> > > > between the MDB buffer lock and the folio lock.
> > > > 
> > > > The deadlock happens because hfs_mdb_commit() holds the mdb_bh
> > > > lock while calling sb_bread(), which attempts to acquire the lock
> > > > on the same folio.
> > > 
> > > I don't quite to follow to your logic. We have only one sb_bread() [1] in
> > > hfs_mdb_commit(). This read is trying to extract the volume bitmap. How is it
> > > possible that superblock and volume bitmap is located at the same folio? Are you
> > > sure? Which size of the folio do you imply here?
> > > 
> > > Also, it your logic is correct, then we never could be able to mount/unmount or
> > > run any operations on HFS volumes because of likewise deadlock. However, I can
> > > run xfstests on HFS volume.
> > > 
> > > [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L324  
> > 
> > Hi Viacheslav,
> > 
> > After reviewing your feedback, I realized that my previous RFC was not in
> > the correct format. It was not intended to be a final, merge-ready patch,
> > but rather a record of the analysis and trial fixes conducted so far.
> > I apologize for the confusion caused by my previous email.
> > 
> > The details are reorganized as follows:
> > 
> > - Observation
> > - Analysis
> > - Verification
> > - Conclusion
> > 
> > Observation
> > ============
> > 
> > Syzbot report: https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2  
> > 
> > For this version:
> > > time             |  kernel    | Commit       | Syzkaller |
> > > 2025/12/20 17:03 | linux-next | cc3aa43b44bd | d6526ea3  |
> > 
> > Crash log: https://syzkaller.appspot.com/text?tag=CrashLog&x=12909b1a580000  
> > 
> > The report indicates hung tasks within the hfs context.
> > 
> > Analysis
> > ========
> > In the crash log, the lockdep information requires adjustment based on the call stack.
> > After adjustment, a deadlock is identified:
> > 
> > task syz.1.1902:8009
> > - held &disk->open_mutex
> > - held foio lock
> > - wait lock_buffer(bh)
> > Partial call trace:
> > ->blkdev_writepages()
> >         ->writeback_iter()
> >                 ->writeback_get_folio()
> >                         ->folio_lock(folio)
> >         ->block_write_full_folio()
> >                 __block_write_full_folio()
> >                         ->lock_buffer(bh)
> > 
> > task syz.0.1904:8010
> > - held &type->s_umount_key#66 down_read
> > - held lock_buffer(HFS_SB(sb)->mdb_bh);
> > - wait folio
> > Partial call trace:
> > hfs_mdb_commit
> >         ->lock_buffer(HFS_SB(sb)->mdb_bh);
> >         ->bh = sb_bread(sb, block);
> >                 ...->folio_lock(folio)
> > 
> > 
> > Other hung tasks are secondary effects of this deadlock. The issue
> > is reproducible in my local environment usuing the syz-reproducer.
> > 
> > Verification
> > ==============
> > 
> > Two patches are verified against the syz-reproducer.
> > Neither reproduce the deadlock.
> > 
> > Option 1: Removing `un/lock_buffer(HFS_SB(sb)->mdb_bh)`
> > ------------------------------------------------------
> > 
> > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > index 53f3fae60217..c641adb94e6f 100644
> > --- a/fs/hfs/mdb.c
> > +++ b/fs/hfs/mdb.c
> > @@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
> >         if (sb_rdonly(sb))
> >                 return;
> > 
> > -       lock_buffer(HFS_SB(sb)->mdb_bh);
> >         if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
> >                 /* These parameters may have been modified, so write them back */
> >                 mdb->drLsMod = hfs_mtime();
> > @@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
> >                         size -= len;
> >                 }
> >         }
> > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> >  }
> > 
> > 
> > Options 2: Moving `unlock_buffer(HFS_SB(sb)->mdb_bh)`
> > --------------------------------------------------------
> > 
> > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > index 53f3fae60217..ec534c630c7e 100644
> > --- a/fs/hfs/mdb.c
> > +++ b/fs/hfs/mdb.c
> > @@ -309,6 +309,7 @@ void hfs_mdb_commit(struct super_block *sb)
> >                 sync_dirty_buffer(HFS_SB(sb)->alt_mdb_bh);
> >         }
> >  
> > +       unlock_buffer(HFS_SB(sb)->mdb_bh);
> >         if (test_and_clear_bit(HFS_FLG_BITMAP_DIRTY, &HFS_SB(sb)->flags)) {
> >                 struct buffer_head *bh;
> >                 sector_t block;
> > @@ -340,7 +341,6 @@ void hfs_mdb_commit(struct super_block *sb)
> >                         size -= len;
> >                 }
> >         }
> > -       unlock_buffer(HFS_SB(sb)->mdb_bh);
> >  }
> > 
> > Conclusion
> > ==========
> > 
> > The analysis and verification confirms that the hung tasks are caused by
> > the deadlock between `lock_buffer(HFS_SB(sb)->mdb_bh)` and `sb_bread(sb, block)`.
> 
> First of all, we need to answer this question: How is it
> possible that superblock and volume bitmap is located at the same folio or
> logical block? In normal case, the superblock and volume bitmap should not be
> located in the same logical block. It sounds to me that you have corrupted
> volume and this is why this logic [1] finally overlap with superblock location:
> 
> block = be16_to_cpu(HFS_SB(sb)->mdb->drVBMSt) + HFS_SB(sb)->part_start;
> off = (block << HFS_SECTOR_SIZE_BITS) & (sb->s_blocksize - 1);
> block >>= sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS;
> 
> I assume that superblock is corrupted and the mdb->drVBMSt [2] has incorrect
> metadata. As a result, we have this deadlock situation. The fix should be not
> here but we need to add some sanity check of mdb->drVBMSt somewhere in
> hfs_fill_super() workflow.
> 
> Could you please check my vision?
> 
> Thanks,
> Slava.
> 
> [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/hfs/mdb.c#L318
> [2]
> https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/hfs_common.h#L196

Hi Slava,

I have traced the values during the hang. Here are the values observed:

- MDB: blocknr=2
- Volume Bitmap (drVBMSt): 3
- s_blocksize: 512 bytes

This confirms a circular dependency between the folio lock and
the buffer lock. The writeback thread holds the 4KB folio lock and 
waits for the MDB buffer lock (block 2). Simultaneously, the HFS sync 
thread holds the MDB buffer lock and waits for the same folio lock 
to read the bitmap (block 3).


Since block 2 and block 3 share the same folio, this locking 
inversion occurs. I would appreciate your thoughts on whether 
hfs_fill_super() should validate drVBMSt to ensure the bitmap 
does not reside in the same folio as the MDB.

