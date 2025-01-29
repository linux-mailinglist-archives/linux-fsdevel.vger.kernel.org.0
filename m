Return-Path: <linux-fsdevel+bounces-40312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B842CA2221F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858663A481B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98CE1DFE06;
	Wed, 29 Jan 2025 16:50:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1191DF96B;
	Wed, 29 Jan 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169412; cv=none; b=OWpKzWVytfmfzwmFov7Qi2wnqtcEI6TRYbkwwRav0QOL7raJkd1zTrnZDBGHxzPHaI9EQr7HLA6VafgR4NeAre2KZpMjgbVYAHMooiOcX9SreT3nrncqG6BJx036lqEwxzEAUm4G3SxsxN2lG8AVDUFbcEJi0J3KqL+fmk6/h5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169412; c=relaxed/simple;
	bh=3escXZ70xI/kAiYoAh+7AX3bAL3ZwGiEx/dkOqoc7uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtRRhBu7FqJwIxnKb10xghgfjrwfTkl5PqH5VLhlbZHP/mQrgrYbb8msbBzhgpOznYEqAbp+PurQWN58UcaKF7GpaQgP39BshA+yPTPBZY/tthhNHenX0nY/7LTGi8Fnxes6EMH1YdlcmYCju980W6Swo0AHmBr+w6cS/g+VlI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A808568C4E; Wed, 29 Jan 2025 17:50:03 +0100 (CET)
Date: Wed, 29 Jan 2025 17:50:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] gfs2: switch to lockref_init(..., 1)
Message-ID: <20250129165003.GA12913@lst.de>
References: <20250129143353.1892423-1-agruenba@redhat.com> <20250129143353.1892423-3-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129143353.1892423-3-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 03:33:51PM +0100, Andreas Gruenbacher wrote:
> In qd_alloc(), initialize the lockref count to 1 to cover the common
> case.  Compensate for that in gfs2_quota_init() by adjusting the count
> back down to 0; this only occurs when mounting the filesystem rw.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


