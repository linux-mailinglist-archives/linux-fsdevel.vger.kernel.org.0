Return-Path: <linux-fsdevel+bounces-66195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDFCC1901F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6C1C8779E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493F72BE020;
	Wed, 29 Oct 2025 08:15:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E41FECD4;
	Wed, 29 Oct 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725723; cv=none; b=C4kc05SHOKL/RfdUn6EdyC5wp2MCLTkulCtfJkXgcxvhEDBrskkNffk+sNLkAuGhWb83L/lzdbCXgubuDh2ngjmKtmUVzkae6/vGFbZyy7uI2KPlTJ0lXYGQjB3zhjQbSXqRGvrwnsk4laLgPvsMqg2G4d+vxfglYMzQVK/wyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725723; c=relaxed/simple;
	bh=FQXoF3ZWjp6RtkZbUtLbBqLMmCk7psdm569/6ZnbdXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4g/yKMwlUkzeBRYB3j58zlvzsRMH/KDlQXaaG1o12l53ouplV/o4MnYJIYVkAO5L49jQHFw9QWfnyWDKQkiqYcn/Ce4nG9p9gtxgfYa1uHBvgPvP19l/c2MOPXwgq0KNU4P9jkbmDtaZZWAKGti1GrHQp4T4IuTDlyLju85lSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D37E227A88; Wed, 29 Oct 2025 09:15:16 +0100 (CET)
Date: Wed, 29 Oct 2025 09:15:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/4] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Message-ID: <20251029081516.GA31592@lst.de>
References: <20251023135559.124072-1-hch@lst.de> <20251023135559.124072-2-hch@lst.de> <20251027161027.GS3356773@frogsfrogsfrogs> <c4cc53b4-cc1a-4269-b67c-817a0d7f3929@suse.com> <20251029074450.GB30412@lst.de> <d5d33754-ecd3-43f0-a917-909cd1c2ab3e@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d33754-ecd3-43f0-a917-909cd1c2ab3e@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 06:30:47PM +1030, Qu Wenruo wrote:
> Patch 2 and 3 look good to me. Thank for catching the missing pos/length 
> checks.
>
> If you like you can even fold the fixes into this one.

That would be best.  I just want to hear from Christian if he's fine
with rebasing, as he said he already applied your original patch.
Although it still hasn't shown up in the tree anyway.


