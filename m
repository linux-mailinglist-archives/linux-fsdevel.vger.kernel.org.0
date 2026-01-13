Return-Path: <linux-fsdevel+bounces-73462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F618D1A1EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A470830433CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DA938A728;
	Tue, 13 Jan 2026 16:11:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCAF3815D0;
	Tue, 13 Jan 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320705; cv=none; b=mJKV9LI8plSODUCFMl4FcCL3ciRJWz3rQiQYnf7Ni36nEjTh+r0FE+5IoTBmpbQ8Ol06GIJcrL0RYa1qm5ivP7IaVo6AUaJC9N9jv5B5xe8QpisfEdaSBFdOylwZqnJW8CiSlNxFdQzCk7H/dHfa+gJ/oy4eeMEMNpPLODnTaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320705; c=relaxed/simple;
	bh=RziFtyAFAq2xUw5/azGRTQ3oAc87q5M2+ke48aIkqAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USvAySLxY35ginGTlg76ig9oSBsgBdWZr5TDraU2B3AWrLQ3xJ1BBp1Hj+2cSHoc29ivlVJkbLEja+vRzZNYyM2PBDuPZ4maLZDAKIGtLN++DviF1EPINZM1I1e2/Ah/ZAaH8CF11rirdlArmUHt1cIOXnGQul7LAjb84d18J08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C3F59227AA8; Tue, 13 Jan 2026 17:11:39 +0100 (CET)
Date: Tue, 13 Jan 2026 17:11:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 05/11] xfs: convey metadata health events to the health
 monitor
Message-ID: <20260113161139.GD4208@lst.de>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs> <176826412814.3493441.17733559986532199432.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826412814.3493441.17733559986532199432.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 12, 2026 at 04:33:51PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Connect the filesystem metadata health event collection system to the
> health monitor so that xfs can send events to xfs_healer as it collects
> information.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


