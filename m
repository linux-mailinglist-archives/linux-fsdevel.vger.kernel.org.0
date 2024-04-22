Return-Path: <linux-fsdevel+bounces-17366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2038A8AC3F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 07:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CBA280C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 05:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378771865C;
	Mon, 22 Apr 2024 05:55:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED5DDA3;
	Mon, 22 Apr 2024 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765325; cv=none; b=s16ipNqPwC2iI5FziquUWyU3BWHY+rAPDx/4CiBuTVDYRB/Ns8uhtwQudUnhG52RCuXiwqhYPNusrdbHPAs0lYoB7zUokXqV/DzKIaNqUGBcg2arMRoSUaRSlSn2v50H29alVF6UtjSYo4f39RyqLKynxiPGKrkpkTSRCYbDOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765325; c=relaxed/simple;
	bh=w9ljiRY6YjFSme8tOIlX3N2MrqVy2zXPAPoF5q7/v4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYkn1zL+tkPMDc14M9WTFR60D+JSvElvVVRU7QziwzmS8hGJBVBMV5CpiDcMiShC6M5EloKRQAV5WPNIzUqPQqcDnxEWdmX9yg/CFaORUzPcAf0Eet2WEUaCFijFxYZvqG2repfrOFgLei8BDwyDPte921Ms7wokQSQhxA/7Y3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3E7E227A87; Mon, 22 Apr 2024 07:55:12 +0200 (CEST)
Date: Mon, 22 Apr 2024 07:55:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, abaci@linux.alibaba.com,
	allison.henderson@oracle.com, catherine.hoang@oracle.com,
	dan.carpenter@linaro.org, djwong@kernel.org, hch@lst.de,
	jiapeng.chong@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, thorsten.blum@toblux.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to c414a87ff750
Message-ID: <20240422055512.GA2486@lst.de>
References: <87jzkqlzbr.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzkqlzbr.fsf@debian-BULLSEYE-live-builder-AMD64>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Apr 22, 2024 at 11:16:13AM +0530, Chandan Babu R wrote:
> Christoph, Can you please rebase and re-post the following patchsets on top of
> xfs-linux's updated for-next branch,
> 1. xfs: compile out v4 support if disabled
> 2. spring cleaning for xfs_extent_busy_clear
> 3. bring back RT delalloc support

Can you please drop this one first:

>       [6279a2050c8b] xfs: fix sparse warning in xfs_extent_busy_clear

befoere I resend series 2 above?

It is the inital hack for the sparse warnings and extent busy sparse
warnings, which just causes a lot of churn.


