Return-Path: <linux-fsdevel+bounces-67099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2EDC35557
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0F1422AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29FB30FC0C;
	Wed,  5 Nov 2025 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFNdm8cY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C242E5B2A;
	Wed,  5 Nov 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341563; cv=none; b=saQ/Sw0r9u3p5qFPc1ZidVht0cbPKrzCsDXD1JUoTpKdePui/MXNVsYyygBiy6DMFjhMW/IOziKu5UgD/bWoyyZYJhQpeWVYd9buKBAjSRBySjRfJviG9lEu01ktOKvCNFFEIWeCnWWBILtgtF7uDk0H+RZV8W2IYuby7tPyi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341563; c=relaxed/simple;
	bh=8fzrbqlZZIA3X+rB0huPkXNufqYWaw0N6jILyOc2Tso=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=b/NegwezgfUBrOU/YUMjIEH5ekkPjQFo6U0CTIn4Apt6qSDBV5AUKxZCSEmRGEMg6MiQwMpRZDEDDBgGlHDWp99JUa9X2yc5cJMPFrt6tBBHFPRq3fP5MWMeaPbpiK++heH7kEjNLx9lnLfAkIlm3PX3jhsx0EgPdOa7ntcIgeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFNdm8cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D6AC4CEF8;
	Wed,  5 Nov 2025 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762341562;
	bh=8fzrbqlZZIA3X+rB0huPkXNufqYWaw0N6jILyOc2Tso=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hFNdm8cYpgm2//0cfqkf1ADYwqH9xYEq6iRjvWT7O2lNULSlXHNod7A2yIRnxirHG
	 7uYtW0uX8fOBs55hsRL4W7YOsVq1w26+8P3H1055ZvAGg5K+5e9tp/pebGewWhX+X9
	 ow4ponYHHptBxFWOP6LJBovdVoRsCx8K1Nants0dtbzKOLTVkOdnp8qW0CmrXZOx+7
	 ad+B925hdAkMjIeUxBwn4m3lm6DKfpAFf2Vc3VCSqaA/Od1S8dWFGuNFI8muhpDmHc
	 Ub5EgORY8ycYjbI2vTuLXt7HrcGYLR9OJulv40hH+1TtAUQoOU41feGQbTzAlNfwpL
	 syzu20P51XR4w==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 12:19:17 +0100
Message-Id: <DE0PXYNG8O8W.19MUQ9TGA6C04@kernel.org>
Subject: Re: [PATCH 1/3] rust: fs: add a new type for file::Offset
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <viro@zeniv.linux.org.uk>,
 <jack@suse.cz>, <arnd@arndb.de>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>
To: "Christian Brauner" <brauner@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251105002346.53119-1-dakr@kernel.org>
 <20251105-begibt-gipfel-cf2718233888@brauner>
In-Reply-To: <20251105-begibt-gipfel-cf2718233888@brauner>

On Wed Nov 5, 2025 at 11:59 AM CET, Christian Brauner wrote:
> On Wed, Nov 05, 2025 at 01:22:48AM +0100, Danilo Krummrich wrote:
>> Replace the existing file::Offset type alias with a new type.
>>=20
>> Compared to a type alias, a new type allows for more fine grained
>> control over the operations that (semantically) make sense for a
>> specific type.
>>=20
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
>> Link: https://github.com/Rust-for-Linux/linux/issues/1198
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>
> What's the base for this?
> If it's stuff that belongs to fs/ I'd prefer if it always uses a stable
> -rc* version as base where possible.

Please see [1]; the base is [2] from the driver-core tree.

[1] https://lore.kernel.org/lkml/DE0C1KA14PDQ.Q2CJDDTQPWOK@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/tree/?id=3D1bf5b90cd2f984e5d6ff6fd30d5d85f9f579b6f0

