Return-Path: <linux-fsdevel+bounces-25280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE1594A604
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF0F1C21AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673C1E4EE4;
	Wed,  7 Aug 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd7UCqzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BBD15B57D;
	Wed,  7 Aug 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027367; cv=none; b=F+04/wfSZebWxc0JQq1euu06POO4xEJgKsQxhfONjpBipvbGDGORUYujNUFyJKjkDjtObM/LIxtr4lZps3qMUjwR8WD2GJh41wttDB4sEdXOUnqrcJxDkilMcs9lWqSW38CgEsvV0uMre6T5ApkzFjRojW52TqG/Wto47gAfIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027367; c=relaxed/simple;
	bh=v4eky5mAIA1TriyWSffAmA9CZvtHi+oO7jyKNWM/mqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piR4toxGc4c/kj1amKHOStRzHUrCdFwZCoJX4LxF4XWs+JfTXei3BUX5qsPQ6iHnIE06LUy+zQgKOKFywamAFABCaTNNlKrgPrKbf7EuNTUyBAWnEATd94IIzbp6xjWWMAJ+loaJYeOQ3lsKnkg69u1w9i88OKjV3WZVTVeXs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd7UCqzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3939FC32782;
	Wed,  7 Aug 2024 10:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027367;
	bh=v4eky5mAIA1TriyWSffAmA9CZvtHi+oO7jyKNWM/mqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vd7UCqzyWO196r8bBtMvG4o0QwVPxRQusCeFCFSi4x1vh20Nthj+oTit5MYz5le5T
	 gHOu0J4keCmMWEBcrEGQz3bEhRaAYWAq4iYBIxMYzn+PiOtFFsi3ZvvzLpqVC0FCXA
	 1DFYJJpXMedu7j27j/PKlEzgWLGZO8LUUguQPq/vfgoFnB7q3uy17JJay4BMCOfi8E
	 SlQK+0uv/Zmlna2OZJ86EIob9fTW/uFJ1Py71IeAdN8zDeIH5r+HYSCEraCuQAy7U6
	 gKLs9ZxAMRknYX9yilUYVqfbquxJZSFbjzQc+Zpp9+DhdDHHiHb4QD6fSWoL3BbIJo
	 Moa4rvXOOa6/Q==
Date: Wed, 7 Aug 2024 12:42:42 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 33/39] convert do_select()
Message-ID: <20240807-ungleich-gewarnt-31102838eb29@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-33-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-33-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:19AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> take the logics from fdget() to fdput() into an inlined helper - with existing
> wait_key_set() subsumed into that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

