Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3B075BEF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 08:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGUGfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 02:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjGUGfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:35:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D03C1BC1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 23:35:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-263036d4bc3so972254a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jul 2023 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689921324; x=1690526124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADIyloD166jYHv11b4YS8m6+UmHnQ0p38Q1r2ipFvFM=;
        b=INyinzdHITe+HkonRw4Nm1dMuNcIC0Xu1HE8dhJ6BGF0ueR2YbEcxtuY+TxDGv81/9
         jbMmbGI7PxVsl/CxTeOXxbIz4f3jENUlN2SL6kXYsFv66YKbGD9FwePmu0ittS0Ge9KU
         RcbuwyRMm6iqyo0Y0CPWjEsikGhoktj9YwwspMy9U8rowMVBA1e7FP7Tx5gNUnUTTArI
         0C/vfG6x9gYtfsFtivqy0HMflrgjgq3ODixXvN82LcmRmsrbDat8a8XcJVk6+a/0nwlB
         uS6JsqbwtYMGdRG8D/JOOH6ZNfshwSbzoOI3EkHj0tbNQNKlLWxtgPMTX4DzlqGRnWnr
         jnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689921324; x=1690526124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADIyloD166jYHv11b4YS8m6+UmHnQ0p38Q1r2ipFvFM=;
        b=PW4iCivOrCZRkja3pBnjEk6ALUeAGbvm4T0HfkYwBk6B5nDLJ64fZ9OsSv76pbQuea
         KAtO3fifSa4HFrPfc+M8RKI9nQZCElpVWEj1nZLZcoPWbmtCXXCVnevmhMgkBjhwF2jS
         vl6qejH41L8GUMZtSK4c4IRk0UPSbmEHMbh8IbDQOy+wdk4aBZKImQGIb91K2SE06djg
         NfTvijObdpDMNXdKVfyLgPSDb0/oF3sYvc2KPcua5Za4pX2rGlfBJo4Ng5IGS74SURM1
         8qkXNsvU0Vo+47dLk2G6MI71XhzNW9Oswq22rtLu4J+rAuVDO9MOJwfbjdnukbP2jU4M
         lYqA==
X-Gm-Message-State: ABy/qLadZmA8nXKkt1pxyU5plpwMdVnwMvLJWp5g5Aqnby3JpNq09R36
        UgyTvL8Tvy635cP890n/ipAXmQ==
X-Google-Smtp-Source: APBJJlFN0J1oceIbBTEsvqQ3cueDwfrRySx5mrjN8Zu66Mtywn9rvbdXCh0v8ttoW8uG/Tc+p/NS8A==
X-Received: by 2002:a17:90b:4d90:b0:267:85ae:2367 with SMTP id oj16-20020a17090b4d9000b0026785ae2367mr809483pjb.12.1689921323932;
        Thu, 20 Jul 2023 23:35:23 -0700 (PDT)
Received: from ?IPV6:fdbd:ff1:ce00:3a:146c:67b8:50e9:7617? ([2001:218:2001:0:1000:0:1:2])
        by smtp.gmail.com with ESMTPSA id w24-20020a17090aea1800b00263418c81c5sm1886568pjy.46.2023.07.20.23.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 23:35:23 -0700 (PDT)
Message-ID: <e5266e11-b58b-c8ca-a3c8-0b2c07b3a1b2@bytedance.com>
Date:   Fri, 21 Jul 2023 14:35:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [External] [fuse-devel] [PATCH 3/3] fuse: write back dirty pages
 before direct write in direct_io_relax mode
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net,
        miklos@szeredi.hu
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <20230630094602.230573-4-hao.xu@linux.dev>
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230630094602.230573-4-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2023/6/30 17:46, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> In direct_io_relax mode, there can be shared mmaped files and thus dirty
> pages in its page cache. Therefore those dirty pages should be written
> back to backend before direct write to avoid data loss.
> 
> Signed-off-by: Hao Xu <howeyxu@tencent.com>
> ---
>   fs/fuse/file.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 176f719f8fc8..7c9167c62bf6 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>   	if (!ia)
>   		return -ENOMEM;
>   
> +	if (fopen_direct_write && fc->direct_io_relax) {
> +		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
> +		if (res) {
> +			fuse_io_free(ia);
> +			return res;
> +		}
> +	}
>   	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
>   		if (!write)
>   			inode_lock(inode);

Tested-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>


Looks good to me.

By the way, the behaviour would be a first FUSE_WRITE flushing the page 
cache, followed by a second FUSE_WRITE doing the direct IO. In the 
future, further optimization could be first write into the page cache 
and then flush the dirty page to the FUSE daemon.


Thanks,
Jiachen
