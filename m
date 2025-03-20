Return-Path: <linux-fsdevel+bounces-44505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B645EA69F52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 06:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DA33AA1BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 05:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9F1E98FB;
	Thu, 20 Mar 2025 05:32:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409317A2E2;
	Thu, 20 Mar 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448743; cv=none; b=A6SVgOw6BypwTcPcBVU/8sta3g5/6yd2DF5UqxjEbOLa9fwzE7xbNpAqM/wee2TZ41WBUwsmQDdAedp8hWfagNIi23KeIzCufm3c4fD1YRi4zavF7kUbEI5uW4eMHAEDGALyV9HtR/c4zP4Lm/7vj8fmV1+YyfusQ6Hv1e7BZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448743; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac6gJD1ZZPqcf29L1vhka3wAB45QDGHe2HcGz3KiBbow+rAlZZesU98OrSWK7zkKuccGmV3OULGN6lDQBSGQSBzhrl6xMNIEa7y+EEawteCwDQ7mqheCFMxtGVRJMsEbPSYjvOUiVdqzrQN3KCWH5RMt+hDqrEHUMZfCPSnHBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7184568AA6; Thu, 20 Mar 2025 06:32:18 +0100 (CET)
Date: Thu, 20 Mar 2025 06:32:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] iomap: fix inline data on buffered read
Message-ID: <20250320053218.GA12640@lst.de>
References: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319085125.4039368-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


