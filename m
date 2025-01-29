Return-Path: <linux-fsdevel+bounces-40306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE2CA220CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E413A87CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8E1DE3DC;
	Wed, 29 Jan 2025 15:44:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43421AAA1F;
	Wed, 29 Jan 2025 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738165459; cv=none; b=reuVNCmBGSLJpPDkWoLhv06IKDHtHMtpx5ixoT71hy+R2+wckar+oIeE5R3L8AJJuQtyKXkjti1BGpSGpPY/7axwE3frLLh1ujPhsy4p6/EOOLyIFZ8MNvgdgAQGsnjWXyUSFFNM5Bc7bikcKgp/otc9vLMN/t+JXXidwknBR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738165459; c=relaxed/simple;
	bh=DTdOdu7VO+UHz3gmFsMZ5Nr7Syh5yplnddC/linvd9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3pTcpIK5D5bVlHbnK8NjKUFkcNGLvabJaRfOeR4o8tVlfabmZlfcc8jd5gWHyRLSVzF56y4tbPvafn16fp+y0CDFCpbnAKuDRwlF2WL+hz4i2MYj1/tAcmH3VtysjcDPYCFgg0GlYjAXXuxIqE9VnTteTqpoaljfs/9bVHw2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 424F668D0D; Wed, 29 Jan 2025 16:44:14 +0100 (CET)
Date: Wed, 29 Jan 2025 16:44:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] lockref: remove count argument of lockref_init
Message-ID: <20250129154413.GD7369@lst.de>
References: <20250129143353.1892423-1-agruenba@redhat.com> <20250129143353.1892423-4-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129143353.1892423-4-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Maybe the lockref_init kerneldoc now needs to say that it's initialized
to a hold count of 1?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

