Return-Path: <linux-fsdevel+bounces-46742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22067A94A19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB121686DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A78528382;
	Mon, 21 Apr 2025 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci7uoF6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1FDDA9;
	Mon, 21 Apr 2025 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745197726; cv=none; b=k9Fh8zQGOuCNwQTnaCbYCbERW4CDiRh/hFVAEW1n+K5GpOhXdor4Lf6NOHV4Ltpadba74wiPPYhYRVa8erU21jcWrpsOrRA14HqCIOfmkQSuL71rFtKIBxnv9QFJWAFoaZ8jPCtVvkbYeNY5XWrAMdyUWqTLzf1f8/kzQsbg664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745197726; c=relaxed/simple;
	bh=HYbFKvmmfEt6aMEq/No8M3SujuEYwPc0zzLEwL3o+6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx0mLG0wdkIesDeH01jYdHsGeUthAfqYeaS+F6tbGJCw8t690SVHweTAW1axYH+nJWjwdMUxh09cmeK4H3Q6k0/5yVzrNAf8fmcmUAGdXBGzikD1f4rhoaT35Qbhd2x2QscUsrI/d4ieODkaEbmzg5kgioTApbSfVonZtmNSC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci7uoF6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557D1C4CEE2;
	Mon, 21 Apr 2025 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745197725;
	bh=HYbFKvmmfEt6aMEq/No8M3SujuEYwPc0zzLEwL3o+6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ci7uoF6UjSJ1ueQq/VLbmk3dMb9JWGINEigZZCc1vYrVtm0wZQ/Yq5dlMghK8nK/M
	 o0ctr4yZOeRKJX6Vvgz4uUOvLUsNirlX84+lg9HiZfUmtA70O+wrxelvqKbXliX9NW
	 HR0dWeX/0FH2OhLnDc1X4A9nKWBz5X9nY1ghmC9EpGDu1B8Gc7ltuXycgIgL6aL46I
	 IgNj98lLsjGvSuLlkTbz2W+QzxJGLP9Ngj4+FygEDeota36Q/48CEF7+LF8XjEMA9V
	 PSmq1SY3ozcvB3UqSN7HvoX7sqbhZvNUMP2EoS3zy418mYh48X1q6wRkjOrYUAxo5U
	 VHzwelI+ABlgQ==
Date: Sun, 20 Apr 2025 18:08:41 -0700
From: Kees Cook <kees@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] enumarated refcounts, for debugging refcount issues
Message-ID: <202504201808.3064FFB55E@keescook>
References: <20250420155918.749455-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420155918.749455-1-kent.overstreet@linux.dev>

On Sun, Apr 20, 2025 at 11:59:13AM -0400, Kent Overstreet wrote:
> Not sure we have a list for library code, but this might be of interest
> to anyone who's had to debug refcount issues on refs with lots of users
> (filesystem people), and I know the hardening folks deal with refcounts
> a lot.

Why not use refcount_t instead of atomic_t?

-- 
Kees Cook

