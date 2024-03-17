Return-Path: <linux-fsdevel+bounces-14663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D746A87E046
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131DF1C20B24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238C208BA;
	Sun, 17 Mar 2024 21:24:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8933D2;
	Sun, 17 Mar 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710653; cv=none; b=eWYfYtgyNOvyvQtzqStyXldgLtkudgIVqxLpARZUwqCDm66XkL+Pm400OZL7DwFBVrPmHG7r5MGGva3MzB5YmrbUkex6cg6g2u6B1L2PaXc4LKQjfhlixpWe+sfloml5aR8zECH9/oOKOfjwq85GUgF3+qmDQ9JuIeEDrzQIymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710653; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4XEjr1DevnNT0tFrxZ/aEmwk7/vzTkMfs6n3OkXNzn/LEHZANhVu/EmTeANJcB0pfgpCPnw4CWKmi5z5Oa0xIGR71V7mXC8AsrLU8UIMFIQEItfWfes7A2rrb4EMpcemqeT0IKrTE9vbFnk3zj3ri3XdXs4vcv3KkvelyL7Z/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D359368BEB; Sun, 17 Mar 2024 22:24:08 +0100 (CET)
Date: Sun, 17 Mar 2024 22:24:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 07/19] erofs: prevent direct access of
 bd_inode
Message-ID: <20240317212408.GG8963@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-8-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-8-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

