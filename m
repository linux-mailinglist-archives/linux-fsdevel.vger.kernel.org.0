Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71163562BCD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 08:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiGAGaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 02:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiGAG3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:29:50 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051AF51B33;
        Thu, 30 Jun 2022 23:29:33 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 22F013200A0F;
        Fri,  1 Jul 2022 02:29:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 01 Jul 2022 02:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1656656969; x=
        1656743369; bh=KOIspMJcHwQs1OjYuZR0a1hevSDFUbLk2XVqDs4Khgg=; b=e
        h/UYSZj11vlV7kHAOX3snTtKBjNWLEK9jIGVvUigvsCqlWluer4N7UsqzBu7uIWt
        JH36NFvGXNokaYVuxlhMY+pUWJoDmOm9T4oK++uGJGfAUUR5iU0GdwtjmmxsVHzd
        mtDPujFMVMzpUAjpGHPzPHRXcRKcCA4LapBJch3m3XqM2U/PvGUTOKZLDA8Mxz2P
        Tu3T3GebIwuzdjj4W/2PWfvYyflYy1M+N3CNC/IIwx/Q6p7TQZ3LWVQRBRMs+Vqr
        b6AJmucXdqru3fvgy8zk6e+XT9Pe4j8GZhWNrOZRxbbW8S/2m7Uw7/KYUcccO6m8
        Ia0+K6RUD8VLMmw4/Xg0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656656969; x=
        1656743369; bh=KOIspMJcHwQs1OjYuZR0a1hevSDFUbLk2XVqDs4Khgg=; b=m
        x82v4hHtH4Y4eTg3FKRwbhGEAfk8Y0Bm9Y1LtSKIu9T0Dpr/QJeP5FA8Fb3Xuizo
        iGcm7/7uxM2LlWu4vvMsZsWMg9bdBI0lwL43a3IHH/L2NKMcbg4m8+ucPIXOUbnj
        4zY3jB/wC+XRJXkyj7Ccw17HV2EI6/4MCUUsth+kP8UwKYeGTGFPD99V53jN0A7k
        w8NDJAo2cP7yDGzb3jA3MvUkwdLnP2GHZltlGrV5KVlD6SlbxWNbOhnvyYLbyYKC
        L3CHQTSDe6bvhtTNQx2DnHjdRixZ5NMgglHsR8/caKQat2GJwDBVcMk0gar/yJIw
        cy+1LZUp2Ua+K1UZy6s1g==
X-ME-Sender: <xms:SJS-YgeJx_z4peflLVFJZQrCRmjyltwpqR0cOQbLiZPWYby4L_QcFg>
    <xme:SJS-YiO-e5L1KvmHTGPVdunbMX78D0IA3RwUe4flvLCpR4YlT4u4qdHSXruOYVe-P
    zQEN1KVlmId>
X-ME-Received: <xmr:SJS-Yhi_JyU-kctbDU-Or_eb1brXKbh7n5QLLk67ZFwyGbs8Fb3GFsBH0zoQF1uDSGig3YSaZaWkGhW2dN-0aJ8p_qfPaWmJvuM0d2v_4K75lX9yy-vx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepkfgr
    nhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeiveelkefgtdegudefudeftdelteejtedvheeuleevvdeluefhuddtieegveelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvg
    hnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:SZS-Yl9Zn8bCZ9OktPrd1wNbaoa_rd2O1pg22qE8VCtFwFeW2ziGzA>
    <xmx:SZS-Yssr_L2g7UPlrnysTEI0uv04C3rwJIrfP-RRw3gSBOdPm33ioQ>
    <xmx:SZS-YsGjwV3xo9kkaGOKdzdkTd46bLm7hycM8An3N0rm9OCWAdP5vQ>
    <xmx:SZS-YmW8fMtKH773HjszLcO18Od5Vkti0pemTyxgQ2fjoIk0ICl81w>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 02:29:25 -0400 (EDT)
Message-ID: <ccc58c3d-ed6d-c3a2-15f7-928b289779cd@themaw.net>
Date:   Fri, 1 Jul 2022 14:29:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] vfs: parse: deal with zero length string value
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
 <165637625215.37717.9592144816249092137.stgit@donald.themaw.net>
 <YrtAqQoyFG/6Y4un@ZenIV> <e2c566f9-47e4-cfdc-ad4a-426ecdfb16e4@themaw.net>
In-Reply-To: <e2c566f9-47e4-cfdc-ad4a-426ecdfb16e4@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 29/6/22 09:06, Ian Kent wrote:
>
> On 29/6/22 01:55, Al Viro wrote:
>> On Tue, Jun 28, 2022 at 08:30:52AM +0800, Ian Kent wrote:
>>> Parsing an fs string that has zero length should result in the 
>>> parameter
>>> being set to NULL so that downstream processing handles it correctly.
>>> For example, the proc mount table processing should print "(none)" in
>>> this case to preserve mount record field count, but if the value points
>>> to the NULL string this doesn't happen.
>>     Hmmm...  And what happens if you feed that to ->parse_param(), which
>> calls fs_parse(), which decides that param->key looks like a name of 
>> e.g.
>> u32 option and calls fs_param_is_u32() to see what's what?  OOPS is a 
>> form
>> of rejection, I suppose, but...
>
> Oh ... yes, would you be ok with an update that moves the
>
> "param.type = fs_value_is_string;" inside the above else
>
> clause?

Looks like I'll need to use a type other than fs_value_is_string

so I can identify the case in those conversion functions when

there's no value for the parameter.


I'm tempted to use fs_value_is_flag since it's already present but

a new type of fs_value_is_empty is probably better.


What do you think about doing it like this and that type naming too?


Ian

