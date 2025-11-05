Return-Path: <linux-fsdevel+bounces-67108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF01CC35860
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E28620D5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72819310768;
	Wed,  5 Nov 2025 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwGXM1sZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6D2E03E6;
	Wed,  5 Nov 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343282; cv=none; b=OE2BUsQfaVL0L6Nc6MtBSbURItUEbN28UQbptG14/GlX1S3GAnTGerEjU9Z8rUu+NBFoRrQx1SGiAB68xSUjVVOgjaCLwPJoHCMYrkLyASySyUTDKGPMGmGQ1dhTv3OXbtGQK/h+7HhpdxMSRGMlURtnurM+Z6wDzy/zty7uCQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343282; c=relaxed/simple;
	bh=btxGnn6CCgFSpgKGiKlUN2Uoo0h0EbsAS5PsaSiCdPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AByHfMPLup7ilR8+cvqy0m9RAj7YOiTliRK9zBfyDsWJsz+rkADjb4uA9pvk5jsebVKbgouJ3RcbhARPiEy32ZIhTsCaA+qLCgrABtijbDV7PiuNbeWZSDVxxb8MsG1pdITL62ZSi09tc/8kmL89VZZb9dCVyBPyO+PZO/NNB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwGXM1sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAEAC4CEFB;
	Wed,  5 Nov 2025 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343282;
	bh=btxGnn6CCgFSpgKGiKlUN2Uoo0h0EbsAS5PsaSiCdPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwGXM1sZVPMMIEL85QYLjQ0vHOh8EXKaoJGqdkAadD4KEXSGC6jdo1AVO1v9Uko01
	 21aNnVjOVpauDxe0V1jUzhdmsI84/uGaC9tOddXiwkDzkDb6bNSYMptOr49arE3NTT
	 G6SAw8F8neQfpDJOmI7IdebRpD5zMOfpYvn5QfSpEZiD+QrufvkQ768kFjqD0bnA87
	 Pj+2TJSGXXZ+icT6U5pql6MqJ5IYwyi6170a7s7OSjLvjWWG/oucjF/Hk5DG2LMU9G
	 TmcbT+xMixtAp/AeDdsLQfShwXpZRbwgAaHKWSnA07a8ZNc+Q5o0/P69dP6yifcQVn
	 +jDFRzhxlPQsA==
Date: Wed, 5 Nov 2025 12:47:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	James Bottomley <james.bottomley@hansenpartnership.com>, linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-23-viro@zeniv.linux.org.uk>
 <66300d81c5e127e3bca8c6c4d997da386b142004.camel@HansenPartnership.com>
 <20251028174540.GN2441659@ZenIV>
 <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV>
 <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>

On Thu, Oct 30, 2025 at 02:35:51PM +0100, Ard Biesheuvel wrote:
> On Wed, 29 Oct 2025 at 20:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Oct 29, 2025 at 02:57:51PM -0400, James Bottomley wrote:
> >
> > > I think this all looks OK.  The reason for the convolution is that
> > > simple_start/done_creating() didn't exist when I did the conversion ...
> > > although if they had, I'm not sure I'd have thought of reworking
> > > efivarfs_create_dentry to use them.  I tried to update some redundant
> > > bits, but it wasn't the focus of what I was trying to fix.
> > >
> > > So I think the cleanup works and looks nice.
> > >
> > > >
> > > > Relying on the -EEXIST return value to detect duplicates, and
> > > > combining the two callbacks seem like neat optimizations to me, so
> > > >
> > > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > but I have to confess I am slightly out of my depth when it comes to
> > > > VFS stuff.
> > >
> > > Yes, ack too.
> >
> >         Umm...  FWIW, I've got a few more followups on top of that (see
> > #untested.efivarfs, current head at 36051c773015).  Not sure what would
> > be the best way to deal with that stuff - I hope to get the main series
> > stabilized and merged in the coming window.  Right now I'm collecting
> > feedback (acked-by, etc.), and there's a couple of outright bugfixes
> > in front of the series, so I'd expect at least a rebase to -rc4...
> >
> 
> I pulled your code and tried to test it. It works fine for the
> ordinary case, but only now I realized that commit
> 
> commit 0e4f9483959b785f65a36120bb0e4cf1407e492c
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Mon Mar 31 14:42:12 2025 +0200
> 
>     efivarfs: support freeze/thaw
> 
> actually broke James's implementation of the post-resume sync with the
> underlying variable store.
> 
> So I wonder what the point is of all this complexity if it does not
> work for the use case where it is the most important, i.e., resume
> from hibernation, where the system goes through an ordinary cold boot
> and so the EFI variable store may have gotten out of sync with the
> hibernated kernel's view of it.
> 
> If no freeze/thaw support in the suspend/resume path is forthcoming,
> would it be better to just revert that change? That would badly
> conflict with your changes, though, so I'd like to resolve this before
> going further down this path.

So first of all, this works. I've tested it extensively. If it doesn't
work there's a regression.

And suspend/resume works just fine with freeze/thaw. See commit
eacfbf74196f ("power: freeze filesystems during suspend/resume") which
implements exactly that.

The reason this didn't work for you is very likely:

cat /sys/power/freeze_filesystems
0

which you must set to 1.

Second, that "complexity" replaces your way more complex blocking
notifier implementation for this thing which simply deadlocked the
system as I reported and showed earlier this year.

That blocking notifier thing had to use vfs_kern_mount() which had to
come up with it's own internal private vfs mount to pin efivarfs because
it's called out-of-band and then walk the list of variables and resync.
Problem is that leads to completely untenable locking problems. So if
you want to go back to that be my guest.

