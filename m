Return-Path: <linux-fsdevel+bounces-24975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C3B947647
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C15A1C214B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA29149E0B;
	Mon,  5 Aug 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vAjB58Zi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24233CA
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722843500; cv=none; b=nF0tOjT01lvoyE0NtUonmJ/VxZVOol1WWJ3rhNj9y0ly9JrqKzBY3Ke1bW3lx1LrMtWFSgVtfBSmCPIq+nzpuAFvvbmgU8MuDfjapn4XSw38TYeBrCwY1erPdFcKIMQ09J5bs9/gVlbMACZFbWxLHjdG3wah0cGkrGQ5i+S8fMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722843500; c=relaxed/simple;
	bh=QsL5FAhVeUeTAhdGuNS6TbvlO8O8h6KpZsHWmf3cb1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaoRqJxSxKfkjGXDuDTQvdlFyiCZ2jgYvMtWhTDtesGX+CyuLIUv34wshjkdO00QuuGbffsMl1QYMhEBJFTg8T9UmyytPGY4TjfaUns8RJbpifNvfTC3ootKELhhYvZAmP0gqlw7CsQXfESyKNtH+6h/bUQJbrx1lLLrO9NsQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vAjB58Zi; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722843489; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cmJ1wCBNIj1V3iMZ+M9U59VoWh7+PgX2luaiD0o/OKk=;
	b=vAjB58ZieuX8rKYjyh/Ey3cA+GU1YoDJvYgEqGv+Ds8nIMvn19fPnRBl+fNBdZkgVyqpNKieLqzNcCOrkFbssKM5sX7snzg41+JsRHWaougFYwY0sCJJxDBcRnYD8XTQE6ZoFgT8dRitUbkoNwxCRTxiUt87IN5godx3zzFSC7k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WC64.R4_1722843488;
Received: from 30.221.145.203(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WC64.R4_1722843488)
          by smtp.aliyun-inc.com;
          Mon, 05 Aug 2024 15:38:08 +0800
Message-ID: <755d1d59-09e8-40f0-a802-607d3404d853@linux.alibaba.com>
Date: Mon, 5 Aug 2024 15:38:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-3-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240730002348.3431931-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 8:23 AM, Joanne Koong wrote:
> Introduce two new sysctls, "default_request_timeout" and
> "max_request_timeout". These control timeouts on replies by the
> server to kernel-issued fuse requests.
> 
> "default_request_timeout" sets a timeout if no timeout is specified by
> the fuse server on mount. 0 (default) indicates no timeout should be enforced.
> 
> "max_request_timeout" sets a maximum timeout for fuse requests. If the
> fuse server attempts to set a timeout greater than max_request_timeout,
> the system will default to max_request_timeout. Similarly, if the max
> default timeout is greater than the max request timeout, the system will
> default to the max request timeout. 0 (default) indicates no timeout should
> be enforced.
> 
> $ sysctl -a | grep fuse
> fs.fuse.default_request_timeout = 0
> fs.fuse.max_request_timeout = 0
> 
> $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> 
> $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 0xFFFFFFFF
> 
> $ sysctl -a | grep fuse
> fs.fuse.default_request_timeout = 4294967295
> fs.fuse.max_request_timeout = 0
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Why do we introduce a new sysfs knob for fuse instead of putting it
under fusectl?  Though we also encounter some issues with fusectl since
fusectl doesn't work well in container scenarios as it doesn't support
FS_USERNS_MOUNT.


-- 
Thanks,
Jingbo

