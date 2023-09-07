Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E70797ED7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 00:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjIGWyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 18:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbjIGWx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:53:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6DF1BD3;
        Thu,  7 Sep 2023 15:53:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 00B785C017D;
        Thu,  7 Sep 2023 18:53:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 07 Sep 2023 18:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694127233; x=1694213633; bh=UPvCAcnv/J1/jmV8VbkXD3TzSzdqkm67jXo
        9SWPq7P0=; b=U11SwOUjJAzuTXUxq8MSXWVVCKOM+MwmhLZqZJ86TfDnj1iCdln
        +QRXUxu7FTUt8ItP/q6Pbz0Zprk4l2xQAqasgHiIeuu3UxfWl8dIwG7q+o84sTEj
        Fgg4aoggO5IHXcNjKgs1sxKYpBWVdxySfE0LHcPddXQ5FFa2khUYRAZzMp4j63XV
        vYJq0Z29iEDM/0juvBAEeaIHRk/tRb4duqZKLwoodedXs6V4rnVDIQwjaNE4vscW
        51BP2Dk2ehoSJF87xWQj46Mnip2URvxtYqCj6PatjGCXZT480cuQszIh/uGk3sS/
        tdUvRCJ62VPs5+uFbA83QSdfuo72eh3HpKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694127233; x=
        1694213633; bh=UPvCAcnv/J1/jmV8VbkXD3TzSzdqkm67jXo9SWPq7P0=; b=q
        GXNj717nvSYZC8I7Qi2s8LYhRLjJMwcVfQNdOAOaTV+LaQfph+JNdRZraGBOtk1c
        VO3BHOBhtgNsoFDlggt+X7k2iTasjjellAzfKdEJZ9d//r2SJ2s7tlaU0o5mULV5
        JI0aVVbdeTy2DsmRHoOmjOddCf6RQ+SuGhQEqNQpTgvc2C9E1DXkAJ4ebYn0LpWk
        JWPR6Aad//Qnc9ObPm0mUOlkb7a9RS3yw+h+crr2aq8FzlpieQgXBLf3uyoLUKNe
        WJUtCidvt5BOR6et+8pHUJY/yW9k+Uq/2RDQvB5uXJot3znpmhr5t2achf/Byfjj
        WqzkCFeWGN9So0ZB5w8jg==
X-ME-Sender: <xms:gVT6ZLn7G_ssg6emN3PcqXlkqKM7IzyBLUpT1O2GneugLC5O8jNo9A>
    <xme:gVT6ZO1_lNOlLbZQKczlWZxcZIKWcM0SaL1KxaG9Zdrlf7s_oFSsYfqX6bc___wzd
    cRc00uqcg_8hqHP>
X-ME-Received: <xmr:gVT6ZBq-Be2ZzrjK1WQVxy939uixzcSS54FwKhTgcfsevbvn66Q82QsiXH2VRhbWJt1e58tziGWD2g4EoumyU1QwyRCwflqhbBg1dCL3WsxT1HAwqZOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefgteelleeggeeuueduteefiedu
    vedvueefieejledvjeeuhfefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:gVT6ZDm5GCXPYpY-Gu2o_5dA4uvuVeKbz6H0Qg2HRTvd0nQqMIExDA>
    <xmx:gVT6ZJ3Xv2xnqvrCRHAKfxNPpYGnF4W0SuxZTUuaxYPCsHRasa8GIg>
    <xmx:gVT6ZCt4CBXGUOhexLn66rBf95cdlD7UyMox9K3ll9zaNw4HzmlY-Q>
    <xmx:gVT6ZHBbIZVvhGJvZ87RjHNbePhtcOu90LqCGhPwJxTKGYo9rpkubw>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 18:53:52 -0400 (EDT)
Message-ID: <ab117143-c89e-baa6-d1cc-a0983337b826@fastmail.fm>
Date:   Fri, 8 Sep 2023 00:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] fuse: remove usage of FR_WATING flag
Content-Language: en-US, de-DE
To:     Kemeng Shi <shikemeng@huaweicloud.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230904143018.5709-1-shikemeng@huaweicloud.com>
 <20230904143018.5709-3-shikemeng@huaweicloud.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230904143018.5709-3-shikemeng@huaweicloud.com>
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
> index 9b7fc7d3c7f1..45da5553bae3 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -307,7 +307,6 @@ struct fuse_io_priv {
>    * FR_ISREPLY:		set if the request has reply
>    * FR_FORCE:		force sending of the request even if interrupted
>    * FR_BACKGROUND:	request is sent in the background
> - * FR_WAITING:		request is counted as "waiting"
>    * FR_ABORTED:		the request was aborted
>    * FR_INTERRUPTED:	the request has been interrupted
>    * FR_LOCKED:		data is being copied to/from the request
> @@ -321,7 +320,6 @@ enum fuse_req_flag {
>   	FR_ISREPLY,
>   	FR_FORCE,
>   	FR_BACKGROUND,
> -	FR_WAITING,
>   	FR_ABORTED,
>   	FR_INTERRUPTED,
>   	FR_LOCKED,

Yeah, at best it is a debug information, but as it is set anyway (also before
patch 1) before queuing it, there is not much to gain from it. Looks good to
me.
