Return-Path: <linux-fsdevel+bounces-49979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53EAC6CD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A0D7A74AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A154F28C2B5;
	Wed, 28 May 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTFJ0OJx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB6C2D1;
	Wed, 28 May 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748446214; cv=none; b=fW2X/hb1lY8v0f6t5NTjW2J0oAsJ8DbjKBMzaV8t/Z+BuzReEusbMpY4npsvjIWmQG4ithoIeU03Q/Q+tdqD8yUBLr/4Js5wMJcH5ti4NxAhHIGIkjKNjZldmwvR6RmFA6C1bFwTZ9WXTBjudYvGXqDhZpxnBIU6NLp7Uvd9+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748446214; c=relaxed/simple;
	bh=RCQ8xW6PYSFY6YML5KXLcLAH/Vax2zlFYfHD+delJug=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pZnFbsQ4n/zJGxeuaK9E6ICASsOnaNgLQsOiA7+y09ZQoWgrb6N0Tim0T92Gn9D1cIp3IyxPASN9Q8KDY3bru9zhLX5KHNW03xkvSqpr2yGgvhCX4Lgj77Tg8QqTtq+fEA+h/D1sXvLVbzl05OZFsJPqzVNJGdY8kxME3e/j4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTFJ0OJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51587C4CEE3;
	Wed, 28 May 2025 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748446213;
	bh=RCQ8xW6PYSFY6YML5KXLcLAH/Vax2zlFYfHD+delJug=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nTFJ0OJxwfsI5WBVIuHQg/Z2p5aO+BY9hB3KNviu2GoYqv8lz4ipExjKQKFn5LUR8
	 sN9UBtcAxAS2rElj0V9UimfySL9oaGeyaGVlZLJC+LN0oVPyygIHtUMNFDwL170iO5
	 8LQaduULGzww27EX0n4kYNlpnmK9tvI7axyaSI1YurmC0JFBAeyWkowuhetHm7q+BY
	 5P8AX/X3GsAH5LstDzfns6j9li8M4znHITEnf8yF+FtcbpUuh1W64Wut+fN2b63Csz
	 IveDKAMmyZi7rtRww05/8cDt0Sz9A9HOLAHjjvd+8qJKNSxfqIwuNR0s896RdnSXne
	 rd4HTvb440R3g==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2025 17:30:08 +0200
Message-Id: <DA7WGBL3SIYQ.KSQX9KU9JH79@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: file: improve safety comments
From: "Benno Lossin" <lossin@kernel.org>
To: "Pekka Ristola" <pekkarr@protonmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250527204636.12573-1-pekkarr@protonmail.com>
 <20250527204636.12573-2-pekkarr@protonmail.com>
In-Reply-To: <20250527204636.12573-2-pekkarr@protonmail.com>

On Tue May 27, 2025 at 10:48 PM CEST, Pekka Ristola wrote:
> Some of the safety comments in `LocalFile`'s methods incorrectly refer to
> the `File` type instead of `LocalFile`, so fix them to use the correct
> type.
>
> Also add missing Markdown code spans around lifetimes in the safety
> comments, i.e. change 'a to `'a`.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1165
> Signed-off-by: Pekka Ristola <pekkarr@protonmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/fs/file.rs | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

