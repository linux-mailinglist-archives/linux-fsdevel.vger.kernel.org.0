Return-Path: <linux-fsdevel+bounces-51345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E0BAD5D41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 208507AB17D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA773221734;
	Wed, 11 Jun 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X8LOFP+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C9222154A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662990; cv=none; b=UdAwOY5OYonPlZIFpUSgiMa/xC2N/C3T+xH5Pgos9qNagJe5YCTaLreDAU0DnNRg9e5olHd5AM0tywD04mJTnjakr6D3hLUmjphb+7t68Gv0SRDXBu32jdIVzJzoSl+k+jTz6vHjdrrRLPAAK7p8Zec6k2ljn80qvC21IwZG6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662990; c=relaxed/simple;
	bh=IZE7SqYjoHxmAeuFvGVNIhjmuYlFaKObHM1KhC+UIew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzKdVcANdDUBfnenhyV6w9sya38wnXkWFtup1fa7ZmS6lRtwGjxnDHrd9QkA2P4H+qU4kvEpJXx7FVTaBuzM4i3mc3RgWjPLYV5nKE0shlH+Hg0cUiaUeQvO9DLt+nDNmzm/EhrYh2W2wTfJrUyFKB/WUwACgD9SJCTSw/ssZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X8LOFP+P; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PfwgEI5wsMhUi+kGe1nZXwwqEwuhFyIXRWzw3De2B0g=; b=X8LOFP+PlaFPlu7TfTbSN9ynqB
	Ci43t9W1TM9jWFw2hV4Ak42hUEkLDPbtq5kcL/3N8TTW2O3+LJZ1nwvee9ggWIQA9WQegW4jaY8fq
	d1vbk+KjHFLs2sqXOjKQXS7LtPs10iKW8Gwo9TvRgofDSoHgmw7Or+pl12WeV2lU5B7LSe53Mwven
	f7CVTQos9LIDmrSxr93rSErQ3U1bwsSRz5istCz/FzA6byhDGcJjyKZxL52aAhVPfXsgFCaxVbWKf
	7cdUjo1unpM2suSl2O3V/fJLJ6E0/ue50pOsOftDvuuk9tjbo49kk9OKIl705XmplfYKvxlRhGGRK
	UMOZOSnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPPGj-00000004eXQ-1jSO;
	Wed, 11 Jun 2025 17:29:45 +0000
Date: Wed, 11 Jun 2025 18:29:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>, Allison Karlitskaya <lis@redhat.com>
Subject: Re: [PATCH 1/2] mount: fix detached mount regression
Message-ID: <20250611172945.GK299672@ZenIV>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
 <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
 <20250606045441.GS299672@ZenIV>
 <20250606051428.GT299672@ZenIV>
 <20250606070127.GU299672@ZenIV>
 <20250606-neuformulierung-flohmarkt-42efdaa4bac5@brauner>
 <20250606174502.GY299672@ZenIV>
 <20250607052048.GZ299672@ZenIV>
 <20250611-denkpause-wegrand-6eb6647dab77@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-denkpause-wegrand-6eb6647dab77@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 11, 2025 at 11:36:43AM +0200, Christian Brauner wrote:

> Sigh. There's no need to get all high and mighty about this. For once I
> actually do write extensive selftests and they do actually catch a lot
> of bugs. It's a joke how little selftests we have given the importance
> of our apis. Nobody ever gives a flying fsck to review selftests when
> they're posted because nobody seems to actually care.

Not quite - for me the problem is more on the logistics side; xfstests
is a lot more convenient in that respect.  To be serious, the main
problems are
	1) many selftests have non-trivial dependencies on config
and spew a lot of noise when run on different configs.
	2) very much oriented to case when kernel tree (with build already
done) sitting on the box where they are going to be run.  Sure, I can
tar c .|ssh kvm.virt "mkdir /tmp/linux; cd /tmp/linux; tar x ." and
then make kselftest there, but it's still a headache.
	3) unlike e.g. xfstests and ltp, you don't get a convenient
summary of the entire run.

None of that is fatal, obviously, just bloody annoying to deal with at 4am...
Yes, I know how to use TARGETS, etc., but IME a test in xfstests is less
of a headache on my setup.

> > IMO that kind of stuff should be dealt with by creating a temporary directory
> > somewhere in /tmp, mounting tmpfs on it, then doing all creations, etc.
> > inside that.  Then umount -l /tmp/<whatever>; rmdir /tmp/<whatever> will
> > clean the things up.
> 
> Sorry, that's just wishful thinking at best and out of touch with how
> these apis are used. The fact that you need a private assembly in some
> hidden away directory followed by a umount is a complete waste of system
> calls for a start. It's also inherently unclean unless you also bring
> mount namespaces into the mix. Being able to use detached mount trees is
> simple and clean especially for the overlayfs layer case.

Huh?  I'm talking about the easy-of-teardown for reproducers, nothing else.
And the way I'd described above _is_ trivial to set up and tear down cleanly...

