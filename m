Return-Path: <linux-fsdevel+bounces-4465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B27FF9CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6A9B20927
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916D54F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee2eCo0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8EFDD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:23:33 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a8a745c43so4615436d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365013; x=1701969813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjBCRIIuapqODUW9hH39Q0ot+B5aRMWKzyGEFZxEaMY=;
        b=ee2eCo0bnKqa6ua7JXaGFAvvFYH9EEOdlD6n/Ko1HpnHJ66Hl4U+iPGI7dkWkNXGnv
         3T2dOvzpHntXYN5ltMPsQ20TjV80Ouboup6krDXWwtzF+Jbh/QN+16Uj+X+YirQDiiqM
         E6I5s7lAjN9pgKnprK5S87K2wd5H/S5GCfUGUK0p6hMbv7MRqZa76nzhAjW/oG0EvlHE
         4UMpWt34dRAVGKKpsqhWfp1j0W6PpEEoF5EAOjelT/fquO6yGCarnGlQGCTDDHx2g9Hm
         eZCE8eUhX+Qr0vQNFs7g0grCg/bRmHcjYjZjkAxAy7HLZtiR4wEiXo2EebpmkBOOvYJz
         uRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365013; x=1701969813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjBCRIIuapqODUW9hH39Q0ot+B5aRMWKzyGEFZxEaMY=;
        b=qIj2XTODNBn9mJotEIUxnrbIpZjECRjRIHcXb3ih8nuaDqyUX5g/MP3ERbyPxt0y38
         xQaZUozeOc9BlTjvh1jIltyOfGjreKx5W3jztrr717pSsp4tVP8slsBk7UYqolh504xj
         NMGPWMOOVaKcwblyUBS3CvlIS0ndi6MaWUG8VjT/WQbVwYxxjmbZFvUMV32o0HzbHSJ6
         j27dfrQVblWdmM6AU9sgD8cLqINrm6080u6yuNTZmzV1eGCXAL+gJV6f/DLErZtUWpWT
         NNlKpwSMVl/+ovkByq6sRD7uur/jag/lcadK7Y5CB7Kq2pyo28tL60l33G/I2zQQSBpO
         kzTQ==
X-Gm-Message-State: AOJu0YwmTUe9Gn5dzptSpC6k3qfnIwqcZNF4XbW8FQvyO5uXwbMD7S8D
	Sju76T1tsDZ/2POLfmnojnCbi2QTdMk9ySXrfP5xEdOoidM=
X-Google-Smtp-Source: AGHT+IGLFAJJybnTWzsq712JG2Ja0DqHpj8qBioecTHiYxQZ2udQQYkIdaj7mEa97NPk7bULKJnkMBHz3saiyuz1nQU=
X-Received: by 2002:ad4:4f41:0:b0:67a:8b52:871a with SMTP id
 eu1-20020ad44f41000000b0067a8b52871amr1621753qvb.31.1701365012764; Thu, 30
 Nov 2023 09:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130165619.3386452-1-amir73il@gmail.com> <20231130165619.3386452-3-amir73il@gmail.com>
 <20231130171216.qrrtlitprrkrbt54@quack3> <CAOQ4uxgJAZ3z5pgbfH+hNGj1G9EWQxQ4Hz4h+9X0xTktdiqsWA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgJAZ3z5pgbfH+hNGj1G9EWQxQ4Hz4h+9X0xTktdiqsWA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 19:23:21 +0200
Message-ID: <CAOQ4uxgRTA9v66MkvcPaKjs3QrH0m09NhWr5+LfZoyJWXKd8ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: allow "weak" fsid when watching a single filesystem
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 7:18=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Nov 30, 2023 at 7:12=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 30-11-23 18:56:19, Amir Goldstein wrote:
> > > So far, fanotify returns -ENODEV or -EXDEV when trying to set a mark
> > > on a filesystem with a "weak" fsid, namely, zero fsid (e.g. fuse), or
> > > non-uniform fsid (e.g. btrfs non-root subvol).
> > >
> > > When group is watching inodes all from the same filesystem (or subvol=
),
> > > allow adding inode marks with "weak" fsid, because there is no ambigu=
ity
> > > regarding which filesystem reports the event.
> > >
> > > The first mark added to a group determines if this group is single or
> > > multi filesystem, depending on the fsid at the path of the added mark=
.
> > >
> > > If the first mark added has a "strong" fsid, marks with "weak" fsid
> > > cannot be added and vice versa.
> > >
> > > If the first mark added has a "weak" fsid, following marks must have
> > > the same "weak" fsid and the same sb as the first mark.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Yep, this is good. Can you please repost the whole series so that b4 ca=
n
> > easily pick it up from the list ;)? Thanks!
>
> hmm. I posted all but they did not hit the list :-/
> now reposted.

damnit! only the first REPOST patch hit the list,
but the first v2 patch now trickled.

You can get it from github if you prefer:
https://github.com/amir73il/linux/commits/fanotify_fsid

Thanks,
Amir.

