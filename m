Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7C76DF78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 06:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjHCEpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 00:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHCEpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 00:45:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F5E2102
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 21:45:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc34b32785so4045205ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Aug 2023 21:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691037940; x=1691642740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OW0P9FbDz0jEUlrcjINl0iKku3iiNF5P+iKjIDvOz8=;
        b=ADJ+vfsHCojkPlo9ghBd3e2j79VQH5938lnT8BPSakzG8kvD8oW4DKosnKnsEJbJTC
         PZqdaunc0/n8q/4Ss4WwPr8rNrf8GHP0FwPA4Qf/XiFcF0ehrHblXD2O7dj/pI77LgQk
         /on81oA6vB1sVxKnnTtm4MI6BP9vKFF6j9Axff54MzseNdLJ7lkgZ3xYFSLb6NJLa95n
         N62ZpBSHMhZnR5f6XQnZlLtPkFWCtMgUJUxkeDTUzZip4Y35JnWzgjUqWgZgYiQZhMIX
         K00h1+DonariIV82oziBxYlnpohPt3cT1Z9rEygF4Ew2s640BvAynondir8pol5RyliS
         wDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691037940; x=1691642740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2OW0P9FbDz0jEUlrcjINl0iKku3iiNF5P+iKjIDvOz8=;
        b=UWILrDhF58MU5QZPehlQxmKLA+AfOgtozv80Ey9/yblkr5O8bEEhQPXOiCUQ1tnqj4
         nearTIWkjkIEwjrQQzNl+5ishZ2xsJ754AhkmZBtHoisS0avigsI6wNmnHOQthj2daEK
         KDWNl1IJRYIFFIdz/Ae4cAMxByjQ1Fn4y7PP98fmLBMAl7DgClMKuZAxAxnTzqykV5jq
         zUo7uaemUvO+tEyPCfiVp4gSUw94RdO10pyiSDELWndEmYQG7XlEnYz+9KPBy65MU9Xp
         kF6t65e9owDw2NQo0Xv7/eroTSQeXnhDymIc6HNSj9uVTQ7y4XKXJfOoMuNTaxB+sZwe
         80tA==
X-Gm-Message-State: ABy/qLZmXWm/FmA6klQmXiGvvP5ind2oC9/hJN76pddGnPELHjZ9NZcE
        pyXHjyf7MSah4wMwS6O27u2/FA==
X-Google-Smtp-Source: APBJJlHPygn+X6jDwzmrzt6ZO0JcBeTMqOj3nxPVktoQoX+9TCQ11QIROnUHfaf+U7ar3DlBslLa/w==
X-Received: by 2002:a17:902:eccf:b0:1b8:6b17:9093 with SMTP id a15-20020a170902eccf00b001b86b179093mr19729248plh.1.1691037939975;
        Wed, 02 Aug 2023 21:45:39 -0700 (PDT)
Received: from [10.255.204.88] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id z18-20020a170903019200b001bba7aab838sm13244306plg.162.2023.08.02.21.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 21:45:39 -0700 (PDT)
Message-ID: <9442a542-957a-5b88-9a50-a55c9a7115ee@bytedance.com>
Date:   Thu, 3 Aug 2023 12:45:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] fuse: invalidate page cache pages before direct write
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net,
        miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
References: <20230801080647.357381-1-hao.xu@linux.dev>
 <20230801080647.357381-2-hao.xu@linux.dev>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230801080647.357381-2-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/8/1 16:06, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> In FOPEN_DIRECT_IO, page cache may still be there for a file since
> private mmap is allowed. Direct write should respect that and invalidate
> the corresponding pages so that page cache readers don't get stale data.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
>   fs/fuse/file.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bc4115288eec..3d320fc99859 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1465,7 +1465,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   	int write = flags & FUSE_DIO_WRITE;
>   	int cuse = flags & FUSE_DIO_CUSE;
>   	struct file *file = io->iocb->ki_filp;
> -	struct inode *inode = file->f_mapping->host;
> +	struct address_space *mapping = file->f_mapping;
> +	struct inode *inode = mapping->host;
>   	struct fuse_file *ff = file->private_data;
>   	struct fuse_conn *fc = ff->fm->fc;
>   	size_t nmax = write ? fc->max_write : fc->max_read;
> @@ -1477,6 +1478,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   	int err = 0;
>   	struct fuse_io_args *ia;
>   	unsigned int max_pages;
> +	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
>   
>   	max_pages = iov_iter_npages(iter, fc->max_pages);
>   	ia = fuse_io_alloc(io, max_pages);
> @@ -1491,6 +1493,14 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   			inode_unlock(inode);
>   	}
>   
> +	if (fopen_direct_io && write) {
> +		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
> +		if (res) {
> +			fuse_io_free(ia);
> +			return res;
> +		}
> +	}
> +
>   	io->should_dirty = !write && user_backed_iter(iter);
>   	while (count) {
>   		ssize_t nres;

Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>

Thanks,
Jiachen
