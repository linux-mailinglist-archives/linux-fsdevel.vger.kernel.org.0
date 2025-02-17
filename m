Return-Path: <linux-fsdevel+bounces-41838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D015A38074
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFA21885C36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA3217668;
	Mon, 17 Feb 2025 10:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a273VhG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C302216E1B;
	Mon, 17 Feb 2025 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788906; cv=none; b=dxE8SRv93IPq080UXeI6a+5Z9fLKbdQul2aTkDmTW06nPNOfH4dLqUnaxKzmpDBTIngTy0myirLGlcs9lfY9fgi2Kk0VO9JQwmmpOrFWiVtT0Ksyv/XrMYAX4B3h5Ax858RKdZVAhaoup1mjqlJ5I9gHbY15aIpM6RIFLkF+1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788906; c=relaxed/simple;
	bh=v2GXHADwm8jyrelNLsN3du0ue6JxDoMDZDX77gfKsDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwMEug7VIUKjljOh//tXvVwi86ZnvTQHjj9nMGsK0/3BfCXhVpx5BEm7oA2pumRu5bL+U8PNNjhxxvGM2jSyDI0aeNW2iIBZixCZo7n2xeLRWfxeVnJrVPvWZ/ROOzEwcaXenrbjcBQuG+8yaDJqH/ak333ZonkGPmQHTVFk+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a273VhG8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739788894; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XWTpZGqQz/jMkvs/NObnrKteVXldw/miuF2M3tixfjY=;
	b=a273VhG85geHLABhrb27oPTRGXNc16KcalNGPvvD8xWIjye39ihZAfamw9z1g+7IEaN4uko1ptGUSSKfo8gv5rkUHJabiV7lOSnySJjxKN5Ybm1rgoULaaw88z9XMppEjUYdhoGaFGtedUZfYOa4UhlebyHaBp6FXdVhzddhIWI=
Received: from 30.74.130.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPdpnMQ_1739788893 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 18:41:33 +0800
Message-ID: <0290170c-39df-4609-8de1-55695d6ec0ad@linux.alibaba.com>
Date: Mon, 17 Feb 2025 18:41:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Rust in FS, Storage, MM
To: Andreas Hindborg <a.hindborg@kernel.org>,
 lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Yiyang Wu <toolmanp@tlmp.cc>, toolmanp@outlook.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <87ldu9uiyo.fsf@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87ldu9uiyo.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/14 14:41, Andreas Hindborg wrote:
> Hi All,
> 
> On behalf of the Linux kernel Rust subsystem team, I would like to suggest a
> general plenary session focused on Rust. Based on audience interest we would
> discuss:
> 
>   - Status of rust adoption in each subsystem - what did we achieve since last
>     LSF?
>   - Insights from the maintainers of subsystems that have merged Rust - how was
>     the experience?
>   - A reflection on process - does the current approach work or should we change
>     something?
>   - General Q&A

Last year Yiyang worked on an experimental Rust EROFS codebase and
ran into some policy issue (c+rust integration), although Rust
adaption is not the top priority stuff in our entire TODO list but
we'd like to see it could finally get into shape and landed as an
alternative part to replace some C code (maybe finally the whole
part) if anyone really would like to try to switch to the new one.

Hopefully some progress could be made this year (by Yiyang), but
unfortunately I have no more budget to travel this year, yet
that is basically the current status anyway.

Thanks,
Gao Xiang

> 
> Please note that unfortunately I will be the only representative from the Rust
> subsystem team on site this year.
> 
> Best regards,
> Andreas Hindborg
> 


