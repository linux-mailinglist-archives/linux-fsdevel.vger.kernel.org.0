Return-Path: <linux-fsdevel+bounces-10667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2284D2F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 21:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E00C1F227E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2721B127B4F;
	Wed,  7 Feb 2024 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TPl5b9d1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521201272CE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337623; cv=none; b=VlxSvz0mS27/rdouFT/fGXYWZ7L/3Ge3zsZf4mpAy2SE4D1w63HwNMmpapga5GhJJE8e+2oGanxNnrKt4ny2m2CU+H89CeZfELbHtxf93rM67JF7cyG+N2Cwy9K++BdNQb1ZnOP25wWzzWJDmn8GVuYrd9Je7ahGcW7pr8d80m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337623; c=relaxed/simple;
	bh=qtCUwIWIbC5yKsRl5nCr/tGp30Ggmi5PGWVrJfvJhZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYJwh2a8C8wSXhXEcYFu5X0kSa420tnYRRO8PMetALvkDNSorryw+AwRio4ZxG/OX4HkQMJIkjIxCjf3Fi/rup6eTU9iS4dpRsXhw0QMfVix1DtjLvYNOnQxn1faa2CZxzodSojoXBbTlMjZ9cuU7OqLIeybwzOTdX8kxHoxvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TPl5b9d1; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Feb 2024 15:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707337619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZPHrfKX+msQdL3rSnYcgNf84jeoY0gQzoOYJ58QxWE=;
	b=TPl5b9d1E3b3GEVnI0pEP0cn/rhWzBDdQdlo4sUn2xcTZTVmsPIZS9vRo2fEsa1SDLY8yz
	LhwW/w2c5x99IfRX0FzLK6Pz2JO9s91/01OSgq1ul/V6kWz/XO4tEbugRjSjUqioc8gmIW
	Qz9kcHejHRFVNepb1zLGYZb7ZhNQ6us=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <kq2mh37o6goojweon37kct4r3oitiwmrbjigurc566djrdu5hd@u56irarzd452>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240207174009.GF119530@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207174009.GF119530@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 07, 2024 at 12:40:09PM -0500, Theodore Ts'o wrote:
> On Tue, Feb 06, 2024 at 03:18:48PM -0500, Kent Overstreet wrote:
> > previous:
> > https://lore.kernel.org/linux-fsdevel/20240206-aufwuchs-atomkraftgegner-dc53ce1e435f@brauner/T/
> > 
> > Changes since v1:
> >  - super_set_uuid() helper, per Dave
> > 
> >  - nix FS_IOC_SETUUID - Al raised this and I'm in 100% agreement,
> >    changing a UUID on an existing filesystem is a rare operation that
> >    should only be done when the filesystem is offline; we'd need to
> >    audit/fix a bunch of stuff if we wanted to support this
> 
> NAK.  First, this happens every single time a VM in the cloud starts
> up, so it happens ZILLIONS of time a day.  Secondly, there is already
> userspace programs --- to wit, tune2fs --- that uses this ioctl, so
> nixing FS_IOC_SETUUID will break userspace programs.

You've still got the ext4 version, we're not taking that away. But I
don't think other filesystems will want to deal with the hassle of
changing UUIDs at runtime, since that's effectively used for API access
via sysfs and debugfs.

