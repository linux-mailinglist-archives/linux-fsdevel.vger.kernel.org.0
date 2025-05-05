Return-Path: <linux-fsdevel+bounces-48066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46D5AA9261
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C161898EAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44B207DF7;
	Mon,  5 May 2025 11:54:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4B1F7580;
	Mon,  5 May 2025 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446095; cv=none; b=WkEeJh1/dY97mrsWBHowDKnakwYwCuqFho+e8OS9cwtv9JeVyHCKHWeiRg/uKoVLG8ezZGpHKRLlsEimuZ8ktjhkTpUmB3to2e+o36l+ZkINxJfGdjnT/LuCLPoj5kbIqVoild6zlmMNTL/f8cPGu8RSU6coy3Vez3JyP5fUOCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446095; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVP3DUsh09Sb2qzsmQxjrwV7NZJIRnJczf0hDIi14ImOkOSbN3LKWRwihfReBfI41gyB2Eqbf8A4Dwxbfky7OhTWA0IUl9E43/1/JPS60MHK7x5s80XYHs9Uibf3sjC5ufQCJYZugDX2YRVgYDRdYjCtuaZJeZP0VBjP+cG/XgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F24C67373; Mon,  5 May 2025 13:54:47 +0200 (CEST)
Date: Mon, 5 May 2025 13:54:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
	tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
	bmarzins@redhat.com, chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com, brauner@kernel.org,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RFC PATCH v4 01/11] block: introduce
 BLK_FEAT_WRITE_ZEROES_UNMAP to queue limits features
Message-ID: <20250505115447.GA15314@lst.de>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com> <20250421021509.2366003-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421021509.2366003-2-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


