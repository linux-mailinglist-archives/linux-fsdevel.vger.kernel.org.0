Return-Path: <linux-fsdevel+bounces-25275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC01494A5DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FD61F22E9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7171E2114;
	Wed,  7 Aug 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX4LK5HP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A912D1D174E;
	Wed,  7 Aug 2024 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027237; cv=none; b=DlLnAx/4iqe3YU8+Sgb6pKjUaSaC3AMDKRLyq+5Qvd3F9V+h8fsMXGC8W/0R9IpLvxK+3CGXpGWX8779fsMAVNzRqVQkOhXiIgnxcc3V/I8HfRy0N/tBZ7FXkTqA0E+OIyil4XUa53EfbAk/emcQETeAUzSEJAzbORj9JUM5vIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027237; c=relaxed/simple;
	bh=80zetxD5H5qrdVS/gorqtI+qt0Dsv638gx4RFosqso0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB9cHH2i/hVO3Lfr1GDjZIK/ljBIRY6hiRviimpC69kMP5mUYbdgDDBlZjdRGFGSyVDOGNjdKyecvHnN3c3WO77p2JN1+fB/sdx9ypV4e5uWi01kuC2GP36zJIKoECH7rsv0q+mXvCwSjsqyaGbG8ZfI1PEHYmDjwP29bP3sD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX4LK5HP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4647DC4AF0B;
	Wed,  7 Aug 2024 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027237;
	bh=80zetxD5H5qrdVS/gorqtI+qt0Dsv638gx4RFosqso0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aX4LK5HPXhH4HNzmNf9xbgUb0CZaQ2Z+RCXzjRBMSawqtQM9c3GZlCSI8ntaSz3er
	 /u3WvLfKOvH0UVW4jNSHAmcKxbxVTC799aeT8cNOUUuqvsFpsCXJVxNk+nclDXj3CE
	 EXe3MAoOod11I1jRKkIVp5nq8Yy/8jxf/bawJM9s/C0rcsa3EaxsfZurSqbAdt034Y
	 fvzi+IlPXYYNBe5gU1zpQ4OcBgFxTQMToNdVuOKzY9x0MJEa2iYwAbwCkDbVqaClRW
	 J3UBu5srchTjvXENMopna9qkVPFCBq+5bbLMfnkGpwrfTC9DEmHKR8+ZPOS3H3WUeG
	 Oam0/IUq0pfIg==
Date: Wed, 7 Aug 2024 12:40:32 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 28/39] convert spu_run(2)
Message-ID: <20240807-ankommen-mitbieten-6d87a9de0764@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-28-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-28-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:14AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> all failure exits prior to fdget() are returns, fdput() is immediately
> followed by return.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

