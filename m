Return-Path: <linux-fsdevel+bounces-63401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C44EBB82D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBE1E4E9984
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673E260565;
	Fri,  3 Oct 2025 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uQzkKuSF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8219DFA2
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526037; cv=none; b=Sf+zXlG+Xp/uDUaPYq/leB0VICUVmFuvhjEYhiLXpd3+wDXFEDCJ/FjSBmPB2SX+Z2bllb5Y1mxQcZx7Vg+/3nO9xW6DedwnRJ0v5UeHbq08LUsRARo5PbxMyZepKsupFdhr8M5Yq8LRtY+c+Owd0s9eaFlhvvZMTHm5sD+MK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526037; c=relaxed/simple;
	bh=V7PoEKXD0Q+mloNd3mDO2GE3C6oMT+qrDx1rM2JOF4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLHWUGaUw/86Syac8O5jIZArXKg/4gIVQWz+W863cSOnAZ8heN3tKfwx7KpVR73b0ieprkA9dYgQnkd0xZJdmUySs57CVXLdcOD0Z34KPq6LSaLZBGyoC6Z2bbj130zfRgyWG9ePB4DbaDDGJCjYmoKfe4Nzw3Haop4zzMT1mFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uQzkKuSF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lJ99lNLZkUvQkZPEYCEupRh0DEOKIbn96zZC8vCF48o=; b=uQzkKuSFUXl/SozgpOGarA9Xu/
	AV1uuAG8JbVL7NG/ZcOpiXtewen48pBn9at/Gk6yFtAJPmG6AgR1ickQ39ApHGm/YY3SoVozNwuRc
	TMfW0JRdd7iHBj5/dy6/Ie+gzjLZpb0Kv0Gjyft03y739yPe1s3D7K621aDB4x5vMe4+9vh7BtNl3
	2zkM6KJm+zzkQfdXYCwlszMZtarsHYvhU3cD+nMjrsFVAy2ZlypalCwl7qY4fN5PEqcTyRye3cI9K
	hZciZu9hFpIbiEa5j3b1CKXFgTetqIOcW/CRfTRGyGgu2m0P/TYVAp1rXPJbQkX716SL0hA6+F90w
	UiRaBQ/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4n67-0000000A1sw-3bcY;
	Fri, 03 Oct 2025 21:13:51 +0000
Date: Fri, 3 Oct 2025 22:13:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [git pull] pile 1: mount stuff
Message-ID: <20251003211351.GA1738725@ZenIV>
References: <20251002055437.GG39973@ZenIV>
 <CAHk-=wjwQpQQb8A5594h8fTODkLHLBuw23TK1jL=Y9CLckR0kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwQpQQb8A5594h8fTODkLHLBuw23TK1jL=Y9CLckR0kw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 03, 2025 at 10:45:02AM -0700, Linus Torvalds wrote:

> What do you think? This patch is ENTIRELY UNTESTED. It compiled for
> me, that's all I can say. It *looks* fine, and it reads nicely and
> groups those variables with the lock that protects them. But it's a
> quick throw-away patch for "maybe something like this?"

Gathering those into a single object makes sense, the only thing that
worries me is that it is suggesting that we might want to have multiple
instances of the entire thing...

One obvious problem is notify_list and mnt_notify_add(); it's not
impossible to deal with.  The only reason it's not static is the
call in reparent(), and I'm not at all sure it needs to be there -
we are sliding something from under an overmount and I don't see
why would anybody want a notification for watchers of that
overmount, especially since nothing is generated for the things
overmounting it, etc.

Last cycle's pile had been way too large as it is, so I decided to
leave dealign with that magical mystery shite for later; might as well
do it this cycle...

>  /*
> - * locks: mount_lock [read_seqlock_excl], namespace_sem [excl]
> + * locks: mount_lock [read_seqlock_excl], fs_namespace.sem [excl]

 * locks: mount_locked_reader, namespace_excl

would be better, IMO.  I didn't switch those comments since the series had
already been getting too long, but I think refering to locking conditions
by guard names is better than going by lock name + type of access.

> -/* iterator; we want it to have access to namespace_sem, thus here... */
> +/* iterator; we want it to have access to fs_namespace.sem, thus here... */

Stale comment, really - mnt_find_id_at() is static, to start with...
Originally it had been explaining why that thing (used in fs/proc_namespace.c)
stayed behind in fs/namespace.c; these days it's not obvious that comment is
needed in the first place, but if we want to explain that, we would be better
off with something like "iterator; used only by fs/proc_namespace.c, kept here
since it uses mount rbtree of namespace and we don't want to expose the details
of that outside of fs/namespace.c"...

> -		emptied_ns = m->mnt_ns;
> +		fs_namespace.emptied_ns = m->mnt_ns;

Might be worth an inlined helper...

> -	rwsem_assert_held(&namespace_sem);
> +	rwsem_assert_held(&fs_namespace.sem);

... as well as this one, really.

