Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A832797ECD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 00:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjIGWvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 18:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIGWvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:51:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C681BCD;
        Thu,  7 Sep 2023 15:51:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 334365C0139;
        Thu,  7 Sep 2023 18:51:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 07 Sep 2023 18:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694127068; x=1694213468; bh=+4O/2mdeSY0Z2JTc1kBaOC6JIT8xilMarlD
        uWf9462s=; b=kUPLJZYeZvsBxVfPaqTlaMMuEBUZkEPYEa2lAd6fSF2xG00jtgm
        6ZV+Cu4xa7S6fwVHfNk4AbjWW31DstxwOAGZME6mJZrLd0+fCqWf80OKy08Q7TjA
        ONOfTbZUcedvMssqTvpcHXKTdUYa5l+fE2H7QjvafByyyVZ+knHxtxHm6SiSsMcT
        tmOcl2IrW/WD16imj8RyXzP+RKkx/HSNPnG3EylawveMS6NYixgBpnRPU9A3WfcK
        iF4KRj+Sb30OUHXzmFyvD+v+oI9wIeMgAZipqfwPK/Wfagb5xhNe6ibXWDNHQjzL
        RVkQdhRRPQlj99SlqYGZGMOl+VVscrH4oGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694127068; x=
        1694213468; bh=+4O/2mdeSY0Z2JTc1kBaOC6JIT8xilMarlDuWf9462s=; b=s
        xvBbsBrIu61DvxtbrvZp6zNifxVWnz4bvsInUYId/FPJVALnTkE4h6oomwJwPyEH
        7fszwDSC0K8gG1JuIfh9M0j4Wsa3zle+KFfWWDlvCE+3nBinC6XEvYU344xPlJww
        v+0bwbrHba2Y5WTLy25S0DZiaCWYre9e1pjDjVRZofr3a1RZLHcqv7VTC7bjdA6o
        nY7la/EnjlDyktExt9nn1IgmIerWKmxjnPwNr7W9cGlhLIxh5t91a/B0M4M0tjMV
        CsmEePiUyk7eZzIEJc/jfdirT7uhmWnKhVecLKDnorxJLB9HBohOSTxoADBa3KJQ
        p+hAtBvDDr17DFJZFygTg==
X-ME-Sender: <xms:21P6ZD_WG0_j8biWGI6Ia7xSwx4R8ZFkMHmJ8XEeLx_3pqwe7Edp7A>
    <xme:21P6ZPvuYB14I0wC-1k9BUiiSssWwV-0p5FmYF1XR7hhFiCGKBO6rn5HAuZWmxIte
    G8RhiOtwQNtv35i>
X-ME-Received: <xmr:21P6ZBCbv4nK1ZENfSkOv8c61k_5W8rfqC1xwh1nelG9viuYs8sfhPjTE9ct_SGmhhE6LkcEFBRevV-tWF5uWEzPZYiL7ciwr1sAJ1BT3_jAV3T1j5MI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefgteelleeggeeuueduteefiedu
    vedvueefieejledvjeeuhfefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:21P6ZPfRiOMCpTVqolNHP7DM2YBLWep7zgzsvUjTYX4ZPjZotM0OKw>
    <xmx:21P6ZIMU3cu9EtUQUK0IuBeB34Mbud1jpd583PEEGCfQtbEVqFJF9w>
    <xmx:21P6ZBkKOnFroKeMjQs362a74jTMznNVEzH6jnZ74JS0FZzCWOqAfg>
    <xmx:3FP6ZBYP96cqA5glJFjEFnB37LPKZsFr2bD-6TC7NBwZh-kml5fR2Q>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 18:51:06 -0400 (EDT)
Message-ID: <02da2f84-4463-0098-4ef9-e3d9622babe6@fastmail.fm>
Date:   Fri, 8 Sep 2023 00:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] fuse: move FR_WAITING set from
 fuse_request_queue_background to fuse_simple_background
Content-Language: en-US, de-DE
To:     Kemeng Shi <shikemeng@huaweicloud.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230904143018.5709-1-shikemeng@huaweicloud.com>
 <20230904143018.5709-2-shikemeng@huaweicloud.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230904143018.5709-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/4/23 16:30, Kemeng Shi wrote:
> Current way to set FR_WAITING in fuse_simple_background:
> fuse_simple_background
> 	if (args->force)
> 		fuse_request_alloc
> 		/* need to increase num_waiting before request is queued */
> 	else
> 		fuse_get_req
> 			atomic_inc(&fc->num_waiting);
> 			__set_bit(FR_WAITING, &req->flags);
> 
> 	fuse_request_queue_background
> 		if (!test_bit(FR_WAITING, &req->flags)
> 			__set_bit(FR_WAITING, &req->flags);
> 			atomic_inc(&fc->num_waiting);
> 
> We only need to increase num_waiting for force allocated reqeust in
> fuse_request_queue_background. Simply increase num_waiting in force block
> to remove unnecessary test_bit(FR_WAITING).
> This patch also makes it more intuitive to remove FR_WATING usage in next
> commit.

Very minor nit 'FR_WAITING'. The patch looks good to me.

> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   fs/fuse/dev.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 1a8f82f478cb..59e1357d4880 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -528,10 +528,6 @@ static bool fuse_request_queue_background(struct fuse_req *req)
>   	bool queued = false;
>   
>   	WARN_ON(!test_bit(FR_BACKGROUND, &req->flags));
> -	if (!test_bit(FR_WAITING, &req->flags)) {
> -		__set_bit(FR_WAITING, &req->flags);
> -		atomic_inc(&fc->num_waiting);
> -	}
>   	__set_bit(FR_ISREPLY, &req->flags);
>   	spin_lock(&fc->bg_lock);
>   	if (likely(fc->connected)) {
> @@ -553,10 +549,14 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
>   	struct fuse_req *req;
>   
>   	if (args->force) {
> +		struct fuse_conn *fc = fm->fc;
> +
>   		WARN_ON(!args->nocreds);
>   		req = fuse_request_alloc(fm, gfp_flags);
>   		if (!req)
>   			return -ENOMEM;
> +		atomic_inc(&fc->num_waiting);
> +		__set_bit(FR_WAITING, &req->flags);
>   		__set_bit(FR_BACKGROUND, &req->flags);
>   	} else {
>   		WARN_ON(args->nocreds);
