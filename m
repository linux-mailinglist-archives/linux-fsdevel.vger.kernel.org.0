Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B2743960
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjF3Kcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF3Kca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:32:30 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E7530C5
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 03:32:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4663232009CD;
        Fri, 30 Jun 2023 06:32:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 30 Jun 2023 06:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688121144; x=1688207544; bh=MF2AELS10CZOOE1BV+7FQzd7j56UV6+/VIk
        Fma+gd3s=; b=MH2d6IB4YNhFswxSs+ajg+l0dRm1TrDcJ9xl7mMDOGTFsABAl2D
        GZ/GiVUNVA+B6XVlNpnVR285hzNqqh1oF10dQJRuYqsYaJpHDvqHufV3+/j2VGkp
        pvsH1tPPdqdYtRWsXnr7BV5M8MDOo0/HYgPIWsW2A7FQFBlWrWCWPbDXN78x2ZJT
        fXt4bl1v77vqIo6TIcvciA4FRupdz9iQfitNCn2te1nraN+DJRk9NRE9pvQal+Wh
        4Uc3cZVfIlUZ9XaPXFPVy1kBWWCvpQPM3da7v8NkdTho6JCOm52/kbvMyg+qb+Fx
        7pa5J/Fuzx2/CQv6KYif1CNzuwChjmZU2vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688121144; x=1688207544; bh=MF2AELS10CZOOE1BV+7FQzd7j56UV6+/VIk
        Fma+gd3s=; b=ayWChCEdNrLqsHN4uaDGWZkUjFJa6ksIf+bQwn3U/twZ7YE2k2D
        eubPErN/wMlaC4eFvMU28WOUO/uZpM7We1u3MXlPdQUxuQp+HPE7wC5pSh9VxbUc
        bT09vGR/ALH6YqBb1CcTQKtBz6w1poYAxwGYdvDc/Fm27MldLEH8KZ2yKHLgU93B
        4/zyz4upntw/AzSWTvHEnO2mvvrTu8woJSlrpNduuBytVp0KhcNmaly0CBN/yNoV
        jK6kCYEAwoMUqu7uBmSyABA35ldZsgvfN4uZQUShx7LtJ3DT7d7hJWOqCqjynYE4
        m6fyuU2u97KzAxmL/bn/0n7ZKugfUJPgW1A==
X-ME-Sender: <xms:Nq-eZH4oDoALcQTgVh3BGs2LovqsX7W_prONzIk75ipSmRzh-p5ndg>
    <xme:Nq-eZM6Nhh6xyoqSFJZCOp43xgF_vzcq8z1vpy9mr4uirD4AkPrgsmwhul1GfSwkz
    RAu9AQ0LcutduYq>
X-ME-Received: <xmr:Nq-eZOfM-TdNT0nu9MK6v9zNKRQtpl3frHaPJE0_fMh_ikpRIkm0FKq1bme3rN3-Lb6RlrK5uxcAgYycR7mlexDp5hVzD2pMLkf22M-0CmB77jc9Dh_m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudejjeei
    heehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:Nq-eZII0S79i4JTQN8pxytiStyinW--hTuFzX_rkSB48h5eitzAJSw>
    <xmx:Nq-eZLLrTWRrLi90OrunXnCLk5MvssBq0lUSCfJn97CtIAroTY2KgQ>
    <xmx:Nq-eZBzj7duzRbGHIMKXXxQrefY86opc1PTc0TC_EnEZp5_gGk1UPg>
    <xmx:OK-eZIFX1t-JLGruInk4TJEZ3U1DmBQ1eVWrmxXNi3uDm9XJfyn2Kg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 06:32:21 -0400 (EDT)
Message-ID: <027df630-7cce-b6b9-91a2-ecc51e11346b@fastmail.fm>
Date:   Fri, 30 Jun 2023 12:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] fuse: invalidate page cache pages before direct write
Content-Language: en-US, de-DE
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
References: <20230630094602.230573-1-hao.xu@linux.dev>
 <20230630094602.230573-2-hao.xu@linux.dev>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230630094602.230573-2-hao.xu@linux.dev>
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
