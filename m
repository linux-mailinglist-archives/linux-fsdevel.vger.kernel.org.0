Return-Path: <linux-fsdevel+bounces-34568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5389A9C6567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B342865AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6487721CF87;
	Tue, 12 Nov 2024 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RV/tz1ZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F21821A4DB
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455178; cv=none; b=Zo82Lt00VRhVZpXr/735BoAMCwXBLD9ecqNJN6q4N/XBgsBOQ57v9R8yzEw9RoA4gWxQ+u74JEjLJ1dC3mfyaRo8TY2oKaZ7Pk/0aLywt6bN77zQuwx7qa4jsSTlUqc077Mm5Z3HhDx2NFJD/qe14iBOjC7gsvJ9oGeW6bEYd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455178; c=relaxed/simple;
	bh=OneZWeNpLZEIYZqbkMJA60wrFG0mAr6NHXYZQu3u+9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDeyepXqxqm2AGKForLPizbewwtJq+U/+F5rO4c7rvcFIfiEumwD+eAnQnBkDHYSkgkLgGQ2b8LJ10kLkn+PB/NQTxMwbpUdwWHQjXUUxX/1/oqZWC7LTRqQXbxaD7Is5gdRke76fUfE8GMdJgYksomMDWsgU4MwK7xVLS2tYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RV/tz1ZS; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <313c9cbb-627e-4256-950a-dd549331e73a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731455173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vI1FN8i967Dezy2W3/6r/8dCS+KMtibRtu+Q8af05Gw=;
	b=RV/tz1ZSAt8eEVFnVPzHD2+ATXrB4uhqe1ds/qM1MycB/qgmbghOSk7ESjr24wJXHOQr4q
	hMVOiCvL8w0ZBZZtLN849kDBuL/if/Ij36sMv3HIl6N9g8H/jbT5NbeDgK/rb/BNtFhghv
	0rRZ/gstlMHDIktvIi9kXzX+SQgvaRA=
Date: Tue, 12 Nov 2024 15:46:04 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 0/4] Make inode storage available to tracing
 prog
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
 amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
 josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
References: <20241112083700.356299-1-song@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241112083700.356299-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/12/24 12:36 AM, Song Liu wrote:
> bpf inode local storage can be useful beyond LSM programs. For example,
> bcc/libbpf-tools file* can use inode local storage to simplify the logic.
> This set makes inode local storage available to tracing program.

Overall looks good. Left some comments in the patches. All bpf sk/task/cgroup 
local storage has already done this move, great to see the last bpf inode 
storage that gets done and makes available to non bpf lsm prog.

