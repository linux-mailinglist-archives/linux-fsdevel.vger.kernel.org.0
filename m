Return-Path: <linux-fsdevel+bounces-40397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31895A230E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DE33A7249
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE181E284C;
	Thu, 30 Jan 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh0YHoyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698BE1AA78E
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738250177; cv=none; b=YUsSoO+YJLQtPkfEjChP43Ppy7wAkU2yIY/+wQuWhKVwoLZ055Z6UN/FKrdGGUMsmZhwKgPHTFVZsH/OJ92s5qkAX4qHmW4OOuUyBcQfaciRr2xwus3JE6Ffh46Ab+b12p3Wg0nT57UrJMwSVS6mj0+difF/DqoP6VsmAofC22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738250177; c=relaxed/simple;
	bh=I4x74K3j28LSkF5UMml3+ZSdn8W9U+O8FLfvmdKEvqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8PTAliaZlJPNlgf6+fg9P65uRoP7ReKbl64bP3ADkU3p5HXxP7wjmrpixVZuMzLCVmj6l7koXfaJS5ghaSJbzbLdHHbpfxLUnOU7JbvMSNX8XMoii42OmY3IuNem9Z//DOhcSoCS34u5anOY9Tu7NNa4UjBSKGAI2c+mzJO7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh0YHoyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148EFC4CED2;
	Thu, 30 Jan 2025 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738250176;
	bh=I4x74K3j28LSkF5UMml3+ZSdn8W9U+O8FLfvmdKEvqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wh0YHoyGvUeS8CtlfPRGWT2yEz4QT640WHP8zn7EThZwj6n8AcIndY9DzAzld+qK0
	 6b238DtjHNLzMjWxs5TmQD9uxLzZnDpCErIbOS+bT75aB6vwc9mLpAoI9HWeLsq1Xb
	 6cNHzhpyBC852GbZ8jqQhxduQ7hiPvdZBOfbVzAy+2AZBP004Ba0apeyRAi3lIcbxo
	 2OJBU67R3rQGjoRs5Flro76LAq904FWGQ1SqJaXlaFpaPH9o+0RSgsUzNOjoi82hhu
	 RWathjB9Nfo2EJsHcnkeMaj/G8BbVhn204wzBxaE9OLftKkXWsTfslXL9mhIMh2WEi
	 6GfmP99PPCVQQ==
Date: Thu, 30 Jan 2025 16:16:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 0/4] statmount: allow to retrieve idmappings
Message-ID: <20250130-abkommen-bauabschnitt-9915be9097cb@brauner>
References: <20250130-work-mnt_idmap-statmount-v1-0-d4ced5874e14@kernel.org>
 <09e3c398d484de2721ac00b7fa2d0026062f7c0c.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09e3c398d484de2721ac00b7fa2d0026062f7c0c.camel@kernel.org>

On Thu, Jan 30, 2025 at 07:22:42AM -0500, Jeff Layton wrote:
> On Thu, 2025-01-30 at 00:19 +0100, Christian Brauner wrote:
> > This adds the STATMOUNT_MNT_UIDMAP and STATMOUNT_MNT_GIDMAP options.
> > It allows the retrieval of idmappings via statmount().
> > 
> > Currently it isn't possible to figure out what idmappings are applied to
> > an idmapped mount. This information is often crucial. Before statmount()
> > the only realistic options for an interface like this would have been to
> > add it to /proc/<pid>/fdinfo/<nr> or to expose it in
> > /proc/<pid>/mountinfo. Both solution would have been pretty ugly and
> > would've shown information that is of strong interest to some
> > application but not all. statmount() is perfect for this.
> > 
> > The idmappings applied to an idmapped mount are shown relative to the
> > caller's user namespace. This is the most useful solution that doesn't
> > risk leaking information or confuse the caller.
> > 
> > For example, an idmapped mount might have been created with the
> > following idmappings:
> > 
> >     mount --bind -o X-mount.idmap="0:10000:1000 2000:2000:1 3000:3000:1" /srv /opt
> > 
> > Listing the idmappings through statmount() in the same context shows:
> > 
> >     mnt_id:        2147485088
> >     mnt_parent_id: 2147484816
> >     fs_type:       btrfs
> >     mnt_root:      /srv
> >     mnt_point:     /opt
> >     mnt_opts:      ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
> >     mnt_uidmap[0]: 0 10000 1000
> >     mnt_uidmap[1]: 2000 2000 1
> >     mnt_uidmap[2]: 3000 3000 1
> >     mnt_gidmap[0]: 0 10000 1000
> >     mnt_gidmap[1]: 2000 2000 1
> >     mnt_gidmap[2]: 3000 3000 1
> > 
> 
> nit: any reason not to separate the fields with ':' like the mount
> option syntax?

I followed the format of how idmappings are written and shown in
/proc/<PID>/{g,u}id_map.

> 
> > But the idmappings might not always be resolvablein the caller's user
> > namespace. For example:
> > 
> >     unshare --user --map-root
> > 
> > In this case statmount() will indicate the failure to resolve the idmappings
> > in the caller's user namespace by listing 4294967295 aka (uid_t) -1 as
> > the target of the mapping while still showing the source and range of
> > the mapping:
> > 
> >     mnt_id:        2147485087
> >     mnt_parent_id: 2147484016
> >     fs_type:       btrfs
> >     mnt_root:      /srv
> >     mnt_point:     /opt
> >     mnt_opts:      ssd,discard=async,space_cache=v2,subvolid=5,subvol=/
> >     mnt_uidmap[0]: 0 4294967295 1000
> >     mnt_uidmap[1]: 2000 4294967295 1
> >     mnt_uidmap[2]: 3000 4294967295 1
> >     mnt_gidmap[0]: 0 4294967295 1000
> >     mnt_gidmap[1]: 2000 4294967295 1
> >     mnt_gidmap[2]: 3000 4294967295 1
> > 
> 
> From a UI standpoint, this behavior is pretty ugly. What if we
> (hypothetically) move to 64-bit uids one day? Maybe it'd be better to
> note an inability to resolve with more distinct output? Like a '?'
> instead of a -1 cast to unsigned?
> 
> If I can't resolve the range, maybe it'd be better to just not return
> the info at all? Are the first and third fields of any value without
> the second?

That's an option but then users can only distinguish between no
idmapping and an empty idmapping by checking sm->mask for
STATMOUNT_MNT_{G,U}IDMAP. Which is probably fine. I'm just pointing it
out.

Leaving them out is probably a good idea rather than adding some special
syntax.

> > Note that statmount() requires that the whole range must be resolvable
> > in the caller's user namespace. If a subrange fails to map it will still
> > list the map as not resolvable. This is a practical compromise to avoid
> > having to find which subranges are resovable and wich aren't.
> > 
> > Idmappings are listed as a string array with each mapping separated by
> > zero bytes. This allows to retrieve the idmappings and immediately use
> > them for writing to e.g., /proc/<pid>/{g,u}id_map and it also allow for
> > simple iteration like:
> > 
> >     if (stmnt->mask & STATMOUNT_MNT_UIDMAP) {
> >             const char *idmap = stmnt->str + stmnt->mnt_uidmap;
> > 
> >             for (size_t idx = 0; idx < stmnt->mnt_uidmap_nr; idx++) {
> >                     printf("mnt_uidmap[%lu]: %s\n", idx, idmap);
> >                     idmap += strlen(idmap) + 1;
> >             }
> >     }
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Christian Brauner (4):
> >       uidgid: add map_id_range_up()
> >       statmount: allow to retrieve idmappings
> >       samples/vfs: check whether flag was raised
> >       samples/vfs: add STATMOUNT_MNT_{G,U}IDMAP
> > 
> >  fs/internal.h                      |  1 +
> >  fs/mnt_idmapping.c                 | 49 ++++++++++++++++++++++++++++++++++++++
> >  fs/namespace.c                     | 43 ++++++++++++++++++++++++++++++++-
> >  include/linux/uidgid.h             |  6 +++++
> >  include/uapi/linux/mount.h         |  8 ++++++-
> >  kernel/user_namespace.c            | 26 +++++++++++++-------
> >  samples/vfs/samples-vfs.h          | 14 ++++++++++-
> >  samples/vfs/test-list-all-mounts.c | 35 ++++++++++++++++++++++-----
> >  8 files changed, 164 insertions(+), 18 deletions(-)
> > ---
> > base-commit: 6d61a53dd6f55405ebcaea6ee38d1ab5a8856c2c
> > change-id: 20250129-work-mnt_idmap-statmount-e57f258fef8e
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

