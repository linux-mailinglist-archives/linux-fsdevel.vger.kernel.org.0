Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C25A7153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiH3XC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH3XCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:02:25 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178F194EE8
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 16:02:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6D15F320046E;
        Tue, 30 Aug 2022 19:02:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 30 Aug 2022 19:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1661900538; x=
        1661986938; bh=FAoFi3hwBHOiUW2nBoAPQnw2f0ldWXGjO1yYq/Qibu8=; b=a
        tOaDeI+zKOsR/4ivZ8vYguRw/IK2VHxeq/PDeljtuz4LmKmVjDQckmT2T5NL61Zj
        W+m4/2V7/ZuArCxFqHFMLGChK9LHTomprmdGMLK8AVem5s+JJfSUdMYYhJllYW46
        zFjHUtyZctvQJOfwOVz/KcgL3wwEwMW6IdyvD74DHlUq2B7pfI32As1jHgkMo40Y
        4QykVgfy2Ihaj7+nFnodNdjAzREEQJYyVm7vxLjjHByR8SlHeRrbxrJj/Eor92f2
        bPZ89FNBOTonhlmNe8bCnTrt17ZPMulaFQ1NoCpzCuOhnvnd5C4f8oc+WkS3DLoF
        /NKlQEQDt6EBgqVqZFz4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1661900538; x=1661986938; bh=F
        AoFi3hwBHOiUW2nBoAPQnw2f0ldWXGjO1yYq/Qibu8=; b=P7V47ltpe6RKcNxcF
        moF5hTSa7UPuKrp/mydPaEHgr+fzuN3jD25OenR6rFAwNEy0mYheS2tPwgT2n37y
        XSWxiTRuNQOqUzhu2i8bCn0TGAd9R+xld9M8u7KROKqhENxJDoO42uUSqD9qx2aI
        nGq37v2eEBXC3JqnS5Pt33bpUftL3Eidd56ARWiOCRhhL6m6APho9vnK2vm0iMyb
        xvmDtit6IqJN6380PIL65WOsjnfAkTfdrT+sgG1AB/U5aELb3TM0unbgROG5SFTO
        wdW6rlxrP0kHZ/G+iq+utRo78whZrHd5CRbpcWZ0lb+jsmxXv7YZNO4L+vSxuRmw
        8gHaQ==
X-ME-Sender: <xms:-pYOYwDhe6dDsyt23467nUdEOjS5UC9nQj56EaDy4DTFg5wmL9hq6w>
    <xme:-pYOYyjp2k9U3JihM6Y3wR-rlkERS8tAGOrlLlH9NoUYuFdiclQM4af2T9bb_UQu3
    RfYlAdNl-wI0BK5>
X-ME-Received: <xmr:-pYOYzmO70WkRZ3Ix32rIe922bEIuW2c1QYlqAn9AAJWon8OwnS_gvwew34U3WAkhe0-FrmkaKXFWgTtKOUBo9MzT-_CFGNGwrutqxOJsq_g3me_U5hG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpefhiedtvdffkeelkedtkefhhedtgeetjeekgedv
    gfekteffhfefkedvleduueeuveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhnrg
    hrkhhivhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:-pYOY2wwNtBf_hM7ZCkoy7HrLgya_0oSvYnOWV7yBlWubPaGYjjmTg>
    <xmx:-pYOY1RqZ94loBuoGouUXBW6LmGgy9POf3Qhd8611yaD4FrTmxOffg>
    <xmx:-pYOYxZa5vkKp3oOiBhb3wUJRu7AYjxKqzttTI3IkQRmoGhhYQ6pUA>
    <xmx:-pYOYwfuTS18SXrkgus-YqEkCnuuS0EKda7Swb94ecgEAbLLh8wS0g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Aug 2022 19:02:18 -0400 (EDT)
Message-ID: <f7110017-8606-8e50-7d86-fc53324a571d@fastmail.fm>
Date:   Wed, 31 Aug 2022 01:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: Why do NBD requests prevent hibernation, and FUSE requests do
 not?
To:     nbd@other.debian.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Wouter Verhelst <w@uter.be>
References: <87k06qb5to.fsf@vostro.rath.org>
Content-Language: de-CH
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <87k06qb5to.fsf@vostro.rath.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/30/22 08:31, Nikolaus Rath wrote:
> Hello,
> 
> I am comparing the behavior of FUSE and NBD when attempting to hibernate
> the system.
> 
> FUSE seems to be mostly compatible, I am able to suspend the system even
> when there is ongoing I/O on the fuse filesystem.
> 

....

> 
> As far as I can tell, the problem is that while an NBD request is
> pending, the atsk that waits for the result (in this case *rsync*) is
> refusing to freeze. This happens even when setting a 5 minute timeout
> for freezing (which is more than enough time for the NBD request to
> complete), so I suspect that the NBD server task (in this case nbdkit)
> has already been frozen and is thus unable to make progress.
> 
> However, I do not understand why the same is not happening for FUSE
> (with FUSE requests being stuck because the FUSE daemon is already
> frozen). Was I just very lucky in my tests? Or are tasks waiting for
> FUSE request in a different kind of state? Or is NBD a red-herring here,
> and the real trouble is with ZFS?
> 
> It would be great if someone  could shed some light on what's going on.

I guess it is a generic issue also affecting fuse, see this patch

https://lore.kernel.org/lkml/20220511013057.245827-1-dlunev@chromium.org/

A bit down the thread you can find a reference to this ancient patch

https://linux-kernel.vger.kernel.narkive.com/UeBWfN1V/patch-fuse-make-fuse-daemon-frozen-along-with-kernel-threads

I had also asked about NFS when the server side is down, (and so a 
request reply will not come) but didn't get an answer.


- Bernd
