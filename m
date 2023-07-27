Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF32765C43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 21:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjG0TnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjG0TnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:43:05 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31F32D7D;
        Thu, 27 Jul 2023 12:43:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 03C38320091E;
        Thu, 27 Jul 2023 15:43:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Jul 2023 15:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1690486983; x=1690573383; bh=49GR1k6Q08NLQKKVbLSRij8vwYLRr8VLzRz
        3qgnQVpc=; b=eIMzuhw6lN9NwSNoBm7Du3VBvSeQSO5QM9OW5QRbTtzBUBbma/8
        fPiet+TrvPwIkt522wvsB4bFABaN1HZvoLDDS/MYWQutbQnboUEH6pu/vE9suU73
        QNqV5fnCW+32Q/H1rGaR9dgdA+f9jYeaRUNVcE5pIDr9QwVHESYzUibG7oJC3q8v
        HYI1iFbBB2qlOvqyAlPViJuzt8bCd6MhZ/TpMQDGDl0rH20JHStJNxr0BuQU2ruM
        Lt5QGqbbuler97ftkORl/G1fwbfcNBuNleqMHv0nz/yurl3WiMlS3udbRUqnQdFf
        pGnQNiqxIUcRe7w1fWFFD8gfAfErkXqqbTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690486983; x=1690573383; bh=49GR1k6Q08NLQKKVbLSRij8vwYLRr8VLzRz
        3qgnQVpc=; b=q9UEBRDEAABBwCD8WqIqejtPNSINKEkcU6i087uLni5AZxJaoOB
        Aj39qXFZWm7BQwJ0xdk31Xz76TVeN40vAfSlujbTNjJRBz+vlp61zYHHg50tuB7c
        wMb+YMpkZN+o3GTBeG7PZt8rNVTSnj38wlQqjjFhMf/sq/RgBYyi5irQh7cqYAui
        k8zUQo1wGtcwTvdU7Cic07csM0VTno1SklnnORnh8TKG9/siogEFfjgkLvXXzSfh
        HCp+k2uTSLE0E8yY/hqD781aRH53aLp6tStPQ7Clrvd53RJobEuqGnrNXJNqNx82
        UPDQAAKVrWqKp1eIaGo/zzgWuyfvOWwBn6g==
X-ME-Sender: <xms:x8jCZJ_kbvxpapkAuV4-k1Q2duQwoxt1TdG11OeXPl5G-OJG_B_cSg>
    <xme:x8jCZNtNKAlsGcGKifdqsZMBB7b51M7ThTA4IwpnpKddpLYMI-pYL041J0JKbvjhH
    uYwFJhJXCEzNElI>
X-ME-Received: <xmr:x8jCZHBAYMPEXGefkkOUFRxoq34lDenX7HQBQD5z9gC87DJ58yluD1ghn2Q3E1Q9Sw1naEv_gmVLDw9PorBXG1xlVuhzbZpM-BAyIM4eg0xd66Mt-cvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieeggdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredt
    tdefjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthh
    husggvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeel
    keekjefhheegfedtffduudejjeeiheehudeuleelgefhueekfeevudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgs
    vghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:x8jCZNd7A3Y53OoIAw913pKFAWl71lZP5PqOjwUJzUVIiM4She_Wjw>
    <xmx:x8jCZOOoNjn4vsj3A3MrkOEwCq3QCfyWcSA-jWZZW9PXiGRqgalkPg>
    <xmx:x8jCZPl2LIQ1s906Ndz6OMUMU3iFmx83DoEklXG17ndGUW_e1bhDnw>
    <xmx:x8jCZLpiRWZRqDmQq4gykMbheX-XCHTTEWLs6vwZm9a8lVxbhH0dTg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Jul 2023 15:43:02 -0400 (EDT)
Message-ID: <21fff874-d4ed-1781-32a6-06f154a4bc99@fastmail.fm>
Date:   Thu, 27 Jul 2023 21:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>, Jaco Kroon <jaco@uls.co.za>
Cc:     Antonio SJ Musumeci <trapexit@spawn.link>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726105953.843-1-jaco@uls.co.za>
 <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
 <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za>
 <0731f4b9-cd4e-2cb3-43ba-c74d238b824f@fastmail.fm>
 <831e5a03-7126-3d45-2137-49c1a25769df@spawn.link>
 <27875beb-bd1c-0087-ac4c-420a9d92a5a9@uls.co.za>
 <CAJfpegtaxHu2RCqStSFyGzEUrQx-cpuQaCCxiB-F6YmBEvNiJw@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtaxHu2RCqStSFyGzEUrQx-cpuQaCCxiB-F6YmBEvNiJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/27/23 21:21, Miklos Szeredi wrote:
> On Wed, 26 Jul 2023 at 20:40, Jaco Kroon <jaco@uls.co.za> wrote:
> 
>> Will look into FUSE_INIT.  The FUSE_INIT as I understand from what I've
>> read has some expansion constraints or the structure is somehow
>> negotiated.  Older clients in other words that's not aware of the option
>> will follow some default.  For backwards compatibility that default
>> should probably be 1 page.  For performance reasons it makes sense that
>> this limit be larger.
> 
> Yes, might need this for backward compatibility.  But perhaps a
> feature flag is enough and the readdir buf can be limited to
> fc->max_read.

fc->max_read is set by default to ~0 and only set to something else when 
the max_read mount option is given? So typically that is a large value 
(UINT_MAX)?


Thanks,
Bernd
