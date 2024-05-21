Return-Path: <linux-fsdevel+bounces-19903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156D8CB0AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1ECE1C21669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D449142E65;
	Tue, 21 May 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTfMZ3+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745A1CD32;
	Tue, 21 May 2024 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302758; cv=none; b=QmBUV0aTegrohR1HT1attII7UZ8UB5s6XIElBwpaOd3V9UUhFTeoYZQ321ekjtC7xI+pz4MFLmW/HG+qpUraoPhBVeCpzBZT2ojx4ls0YR2x9SW7o0KAOOeK+nzYlHpPMHgaRviy8RL1a05ij1pIb7B3yq/suuKmQnRwMIMMo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302758; c=relaxed/simple;
	bh=h56f1QL3jb+GHUV4CymHSyb4E4n54peG+Qn4CsaG9Ts=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=hovhlnMbpxvTx4NgzMVrZQ3SCV4qBpfVBf2tXmDCJwf8JzQ3kvdS7dx+IXDxqvIUGur0mVTjreDKyJ73yfHLnSx49FUom3X85xXj/L593Qw9S7zytKIy9qOCVBpIJsTQYpEXKJiZ/RI7g64wu8DkK7Z1bndUi5wrzVCPuaySw4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTfMZ3+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186EFC2BD11;
	Tue, 21 May 2024 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716302757;
	bh=h56f1QL3jb+GHUV4CymHSyb4E4n54peG+Qn4CsaG9Ts=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bTfMZ3+ncJE7OLdODIqNXZ6D9GrNsCumq/EQpRt77Z9Zv7L06eor07wgeqfv89scD
	 Uu5zX7o+SWFtkq9wHB9lE/UtUdRmwKpQBgwRnvvp2cHsqRR8vyS2nNzlR1KKKnWhLp
	 8bBJbDfB1DCxyn5/IIE7YnJq/C6naem9KgEpliUFexiziI0pbrWlMRHmeziBo4ys97
	 8TadNnKqkHCElBZv7jUzucCHAqq2gyM3nonTLdTBj0hKRr34OgEyAkBVe01MumVDa8
	 Q2k7oOBbEXFe5GZyAZnviDypZ41Kw/7IZhkms94HsIXqgAiMA3oqJQfIWDASrPv1zd
	 qFAIt4azUjK/A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 17:45:52 +0300
Message-Id: <D1FEJRLKVVXK.2GSTW5LNF9OFY@kernel.org>
Subject: Re: [PATCH 3/3] capabilities: add cap userns sysctl mask
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tycho Andersen" <tycho@tycho.pizza>
Cc: "Jonathan Calmels" <jcalmels@3xx0.net>, <brauner@kernel.org>,
 <ebiederm@xmission.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Kees
 Cook" <keescook@chromium.org>, "Joel Granados" <j.granados@samsung.com>,
 "Serge Hallyn" <serge@hallyn.com>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>,
 <containers@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <keyrings@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-4-jcalmels@3xx0.net> <ZktQZi5iCwxcU0qs@tycho.pizza>
 <ptixqmplbovxmqy3obybwphsie2xaybfj46xyafdnol7bme4z4@4kwdljmrkdpn>
 <Zku8839xgFRAEcl+@tycho.pizza> <D1ETFJFE9Y48.1T8I7SIPGFMQ2@kernel.org>
 <Zkyvz122pigJGgEw@tycho.pizza>
In-Reply-To: <Zkyvz122pigJGgEw@tycho.pizza>

On Tue May 21, 2024 at 5:29 PM EEST, Tycho Andersen wrote:
> On Tue, May 21, 2024 at 01:12:57AM +0300, Jarkko Sakkinen wrote:
> > On Tue May 21, 2024 at 12:13 AM EEST, Tycho Andersen wrote:
> > > On Mon, May 20, 2024 at 12:25:27PM -0700, Jonathan Calmels wrote:
> > > > On Mon, May 20, 2024 at 07:30:14AM GMT, Tycho Andersen wrote:
> > > > > there is an ongoing effort (started at [0]) to constify the first=
 arg
> > > > > here, since you're not supposed to write to it. Your usage looks
> > > > > correct to me, so I think all it needs is a literal "const" here.
> > > >=20
> > > > Will do, along with the suggestions from Jarkko
> > > >=20
> > > > > > +	struct ctl_table t;
> > > > > > +	unsigned long mask_array[2];
> > > > > > +	kernel_cap_t new_mask, *mask;
> > > > > > +	int err;
> > > > > > +
> > > > > > +	if (write && (!capable(CAP_SETPCAP) ||
> > > > > > +		      !capable(CAP_SYS_ADMIN)))
> > > > > > +		return -EPERM;
> > > > >=20
> > > > > ...why CAP_SYS_ADMIN? You mention it in the changelog, but don't
> > > > > explain why.
> > > >=20
> > > > No reason really, I was hoping we could decide what we want here.
> > > > UMH uses CAP_SYS_MODULE, Serge mentioned adding a new cap maybe.
> > >
> > > I don't have a strong preference between SETPCAP and a new capability=
,
> > > but I do think it should be just one. SYS_ADMIN is already god mode
> > > enough, IMO.
> >=20
> > Sometimes I think would it make more sense to invent something
> > completely new like capabilities but more modern and robust, instead of
> > increasing complexity of a broken mechanism (especially thanks to
> > CAP_MAC_ADMIN).
> >=20
> > I kind of liked the idea of privilege tokens both in Symbian and Maemo
> > (have been involved professionally in both). Emphasis on the idea not
> > necessarily on implementation.
> >=20
> > Not an LSM but like something that you could use in the place of POSIX
> > caps. Probably quite tedious effort tho because you would need to pull
> > the whole industry with the new thing...
>
> And then we have LSM hooks, (ns_)capable(), __secure_computing() plus
> a new set of hooks for this new thing sprinkled around. I guess
> kernel developers wouldn't be excited about it, let alone the rest of
> the industry :)
>
> Thinking out loud: I wonder if fixing the seccomp TOCTOU against
> pointers would help here. I guess you'd still have issues where your
> policy engine resolves a path arg to open() and that inode changes
> between the decision and the actual vfs access, you have just changed
> the TOCTOU.
>
> Or even scarier: what if you could change the return value at any
> kprobe? :)

I had one crazy idea related to seccomp filters once.

What if there was way to compose tokens that would be just a seccomp
filter like the one that you pass to PR_SET_SECCOMP but presented with a
file descriptor?

Then you could send these with SCM_RIGHTS to other processes and they
could upgrade their existing filter with them. So it would be a kind of
extension mechanism for a seccomp filter.

Not something I'm seriously suggesting but though to flush this out now
that we are on these topics anyhow ;-)

> Tycho

PS. Sorry if my language was a bit harsh earlier but I think I had also
a point related to at least to the patch set presentation. I.e. you
are very precise describing the mechanism but motivation and bringing
topic somehow to a context is equally important :-)

BR, Jarkko

