Return-Path: <linux-fsdevel+bounces-33722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F263D9BE116
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0BF1F23ADE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BAF1D9323;
	Wed,  6 Nov 2024 08:35:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C061D5CC7;
	Wed,  6 Nov 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882128; cv=none; b=K35RMW6KhcSkTv/IgXjAZd06s+tEBqWzz0jMJShKyCsrEe+vG6W+IHh0nuP0dY1vG+2sJGiomKGeulyprku8Xu9XvFQ31OJAM5XVl4MnorGQp5ks4PVAE5cLPFNvj8vzoABNpeTFuyPXtHK/XtxuwtpECm/5zT5KQkeyV8M+41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882128; c=relaxed/simple;
	bh=C/velvt7rmPUsQmHDYuEhOqbZlT3Y7yVo6RK2nuGCVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDrmgdJbz9MbmkFpbu7FMK1u15AVVseJsW75iXV4feSpyjq+aJh+gBmCM3Svu1oCrndVou+n0QaAps5Kzuk8J6ySusUDdkD9vVGl1sqZ0F4wZqTvyNFtZezNpCSz3d0/R9B/Rhvm65qayyMGFUZVovP8fUqEDW37f4+GRYSVwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 42F8948D33;
	Wed,  6 Nov 2024 09:26:48 +0100 (CET)
Message-ID: <7e364258-e643-4656-9233-f89f1c4b1a66@proxmox.com>
Date: Wed, 6 Nov 2024 09:26:46 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.11.y] netfs: reset subreq->iov_iter before
 netfs_clear_unread() tail clean
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dhowells@redhat.com, jlayton@kernel.org, stable@vger.kernel.org,
 netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241027114315.730407-1-c.ebner@proxmox.com>
 <2024110644-audible-canine-30ca@gregkh>
Content-Language: en-US, de-DE
From: Christian Ebner <c.ebner@proxmox.com>
In-Reply-To: <2024110644-audible-canine-30ca@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 06:59, Greg KH wrote:
> We would much rather take the original series of commits, what exactly
> are they here?
> 
> thanks,
> 
> greg k-h

Hello Greg,
thank you for your reply.

AFAIK the relevant patches for this series are commits 
80887f31..ee4cdf7b, although the last patch containing the fix does not 
apply cleanly on the current 6.11.y branch.

Please note, I am not very familiar with the code so unsure if all of 
the patches in the series are required for the fix. Maybe David Howells 
as author of the series can provide some more insights?

The patch series introducing the fix is 
https://lore.kernel.org/all/20240814203850.2240469-1-dhowells@redhat.com/

Please let me know how to proceed, thanks!

Best regards,
Christian Ebner



