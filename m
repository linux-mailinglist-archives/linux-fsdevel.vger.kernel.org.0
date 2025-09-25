Return-Path: <linux-fsdevel+bounces-62813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B147BA1BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 00:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC511C27181
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 22:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9931BCB9;
	Thu, 25 Sep 2025 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuXuIxvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6346B5;
	Thu, 25 Sep 2025 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838302; cv=none; b=f1P0xSmET5tmdZabVxpDd/LJh+uwYleSKfUxhLyydkB4w7iVfwzQl2w86qgnT/1Wjtfx9MZbyKXONqzCVqVPNKn9G56Gu/fuSs+2hfmQcTWhfB3udluavtWq3eZcNpS/AczG1C0V7s8UPBZWMEY8Lg1eIrIwWDlMxMpqddqveik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838302; c=relaxed/simple;
	bh=46nzcX7EQ1S87NIV3BIAH28q83fRnfEoERyE5l8Fjo4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=YtZjFoKf9QLUAyyGKWNuJjyN8fho1QgGZwLyWezUtRZwWaQcParehA9mY9gG9SwJoxWkfOORVOypeoletQydI+Ki7uziZ/9niGTDZHG7NWrwuQ33rVfZZf+bsQ7oPiNWCyF+g88XnrGeeCwtofryaf0IoH0Dty7z1pibylmahCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuXuIxvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E06C4CEF0;
	Thu, 25 Sep 2025 22:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758838301;
	bh=46nzcX7EQ1S87NIV3BIAH28q83fRnfEoERyE5l8Fjo4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=NuXuIxvn0ye2HTMcv75rNTWm8m+Cc++4iReWGWXWgxaf2MmLsKeGGZn6kEg+XSbgB
	 mpsA5BLBT4UgfCwPgfzKrllHYqJhqMP7V1sGtIsWivwcRgyexywtuR84H0dYs2IVMT
	 KRdOWLzvTMFhYGOLcKMihIhcf6oHmMJY9gdwsf4qd2/dm6EhvgxFkLwa2MYkLHAcgS
	 2ro8OmJp4AleP74o9E+YbWUKuynWJmB5urJfRirBpVj9sxyyCaOgejeRXzJD3GQaqd
	 Zg2FbutDNdn0D7417+tr7dR3fxzP28dzmyWk3seLggMCElNPWT48roSQ3ONmRYJdjF
	 q/5zUiW4Ocv7g==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 00:11:34 +0200
Message-Id: <DD2851XYSIGT.1FV9R7M15XS8F@kernel.org>
Subject: Re: [PATCH v16 1/3] samples: rust: platform: remove trailing commas
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Waiman Long"
 <longman@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, "Christian
 Brauner" <brauner@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <llvm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20250925-cstr-core-v16-0-5cdcb3470ec2@gmail.com>
 <20250925-cstr-core-v16-1-5cdcb3470ec2@gmail.com>
In-Reply-To: <20250925-cstr-core-v16-1-5cdcb3470ec2@gmail.com>

On Thu Sep 25, 2025 at 3:42 PM CEST, Tamir Duberstein wrote:
> This prepares for the next commit in which we introduce a custom
> formatting macro; that macro doesn't handle these spurious commas, so
> just remove them.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  samples/rust/rust_driver_platform.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

