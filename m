Return-Path: <linux-fsdevel+bounces-46634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5CFA92324
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B9819E7EDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355EC255232;
	Thu, 17 Apr 2025 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvLgR4jb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD82550AC;
	Thu, 17 Apr 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908857; cv=none; b=lMw1O1Q4uBjTPdhGVl/+nwRyxSGkMNi4FfSMgUIFM77hCekYZ67YdHl9JcsMQpogxcI07SN3ot9KcenGj9qbtUBBm6N2vudWQt7bsY4BQxvdpbNHHrJZtiSuq5m/oqC+TQWc7/vGDm6IlKPwzPemoFnwEqG9Hg1kKVkyRGJ5yXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908857; c=relaxed/simple;
	bh=/q2tqlR47Os+3XctTy6MhLoJWhn1rjLydWY4rCgvTdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTVzylIhlIxpq5bOz0NNLJGl8+fjjad6RQQOJruXbzKUJCLqumHE3M+iy1LxWv+BFrP0htoe6ft+70qafWHC0e168b96Dx1xmDet9rg9LpnotNE5STeGIs3cMmfpQdb62dsPF9yOXMhkGD8HeFJbrgDyFAmctatV0vBEszB7xAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvLgR4jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E9CC4CEE4;
	Thu, 17 Apr 2025 16:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744908857;
	bh=/q2tqlR47Os+3XctTy6MhLoJWhn1rjLydWY4rCgvTdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvLgR4jblj84RMcQ6RrZ14hJCOIgd/Pu6yucY87wNkRczDjKOJKHf3fGEZmw492rV
	 64NJMAxSPUCloyCDXSQl/2kHICv76iHNlSqBc38aq8P728JkazdrZ29DsyMk+NeE5B
	 Zgzuv569x3wQQmxhvWAPcxyRAz2VfDMUilyTy/OBMeJNMmbqRJR9DTC9gbi2lScZ/a
	 HEZdiZurGn2BmYEeoA+x30hEzllAenz2sKBYzmiyfkUnexJSVtFLpgqn81M0Pplszr
	 im30Um6HV+p29LMiFn8BH4Ko7HSQkfDVJtDyGoUKrAFk9bd28ca2T4aGmE/2HcrE/O
	 U3opxX5BW6j6Q==
Date: Thu, 17 Apr 2025 09:54:15 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Tso Ted <tytso@mit.edu>, kdevops@lists.linux.dev,
	fstests <fstests@vger.kernel.org>,
	Gustavo Padovan <gus@collabora.com>
Subject: Re: Automation of parsing of fstests xunit xml to kicdb kernel-ci
Message-ID: <aAEyNxkMyJEVHRhR@bombadil.infradead.org>
References: <aAEp8Z6VIXBluMbB@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAEp8Z6VIXBluMbB@bombadil.infradead.org>

On Thu, Apr 17, 2025 at 09:18:57AM -0700, Luis Chamberlain wrote:
> We're at the point that we're going to start enablish automatic push
> of tests for a few filesystems with kdevops. We now have automatic
> collection of results, parsing of them, etc. And so the last step
> really, is to just send results out to kicdb [0].
> 
> Since we have the xml file, I figured I'd ask if anyone has already
> done the processing of this file to kicdb, because it would be easier
> to share the same code rather than re-invent. We then just need to
> describe the source, kdevops, version, etc.
> 
> If no one has done this yet, we can give it a shot and we can post
> here the code once ready.
> 
> [0] https://docs.kernelci.org/kcidb/submitter_guide/

Forgot to add Gustavo.

  Luis

