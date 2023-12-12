Return-Path: <linux-fsdevel+bounces-5729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9BB80F559
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 19:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2451C20A6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8517E782;
	Tue, 12 Dec 2023 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZX1sv8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D5BCA;
	Tue, 12 Dec 2023 10:17:14 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77f35b70944so365624385a.0;
        Tue, 12 Dec 2023 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702405034; x=1703009834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgf35NQICNkg6I7jlAb/v2z/ddQ7MJTeL6OfGIPcb28=;
        b=kZX1sv8DqoyndNNhYD4mbhsoWampL4qauxEcbZj7bssvtVmx5XjL9rm4WTwIVr+kgy
         TeweYOner9vM3ITmB+D5ySKeP7YAzq0SkBG0YWwUHC6gQ1qNvlBcJa7dHIinDyLXdflF
         +NsneaNO+BWACsBU+tMgybKeN/5/rwblacxyy55dsgTjQ7iSGfAXHGzvGe7tcfHcTAMh
         ws/XiwgT6e1p75B241KLvnKpf0Dc6r3cJ6XqwqDvS3RLeev0FZD2dJyenE2tuXNoSuWo
         VF2zcW+41LSS5GyTr0Ps2/osuZToo8H6Fe+DFHHjwOhLyfMHYWEzgxuA9PeNAoeSPEzI
         0f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405034; x=1703009834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgf35NQICNkg6I7jlAb/v2z/ddQ7MJTeL6OfGIPcb28=;
        b=GRKlM1roF+e7FTGs2JUl+YkBe2M98x4ihk1t4i+Aoo2/ko+v4Yz3n+xPERbvIuxCAD
         Iz77HpJrUKfRZksyGxq9w0LMN2sPMkWQEGZG1YPiL7ba/4UL2gXH0JhskqN3TU4aJbtj
         vcdo7nOMgHdIVRtrxi4klL50QrSUOsQyA53SozKjeBb3e3kF/H32UEjB52WnnuhO8FvV
         76sNp2Qf3Z9cNK3xPF62RkZGRRTTJCRHoYqRB9ULDPnkKKOZsHsm4S5SXxzZ5nF6OtYR
         1Yx+7or0sQegFNC6b5HVfv/BrXZDK58e0WmVk7zd4QXqNcmBe1dSizho3BYtxyy4i5de
         Y9dQ==
X-Gm-Message-State: AOJu0YzL6iwnbo1b9iMausTBc4HkCrjQD6TSHiI9Icdn+gLT6Pq9HYWH
	sPunEgx8nav1a+zbjmbcv4pctJyvaPqccIOfbC0=
X-Google-Smtp-Source: AGHT+IF6rIws6HDUwQrj+acbdV0Ps7unQeEoCQ2ikzEnYjF1JPwdY8dvKYNd87wzYL5VoqeCWRwnMhi47a3xKhc8Jl8=
X-Received: by 2002:ad4:44b0:0:b0:67e:ab0b:c93b with SMTP id
 n16-20020ad444b0000000b0067eab0bc93bmr8205223qvt.72.1702405033724; Tue, 12
 Dec 2023 10:17:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area> <e07d2063-1a0b-4527-afca-f6e6e2ecb821@molgen.mpg.de>
 <20231212152016.GB142380@mit.edu> <0b4c01da2d1e$cf65b930$6e312b90$@mindspring.com>
 <20231212174432.toj6c65mlqrlt256@moria.home.lan>
In-Reply-To: <20231212174432.toj6c65mlqrlt256@moria.home.lan>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Dec 2023 20:17:02 +0200
Message-ID: <CAOQ4uxgcUQE9Ldg8rodMXJvbU9BDCC9wGED0jANGrC-OLY1HJQ@mail.gmail.com>
Subject: Re: file handle in statx
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Frank Filz <ffilzlnx@mindspring.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Donald Buczek <buczek@molgen.mpg.de>, Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, 
	linux-bcachefs@vger.kernel.org, Stefan Krueger <stefan.krueger@aei.mpg.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 7:44=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Dec 12, 2023 at 09:15:29AM -0800, Frank Filz wrote:
> > > On Tue, Dec 12, 2023 at 10:10:23AM +0100, Donald Buczek wrote:
> > > > On 12/12/23 06:53, Dave Chinner wrote:
> > > >
> > > > > So can someone please explain to me why we need to try to re-inve=
nt
> > > > > a generic filehandle concept in statx when we already have a have
> > > > > working and widely supported user API that provides exactly this
> > > > > functionality?
> > > >
> > > > name_to_handle_at() is fine, but userspace could profit from being
> > > > able to retrieve the filehandle together with the other metadata in=
 a
> > > > single system call.
> > >
> > > Can you say more?  What, specifically is the application that would w=
ant
> > to do
> > > that, and is it really in such a hot path that it would be a user-vis=
ible
> > > improveable, let aloine something that can be actually be measured?
> >
> > A user space NFS server like Ganesha could benefit from getting attribu=
tes
> > and file handle in a single system call.
> >
> > Potentially it could also avoid some of the challenges of using
> > name_to_handle_at that is a privileged operation.
>
> which begs the question - why is name_to_handle_at() privileged?
>

AFAICT, it is not privileged.
Only open_by_handle_at() is privileged.

Thanks,
Amir.

