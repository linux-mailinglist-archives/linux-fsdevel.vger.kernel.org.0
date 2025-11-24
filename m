Return-Path: <linux-fsdevel+bounces-69718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E8AC82B7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 23:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E266E3424F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 22:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92359343D6F;
	Mon, 24 Nov 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="BUWklEIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6F342C88
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023592; cv=none; b=MfvSWYwN0chLj6iP1YVNPObtKPIqq7Jl08e7UptgIRU6y5ZgQCLO12FMZABm5B3cLtz4Oe/GuBRtHh0x6/r45miVhtCTCoyzIcf0E26D6BG8ewNLCDEMBSShD2pCahlmFd6OHb6fDgiCD00G4tdpsyX38E3pQf3E3K8gcgw+J2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023592; c=relaxed/simple;
	bh=RWKvJ2vmxL2k+cHQZ1aHnSmdq8EtsmlbYRU3rauYvUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhVTtRJrdnfK4FA082eSQE1kwUcUQIbDycCJfmXYH/rQLaLbDqPNgyUlmPG9wA9i0stjsF8BsyCYC5ELXJnHjeOJvHrdiVZ4Cn53geL3ktvX+VTxR0RULfwJR6sTbMMur/HmSo2Iqp16sNOxbWFrHTcx7XUV8d+25/JOqcVP1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=BUWklEIy; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Mon, 24 Nov 2025 22:33:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1764023578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f638h1XgbGh1cJNAXbxbYgub04PT6qPlLCKNX5ATKI4=;
	b=BUWklEIyNxRrVgC8y/RKIXyz+3Q+Fg4p8auPabyy6INgAtpY8RYtxvGHjOVSouaNi2cELK
	1Pnbm5l2S+mkUEPEqV8T6DB4Dx1Lk4LJzy38FxJywaUVo+G6oaGCqYYgaRlbEVoHKIKlDu
	J5e1wZr+cLzFElAa3K54kqSm0EpMR0ectVtzamLxcB7U8O7lkSHYEqCrQ6whIjOhT5lwgZ
	N/qO8Z8zBRtpUKlt0Wr8Z8t/9LrU6cypWoFARE5BtLxc7XrYP7Na55Igt0HUuoa4ViQgfs
	pIRcnRf47aJ5nsgbGv+MHGntJ4dzF+6mTZrE9a3JKRjQpaVXfn9ZG8h3FEkODw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>,
	"linux-kernel-mentees@lists.linux.dev" <linux-kernel-mentees@lists.linux.dev>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
	"syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com" <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <aSTdK2m2TInzWW6_@Bertha>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
 <20251104014738.131872-3-contact@gvernon.com>
 <e13da4581ff5e8230fa5488f6e5d97695fc349b0.camel@ibm.com>
 <aRJ8uYyD0ydI8MUk@Bertha>
 <10acb67e66aa0b05ef2340178e761bafaab20af9.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10acb67e66aa0b05ef2340178e761bafaab20af9.camel@ibm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 12:48:28AM +0000, Viacheslav Dubeyko wrote:
> On Tue, 2025-11-11 at 00:00 +0000, George Anthony Vernon wrote:
> > On Tue, Nov 04, 2025 at 10:34:15PM +0000, Viacheslav Dubeyko wrote:
> > > On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> > > > hfs_read_inode previously did not validate CNIDs read from disk, thereby
> > > > allowing inodes to be constructed with disallowed CNIDs and placed on
> > > > the dirty list, eventually hitting a bug on writeback.
> > > > 
> > > > Validate reserved CNIDs according to Apple technical note TN1150.
> > > 
> > > The TN1150 technical note describes HFS+ file system and it needs to take into
> > > account the difference between HFS and HFS+. So, it is not completely correct
> > > for the case of HFS to follow to the TN1150 technical note as it is.
> > 
> > I've checked Inside Macintosh: Files Chapter 2 page 70 to make sure HFS
> > is the same (CNIDs 1 - 5 are assigned, and all of 1-15 are reserved).
> > I will add this to the commit message for V3.
> > 
> > > > 
> > > > This issue was discussed at length on LKML previously, the discussion
> > > > is linked below.
> > > > 
> > > > Syzbot tested this patch on mainline and the bug did not replicate.
> > > > This patch was regression tested by issuing various system calls on a
> > > > mounted HFS filesystem and validating that file creation, deletion,
> > > > reads and writes all work.
> > > > 
> > > > Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@    
> > > > I-love.SAKURA.ne.jp/T/
> > > > Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b    
> > > > Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > > > Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > > Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> > > > ---
> > > >  fs/hfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++-----------
> > > >  1 file changed, 53 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> > > > index 9cd449913dc8..bc346693941d 100644
> > > > --- a/fs/hfs/inode.c
> > > > +++ b/fs/hfs/inode.c
> > > > @@ -321,6 +321,38 @@ static int hfs_test_inode(struct inode *inode, void *data)
> > > >  	}
> > > >  }
> > > >  
> > > > +/*
> > > > + * is_valid_cnid
> > > > + *
> > > > + * Validate the CNID of a catalog record
> > > > + */
> > > > +static inline
> > > > +bool is_valid_cnid(u32 cnid, u8 type)
> > > > +{
> > > > +	if (likely(cnid >= HFS_FIRSTUSER_CNID))
> > > > +		return true;
> > > > +
> > > > +	switch (cnid) {
> > > > +	case HFS_ROOT_CNID:
> > > > +		return type == HFS_CDR_DIR;
> > > > +	case HFS_EXT_CNID:
> > > > +	case HFS_CAT_CNID:
> > > > +		return type == HFS_CDR_FIL;
> > > > +	case HFS_POR_CNID:
> > > > +		/* No valid record with this CNID */
> > > > +		break;
> > > > +	case HFS_BAD_CNID:
> > > 
> > > HFS is ancient file system that was needed to work with floppy disks. And bad
> > > sectors management was regular task and responsibility of HFS for the case of
> > > floppy disks (HDD was also not very reliable at that times). So, HFS implements
> > > the bad block management. It means that, potentially, Linux kernel could need to
> > > mount a file system volume that created by ancient Mac OS.
> > > 
> > > I don't think that it's correct management of HFS_BAD_CNID. We must to expect to
> > > have such CNID for the case of HFS.
> > > 
> > 
> > HFS_BAD_CNID is reserved for internal use of the filesystem
> > implementation. Since we never intend to use it, there is no correct
> > logical path that we should ever construct an inode with CNID 5. It does
> > not correspond to a record that the user can open, as it is a special
> > CNID used only for extent records used to mark blocks as allocated so
> > they are not used, a behaviour which we do not implement in the Linux
> > HFS or HFS+ drivers. Disallowing this CNID will not prevent correctly
> > formed filesystems from being mounted. I also don't think that
> > presenting an internal record-keeping structure to the VFS would make
> > sense or would be consistent with other filesystems.
> > 
> 
> Yes, we don't want to use it on Linux kernel side. But, potentially, the file
> for bad block management could or was been created/used on Mac OS side. And if
> anyone tries to mount the HFS volume with the bad block file, then we will
> refuse to mount it on the Linux kernel side. This is my main worry here. But it
> is not very probable situation, by the way.
> 
The mount operation only requires reading the root inode, so the
proposed change does not mean we would refuse to mount an HFS volume.

It is okay if HFS_BAD_CNID already exists in the btree, we simply won't
ever try to read or write it from disk.
> > > > +	case HFS_EXCH_CNID:
> > > > +		/* Not implemented */
> > > > +		break;
> > > > +	default:
> > > > +		/* Invalid reserved CNID */
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > >  /*
> > > >   * hfs_read_inode
> > > >   */
> > > > @@ -350,6 +382,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
> > > >  	rec = idata->rec;
> > > >  	switch (rec->type) {
> > > >  	case HFS_CDR_FIL:
> > > > +		if (!is_valid_cnid(rec->file.FlNum, HFS_CDR_FIL))
> > > > +			goto make_bad_inode;
> > > >  		if (!HFS_IS_RSRC(inode)) {
> > > >  			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
> > > >  					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
> > > > @@ -371,6 +405,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
> > > >  		inode->i_mapping->a_ops = &hfs_aops;
> > > >  		break;
> > > >  	case HFS_CDR_DIR:
> > > > +		if (!is_valid_cnid(rec->dir.DirID, HFS_CDR_DIR))
> > > > +			goto make_bad_inode;
> > > >  		inode->i_ino = be32_to_cpu(rec->dir.DirID);
> > > >  		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
> > > >  		HFS_I(inode)->fs_blocks = 0;
> > > > @@ -380,8 +416,12 @@ static int hfs_read_inode(struct inode *inode, void *data)
> > > >  		inode->i_op = &hfs_dir_inode_operations;
> > > >  		inode->i_fop = &hfs_dir_operations;
> > > >  		break;
> > > > +	make_bad_inode:
> > > > +		pr_warn("rejected cnid %lu. Volume is probably corrupted, try performing fsck.\n", inode->i_ino);
> > > 
> > > The "invalid cnid" could sound more relevant than "rejected cnid" for my taste.
> > > 
> > > The whole message is too long. What's about to have two messages here?
> > > 
> > > pr_warn("invalid cnid %lu\n", inode->i_ino);
> > > pr_warn("Volume is probably corrupted, try performing fsck.\n");
> > > 
> > Good improvement!
> > > 
> > > > +		fallthrough;
> > > >  	default:
> > > >  		make_bad_inode(inode);
> > > > +		break;
> > > >  	}
> > > >  	return 0;
> > > >  }
> > > > @@ -441,20 +481,19 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
> > > >  	if (res)
> > > >  		return res;
> > > >  
> > > > -	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
> > > > -		switch (inode->i_ino) {
> > > > -		case HFS_ROOT_CNID:
> > > > -			break;
> > > > -		case HFS_EXT_CNID:
> > > > -			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> > > > -			return 0;
> > > > -		case HFS_CAT_CNID:
> > > > -			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> > > > -			return 0;
> > > > -		default:
> > > > -			BUG();
> > > > -			return -EIO;
> > > > -		}
> > > > +	if (!is_valid_cnid(inode->i_ino,
> > > > +			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL))
> > > 
> > > What's about to introduce static inline function or local variable for
> > > S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL? I don't like this two line
> > > implementation.
> > 
> > Okay, I will rewrite this.
> > 
> > > 
> > > > +		BUG();
> > > 
> > > I am completely against of leaving BUG() here. Several fixes of syzbot issues
> > > were the exchanging BUG() on returning error code. I don't want to investigate
> > > the another syzbot issue that will involve this BUG() here. Let's return error
> > > code here.
> > > 
> > > Usually, it makes sense to have BUG() for debug mode and to return error code
> > > for the case of release mode. But we don't have the debug mode for HFS code.
> > 
> > I prefer BUG() because I think it is a serious bug that we should not
> > allow for a bad inode to be written. I am willing to take responsibility
> > for investigating further issues if they appear as a result of this. Of
> > course, the final say on BUG() or -EIO is yours as the maintainer.
> > 
> > > 
> 
> The hfs_write_inode() will return error code and it is also bug case. But we
> will not crash the kernel in such case. Why would you still like to crash the
> kernel? :)

I would like the kernel to crash so that a bug report is made and I can
fix it, rather than something go wrong quietly. My logic about that
could be wrong and I'm happy to return error code as you prefer.

> 
> I see your point that we should not be here because we must create the bad inode
> in hfs_read_inode() for the case of corrupted Catalog File's records. Let me
> sleep on it. :)
> 
> Thanks,
> Slava.

Thanks,

George

