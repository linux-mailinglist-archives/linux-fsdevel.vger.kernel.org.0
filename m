Return-Path: <linux-fsdevel+bounces-981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEDB7D47FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937171F21BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 07:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11B913AE0;
	Tue, 24 Oct 2023 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkuzKWGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8EF134C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:08:41 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60402118;
	Tue, 24 Oct 2023 00:08:40 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d0ea3e5b8so28240466d6.0;
        Tue, 24 Oct 2023 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698131319; x=1698736119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqdvkUsqWd4zu3IEIRbwUNktCPDbd/gk6A5nLT4VIeM=;
        b=FkuzKWGPgKu23f7MQ6y7O95S5s8tdJxnEbTm32ctOfOzqfZw7wYlQ2m+cQebQCvLmI
         QdA81shifDt2PODrds6dL+fS7CXobtOJCrjpR6bG7dbnqTbba20b86rafCdcSTgR/Yyi
         KzSHzflOfAjLM2oAOpuInTpgoRIjN73+gB70dH5KP1MKe/mVp8Smo8dLW+Vl/yJcO+tw
         x3qxY8+uEOiMj50y9K1UEbNMMdyd7u0+YttX0ItYMBsV9yKRN/Tkedh1b/9VeZK5b99n
         He/6UcX91drwZ24+2yQtdX/e1Wv5PULL+1PepPdkeFoREss0CjJrH3ThxhlylPut3C+j
         ZTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698131319; x=1698736119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqdvkUsqWd4zu3IEIRbwUNktCPDbd/gk6A5nLT4VIeM=;
        b=NkEpQjSoPD02q96gAuiLXCwVsdB03WrXXvWt/qHtUYGeWVvS2Bam1So3U1/5ingnnE
         MViCUCkh/KACYZodogDDXXtIEdxr793RkFpEi3WIjMAlKGagpq7br7iFApD14Htz4wbC
         sIgT0eZJbNtXprhehOU/aZOnCuKyCESJpLETvndw5OUtg/lodN0SXWO0J+3UyzSyEfzJ
         jicRp82Ox19E+35RtfgT+ke9gdjMJLDvzrwpNxs69o84ZsudXimUaGyH8XWuIyMTe6Fq
         piwtM24i5NI39wmAuYESGr0FRvb1sE7RqGRbe6gM1DRz5vOJ4pqqozKNRwsTq7jtvHTm
         TOOQ==
X-Gm-Message-State: AOJu0YyG7MvE0y3hL5cdKABpm48QPrTnT6hVCTG2qoAOdUeNh3TSJg2n
	dVnZM2byIrYgctYY8om2S5gHu0XtNmHRZBrpzp4=
X-Google-Smtp-Source: AGHT+IE3cbJpQKZFd6RGOof+Net59golChwN9iI+4rus52ve4TnU6zTtzWsEuc24BZZmeNAApernLLkRejdVGhlj2/w=
X-Received: by 2002:a05:6214:224c:b0:658:7441:ff1b with SMTP id
 c12-20020a056214224c00b006587441ff1bmr14513785qvc.45.1698131319478; Tue, 24
 Oct 2023 00:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area>
In-Reply-To: <ZTc8tClCRkfX3kD7@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Oct 2023 10:08:28 +0300
Message-ID: <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 6:40=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > The problem is the first read request after a modification has been
> > > made. That is causing relatime to see mtime > atime and triggering
> > > an atime update. XFS sees this, does an atime update, and in
> > > committing that persistent inode metadata update, it calls
> > > inode_maybe_inc_iversion(force =3D false) to check if an iversion
> > > update is necessary. The VFS sees I_VERSION_QUERIED, and so it bumps
> > > i_version and tells XFS to persist it.
> >
> > Could we perhaps just have a mode where we don't increment i_version
> > for just atime updates?
> >
> > Maybe we don't even need a mode, and could just decide that atime
> > updates aren't i_version updates at all?
>
> We do that already - in memory atime updates don't bump i_version at
> all. The issue is the rare persistent atime update requests that
> still happen - they are the ones that trigger an i_version bump on
> XFS, and one of the relatime heuristics tickle this specific issue.
>
> If we push the problematic persistent atime updates to be in-memory
> updates only, then the whole problem with i_version goes away....
>
> > Yes, yes, it's obviously technically a "inode modification", but does
> > anybody actually *want* atime updates with no actual other changes to
> > be version events?
>
> Well, yes, there was. That's why we defined i_version in the on disk
> format this way well over a decade ago. It was part of some deep
> dark magical HSM beans that allowed the application to combine
> multiple scans for different inode metadata changes into a single
> pass. atime changes was one of the things it needed to know about
> for tiering and space scavenging purposes....
>

But if this is such an ancient mystical program, why do we have to
keep this XFS behavior in the present?
BTW, is this the same HSM whose DMAPI ioctls were deprecated
a few years back?

I mean, I understand that you do not want to change the behavior of
i_version update without an opt-in config or mount option - let the distro
make that choice.
But calling this an "on-disk format change" is a very long stretch.

Does xfs_repair guarantee that changes of atime, or any inode changes
for that matter, update i_version? No, it does not.
So IMO, "atime does not update i_version" is not an "on-disk format change"=
,
it is a runtime behavior change, just like lazytime is.

Thanks,
Amir.

