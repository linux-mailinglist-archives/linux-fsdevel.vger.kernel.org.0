Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649D57439A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 12:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjF3KgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 06:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjF3Kfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:35:36 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EEB3C10
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 03:35:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2E0CA32009CF;
        Fri, 30 Jun 2023 06:35:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 06:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688121312; x=1688207712; bh=MF2AELS10CZOOE1BV+7FQzd7j56UV6+/VIk
        Fma+gd3s=; b=GT8jg1Ig2k7/DAJmP0DNKUttDtfNxJcAHhUnI2wqG4wpBmsertM
        3UijViECRBGX/T6+rV+Jtgo8uvAnL32LWsEHmmrP04iKRFC5GavwDD8PlNVA6iVn
        AqB3EFNusA+dcuejhit5k+SM71ZCVPCIYzEDTbuvkxrLk6tTr8Bw59ruLIHjZD4r
        sx1h96Tk7eMzaMuswbTbSR8SPyEYDsm7+eLBsjfFr4VsuHmB6N6ceMSEpPPJefx2
        WuALIehSLUo78nXMBum7C7+AbCYJGgEkHCer2HVZU8a2kombrA6et0RyleFt1PPn
        8x4lrJTngO0YmHJBjJVBP4EpMYgChjkYtvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688121312; x=1688207712; bh=MF2AELS10CZOOE1BV+7FQzd7j56UV6+/VIk
        Fma+gd3s=; b=cpQw/EIZg3wfVLfxdjsBGrirkofLqK6jx15uAQic2YnfX+xJdS8
        874Rb2rBMkc0UGhevAukx2K15WR092+3bL//Gfh2IxNPLerkCVrtttmvnrm2kb95
        AX13ogtW5jssRZPQgR1mG15NhdOw+lEQ9M5wn410wLSYVRPHrF4dGQRcZPG8lBFi
        0ywhAUKQwjhGsM8W3MIGT677zU0h+qHh0bVFRW6Sv8lOmIFEZuOUhELPS4SQXB3T
        j89NL4ZZSCeXTZzwwDaTZKD+P5nQ3miuDrJUh/+yWpJa3SgTzdAuDDZrjOXEAaGQ
        +EvxpaBKdK9ZpOjKpmco3iMlmi3bz5wRV8A==
X-ME-Sender: <xms:4K-eZIufvQIB2-5Xrpb9HbvONyOyqs3xn7u4afzsNhvtHVtqYkdA0Q>
    <xme:4K-eZFfsLW7EOCsGCiASp8QgQN1k4nqFDnXjnmOadY-vzQ5NoeJYXr7yV2DrO_lCu
    mUpM9SmjUleNLpH>
X-ME-Received: <xmr:4K-eZDwjeHUwjbJKSpR8GHNLyjQz3t2brzNyqvLTAacTZ34YvylIhaBzEG3hlOjkHrz9w1YR5Gcuc3s4Nlhc1Uom9aq0AyeK05wtb9aCMg-hNdlZAYRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:4K-eZLNUArybJS832EnmAzWaEyZ1uDJwL7pS3HBNL7LyzMQX1Nyk5w>
    <xmx:4K-eZI-mXrBO5fISM7yi0MX4MwxN64_OwlcB_GtYeS-v867m0qcwFw>
    <xmx:4K-eZDUBrDBLjGqm-D_vRDOHLMgyYOxbNXc6mJSb3ImLalLrW9kFEg>
    <xmx:4K-eZMbtwcUkB2NYOoqRYZn_DxGn7S0gLnCZmffPno5uW2hvjGSWwA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 06:35:11 -0400 (EDT)
Message-ID: <412f8089-3d98-7aa0-3c1b-f144cf7b9552@fastmail.fm>
Date:   Fri, 30 Jun 2023 12:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] fuse: add a new fuse init flag to relax restrictions
 in no cache mode
Content-Language: en-US, de-DE
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <20230630094602.230573-3-hao.xu@linux.dev>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230630094602.230573-3-hao.xu@linux.dev>
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
