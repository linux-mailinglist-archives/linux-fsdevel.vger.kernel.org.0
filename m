Return-Path: <linux-fsdevel+bounces-69048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C14C6CD3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A7413815AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581F30E859;
	Wed, 19 Nov 2025 05:49:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47524EF76;
	Wed, 19 Nov 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531391; cv=none; b=mbJ2C0KEjzq3UO8MG9TUPHCLabKCF+i0qzoupb4EFGmW9AQvUSKyLU7TfHKyqxE1CjN22DBxXlzdyRsUKIeAVpjPOzK9c1BiZFuR09J0ZDO/6L4ojEzarNpNRYfRGTbUJcsAuc290eYRRecGoNHxZxbsb3wJSUw+8ZVBQy3EgVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531391; c=relaxed/simple;
	bh=wo526rARRm+OOJkOvOMWW78YziTKANQUFagQnH8e+Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgarzUX5VJLnXIjrALd72zw3Bytrni8D8rFjWjSrpZzexO68sXyMJvqiWWthGlLcJagCYbk2Ycsha5KkzUYPgLQU5Ozo7Ol1JEPox18neEWX0pw/bYwEV7FYng66W14V0B4uT3yx/J1xgRLDJmgvzzgqopEYevgz/MRjubm9Usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D6BE68AFE; Wed, 19 Nov 2025 06:49:46 +0100 (CET)
Date: Wed, 19 Nov 2025 06:49:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: brauner@kernel.org, djwong@kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Hongbo Li <lihongbo22@huawei.com>
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private
 field of iomap_iter
Message-ID: <20251119054946.GA20142@lst.de>
References: <20251117132537.227116-1-lihongbo22@huawei.com> <20251117132537.227116-2-lihongbo22@huawei.com> <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com> <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 18, 2025 at 03:35:45PM +0800, Gao Xiang wrote:
> (... try to add Christoph..)

What are you asking me for?


