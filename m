Return-Path: <linux-fsdevel+bounces-64952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02263BF7621
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D41934E236C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51B34BA28;
	Tue, 21 Oct 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEjiUO5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9F3446B0;
	Tue, 21 Oct 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060394; cv=none; b=ZRnUVohlrqQ+xog3/wWIgaBYbR8/H16y0V5eBKSZMVVyrI22BxPWbU9j6k7JFxf5UEwffVblGXx0wxg8niAlBFqCYrfvQWU3u3HlOqOiHYDtk/ol/vtvn4ppFMgU2s/frDBAhqnCaminj/z7Z/D7FlW0nsLmSpR+y1YhLyxe1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060394; c=relaxed/simple;
	bh=eN/o21nJauxCaIR9XeIoYd7ymIS6OEsOgBmlALQLaVw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=XLiOZO8OGj3yAN8cAAeWGr+AThRKbMaJ2BJRd3c5sAL8tNv9XAOplMRphSCB6C05koJ+xAalZRPO60lodlelhk7MNMOHwnPqBBB8TadcdkUZeJe26hr5zEhlXIbL0TpGQl+i4OP+C2ABCIMT7FfQL2kj+xXAxCw5vIk5a6SgLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEjiUO5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB390C4CEF5;
	Tue, 21 Oct 2025 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060393;
	bh=eN/o21nJauxCaIR9XeIoYd7ymIS6OEsOgBmlALQLaVw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=hEjiUO5B/hqZMPKuvBisRUTCBf654jCcmBt5thqh7Dz29JVBhUa6HL+wNmHXcleZA
	 wJQYafG7M0MHWl9KzJkb0OIKBFJNuOt2aLHemokwinZyr2LX2MhZPozTAr2PO9NKNS
	 qj3tXUqN9NMrk0csjH31YkngTPfRTsDVrP0gJuJAAwVfh5lW1kL6d7li1xkHYP3FWT
	 4sPAyh2ZBExTvHcIn3bnXTnOI0Zsf0cKnZL69qeHSZFO5lr1LejQoElX5BWUKTHd3Z
	 Sh2JhHMX6WXQjmJAKBs1NBxMXQzY+gN4qcKoteJghyeR6eq/CgJLQCJTPtf+yzPmLn
	 wkaAGNOvLD5dw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 17:26:28 +0200
Message-Id: <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-2-dakr@kernel.org>
 <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com>
In-Reply-To: <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com>

On Tue Oct 21, 2025 at 5:08 PM CEST, Miguel Ojeda wrote:
> On Tue, Oct 21, 2025 at 12:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:
>>
>> Add a type alias for file offsets, i.e. bindings::loff_t. Trying to
>> avoid using raw bindings types, this seems to be the better alternative
>> compared to just using i64.
>
> Would a newtype be too painful?
>
> Note: I didn't actually check if it is a sensible idea, but when I see
> an alias I tend to ask myself that so it would be nice to know the
> pros/cons (we could ideally mention why in the commit message in cases
> like this).

Yeah, I don't think there's any value making this a new type in this case. =
There
are no type invariants, useful methods, etc.

In fact, not even the type alias is strictly needed, as i64 would be suffic=
ient
as well.

The main motivation for the type alias is that I think i64 is not super
intuitive for an offset value (people would rather expect usize or isize) a=
nd
it's nice to not have bindings::loff_t exposed to driver APIs.

