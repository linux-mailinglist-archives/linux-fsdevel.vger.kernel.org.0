Return-Path: <linux-fsdevel+bounces-67107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941AC356E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F6056354A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888D312828;
	Wed,  5 Nov 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYFG5s+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF9310627;
	Wed,  5 Nov 2025 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342799; cv=none; b=RLopNuQxjS4TMhAj2lQLS8QjEs40XFTNhnk8J3gkXJAwjt/HGzw86f2cXgXWXN/HmoyhJ5cq1TZKImzUNE/yHdJYUDPOOaryfcDXM1wc4jrL9pA8+ib1obqqGxAH5cl1TGRWCdsN+hCrnU1Eaum5hmVls+A/fJTmJuEDCt7UFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342799; c=relaxed/simple;
	bh=Kn5k+II7Q6PI7eUOxy9uvtx5B6RUC+vCItw+ue1K0W8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=YVaMB7ZO3JwVVHB5q9ey5yaP5KfegiZAC2T59SpnaGg7jZd3h/I2UV7WRENB0bLtgoAeIFEYRwAbVKekOT1cprTINd5prZUssHMm4WegzkH+1RBl0VBPdihvMnSRq1iPjGp5yRSzSd2xaMr/JNwMxmqKG6muojxi+O2KBQd6fOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYFG5s+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A53CC4CEF8;
	Wed,  5 Nov 2025 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762342799;
	bh=Kn5k+II7Q6PI7eUOxy9uvtx5B6RUC+vCItw+ue1K0W8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iYFG5s+bxCf3LLlWZhzGZSgteNY4Ud7oI0ag26CDRUGPAVW8NzniKIXEmVVXQMoPV
	 E2eWBUDD2fZkq4v2z0/aITAXEEa/JJXPceejW+kaoW0NeaDCeIMTwEEWK/fdZLq+/3
	 k2LAhGn+e2Fit/fceI0qF38ljdyn6kBw3j+NBz2mqAHgeBQbt/EFrhm3Ta8APaVM2J
	 BkJBFPahEzhR6LR5c647RBFA1uL/xPwu5FaxhE7DDNEnBPuuS/TKSxplu4OeBGwGk4
	 ikbxTqC2nf5dIgaOzC0thdFzg2RMO+Wactbn+M/h9t0/PcsYU7gOBOUCCy/4H8YVwZ
	 xLpczcFewJhcw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 12:39:53 +0100
Message-Id: <DE0QDQKZUONC.Q9H00WGX8YCO@kernel.org>
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
 <DE0PXYNG8O8W.19MUQ9TGA6C04@kernel.org>
In-Reply-To: <DE0PXYNG8O8W.19MUQ9TGA6C04@kernel.org>

On Wed Nov 5, 2025 at 12:19 PM CET, Danilo Krummrich wrote:
> On Wed Nov 5, 2025 at 11:59 AM CET, Christian Brauner wrote:
>> On Wed, Nov 05, 2025 at 01:22:48AM +0100, Danilo Krummrich wrote:
>>> Replace the existing file::Offset type alias with a new type.
>>>=20
>>> Compared to a type alias, a new type allows for more fine grained
>>> control over the operations that (semantically) make sense for a
>>> specific type.
>>>=20
>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>> Cc: Christian Brauner <brauner@kernel.org>
>>> Cc: Jan Kara <jack@suse.cz>
>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>>> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
>>> Link: https://github.com/Rust-for-Linux/linux/issues/1198
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>
>> What's the base for this?
>> If it's stuff that belongs to fs/ I'd prefer if it always uses a stable
>> -rc* version as base where possible.
>
> Please see [1]; the base is [2] from the driver-core tree.

For more context, when I picked up the debugfs patch series from [1] I pick=
ed up
the patch that only introduced the file::Offset type alias for loff_t as a
dependency and sent this series as a follow-up.

Hence, I can either take this one through the driver-core tree as well, or,=
 if
you prefer we can also wait for a cycle, so you can pick it up through the =
FS
tree.

> [1] https://lore.kernel.org/lkml/DE0C1KA14PDQ.Q2CJDDTQPWOK@kernel.org/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-co=
re.git/tree/?id=3D1bf5b90cd2f984e5d6ff6fd30d5d85f9f579b6f0


