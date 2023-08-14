Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D477BA73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 15:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHNNoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjHNNor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:44:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADBE54;
        Mon, 14 Aug 2023 06:44:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 715135C00E0;
        Mon, 14 Aug 2023 09:44:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Aug 2023 09:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692020686; x=1692107086; bh=ai7XWqBGUdniAkqv0bcRnyO+vIQGfDDb1O+
        pQtyLUcU=; b=gDc8zgbSY4hrwYIWF+zBrO9lseReBoT/MYr2sCx0Szu9d+VIEQe
        9lxEN75Xx6x6v8BZJwoBGxLqVuZQ1o4L650lZ47/FzN7EI+EFQRbaOz8w75SyXHB
        PFVjZN2IKr42q7mp0yCT2yfwTSQE7QsfH2XKKi4GAB0GNc3dgb1MdrxpOHSoJ/VN
        brBq0Ts7xoqxfH4JW+WCA+nD5DzmLfQoRRX5PxQdOU8buQu0mn6I7IRgXY3/wtWP
        95AtW21RIDUkI+u6jYoZiT9IOfCWa7Hvh/0bDYQrliTqdiVyK+0RBDpde3EQedjo
        olmsdO140H7BRIf2u+3chXooCqdGuvuRTiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692020686; x=1692107086; bh=ai7XWqBGUdniAkqv0bcRnyO+vIQGfDDb1O+
        pQtyLUcU=; b=boolcNWQhRBQCKbPugiqPuF42wdD5u4jmPOZh8+TyXVOWgGWnEV
        /lWn7eFyUm4t8QeSMwTw8V5k2JkjG5UCzFVX/kEAQEu9+hcSMpI+pFTJ311dzJ2c
        YPRz7WQJAT1+H6a3muUUkvZd1KpKm1c6MiIgA9z9RP4tre23xHLIX4WOiKYJ4mH2
        LRh/7GecSWxtrb59s60sb9SbyDn72znCJVlDCR43l0nHVBmbOgP2ViDW3V89Dg2G
        UG3YEJdGq9gkgfTg9ISf+0bHmS78Sj6dyYjq078+QqJZLTVuimwGaie80YDhomeP
        IitzA9YLPq8nYRid2nLhoTMlfPZ79CLmOrg==
X-ME-Sender: <xms:zC_aZLBD6S0bHcIT9rCkQ3GxlmRLUGNbwU-vHDhEKA3Eyl8O63Ljsg>
    <xme:zC_aZBgOWG3cSzNiyeP_vCnF6FK_gNwXTeIeiiRFEm19eAqxVNyd48yt7-6594oRO
    koqfKeeKElYxUfc>
X-ME-Received: <xmr:zC_aZGnop3DrKLn7huQlAbxk-QSQmnZ1egi3kXqD1rSxA9f-K8ui0juiSRvh6i1vgIV3hT-RvhEQLC0qg8d6rj6xSkGWfcSELmF11GqrVk75FUhUDN_6SGcS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:zC_aZNy2-2VbPfxwmpBvFW8XZRGEWLkiPa04R4NfSVXfl9CYSgWGlQ>
    <xmx:zC_aZARIiilx1VvLhfiPalxOdJc8emCUS-ywIEyRtmoRaWuYtBkU7w>
    <xmx:zC_aZAbeKknTb34myofPimtGtPNPMD7gsTYZokYlrQAGatcnSW0ewA>
    <xmx:zi_aZFIxeCMT8cGKKcSHVJ3Rw8eUKEPxsl48QErdd2Iuz76hzKLuLg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 09:44:43 -0400 (EDT)
Message-ID: <3a49282f-7d57-2756-fc20-54bc3f53a80d@fastmail.fm>
Date:   Mon, 14 Aug 2023 15:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async
 fuse_flush
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?J=c3=bcrg_Billeter?= <j@bitron.ch>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com>
 <da17987a-b096-9ebb-f058-8eb91f15b560@fastmail.fm>
 <CAJfpegtUVUDac5_Y7BMJvCHfeicJkNxca2hO1crQjCNFoM54Lg@mail.gmail.com>
 <e7499d0942a4489086c803dcdf1a5bb4317e973e.camel@bitron.ch>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <e7499d0942a4489086c803dcdf1a5bb4317e973e.camel@bitron.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/14/23 14:38, Jürg Billeter wrote:
> On Mon, 2023-08-14 at 14:28 +0200, Miklos Szeredi wrote:
>> On Mon, 14 Aug 2023 at 14:07, Bernd Schubert
>>> fuse: Avoid flush for O_RDONLY
>>>
>>> From: Bernd Schubert <bschubert@ddn.com>
>>>
>>> A file opened in read-only moded does not have data to be
>>> flushed, so no need to send flush at all.
>>>
>>> This also mitigates -EBUSY for executables, which is due to
>>> async flush with commit 5a8bee63b1.
>>
>> Does it?  If I read the bug report correctly, it's the write case that
>> causes EBUSY.
> 
> Indeed, I see this when trying to execute a file after a process wrote
> to (created) that file. As far as I can tell, `ETXTBSY` can't happen on
> exec without the file being opened for writing and thus, I don't see
> this patch mitigating this bug.

Sorry, my fault, I should have read your message/report more carefully.


Bernd
