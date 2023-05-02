Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A56F3E73
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjEBHhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 03:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjEBHhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 03:37:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90749F8
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 00:37:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 308005C0231;
        Tue,  2 May 2023 03:37:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 May 2023 03:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683013071; x=1683099471; bh=N5D51x02atDA8ao1QjnAlT3mY0aScBY+//0
        AiRoDkq0=; b=Jih2pr3gTd6dMSvgYScbYvth2GJsyXGi5bX7i7UQf6weDgamU55
        CZHlfxvlWgIhSGqKAcRpmXDOC2eoBuAG3/dXFIyTu+x8rT4ikn3brLLxzond7T78
        LlEvuCOrySfL4vkpq264HV7bq3kF6XSG8C9HwHlCvyIvKJ+TshM2ICa706lwPLkP
        Dyp1CfGKmWFNuJBZ9aej8Ox3EkAZcN2nMdPGJtEXID/INITGolwl1e76qk5Sp5Xd
        N+bn8q8mX9PmGHD++hJQdfKqNYm/LS+vfcYQpHmPqEqTwIT6E8+X/fDwiH4xL9XH
        HgwVnzgfrbcNFwwz0xVva8kxwUvjOd8uNHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683013071; x=1683099471; bh=N5D51x02atDA8ao1QjnAlT3mY0aScBY+//0
        AiRoDkq0=; b=ZFYlPQ80SSqVXZkaTvtbOCvn/XHbG45kTOmO5XOqbxdnOG6A/dD
        0PVANUSNIUdfoy1SvOuizpWYMuegpy8JtQ6byJiNAc1ereUAAebGqsYhFD8PHGtB
        RuRkpYocpsT2b4Cfyo/rTz/r1v1WTKQRxdzYGyyVQxmO39wMUdj8riRD7aahwT2v
        H4F7Ug2LSycZjjpJTTPgKbpjorsPjJs9YZw01lq0z+lWtGhdtbuhdguklVZMBnhN
        LBLVbhNzCuD3rZAInD8IEise5w6nGIuAhG3Qb1dslzPkSzAOymIUow7TyTEN1k6I
        97LeqX1Kibzw7zoKbOKk70c/cr6Fr90zRVg==
X-ME-Sender: <xms:zr1QZDOAE6IEwslIRDvqa3WZUNz60kJfZRxrwleCsP9D56zxFzpwYQ>
    <xme:zr1QZN-DdTiufijXQZrFPnWEoFeCQcaVGYDWKUONSSeqDxN23bJ33aoBHOP8hQ9JR
    Y5JFM_WsB6dmEGu>
X-ME-Received: <xmr:zr1QZCTYd4m4JqKXCU6TIMyisg5WO9Eub6LI-MjaRtRefeCW9JPxOMhYXZ_Lp2lgrvVZJjU4b6WtgcU2tJR8WikXuxvDlkfAgQBbTEjyXlxwxbYvmSOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvhedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudej
    jeeiheehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:zr1QZHvLSvLApHlUXdekRlndJV_MfRR5JS9rf9vUK_RoP8B7vaqqYg>
    <xmx:zr1QZLfpUNgv7lddzyXLFjpI0O8dP-YPntY_KtmQ_5gdZ9waanMIfw>
    <xmx:zr1QZD2JCHRru36vz6F3iNPfKUtmL4sh-g8-jzaqZOfz-ahQpu4jng>
    <xmx:z71QZH75z-DcFryfwPj1jATUU5bZyETb1vavLPVPzjiDtfbL_pV5KA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 03:37:49 -0400 (EDT)
Message-ID: <45ad47ae-5471-3d44-d3d6-2760dee0945d@fastmail.fm>
Date:   Tue, 2 May 2023 09:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC] FUSE: add another flag to support shared mmap in
 FOPEN_DIRECT_IO mode
To:     Hao Xu <hao.xu@linux.dev>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        miklos@szeredi.hu
Cc:     Antonio SJ Musumeci <trapexit@spawn.link>,
        linux-fsdevel@vger.kernel.org
References: <5683716d-9b1d-83d6-9dd1-a7ad3d05cbb1@linux.dev>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <5683716d-9b1d-83d6-9dd1-a7ad3d05cbb1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hao,

On 5/2/23 09:28, Hao Xu wrote:
> Hi all,
> 
>  From discussion with Bernd, I get that FOPEN_DIRECT_IO is designed for 
> those user cases where users want strong coherency like network 
> filesystems, where one server serves multiple remote clients. And thus 
> shared mmap is disabled since local page cache existence breaks this 
> kind of coherency.
> 
> But here our use case is one virtiofs daemon serve one guest vm, We use 
> FOPEN_DIRECT_IO to reduce memory footprint not for coherency. So we 
> expect shared mmap works in this case. Here I suggest/am implementing 
> adding another flag to indicate this kind of cases----use 
> FOPEN_DIRECT_IO not for coherency----so that shared mmap works.

Yeah it should work, but I think what you want is "DAX" - can you try to 
enable it?

fuse_i.h:	FUSE_DAX_ALWAYS,	/* "-o dax=always" */
fuse_i.h:	FUSE_DAX_NEVER,		/* "-o dax=never" */
fuse_i.h:	FUSE_DAX_INODE_USER,	/* "-o dax=inode" */



Hope it helps,
Bernd
