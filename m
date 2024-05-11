Return-Path: <linux-fsdevel+bounces-19306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA4B8C2FC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 08:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DBB284CF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 06:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C74D135;
	Sat, 11 May 2024 06:09:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D2847A
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715407751; cv=none; b=DZy+ao7xdcuJ6+UHQO0AwsBsJRxC6W0sLYaZPXOPmmu8dUQI3orsGt1XfyIqznMWnqRVTF+UyRxP9kxAewLHwEI+RIpNpkqSXBuGEhf1ZkUtThTO16w9mAs9X6DSHwFmKGldyibaKpAocwgCPO6y7QPpQsyYL1omXw+rLb4yDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715407751; c=relaxed/simple;
	bh=qpP/tpVbUa3HMH2Nbcz9YiWYsrdMoTetL9wg2Xv+bRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d/Uff+fUUAmu5fwLvrTMzpvB5qT6hOGofHx8I6STDp8Ub8f4cS9u11Ee6BFg2UIpUq1CWhDHe8ynxlJBJSzdtkv5w4bCeVHHHFrN5AOHd0JtHVY/3SNwL8bNk9zWA/HayA7ysfqpv0p8xbYlkgq484vg+WuZta45WrziSxVTYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VbwGX20tgz1j19q;
	Sat, 11 May 2024 14:05:40 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 270F41A016C;
	Sat, 11 May 2024 14:08:59 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 11 May 2024 14:08:58 +0800
Message-ID: <0607f99b-e64f-4e95-8271-1b409e18bcf8@huawei.com>
Date: Sat, 11 May 2024 14:08:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] fsconfig: intercept for non-new mount API in
 advance for FSCONFIG_CMD_CREATE_EXCL
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
CC: <linux-fsdevel@vger.kernel.org>
References: <20240511040249.2141380-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240511040249.2141380-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)

sorry, please ignore this, and I will revise my code.

On 2024/5/11 12:02, Hongbo Li wrote:
> fsconfig with FSCONFIG_CMD_CREATE_EXCL command requires the new mount api,
> here we should return -EOPNOTSUPP in advance to avoid extra procedure.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>   fs/fsopen.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index 6593ae518115..880eea7a30fd 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -220,10 +220,6 @@ static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
>   	if (!mount_capable(fc))
>   		return -EPERM;
>   
> -	/* require the new mount api */
> -	if (exclusive && fc->ops == &legacy_fs_context_ops)
> -		return -EOPNOTSUPP;
> -
>   	fc->phase = FS_CONTEXT_CREATING;
>   	fc->exclusive = exclusive;
>   
> @@ -411,6 +407,7 @@ SYSCALL_DEFINE5(fsconfig,
>   		case FSCONFIG_SET_PATH:
>   		case FSCONFIG_SET_PATH_EMPTY:
>   		case FSCONFIG_SET_FD:
> +		case FSCONFIG_CMD_CREATE_EXEC:
FSCONFIG_CMD_CREATE_EXCL
>   			ret = -EOPNOTSUPP;
>   			goto out_f;
>   		}

