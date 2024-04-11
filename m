Return-Path: <linux-fsdevel+bounces-16648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805278A0747
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 06:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379751F248EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 04:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7FA13BC23;
	Thu, 11 Apr 2024 04:49:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A813B5AF;
	Thu, 11 Apr 2024 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712810997; cv=none; b=ZJSz3iipZMeuzD8+K3R8VG6ZsFUldShSqJ0Wr4l1fhaL76sjAJcSDKTf+eCTd3A29jYiigm2Wo/zmSHBTD2XqwABrpcj2leAAwDWru+PHNVtUxYmugVQt34d/BucaDNCc2nD31Cl6Ak0iP3XAqr3AAuXZJDF4Ezx8WbVFpGO6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712810997; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHflAdUmXMDfYUTcKUsAXPmVZCErrVZwhLs1KrSfPecI9aMhKDAADoL/3m9b6kwxu4KhjFn5kQCP0CJpSU4sKblJ2umsqZvgV12fDR4loA1XvsjmAOSCjFfIsqM32b0L19fqw/qFRxlZKZqioWlAaDC820qSYI1rxjv/fGSbJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1163968BEB; Thu, 11 Apr 2024 06:49:51 +0200 (CEST)
Date: Thu, 11 Apr 2024 06:49:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v30.2.1 15/14] xfs: capture inode generation numbers in
 the ondisk exchmaps log item
Message-ID: <20240411044950.GA31964@lst.de>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs> <20240410000528.GR6390@frogsfrogsfrogs> <20240411041441.GS6390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411041441.GS6390@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


