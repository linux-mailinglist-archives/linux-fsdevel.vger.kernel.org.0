Return-Path: <linux-fsdevel+bounces-1223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20EF7D7C5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 07:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B7F281E68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 05:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08E5D2FC;
	Thu, 26 Oct 2023 05:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAa/BcYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A1C2D5
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 05:43:14 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C8A115;
	Wed, 25 Oct 2023 22:43:12 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d17fd450aso13689756d6.1;
        Wed, 25 Oct 2023 22:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698298991; x=1698903791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0wskKT4pWU48/4FUK3iMC6E9ayAZ0MFNFM/wSMas+E=;
        b=EAa/BcYsnp7JMmmWLqeDiBuZKUR8iCzgz6lJRfU3FPBERY/yJ97BxxvxBiYeJLpLxV
         8d65Fr1rip2LIo6dXGnHPK/TVzNNuVAyG4X7O+NbfhBXkl8FfqzSB+bSdjxfdg8el7Qg
         twN9miUJNnTKlJXgVL2NEZDIHCFKYg20ifK740u0laWxKzJjzeEOSmWBeTpD6W58jHhj
         /Z+fe8J1Js0mYQYFWBYWsfqKT6N2DafKzKp2pqQa+DXUcxSpAZm0Bm7opamexc/rpC1T
         414U8roJ7U3gX0Fc+ko2NV1WKtAhuJqInUyA+UtVA2TmEtycnth+bsAqedSY0yHxEP71
         RmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698298991; x=1698903791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0wskKT4pWU48/4FUK3iMC6E9ayAZ0MFNFM/wSMas+E=;
        b=eEmbMQNik1I2c54Q5TKJdpEpYH8LZhg+23v3l/knJpIr/Lp2EUdwchgtYhXXVX5cR2
         sTSsOoFaYqXZsF+PA1zlFRwh4GVspgjXJpY4m51j+33MeE39WnwN7d9zpvqvkGMlBPb0
         6Y4jSMHUzE4wQREA6HFxvEQ54bQdunHcLgmIzg5+2c2oFHse7VXD/EgOJ3SIVpzdRuwe
         Gtc1QOcXIeb5oksIol91xS9UJ2P2LGp0s4iRqxTFOTrgFc/b3KQ+kj7XP5HQihWMgnRw
         CA7Amxf+On7X0HQB8ZDGgo0ViSCWV5NNong5rZKTOkapSSn5jiTcKz7gNEAp14jWl6ZG
         vcWg==
X-Gm-Message-State: AOJu0YwkcnbGVVBkAWBj/GTNZKtkdF9bPeVpgdYa5abct+Y+NfppBYio
	KOLByHuaFsvrgvRQ6YMzas1hSZtugUwMnWlBPKU=
X-Google-Smtp-Source: AGHT+IFtQlJkyk/SemAvlLy18H81rmH3bjGyS6GSbs3XB/X6xHM1ikIcbtxNFkrSUvjSK3z+n/Qk1ZPsdGmCwdu5uo4=
X-Received: by 2002:a05:6214:242b:b0:66d:9987:68f9 with SMTP id
 gy11-20020a056214242b00b0066d998768f9mr2382116qvb.15.1698298991118; Wed, 25
 Oct 2023 22:43:11 -0700 (PDT)
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
 <ZTnNCytHLGoJY9ds@dread.disaster.area>
In-Reply-To: <ZTnNCytHLGoJY9ds@dread.disaster.area>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Oct 2023 08:42:59 +0300
Message-ID: <CAOQ4uxjJdpPQAUfSf1EVWu-wxtmU63X=cwgoNHrhY-Ls5KWo5g@mail.gmail.com>
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

On Thu, Oct 26, 2023 at 5:21=E2=80=AFAM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Wed, Oct 25, 2023 at 08:25:35AM -0400, Jeff Layton wrote:
> > On Wed, 2023-10-25 at 19:05 +1100, Dave Chinner wrote:
> > > On Tue, Oct 24, 2023 at 02:40:06PM -0400, Jeff Layton wrote:
> > > > On Tue, 2023-10-24 at 10:08 +0300, Amir Goldstein wrote:
> > > > > On Tue, Oct 24, 2023 at 6:40=E2=80=AFAM Dave Chinner <david@fromo=
rbit.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 23, 2023 at 02:18:12PM -1000, Linus Torvalds wrote:
> > > > > > > On Mon, 23 Oct 2023 at 13:26, Dave Chinner <david@fromorbit.c=
om> wrote:
> > > > > Does xfs_repair guarantee that changes of atime, or any inode cha=
nges
> > > > > for that matter, update i_version? No, it does not.
> > > > > So IMO, "atime does not update i_version" is not an "on-disk form=
at change",
> > > > > it is a runtime behavior change, just like lazytime is.
> > > >
> > > > This would certainly be my preference. I don't want to break any
> > > > existing users though.
> > >
> > > That's why I'm trying to get some kind of consensus on what
> > > rules and/or atime configurations people are happy for me to break
> > > to make it look to users like there's a viable working change
> > > attribute being supplied by XFS without needing to change the on
> > > disk format.
> > >
> >
> > I agree that the only bone of contention is whether to count atime
> > updates against the change attribute. I think we have consensus that al=
l
> > in-kernel users do _not_ want atime updates counted against the change
> > attribute. The only real question is these "legacy" users of
> > di_changecount.
>
> Please stop refering to "legacy users" of di_changecount. Whether
> there are users or not is irrelevant - it is defined by the current
> on-disk format specification, and as such there may be applications
> we do not know about making use of the current behaviour.
>
> It's like a linux syscall - we can't remove them because there may
> be some user we don't know about still using that old syscall. We
> simply don't make changes that can potentially break user
> applications like that.
>
> The on disk format is the same - there is software out that we don't
> know about that expects a certain behaviour based on the
> specification. We don't break the on disk format by making silent
> behavioural changes - we require a feature flag to indicate
> behaviour has changed so that applications can take appropriate
> actions with stuff they don't understand.
>
> The example for this is the BIGTIME timestamp format change. The on
> disk inode structure is physically unchanged, but the contents of
> the timestamp fields are encoded very differently. Sure, the older
> kernels can read the timestamp data without any sort of problem
> occurring, except for the fact the timestamps now appear to be
> completely corrupted.
>
> Changing the meaning of ithe contents of di_changecount is no
> different. It might look OK and nothing crashes, but nothing can be
> inferred from the value in the field because we don't know how it
> has been modified.
>

I don't agree that this change is the same as BIGTIME change,
but it is a good queue to ask:
BIGTIME has an on-disk feature bit in super block that can be set on an
existing filesystem (and not cleared?).
BIGTIME also has an on-disk inode flag to specify the format in which a
specific inode timestampts are stored.

If we were to change the xfs on-disk to change the *meaning* (not the
format that the counter is stored) of di_changecount, would the feature
flag need be RO_COMPAT?
Would this require a per-inode on-disk flag that declares the meaning
of di_changecount on that specific inode?

Neither of those changes is going to be very hard to do btw.
Following the footsteps of the BIGTIME conversion, but without the
need for an actual format convertors.

Thanks,
Amir.

