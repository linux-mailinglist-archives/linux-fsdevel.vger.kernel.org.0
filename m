Return-Path: <linux-fsdevel+bounces-59078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8865B340FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922D5164DAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB25275AF9;
	Mon, 25 Aug 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAFZ/9U3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C3B242D62
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129362; cv=none; b=QkmvbOqJUfeXZrz6+EbXGYal3/75yrAQXltAHkoJZ9CDW4VI9emYXz5DJUYIuN5e9wYn8V4d3X7wzcV3roLA0gtoiTNR17yCk8vkIIsxqk/c1iAnmozhwl/YMmc7AmjHPLWp5qVQghxVKyrbtyWSACy+1yCf5d75hGxvDv+UBtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129362; c=relaxed/simple;
	bh=snU0LICL+o9pljtSrlfCFi8nw0ogDzqUrBjcQAR+SYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4pDYDgdNVt5fqROTHlgseSL408MiFm2tGSWj/V/R6NpqL9nWufjr3gNFrDGy9v9oegPFbU+QMsTLDKvIaKZ71Et+A8DyBKQGHtzOGhmDZ6tf33Ozhwhp5woSE2//BB1i3mOFSD3AxUrGkMDBxM7KBcyPOVWrrjQQ+QPjqyntYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAFZ/9U3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7CDC4CEED;
	Mon, 25 Aug 2025 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129362;
	bh=snU0LICL+o9pljtSrlfCFi8nw0ogDzqUrBjcQAR+SYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAFZ/9U3jLE6eD/TXvG61Ut0fWdDvYBPPX2HRsryFEoItqv9gXcdA6mF6AdgTUzdg
	 Jue4ehs9A7dv2Q4AJYTtcy9/I0nmqMpDqRG1qJTIdxlbvoD3Mlu2bDxzWTliC7r8bu
	 yXektdvVO/9ObYCgdMBdgu7R5Si0/t4gLUBEmBCeSWJ/L0LmO9nRi5szF7eASARGuE
	 xYvILobF9LJpxXKfDgW52sNv7qOl59sVMnIzzBttr+QbEPyMAXaHXUuTpho05r2oXc
	 2cjXdkyI5wl/8Btt7QIJZ7AmuWRFUtIVM041SF7kIivpaVp5PqOIjEYTm5XKp63Cvi
	 osgDQlJrfth9Q==
Date: Mon, 25 Aug 2025 15:42:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 52/52] fs/namespace.c: sanitize descriptions for
 {__,}lookup_mnt()
Message-ID: <20250825-notleidend-meerschwein-d45cca80ccd9@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-52-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-52-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:55AM +0100, Al Viro wrote:
> Comments regarding "shadow mounts" were stale - no such thing anymore.
> Document the locking requirements for __lookup_mnt().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

