Return-Path: <linux-fsdevel+bounces-62142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDDBB85713
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22AD7E1EC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A700B31195D;
	Thu, 18 Sep 2025 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaWxf3se"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB430CB36;
	Thu, 18 Sep 2025 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207690; cv=none; b=JOnyknRM9gLjgOrULvNERCFpM1wWoRh589bpEOPoUh44hgRY2PRBSfaT/U8E53AcI3A2E9zk4eJF3iYAzPtBMSFoKuS5EbI85vJrcrUX1U66fieZ5I4v1UtP/eCryZaAnJ4ZDe8BgucfYJHucwiA9FDuBggcVtoManqT4DPWQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207690; c=relaxed/simple;
	bh=YkUhrdJ77qxCz0LRTerH2THmYwSvWHK0xjh4fDRXL9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfy048nUjmBbunUy4Pg5Nza9LcDBLlJMAquAeKHT9ZaZYJ8McsryJIKcj3xo5zjmvdlTNN/o2mStCqGObXqc3xfXPehcMpW2I39+q/PAw6ZRta3mHgx0Ow4CNakvxSGK6+wHrdMzVMEQrtgD1Jm4MZUXpDWVth+GHduxskujMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaWxf3se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B63CC4CEE7;
	Thu, 18 Sep 2025 15:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758207689;
	bh=YkUhrdJ77qxCz0LRTerH2THmYwSvWHK0xjh4fDRXL9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaWxf3se0dIvqb+7AeF0vK9lNeEWQikgoNUdodIzWcvmwp/nWek7ZVPjnaU0bJCBo
	 5J9xZuryhX9T/jXhlCQyuhkfHQycpR7cUYEYhiunQks/4g8PQkDtIHa8DFQSqByldD
	 ShmLuQUXZmsRASFktaEgsl/rV4t8RpaoED4eHWgs=
Date: Thu, 18 Sep 2025 17:01:26 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: ManeraKai <manerakai@protonmail.com>
Cc: "aliceryhl@google.com" <aliceryhl@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] samples: rust: Updated the example using the Rust
 MiscDevice abstraction
Message-ID: <2025091850-brownnose-applause-1dac@gregkh>
References: <20250918144356.28585-1-manerakai@protonmail.com>
 <20250918144356.28585-4-manerakai@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918144356.28585-4-manerakai@protonmail.com>

On Thu, Sep 18, 2025 at 02:45:44PM +0000, ManeraKai wrote:
> This sample driver will now:
> - use the new general `FileOperations` abstraction.
> - have `read` and `write` methods, that use a persistent kernel buffer to
> store data.
> 
> Signed-off-by: ManeraKai <manerakai@protonmail.com>
> ---
>  samples/rust/rust_misc_device.rs | 283 +++++++++++++++++++++----------
>  1 file changed, 195 insertions(+), 88 deletions(-)
> 
> diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> index d052294cebb8..c8e90eb9b9ad 100644
> --- a/samples/rust/rust_misc_device.rs
> +++ b/samples/rust/rust_misc_device.rs
> @@ -7,92 +7,139 @@
>  //! Below is an example userspace C program that exercises this sample's functionality.
>  //!
>  //! ```c
> -//! #include <stdio.h>

You seem to have dropped the leading ' ' character, which makes this
diff almost impossible to review :(

Please fix that up and only change the modified files, not all of them,
in the example.

thanks,

greg k-h

