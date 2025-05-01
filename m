Return-Path: <linux-fsdevel+bounces-47811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BBFAA5A71
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 07:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6154A5ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 05:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0D0231840;
	Thu,  1 May 2025 05:04:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.carlthompson.net (charon.carlthompson.net [45.77.7.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB64C85;
	Thu,  1 May 2025 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.77.7.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746075889; cv=none; b=Qi1qKz743bpDgbrUMFCTDr06QQ6e2fK2hsb/wm3RGfRmELFMXOzo21jq4nyXbqGxXmuvVEHs1R+dvdNBQ5Lvb5zDG6kHYpP2/m9J86CjhNAwI6+Pus//FH8Hto7ZhP3mVDHKa0Dyh/3TJBPfeFWD5CophsH89sPAGMMn5+o6uwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746075889; c=relaxed/simple;
	bh=bKz7SHyk2eTeiqkjGwAFQb5WcyVlwIow4MJb3mlck8I=;
	h=Date:From:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VR8hyneXuG7URQ5VrRVCST5/zfrmefYtaCoHPLR9QGgPDiL4CCnk/9+K9ciSUtPDIEA8sJE4aGXCUcIqPxF4hFaVB8i18C4WHsv+iK+5/hhjoedi7aOrEZ84gZwYAP4fWawP333QSrdBzhhg7nFo6H9e7xUxdcjWU6t6Bpxvi5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net; spf=pass smtp.mailfrom=carlthompson.net; arc=none smtp.client-ip=45.77.7.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=carlthompson.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=carlthompson.net
Received: from mail.carlthompson.net (mail.home [10.35.20.252])
	(Authenticated sender: cet@carlthompson.net)
	by smtp.carlthompson.net (Postfix) with ESMTPSA id AF13A1E0F55A8;
	Wed, 30 Apr 2025 21:55:50 -0700 (PDT)
Date: Wed, 30 Apr 2025 21:55:50 -0700 (PDT)
From: "Carl E. Thompson" <list-bcachefs@carlthompson.net>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <937126029.191.1746075350593@mail.carlthompson.net>
In-Reply-To: <114E260B-7AC4-4F5D-BBC4-60036CC7188F@zytor.com>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <20250425195910.GA1018738@mit.edu>
 <d87f7b76-8a53-4023-81e2-5d257c90acc2@zytor.com>
 <CAHk-=wgwuu5Yp0Y-t_U6MoeKmDbJ-Y+0e+MoQi7pkGw2Eu9BzQ@mail.gmail.com>
 <114E260B-7AC4-4F5D-BBC4-60036CC7188F@zytor.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite

Here's a probably silly question from someone who isn't a kernel developer:=
 What's the point of all this effort to do case-folding at the Linux kernel=
 level anyway?

Linux and UNIX applications don't need it. Certainly nothing performance cr=
itical uses it.

If certain Windows games and applications need case-folding and Wine wants =
to let Linux users run those applications then let Wine handle case-folding=
 at *their* layer since they have to implement Microsoft's filesystem APIs =
/ ABIs anyway.

Or implement loop-device namespaces and let users mount their own exFAT ima=
ges for the Wine case and contain the evilness to *that* driver.

I can think of no *good* reason why a modern *Linux* filesystem needs case-=
folding. (I don't consider it being a challenging problem to "solve" to be =
a good reason. Neither is because someone is paying you to help their narro=
w use case if it means making more common cases less optimal or more comple=
x.)

I do very much agree with a point that I think Kent was making that humans =
beings expect case-folding in their interactions with computers. That's tru=
e. But the human interaction case doesn't need to be handled in the kernel,=
 does it? When I click "Open" in my editor and start typing to find a file =
it *already* case folds for me and it does it without filesystem support. S=
ame thing for my file browser. Same thing for the 'ls' command in my config=
uration. We already have tons of options in user space for this.

Thanks,
Carl

PS: And as long as folks are opining on the causes and history of this prob=
lem maybe go right to the origin: whomever first made the idiotic decision =
that computers should internally represent an uppercase 'A' with a differen=
t code than a lowercase 'a'. Sure that probably made writing routines to di=
splay a limited set of glyphs on ancient OSs a little easier but logically =
it makes no sense. *It's the same letter!* I guess I can be thankful they d=
idn't add separate codes for italics, bold and serif versions of the letter=
s too. (But at least one company *did* add reversed foreground/background l=
etters to there version of ASCII.) There should only be one code for each l=
etter and everything else should be up to user space.=20


> On 2025-04-30 8:32 PM PDT H. Peter Anvin <hpa@zytor.com> wrote:
>=20
> =20
> On April 30, 2025 8:12:20 PM PDT, Linus Torvalds <torvalds@linux-foundati=
on.org> wrote:
> >On Wed, 30 Apr 2025 at 19:48, H. Peter Anvin <hpa@zytor.com> wrote:
> >>
> >> It is worth noting that Microsoft has basically declared their
> >> "recommended" case folding (upcase) table to be permanently frozen (fo=
r
> >> new filesystem instances in the case where they use an on-disk
> >> translation table created at format time.)  As far as I know they have
> >> never supported anything other than 1:1 conversion of BMP code points,
> >> nor normalization.
> >
> >So no crazy '=C3=9F' matches 'ss' kind of thing? (And yes, afaik that's
> >technically wrong even in German, but afaik at least sorts the same in
> >some locales).
> >
> >Because yes, if MS basically does a 1:1 unicode translation with a
> >fixed table, that is not only "simpler", I think it's what we should
> >strive for.
> >
> >Because I think the *only* valid reason for case insensitive
> >filesystems is "backwards compatibility", and given that, it's
> >_particularly_ stupid to then do anything more complicated and broken
> >than the thing you're trying to be compatible with.
> >
> >I hope to everything holy that nobody ever wants to be compatible with
> >the absolute garbage that is the OSX HFS model.
> >
> >Because the whole "let's actively corrupt names into something that is
> >almost, but not exactly, NFD" stuff is just some next-level evil
> >stuff.
> >
> >            Linus
> >
>=20
> I suspect the NFD bit in HFS comes from the use of decomposed characters =
in the 8-bit character systems of MacOS Classic.

