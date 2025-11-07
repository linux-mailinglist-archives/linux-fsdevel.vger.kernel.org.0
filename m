Return-Path: <linux-fsdevel+bounces-67434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C855CC40196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 14:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9E61882269
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD7E2DECB2;
	Fri,  7 Nov 2025 13:26:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E152DA76F;
	Fri,  7 Nov 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521988; cv=none; b=VrW4kY0zFXrk9+0vCrzU5C9VFBq4jWbHL6MlPY95n30oWep98nT/d4g5NwIo4qFd+CZedoODvFMSdBGwEWl2EEG/dw6JPTTYR0wW7GhE8dOwDlSiGAsQU5nI+42xdg79m/VdYWMTKgRJkokd4WRXF5jMBHiPZ9Jt3QSCqNz+5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521988; c=relaxed/simple;
	bh=Ao5qcDG2x2Pk7wQJpAaZGN82Q0K+rAa5Sj+gPcX8Y54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk4JdzCt+yHKZ2Yirme+MW6H6swyuf4Vr4NlQVwb7Y9eE95fsry99IXc7lPs4xICtzW1QIXnMCIhYiXAjkmlqgQBaQbcuAspjbNYET/MUlDAkrQFuB/wy+H2J3y6yS+er8xY8DWvjRJvlnV2DNZTSrG+bE4lDOU3leK6pXdaCQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A20B6227AAE; Fri,  7 Nov 2025 14:26:20 +0100 (CET)
Date: Fri, 7 Nov 2025 14:26:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] locks: Introduce lm_breaker_timedout op to
 lease_manager_operations
Message-ID: <20251107132620.GA4796@lst.de>
References: <20251106170729.310683-1-dai.ngo@oracle.com> <20251106170729.310683-2-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106170729.310683-2-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 09:05:25AM -0800, Dai Ngo wrote:
> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")

I don't think adding an operation can fix nfsd code.  This is just
infrastructure you need for the fix that sits in the nfsd code.


