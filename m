Return-Path: <linux-fsdevel+bounces-1154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52857D692C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 12:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0CA1C20D06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD7266DD;
	Wed, 25 Oct 2023 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbr2SmSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918915B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 10:42:12 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36091BDB;
	Wed, 25 Oct 2023 03:41:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7789a4c01ddso371588885a.1;
        Wed, 25 Oct 2023 03:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698230518; x=1698835318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waqA3Wuu0WYamjZmXtBbHzp1YM3pbNgPBrZtQ2JTrdM=;
        b=mbr2SmSV3miUD750RE7vqS+m+1hEZdPEg+6mKrAEl8ZnmcB4nHilOn8c/rioVIl95+
         Hj1DdUTbL4O4itVTKd6AWlzbScI095b4XhMIvE6DFgCWlh+eBGQ2GCf7utKtn3TR/a0z
         EHOLNyjEBLNxuCtYTMk6ADWTWQ3skeyyx1YafVSXgtnakWqqLkDT7cY8df9+L/Fe7EG+
         LqAAUxqp6EIttGtA5HqQE5Xdf5F+y/R+23KcxbYErRXGoHvzwtw8owncSCFCdOUapzMQ
         GtTMIKjK6XARd11b7fg61U/4a5ALJmwjG3ubFuwTj/Iyh7tHxRGffFsfx0Uf1kByaQ0Q
         rYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230518; x=1698835318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waqA3Wuu0WYamjZmXtBbHzp1YM3pbNgPBrZtQ2JTrdM=;
        b=SIWQU2Tj7xm6yMkFkZP1I4ws6fdNVn2WKW9C7B8dWQfOlxwnLL1Ewzr0knkNzN7kqx
         pN/UnMm0QTV3+o9ycHscpWo7hRmiswKwCLechXCE20/GmvjNtEYnK9ynLAGPrRo2o1pA
         mKzbIrWSNvNEVZ1VHSsup+H7TIXchUvZv01wg9aGLGIGs2ThvL6OrVK1523Z/ZQLxG68
         NgCcf/tE15CphGJ3Rp+xcswDad7oS0HkRDouvOhVa6UyUQQDejWGn7tJzoti7Je+Hi6q
         Xp2LrXEC02oNKS3VF5yhhFwHlnQAShNdINYBVYq82tEE12Of5hMkjndgDBnI193eR6jH
         Ae8A==
X-Gm-Message-State: AOJu0YzMNkqb7Qw6Cv8hukUc3hJH5BHhna2+Rolsj869sAQNCbP1oVus
	lD63uccw8XLDRogH7rE9mU8Yqmwdzp/zLOSdI1U=
X-Google-Smtp-Source: AGHT+IE1T4f/B4rMNL1sPJuZ3K0wNsQZDTWnBqxx6Z/H8yseAqJoiFBDHVNFekFm4dV4XwCG1j1ncqG33Ax+9qoCLa8=
X-Received: by 2002:a05:620a:10a6:b0:76f:1a6b:571 with SMTP id
 h6-20020a05620a10a600b0076f1a6b0571mr14824898qkk.27.1698230517883; Wed, 25
 Oct 2023 03:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area> <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org> <ZTjMRRqmlJ+fTys2@dread.disaster.area>
In-Reply-To: <ZTjMRRqmlJ+fTys2@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Oct 2023 13:41:46 +0300
Message-ID: <CAOQ4uxj7o4SVyDqXQp-vqjJptXdFpZ736ARjk=L8knc+gaSWXg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Dave Chinner <david@fromorbit.com>
Cc: Jeff Layton <jlayton@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
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

On Wed, Oct 25, 2023 at 11:05=E2=80=AFAM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> > On Tue, 2023-10-24 at 10:08 +0300, Amir Goldstein wrote:
> > > On Tue, Oct 24, 2023 at 6:40=E2=80=AFAM Dave Chinner <david@fromorbit=
.com> wrote:
> > > >
> > > > On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > > > > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.com> =
wrote:
> > > > > >
> > > > > > The problem is the first read request after a modification has =
been
> > > > > > made. That is causing relatime to see mtime > atime and trigger=
ing
> > > > > > an atime update. XFS sees this, does an atime update, and in
> > > > > > committing that persistent inode metadata update, it calls
> > > > > > inode_maybe_inc_iversion(force =3D false) to check if an iversi=
on
> > > > > > update is necessary. The VFS sees I_VERSION_QUERIED, and so it =
bumps
> > > > > > i_version and tells XFS to persist it.
> > > > >
> > > > > Could we perhaps just have a mode where we don't increment i_vers=
ion
> > > > > for just atime updates?
> > > > >
> > > > > Maybe we don't even need a mode, and could just decide that atime
> > > > > updates aren't i_version updates at all?
> > > >
> > > > We do that already - in memory atime updates don't bump i_version a=
t
> > > > all. The issue is the rare persistent atime update requests that
> > > > still happen - they are the ones that trigger an i_version bump on
> > > > XFS, and one of the relatime heuristics tickle this specific issue.
> > > >
> > > > If we push the problematic persistent atime updates to be in-memory
> > > > updates only, then the whole problem with i_version goes away....
> > > >
> > > > > Yes, yes, it's obviously technically a "inode modification", but =
does
> > > > > anybody actually *want* atime updates with no actual other change=
s to
> > > > > be version events?
> > > >
> > > > Well, yes, there was. That's why we defined i_version in the on dis=
k
> > > > format this way well over a decade ago. It was part of some deep
> > > > dark magical HSM beans that allowed the application to combine
> > > > multiple scans for different inode metadata changes into a single
> > > > pass. atime changes was one of the things it needed to know about
> > > > for tiering and space scavenging purposes....
> > > >
> > >
> > > But if this is such an ancient mystical program, why do we have to
> > > keep this XFS behavior in the present?
> > > BTW, is this the same HSM whose DMAPI ioctls were deprecated
> > > a few years back?
>
> Drop the attitude, Amir.
>
> That "ancient mystical program" is this:
>
> https://buy.hpe.com/us/en/enterprise-solutions/high-performance-computing=
-solutions/high-performance-computing-storage-solutions/hpc-storage-solutio=
ns/hpe-data-management-framework-7/p/1010144088
>

Sorry for the attitude Dave, I somehow got the impression that you
were talking about a hypothetical old program that may be out of use.
I believe that Jeff and Linus got the same impression...

> Yup, that product is backed by a proprietary descendent of the Irix
> XFS code base XFS that is DMAPI enabled and still in use today. It's
> called HPE XFS these days....
>

What do you mean?
Do you mean that the HPE product uses patched XFS?
If so, why is that an upstream concern?

Upstream xfs indeed preserves di_dmstate,di_dmevmask, but it does
not change those state members when file changes happen.

So if mounting an HPE XFS disk on with upstream kernel is not
going to record DMAPI state changes, does it matter if upstream
xfs does not update di_changecount on atime change?

Maybe I did not understand the situation w.r.t HPE XFS.

> > > I mean, I understand that you do not want to change the behavior of
> > > i_version update without an opt-in config or mount option - let the d=
istro
> > > make that choice.
> > > But calling this an "on-disk format change" is a very long stretch.
>
> Telling the person who created, defined and implemented the on disk
> format that they don't know what constitutes a change of that
> on-disk format seems kinda Dunning-Kruger to me....
>

OK. I will choose my words more carefully:

I still do not understand, from everything that you have told us
so far, including the mention of the specific product above,
why not updating di_changecount on atime update constitutes
an on-disk format change and not a runtime behavior change.

You also did not address my comment that xfs_repair does not
update di_changecount on any inode changes to the best of my
code reading abilities.

> There are *lots* of ways that di_changecount is now incompatible
> with the VFS change counter. That's now defined as "i_version should
> only change when [cm]time is changed".
>
> di_changecount is defined to be a count of the number of changes
> made to the attributes of the inode.  It's not just atime at issue
> here - we bump di_changecount when make any inode change, including
> background work that does not otherwise change timestamps. e.g.
> allocation at writeback time, unwritten extent conversion, on-disk
> EOF extension at IO completion, removal of speculative
> pre-allocation beyond EOF, etc.
>

I see.
Does xfs update ctime on all those inode block map changes?

> IOWs, di_changecount was never defined as a linux "i_version"
> counter, regardless of the fact we originally we able to implement
> i_version with it - all extra bumps to di_changecount were not
> important to the users of i_version for about a decade.
>
> Unfortunately, the new i_version definition is very much
> incompatible with the existing di_changecount definition and that's
> the underlying problem here. i.e. the problem is not that we bump
> i_version on atime, it's that di_changecount is now completely
> incompatible with the new i_version change semantics.
>
> To implement the new i_version semantics exactly, we need to add a
> new field to the inode to hold this information.
> If we change the on disk format like this, then the atime
> problems go away because the new field would not get updated on
> atime updates. We'd still be bumping di_changecount on atime
> updates, though, because that's what is required by the on-disk
> format.
>

I fully agree with you that we should avoid on-disk format change.
This is exactly the reason that I'm insisting on the point of clarifying
how exactly, this semantic change of di_changecount is going to
break existing applications that run on upstream kernel.

Thanks,
Amir.

