Return-Path: <linux-fsdevel+bounces-40207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A94A204AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 07:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6201163FE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 06:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911FC1DF270;
	Tue, 28 Jan 2025 06:47:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6634A1A;
	Tue, 28 Jan 2025 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738046846; cv=none; b=eTvyqYwf231yhAhuWgPZyzEz8lgvyuNNuZuNc483q4GgyeiT8rsdxAeX0oSb+gYE5ZQ5jh/n/nAXaODmLON4gFwssFRqxLny4z4WF7MrnyclSSYL64nVxB2qQ/GwQlBuEhHcPQLLHaty0ZpODtw3+ZxgDOS4cWDiyvdhbvs8okE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738046846; c=relaxed/simple;
	bh=RGTUK9De1R3vjTcwQXi/H24wBkRfW9qvYBiTRD14FRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPxdIGWBlpuIJZ3igERJgBNAwQ0UtXQN/yQ6JcPb0UB8VX0HvybwAo7akKrfu+yZgU9ProsvZ3rwDeRjkXfQsWsv8hXfUiftkVxw/Bnl1OvgLiyYRXfC5tJbhneKPgjsYqL8j13GATOA9vAekZhpF0yo4l0DmiDsiqvNoU1SkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAF5F68D05; Tue, 28 Jan 2025 07:47:20 +0100 (CET)
Date: Tue, 28 Jan 2025 07:47:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
	djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v2 3/8] scsi: sd: set BLK_FEAT_WRITE_ZEROES_UNMAP
 if device supports unmap zeroing mode
Message-ID: <20250128064720.GC21401@lst.de>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com> <20250115114637.2705887-4-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115114637.2705887-4-yi.zhang@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 15, 2025 at 07:46:32PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When the device supports the Write Zeroes command and the zeroing mode
> is set to SD_ZERO_WS16_UNMAP or SD_ZERO_WS10_UNMAP, this means that the
> device supports unmap Write Zeroes, so set the corresponding
> BLK_FEAT_WRITE_ZEROES_UNMAP feature to the device's queue limit.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


