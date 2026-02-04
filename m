Return-Path: <linux-fsdevel+bounces-76356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vMtKBvjTg2kHuwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 00:19:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B2AED332
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 00:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21D5D30120FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 23:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD52E92D2;
	Wed,  4 Feb 2026 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JSLihIIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2942AA9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 23:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247156; cv=none; b=fKOoF3kR0azuvT5nUPbUV5guz7IgMIYnWPccHJn3Z4Sos4ZBxN2cMLYLnRfl4bQTUjC7PZ7fhtYGTYP2aKNmxu799kHHwbjpeyw3JoGSf/g6GFY+hsRXJ5WBFF4BzGxFli3xiKCR4IDDj0NGtwvO3CVYqXPLQJ1mR5tiOdtwLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247156; c=relaxed/simple;
	bh=FHmcpmGcua4k5YBJ6GkkzqL/yk49jXpsX2YTQlULwz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS75OnfpOhemK/tqlFg0pikR8m3ecjQHTRD7Bx3FS1Nvr3U9lIn+oV5mqc9bIjMg3Hunjh/cfR7RX4fJnDCxmH7vsdsV+GMcyHgjNvIR7VTuCBPCuuXrk2kiEdo++r00XVvIciZvNXqUA3GAQqS+wSBn7FK32Uhe8TaE3IrP30M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JSLihIIO; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770247147; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9FRvlb8bm4I4hY02iJ1Rh8ALFxI5lF5ytupAwDrS7MQ=;
	b=JSLihIIOewhiRpRsmkR/gCLhuJHJZtoPgvKWFYN7Iz7GMZo/vzkunN/3/9MPmGPvrcnHKWErRnqnWNq7/tiODTFmF4rxAGmwCO6ZopJohBMizgry2izT6lPyEogU5AAwAlLHs1RhLvGMaB+2XYrG16eUSNm1nS2q7qhLi2Ib6mU=
Received: from 30.251.11.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyYhV5K_1770247146 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Feb 2026 07:19:06 +0800
Message-ID: <a6a27215-b9c1-4d8c-9b92-32e93922a67e@linux.alibaba.com>
Date: Thu, 5 Feb 2026 07:19:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: f-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260204190649.GB7693@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76356-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 75B2AED332
X-Rspamd-Action: no action



On 2026/2/5 03:06, Darrick J. Wong wrote:
> On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:

...

>>
>>   - BPF scripts
> 
> Is this an extension of the fuse-bpf filtering discussion that happened
> in 2023?  (I wondered why you wouldn't just do bpf hooks in the vfs
> itself, but maybe hch already NAKed that?)

For this part: as far as I can tell, no one NAKed vfs BPF hooks,
and I had the similar idea two years ago:
https://lore.kernel.org/r/CAOQ4uxjCebxGxkguAh9s4_Vg7QHM=oBoV0LUPZpb+0pcm3z1bw@mail.gmail.com

We have some fanotify BPF hook ideas, e.g. to make lazy pulling
more efficient with applied BPF filters, and I've asked BPF
experts to look into that but no deadline on this too.

Thanks,
Gao Xiang

