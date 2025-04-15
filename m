Return-Path: <linux-fsdevel+bounces-46501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4DA8A457
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604FE189D298
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 16:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162A29B212;
	Tue, 15 Apr 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeSmc16m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4E29A3D6;
	Tue, 15 Apr 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735197; cv=none; b=CIRSZfSDkTZj70yJkfDbP/Faa1eDBQEn6HR/Nx/IjL03TO0Gx37/uQJOu/MR0yiDyFVSBXhOpLBTndusNNw4Vivf6BTay6qUsGH+YLyP+C1DbmKFT09trpMxV3jZWkuvzUTiFDXEw1KiCJwH+pEMzPggTFxUmDES6CToidUU6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735197; c=relaxed/simple;
	bh=5iuI/wHGLq4bbWLyb304laW8WAZz2mPyUrChYsYacWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDgu4TdqWYrXGXHcyegRfL51/8eKXNFu7X2ljuevKUGCXd9DEeJaR1Pv5uNNzm+faA5mNKSEcBTSMPN9/proNBy48DTWjZbmZNm15dkUozX9q45QWbJV1IvZN5tYNMoC1d/TkF67kH2ar7qvkAPSDlqWvlUjYW7v/OuuH+c5AC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeSmc16m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C612C4CEEE;
	Tue, 15 Apr 2025 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744735196;
	bh=5iuI/wHGLq4bbWLyb304laW8WAZz2mPyUrChYsYacWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeSmc16m+NksOC1fsuRuUbpIOTnsBjSb81VRdlK5y3noNMSUbvkbowMV0fmMd24oS
	 W74FtiUz0u3pdU35P1VoloKfP2wEEhJ8Wgw0WJBc67eXvG7HGv8LtH94zkeew1nyTQ
	 bLwNXEfPz8FcR2qVSQ/lyfllskk6nTZlAXQsP4LYbKt2I56IMXvoRP7C1+Sw6GbGsJ
	 w9CqQlPukiaUCM/NFsPy6giUSGqdq+OQTpcZJH3BQdk64niXEL2YxV0Nm/qgyFLmcY
	 MRqZHx6yVeQ68NU0yyhmprssXS+gDHCvKlA6JceEPFGmrivuhW+FfgxAfeRPA3GSct
	 UIOUsQzOv8+Zw==
Date: Tue, 15 Apr 2025 09:39:53 -0700
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: remove uselib() system call
Message-ID: <202504150916.5E6B4CD82@keescook>
References: <20250415-kanufahren-besten-02ac00e6becd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415-kanufahren-besten-02ac00e6becd@brauner>

On Tue, Apr 15, 2025 at 10:27:50AM +0200, Christian Brauner wrote:
> This system call has been deprecated for quite a while now.
> Let's try and remove it from the kernel completely.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Yes please. Though I see Debian still has this enabled for alpha and
m68k:
https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/alpha/config#L779
https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/m68k/config#L684

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

