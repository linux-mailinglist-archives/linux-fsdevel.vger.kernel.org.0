Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3B7A2FA5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 13:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbjIPLPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 07:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239262AbjIPLPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:15:35 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB741A3;
        Sat, 16 Sep 2023 04:15:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3B6F8320092A;
        Sat, 16 Sep 2023 07:15:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 16 Sep 2023 07:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694862908; x=1694949308; bh=0bwZMM2xOlKcoGRCbyHscdRQUzZ526W6h6D
        76rWL19I=; b=B8rjWQkgkGdrU+PiiEm5yXFGjazEAVs95C++guKUOi+xKktDDrR
        N9ncvtdQnH8Jq6XgUw3V8LBdqE+afpSXjqyYa4vIQpsB1NatkB+Dx0o85W2W4XDT
        8NdEhdeZOaIQhinHAW2w1jP0gU0PJ9d5Gtk7RepwqMMxBTorWga0sWRljOaopjYn
        hG9jy7e5Qf1wnbuk/XNDhUVfeiH+9Z/MJhyJoBehI+OZspCpf0dChxEYGIUe/7G8
        uuwLT7JmnMwqVeTe7sHwaMpS/wEo/15GVOP2RtCnmVaun13qKQwvjKXZYDw21rt2
        5DNy36R2CGI+yeZ1YSRl/t5VlNjjU6yW6kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1694862908; x=
        1694949308; bh=0bwZMM2xOlKcoGRCbyHscdRQUzZ526W6h6D76rWL19I=; b=E
        JP2fpid1tg2b9Qj2SYxLk9pmXUvg/Icc4ZO8JY8P1DRPKMQr8iKpkicZaUxbGnYf
        cEYOFllsrY3UXwNesSj6jKvzU1Pjw0pZvWwdEVLLi9MvFrK6hmmcrCaUA2rirgrU
        KcoVuLL5kK+j4ol7roBPlWWDUdxTxr9c2usmBB6/UXyGzD+KAgR1968L5DIdmPzf
        w4Qz4UYvECf/dEmvfnpcgiwtTU4GsTyETWhotc+I2ceU/SuSSdiRr6+6fNFvPDPK
        3E4WXWAVelezkeOUZC/iOz8j9/pjdJTmMGvivJWuwIIgCJqZCghkhR6DRXBif70j
        3WsJY5c/SHo4Wsvd+aUmQ==
X-ME-Sender: <xms:PI4FZQd5Ir-ABwzpgw9zLdmNmREHRmUNOz-cP1N7wmDruBJP-OZrNQ>
    <xme:PI4FZSPu00a8THAy8J6hbkQW3i_GmwfpCcRUkFOUYhUCATcLaruuERhAaAp4Gywjs
    G0NYUSqTZij4Krn>
X-ME-Received: <xmr:PI4FZRgv1GmeG_SBsFHqzCEtL-28t5oVef-WEolF9AxNDf-SRuQfuJAeY8HiDKFosyYjfUT75yGaeYaaxwoC27gfDDZKJH6u1Eu7p7gq0yNuHq_AEBWh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefgteelleeggeeuueduteefiedu
    vedvueefieejledvjeeuhfefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:PI4FZV8JqzCtpDhrPUjdEZtCptwxQ5r044VINrM8HUaa7MwzK4bKQw>
    <xmx:PI4FZcsbFqVCFmoXS_Mkur7GClkKLEoR463NPTDCwnCeRmPTrT4muw>
    <xmx:PI4FZcHTbFHpTPxTuuQVql_gHJ666M_rFcInDU4RB0VmvEd-vZhzbA>
    <xmx:PI4FZV63PtnqU5MyVHz7oFFYKGiJm9Y43PzRCSy0hpUGk_xuExPvNQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Sep 2023 07:15:07 -0400 (EDT)
Message-ID: <7a6d2c91-2221-ce07-995b-9f648f9ba2d3@fastmail.fm>
Date:   Sat, 16 Sep 2023 13:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] fuse: move FR_WAITING set from
 fuse_request_queue_background to fuse_simple_background
Content-Language: en-US, de-DE
To:     Kemeng Shi <shikemeng@huaweicloud.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230913092246.22747-1-shikemeng@huaweicloud.com>
 <20230913092246.22747-2-shikemeng@huaweicloud.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230913092246.22747-2-shikemeng@huaweicloud.com>
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
> This patch also makes it more intuitive to remove FR_WAITING usage in next
> commit.
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

Looks good to me.
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
