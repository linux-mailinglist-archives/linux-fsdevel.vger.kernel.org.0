Return-Path: <linux-fsdevel+bounces-32106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199669A0A17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7F5284532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28158208962;
	Wed, 16 Oct 2024 12:39:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C8207A33;
	Wed, 16 Oct 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082351; cv=none; b=ro3dEsl2fuTzh+nbGObhpSHT1TwstWDqK4ygk/aNWHgTyKW2oKBWeeDva5K0YAmV+SW7H/k+dmpimtO3nDDWeLFq1b+XaPz5L9Agn5Ov8w7GSY5Tku35wpwbJNz85xLUEFYd6BeNeHDuoUBqCII/B7YNgj6pXLmH2js46NhCZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082351; c=relaxed/simple;
	bh=ehfbyLA2hrTlt/v0bKSE/WccAfhfO60QTjcFYbWjGhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXNyi8mLYx1QoVhxRvLkxM65d2wRwABKg+D0RDVAPd9ONhBzdNcWC7Tlz6/xNQbPWuuyxVm/6JwnxPqOnqLHbsR0uH8/aVaSVHzTcjz/tXQv0ctqamsfiukCNFRvdR7mQIJT0WeuRSyP4Z6XeV5Ttzfv1E+dY4pDCil5aQlG1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AC6A227AB1; Wed, 16 Oct 2024 14:39:03 +0200 (CEST)
Date: Wed, 16 Oct 2024 14:39:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, brauner@kernel.org,
	djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	dchinner@redhat.com, cem@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH v9 3/8] block: Add bdev atomic write limits helpers
Message-ID: <20241016123902.GA18957@lst.de>
References: <20241016100325.3534494-1-john.g.garry@oracle.com> <20241016100325.3534494-4-john.g.garry@oracle.com> <20241016122919.GA18025@lst.de> <e56a3443-6195-4171-8c22-b78450f0ba26@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e56a3443-6195-4171-8c22-b78450f0ba26@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 16, 2024 at 01:36:40PM +0100, John Garry wrote:
> thanks, but let me know if you would still like to see any changes.

Sounds like this is fine.

