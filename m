Return-Path: <linux-fsdevel+bounces-63423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D4CBB87BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 03:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1083AEB27
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 01:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E61519B4;
	Sat,  4 Oct 2025 01:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="bHm/JpiG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8B146593
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759541129; cv=none; b=Dy9Z5yjObOlkS74yNcqIO/EWWShi2ulvona9eLNuzeoRY5UnlaiUQ0zydEFt5KEB4uQfYxftg7Y0HV0y4ZCsXNfBaNxNS7oxmLEx/fquJm1EyM5jHFZ5kmZ/h8laYCgajKd3tGdxHuYsx51wHOQ+9iJIbCOGgQjQua9hjNyjsDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759541129; c=relaxed/simple;
	bh=FDkFCEGWhZHa1Woj7m+2H/+uk27BBMDyqk5dQoPv0vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AipjJ7mvfdRJqUNud09ja4hb2Mwj/OyX4dm4HlViH1b7sQhI6LQRGCrJKe1m7uq9HhspcFBADuAWj8XC2z4O6Bb4i4nBI4dfJjm90qCoNvAaqmYfttASSLSAd9YMIir+wcqtLMXk8+IsaLwQJ8fLJvufTdKicSux4mur9Ep3RC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=bHm/JpiG; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Sat, 4 Oct 2025 02:25:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1759541121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxMDW/Dq4L6kXa9Vwh1VX6wM7Gn8hhMzHJhGHctQQmc=;
	b=bHm/JpiGEzh6zFXYgcRBqn76ahirD+9VZqXqBdohezHrI1PWNVzOf19YSoH5H5cWy56Qz7
	VMTRVN0/k+c+w8Kj2onD/wdeH/lPhAEnKU9e6UWG+A6J0TG2G6iBek0Lv57q6Xu8TuUzHI
	sFlVM8vDH0X5HhbUsAH0nWEIso5cCEz7Oyu5k0M+O+up971afmUtWrVjSZ1+livCFqcG/E
	n7AEq1j34CyGZNM4Av5r7ve3g4mr7Y369+vzJys2n9cCb3UawmvQNx5XbsHznnVXOzkvGu
	KwKoIxdQlh9f9ljVkhtDaEQBPXPzAovh88oY84hGa8RLlz03kwl9nfmlW48Amw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel-mentees@lists.linux.dev" <linux-kernel-mentees@lists.linux.dev>,
	"syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com" <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfs: Validate CNIDs in hfs_read_inode
Message-ID: <aOB3fME3Q4GfXu0O@Bertha>
References: <20251003024544.477462-1-contact@gvernon.com>
 <405569eb2e0ec4ce2afa9c331eb791941d0cf726.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405569eb2e0ec4ce2afa9c331eb791941d0cf726.camel@ibm.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 03, 2025 at 10:40:16PM +0000, Viacheslav Dubeyko wrote:
> Let's pay respect to previous efforts. I am suggesting to add this line:
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Are you OK with it?
I agree with paying respect to Tetsuo. The kernel docs indicate that the SoB tag
isn't used like that. Would the Suggested-by: tag be more appropriate?

> I think we can declare like this:
> 
> static inline
> bool is_valid_cnid(unsigned long cnid, s8 type)
> 
> Why cnid has unsigned long type? The u32 is pretty enough.
Because struct inode's inode number is an unsigned long.
> 
> Why type has signed type (s8)? We don't expect negative values here. Let's use
> u8 type.
Because the type field of struct hfs_cat_rec is an s8. Is there anything to gain
by casting the s8 to a u8?

> 
> > +{
> > +	if (likely(cnid >= HFS_FIRSTUSER_CNID))
> > +		return true;
> > +
> > +	switch (cnid) {
> > +	case HFS_POR_CNID:
> > +	case HFS_ROOT_CNID:
> > +		return type == HFS_CDR_DIR;
> > +	case HFS_EXT_CNID:
> > +	case HFS_CAT_CNID:
> > +	case HFS_BAD_CNID:
> > +	case HFS_EXCH_CNID:
> > +		return type == HFS_CDR_FIL;
> > +	default:
> > +		return false;
> 
> We can simply have default that is doing nothing:
> 
> default:
>     /* continue logic */
>     break;
> 
> > +	}
> 
> I believe that it will be better to return false by default here (after switch).
We can do that, but why would it be better, is it an optimisation? We don't have
any logic to continue.

> > +			break;
> > +		}
> >  		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
> >  		HFS_I(inode)->fs_blocks = 0;
> >  		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
> 
> We have practically the same check for the case of hfs_write_inode():
> 
> int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
> {
> 	struct inode *main_inode = inode;
> 	struct hfs_find_data fd;
> 	hfs_cat_rec rec;
> 	int res;
> 
> 	hfs_dbg("ino %lu\n", inode->i_ino);
> 	res = hfs_ext_write_extent(inode);
> 	if (res)
> 		return res;
> 
> 	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
> 		switch (inode->i_ino) {
> 		case HFS_ROOT_CNID:
> 			break;
> 		case HFS_EXT_CNID:
> 			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> 			return 0;
> 		case HFS_CAT_CNID:
> 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> 			return 0;
> 		default:
> 			BUG();
> 			return -EIO;
> 
> I think we need to select something one here. :) I believe we need to remove
> BUG() and return -EIO, finally. What do you think? 

I think that with validation of inodes in hfs_read_inode this code path should
no longer be reachable by poking the kernel interface from userspace. If it is
ever reached, it means kernel logic is broken, so it should be treated as a bug.

> 
> 		}
> 	}
> 
> <skipped>
> }
> 
> What's about to use your check here too?

Let's do that, I'll include it in V2.

> 
> Mostly, I like your approach but the patch needs some polishing yet. ;)
> 
> Thanks,
> Slava.

Thank you for taking the time to give detailed feedback, I really appreciate it.

George

