Return-Path: <linux-fsdevel+bounces-52853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D35EAE7939
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767AF4A0775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF23207A26;
	Wed, 25 Jun 2025 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C9/dKQy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F361DC198
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838260; cv=none; b=qbxZ9ccEDFU9hyXCNBm/4qihAVljy9qbm6Sln/SmRSLp3VypP0pdCr+aRYzcT8e7VAFsVX6Dje5+faBfw1Jfs9pWJnnSavSQwLGZZeZZJB1CLg8lg0isz8n91gJR9/VuJxfcwtRo1AEQrGVk0nk7zza6d/7wxryHycEZok2oTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838260; c=relaxed/simple;
	bh=wXghg8YL2zzRIij3nEaifgNY9TsTstju9UEmpsizDAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gk7KvqUbW9A1y3uBZbDeXWlDCVSO9r/GYNSJ8Me8Zj4AkJs7XowuzvkGN+VLdLXwzmenS0YhpnNyk5Wn5/D2N9vSzb9syrmSjFn8tRrb0d4if4LyJveO1nzupj5WF92knIM9MHjy8HrCwa0NCOnxV9XOdiDelSGi6WEXCrOF6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C9/dKQy4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=AtxblejyW7rgGjgAuxugGwB/+mG7PsIFOMajrEDE1a0=; b=C9/dKQy4tPBEroA+d3+Axz6xs/
	EUAtRJz61LseVWdmW2MTjAHcnzORfmPAd4H8e/kOaSCDmljG4U/j8t6HTVRQXEW+tcYkDw8p3Phos
	pEogMlwwkWxsj4SgwdIIJqAcEJOQlGMr1Ij9PXz3DZsuZWzFtY9WYz1GekbMKoyyiwOiXKKf8RRbF
	q8D3t4QavElCMMFNkrf+hb2ZJ1MO9deBEIPEQUFDpCny15CFvu3XDMohChBLZ6C7tB+pXC41ukwNM
	2dymRBziMWXc+WlVGCUrClQsDnn9lSdayMI7DBI7DEQsbJEz9/WyQzDtGd1tIBestDj1tGD2F7Oue
	wEHn2fBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUL0f-0000000CTYV-2mNh;
	Wed, 25 Jun 2025 07:57:33 +0000
Date: Wed, 25 Jun 2025 08:57:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCHES v2][RFC][CFR] mount-related stuff
Message-ID: <20250625075733.GS1880847@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250623044912.GA1248894@ZenIV>
 <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
 <20250623185540.GH1880847@ZenIV>
 <45bb3590-7a6e-455c-bb99-71f21c6b2e6c@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45bb3590-7a6e-455c-bb99-71f21c6b2e6c@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 24, 2025 at 02:48:53PM +0800, Ian Kent wrote:

> +    for (p = mnt; p; p = next_mnt(p, mnt)) {
> +        unsigned int f = 0;
> +
> +        if (p->mnt_mountpoint != mnt->mnt.mnt_root) {

???  The loop goes over everything mounted on mnt, no matter how
deep it is.  Do you mean "p is mounted on the root of its parent",
or is it "p is mounted on some mount of the same fs, with mountpoint
that just happens to be equal to root dentry of mnt (which may be
not the mount p is mounted on)"?

> +        /* p is a covering mnt, need to check if p or any of its
> +         * children are in use. A reference to p is not held so
> +         * don't pass TREE_BUSY_REFERENCED to the propagation
> +         * helper.
> +         */

... so for these you keep walking through the subtree on them (nevermind
that outer loop will walk it as well)...

> +        for (q = p; q; q = next_mnt(q, p)) {
> +            if (propagate_mount_tree_busy(q, f)) {
> +                busy = true;
> +                break;
> +            }

... and yet you still keep going in the outer loop?  Confused...
>      }
>      unlock_mount_hash();
> +    up_read(&namespace_sem);

> + * count greater than the minimum reference count (ie. are in use).
> + */
> +int propagate_mount_tree_busy(struct mount *mnt, unsigned int flags)
> +{
> +    struct mount *m;
> +    struct mount *parent = mnt->mnt_parent;
> +    int refcnt = flags & TREE_BUSY_REFERENCED ? 2 : 1;
> +
> +    if (do_refcount_check(mnt, refcnt))
> +        return 1;
> +
> +    for (m = propagation_next(parent, parent); m;
> +            m = propagation_next(m, parent)) {
> +        struct mount *child;
> +
> +        child = __lookup_mnt(&m->mnt, mnt->mnt_mountpoint);
> +        if (!child)
> +            continue;
> +
> +        if (do_refcount_check(child, 1))
> +            return 1;
> +    }
> +    return 0;
> +}

What is the daemon expected to do with your subtree?  Take it apart with
a series of sync (== non-lazy) umount(2)?  I presume it is normal for
it to run into -EBUSY halfway through - i.e. get rid of some, but not
all of the subtree, right?

