Return-Path: <linux-fsdevel+bounces-59146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C555B34F3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 00:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EAD3B9484
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 22:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2872C027F;
	Mon, 25 Aug 2025 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="ZXPGWGCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4838AD2C;
	Mon, 25 Aug 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162479; cv=none; b=HBLt4/sbCSdgIVmXAklWwTDx1rI/BTcjXPwGDGU9zHqi+xUZsLofgcK6zI/V6osC33dWxg8LLPv14lQs91OOgQxwDEYSNx2uL98K+w2/4l7W+D0kqgHowZCHHk8TVd09lUu6NwuLg0W9Is284NXywuQUbRLMDERMnzBDa6pIkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162479; c=relaxed/simple;
	bh=KUHNvd/4RB+C4mqKq6271tUITmjV3ZqRBPwdCYk/E2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYUAe4u052QHx48h4d3IXn9kofrqJL1Desni301gwnlYTNCLbvP8MdJMw3IXZSS8gSPXb0pW67U0EMph3k2z+hu5cxKaD22nRxFRRJRDQCKBORKf7Bx9S1IVkGULUFdnpWXVZ5/6wLGJL8cTMParC2VB6f+JN4kO1vxCP7JU8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=ZXPGWGCD; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=protonmail3; t=1756162475; x=1756421675;
	bh=eTlJMEfiQekU1EYYQrUuNLGsX/vZUxAdnlT3ykMi/8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZXPGWGCDKQciBqfMR+wuqkY9UX6yJ9YwO3zgsbnMXSdgCNLmyBNcn/N5YTON3thqZ
	 d79fE7eDEG7klNIB0gt85hpHkGkxSWDaw0kpiEmq/i56GnE3JNqtq3hrrw10G23pRp
	 BWZvxa8vWhMi8Euv+/I0KLxfjGYogVWXYQ+1YCc6s79v6gAM6HRWSBJeX8ip03nZWL
	 gXWL5La8SLXVMgE2K9nKMnf52E8de2xQ6eg777KzIRtH6a8LH6dgavXr8+ovn4LDDE
	 NGUNVXRo2E5282n+YoYH8AxR8Lq7dmiMjcp5o2BWWJ6zabptQsud27IQgaC5jM1WBf
	 +7T2q0lu02vzA==
X-Pm-Submission-Id: 4c9mMC2r7cz1DDCD
Date: Mon, 25 Aug 2025 22:54:28 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: file: use to_result for error handling
Message-ID: <aKzppHcaaTxpfMTI@archiso>
References: <20250821091001.28563-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821091001.28563-1-work@onurozkan.dev>

On Thu, Aug 21, 2025 at 12:10:01PM +0300, Onur Özkan wrote:
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
> 
> Signed-off-by: Onur Özkan <work@onurozkan.dev>
> ---
>  rust/kernel/fs/file.rs | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 35fd5db35c46..924f01bd64c2 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -10,7 +10,7 @@
>  use crate::{
>      bindings,
>      cred::Credential,
> -    error::{code::*, Error, Result},
> +    error::{code::*, to_result, Error, Result},
>      types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
>  };
>  use core::ptr;
> @@ -398,9 +398,8 @@ impl FileDescriptorReservation {
>      pub fn get_unused_fd_flags(flags: u32) -> Result<Self> {
>          // SAFETY: FFI call, there are no safety requirements on `flags`.
>          let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
> -        if fd < 0 {
> -            return Err(Error::from_errno(fd));
> -        }
> +        to_result(fd)?;
> +
>          Ok(Self {
>              fd: fd as u32,
>              _not_send: NotThreadSafe,

Can be further simplified with:

```rust
to_result(fd).map(|_| Self { fd: fd as u32, // rest... })
```

> --
> 2.50.0

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

