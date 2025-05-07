Return-Path: <linux-fsdevel+bounces-48355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E59AADD5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFD21BC15B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C08221DAA;
	Wed,  7 May 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdC+68Gn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08321B9F1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617384; cv=none; b=uGoMatF9Dk787TPBKRJcFwQ379eGLSBIJqGQgvVoegyqD8+s+d9Nt/5hwjW5DEelLxryJ7jovGkPKJ7X2FCzIC+cluXSnQIUJP7NxKBGfWsfAl+ukQjLWkXW70soY0rCewoTDDJfwBcDlfgsgpoYKW7yflnr0DDbE4cEWqa8FfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617384; c=relaxed/simple;
	bh=hd3YBt2U7rpyOamT0WSsBI9rtKQBxwZOpRZOvt/klVk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bf8bD3rLPxLYuYrWWgjKn7eCTmKFsXYT0gAG0VFQj5XdPLzPfx8Z+4sLMSlDOQDz+2lr+LVBnYk1s9oEVmu4qx4HvZXmaKPkaoD2++tQqb/7P02JKb+mFi/ch5JAVPOdZeMo60blswSxODvPhf5BR137FtCCRen7wFlzFvlduhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdC+68Gn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBAAC4CEE7;
	Wed,  7 May 2025 11:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746617384;
	bh=hd3YBt2U7rpyOamT0WSsBI9rtKQBxwZOpRZOvt/klVk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kdC+68GnJ8aaziIhuIT1CghT5fSFXxHTkSZi44ox5tqUJG2RPJTsf+TgQ7iRajQb+
	 pCbTcwUpxySP79enM8CxvxC+UgD80fkHGt9yYPG8TKttvCkEAPNyS9hJUBQWqz9Det
	 6ds/qSbe9bS/LR5rw8nVXGGPLMC1zzsuNgAsemnfctt9zjzOn+v+TbbxXm7RgaHlwU
	 RAqhm4xg/v7/isrgZak8i8COpuwTdZCniV4Inul76Um0ZNRrGxLQCmw+89PMerm6YS
	 71LiDQOow+/yIM9XU9IId62K6y986O1tTrEm826T/q7jh2FChoBxNUnoNkFGMatDgc
	 QyYADnx7XufPg==
Message-ID: <ebebfbfa-8322-4bdb-91a6-095bb7d7a9a4@kernel.org>
Date: Wed, 7 May 2025 19:29:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH 3/7] f2fs: Allow sbi to be NULL in f2fs_printk
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250420154647.1233033-1-sandeen@redhat.com>
 <20250420154647.1233033-4-sandeen@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250420154647.1233033-4-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/25 23:25, Eric Sandeen wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> At the parsing phase of the new mount api, sbi will not be
> available. So here allows sbi to be NULL in f2fs log helpers
> and use that in handle_mount_opt().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> [sandeen: forward port]
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

