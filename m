Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23067A7625
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjITImW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjITImS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:42:18 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00EA11A
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:42:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 339395C00EA;
        Wed, 20 Sep 2023 04:42:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 20 Sep 2023 04:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1695199326; x=1695285726; bh=XR+3qrFIHqb2ApZZK9X664r7zbejEnjdpvP
        LipHTw9Y=; b=qkju0x/rZVobQAkHxLMgoeo3K9ZlV4pptCGCHuY4U9lKQLyehe8
        r+kC+4CxQcRPFMVn3Go5SPjPr+KA/pn2w4qt5PkBzBZdu4t8xyLUF2F2nOQ9WmEZ
        Ck4m4EA9b2n6JGx3qcxlIdf9kogAQL4kVOmGD98racoywRNQIURnHTy47Sa7pKj4
        SlIfJzYKFTEciBjYzXNGcamjc+dL0hswPtCbHG/s01ZHZNMNWgyodr34Nh2LUixC
        GooR4Ul2OcxZNJzkEFQio/Nc2TdHJKk6FqepJrw07EfP4gbDU0CPD8VLLaUIPsMA
        A6oJmJh6tPux5x5bCKwCxAGT8mv+O/qXOxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695199326; x=1695285726; bh=XR+3qrFIHqb2ApZZK9X664r7zbejEnjdpvP
        LipHTw9Y=; b=lB8HO79hc/RyaMqnt9TrVgL1+vRjC93cbMtU0Q+LdcM8lZj11s9
        rmedeIHlbzvspV66p/TuBreGXNGMQC7SpT0xbn7jxcnkOeyQefrLKwhGJc5Vni4D
        mdQSPwLixgdjRw4qrLlrSKHEt/RUefh0Q6+0IdEuq25XC3jbdxHBRlnJP0Aa8Nd4
        K4mbmW8TT8dMslNZRNaH+7LUuGDk7JtvtHJWm+HM61BI6Ji22VlnUMo+6OJ1kB+3
        gjxYnb/miXwZWkszMceVT50unC3OSgXT8Gy8ebPcACbA3zXNBHvCYFbYOL1NZryD
        cMIf2kTqbPLAaIyLLGYymiq+M2Z6mMrvbYg==
X-ME-Sender: <xms:XbAKZc_nNJfRRu8OZeODQC4OLjgjAxSeD-Nq88BJUy6qAN4zEN2tvg>
    <xme:XbAKZUvJlGbSnuKT0YwLVPhLIZGzpdJOuR43zDYHXH4Ped0GdpC3EqPV5U2qg7Shs
    Zw56cALNbJw6JHM>
X-ME-Received: <xmr:XbAKZSBvt-zrozmKA9RzvypPqwXJ1qs7XHWnIpWM1gSj6c0C0rVTzKXWedgm34yA-JE32vPar74TjnziUwhWt89rm-zHF9Cx0owXyHEYnLZwQc-wVD-2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekfedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:XbAKZcd8VA46MsTKlvykE_dCXF_N6Hn4OkCg9ldA2yHU7BGh-QsWag>
    <xmx:XbAKZROvy9d4UrZkFuqIyv0urY7MTwn2IbyH30ecpdCi7SQqETATTQ>
    <xmx:XbAKZWk5b0EtbLWjja975-uhGH_O5Umxyy7z3U3qcUOJ-7AUN_sXRw>
    <xmx:XrAKZWq0aID0M4FIucbbjuuKcpdY4Gij215WTor4RpJoes2dgvaM5A>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Sep 2023 04:42:04 -0400 (EDT)
Message-ID: <97c002a3-1db9-b7df-e87a-68852a9bc97d@fastmail.fm>
Date:   Wed, 20 Sep 2023 10:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] fuse: Rename DIRECT_IO_{RELAX -> ALLOW_MMAP}
Content-Language: en-US, de-DE
To:     Tyler Fanelli <tfanelli@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     mszeredi@redhat.com, gmaglione@redhat.com, hreitz@redhat.com,
        Hao Xu <howeyxu@tencent.com>
References: <20230920024001.493477-1-tfanelli@redhat.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230920024001.493477-1-tfanelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/20/23 04:39, Tyler Fanelli wrote:
> At the moment, FUSE_INIT's DIRECT_IO_RELAX flag only serves the purpose
> of allowing shared mmap of files opened/created with DIRECT_IO enabled.
> However, it leaves open the possibility of further relaxing the
> DIRECT_IO restrictions (and in-effect, the cache coherency guarantees of
> DIRECT_IO) in the future.
> 
> The DIRECT_IO_ALLOW_MMAP flag leaves no ambiguity of its purpose. It
> only serves to allow shared mmap of DIRECT_IO files, while still
> bypassing the cache on regular reads and writes. The shared mmap is the
> only loosening of the cache policy that can take place with the flag.
> This removes some ambiguity and introduces a more stable flag to be used
> in FUSE_INIT. Furthermore, we can document that to allow shared mmap'ing
> of DIRECT_IO files, a user must enable DIRECT_IO_ALLOW_MMAP.
> 
> Tyler Fanelli (2):
>    fs/fuse: Rename DIRECT_IO_RELAX to DIRECT_IO_ALLOW_MMAP
>    docs/fuse-io: Document the usage of DIRECT_IO_ALLOW_MMAP
> 
>   Documentation/filesystems/fuse-io.rst | 3 ++-
>   fs/fuse/file.c                        | 6 +++---
>   fs/fuse/fuse_i.h                      | 4 ++--
>   fs/fuse/inode.c                       | 6 +++---
>   include/uapi/linux/fuse.h             | 7 +++----
>   5 files changed, 13 insertions(+), 13 deletions(-)
> 

I guess would be good to add Hao (in CC here), as the author and in case 
the flag is already used in production (on an internal kernel version).


Thanks,
Bernd
