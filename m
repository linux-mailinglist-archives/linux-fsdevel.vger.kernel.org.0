Return-Path: <linux-fsdevel+bounces-37777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E119F74A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 07:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68C9169E72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 06:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64A32163B7;
	Thu, 19 Dec 2024 06:28:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F878F4C;
	Thu, 19 Dec 2024 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589713; cv=none; b=GrzTl0aqn4ZTDdatcInf+a778PFrbyW6liVOejSGJPK3TJPE4c5aiaQIRA9NOaT3pnxF20ItDxN/m/RJVTd36FLyb7+jBVY4ITvwzr+FHhOokJKCvlndkHYFnJ/9KJBPPbmMCR3JNwc2lrTzsM6KR54XaxwI84th7UXArI3tXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589713; c=relaxed/simple;
	bh=c+sSTI/kYsg1YkJ3NxpUaxinK37XgXB9P2GIAjEtKUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gErxV7awwdR2ADRisOW6a12yfnosrf60A+qKMPloipYqpeSIqKyWTt0Hy2VPCDGxqX2/6/05TxeVhA49lzHVUaTeJfQZMDIPKvVt2ckjQ9Pl/83IP9Zc6Jae1HPW/mHbWIXyuFjMQQzOvAMoo+w6lXEmduqlmKND+7ggDgV38W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 84F6B68D05; Thu, 19 Dec 2024 07:28:27 +0100 (CET)
Date: Thu, 19 Dec 2024 07:28:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, willy@infradead.org, dave@stgolabs.net,
	david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org,
	john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com,
	kernel@pankajraghav.com
Subject: Re: [PATCH 0/5] fs/buffer: strack reduction on async read
Message-ID: <20241219062827.GA19904@lst.de>
References: <20241218022626.3668119-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218022626.3668119-1-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

What is this strack that gets reduced here?


