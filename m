Return-Path: <linux-fsdevel+bounces-52637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D52FAE4D74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 21:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D5E17D463
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB721F4628;
	Mon, 23 Jun 2025 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YobQ0v/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431678F4F;
	Mon, 23 Jun 2025 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706261; cv=none; b=dH18rPwV4wPCj18TngS7D6Ui0K8Ev/hy/Dcu5UpcHi+AX8Wj8fTJ35QJ+ZvepS4Bzw515BnaaiWjTjy5fR00/bQNpJLHInJW0U+LZXpphn58sjYouVb0BMNfSdCH1U8aHzIVzt5odqdD6PGVrWqfbeyN0d2x6KK77miGT4RC4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706261; c=relaxed/simple;
	bh=+Qly8++8NwkVFxi0EqVhD/4JcJSwOckHZ1V5SQOWRzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Apq2FgMTnd2YB1LUf7U/SMEOykihQdhczP+Il7tAh1mbY8WAi4V0YqDFifpDYEI31Zgtdz5F+QbdIiLcgMvJlxflBX4pIm3pv4IKQgLRa14Ph/OE4Xq4dtm9Q2hDMkSB4xrM6OI5dz8GKQMSOfZlfwQPOQS9enfACR3WFUM5uMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YobQ0v/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AE7C4CEF0;
	Mon, 23 Jun 2025 19:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750706260;
	bh=+Qly8++8NwkVFxi0EqVhD/4JcJSwOckHZ1V5SQOWRzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YobQ0v/rxu+RveG+u6Y9Y+M/MRVN0bbgAuGVsFSeJ+7+Nnp0tE7wFrS5OF3fxjI6m
	 HRTO3UaI+txGAABJa4TAzsnuixdF/xyXtC+pec1QPse1nRLe3As6QVbU7Qsg/SewD5
	 7vBgtufZUUZxIFEtRoTics3030/3rRxcke2jyH5ftfi8ni4K8rhs3t5kTm3QXY8j3P
	 E6I/Yi0bqRxaZZcHJXqipG16NPMh1U5sbYygJJ2ZtcKV1f7jKTSEBrmcyRSnykKFVC
	 PZ7tnCVWJrTgCskT5dqxMnShe+3hU7LSAPwdAPM/i3vcEk1jGp6yo9YDas/pIkKZRZ
	 8aQsPm7kZc3Sg==
Date: Mon, 23 Jun 2025 21:17:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/9] exportfs: add FILEID_PIDFS
Message-ID: <20250623-unklar-nachwachsen-09f3568700c8@brauner>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
 <y6yp3ldhmmtl6mzr2arwr5fggzrlffc2pzvqbr7jkabqm5zm3u@6pwl22ctaxkx>
 <20250623-herzrasen-geblickt-9e2befc82298@brauner>
 <CAOQ4uxid1=97dZSZPB_4W5pocoU4cU-7G6WJ_4KQSGobZ_72xA@mail.gmail.com>
 <lo73q6ovi2m2skguq5ydedz2za4vud747ztwfxwzn33r3do7ia@p7y3sbyrznfi>
 <CAOQ4uxirz2sRrNNtO5Re=CdzwW+tLvoA0XHFW9V5HDPgh15g2A@mail.gmail.com>
 <idfofhnjxf35s4d6wifbdfh27a5blh5kzlpr5xkgkc3zkvz3nx@odyxd6o75a5a>
 <CAOQ4uxg9jWNxWg3ksoeEQ-KY0xKUwTPYokKN7d4whi_QDa=u_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg9jWNxWg3ksoeEQ-KY0xKUwTPYokKN7d4whi_QDa=u_g@mail.gmail.com>

On Mon, Jun 23, 2025 at 04:05:18PM +0200, Amir Goldstein wrote:
> On Mon, Jun 23, 2025 at 3:18 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 23-06-25 15:05:45, Amir Goldstein wrote:
> > > On Mon, Jun 23, 2025 at 2:41 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Mon 23-06-25 14:22:26, Amir Goldstein wrote:
> > > > > On Mon, Jun 23, 2025 at 1:58 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Jun 23, 2025 at 01:55:38PM +0200, Jan Kara wrote:
> > > > > > > On Mon 23-06-25 11:01:28, Christian Brauner wrote:
> > > > > > > > Introduce new pidfs file handle values.
> > > > > > > >
> > > > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > > > ---
> > > > > > > >  include/linux/exportfs.h | 11 +++++++++++
> > > > > > > >  1 file changed, 11 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > > > > > > index 25c4a5afbd44..45b38a29643f 100644
> > > > > > > > --- a/include/linux/exportfs.h
> > > > > > > > +++ b/include/linux/exportfs.h
> > > > > > > > @@ -99,6 +99,11 @@ enum fid_type {
> > > > > > > >      */
> > > > > > > >     FILEID_FAT_WITH_PARENT = 0x72,
> > > > > > > >
> > > > > > > > +   /*
> > > > > > > > +    * 64 bit inode number.
> > > > > > > > +    */
> > > > > > > > +   FILEID_INO64 = 0x80,
> > > > > > > > +
> > > > > > > >     /*
> > > > > > > >      * 64 bit inode number, 32 bit generation number.
> > > > > > > >      */
> > > > > > > > @@ -131,6 +136,12 @@ enum fid_type {
> > > > > > > >      * Filesystems must not use 0xff file ID.
> > > > > > > >      */
> > > > > > > >     FILEID_INVALID = 0xff,
> > > > > > > > +
> > > > > > > > +   /* Internal kernel fid types */
> > > > > > > > +
> > > > > > > > +   /* pidfs fid types */
> > > > > > > > +   FILEID_PIDFS_FSTYPE = 0x100,
> > > > > > > > +   FILEID_PIDFS = FILEID_PIDFS_FSTYPE | FILEID_INO64,
> > > > > > >
> > > > > > > What is the point behind having FILEID_INO64 and FILEID_PIDFS separately?
> > > > > > > Why not just allocate one value for FILEID_PIDFS and be done with it? Do
> > > > > > > you expect some future extensions for pidfs?
> > > > > >
> > > > > > I wouldn't rule it out, yes. This was also one of Amir's suggestions.
> > > > >
> > > > > The idea was to parcel the autonomous fid type to fstype (pidfs)
> > > > > which determines which is the fs to decode the autonomous fid
> > > > > and a per-fs sub-type like we have today.
> > > > >
> > > > > Maybe it is a bit over design, but I don't think this is really limiting us
> > > > > going forward, because those constants are not part of the uapi.
> > > >
> > > > OK, I agree these file handles do not survive reboot anyway so we are free
> > > > to redefine the encoding in the future. So it is not a big deal (but it
> > > > also wouldn't be a big deal to start simple and add some subtyping in the
> > > > future when there's actual usecase). But in the current patch set we have
> > > > one flag FILEID_IS_AUTONOMOUS which does provide this subtyping and then
> > > > this FILEID_PIDFS_FSTYPE which doesn't seem to be about subtyping but about
> > > > pidfs expecting some future extensions and wanting to recognize all its
> > > > file handle types more easily (without having to enumerate all types like
> > > > other filesystems)? My concern is that fh_type space isn't that big and if
> > > > every filesystem started to reserve flag-like bits in it, we'd soon run out
> > > > of it. So I don't think this is a great precedens although in this
> > > > particular case I agree it can be modified in the future if we decide so...
> > > >
> > >
> > > Yes, I agree.
> > > For the sake of argument let's assume we have two types to begin with
> > > pidfs and drm and then would you want to define them as:
> > >
> > >    /* Internal kernel fid types */
> > >    FILEID_PIDFS = 0x100,
> > >    FILEID_DRM = 0x200,
> > >
> > > Or
> > >
> > >    FILEID_PIDFS = 0x100,
> > >    FILEID_DRM = 0x101,
> > >
> > > I think the former is easy to start with and we have plenty of time to
> > > make reparceling if we get to dousens and file id type...
> >
> > No strong preference if we then test for equality with FILEID_PIDFS and
> > FILEID_DRM and not like fh_type & FILEID_PIDFS.
> >
> > > Regarding the lower bits, I think it would be wise to reserve
> > >
> > > FILEID_PIDFS_FSTYPE = 0x100,
> > > FILEID_PIDFS_ROOT = FILEID_PIDFS_FSTYPE | FILEID_ROOT /* also 0x100 */
> > >
> > > This is why I suggested using non zero lower bits and then why
> > > not use the actual format descriptor for the lower bits as it was intended.
> >
> > I'm getting lost in these names a bit :) It's hard to see a difference for
> > me without a concrete examples of where one should be used compared to the
> > other...
> 
> In any case, I don't feel strongly about it.
> You can leave it as is or use
>     FILEID_PIDFS = 0x100,
> or
>     FILEID_PIDFS = 0x180,
> 
> we can always change it later if we want to.
> 
> Thanks,
> Amir.

I'm completely lost.

