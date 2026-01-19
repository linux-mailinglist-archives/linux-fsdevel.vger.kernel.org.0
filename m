Return-Path: <linux-fsdevel+bounces-74459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F1FD3AF6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06813047900
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CC638BF76;
	Mon, 19 Jan 2026 15:44:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C622A7E4;
	Mon, 19 Jan 2026 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837470; cv=none; b=Emnv61BH0W2V1qf4rXU8Lj/SrkjDM7XQdBvMCM7DH+aJqYjeMv7RyEV35Q2GU/ESTDQTnD5wbpfua8ShbsVbgr2/6uuHkfro/eXabgx4Dk0scj5tE/NEsh/JDMqxBdDn8CtgvMGeP0u19X+TQqVdwya5t1N5nyYG1FZs3p1ApnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837470; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma1SUXwry07vjaXK7rC3MEWaMODPIajoxct3CFrTv/Lzdzl3iUfrnF/5jL6rxoTSiYng0OkXdshrlQJ42Jthd+s7ZgEww5pelzVJJkc+qM9biWzpQ5OkUUhojLc4Nsp6jfEL6SWFK3Asfl+2AgQieXeRcicmoC35sG3s7vF7ejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42D21227AA8; Mon, 19 Jan 2026 16:44:25 +0100 (CET)
Date: Mon, 19 Jan 2026 16:44:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 06/11] xfs: convey filesystem shutdown events to the
 health monitor
Message-ID: <20260119154424.GB10152@lst.de>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs> <176852588670.2137143.7251435441992863871.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176852588670.2137143.7251435441992863871.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

