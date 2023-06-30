Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A61B7439C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 12:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjF3Kmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 06:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjF3KmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:42:11 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD01F3C29
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 03:40:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B34CD3200941;
        Fri, 30 Jun 2023 06:40:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 30 Jun 2023 06:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688121657; x=1688208057; bh=MF2AELS10CZOOE1BV+7FQzd7j56UV6+/VIk
        Fma+gd3s=; b=gxjmfSebzMINJchnrgCTUIrrjm79ajyKoT+JUZgEPZH24gBjLgH
        8xlEGu1PibvuMNH7rYma3vs8UaxyzfC4FTqfqjKDj2cippxLRAwPeYjJS02eo2Zp
        F8N7Ka91r3rohQSoPM9M70zSh0RD9VxJKJGROYVSvx/HIfyMtsAqIGRUsRnWxC3v
        AKAn/T0dS0/MrYzJlFus124RV8AY4PIs/3F9E7h4RJyz4AtT9iIERWH47bAd01P/
        Lj4Jf2K9c9lkfbSmt7l69tvV1bDAS3U5Vb3LwEQ9AcrZK80mrWKuEXUn4UIRiFvy
        zPXMEawhuWdtcX4MTC1BOBAELonLYrVxpTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688121657; x=1688208057; bh=MF2AELS10CZOOE1BV+7FQzd7j56UV6+/VIk
        Fma+gd3s=; b=JqwXyDVgEq2xRO8RC4dLfuahsBOe5U0xp01SEwdaFDTNl3AzzGr
        ny77phCL70WjWsgIf4INzkMp/X/VmQMjHlz2XrpIFSxp6wIY/HflKBCSG99sKRQ6
        qDSZyw0RPeTtKoXiF/CmYhGNtvNVV/Hyh8vrT66Af9yVpMr0zQ7eQ+4584C/BPTY
        YcQZ2qOlZ9ifmSpl7osTxg9jNC6x3YAxKk/pKUMhcR9BTP9cLTPJ7ZLRbI6rhduY
        UqHcsNcQlUAXxWmOveZ+rFkd9HbFQJ/aKjIl+O6TVSiabHIh+BUTZLVkZDtm97Zv
        s6WhMEYlGz7QXs7/VoMw83TbYltUIqada6w==
X-ME-Sender: <xms:OLGeZJyVaGkQRC7tuXaJ7XmivxZ1xf1YpL5qCFU7X1qr3s0xcMPEgg>
    <xme:OLGeZJT3t1Pju4zD5lodfwNDU4HCJF_05QxUnySadlfVY4PxgdyuCf0NaaBOlosNn
    Teijxcxd6EUrOaO>
X-ME-Received: <xmr:OLGeZDW6k3lcHfi77MI_7MkuHUQm_jAEfzSrHopWdlXrSx5Bw2Sr6amlcvmbTPnroxulxNCFj2SinPGKoKJts58dyQ7dpce4k6SxK0dVAZ4Q4pHeVjYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:OLGeZLhS8WC2WPo3uexIgF-jIalFDWETez2rotYFkeNBsMP_l32qjw>
    <xmx:OLGeZLBM9SQCe2p8YWcTJvPd7kB4A_xgaDi9UAv2ROxOigQEL0tkIA>
    <xmx:OLGeZEJjfvJ4wI8epTvElEzSvbqJjmrvJ2Wd8BUZeMm-1OSvrqfIwg>
    <xmx:ObGeZG8jLHhFTxSqY8A_nGcrX7FJskxJomtB5BTjjMEutGKQLnpx2g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 06:40:55 -0400 (EDT)
Message-ID: <628bfb98-08f8-ecf0-2e7f-1c67ae09a07b@fastmail.fm>
Date:   Fri, 30 Jun 2023 12:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] fuse: write back dirty pages before direct write in
 direct_io_relax mode
Content-Language: en-US, de-DE
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <20230630094602.230573-4-hao.xu@linux.dev>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230630094602.230573-4-hao.xu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, looks good to me:

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

