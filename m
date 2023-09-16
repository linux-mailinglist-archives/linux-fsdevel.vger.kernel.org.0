Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3F7A2F6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 13:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbjIPLHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 07:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjIPLG5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:06:57 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0882D199;
        Sat, 16 Sep 2023 04:06:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6B8123200786;
        Sat, 16 Sep 2023 07:06:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 16 Sep 2023 07:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694862407; x=1694948807; bh=KNPnuJg5J06+4l2lKMSaca5bqznxaYuUEOM
        5vQKVna8=; b=mkCbZfvl+H94RMDIQ4wQcwjOe8DLRu5U63SBcZ90yjii68T3RU7
        WKa5cML2uU6Z9uX0K06C/rWAxSqapH3aDDOX2YpxXe6yGFNSDZJWV4e0Wg/aTNGE
        /FUtqfykOHzNi5bK7hsCdqSatHAKp0qTYm0Ed1C9MNoHqymcEaabbdVRVKTYIxmu
        aK6rmtIzwNHw92bsdzydM2qNLpsbrJoT9bvA/69Z3QRX6AzC2HqJ+pexnPITCknB
        I2qxuz7ZlWpSlksMKgB+kAN6YihCl/ZLJNchRhK2DattOTzIGfnaVK+EyhEZljgL
        kFcOt07ihc0iT3SXW1/sErao3UBdX48KruA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1694862407; x=
        1694948807; bh=KNPnuJg5J06+4l2lKMSaca5bqznxaYuUEOM5vQKVna8=; b=Q
        sr37rigZM4Y1cX+ddktp7mL/rAQP4yvCOcHW7NUQtSkCmyI1dLfTS9G1pdVue94h
        iXE/tzoFisZOb75PIdgpUTWI7rjZb3EVQuM79kw9KV4fpsB2bAqDYxeGTyKH+APy
        lo1+ikTkltDUAtSTYiqhAR8oxjEfIkyBixmWplYUsRegntBlCjtuep9wHemXK8hu
        TgYIX0azDrE0nC9EcRcxjoX7ErFCSeRy2/q3XTY2cmP/YkFNi9lbzBiB4Y5ZB6IP
        RCKCZ05FffLohvF+h1hP7TPnCNlSeA8/3K6BTRzlT+FincQw/sP3v8Yw0SFJRz7Y
        2aOKM98P2x9swG8PErWKg==
X-ME-Sender: <xms:R4wFZbli6f-4F9PG75KT6DOYkl9kPLXFMXh83XtXPlKNyobvDC8PCw>
    <xme:R4wFZe1ak13G5Gx1VMjfxq54Jim4a_zqGqzHVn0L8riQQALXJGTVJ87j4-SuFUaPl
    oSd_mPyvtfo0-1w>
X-ME-Received: <xmr:R4wFZRr9SovJ5iaT8TyunWMyog6IrZIunGskjDdGr4xxQMtFNsjAysXTJcu7DF8YWX6yG14ZUSx8wycmQJ0yJunRFceECTngFFMaZNqFC0DkVZA0Oz5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejgedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefgteelleeggeeuueduteefiedu
    vedvueefieejledvjeeuhfefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:R4wFZTmMLtPVEMZKhOUiu07lA-1YPonIqmyC4Qzb91Eqzn4FKeQOYg>
    <xmx:R4wFZZ2unKu_Me6UEDW01ksMiY_2r3jO2fAXBAFuIrt8EfsAajFB_g>
    <xmx:R4wFZSsDOna9USE4WjSDfUJHjInQ4zeXSrNyERWBV5jBbcDOSn5IRQ>
    <xmx:R4wFZXASIuziNu-Jf2Lanq_MDhA9qRvQ_IFvjV5cxcwbue_Sjv1w3g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Sep 2023 07:06:46 -0400 (EDT)
Message-ID: <9a5d4c82-1ab3-e96d-98bb-369acc8404d1@fastmail.fm>
Date:   Sat, 16 Sep 2023 13:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] fuse: remove unneeded lock which protecting update of
 congestion_threshold
To:     Kemeng Shi <shikemeng@huaweicloud.com>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230914154553.71939-1-shikemeng@huaweicloud.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230914154553.71939-1-shikemeng@huaweicloud.com>
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



On 9/14/23 17:45, Kemeng Shi wrote:
> Commit 670d21c6e17f6 ("fuse: remove reliance on bdi congestion") change how
> congestion_threshold is used and lock in
> fuse_conn_congestion_threshold_write is not needed anymore.
> 1. Access to supe_block is removed along with removing of bdi congestion.
> Then down_read(&fc->killsb) which protecting access to super_block is no
> needed.
> 2. Compare num_background and congestion_threshold without holding
> bg_lock. Then there is no need to hold bg_lock to update
> congestion_threshold.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   fs/fuse/control.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 247ef4f76761..c5d7bf80efed 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -174,11 +174,7 @@ static ssize_t fuse_conn_congestion_threshold_write(struct file *file,
>   	if (!fc)
>   		goto out;
>   
> -	down_read(&fc->killsb);
> -	spin_lock(&fc->bg_lock);
>   	fc->congestion_threshold = val;
> -	spin_unlock(&fc->bg_lock);
> -	up_read(&fc->killsb);
>   	fuse_conn_put(fc);
>   out:
>   	return ret;

Yeah, I don't see readers holding any of these locks.
I just wonder if it wouldn't be better to use WRITE_ONCE to ensure a 
single atomic operation to store the value.


Thanks,
Bernd
