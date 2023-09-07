Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD7D797EDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 00:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjIGW4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjIGW4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:56:03 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6301BCD;
        Thu,  7 Sep 2023 15:56:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 76EA35C01B0;
        Thu,  7 Sep 2023 18:55:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Sep 2023 18:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694127359; x=1694213759; bh=JY/3pWUgixeq4U1xcB+vQrecNNcreqKmHuv
        TvHPoKks=; b=hZOKZyDUc7+j+CIPweGtI9KhmXyOpFpT1Q2Iwr/a2WroAjm8/Hs
        yCJo/vqmL3zCuf3sFLp18W+gMXndqIYJ6ANDdu3V2nW/4PzGleSLbxE8ndfBwVIS
        Ml8hp+d/GHmNqeW0g9Z1RgSHWVVeFhVORjfR/JLVzxyV7y7b9ykyZw9xxJU0RFz8
        /Dnv8KqpdNboELMioNvZczDtKxZAF0xWjkj1E8IiawKISGAN0+gZaH+qD6GuQzYj
        k6FWa+lKtaQ96cMdwKfujoD271d9s1JmPW5+tiVgiDC28xpsFHPdEw2x0ICDaY7a
        5xXYrO74Ufn89edqOHlCEDJNj23zPicl9gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694127359; x=
        1694213759; bh=JY/3pWUgixeq4U1xcB+vQrecNNcreqKmHuvTvHPoKks=; b=p
        LfEGCr84wsFOW85Yq/WxTzsZddhj3yvExc3WX3BZEBMEDb2rPfEe3CaEU6BU+r8C
        M/zRB5DiVJF9vqh3muvVQyMhEf7TgpPMLGOjiEG2/q7UN0HJ+SHppAifIyMkxkH/
        fLJ6EzDUYhgeosOEHyj2et49RjFq51t97r3bfRgFDiqghbJMWtjz7IXU65xY84B0
        Zz8Odi5SrI+M3NwFWfs2RXHKWFh8Jefl7jaEc7UyMFWf59Nea3n4cBjn0glyWaFV
        IwAJyiMVGrz3xj5rsculPRKuVXjX04QJlbGRIotOY7yaPVc5lTrtkGeFQaFYfuUu
        pew9Um6dY7EGq4tti8guA==
X-ME-Sender: <xms:_1T6ZLx2FwowYebnfnvo55HF8J_2z_sFEKH7JlaUjXyKa4MgL4JJmA>
    <xme:_1T6ZDSS8CWGyMZKdtvQXZmZjjgmeUwvVowBS9EIsUxY0MAxiIIUZCKEM0Db2bEMi
    BZtD1_s08tfnMWH>
X-ME-Received: <xmr:_1T6ZFVQGSKfEKrJW3QxUUxSM8cjWKj17PbOQBsEVuqQLJWjmWtm6c8unBiER4SH72wXlAhB5-SGrRUQO9-M4JA32vpD0pYzmTgTUyhpXFB1g89eBcPJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefgteelleeggeeuueduteefiedu
    vedvueefieejledvjeeuhfefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:_1T6ZFj-MkyBfHK6T5mQaW8NRVKir97boN_9nX7fVsrAZwkbDI6YGg>
    <xmx:_1T6ZNAfnUf8_ET-7WGWjeGPvo0ksNI4kUAug8Yyt8GWaWp1fjOEqQ>
    <xmx:_1T6ZOIHIt38Q_D3UyDOFXujiK43Ccekd8lYsVDq2JHy0h5qiUBhaA>
    <xmx:_1T6ZANX3lfmCQNPpypX-6pMCkT2DIPwXFRGCj8wJUjWOfxpaRkLAQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 18:55:58 -0400 (EDT)
Message-ID: <633750a9-bd94-df4b-0112-1e1e15a6b47b@fastmail.fm>
Date:   Fri, 8 Sep 2023 00:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] fuse: move fuse_put_request a bit to remove forward
 declaration
Content-Language: en-US, de-DE
To:     Kemeng Shi <shikemeng@huaweicloud.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230904143018.5709-1-shikemeng@huaweicloud.com>
 <20230904143018.5709-4-shikemeng@huaweicloud.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230904143018.5709-4-shikemeng@huaweicloud.com>
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
> Move fuse_put_request before fuse_get_req to remove forward declaration.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   fs/fuse/dev.c | 42 ++++++++++++++++++++----------------------
>   1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 4f49b1946635..deda8b036de7 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -101,7 +101,26 @@ static void fuse_drop_waiting(struct fuse_conn *fc)
>   	}
>   }
>   
> -static void fuse_put_request(struct fuse_req *req);
> +static void fuse_put_request(struct fuse_req *req)
> +{
> +	struct fuse_conn *fc = req->fm->fc;
> +
> +	if (refcount_dec_and_test(&req->count)) {
> +		if (test_bit(FR_BACKGROUND, &req->flags)) {
> +			/*
> +			 * We get here in the unlikely case that a background
> +			 * request was allocated but not sent
> +			 */
> +			spin_lock(&fc->bg_lock);
> +			if (!fc->blocked)
> +				wake_up(&fc->blocked_waitq);
> +			spin_unlock(&fc->bg_lock);
> +		}
> +
> +		fuse_drop_waiting(fc);
> +		fuse_request_free(req);
> +	}
> +}
>   
>   static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
>   {
> @@ -154,27 +173,6 @@ static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
>   	return ERR_PTR(err);
>   }
>   
> -static void fuse_put_request(struct fuse_req *req)
> -{
> -	struct fuse_conn *fc = req->fm->fc;
> -
> -	if (refcount_dec_and_test(&req->count)) {
> -		if (test_bit(FR_BACKGROUND, &req->flags)) {
> -			/*
> -			 * We get here in the unlikely case that a background
> -			 * request was allocated but not sent
> -			 */
> -			spin_lock(&fc->bg_lock);
> -			if (!fc->blocked)
> -				wake_up(&fc->blocked_waitq);
> -			spin_unlock(&fc->bg_lock);
> -		}
> -
> -		fuse_drop_waiting(fc);
> -		fuse_request_free(req);
> -	}
> -}
> -
>   unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
>   {
>   	unsigned nbytes = 0;

Hmm yeah, but it makes it harder to get history with git annotate/blame?

Thanks,
Bernd
