Return-Path: <linux-fsdevel+bounces-52256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3958CAE0E0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 21:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F3BE7A26DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7872441AA;
	Thu, 19 Jun 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7fB0MeK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACA226D1A;
	Thu, 19 Jun 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750361608; cv=none; b=IXffyJMAFdK+1hkJI7SVBwXmXNhA6EBGDOYqR8k3f1svuv651P9qj8Cjh1dAqgcDQwDKUdOsFNhbXhrvkUvw4qPgrC5OcybfXV3fhjOK73qK9ORsXA9KhdrNsWtIZ5EJJzO+0Oyjy7wAtkKoaKIBA7efkwmESSW6g0JbZyFNvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750361608; c=relaxed/simple;
	bh=K3ig0XW+sR2f7AhU8fu/SP67FM15tcTtEVt9oemecH0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PbnnipJK2xNiIlIK1+SYusk0nhfXp4KpT38ciuc/p+TsgAGIYhqEd/Y4FN18lmvR2hLFbkf9XfIyfrC6kuBFxgO9/4GhcKU96dSWY0hzbZHdybTUATgf6kqj44wbDSOaGhlRlM4KMlnew23bkMHYDJ8L0srFMwEpPNX062jUm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7fB0MeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49B2C4CEEA;
	Thu, 19 Jun 2025 19:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750361608;
	bh=K3ig0XW+sR2f7AhU8fu/SP67FM15tcTtEVt9oemecH0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=j7fB0MeKB++tqdj9jER/Rm7izIOEiRPVFOlvKQYBzqlIV9K5iuWMMYXcyP0c68rFk
	 ubFhWNSlyPudZ34UiTN06SvJJURtNhIr6SPv3ekvBo3jCdvpxBSoj6FqWjx2FyTrFe
	 LuVga4BIn27AxV5MMzyFkmx/NzSu8HGGpPhI7sjNnYaDNYTG/Duvvfio5+00ugstmT
	 S1I9tVu5pkU1OQ1E9Y4mtE9LSTjkFMAKYe9C4LfWDzhD9My3nvIJkwwNlB5igQDoGW
	 EDMu9gtYJFuMhPDMI19KnGGkfJb/iJA5t+RoRvhxHSjHRDCbPjPUeIgrnt67GaMAyl
	 srATyCiKuHdMw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Jun 2025 21:33:24 +0200
Message-Id: <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "slava@dubeyko.com" <slava@dubeyko.com>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
From: "Benno Lossin" <lossin@kernel.org>
To: "Viacheslav Dubeyko" <Slava.Dubeyko@ibm.com>, "frank.li@vivo.com"
 <frank.li@vivo.com>, "glaubitz@physik.fu-berlin.de"
 <glaubitz@physik.fu-berlin.de>
X-Mailer: aerc 0.20.1
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
In-Reply-To: <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>

Andreas Hindborg will most likely reply with some more info in the near
future, but I'll drop some of my thoughts.

On Wed May 28, 2025 at 6:16 PM CEST, Viacheslav Dubeyko wrote:
> On Wed, 2025-05-28 at 20:40 +0800, Yangtao Li wrote:
>> +cc rust-for-linux
>>=20
>> =E5=9C=A8 2025/5/28 07:39, Viacheslav Dubeyko =E5=86=99=E9=81=93:
>> > Hi Adrian, Yangtao,
>> >=20
>> > One idea crossed my mind recently. And this is about re-writing HFS/HF=
S+ in
>> > Rust. It could be interesting direction but I am not sure how reasonab=
le it
>> > could be. From one point of view, HFS/HFS+ are not critical subsystems=
 and we
>> > can afford some experiments. From another point of view, we have enoug=
h issues
>> > in the HFS/HFS+ code and, maybe, re-working HFS/HFS+ can make the code=
 more
>> > stable.
>> >=20
>> > I don't think that it's a good idea to implement the complete re-writi=
ng of the
>> > whole driver at once. However, we need a some unification and generali=
zation of
>> > HFS/HFS+ code patterns in the form of re-usable code by both drivers. =
This re-
>> > usable code can be represented as by C code as by Rust code. And we ca=
n
>> > introduce this generalized code in the form of C and Rust at the same =
time. So,
>> > we can re-write HFS/HFS+ code gradually step by step. My point here th=
at we
>> > could have C code and Rust code for generalized functionality of HFS/H=
FS+ and
>> > Kconfig would define which code will be compiled and used, finally.
>> >=20
>> > How do you feel about this? And can we afford such implementation effo=
rts?
>>=20
>> It must be a crazy idea! Honestly, I'm a fan of new things.
>> If there is a clear path, I don't mind moving in that direction.
>>=20
>
> Why don't try even some crazy way. :)

There are different paths that can be taken. One of the easiest would be
to introduce a rust reference driver [1] for HFS. The default config
option would still be the C driver so it doesn't break users (& still
allows all supported architectures), but it allows you to experiment
using Rust. Eventually, you could remove the C driver when ggc_rs is
mature enough or only keep the C one around for the obscure
architectures.

If you don't want to break the duplicate drivers rule, then I can expand
a bit on the other options, but honestly, they aren't that great:

There are some subsystems that go for a library approach: extract some
self-contained piece of functionality and move it to Rust code and then
call that from C. I personally don't really like this approach, as it
makes it hard to separate the safety boundary, create proper
abstractions & write idiomatic Rust code.

[1]: https://rust-for-linux.com/rust-reference-drivers

>> It seems that downstream already has rust implementations of puzzle and=
=20
>> ext2 file systems. If I understand correctly, there is currently a lack=
=20
>> of support for vfs and various infrastructure.
>>=20
>
> Yes, Rust implementation in kernel is slightly complicated topic. And I d=
on't
> suggest to implement the whole HFS/HFS+ driver at once. My idea is to sta=
rt from
> introduction of small Rust module that can implement some subset of HFS/H=
FS+
> functionality that can be called by C code. It could look like a library =
that
> HFS/HFS+ drivers can re-use. And we can have C and Rust "library" and peo=
ple can
> select what they would like to compile (C or Rust implementation).

One good path forward using the reference driver would be to first
create a read-only version. That was the plan that Wedson followed with
ext2 (and IIRC also ext4? I might misremember). It apparently makes the
initial implementation easier (I have no experience with filesystems)
and thus works better as a PoC.

>> I'm not an expert on Rust, so it would be great if some Rust people=20
>> could share their opinions.
>>=20
>
> I hope that Rust people would like the idea. :)

I'm sure that several Rust folks would be interested in getting their
hands dirty helping with writing abstractions and/or the driver itself.

I personally am more on the Rust side of things, so I could help make
the abstractions feel idiomatic and ergonomic.

Feel free to ask any follow up questions. Hope this helps!

---
Cheers,
Benno

