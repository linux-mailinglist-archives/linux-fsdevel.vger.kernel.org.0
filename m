Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4957919EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbjIDOpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbjIDOpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:45:24 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F4CFB;
        Mon,  4 Sep 2023 07:45:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B71963200913;
        Mon,  4 Sep 2023 10:45:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Sep 2023 10:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693838716; x=1693925116; bh=UXbFDq1oZDIMG9Mkcwavte+MHov3QwCgv8a
        c7QV3jZM=; b=OROO0sbUJhxt7X9b456JaNaDhJX4Jc3bQLBw6dYNnv61IC3nRNZ
        VY+I4UqWTQOfpj5gJASRJCoiF6NoN6LegZxZvXVIS19BI6vlEqFpiDDxjMxBuk8E
        HiBfJ5NZUdso695NoN4gA5Xq6TdnJGgpyDMGYkLPnfGQMcaL7F2hmoi2EbvOViWU
        EUuzXgTr+2ur59mMo9z4VR9TT1l9Mt+zuAhLDZHr5ZehiNWkUfj2LgWM+dWvzZn/
        YPx/6GfYkaeeOzi8o0xYteLt5MScfI1DWQMy/LoZHzW4WY2uFmAzWmf1OAsQoBgE
        M0ortEhcRo4gu7VHjgsstqL2y1UCgH3WKgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693838716; x=1693925116; bh=UXbFDq1oZDIMG9Mkcwavte+MHov3QwCgv8a
        c7QV3jZM=; b=rjZlC68E5wZiLPToh9DU61asKPr6I4EuL6FRGw7z6Uoqw1Ucg6c
        W7VMWXabKysxOWBoR9L8DEA0Kn83vhJixJa6IyqXWH6QCcFlCiccCpQ4wRmOS1Ac
        0xIQS4FSpw2rVl0VlufH2yzhrv4vrQ/SNSwP10halPnVby56r+/hXTxIsHReAwMc
        wOKXnfwjuIUFkYhXbyG7fx/EQS5I3DUvLI37SAcvrpWRqRG9wHyXY3j447a2HbkI
        G+AG8a88H8FLV3MXwcvOfYUz1LocYN4Z1+b3oGQLnAs47azmLJqn3xcXjAd1hjsP
        fcnyZTt4zHBov5toiSjni/vD2J9Jj9WqdWg==
X-ME-Sender: <xms:fO31ZFgmdwfxaPK-Tu-hYbwb6kh7LmUd5nj6kSHDlWrpE-WXq3Tqqg>
    <xme:fO31ZKB_RCsS0GK_4506__73IwNG8S2jLDFWv0wktphS1Yo4HAoV6f2_UpwaztW2u
    UaZLba0vcDf5Wbg>
X-ME-Received: <xmr:fO31ZFFvtFVJiWcyPEsyh58fiozf-kArB_MzdzkFCSvVE46WuK3enrsGUrObwNwvRr2puzwpNlBBaPdB3nURh7aynh-4gSgk6Uo_qvsVV9CXMEk3ETbN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegkedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:fO31ZKSXZbvdY0WEvmjEBGxd0Ezh4BmYN5wXXaOanGSCA6ZeZBGxFA>
    <xmx:fO31ZCyt8k_aryUfIZJ51NiD_Wz4D9bHqlPwEbUW4eqk015T1EZmhg>
    <xmx:fO31ZA7gX18624EIFkUQRFd5tI7SenWnGv1shNNFijFPrJeEuDTNyQ>
    <xmx:fO31ZJq3Hm_PbQxiZn0_miQf3LZS1fYJoIOAe4cGE_wPtYF2UjzhKA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Sep 2023 10:45:15 -0400 (EDT)
Message-ID: <5d7b63eb-d2be-d089-48eb-ac2f3d698f8d@fastmail.fm>
Date:   Mon, 4 Sep 2023 16:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RESEND PATCH] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
To:     =?UTF-8?Q?Andr=c3=a9_Draszik?= <andre.draszik@linaro.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
References: <20230904133321.104584-1-git@andred.net>
 <CAJfpegtSEjO9yi6ccG1KNi+C73xFuECnpo1DQsD9E5QhttwoRA@mail.gmail.com>
 <10e2fc00466d3e5fc8142139ee979a71872292e6.camel@linaro.org>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <10e2fc00466d3e5fc8142139ee979a71872292e6.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/4/23 16:21, André Draszik wrote:
> On Mon, 2023-09-04 at 15:41 +0200, Miklos Szeredi wrote:
>> On Mon, 4 Sept 2023 at 15:34, André Draszik <git@andred.net> wrote:
>>>
>>> From: André Draszik <andre.draszik@linaro.org>
>>>
>>> This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
>>>
>>> This patch breaks all existing userspace by requiring updates as
>>> mentioned in the commit message, which is not allowed.
>>
>> It might break something, but you need to tell us what that is, please.
> 
> In my case, it's Android.
> 
> More generally this breaks all user-spaces that haven't been updated. Not
> breaking user-space is one of the top rules the kernel has, if not the topmost.


Hmm, I guess Android is using one of the extended flags in the mean time.
Do you have more data what exactly fails? I had posted this patch last year,
when it was still rather early introduction of FUSE_INIT_EXT, hoping there was
nothing in production yet using these flags. But virtiofsd was already using it,
so the patch got delayed (I had actually assumed it would just get dropped).


Sorry for the trouble!


Bernd
