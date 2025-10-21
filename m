Return-Path: <linux-fsdevel+bounces-64986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB38BF7EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 19:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF2E189091A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2B734C123;
	Tue, 21 Oct 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHv9pwKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E41F584C;
	Tue, 21 Oct 2025 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068059; cv=none; b=OuBse//UxUi3BOJEQSUkUGEPemt2iEePxYbVS6DcWcbgMu5xJH1y71ifeCWgdN6elPTVgpYavCUVO4T5q1LZNK2oZiRMoWtzzPHpbLaEN1tdhB+H/EozyFND8eEGPFvN0fhlbE8PsL1pTMJPC4Hb4jGl6dhb88TX8S35J0/f4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068059; c=relaxed/simple;
	bh=yZ5iFEeaaYVaI3L+acwknFPYoOVNKOCIcgEuvzYBv50=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=d4+2b3hsZvUcRV9ygcQvrn3pcvlRPhYZROLRVCPRS2yGbFJHGL9yd1fu+jgaUZ/9FozHsuxPr5ee+nIbIFKTa6IU4jcFZKnfAAU2rrTdLpgVAcJKdIUbLJRz0h+5BC1gi/KXAbBP7NdATdI0aX/RaeeirzMtWsYjgEGwoO7aTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHv9pwKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1090C4CEF1;
	Tue, 21 Oct 2025 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761068058;
	bh=yZ5iFEeaaYVaI3L+acwknFPYoOVNKOCIcgEuvzYBv50=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=tHv9pwKMTLil8clUAW1faEeTmf5FikkTPHvroA4B4dqaiszSwgHhmP5jf4kbO/VvO
	 wg+uvzXpGRE4rEZ1wq7dP4csBeMUbmqtiGPAN+nyI5r9ykjDr3dblQdM+s0UkL03ZZ
	 wter9xjJgbYMOoBq7meeqskEIdcipkWBMn6YMrA6HJT0KDn7rkiRigY5c+W/4e1B4a
	 VFj1WEReLuNg3bOOd6W+RfcaYqgcASAMUeSS69zMJJ9TY5xGmp/e1bBfYWVR8fM0i9
	 Dce7wuzl2pCvOeN3QfSbUL/yHlHJ6UX4IEj2Io5WJKNqBgA9fwBL0wTZ1qvF7l/qlQ
	 fO0ku3AANA6KA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 19:34:12 +0200
Message-Id: <DDO6IUEAVBR0.14AZ0UXFYQF48@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-2-dakr@kernel.org>
 <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com>
 <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org>
 <CANiq72k-_=nhJAfzSV3rX7Tgz5KcmTdqwU9+j4M9V3rPYRmg+A@mail.gmail.com>
 <DDO521751WXE.11AAYWCL2CMP0@kernel.org>
 <CANiq72=N+--1bhg+nSTDhvx3mFDcvppXo9Jxa__OPQRiSgEo2w@mail.gmail.com>
In-Reply-To: <CANiq72=N+--1bhg+nSTDhvx3mFDcvppXo9Jxa__OPQRiSgEo2w@mail.gmail.com>

On Tue Oct 21, 2025 at 6:47 PM CEST, Miguel Ojeda wrote:
> If it is just e.g. add/sub and a few from/into, then it sounds ideal
> (i.e. I am worried if it wants to be used as essentially a primitive,
> in which case I agree it would need to be automated to some degree).

That's what I need for this patch series, I think the operations applicable=
 for
this type are quite some more; not that far from a primitive.

> To me, part of that is restricting what can be done with the type to
> prevent mistakes.
>
> i.e. a type alias is essentially the wild west, and this kind of
> type/concept is common enough that it sounds a good idea to pay the
> price to provide a proper type for it.

The reason why I said for this case I think it would be good to have derive
macros first is that there's a lot of things that are valid to do with an o=
ffset
value.

Of course, there's also a lot of things that don't make a lot of sense that=
 we
could prevent (e.g. reverse_bits(), ilogX(), etc.).

I think in this case there not a lot to gain from preventing this, consider=
ing
that we don't have derive macros yet.

However, I understand where you're coming from. Even though there's not a h=
uge
gain here, it would be good to set an example -- especially if it's somethi=
ng as
cental as a file offset type.

If this is what you have in mind, let me go ahead and do it right away (at =
least
for the things needed by this patch series), because that's a very good rea=
son I
think.

> So I don't want to delay real work, and as long as we do it early
> enough that we don't have many users, that sounds like a good idea to
> me -- done:
>
>     https://github.com/Rust-for-Linux/linux/issues/1198
>
> Also took the chance to ask for a couple examples/tests.

Thanks a lot for creating the issue!

(I mainly also thought of adding one for a derive macro.)

