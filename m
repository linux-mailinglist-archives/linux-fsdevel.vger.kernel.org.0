Return-Path: <linux-fsdevel+bounces-37257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBAC9F0273
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 02:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7F6285936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7652B2B2CF;
	Fri, 13 Dec 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PtvaXFQ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779C27715
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734054844; cv=none; b=nRjAq6GZQPNZzxW/Q/z1cYDYXwpI5JpdfVevidKaEwu+k51awXV20GlFsgxfWJZU8B5ZOUgHfF0upYA3ZjodBJ7FepzFlmOH/+aKzfoyrXPnfXRc4QjTd1tYe6/f3gqjMNE1MmAy976icwslBBovSuo5i+R2yX07y1MNzALGnPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734054844; c=relaxed/simple;
	bh=ACww25Ban/Nr+dnleAbfJXLQ3TjGhZVSPT/0PJm39Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLb/h0lNSBieHiB+XEU6ETy4NQZOAIdRjsLK4c3LmyCPoNk2X5angvrz6EY38FFYfGj0ruNdI/wv19Xe/aKiT1Ll/eDTy1VNBYH39rx7gZRSeNyFpzY9DZHn3RYWXez8eS4IzE6nrEmRaw2Mb/0YVE8NnlDyXf3Fb6Z6onYmFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PtvaXFQ7; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734054840; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=j9UEF9jtgn2GfbHtr5FUZp+PnSjy+pZnHMzCj3315fM=;
	b=PtvaXFQ71VHxmNPJx8zxxQEMuAEpysg9Bozx8Hn8kNPfiHH3rKHW29HZSuClm5uSawLVPIokERj3Xtfasv/0Rr1uV8ImAeyyhGSndXlUjJ36LsfuLVJU0g4HQOEeGMnUK+ao2CmH4yWPPqE+QoU71ai0YmwOjDaAeFMIg5W6KcQ=
Received: from 30.221.145.11(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WLNFCbi_1734054839 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 09:53:59 +0800
Message-ID: <4e94f0db-2f96-4f38-9d48-b4d2389bef2f@linux.alibaba.com>
Date: Fri, 13 Dec 2024 09:53:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20241212-fuse_name_max-limit-6-13-v1-0-92be52f01eca@ddn.com>
 <20241212-fuse_name_max-limit-6-13-v1-2-92be52f01eca@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241212-fuse_name_max-limit-6-13-v1-2-92be52f01eca@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 5:50 AM, Bernd Schubert wrote:
> Our file system has a translation capability for S3-to-posix.
> The current value of 1kiB is enough to cover S3 keys, but
> does not allow encoding of escape characters. The limit is
> increased by factor 3 to allow worst case encoding with %xx.
> 
> Testing large file names was hard with libfuse/example file systems,
> so I created a new memfs that does not have a 255 file name length
> limitation.
> https://github.com/libfuse/libfuse/pull/1077
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/fuse_i.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f286003251564d1235f4d2ca8654d661b..91b4cdd60fd4fe4ca5c3b8f2c9e5999c69d40690 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -39,7 +39,7 @@
>  #define FUSE_NOWRITE INT_MIN
>  
>  /** It could be as large as PATH_MAX, but would that have any uses? */
> -#define FUSE_NAME_MAX 1024
> +#define FUSE_NAME_MAX (3 * 1024)


So why not increase it directly to PATH_MAX, as indicated by the comment?

-- 
Thanks,
Jingbo

