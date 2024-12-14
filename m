Return-Path: <linux-fsdevel+bounces-37400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931659F1C09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10079188EB99
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10614293;
	Sat, 14 Dec 2024 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NArTOkHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990863209
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734142051; cv=none; b=d8LO/lO6w4qvWK1zfOf3EOUzREDiUt/bQQyE67kOO3RuM2H5aNL2nBdMdq7NGo6Y44paYWsf2yib/WCgbE+jTwapOdAsX/S1GRyw9OSI2AFZ/8xZizgcSP/rl8M7n7JoAKlNJA47JOtHc24Z9TkZEyjngn3II7oHUM6x/AKgTx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734142051; c=relaxed/simple;
	bh=MnUH9daorTcFLLkntec+212S6Xg/Htcc/TpVQn4dWtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPjUbJyeQTH0kC9kjgxJfdo+IbtyrVZw8v9VFPsPyMYzD2RjpiiPbPct1UvIMw7yH5AfnkUIDM3Y8mqZS5yzhBV8dlJ2qymCsg0ap7dyZ9gXpWVRbJFytMv5AiVVdTiOyUwi8KrlaamQ8goPLgFXKa6pYonbDE5jdI3GDl71zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NArTOkHC; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734142040; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tQ1bGhN8TNxEsq+2rPJzQcOy6ttc5jb4bQ51eyXwtxY=;
	b=NArTOkHCr6lVc8zhz2uTBhyCyrjsGB4GDkb7lVZHpBBR5pRV+/LaPunSuNSUnoaR0MhwV8edYfTCgfVXl7D2PDnkPrzgyvWo0Aov7j5VS3Vt353ka97JftwcQGOkL3JxBpne0N7pMGt1QI3Rzd/dKBFRCf6RgTWPWTmRDFdqcIs=
Received: from 30.221.144.74(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WLQGK7U_1734142039 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 14 Dec 2024 10:07:19 +0800
Message-ID: <60105613-b0d3-4345-b4c6-aef7f3b90e71@linux.alibaba.com>
Date: Sat, 14 Dec 2024 10:07:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: Increase FUSE_NAME_MAX to PATH_MAX
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Shachar Sharon <synarete@gmail.com>
References: <20241213-fuse_name_max-limit-6-13-v2-0-39fec5253632@ddn.com>
 <20241213-fuse_name_max-limit-6-13-v2-2-39fec5253632@ddn.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241213-fuse_name_max-limit-6-13-v2-2-39fec5253632@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/14/24 12:01 AM, Bernd Schubert wrote:
> Our file system has a translation capability for S3-to-posix.
> The current value of 1kiB is enough to cover S3 keys, but
> does not allow encoding of %xx escape characters.
> The limit is increased to (PATH_MAX - 1), as we need
> 3 x 1024 and that is close to PATH_MAX (4kB) already.
> -1 is used as the terminating null is not included in the
> length calculation.
> 
> Testing large file names was hard with libfuse/example file systems,
> so I created a new memfs that does not have a 255 file name length
> limitation.
> https://github.com/libfuse/libfuse/pull/1077
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

LGTM.

Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>


> ---
>  fs/fuse/fuse_i.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 74744c6f286003251564d1235f4d2ca8654d661b..a47a0ba3ccad7d9cbf105fcae728712d5721850c 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -38,8 +38,8 @@
>  /** Bias for fi->writectr, meaning new writepages must not be sent */
>  #define FUSE_NOWRITE INT_MIN
>  
> -/** It could be as large as PATH_MAX, but would that have any uses? */
> -#define FUSE_NAME_MAX 1024
> +/** Maximum length of a filename, not including terminating null */
> +#define FUSE_NAME_MAX (PATH_MAX - 1)
>  
>  /** Number of dentries for each connection in the control filesystem */
>  #define FUSE_CTL_NUM_DENTRIES 5
> 

-- 
Thanks,
Jingbo

