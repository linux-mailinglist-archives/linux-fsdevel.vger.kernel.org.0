Return-Path: <linux-fsdevel+bounces-6003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C8812000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 21:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04FB1C2102B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5411B5A10C;
	Wed, 13 Dec 2023 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzY58e+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D649225AA;
	Wed, 13 Dec 2023 20:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089D5C433C8;
	Wed, 13 Dec 2023 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702499457;
	bh=2kSgrL3rqNhzbcloHGwmD+Op6eU1uTYkc8WV4RpWZEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pzY58e+SfqagqI/N/rg8JrJI6zrL3tQk8blJRpnIxpAdps98u0I/TDxE1gkEXX5Sc
	 ITXcIp2mty+caRxzX5P05yWik3apA9iI3Aes3rDlY6ctkFQGR9s08UzwHDcIZ0Rl7g
	 nvHErr4Dc7OyBWPauvakubCKIaxKlX8frlACfWZiqG/+w2pgre2V2rwjp3FKaKPPuI
	 l7+LLtASLTW9e4MlduynIA9QEOVF+6ChQcgK/T3AUHIrspvL01y6q659ZCUiLzLk/j
	 W7ejUw3/zAiXeAOOoqNtbIXpwa8ez8Kx1AOX4Z1MUcqSvehwcE1G/91bHkW52oE9Wh
	 jZmoOertBiZhQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50c0f6b1015so8662370e87.3;
        Wed, 13 Dec 2023 12:30:56 -0800 (PST)
X-Gm-Message-State: AOJu0Yyu/NVz3TZ8WiYb3mffVGSQ7W+csRgbKTWKQ568hTFTNuBzHkcB
	iCbdVR2rJjSfwSw0LWpt9HBTOjZx0lSvMUxbmw==
X-Google-Smtp-Source: AGHT+IFgd6YpFyJgZhLDy0EZGLGdXBWFqpNnZ7ro1f5adp2tWnNWL6zmYVImkR5sAkQh+ReR19JlxfWI4mQIp7D1Js8=
X-Received: by 2002:ac2:4d15:0:b0:50d:2f88:e93e with SMTP id
 r21-20020ac24d15000000b0050d2f88e93emr2997218lfi.66.1702499455211; Wed, 13
 Dec 2023 12:30:55 -0800 (PST)
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
 <ZXnE3724jYYSg4o6@raptor> <CAL_JsqJgTnuQjo13cKo1Ebm5j9tCRT8GhNavdqu5vwp+fdnTLw@mail.gmail.com>
 <ZXnthcg0BkEd-RgK@raptor>
In-Reply-To: <ZXnthcg0BkEd-RgK@raptor>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Dec 2023 14:30:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLAW0--F8R0oTaajN3YpbK2KgE6Ypn8tk4_pf_s=xC+aw@mail.gmail.com>
Message-ID: <CAL_JsqLAW0--F8R0oTaajN3YpbK2KgE6Ypn8tk4_pf_s=xC+aw@mail.gmail.com>
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

On Wed, Dec 13, 2023 at 11:44=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> On Wed, Dec 13, 2023 at 11:22:17AM -0600, Rob Herring wrote:
> > On Wed, Dec 13, 2023 at 8:51=E2=80=AFAM Alexandru Elisei
> > <alexandru.elisei@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Dec 13, 2023 at 08:06:44AM -0600, Rob Herring wrote:
> > > > On Wed, Dec 13, 2023 at 7:05=E2=80=AFAM Alexandru Elisei
> > > > <alexandru.elisei@arm.com> wrote:
> > > > >
> > > > > Hi Rob,
> > > > >
> > > > > On Tue, Dec 12, 2023 at 12:44:06PM -0600, Rob Herring wrote:
> > > > > > On Tue, Dec 12, 2023 at 10:38=E2=80=AFAM Alexandru Elisei
> > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > >
> > > > > > > Hi Rob,
> > > > > > >
> > > > > > > Thank you so much for the feedback, I'm not very familiar wit=
h device tree,
> > > > > > > and any comments are very useful.
> > > > > > >
> > > > > > > On Mon, Dec 11, 2023 at 11:29:40AM -0600, Rob Herring wrote:
> > > > > > > > On Sun, Nov 19, 2023 at 10:59=E2=80=AFAM Alexandru Elisei
> > > > > > > > <alexandru.elisei@arm.com> wrote:
> > > > > > > > >
> > > > > > > > > Allow the kernel to get the size and location of the MTE =
tag storage
> > > > > > > > > regions from the DTB. This memory is marked as reserved f=
or now.
> > > > > > > > >
> > > > > > > > > The DTB node for the tag storage region is defined as:
> > > > > > > > >
> > > > > > > > >         tags0: tag-storage@8f8000000 {
> > > > > > > > >                 compatible =3D "arm,mte-tag-storage";
> > > > > > > > >                 reg =3D <0x08 0xf8000000 0x00 0x4000000>;
> > > > > > > > >                 block-size =3D <0x1000>;
> > > > > > > > >                 memory =3D <&memory0>;    // Associated t=
agged memory node
> > > > > > > > >         };
> > > > > > > >
> > > > > > > > I skimmed thru the discussion some. If this memory range is=
 within
> > > > > > > > main RAM, then it definitely belongs in /reserved-memory.
> > > > > > >
> > > > > > > Ok, will do that.
> > > > > > >
> > > > > > > If you don't mind, why do you say that it definitely belongs =
in
> > > > > > > reserved-memory? I'm not trying to argue otherwise, I'm curio=
us about the
> > > > > > > motivation.
> > > > > >
> > > > > > Simply so that /memory nodes describe all possible memory and
> > > > > > /reserved-memory is just adding restrictions. It's also because
> > > > > > /reserved-memory is what gets handled early, and we don't need
> > > > > > multiple things to handle early.
> > > > > >
> > > > > > > Tag storage is not DMA and can live anywhere in memory.
> > > > > >
> > > > > > Then why put it in DT at all? The only reason CMA is there is t=
o set
> > > > > > the size. It's not even clear to me we need CMA in DT either. T=
he
> > > > > > reasoning long ago was the kernel didn't do a good job of movin=
g and
> > > > > > reclaiming contiguous space, but that's supposed to be better n=
ow (and
> > > > > > most h/w figured out they need IOMMUs).
> > > > > >
> > > > > > But for tag storage you know the size as it is a function of th=
e
> > > > > > memory size, right? After all, you are validating the size is c=
orrect.
> > > > > > I guess there is still the aspect of whether you want enable MT=
E or
> > > > > > not which could be done in a variety of ways.
> > > > >
> > > > > Oh, sorry, my bad, I should have been clearer about this. I don't=
 want to
> > > > > put it in the DT as a "linux,cma" node. But I want it to be manag=
ed by CMA.
> > > >
> > > > Yes, I understand, but my point remains. Why do you need this in DT=
?
> > > > If the location doesn't matter and you can calculate the size from =
the
> > > > memory size, what else is there to add to the DT?
> > >
> > > I am afraid there has been a misunderstanding. What do you mean by
> > > "location doesn't matter"?
> >
> > You said:
> > > Tag storage is not DMA and can live anywhere in memory.
> >
> > Which I took as the kernel can figure out where to put it. But maybe
> > you meant the h/w platform can hard code it to be anywhere in memory?
> > If so, then yes, DT is needed.
>
> Ah, I see, sorry for not being clear enough, you are correct: tag storage
> is a hardware property, and software needs a mechanism (in this case, the
> dt) to discover its properties.
>
> >
> > > At the very least, Linux needs to know the address and size of a memo=
ry
> > > region to use it. The series is about using the tag storage memory fo=
r
> > > data. Tag storage cannot be described as a regular memory node becaus=
e it
> > > cannot be tagged (and normal memory can).
> >
> > If the tag storage lives in the middle of memory, then it would be
> > described in the memory node, but removed by being in reserved-memory
> > node.
>
> I don't follow. Would you mind going into more details?

It goes back to what I said earlier about /memory nodes describing all
the memory. There's no reason to reserve memory if you haven't
described that range as memory to begin with. One could presumably
just have a memory node for each contiguous chunk and not need
/reserved-memory (ignoring the need to say what things are reserved
for). That would become very difficult to adjust. Note that the kernel
has a hardcoded limit of 64 reserved regions currently and that is not
enough for some people. Seems like a lot, but I have no idea how they
are (ab)using /reserved-memory.

Let me give an example. Presumably using MTE at all is configurable.
If you boot a kernel with MTE disabled (or older and not supporting
it), then I'd assume you'd want to use the tag storage for regular
memory. Well, If tag storage is already part of /memory, then all you
have to do is ignore the tag reserved-memory region. Tweaking the
memory nodes would be more work.


Also, I should point out that /memory and /reserved-memory nodes are
not used for UEFI boot.

Rob

