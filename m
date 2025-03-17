Return-Path: <linux-fsdevel+bounces-44173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C2DA6423F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 07:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE0F3A6824
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 06:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503AF21A424;
	Mon, 17 Mar 2025 06:56:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4241E1E0F;
	Mon, 17 Mar 2025 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194618; cv=none; b=TIPKNJytQ3Sl2cXqSGPaupNbt30U/PfK0P6MsxjJU4JBpFUjUjStjGOGbgpGKvJ+ncXm6aWnMeQzVsMDnj5MUpVxndoGBXCxRoW/9xIHk+dAhRHpFNjgB84I7eZilqqCVEwuaAkCJUFopjtzmH1rV9TR0JOQxUvlCMCaZ0J7GRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194618; c=relaxed/simple;
	bh=v8N6JXkgUTdf++cxQmfupfXXXAgagRCUspNqW8n+L4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UykzRY+OhBHOq0ynTh7uc+2BIknbxx5ZhnflV1kRsllmVPe2LwwyjM5d6H+bybLRt4dHG+i9DlQd2zmAC6QEg+6757FbREESi8qzCHUEkFtEVJI/y0PgQHCsqVIbywPL9gQff58x9POlbIoMXS4LRJ5GjEBTSplbXkFIrbHtpX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AFB2668AFE; Mon, 17 Mar 2025 07:56:51 +0100 (CET)
Date: Mon, 17 Mar 2025 07:56:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
	dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v6 12/13] xfs: commit CoW-based atomic writes atomically
Message-ID: <20250317065651.GA28079@lst.de>
References: <20250313171310.1886394-1-john.g.garry@oracle.com> <20250313171310.1886394-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313171310.1886394-13-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
>  	return error;
>  }
> +int

Still a missing empty line after the previous function.   Also
please add a comment what is atomic about this function and why
the regular path doesn't use it.


