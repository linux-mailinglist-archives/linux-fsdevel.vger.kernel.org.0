Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4C9784550
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjHVPU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 11:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbjHVPU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:20:58 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBEDCD6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 08:20:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E9E45C0186;
        Tue, 22 Aug 2023 11:20:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 22 Aug 2023 11:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692717652; x=1692804052; bh=lgAHRyTRiyQd67yNbpCDEg82Y5VFwDpEbqC
        7YgP8xBI=; b=j/CRWlZtbrL8Ps2/k+MrXUXV3q6xU3EmfZ7hkFUlsOZLKwlTwwG
        tZxm6PWqrnPS8acsXYSbKWyN1+D61wnNTWt3fQex2UQDYQhYPj8ycm291+BNLy5X
        ejD6Ll/8R2jEAsQfh1wwF0LFh9UQvnJL6Mf1DdUrwLTV7/2Qgfry4GUoOi3hKxhV
        YiEjq8orEUuto9vid5RJl9/CldXL44EN2+l5FbfGlpZsoz2nyOsc5cm+MS3NvPe7
        HTtHx0o7wb6gb+x4nnWGsM7fG82FtbT7q7Doaw8I+BK72nSdSiwmgiazgX15f8gB
        4d0w/wwtgaSrreVrotTbEwiBqwQSVs9OSnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1692717652; x=
        1692804052; bh=lgAHRyTRiyQd67yNbpCDEg82Y5VFwDpEbqC7YgP8xBI=; b=f
        2j+S/jcFaNP2qv9vi38aEdCEaPq1DfLKvqHhjs12Hzapb6VtjGObURQhUvh1n+Qz
        lo2R0gblH3kSFVD5nFlNWfeboGN6yemdgmXgqtcXTYIHBilQzBXmwYnYoY1Z8HbI
        57tkOWNSORwABYwRf6+oYSu0bWV+c9qTOcA5u3T6S8i5PcQKy18UyhthJoXK3jkd
        VVGjlWOXRw4akGat5jU5LuzLCDBTwHuPL2BRMMJqnJSxGDMO5LZkKc4oiD0SgB4N
        v/dxEt75V0vOThqo066p4qpoz+IQmyt7o8aXOX4YidFDgo6LOwKQvx3pz9fw1xRx
        Nw9Tu/943W5juBuQmJr1w==
X-ME-Sender: <xms:VNLkZPPSiKy6Bh-RNkAMnT3pFh39Xzu5O6moXFbk1d1Spni0yMgsXQ>
    <xme:VNLkZJ8_wt0EYLXeUlP7RX-QUtf7qoM-0QmQSQr9rrUrwh0NntO2KPU3Xi_p8CwdZ
    ljYkdKalAe6IUAk>
X-ME-Received: <xmr:VNLkZORI0nC2C5qEjBvA766BgYF4Wj5Aw5sOvmX8azIxipk7b0HhLaE0OPlUOXIggNr8OJlP33O0thrvxTm9Z2h0hj81fSb2DWrW9VnbgToEk7fkllgn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeegffdutdegiefgteelleeggeeuueduteefiedu
    vedvueefieejledvjeeuhfefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:VNLkZDtNGSZ1iDHF1ui3UyBlKuon03wUErG6z68tMrD46-AoEQRRQQ>
    <xmx:VNLkZHeo0IxCzIK-j8XwCGE9leukJSMPVn4kDzEo9Odc30tqLPZSYg>
    <xmx:VNLkZP1AzWyw6WM58qAQnRd1iG6IBLR6A8_8stfs8L21CO14J4jcBw>
    <xmx:VNLkZHkeonMThS44LAFTBm6ekZ3oadcx0EmqPqOuHJrEsrvvLICKkQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Aug 2023 11:20:52 -0400 (EDT)
Message-ID: <067fcdfa-0a99-4731-0ea1-a799fff51480@fastmail.fm>
Date:   Tue, 22 Aug 2023 17:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] fuse: implement statx
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20230810105501.1418427-1-mszeredi@redhat.com>
 <20230810105501.1418427-5-mszeredi@redhat.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230810105501.1418427-5-mszeredi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

sorry for late review.

On 8/10/23 12:55, Miklos Szeredi wrote:
[...]
> +static int fuse_do_statx(struct inode *inode, struct file *file,
> +			 struct kstat *stat)
> +{
> +	int err;
> +	struct fuse_attr attr;
> +	struct fuse_statx *sx;
> +	struct fuse_statx_in inarg;
> +	struct fuse_statx_out outarg;
> +	struct fuse_mount *fm = get_fuse_mount(inode);
> +	u64 attr_version = fuse_get_attr_version(fm->fc);
> +	FUSE_ARGS(args);
> +
> +	memset(&inarg, 0, sizeof(inarg));
> +	memset(&outarg, 0, sizeof(outarg));
> +	/* Directories have separate file-handle space */
> +	if (file && S_ISREG(inode->i_mode)) {
> +		struct fuse_file *ff = file->private_data;
> +
> +		inarg.getattr_flags |= FUSE_GETATTR_FH;
> +		inarg.fh = ff->fh;
> +	}
> +	/* For now leave sync hints as the default, request all stats. */
> +	inarg.sx_flags = 0;
> +	inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;



What is actually the reason not to pass through flags from 
fuse_update_get_attr()? Wouldn't it make sense to request the minimal 
required mask and then server side can decide if it wants to fill in more?


Thanks,
Bernd
