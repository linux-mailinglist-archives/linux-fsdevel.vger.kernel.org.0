Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF787A2FB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjIPLao (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 07:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjIPLa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:30:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250EFCC0;
        Sat, 16 Sep 2023 04:30:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 554C1320091C;
        Sat, 16 Sep 2023 07:30:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 16 Sep 2023 07:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694863822; x=1694950222; bh=mprAwCT7s3jxXm1o3B8GItufVCyeNrzoBOD
        W4N/kqkI=; b=QtY9vbdpeNeKnWXKfyHl9kwXv8TmizTpgubcSxc+txjcxl50zAX
        CJCGWd02WBO645q0VJ1aB9ZD3lco8WZ/0vVvXoDMo3wUpap9dbnUpMhjw1Zowg70
        YBDYMoYroZxoT/k0wu8FsKwCpmmqj7Koyd21Hzy4X5+yiuyYk/C9awvNngbv0hbU
        NvAg1UB3tE6Dl9mErhmYbUeBqLckQKXrm/5Z5iUusp/zXWngWZ+fVgJCCSjqPPOP
        oLOqZcETPDzTkBxc8qd93bVSCHutIXltnlajNKY6dtJuRRKH6bTjuKTU+/lwcmiC
        IQlFDO0I+TYEYpDn/gp0MsTJgAKERACByBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1694863822; x=
        1694950222; bh=mprAwCT7s3jxXm1o3B8GItufVCyeNrzoBODW4N/kqkI=; b=S
        Hmx3mPywf7rUIbjPvz7kxzABbYmTVNWk/EDu1PNyNrm2uqOxYgJy/nQeibYby9Ms
        l5W/hpjMETuIzff1xLv8fHgfmunx44IbRZ++r7NtKVsoa7ee7f6CkP0jXsmCoP78
        Pjn7E8upd3HFkd9XkLHLobWru2eZq+LeSHtECH3heRDNzn7LysysO5WZBxSIpEqa
        a+MGvWsZHDFGEAWP/SgnmmW+j8tI7pTWiugA8BWbNJ65mR4OxMGP2qabyF35TYF8
        bS+CEBvX1CqCEL4Mz8826ELBvnwqLjub8hRPEqWb9wevjTm84CA5FTJJzs4muYWE
        RNRlLNQcDcIpGlpG8z3YA==
X-ME-Sender: <xms:zpEFZW55B_ddH_po5wYZ12JveCsjy5MeU8KxR73IK2lg_e1mwT-f_w>
    <xme:zpEFZf6jpYKSb0jStULOFysnRnLcl01dZNBU3A66Gk7xYhn2S8XLXhPSvke2Yrn88
    zJSYY3II4ZIyqGQ>
X-ME-Received: <xmr:zpEFZVdfZdsQ9PSNvERo7fFQRlsdZELhGB9ilHHUQ2HCKgoDGSgpb1L8Jby7A6oa0zfZspKyjF-Hb4DqlvS9wQFjhbXu_r5II43Id0LEDRZvoS0xjyEK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefgteelleeggeeuueduteefiedu
    vedvueefieejledvjeeuhfefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:zpEFZTIu6RgVXj6qVTu1eCDuX5MGpGgZP-JCegUBD29jrLLNPLQKvg>
    <xmx:zpEFZaJbJUkyptk1T16qhuU9frikMpSNMqI71NRZgmvo98knl0ikYA>
    <xmx:zpEFZUwseitTa4oDo_c7fx33GMBvub9EWyXu2ZQdrS6js1coxjzVbw>
    <xmx:zpEFZRV77zr8bcTFlB_Jc4x_2lbZNDACJA4luef_wdhBycx7XjRxHA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Sep 2023 07:30:21 -0400 (EDT)
Message-ID: <8d72c789-5db3-dd01-1e20-71fff4046c83@fastmail.fm>
Date:   Sat, 16 Sep 2023 13:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] fuse: remove usage of FR_WATING flag
Content-Language: en-US, de-DE
To:     Kemeng Shi <shikemeng@huaweicloud.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230913092246.22747-1-shikemeng@huaweicloud.com>
 <20230913092246.22747-3-shikemeng@huaweicloud.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230913092246.22747-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/13/23 11:22, Kemeng Shi wrote:
> Each allocated request from fuse_request_alloc counts to num_waiting
> before request is freed.
> Simply drop num_waiting without FR_WAITING flag check in fuse_put_request
> to remove unneeded usage of FR_WAITING flag.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   fs/fuse/dev.c    | 9 +--------
>   fs/fuse/fuse_i.h | 2 --
>   2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 59e1357d4880..4f49b1946635 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -139,7 +139,6 @@ static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
>   	req->in.h.gid = from_kgid(fc->user_ns, current_fsgid());
>   	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
>   
> -	__set_bit(FR_WAITING, &req->flags);
>   	if (for_background)
>   		__set_bit(FR_BACKGROUND, &req->flags);
>   
> @@ -171,11 +170,7 @@ static void fuse_put_request(struct fuse_req *req)
>   			spin_unlock(&fc->bg_lock);
>   		}
>   
> -		if (test_bit(FR_WAITING, &req->flags)) {
> -			__clear_bit(FR_WAITING, &req->flags);
> -			fuse_drop_waiting(fc);
> -		}
> -
> +		fuse_drop_waiting(fc);
>   		fuse_request_free(req);
>   	}
>   }
> @@ -495,7 +490,6 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
>   		if (!args->nocreds)
>   			fuse_force_creds(req);
>   
> -		__set_bit(FR_WAITING, &req->flags);
>   		__set_bit(FR_FORCE, &req->flags);
>   	} else {
>   		WARN_ON(args->nocreds);
> @@ -556,7 +550,6 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
>   		if (!req)
>   			return -ENOMEM;
>   		atomic_inc(&fc->num_waiting);
> -		__set_bit(FR_WAITING, &req->flags);
>   		__set_bit(FR_BACKGROUND, &req->flags);
>   	} else {
>   		WARN_ON(args->nocreds);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index bf0b85d0b95c..a78764cef313 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -312,7 +312,6 @@ struct fuse_io_priv {
>    * FR_ISREPLY:		set if the request has reply
>    * FR_FORCE:		force sending of the request even if interrupted
>    * FR_BACKGROUND:	request is sent in the background
> - * FR_WAITING:		request is counted as "waiting"
>    * FR_ABORTED:		the request was aborted
>    * FR_INTERRUPTED:	the request has been interrupted
>    * FR_LOCKED:		data is being copied to/from the request
> @@ -326,7 +325,6 @@ enum fuse_req_flag {
>   	FR_ISREPLY,
>   	FR_FORCE,
>   	FR_BACKGROUND,
> -	FR_WAITING,
>   	FR_ABORTED,
>   	FR_INTERRUPTED,
>   	FR_LOCKED,

Thanks, looks good to me.
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
