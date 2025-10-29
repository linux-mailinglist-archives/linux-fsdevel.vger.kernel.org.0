Return-Path: <linux-fsdevel+bounces-66290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4277C1A891
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5902D1A27174
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F362848A4;
	Wed, 29 Oct 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osTOBNJc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8509278E63;
	Wed, 29 Oct 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742166; cv=none; b=KmcCz6eVmfWODeiGGm8JrwMp3OyU0lr2Sql8+fya1sQ4eFgAcLDB/zq3gde15HWYJwVz9dCvL/eCtMIzEAcg4B6P9e4HUNhQKGq42O7D8GY04v+8JftMKmXw++QlpEapTDQpyN8upNT/SNxZp9jVDW9kj9OnQpJAt3MDqOhvviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742166; c=relaxed/simple;
	bh=ZEXPdBOJMbforEZ+mDk0Bgiyc2yv4NHYDWhiTE/bkJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcAjn5Wp3R0XIA3DKcbL0X8zVjqYnPzwk8ttdntEf/IIaZ7exzjlbGUBp9/p/imtgvI/6FfwB72UIH2yuoWxX0KeLdXBuWAOQafkYzWqoVQmtTJkG1iOcKfbxoUP0ayk27HbBKr57fUQQZimHlJuCHhsIm6+y2h7U6kqtunUI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osTOBNJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8E1C4CEF7;
	Wed, 29 Oct 2025 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761742166;
	bh=ZEXPdBOJMbforEZ+mDk0Bgiyc2yv4NHYDWhiTE/bkJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osTOBNJc9DnNCgA2Hu4DOJoP1ZYe3nL+NST3o60P3bsku2UsroZfk16bk0IV7ptDl
	 nz2CJROIns9dKVNZm8AIF+UqFycbtTCeAWpgZzO9xwi6ZRF064eOp4xaBu9NlRnrqm
	 yD6ZvK6p5zfVXQz0rqClyvHOS9iDR3/2xChknLHlZvme0n6BXA9lcaaPihtlfDyOr+
	 NHwnr0QgMSYSATYIyUhzoQxSdECJ3PKa4Nd2h6xCQ1suXZl83JH0XOaPJgbMNs2xyL
	 i/DJSxLOEajktOp6njOxYfMpFPz1N+p8Wn+7z0MwMZACxAfntsF97/GpMH6uYIdxi0
	 OUnVp2/zeBeZg==
Date: Wed, 29 Oct 2025 13:49:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	mmaurer@google.com, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
Message-ID: <20251029-orgel-eishockey-44848cc46a6d@brauner>
References: <20251020222722.240473-1-dakr@kernel.org>
 <20251020222722.240473-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020222722.240473-2-dakr@kernel.org>

On Tue, Oct 21, 2025 at 12:26:13AM +0200, Danilo Krummrich wrote:
> Add a type alias for file offsets, i.e. bindings::loff_t. Trying to
> avoid using raw bindings types, this seems to be the better alternative
> compared to just using i64.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> Al, Christian: If you are okay with the patch, kindly provide an ACK, so I can
> take it through the driver-core tree.
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  rust/kernel/fs/file.rs | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index cf06e73a6da0..021a6800b46c 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -17,6 +17,11 @@
>  };
>  use core::ptr;
>  
> +/// Primitive type representing the offset within a [`File`].
> +///
> +/// Type alias for `bindings::loff_t`.
> +pub type Offset = bindings::loff_t;
> +
>  /// Flags associated with a [`File`].
>  pub mod flags {
>      /// File is opened in append mode.
> -- 
> 2.51.0
> 

