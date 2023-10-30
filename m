Return-Path: <linux-fsdevel+bounces-1596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5F87DC334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 00:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5090281422
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Oct 2023 23:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C7F199DC;
	Mon, 30 Oct 2023 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StsKUXHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B1199AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 23:34:31 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1878AC2;
	Mon, 30 Oct 2023 16:34:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-280208d0679so2009212a91.3;
        Mon, 30 Oct 2023 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698708869; x=1699313669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CB/3ERKRQdAoGXS7P/nKVgYxNOJttrjEEJi0MqI70I=;
        b=StsKUXHnHL0oe/T5YUem4UDTgF6IduM78QLJe1Bkc8+gM2JpJfJIuxoZbvyKTPPde5
         btq8Y3o7Tk/b1Hev5abk8sjWk0YVK5hdlOsMs1x+4uqHFmX2Ljn1pNnXuK96aKznjRJa
         5st8Me2+B1vFja3JXpjSjTyWfquKapF0B/5bkFFDy/qQYoBfYaLeBMpPHoq5iEShT8pP
         ArgC3w7LcsY4szuUEH/9I3nUoJyeggXGvyA3zI/zEb+X66qRjtbpNt6RIS0rZ5iMlKT5
         qSojvfE/vv/NsJznqIqpWosItRl5ExLZMLIw3KmrEcHYdAEdjBY/e9xZl+xKKPKcjTpB
         DpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698708869; x=1699313669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CB/3ERKRQdAoGXS7P/nKVgYxNOJttrjEEJi0MqI70I=;
        b=ZVs6qr/YtOP3M/ikA/csc7k2OjEX9VLksZLsSDk8JFPs7LvICo31Vw+kZcfR5zKW5C
         3ob5hYePaqxJu9SvlW1LJagvx+EPTf23pxNCwKCuh+Bm6Vstm+RuMjPzQtvXYlKeN1co
         4AKRj79qgYf27ZlCwNb2iO91eJMJjUrjlncOVhUjpUWTGPWguUer2uEcCMP17jiwc0pB
         x28QOHxPTkTCZWBTqDS4MhmLYh64FoYE4/ZPiyFDCE7Q1nGkemAMuVu7qkhVw4gy1ZzQ
         /T/aItqaFORLnZ2XrGOXF8fQCC8Eoz67dewWAYKbnXzuHdx8lnA22QoUesrZIaYgVbG2
         bMqA==
X-Gm-Message-State: AOJu0Yzrp+mDny8AvaG2bSELavPMZrM3FqObjD8NGXQ0KbS76ThBN14w
	1A0RmoxGaBwPjJ1b/Jx+Z+jYNz1O6GdQNKFJ6qg=
X-Google-Smtp-Source: AGHT+IEAugpy3wr2zQZYMIj1sg1O84YQKmvDQqdjxa/hgZpDKapgYd0DVREWOS9HC7ol9Dny9A/VBbe0vPnwbLGx634=
X-Received: by 2002:a17:90a:b004:b0:280:4f82:68ac with SMTP id
 x4-20020a17090ab00400b002804f8268acmr3176366pjq.24.1698708869296; Mon, 30 Oct
 2023 16:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <ZTWfX3CqPy9yCddQ@dread.disaster.area> <61b32a4093948ae1ae8603688793f07de764430f.camel@kernel.org>
 <ZTcBI2xaZz1GdMjX@dread.disaster.area> <CAHk-=whphyjjLwDcEthOOFXXfgwGrtrMnW2iyjdQioV6YSMEPw@mail.gmail.com>
 <ZTc8tClCRkfX3kD7@dread.disaster.area> <CAOQ4uxhJGkZrUdUJ72vjRuLec0g8VqgRXRH=x7W9ogMU6rBxcQ@mail.gmail.com>
 <d539804a2a73ad70265c5fa599ecd663cd235843.camel@kernel.org>
 <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
In-Reply-To: <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Tue, 31 Oct 2023 09:34:17 +1000
Message-ID: <CAN05THQZKe5e+KCWX4gbz6MH633q6wTbNbukLpeTPKcRSWFo-w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Jeff Layton <jlayton@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
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

On Fri, 27 Oct 2023 at 20:36, Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2023-10-26 at 13:20 +1100, Dave Chinner wrote:
> > On Wed, Oct 25, 2023 at 08:25:35AM -0400, Jeff Layton wrote:
> > > On Wed, 2023-10-25 at 19:05 +1100, Dave Chinner wrote:
> > > > On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> > > > > On Tue, 2023-10-24 at 10:08 +0300, Amir Goldstein wrote:
> > > > > > On Tue, Oct 24, 2023 at 6:40=E2=80=AFAM Dave Chinner <david@fro=
morbit.com> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrot=
e:
> > > > > > > > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit=
.com> wrote:
> > > > > > Does xfs_repair guarantee that changes of atime, or any inode c=
hanges
> > > > > > for that matter, update i_version? No, it does not.
> > > > > > So IMO, "atime does not update i_version" is not an "on-disk fo=
rmat change",
> > > > > > it is a runtime behavior change, just like lazytime is.
> > > > >
> > > > > This would certainly be my preference. I don't want to break any
> > > > > existing users though.
> > > >
> > > > That's why I'm trying to get some kind of consensus on what
> > > > rules and/or atime configurations people are happy for me to break
> > > > to make it look to users like there's a viable working change
> > > > attribute being supplied by XFS without needing to change the on
> > > > disk format.
> > > >
> > >
> > > I agree that the only bone of contention is whether to count atime
> > > updates against the change attribute. I think we have consensus that =
all
> > > in-kernel users do _not_ want atime updates counted against the chang=
e
> > > attribute. The only real question is these "legacy" users of
> > > di_changecount.
> >
> > Please stop refering to "legacy users" of di_changecount. Whether
> > there are users or not is irrelevant - it is defined by the current
> > on-disk format specification, and as such there may be applications
> > we do not know about making use of the current behaviour.
> >
> > It's like a linux syscall - we can't remove them because there may
> > be some user we don't know about still using that old syscall. We
> > simply don't make changes that can potentially break user
> > applications like that.
> >
> > The on disk format is the same - there is software out that we don't
> > know about that expects a certain behaviour based on the
> > specification. We don't break the on disk format by making silent
> > behavioural changes - we require a feature flag to indicate
> > behaviour has changed so that applications can take appropriate
> > actions with stuff they don't understand.
> >
> > The example for this is the BIGTIME timestamp format change. The on
> > disk inode structure is physically unchanged, but the contents of
> > the timestamp fields are encoded very differently. Sure, the older
> > kernels can read the timestamp data without any sort of problem
> > occurring, except for the fact the timestamps now appear to be
> > completely corrupted.
> >
> > Changing the meaning of ithe contents of di_changecount is no
> > different. It might look OK and nothing crashes, but nothing can be
> > inferred from the value in the field because we don't know how it
> > has been modified.
> >
> > Hence we can't just change the meaning, encoding or behaviour of an
> > on disk field that would result in existing kernels and applications
> > doing the wrong thing with that field (either read or write) without
> > adding a feature flag to indicate what behaviour that field should
> > have.
> >
> > > > > Perhaps this ought to be a mkfs option? Existing XFS filesystems =
could
> > > > > still behave with the legacy behavior, but we could make mkfs.xfs=
 build
> > > > > filesystems by default that work like NFS requires.
> > > >
> > > > If we require mkfs to set a flag to change behaviour, then we're
> > > > talking about making an explicit on-disk format change to select th=
e
> > > > optional behaviour. That's precisely what I want to avoid.
> > > >
> > >
> > > Right. The on-disk di_changecount would have a (subtly) different
> > > meaning at that point.
> > >
> > > It's not a change that requires drastic retooling though. If we were =
to
> > > do this, we wouldn't need to grow the on-disk inode. Booting to an ol=
der
> > > kernel would cause the behavior to revert. That's sub-optimal, but no=
t
> > > fatal.
> >
> > See above: redefining the contents, behaviour or encoding of an on
> > disk field is a change of the on-disk format specification.
> >
> > The rules for on disk format changes that we work to were set in
> > place long before I started working on XFS.  They are sane, well
> > thought out rules that have stood the test of time and massive new
> > feature introductions (CRCs, reflink, rmap, etc). And they only work
> > because we don't allow anyone to bend them for convenience, short
> > cuts or expediting their pet project.
> >
> > > What I don't quite understand is how these tools are accessing
> > > di_changecount?
> >
> > As I keep saying: this is largely irrelevant to the problem at hand.
> >
> > > XFS only accesses the di_changecount to propagate the value to and fr=
om
> > > the i_version,
> >
> > Yes.  XFS has a strong separation between on-disk structures and
> > in-memory values, and i_version is simply the in-memory field we use
> > to store the current di_changecount value.  We force bump i_version
> > every time we modify the inode core regardless of whether anyone has
> > queried i_version because that's what di_changecount requires. i.e.
> > the filesystem controls the contents of i_version, not the VFS.
> >
> > Now that NFS is using a proper abstraction (i.e. vfs_statx()) to get
> > the change cookie, we really don't need to expose di_changecount in
> > i_version at all - we could simply copy an internal di_changecount
> > value into the statx cookie field in xfs_vn_getattr() and there
> > would be almost no change of behaviour from the perspective of NFS
> > and IMA at all.
> >
> > > and there is nothing besides NFSD and IMA that queries
> > > the i_version value in-kernel. So, this must be done via some sort of
> > > userland tool that is directly accessing the block device (or some 3r=
d
> > > party kernel module).
> >
> > Yup, both of those sort of applications exist. e.g. the DMAPI kernel
> > module allows direct access to inode metadata through a custom
> > bulkstat formatter implementation - it returns different information
> > comapred to the standard XFS one in the upstream kernel.
> >
> > > In earlier discussions you alluded to some repair and/or analysis too=
ls
> > > that depended on this counter.
> >
> > Yes, and one of those "tools" is *me*.
> >
> > I frequently look at the di_changecount when doing forensic and/or
> > failure analysis on filesystem corpses.  SOE analysis, relative
> > modification activity, etc all give insight into what happened to
> > the filesystem to get it into the state it is currently in, and
> > di_changecount provides information no other metadata in the inode
> > contains.
> >
> > > I took a quick look in xfsprogs, but I
> > > didn't see anything there. Is there a library or something that these
> > > tools use to get at this value?
> >
> > xfs_db is the tool I use for this, such as:
> >
> > $ sudo xfs_db -c "sb 0" -c "a rootino" -c "p v3.change_count" /dev/mapp=
er/fast
> > v3.change_count =3D 35
> > $
> >
> > The root inode in this filesystem has a change count of 35. The root
> > inode has 32 dirents in it, which means that no entries have ever
> > been removed or renamed. This sort of insight into the past history
> > of inode metadata is largely impossible to get any other way, and
> > it's been the difference between understanding failure and having no
> > clue more than once.
> >
> > Most block device parsing applications simply write their own
> > decoder that walks the on-disk format. That's pretty trivial to do,
> > developers can get all the information needed to do this from the
> > on-disk format specification documentation we keep on kernel.org...
> >
>
> Fair enough. I'm not here to tell you that you guys that you need to
> change how di_changecount works. If it's too valuable to keep it
> counting atime-only updates, then so be it.
>
> If that's the case however, and given that the multigrain timestamp work
> is effectively dead, then I don't see an alternative to growing the on-
> disk inode. Do you?

Would a new mount option be a viable alternative?
A new option that would when used change the semantics of these fields
to what NFS needs?
With the caveat: using this mount option may break other special tools
that depend on the default
semantics.


> --
> Jeff Layton <jlayton@kernel.org>

