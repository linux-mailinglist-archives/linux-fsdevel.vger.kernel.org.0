Return-Path: <linux-fsdevel+bounces-59065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D11B340B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28204855EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F4219A7A;
	Mon, 25 Aug 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhEBbRYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413834A0C
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128683; cv=none; b=Tpx57IMvW5SDXFecY35JfElp+43SsaaHH7VF3hUDg0HvUDbpsonqxZqqnTRWOxOaHVw5tS8Ujy1DbNo0S/h34rlzx7SaMN9u5CkcJSvPNVvBdv/oqfMfnIoHmQpwl/NtrTYcFQwvKwTSYFeODBcuhgijMPACVMgftBFzkrPlxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128683; c=relaxed/simple;
	bh=/ObrBJGM4tpxY1O3Ke6S8IIyo13MnC0WU0RVvxrXw9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJwMwexIVJyrbMivmXD1K+e56fvQ8TFg+xwTZFUJ+W/tPodmt8v8CQ3rHdD73RjBLNijKMlDZo3hD+6MCdGQscUVxX0EiVMLERtw7UF46ing7SPmZ0HUmbcOGqUITRzaOuFr5EHRRL2bpkdFrK04DUGQF1rU6t0J/XlbLuJvNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhEBbRYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F004EC4CEED;
	Mon, 25 Aug 2025 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128683;
	bh=/ObrBJGM4tpxY1O3Ke6S8IIyo13MnC0WU0RVvxrXw9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhEBbRYHrR2kSFy1jrFl/yFeS/N15VA2rwaOtBSlHO7S+s1z2k+AVVCvJV/y99XQB
	 skvvEnCfdhRfFqMjhxlsGlxqesDWgfW91SuHNcEY6bk5PZvsYBh959+JkjCEswTjAc
	 zeYa5APaUlQBZqgZqbREy9FxwHUvZYvplijfaTM9mLM5kJ9msXoChsVydOj290C/jk
	 3kHxFumg/F3R6ksoviDTuYDY0ECIPcOnE5HCupjQ3npnfnYEGLEhE5mJUBBLVxNyDy
	 uxCOVBb4FJqUZ0AgTyrRdBhgUHMatRG3PfyOrj6y9ryYp++b/10NHYdTnaEuIZzqZT
	 J1LuD6jdJoOLw==
Date: Mon, 25 Aug 2025 15:31:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 38/52] drop_collected_paths(): constify arguments
Message-ID: <20250825-geerbt-mitmensch-3e2395894c9d@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-38-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-38-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:41AM +0100, Al Viro wrote:
> ... and use that to constify the pointers in callers
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

