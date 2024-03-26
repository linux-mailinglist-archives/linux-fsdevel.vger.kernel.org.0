Return-Path: <linux-fsdevel+bounces-15364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46B88CABA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C7632570E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED71CAA0;
	Tue, 26 Mar 2024 17:26:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DA1C6BB;
	Tue, 26 Mar 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473962; cv=none; b=tts+rC5LRCQ18njQY6uUPiTbByuykqnqEeEIH4abBMtK7fs85ESopLVYWAPqDV7xbSCx/TPwpkYbZWyDDt0BLw7xQ45Pa6O/uqa+2AScKAKto6udRi/o5gz5V+hDfBiqnq+L3JT3ajFqQ57wg/uFfhZBSfu+4jFxFchMCItiuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473962; c=relaxed/simple;
	bh=o1tcffiwxN2Jenorl2JYLG0iVXFgumFhxVqbh2krL8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaCt5otfsGTfWH6Z4SUW1E0HUUhfCuPhIoeXEPZTQYDhNG4f8vraFZEn8lbX5epHVPsk1XFIRHqkJEnQL3mmMRaGphyAozbMvv59KF9KwQZQITz4af4Hks91J+W9A5Z9Yg6wnRGrtmVmTg7M9vSigityImE0ApI4EK2NlyoToUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4386868D49; Tue, 26 Mar 2024 18:25:57 +0100 (CET)
Date: Tue, 26 Mar 2024 18:25:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Message-ID: <20240326172556.GB25884@lst.de>
References: <20240326133107.bnjx2rjf5l6yijgz@quack3> <20240326-lehrkraft-messwerte-e3895039e63b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-lehrkraft-messwerte-e3895039e63b@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

Not a fan of the new bit, but I see no good way around it.

Reviewed-by: Christoph Hellwig <hch@lst.de>

