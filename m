Return-Path: <linux-fsdevel+bounces-52273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25DAE0F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7E516C93D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D2246792;
	Thu, 19 Jun 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdRU1qpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6C323E35D;
	Thu, 19 Jun 2025 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750371886; cv=none; b=NWsuOXtE2DYIf2jdZhQSutiBQU0tTBMyYTL/b1cMSWXNkJHH2BZfVuVkMSoBSU/athW55ZRNfvPbCdAbbWgIBSctP0sTTmAovSS6Mp04PxwZ+3p3eferGiod/Qdfy1cl30pv5OlLek+p/NC4OuTjDIJGl8pergYsTtMo3J+R7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750371886; c=relaxed/simple;
	bh=ShktJbcUjdwML+bFdo48jk6VKPT9i9s43d3tNkkW+sg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WF0iZ/8Z3hRINH4/VxwDOjVn6TO1ZmV08B1yhOtV2xBzCku+mSOtUR1OIOqWiQI5XdSc/qli7Cq2yZlbdr6rbuwYqCkPxNo7RgvK+hZVYGj7m2sWHoNCihlUedwCcdH8Lvno1ecsu7x7j9e4/QC6rEYMEGRYlB+uQsWUa9QHSRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdRU1qpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF85C4CEFB;
	Thu, 19 Jun 2025 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750371885;
	bh=ShktJbcUjdwML+bFdo48jk6VKPT9i9s43d3tNkkW+sg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=OdRU1qpLh9onKFCKwf8KT6uAqOYdBxC63BIUpICKF/a2EnvdgfD2UfUqYTvDL/NPq
	 YCU7YIHmwL4OsL3r3TEgQFWTQ6+FNtgTJR1Bkj4pRdPz4oWoZ3JPWzxKPgOo9qsfJR
	 jzLPM4P54z7DnAG/4k258jHVAOtrTty/yKbc5QWVgHYglU64xF/Nhg8eqP32okJYNa
	 Tn+k8I7Z7xFENTrAMM9aplklQ+qOmWIl5RNBYbwq8aPrWWPlL4uX1NcDZ3KKdNX6fl
	 UTuPb1JdNAYr6A3mvoMccpoqX7jWs6WX5iD+Pv2ZtCifoBtwgO2rd0gVLlSgKvEY6a
	 bOxJgdQzASfzw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 00:24:41 +0200
Message-Id: <DAQV1PLOI46S.2BVP6RPQ33Z8Y@kernel.org>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
From: "Benno Lossin" <lossin@kernel.org>
To: "Viacheslav Dubeyko" <Slava.Dubeyko@ibm.com>, "frank.li@vivo.com"
 <frank.li@vivo.com>, "glaubitz@physik.fu-berlin.de"
 <glaubitz@physik.fu-berlin.de>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "slava@dubeyko.com" <slava@dubeyko.com>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
 <a9dc59f404ec98d676fe811b2636936cb958dfb3.camel@ibm.com>
In-Reply-To: <a9dc59f404ec98d676fe811b2636936cb958dfb3.camel@ibm.com>

On Thu Jun 19, 2025 at 11:39 PM CEST, Viacheslav Dubeyko wrote:
> On Thu, 2025-06-19 at 21:33 +0200, Benno Lossin wrote:
>> Andreas Hindborg will most likely reply with some more info in the near
>> future, but I'll drop some of my thoughts.
>>=20
>> On Wed May 28, 2025 at 6:16 PM CEST, Viacheslav Dubeyko wrote:
>> > On Wed, 2025-05-28 at 20:40 +0800, Yangtao Li wrote:
>> > > +cc rust-for-linux
>> > >=20
>> > > =E5=9C=A8 2025/5/28 07:39, Viacheslav Dubeyko =E5=86=99=E9=81=93:
>> > > > Hi Adrian, Yangtao,
>> > > >=20
>> > > > One idea crossed my mind recently. And this is about re-writing HF=
S/HFS+ in
>> > > > Rust. It could be interesting direction but I am not sure how reas=
onable it
>> > > > could be. From one point of view, HFS/HFS+ are not critical subsys=
tems and we
>> > > > can afford some experiments. From another point of view, we have e=
nough issues
>> > > > in the HFS/HFS+ code and, maybe, re-working HFS/HFS+ can make the =
code more
>> > > > stable.
>> > > >=20
>> > > > I don't think that it's a good idea to implement the complete re-w=
riting of the
>> > > > whole driver at once. However, we need a some unification and gene=
ralization of
>> > > > HFS/HFS+ code patterns in the form of re-usable code by both drive=
rs. This re-
>> > > > usable code can be represented as by C code as by Rust code. And w=
e can
>> > > > introduce this generalized code in the form of C and Rust at the s=
ame time. So,
>> > > > we can re-write HFS/HFS+ code gradually step by step. My point her=
e that we
>> > > > could have C code and Rust code for generalized functionality of H=
FS/HFS+ and
>> > > > Kconfig would define which code will be compiled and used, finally=
.
>> > > >=20
>> > > > How do you feel about this? And can we afford such implementation =
efforts?
>> > >=20
>> > > It must be a crazy idea! Honestly, I'm a fan of new things.
>> > > If there is a clear path, I don't mind moving in that direction.
>> > >=20
>> >=20
>> > Why don't try even some crazy way. :)
>>=20
>> There are different paths that can be taken. One of the easiest would be
>> to introduce a rust reference driver [1] for HFS. The default config
>> option would still be the C driver so it doesn't break users (& still
>> allows all supported architectures), but it allows you to experiment
>> using Rust. Eventually, you could remove the C driver when ggc_rs is
>> mature enough or only keep the C one around for the obscure
>> architectures.
>>=20
>
> Yeah, makes sense to me. It's one of the possible way. And I would like t=
o have
> as C as Rust implementation of driver as the first step. But it's hard en=
ough to
> implement everything at once. So, I would like to follow the step by step
> approach.
>
>> If you don't want to break the duplicate drivers rule, then I can expand
>> a bit on the other options, but honestly, they aren't that great:
>>=20
>> There are some subsystems that go for a library approach: extract some
>> self-contained piece of functionality and move it to Rust code and then
>> call that from C. I personally don't really like this approach, as it
>> makes it hard to separate the safety boundary, create proper
>> abstractions & write idiomatic Rust code.
>>=20
>
> This is what I am considering as the first step. As far as I can see, HFS=
 and
> HFS+ have "duplicated" functionality with some peculiarities on every sid=
e. So,
> I am considering to have something like Rust "library" that can absorb th=
is
> "duplicated" fuctionality at first. As a result, HFS and HFS+ C code can =
re-use
> the Rust "library" at first. Finally, the whole driver(s) could be conver=
ted
> into the Rust implementation.=20

I'd of course have to see the concrete code, but this sounds a lot like
calling back and forth between C and Rust. Which will most likely be
painful. But it did work for the QR code generator, so we'll see.

>> [1]: https://rust-for-linux.com/rust-reference-drivers =20
>>=20
>
> Thanks for sharing this.
>
>> > > It seems that downstream already has rust implementations of puzzle =
and=20
>> > > ext2 file systems. If I understand correctly, there is currently a l=
ack=20
>> > > of support for vfs and various infrastructure.
>> > >=20
>> >=20
>> > Yes, Rust implementation in kernel is slightly complicated topic. And =
I don't
>> > suggest to implement the whole HFS/HFS+ driver at once. My idea is to =
start from
>> > introduction of small Rust module that can implement some subset of HF=
S/HFS+
>> > functionality that can be called by C code. It could look like a libra=
ry that
>> > HFS/HFS+ drivers can re-use. And we can have C and Rust "library" and =
people can
>> > select what they would like to compile (C or Rust implementation).
>>=20
>> One good path forward using the reference driver would be to first
>> create a read-only version. That was the plan that Wedson followed with
>> ext2 (and IIRC also ext4? I might misremember). It apparently makes the
>> initial implementation easier (I have no experience with filesystems)
>> and thus works better as a PoC.
>>=20
>
> I see your point but even Read-Only functionality is too much. :) Because=
, it
> needs to implement 80% - 90% functionality of metadata management even fo=
r Read-
> Only case. And I would like to make the whole thing done by small working=
 steps.
> This is why I would like: (1) start from Rust "library", (2) move metadat=
a
> management into Rust "library" gradually, (3) convert the whole driver in=
to Rust
> implementation.

I personally don't know how this argument works, I only cited it in case
it is useful to people with domain knowledge :)

>> > > I'm not an expert on Rust, so it would be great if some Rust people=
=20
>> > > could share their opinions.
>> > >=20
>> >=20
>> > I hope that Rust people would like the idea. :)
>>=20
>> I'm sure that several Rust folks would be interested in getting their
>> hands dirty helping with writing abstractions and/or the driver itself.
>>=20
>
> Sounds great! :) I really need some help and advice.
>
>> I personally am more on the Rust side of things, so I could help make
>> the abstractions feel idiomatic and ergonomic.
>>=20
>> Feel free to ask any follow up questions. Hope this helps!
>>=20
>
> Sounds interesting! Let me prepare my questions. :) So, HFS/HFS+ have
> superblock, bitmap, b-trees, extent records, catalog records. It sounds t=
o me
> like candidates for abstractions. Am I correct here? Are we understand
> abstraction at the same way? :)

Yes! Everything that is used by other drivers/subsystems are usual
candidates for abstractions.

Essentially an abstraction is a rustified version of the C API. For
example, `Mutex<T>` is generic over the contained value, uses guards and
only allows access to the inner value if the mutex is locked.

Abstractions can take a pretty different form from the C API when it's
possible to make certain undesired uses of the API impossible through
Rust's type system or other features (in the case of the mutex, making
it impossible to access a value without locking it). Though they can
also be pretty simple if the C API is straightforward (this of course
depends on the concrete API).

Their purpose is to encapsulate the C API and expose its functionality
to safe Rust (note that calling any C function is considered `unsafe` in
Rust).

Calling C functions directly from Rust driver code (ie without going
through an abstraction) is not something that we want to allow (of
course there might be some exceptional cases where it is needed
temporarily). And thus everything that you use should have an
abstraction (this might include driver-specific abstractions that
effectively are also part of the driver, but encapsulate the C parts,
when you have converted the driver fully to rust, you probably won't
need any of them).

---
Cheers,
Benno

