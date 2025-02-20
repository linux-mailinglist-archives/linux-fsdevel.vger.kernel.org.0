Return-Path: <linux-fsdevel+bounces-42152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717F1A3D445
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7421791FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA321EEA23;
	Thu, 20 Feb 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4lJyPu5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A781EA7EA;
	Thu, 20 Feb 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042646; cv=none; b=pSTDA/Ruz3VeY+UEQmvDmo0p/EsURzLzLm6NtjPXHlBiLQjQKxpjb/xBuHpBxyaNv0WhE9uoMLxOjovys/Fmu/adT+FGuEqu0Og0DhAg8IGvln+sG1SXsfi6RGmHmKmoTSTVLLHFM2c3OaAf0269NsybqnJqcXtQGNasdGIkiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042646; c=relaxed/simple;
	bh=zkUYS70I+Nf9ka7zz+ya11cHc3vvIBMrTr1lDF6Vwqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehStALhHoeI+vA7C88UXn1DgNdQhgCJYASXeIwHtWTGd9nM04u2dNpejLdl/kbe6k5zGNkS24YSGPGKIWz9VGlK4uXDww1bmVRNEYv+Lms5GbpXXS44/1PC987swnLkWmnBltqHQ6jK0c3U/ekmW2cYxiF4pi1RXZENbFJ7Sqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4lJyPu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D677C4CEDD;
	Thu, 20 Feb 2025 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740042646;
	bh=zkUYS70I+Nf9ka7zz+ya11cHc3vvIBMrTr1lDF6Vwqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4lJyPu5kWyn/jyOWkFwCSkJ65mg/MDTtPrFHwMrepRBv8Qh/puOI4FZVNnpntdGU
	 yJHwFR6LPnbOMvYl5dGFEsADDgPNOTRTTXGCexsdjr1aDgcc81SdCn979qBjgL2fpS
	 dU/amBvz0RC83jXfoZYHhlfLH+eiKAijsWuvP3HgmZVPqckQSEgmLk4TpzHgBBVrGd
	 FKyQOecN0pqBKeb7ifjpAL9o5/0eBhetKPs1WdH+biwzhBNJV20lgf+JCqcJpnxOFA
	 eoYwNqSPeI7nXT3rxGTwEttySA4QxombnzWS3pDGpa+OFvW7oFaot7KTCUKoExBPRV
	 MpnbyJhYrUstw==
Date: Thu, 20 Feb 2025 10:10:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2 00/12] iomap: incremental advance conversion -- phase 2
Message-ID: <20250220-mitgearbeitet-nagen-fa0db4e996f8@brauner>
References: <20250219175050.83986-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-1-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:38PM -0500, Brian Foster wrote:
> Hi all,
> 
> Here's phase 2 of the incremental iter advance conversions. This updates

Hm, what's this based on? Can you base it on vfs-6.15.iomap, please?

