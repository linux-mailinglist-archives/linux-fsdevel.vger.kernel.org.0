Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5E614578
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 09:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKAIJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiKAIJf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:09:35 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF0BC3E;
        Tue,  1 Nov 2022 01:09:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A671E5C0183;
        Tue,  1 Nov 2022 04:09:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 01 Nov 2022 04:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1667290174; x=
        1667376574; bh=fZsEJ7wi+HahAReChxV3837nUT/qrncYmj4vJFyeKis=; b=K
        FjRkr3OgjHGn+kMfurwKA4uzcb9nYif4iQjCfCcmUuut4Lwp78yZwlTgt67Y2Koh
        9BTTBap0QdO+ejVgYHYUV5nJbfRvtWo9uTCI1jXt18c3Y9VqHA89SvI/oQs29mjj
        sDDQyAIUrYhQ5Pe8jZylkIeLXjwbCTi/6irBv1EqvBVjSQfbjYJIpm2UZW1mKcor
        HrQELPzNFvxKmqD613/gMVTBDBJUk3JqAl0kNeD6bd5unq3kda/FUUVlpxDoo9j3
        vBJ6Z7f3au60GMHyK4D7kNKhl3yAXd5HaLeMMTlgYSAa7r2c8yxOOOysKOxp9gzp
        3NRAkyjKRyUqwKaKySNtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667290174; x=
        1667376574; bh=fZsEJ7wi+HahAReChxV3837nUT/qrncYmj4vJFyeKis=; b=t
        ss5KYZZHvakKZKa1yr5Qo5ZQfAd23aHXcdzzJc4HbBmDvb/frle9rjvDwExNQ/Fz
        W7bz9z/HgahBlqN6Obzo+6fvMtuBLgoCgTd3QHyTI8BuFRFuPb1UrOuKk/AMwh+q
        QIlKePG75K5bPqC9nYx0TGaIFkWQB+eGJCeI1R/P6n2QxwPPUDXB2msnhOo7qzLm
        SvDLEnCRXNwcpJaiVU54FseDVaqt4Lc6tHqIB0pG75j1tsAlY/9VOY+5Uzh+U8+2
        IQ7KuD3YklEqJpB911bYhVQjoys/SRNs5KtnaylGx1gQSDjo4efFjXoz56uhRaPK
        5CXomR462GZ3g1aJxqMog==
X-ME-Sender: <xms:PdRgY6juQeEb7KizJHU_nBYb2GYa70ifiFPxe-aHPTleu80J_6KMXQ>
    <xme:PdRgY7CpUyBYrsX6-GYWFFJWa6_aaSKxZRwHnnjSJ22Rmc2TqhEkaKCjrSbeglfoj
    hUBwDfFjQe5>
X-ME-Received: <xmr:PdRgYyG4s_Pthm7LIW50GJXeyolSp5rqsx9pHCMIwjdR2YQTd6YLAG2SEDEncmR7RHBFbChhrFH5SAys7i8sBVeCPx82Bavm6SqphXZ1w2H_H7OcXvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudeggdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:PdRgYzR4QtzV5XXdJormcSgi5QF3EFeN6Td1oy0i4qfYzC4PrFLt0A>
    <xmx:PdRgY3yqf6SGsCjiovyyK9NZdTyXxlmsk1peCX7KBmh0ZmrzoguLQQ>
    <xmx:PdRgYx6bvfARGEDqUveKCD02xtn3Y7EhDhD-OmSfSq9pzotGMECnOg>
    <xmx:PtRgY_cNdob1-8Wuxq9cxYhZZvGtXS1fPivhgcUjwob-5GcDtO7Phg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Nov 2022 04:09:29 -0400 (EDT)
Message-ID: <5fd7f78e-4b8f-1dd4-5b3c-e2c3583b9e9d@themaw.net>
Date:   Tue, 1 Nov 2022 16:09:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] kernfs: dont take i_lock on revalidate
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036967.13363.9336408133975631967.stgit@donald.themaw.net>
 <CAOQ4uxjiEbHwT7M1GhPb_GFn-oiuvqwS1aOw7N9N8cu5jam5Yw@mail.gmail.com>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAOQ4uxjiEbHwT7M1GhPb_GFn-oiuvqwS1aOw7N9N8cu5jam5Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/11/22 15:46, Amir Goldstein wrote:
> On Tue, Oct 18, 2022 at 5:58 AM Ian Kent <raven@themaw.net> wrote:
>> In kernfs_dop_revalidate() when the passed in dentry is negative the
>> dentry directory is checked to see if it has changed and if so the
>> negative dentry is discarded so it can refreshed. During this check
>> the dentry inode i_lock is taken to mitigate against a possible
>> concurrent rename.
>>
>> But if it's racing with a rename, becuase the dentry is negative, it
>> can't be the source it must be the target and it must be going to do
>> a d_move() otherwise the rename will return an error.
>>
>> In this case the parent dentry of the target will not change, it will
>> be the same over the d_move(), only the source dentry parent may change
>> so the inode i_lock isn't needed.
> You meant d_lock.
> Same for the commit title.

Ha, well how do you like that, such an obvious mistake, how

did I not see it?


Not sure what to do about it now though ...

Any suggestions anyone?


Ian


