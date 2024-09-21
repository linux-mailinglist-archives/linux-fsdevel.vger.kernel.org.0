Return-Path: <linux-fsdevel+bounces-29780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D679F97DBF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 09:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A6F2819D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F613F43E;
	Sat, 21 Sep 2024 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/8CF+vi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1852C9D
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726903163; cv=none; b=gBI/a/FNHVhywyDyjEB3CXjWLYKCZtd/P4NZPXXx548r2wRf0FmtuJrGH5hUkwaa6mxWXqoM+UsXnzD1/kk1Ed8O3oYbMD/mmuuNGPuBChKevmzY+kF9BBY4YVmfNL2+ONvoSoTZCO/REmQydrigXc7bC6rSFAQ/NExY339SDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726903163; c=relaxed/simple;
	bh=2CSVsbBzGUSYhZ7xAMjXq61nK8MSePG4jJZJy4WhDCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFfYaJfxvYaQ0QzHbQKWcO0SgcosisK5QMi1Ylw7isyP52+ouWj8XHSVeqGd0tWsbdlVBQj56vnnEXv+ZyFvQsXcqDdq2PcXPR6axEcbTcT5so8nETuqmNCmsgBJREQszseVoTRTVVpkI96eCOVsph6jQ60tukDaiJ5DndHdcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/8CF+vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC81C4CEC2;
	Sat, 21 Sep 2024 07:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726903163;
	bh=2CSVsbBzGUSYhZ7xAMjXq61nK8MSePG4jJZJy4WhDCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T/8CF+vi7cr9jxFFVYtyhlL4DgW6YpNM76umOQRMfKcKXOuuvZCyj4USISY7agLG3
	 8zgpLAgo9I9rrMn0gyJdekfi0tCQJG6bPAvZD/kfeSZv0dIZeHouK49Zk8vvT68q3V
	 ndsJYrga1t9JUKYFgRfgnrph4s1g36nosWod3J0NjmyQR/Baus2c4ZBBHLJqI1s7qy
	 9xPXbPi2K4Xb1++Z+1CeycXvXrRHM6x/9mRyMRVI4Esr5QVN0Zj8LKix2exuwdGzDa
	 dSj82YxuUIHExOHIsKh9yvegqaauqde2sIovn2ISimPfGGSsw7e/0Ja/zxPim25Fgr
	 IK74D53nAN+1Q==
Date: Sat, 21 Sep 2024 09:19:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Add FOP_UNSIGNED_OFFSET to fop_flags
Message-ID: <20240921-autoteile-fahrlehrer-201ea80e1ea2@brauner>
References: <20240920102802.2483367-1-liviu.dudau@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920102802.2483367-1-liviu.dudau@arm.com>

On Fri, Sep 20, 2024 at 11:28:02AM GMT, Liviu Dudau wrote:
> Since 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
> the FMODE_UNSIGNED_OFFSET flag has been moved to fop_flags and renamed,
> but the patch failed to make the changes for the panthor driver.
> When user space opens the render node the WARN() added by the patch
> gets triggered.
> 
> Fixes: 641bb4394f40 ("fs: move FMODE_UNSIGNED_OFFSET to fop_flags")
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

