Return-Path: <linux-fsdevel+bounces-65734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257BFC0F416
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2ED468341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A43148A0;
	Mon, 27 Oct 2025 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO6SJy2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F5313E21;
	Mon, 27 Oct 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581751; cv=none; b=aHNzKptASP6Q6+O2x1ijqgV5jXCvG2kvrUaDztJrm1WkR4w9gnIHBWykD4wTwrItrwNfW4dWRRLMmvoHOId4Xx9BlN01Hj57L8aZ7Qea//UXYQuJeRdt67LXBOw8a2NoZTmNH5qgbUht8iN6YBsI36iMtSJ733eXtNdoMICuR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581751; c=relaxed/simple;
	bh=fzESjS0XDN0jMXrqP7cqR2R1KfPusrt1ugLn/E/jggk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afuaptCa/0MfNJT4C1zSkbRVAiH0H2JAv1OXNTOpP5JmmsRAbWH643DvT7SVqu5N2mtZ0m4MrxtWwXkyPKquVDCTitJQZtyQsHNCzoEsx/i4yEyjYMhEb8bSmSa7wFpVyDi8oOLSEjHosrOY6s+8OlERN9xlw2WE9JlL/fJgmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO6SJy2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C0EC4CEF1;
	Mon, 27 Oct 2025 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761581751;
	bh=fzESjS0XDN0jMXrqP7cqR2R1KfPusrt1ugLn/E/jggk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dO6SJy2cR9ETtL/60jBcEgkRBNwtLHJ7hKOVt5V5OxUAyO4mBLpTqFHTnLdNz31pn
	 YJN9vqiVVghkxleu6IqGtyKqyb8GU/shYhnwWt7TcL+4aAprM5edJijuh88Hd0KzEv
	 Kifr+ssZF42+6zCy+M1o4pYvTtdJANknkiEyaqPaQvhdO39x1l7BeYPXR+tNWbVvot
	 9/NSFnYxOQZXQGSQQK1/5O+B29g4YWDXC2bOdRugmOoPzmdLqiB0Z3c2veHBIbFXAw
	 lFMF4Rq3w0zArhbIpjxlFsvIvrN1FeeEdUhdx/Kpc2bhKLXqly8Y7NAoSaaBPHFY0N
	 uA/ig4pc1fwBQ==
Date: Mon, 27 Oct 2025 09:15:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 01/19] docs: remove obsolete links in the xfs online
 repair documentation
Message-ID: <20251027161550.GW3356773@frogsfrogsfrogs>
References: <176117744372.1025409.2163337783918942983.stgit@frogsfrogsfrogs>
 <176117744519.1025409.3383109218141770569.stgit@frogsfrogsfrogs>
 <aPsRSFaxLNSxuDY4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPsRSFaxLNSxuDY4@infradead.org>

On Thu, Oct 23, 2025 at 10:40:24PM -0700, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Maybe expedite this for 6.18-rc?

Ok.  I guess removing obsolete links is a bug fix :)

--D

