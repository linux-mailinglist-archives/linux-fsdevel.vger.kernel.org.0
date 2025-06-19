Return-Path: <linux-fsdevel+bounces-52266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10326AE0F44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB2A5A179D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF79C28C871;
	Thu, 19 Jun 2025 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sahwZKD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7928C00B;
	Thu, 19 Jun 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370427; cv=none; b=uUzn5qMnT9Jr/VZ9+tTcW9Rxlh+f77YNr0RICPBhht3JaoQZy78Y6b2hDYYGIu4FErxFqU8ow5gAqd9osxrOebjslxUq/YFQtCjDU0ChORCGepTBYAYkYJfcR2890iZsMr0whoy3MhSMRerwZXGJHipgDiV6rOYT+4dwBtB40CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370427; c=relaxed/simple;
	bh=RCJL5uKWeDMP4COusptXhGPas5oPchmcP7+doHcXhkk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=blyMJWIspRb8CvE3W36ehx6of9UNW4Yja5ZZdYMYV7OEFwgtYdrUPVT3x+NuFdwhi82r3IkorZ5FkdTdtCEKvtsXk6+omAYtm0slaX/xPx6J8D7+0Ngmz9BTw0ucHHlAfNDpBO909vm56lKB1pFp7mi6JpcmLEUxRO1buxeouQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sahwZKD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32590C4CEF0;
	Thu, 19 Jun 2025 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370426;
	bh=RCJL5uKWeDMP4COusptXhGPas5oPchmcP7+doHcXhkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sahwZKD+EWLd3RfbZu0tJZHjWMtFS3zowwh22YYlr9/5D+yTLmiQdt8chJ1XVSq5D
	 l/Ivh4ZTLpVvMYiW7rk0CE3ZYZX52ZbL6gajLEw5XOh0RDAI5C9jvV67tEXPcCdAtn
	 zUDyAOWJ2+rplNFyGoGPLQl/mpZovGqrckFooQ8+yvHPI5C0j1cM0jVylJXPkLcg9K
	 H1UWq+p3gic2SQ6IpQVeF/lpfSjorirtD7dSN1jTvQo4hD1E9dLcpzp4qxPWhoSjxP
	 MA7SHU7Tg8PTPZxEZyHb/knsYcWxNZ2r+FWZ/X7Sh9ssTf0dM8WC47yr1G79dMqvsL
	 2UQyKSytxTHNQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 00:00:22 +0200
Message-Id: <DAQUJ3FZZH2V.1CT5PEW0QCBVV@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Viacheslav Dubeyko" <Slava.Dubeyko@ibm.com>,
 "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>, "glaubitz@physik.fu-berlin.de"
 <glaubitz@physik.fu-berlin.de>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
X-Mailer: aerc 0.20.1
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
 <CANiq72k5SensLERt3PkyDfDWiQsds_3GpS4nQqPPPMVSiWwSfg@mail.gmail.com>
 <c212d2e1ca41fa0f2e4bc7c6d9fe0186ca5e839e.camel@ibm.com>
In-Reply-To: <c212d2e1ca41fa0f2e4bc7c6d9fe0186ca5e839e.camel@ibm.com>

On Thu Jun 19, 2025 at 11:48 PM CEST, Viacheslav Dubeyko wrote:
> On Thu, 2025-06-19 at 22:22 +0200, Miguel Ojeda wrote:
>> On Thu, Jun 19, 2025 at 9:35=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>> >=20
>> > There are some subsystems that go for a library approach: extract some
>> > self-contained piece of functionality and move it to Rust code and the=
n
>> > call that from C. I personally don't really like this approach, as it
>> > makes it hard to separate the safety boundary, create proper
>> > abstractions & write idiomatic Rust code.
>>=20
>> Yeah, that approach works best when the interface surface is
>> small/simple enough relative to the functionality, e.g. the QR code
>> case we have in the kernel already.
>>=20
>> So there are some use cases of the approach (codecs have also been
>> discussed as another one). But going, in the extreme, "function by
>> function" replacing C with Rust and having two-way calls everywhere
>> isn't good, and it isn't the goal.
>>=20
>> Instead, we aim to write safe Rust APIs ("abstractions") and then
>> ideally having pure Rust modules that take advantage of those.
>> Sometimes you may want to keep certain pieces in C, but still use them
>> from the Rust module until you cover those too eventually.
>>=20
>
> Yeah, I completely agree. But I would like to implement the step-by-step
> approach. At first, introduce a Rust "library" that will absorb a "duplic=
ated"
> functionality of HFS/HFS+. And C code of HFS/HFS+ will re-use the functio=
nality
> of Rust "library". Then, elaborate "abstractions" (probably, HFS/HFS+ met=
adata
> primitives) and test it in Rust "library" by calling from C code. And, fi=
nally,
> completely switch to Rust implementation.

So the difficult part is the back and forth between Rust and C. You'll
have to write lots of glue code to make it work and that's why we don't
recommend it.

You can of course still build the driver step-by-step (and I'd recommend
doing that). For example the Nova driver is being built this way.

---
Cheers,
Benno

