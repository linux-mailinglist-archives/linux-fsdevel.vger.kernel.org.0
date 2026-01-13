Return-Path: <linux-fsdevel+bounces-73384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8EAD1743A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B98483029557
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3B37FF6B;
	Tue, 13 Jan 2026 08:24:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB637FF60;
	Tue, 13 Jan 2026 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292653; cv=none; b=gVW1m8tHzmTIdKDc2vOBbQSd8dSp86so2mBK9XeID96T3m8llXKk2fQQJn2pexokKHOY28xS98IJdzxuP0QJJEtLuCyI3WkSEj9u9/V/79M+TJiUjp2FyBDVkOOZjvJX0XXvH9K4NIgYGBKc1cQgObRCRkZrE7Om36y1SjiMFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292653; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWxZpTL0fiT/g6NcyAsjbZpIKpWg506bqWeZiXL9qxXW38SyufxqD4N2m1KulAsSmGJum+UkLbbcsz8/4YJqrpiUeIiLZGPvRcA1CMEI4pUQXgVL1P8ccmQUaDLkcQl3ikyJErQCin9/NYzTz1lBSXZVo4Xp4ArrH4gLhPJIRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0CCDA227AA8; Tue, 13 Jan 2026 09:24:09 +0100 (CET)
Date: Tue, 13 Jan 2026 09:24:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 2/6] fs: report filesystem and file I/O errors to
 fsnotify
Message-ID: <20260113082408.GA32048@lst.de>
References: <176826402528.3490369.2415315475116356277.stgit@frogsfrogsfrogs> <176826402610.3490369.4378391061533403171.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176826402610.3490369.4378391061533403171.stgit@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


