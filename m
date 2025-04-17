Return-Path: <linux-fsdevel+bounces-46636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F841A9232A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4152019E7CCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141F255237;
	Thu, 17 Apr 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfxposJy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6995A19DF9A;
	Thu, 17 Apr 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908883; cv=none; b=oPqDvLs7hUKdK2uEeoToiuHjsDID/1i6t6PTI3SVRdV03y08SJTJ11W/bQ3/B5LMS5tiKRKbwc7tF7R52DCF3/oouEPy7UwUg62GNytKBsJfOFuvBBkNghh5ywWKA90uSzkiy96LabpzCc82bgqyj9v0knchJrdLoivy0qwZkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908883; c=relaxed/simple;
	bh=9hAIQHlzBVrKv8LqkQF37X7McU+y8Jj+NjOt8ky7z9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqtch/WsS6lUUr/Qi8Q1tlhRbkD8xktYv1z8lf4Hk5h1VM2SS3bhm1HPvFCwRfMLqr8PTEI9TK2H0wsmMmVWd6BCGVjQoCV1V+7AGCmK79WsRLEpPIZKzlmIUKiIIgXSrsCr4IrwAjh1emWxJLHz70YFmRPnl0Sc0Ls5NCOKwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfxposJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAFBC4CEE4;
	Thu, 17 Apr 2025 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744908880;
	bh=9hAIQHlzBVrKv8LqkQF37X7McU+y8Jj+NjOt8ky7z9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfxposJyFbhAbymtMWocwLnIULoSS3TM8DRV69aKfwPimJ+Y3ZbOckKB/ahTMzY2J
	 0Y2ljcz3DGbmDUX5op5WTW0KW/gTk7aBOFgNhZ6iD7ypHYczEtwoWoY0A2vAqEEf1x
	 qppAWFT610pq6qc0nLCx9hla0NUI9DRfILF6WgGV21PCuffLC/msojF1fCQhy+FKPF
	 z43jFBnaaJ8PTCoNKWLYt3ViTO3T2FYPrefx4ALuyPy/aHEsmx7mSJyENZ9n8aCDfi
	 q5vfMkPhoLLER00haZCAZJ7/FRsN2bDa79LmnfeyI1spCIxopI2YIofiHSOh0tb4D4
	 69u/ClEf8pNDw==
Date: Thu, 17 Apr 2025 09:54:39 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Tso Ted <tytso@mit.edu>, kdevops@lists.linux.dev,
	fstests <fstests@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Gustavo Padovan <gus@collabora.com>
Subject: Re: Automation of parsing of fstests xunit xml to kicdb kernel-ci
Message-ID: <aAEyTweu14GX327X@bombadil.infradead.org>
References: <aAEp8Z6VIXBluMbB@bombadil.infradead.org>
 <fcf7af77-1f2e-4b07-abb2-f7c0740ebdfc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf7af77-1f2e-4b07-abb2-f7c0740ebdfc@oracle.com>

On Thu, Apr 17, 2025 at 12:53:56PM -0400, Chuck Lever wrote:
> On 4/17/25 12:18 PM, Luis Chamberlain wrote:
> > We're at the point that we're going to start enablish automatic push
> > of tests for a few filesystems with kdevops. We now have automatic
> > collection of results, parsing of them, etc. And so the last step
> > really, is to just send results out to kicdb [0].
> > 
> > Since we have the xml file, I figured I'd ask if anyone has already
> > done the processing of this file to kicdb, because it would be easier
> > to share the same code rather than re-invent. We then just need to
> > describe the source, kdevops, version, etc.
> > 
> > If no one has done this yet, we can give it a shot and we can post
> > here the code once ready.
> > 
> > [0] https://docs.kernelci.org/kcidb/submitter_guide/
> > 
> >   Luis
> > 
> 
> https://git.nowheycreamery.com/anna/xfstestsdb.git is one possible
> solution.

Sweet thanks!

  Luis

