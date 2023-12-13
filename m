Return-Path: <linux-fsdevel+bounces-5986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4755811AD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5841BB21204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A945579B;
	Wed, 13 Dec 2023 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCjqTyEE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8051C31;
	Wed, 13 Dec 2023 17:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC89C433CA;
	Wed, 13 Dec 2023 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702488152;
	bh=MdFfxmRqnU2pgiKIHVjpuT5qM/n8AmSOleAkAeYhZzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nCjqTyEEwYAqdW8/rlU/X2qNfvBr2d9kOIKAiAWZ9qncIg+m+22IilZcJEY8VRoTX
	 7PgbJV6HZ5JLE3sDdfsX2UHiaQmp3mY3zRbfmkxhAQWJ83UeIlzK3XIiaKF4vV3C3f
	 l9pxj+2hx8VjnlJ2uwTuDTSGTfuTbmQMk1sflXBlXe0SOkan+3n93ddJV7VKUEfu0Z
	 MZFFlYrGAojnFk9Ri12mVxePt5n8d5wu+mgtpl3OjT9ECbV+/ED8mE03YSGnU9dACx
	 ItkqIXFCrBxK8l26h8/TEEuSPhBnj4lDFVScIjFLiDXKOzURPiqtz1dSaT/lmYKVu+
	 rig24IG2XtNVw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso9710812e87.0;
        Wed, 13 Dec 2023 09:22:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yy2uYAhtI/7k+yf9Nu6M0xCqF7BTg6Pqn9wGukmtqAQXHv1sMP6
	XEI8kv4E9uG7B072YJbHPSp10FfY7W7/1rN9ew==
X-Google-Smtp-Source: AGHT+IFqzlN5cXgUWTtVKqvQkSS2vQPSTV20xZkO0pzlfuqEtQX8svaifgRBAAqLPVw/kWvXPFUvtTzHkFE1kxDLXyI=
X-Received: by 2002:ac2:5504:0:b0:50c:a39:ee37 with SMTP id
 j4-20020ac25504000000b0050c0a39ee37mr4154700lfk.109.1702488150631; Wed, 13
 Dec 2023 09:22:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-12-alexandru.elisei@arm.com> <CAL_Jsq+k5BeM9+u12AQvWQ0b4Uv5Cy0vPOpK_uLcYtRnunq4iQ@mail.gmail.com>
 <ZXiMiLz9ZyUdxUP8@raptor> <CAL_Jsq+U_GR=mOK3-phnd4jeJKf79aOmhPwDOSj+f=s-7fZZWQ@mail.gmail.com>
 <ZXmr-Kl9L2SO13--@raptor> <CAL_JsqL=P1Y6w38LD_xw+vK4CNqt22FW_FE9oi_XTLHVQEne7Q@mail.gmail.com>
 <ZXnE3724jYYSg4o6@raptor>
In-Reply-To: <ZXnE3724jYYSg4o6@raptor>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Dec 2023 11:22:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJgTnuQjo13cKo1Ebm5j9tCRT8GhNavdqu5vwp+fdnTLw@mail.gmail.com>
Message-ID: <CAL_JsqJgTnuQjo13cKo1Ebm5j9tCRT8GhNavdqu5vwp+fdnTLw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 11/27] arm64: mte: Reserve tag storage memory
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, pcc@google.com, 
	steven.price@arm.com, anshuman.khandual@arm.com, vincenzo.frascino@arm.com, 
	david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 8:51=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> Hi,
>
> On Wed, Dec 13, 2023 at 08:06:44AM -0600, Rob Herring wrote:
> > On Wed, Dec 13, 2023 at 7:05=E2=80=AFAM Alexandru Elisei
> > <alexandru.elisei@arm.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Tue, Dec 12, 2023 at 12:44:06PM -0600, Rob Herring wrote:
> > > > On Tue, Dec 12, 2023 at 10:38=E2=80=AFAM Alexandru Elisei
> > > > <alexandru.elisei@arm.com> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > Thank you so much for the feedback, I'm not very familiar with de=
vice tree,
> > > > > and any comments are very useful.
> > > > >
> > > > > On Mon, Dec 11, 2023 at 11:29:40AM -0600, Rob Herring wrote:
> > > > > > On Sun, Nov 19, 2023 at 10:59=E2=80=AFAM Alexandru Elisei
> > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > >
> > > > > > > Allow the kernel to get the size and location of the MTE tag =
storage
> > > > > > > regions from the DTB. This memory is marked as reserved for n=
ow.
> > > > > > >
> > > > > > > The DTB node for the tag storage region is defined as:
> > > > > > >
> > > > > > >         tags0: tag-storage@8f8000000 {
> > > > > > >                 compatible =3D "arm,mte-tag-storage";
> > > > > > >                 reg =3D <0x08 0xf8000000 0x00 0x4000000>;
> > > > > > >                 block-size =3D <0x1000>;
> > > > > > >                 memory =3D <&memory0>;    // Associated tagge=
d memory node
> > > > > > >         };
> > > > > >
> > > > > > I skimmed thru the discussion some. If this memory range is wit=
hin
> > > > > > main RAM, then it definitely belongs in /reserved-memory.
> > > > >
> > > > > Ok, will do that.
> > > > >
> > > > > If you don't mind, why do you say that it definitely belongs in
> > > > > reserved-memory? I'm not trying to argue otherwise, I'm curious a=
bout the
> > > > > motivation.
> > > >
> > > > Simply so that /memory nodes describe all possible memory and
> > > > /reserved-memory is just adding restrictions. It's also because
> > > > /reserved-memory is what gets handled early, and we don't need
> > > > multiple things to handle early.
> > > >
> > > > > Tag storage is not DMA and can live anywhere in memory.
> > > >
> > > > Then why put it in DT at all? The only reason CMA is there is to se=
t
> > > > the size. It's not even clear to me we need CMA in DT either. The
> > > > reasoning long ago was the kernel didn't do a good job of moving an=
d
> > > > reclaiming contiguous space, but that's supposed to be better now (=
and
> > > > most h/w figured out they need IOMMUs).
> > > >
> > > > But for tag storage you know the size as it is a function of the
> > > > memory size, right? After all, you are validating the size is corre=
ct.
> > > > I guess there is still the aspect of whether you want enable MTE or
> > > > not which could be done in a variety of ways.
> > >
> > > Oh, sorry, my bad, I should have been clearer about this. I don't wan=
t to
> > > put it in the DT as a "linux,cma" node. But I want it to be managed b=
y CMA.
> >
> > Yes, I understand, but my point remains. Why do you need this in DT?
> > If the location doesn't matter and you can calculate the size from the
> > memory size, what else is there to add to the DT?
>
> I am afraid there has been a misunderstanding. What do you mean by
> "location doesn't matter"?

You said:
> Tag storage is not DMA and can live anywhere in memory.

Which I took as the kernel can figure out where to put it. But maybe
you meant the h/w platform can hard code it to be anywhere in memory?
If so, then yes, DT is needed.

> At the very least, Linux needs to know the address and size of a memory
> region to use it. The series is about using the tag storage memory for
> data. Tag storage cannot be described as a regular memory node because it
> cannot be tagged (and normal memory can).

If the tag storage lives in the middle of memory, then it would be
described in the memory node, but removed by being in reserved-memory
node.

> Then there's the matter of the tag storage block size (explained in this
> commit message), and also knowing the memory range for which a tag storag=
e
> region stores the tags. This is explained in the cover letter.

Honestly, I just forgot about that part.

Rob

