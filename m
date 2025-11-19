Return-Path: <linux-fsdevel+bounces-69046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD704C6CD0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04D1635B68B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A505130FC33;
	Wed, 19 Nov 2025 05:43:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E273234964
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 05:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531005; cv=none; b=TsRFD8q3G+k6Yum4TXRTozzJUpVHSvbt2B2IDBexeEGg8qBkVv4QqMl/kfzVzENUTBPlSfmo8oAwA3SEam8LtdDlWqWKfF2IcHBrsXIIPxGybt+Ziq5u0t0MVtF6YmEuEMUjlbcI0c3T5YvuaYmnqMrLoAfOJ2IlCDzgenxwe/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531005; c=relaxed/simple;
	bh=YdqW1qkX0aAvEa/q0elGoUsP2OUnuvkslHfZWHDKIgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxTCb0i0K14vNqP/4fLK6oML/ybEj0epXrE5Fy/4U71bNUW/mcMapH18vLMVMRlLYLE0Q/P259O2+cwZKLZwu7RPbWP+fmn92hXUNUdGZrRegtPQxFSf6itamkQIVU8gNfYx5FL8ZV2KjJtd8zT4Tt5mYYxDhAsSe1ZO7/XIrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D772768AFE; Wed, 19 Nov 2025 06:43:18 +0100 (CET)
Date: Wed, 19 Nov 2025 06:43:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: unexport ioctl_getflags
Message-ID: <20251119054318.GA19925@lst.de>
References: <20251118070941.2368011-1-hch@lst.de> <20251118155913.GD196362@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118155913.GD196362@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 18, 2025 at 07:59:13AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 18, 2025 at 08:09:41AM +0100, Christoph Hellwig wrote:
> > No modular users, nor should there be any for a dispatcher like this.
> 
> Does the same logic apply to the EXPORT_SYMBOLs of ioctl_setflags /
> ioctl_fs[gs]etxattr?

Yes.


