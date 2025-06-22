Return-Path: <linux-fsdevel+bounces-52388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E544AE2EC6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 09:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E868C172B66
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AA2199385;
	Sun, 22 Jun 2025 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffIq2Zl/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECF440C;
	Sun, 22 Jun 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750578509; cv=none; b=OF4pVZZaQoeU6bvUUCSiT2zRMWWh0hDtzWctLAbE8Q/N1PAGOjQVlm5GPkg/lmU3dB7rJuPJvmZJyrlgIShioi0qz7Qnz4EsiAcZ+ASl7+p2HxtHw/XNJ7BwgOqKqUakPmX8zCHiNV1VFStCwDjdtizZjjUsAKkr7pFz8lWQZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750578509; c=relaxed/simple;
	bh=gpL9tlBu//lWGAhbLUsHR0Pb8+/j5ns27Zojw08nwA8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Fkz0YS4bMaqS5NqhxUUuQn4tWz8nGgKHgNeBtFLdphlySZsICtgyPz1TvqD8Wdto0VKH2+nru2m3Y3Bjz3qIJTkwMcLt+Q0TRgVxi45/V/jAe6ZriQJGIHqJly1fel90/CdKMKF9WYdx3jWDZsDNt/fgtx35L6tyj9zLTu+Qt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffIq2Zl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463CCC4CEE3;
	Sun, 22 Jun 2025 07:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750578509;
	bh=gpL9tlBu//lWGAhbLUsHR0Pb8+/j5ns27Zojw08nwA8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ffIq2Zl/8lsZ0mMXzghLMig7/sbr3pf6zZTUtELF5GT7yHj/KIswJWhn4yupmdOWK
	 bC6620Vb8TYd1lSuUS86OxeW39ncVTY769tuc4LaUrIx94rXzVlSyelecStKy5eNJY
	 J/ofEEK40LIh5FL6QmeV0Yib0KFugHLR8VRZ9HgzskrOgLYex4Z6uFoYjW2NfZdg+6
	 3sso6rsXHZ6dJNvR3qNIROssy3yCDv2ydGFLSG6GZ/0JGLbSSkSw7mNAviIpYen54D
	 sKr08A9sDGPIr3m4SygPygHoC0VmU2Rzv14g+UTXT96OyuLASuoI+Cbl/1EhuCEqjL
	 QpkPMq4r+pjZw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Jun 2025 09:48:25 +0200
Message-Id: <DASWAFCSUIO2.1W6RBKY6VRFHM@kernel.org>
Cc: "ariel.miculas@gmail.com" <ariel.miculas@gmail.com>, "frank.li@vivo.com"
 <frank.li@vivo.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "a.hindborg@kernel.org"
 <a.hindborg@kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
From: "Benno Lossin" <lossin@kernel.org>
To: "Viacheslav Dubeyko" <Slava.Dubeyko@ibm.com>,
 "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
 <a9dc59f404ec98d676fe811b2636936cb958dfb3.camel@ibm.com>
 <DAQV1PLOI46S.2BVP6RPQ33Z8Y@kernel.org>
 <39bac29b653c92200954dcc8c4e8cab99215e5b4.camel@ibm.com>
 <CANiq72mUpTMapFMRd4o=RSN0kU0JbLwccRKn9R+NPE7DvXDuwg@mail.gmail.com>
 <c3786491d6ed5fa10a27e307631253e97c644373.camel@ibm.com>
In-Reply-To: <c3786491d6ed5fa10a27e307631253e97c644373.camel@ibm.com>

On Sun Jun 22, 2025 at 12:38 AM CEST, Viacheslav Dubeyko wrote:
> On Fri, 2025-06-20 at 20:11 +0200, Miguel Ojeda wrote:
>> On Fri, Jun 20, 2025 at 7:50=E2=80=AFPM Viacheslav Dubeyko
>> <Slava.Dubeyko@ibm.com> wrote:
>> >=20
>> > Nowadays, VFS and memory subsystems are C implemented functionality. A=
nd I don't
>> > think that it will be changed any time soon. So, even file system driv=
er will be
>> > completely re-written in Rust, then it should be ready to be called fr=
om C code.
>>=20
>> That is fine and expected.
>>=20
>> > Moreover, file system driver needs to interact with block layer that i=
s written
>> > in C too. So, glue code is inevitable right now. How bad and inefficie=
nt could
>> > be using the glue code? Could you please share some example?
>>=20
>> Please take a look the proposed VFS abstractions, the filesystems that
>> were prototyped on top of them, and generally other Rust code we have.
>>=20
>> As for "how bad", the key is that every time you go through a C
>> signature, you need to constrain yourself to what C can encode (which
>> is not much), use unsafe code and other interop issues. Thus you want
>> to avoid having to go back and forth all the time.
>>=20
>> Thus, the idea is to write the filesystem in Rust using abstractions
>> that shield you from that.
>>=20
>> Cc'ing other potentially interested/related people.
>>=20
>
> I completely see your point. But let's consider allegory of home construc=
tion.
> Usually, we need to start from foundation, then we need to raise the wall=
s, and
> so on. The file system's metadata is the foundation and if I would like t=
o re-
> write the file system driver, then I need to start from metadata. It mean=
s that
> it makes sense to re-write, for example, bitmap or b-tree functionality a=
nd to
> check that it works completely functionally correct in the C implemented
> environment. Then, potentially, I could switch on bitmap implementation i=
n Rust.
> This is the vision of step-by-step implementation. And I completely OK wi=
th glue
> code and inefficiency on the first steps because I need to prepare the fi=
le
> system "foundation" and "walls". Also, I would like to manage the complex=
ity of
> implementation and bug fix. It means that I would like to isolate the bug=
s in
> HFS/HFS+ layer. I can trust to C implementation of VFS but I cannot trust=
 to
> Rust implementation of VFS. So, I prefer to re-write HFS/HFS+ functionali=
ty in
> Rust by using the C implemented environment at first. Because, from my po=
int of
> view, it is the way to manage complexity and to isolate bugs by HFS/HFS+ =
layer
> only. And when everything will be in Rust, then it will be possible to sw=
itch on
> complete Rust environment.

Ah maybe this is where the misunderstanding originates: we're not
talking about reimplementing bitmap or b-trees in Rust. We build
abstractions that call into the C side and use the existing
implementations. The abstractions make them available for the Rust side
to use them safely & efficiently.

In the case of bitmaps, there already is someone working on it, see [1].

In your metaphor, our recommendation is use adapters (the abstractions)
to go from the existing house frame (C) to the new interior (Rust). And
to avoid having mixed interior.

[1]: https://lore.kernel.org/all/20250620082954.540955-1-bqe@google.com

---
Cheers,
Benno

