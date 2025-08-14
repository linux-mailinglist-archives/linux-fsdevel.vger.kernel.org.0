Return-Path: <linux-fsdevel+bounces-57845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B634B25E1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 09:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11F8188B999
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A922D78F;
	Thu, 14 Aug 2025 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwG6sxcS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B67192D97;
	Thu, 14 Aug 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158059; cv=none; b=f8tY2XnyihZRuthgQKVZlZT8BAXw4VmUcrdtpGE6fwNaJVHbEJDlyLEa87yEjbPhLwjnscKK3t1KJWYXxQDHYeFl2aeHmCjh7TnbGklFP/r97Nq/S0Ea3HETvTlxrkukm/I15m2S2OtFRhVrLFWaBjqGfWWIvUr/2V971l1vWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158059; c=relaxed/simple;
	bh=8n2URVW1zH35PTkcFhfdDY6JdVB2waPtDBeuhXieSmc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ohqebMix+NuvGeK4kyIXHCy556VGh9XM2XSZ34wAb7/aLm4FfDk5pFoCVAJ32IGQEiRjAnfn6PbGv8/2e++0jsBC41bP53uaU3lsBltPXFLlWfCGVPdaorZySA9c2CZlUfCx/R7Hz5og8b8LrY4c0ENTJV9xs9Nc8ybsrgqhAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwG6sxcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD96C4CEEF;
	Thu, 14 Aug 2025 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755158058;
	bh=8n2URVW1zH35PTkcFhfdDY6JdVB2waPtDBeuhXieSmc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=XwG6sxcSZ4e7RBPNZDqVWlc3ShcGu5AG24wQYLVS5LuPGPuFBTFuMUCfAU9DlDul3
	 YqAuR5TsBysOtbQlj172ZmkZPYKd/7ItYBX8xn88aB0G/Z+kY515VurN2zAL9MK+aP
	 2MG1rFQwZ3KyVb4cEWKd1tWhVQdukyPiHI8Yh3wLIVATqkFlhbQQImhS5e/7yMLNHR
	 g4k8WyYDr386xoOcjRyzRjEC8hppnuQiX2NLbtUlHHCbwZ5ifMdulAfJM2VT+XMC7r
	 c3m+hh/ldIFcj/wcOXssueSZ7r00TCMS+BmzLqghaiMWPzbkWNstIT4NASnh2yY2Pt
	 VKLxy8v3XucDg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Aug 2025 09:54:10 +0200
Message-Id: <DC1ZLP61HJAL.3I2YF82Y4T7L9@kernel.org>
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] rust: device: use `kernel::{fmt,prelude::fmt!}`
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Jens Axboe" <axboe@kernel.dk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>
X-Mailer: aerc 0.20.1
References: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
 <20250813-core-cstr-fanout-1-v3-9-a15eca059c51@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-9-a15eca059c51@gmail.com>

On Wed Aug 13, 2025 at 5:39 PM CEST, Tamir Duberstein wrote:
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/kernel/device/property.rs | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
   =20
> @@ -413,9 +414,9 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> co=
re::fmt::Result {
>                  // SAFETY: `fwnode_get_name_prefix` returns null or a
>                  // valid C string.
>                  let prefix =3D unsafe { CStr::from_char_ptr(prefix) };
> -                write!(f, "{prefix}")?;
> +                fmt::Display::fmt(prefix, f)?;
>              }
> -            write!(f, "{}", fwnode.display_name())?;

So we're not able to use `write!` with our `Display` or did you also
write a `FmtAdapter` wrapper for that? (don't think we need it now, just
wanted to know if we have this issue possibly in the future)

---
Cheers,
Benno

> +            fmt::Display::fmt(&fwnode.display_name(), f)?;
>          }
> =20
>          Ok(())


