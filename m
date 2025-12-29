Return-Path: <linux-fsdevel+bounces-72190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEAACE715F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD058300C175
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1525322DD4;
	Mon, 29 Dec 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF7cadIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA780322B76
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019247; cv=none; b=K9KNoPmaY9L1Pop93n5AQqOSi6VqaZUWl4vh1CXIn0S6aloQhtyfmPbVr/DkRYGCPT9rv7lGBmO8uqAxcWxVTdDKRhHZoKX396IQCOgoabkpCbvpAIHe0zQu8cjFEN73DUwGyTqk6HHBKYXoCCj+yUpFA6wq7Ti3uahJys+c3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019247; c=relaxed/simple;
	bh=gAR5yydwbLjk8rlSrozhNMcuwMr+BSppZpkjO8mKxVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIqTiC3qbLvm9eTBg32vBjA/S5fyHjmAmewRy8J4fL7j1cxSZIzULECgCIEaJc1efbIXw13x3cAqPclwzzg8eoIKfiyizNQJ9Ew2eAYVG/4E0yK7bePIFNXFmAL3JS+G8l2ob5cCHKNIEz+HwsE7DqgkvcM00waBKSSnbMucFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF7cadIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830C5C2BC9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767019247;
	bh=gAR5yydwbLjk8rlSrozhNMcuwMr+BSppZpkjO8mKxVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JF7cadIinXtBtXNOl0D+GhJcWdKKPP0QXfh3G9ZgzyqGOod702h+tXs6Son4Wp+EK
	 O1etKQDNOwD9Q8sJGAMWUkicpohyaB2pkIAnAYGvdKbFhB4D6Xx2dbCP5MvBdrTO3+
	 WcMbmncOn39FjHEffXqoK1AiiDd6aP3keR9r4X97Gk/NAyCBoT+XCSCBrv8qkyZJ9X
	 8EVj23HPzp3lpVl0g51FaeS19sMytt5gLKOwGRq5C0zINVLdzboWETNVk96BfcS1Qb
	 7c72Ax+iV8XdYYsZVD/OwxCC4kOdq/U6amKTcXQSeBxKYzav/qlYvLNNQCoWjxz1l/
	 iowSAOR08tm0g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b728a43e410so1720775766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 06:40:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZkyVSEByy5XipZLw0eJEwEEy9ynCt5xGuCy7dyhg8ojovaSIIjHsH0DpUxugleZwfZuYvyvSsEOhQ6T00@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVPSebaSovTxhLEUQKulT2z7o2rzojU870JXfgyruWofwWEJ1
	j5+Tr6eMf1J3FrD7s8DJgoY12OMRpyfZ+EKZXedGkPPt2xyIDdU+IXa1cO/VpCei12VckaU798s
	q5Y3fAeExvngYMq3KxtibE35FTDigUlI=
X-Google-Smtp-Source: AGHT+IFxLyol+ej7/T/qYqap4HLhpuHDmlKJqTqqUlbaqYygMReAvTCHqZOUd2WP6jZxvCk5Hj+BfUXnO0JpqGdxtII=
X-Received: by 2002:a17:907:cc81:b0:b80:40fe:92c with SMTP id
 a640c23a62f3a-b8040fe2351mr1751673166b.24.1767019246069; Mon, 29 Dec 2025
 06:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-15-linkinjeon@kernel.org>
 <CAOQ4uxh3MM1kToyhpcGR98pD8dH_FMyyvsngnexuqpjU14RfzA@mail.gmail.com>
In-Reply-To: <CAOQ4uxh3MM1kToyhpcGR98pD8dH_FMyyvsngnexuqpjU14RfzA@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 29 Dec 2025 23:40:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-rPJHEbwUezd+809=z2hZE_35_4uGTZA=DsLnOrj6vxA@mail.gmail.com>
X-Gm-Features: AQt7F2p49E5e1iF2FCwPcENtnJJg8NxZ5g_pr9UBhB8iEP6PYsglfqnTIWDS7Fg
Message-ID: <CAKYAXd-rPJHEbwUezd+809=z2hZE_35_4uGTZA=DsLnOrj6vxA@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] MAINTAINERS: add ntfs filesystem
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Anton Altaparmakov <anton@tuxera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 11:30=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, Dec 29, 2025 at 2:44=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > Add myself and Hyunchul Lee as ntfs maintainer.
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 12f49de7fe03..adf80c8207f1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18646,6 +18646,15 @@ W:     https://github.com/davejiang/linux/wiki
> >  T:     git https://github.com/davejiang/linux.git
> >  F:     drivers/ntb/hw/intel/
> >
> > +NTFS FILESYSTEM
> > +M:     Namjae Jeon <linkinjeon@kernel.org>
> > +M:     Hyunchul Lee <hyc.lee@gmail.com>
> > +L:     linux-fsdevel@vger.kernel.org
> > +S:     Maintained
> > +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/nt=
fs.git
> > +F:     Documentation/filesystems/ntfs.rst
> > +F:     fs/ntfs/
> > +
>
> Would have been nicer and more informative if you kept MAINTAINERS
> in the first revert patch and then really "Add yourself and Hyunchul
> Less as maintainers".
Okay.
>
> A note about the CREDITS file.
> Willy's deprecate commit that you partially reverted added this CREDITS r=
ecord:
> `
> NTFS FILESYSTEM
> N: Anton Altaparmakov
> E: anton@tuxera.com
> D: NTFS filesystem
> `
>
> It is oddly formatted - this NTFS FILESYSTEM header is uncovetional in
> this file.
> and also, Anton already had a more descriptive entry in the CREDITS file:
Right.
> `
> N: Anton Altaparmakov
> E: aia21@cantab.net
> W: http://www-stu.christs.cam.ac.uk/~aia21/
> D: Author of new NTFS driver, various other kernel hacks.
> S: Christ's College
> S: Cambridge CB2 3BU
> S: United Kingdom
> `
>
> So I think that the later entry could be reverted along with the revert c=
ommit
> and maybe add or update to the Tuxera email/website entries, because the
> current W link in CREDITS is broken.
Okay, I will update it on v4.

Thanks for your review!
>
> Thanks,
> Amir.

