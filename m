Return-Path: <linux-fsdevel+bounces-20429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341ED8D3537
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44E21F26CA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6871816A360;
	Wed, 29 May 2024 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik88ltCn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC11316937A
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981139; cv=none; b=q4GQevTZ+z/CvPgq60Hnrhm6AsqPLR6wfUqmaFJpB6MLHFZhACCov3x7jPyBF2kBu/lgQGumBS5F9s1jGqmEHXTW82qPD2UQynapIXh0b7jH84PvdhMDcUwvthAbZabfiO3EJ6V2PjHtdS6UCfU9+aLlcJtT7tsUPdA+mMButcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981139; c=relaxed/simple;
	bh=aw3x0I6VAVXDVZtdgFinfZaa9XQIcCg7/lBaR/z6oXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNto10DP1lWm+P+Wdjsy6CSiNmBQZS/68nSmWVG/DekCEfK0HiTIVb6HJZt+FJiFgxjKF4pqPTsbwe0diySFtLdce0gsM/fRjF51Ei1i7xR+M9rZQ5bYF3fZ+rHd8DMuVmLOE1Mq5v+jRSarseUVtnCrJPMYPbAF1zNO7Zslqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik88ltCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CA1C2BD10;
	Wed, 29 May 2024 11:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716981139;
	bh=aw3x0I6VAVXDVZtdgFinfZaa9XQIcCg7/lBaR/z6oXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik88ltCns1zdBHTPeiBZBifxg1kyaqnpNPqOQjk9hRn5WLV2afT90LK1G2rq3Crn0
	 zAxIpV36ABGums+pq01L8ZBnaNxHsKvD8cDF5VqyI7GRUhjm9CGxEipz3Up/i+7b2P
	 TYh8S9nT2miHnVQa1PV89ip08mrBCqqYeewSgfa8SqyS+2+PmoRJBut1/Y84Exk8lc
	 Eyb6AYj5Unq48zF2OKcgSQA8y+NgdjPz8irjY4QJDgcqIkYHUVo5XBvBr/PmWXLGb7
	 5yF2FjJAlafGzt3ORN/ryvPil3wv3+nqhfpo/z35tIc7UTUQAWWxn0Pz+wltFsLFKr
	 ZTz+KiaChEtEQ==
Date: Wed, 29 May 2024 13:12:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: A fs-next branch
Message-ID: <20240529-teesieb-frieren-c432407f5543@brauner>
References: <ZkPsYPX2gzWpy2Sw@casper.infradead.org>
 <20240520132326.52392f8d@canb.auug.org.au>
 <ZkvCyB1-WpxH7512@casper.infradead.org>
 <20240528091629.3b8de7e0@canb.auug.org.au>
 <20240529143558.4e1fc740@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529143558.4e1fc740@canb.auug.org.au>

On Wed, May 29, 2024 at 02:35:58PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 28 May 2024 09:16:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Mon, 20 May 2024 22:38:16 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > As I understand the structure of linux-next right now, you merge one
> > > tree after another in some order which isn't relevant to me, so I have no
> > > idea what it is.  What we're asking for is that we end up with a branch
> > > in your tree called fs-next that is:
> > > 
> > >  - Linus's tree as of that day
> > >  - plus the vfs trees
> > >  - plus xfs, btrfs, ext4, nfs, cifs, ...
> > > 
> > > but not, eg, graphics, i2c, tip, networking, etc
> > > 
> > > How we get that branch is really up to you; if you want to start by
> > > merging all the filesystem trees, tag that, then continue merging all the
> > > other trees, that would work.  If you want to merge all the filesystem
> > > trees to fs-next, then merge the fs-next tree at some point in your list
> > > of trees, that would work too.
> > > 
> > > Also, I don't think we care if it's a branch or a tag.  Just something
> > > we can call fs-next to all test against and submit patches against.
> > > The important thing is that we get your resolution of any conflicts.
> > > 
> > > There was debate about whether we wanted to include mm-stable in this
> > > tree, and I think that debate will continue, but I don't think it'll be
> > > a big difference to you whether we ask you to include it or not?  
> > 
> > OK, I can see how to do that.  I will start on it tomorrow.  The plan
> > is that you will end up with a branch (fs-next) in the linux-next tree
> > that will be a merge of the above trees each day and I will merge it
> > into the -next tree as well.
> 
> OK, this is what I have done today:
> 
> I have created 2 new branches local to linux-next - fs-current and fs-next.
> 
> fs-current is based on Linus' tree of the day and contains the
> following trees (name, contacts, URL, branch):
> 
> fscrypt-current	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/fs/fscrypt/linux.git	for-current
> fsverity-current	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>	git://git.kernel.org/pub/scm/fs/fsverity/linux.git	for-current
> btrfs-fixes	David Sterba <dsterba@suse.cz>	git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git	next-fixes
> vfs-fixes	Al Viro <viro@ZenIV.linux.org.uk>	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git	fixes
> erofs-fixes	Gao Xiang <xiang@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git	fixes
> nfsd-fixes	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux	nfsd-fixes
> v9fs-fixes	Eric Van Hensbergen <ericvh@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git	fixes/next
> overlayfs-fixes	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git	ovl-fixes

Could you please add
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.fixes to fs-current
as well. Thanks!

> 
> 
> The fs-next tree is based on fs-current and contains these trees:
> 
> bcachefs	Kent Overstreet <kent.overstreet@linux.dev>	https://evilpiepirate.org/git/bcachefs.git	for-next
> pidfd	Christian Brauner <brauner@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git	for-next
> fscrypt	Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/fs/fscrypt/linux.git	for-next
> afs	David Howells <dhowells@redhat.com>	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git	afs-next
> btrfs	David Sterba <dsterba@suse.cz>	git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git	for-next
> ceph	Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>	git://github.com/ceph/ceph-client.git	master
> cifs	Steve French <smfrench@gmail.com>, CIFS <linux-cifs@vger.kernel.org>	git://git.samba.org/sfrench/cifs-2.6.git	for-next
> configfs	Christoph Hellwig <hch@lst.de>	git://git.infradead.org/users/hch/configfs.git	for-next
> erofs	Gao Xiang <xiang@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git	dev
> exfat	Namjae Jeon <linkinjeon@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git	dev
> exportfs	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux	exportfs-next
> ext3	Jan Kara <jack@suse.cz>	git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git	for_next
> ext4	Theodore Ts'o <tytso@mit.edu>	git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git	dev
> f2fs	Jaegeuk Kim <jaegeuk@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git	dev
> fsverity	Eric Biggers <ebiggers@kernel.org>, Theodore Y. Ts'o <tytso@mit.edu>	git://git.kernel.org/pub/scm/fs/fsverity/linux.git	for-next
> fuse	Miklos Szeredi <miklos@szeredi.hu>	git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git	for-next
> gfs2	Steven Whitehouse <swhiteho@redhat.com>, Bob Peterson <rpeterso@redhat.com>	git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git	for-next
> jfs	Dave Kleikamp <dave.kleikamp@oracle.com>	git://github.com/kleikamp/linux-shaggy.git	jfs-next
> ksmbd	Steve French <smfrench@gmail.com>	https://github.com/smfrench/smb3-kernel.git	ksmbd-for-next
> nfs	Trond Myklebust <trondmy@gmail.com>	git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git	linux-next
> nfs-anna	Anna Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@gmail.com>, NFS Mailing List <linux-nfs@vger.kernel.org>	git://git.linux-nfs.org/projects/anna/linux-nfs.git	linux-next
> nfsd	Chuck Lever <chuck.lever@oracle.com>	git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux	nfsd-next
> ntfs3	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>	https://github.com/Paragon-Software-Group/linux-ntfs3.git	master
> orangefs	Mike Marshall <hubcap@omnibond.com>	git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux	for-next
> overlayfs	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git	overlayfs-next
> ubifs	Richard Weinberger <richard@nod.at>	git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git	next
> v9fs	Dominique Martinet <asmadeus@codewreck.org>	git://github.com/martinetd/linux	9p-next
> v9fs-ericvh	Eric Van Hensbergen <ericvh@gmail.com>	git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git	ericvh/for-next
> xfs	Darrick J. Wong <djwong@kernel.org>, David Chinner <david@fromorbit.com>, <linux-xfs@vger.kernel.org>	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git	for-next
> zonefs	Damien Le Moal <Damien.LeMoal@wdc.com>	git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git	for-next
> iomap	Darrick J. Wong <djwong@kernel.org>	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git	iomap-for-next
> djw-vfs	Darrick J. Wong <djwong@kernel.org>	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git	vfs-for-next
> file-locks	Jeff Layton <jlayton@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git	locks-next
> iversion	Jeff Layton <jlayton@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git	iversion-next
> vfs-brauner	Christian Brauner <brauner@kernel.org>	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git	vfs.all
> vfs	Al Viro <viro@ZenIV.linux.org.uk>	git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git	for-next
> 
> 
> Please let me know if you want them reordered or some removed/added.
> 
> Both these branches will be exported with the linux-next tree each day.
> 
> -- 
> Cheers,
> Stephen Rothwell



