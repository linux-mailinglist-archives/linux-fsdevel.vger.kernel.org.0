Return-Path: <linux-fsdevel+bounces-49978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D80AC6CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE49B7A1F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 15:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE6328C2B0;
	Wed, 28 May 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuwh3OKl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38442882BE;
	Wed, 28 May 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446172; cv=none; b=cr8mgjxSJnfXMwimkPrpEpxOtTh6D8/fsV6+5SL5dlnjCIuzvv/4EpHvue5umDn1YRZGEV49eNVhOPqP3MuWlymcNdrEVifMNM+aWOJ2cVrT0VwrDdcu1Vl4tAqFAuteO1P1Vg+nVq2Ide8WFatJ1Lidq7bfB9Idd08+1svEje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446172; c=relaxed/simple;
	bh=VKnzuxZGbyr5nWMvWhI8JQXl3fxnPGXhp3oyzAehjpk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=t9DwHnmVkZbAib2xCCXwXCw2Y3FNdx8BleTHtVeRneNfiUV4mhLPV0dL9i8YdnH8Sv6baCR0syzJO5XLCm3+39FRUDYsnWpmqB1E41giCP+mEBADoL5Pr6W0jDGCUncknRtYUNfh+Mj2hYLLm2bxZaX1VoGc4y3rHfQExJp5/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuwh3OKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF82C4CEE3;
	Wed, 28 May 2025 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748446171;
	bh=VKnzuxZGbyr5nWMvWhI8JQXl3fxnPGXhp3oyzAehjpk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kuwh3OKlGofxP5IsZbgkRlvyv8McwOCKSMORSXgDIhOPKeX718PbZC1/hVRb4NcmB
	 f/1dm9Bc1XFqL4k/G3m3kmXDq34rePmxzJ5TiEZIN8vgX7M+3Qal+XtozXVA4n/IO1
	 4Y7C1apTmM7Px5CZXTEwlT8vTmqH0UrWvAoY7J+6r2qP+6bCKco3tTReAjB5N54Zbo
	 ph5xMd6rSoTtu//s8F05qUhGLLxdOelGMTwZutjvb7c3HDJDgDqQyXeH4z996ToBEB
	 rHxUcxNbg4WDC0BqNQGMuR4HDlcXbTm6FAUhlSy5PIUK0c0sG4ZJAORslHpD7/Mr3l
	 Wkb9MzSJn1ZHw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2025 17:29:26 +0200
Message-Id: <DA7WFS13MU9F.349OE3IGIDMBY@kernel.org>
Subject: Re: [PATCH 1/2] rust: file: mark `LocalFile` as `repr(transparent)`
From: "Benno Lossin" <lossin@kernel.org>
To: "Pekka Ristola" <pekkarr@protonmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250527204636.12573-1-pekkarr@protonmail.com>
In-Reply-To: <20250527204636.12573-1-pekkarr@protonmail.com>

On Tue May 27, 2025 at 10:48 PM CEST, Pekka Ristola wrote:
> Unsafe code in `LocalFile`'s methods assumes that the type has the same
> layout as the inner `bindings::file`. This is not guaranteed by the defau=
lt
> struct representation in Rust, but requires specifying the `transparent`
> representation.
>
> The `File` struct (which also wraps `bindings::file`) is already marked a=
s
> `repr(transparent)`, so this change makes their layouts equivalent.
>
> Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file`"=
)
> Closes: https://github.com/Rust-for-Linux/linux/issues/1165
> Signed-off-by: Pekka Ristola <pekkarr@protonmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

