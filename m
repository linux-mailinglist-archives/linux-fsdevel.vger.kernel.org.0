Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC577AA2C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjIUVe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjIUVeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:34:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8355A023;
        Thu, 21 Sep 2023 10:20:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B8D55C018C;
        Thu, 21 Sep 2023 08:36:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Sep 2023 08:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695299763; x=1695386163; bh=rfl8F4CyNg3EmdUb8W4wwAH01ChxlJcbD3i
        dNI4QWvg=; b=CLqK/AzUzlihIUEIkRgqLCdvU8tzTIpAOMw5hKZhxE01Ge51xg2
        2jCOE9K9QR6N6ztyc/j1IUTWivE81Sb76k76zGPK+OlFaGSQUK7g459EL0mvtzV9
        De84R3Aq6eyiIR3obtPlzrgGqgbU9nzaQ1jc+vA3xa5eWQgf6nDwQHYHTiMmZLvY
        w8r4EXIcolN6vknBc0GGhNtmcSuX1CqVLzUO8BRlr45cMMkw0pJ+huyP6jkOJ/wy
        KRZC9F/Ck7fi9CB3WSXoGvA7PpldGPUIogFya/mJXYBwEBLzwA5ZVX/9YMyPtZd8
        2iAIHEVUnynDhjmPR2dp3Q6mO3wRGEUzEZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695299763; x=1695386163; bh=rfl8F4CyNg3EmdUb8W4wwAH01ChxlJcbD3i
        dNI4QWvg=; b=lrJvS4taD7NXi0UngiiQWgJPZG/9nl1RR4Zm568zJy4dKiKUdwg
        GnGIAKZcRi6uy8MwejlGFToZREYG0qfAEBWVD3KXym7s7kQ898i1ERDHd/HJ5KFK
        VtUKJSiVbmGiq/6m6ImrPpFydTkgw0kA79Dbf/52ewGWKB8BUsHhoUQetI2vEtCo
        cwsnew5CHFvKKU1ymcYt3DuksV+eWVULeU3/JeUOPTbd1cmLUZgzDJIMardnRtmr
        HEorNcoQBuArlGPdkZnVlzFZHy4YyD/y1VnBjHvaZNWuJ9GJyYH7tzdsztPguEuz
        PM7OSYvmub+E4xGiSM5znbNf/w9zN0du3Bg==
X-ME-Sender: <xms:szgMZerFD3cDdzbMpqdWkeBo_o4GjwGsiaiFw0_ovlYLssYO1oO8xQ>
    <xme:szgMZcqcNYUMYA75wjJAdJdYr91_9igGKS7weGVGCG_J6QNlD-PAcHeu3HPOjlY6K
    auquRheKJIO>
X-ME-Received: <xmr:szgMZTOWSZBOicA-4Z3GL_tie9c2zfn6SSTN6DZK3SJT3ajfmzD7DnV6U_9tAeELpHk8uAEntHcfnb3zHeKa5vxQ9OM-xQ52xByUUrjDVmBfPp0oWtQK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:szgMZd4xLoISHGLy4q-1FvPtPHzJ76hIxbRdY_rzPx1dUArKGOMgXQ>
    <xmx:szgMZd5zZKfKY6FcEqR9gfbKnSZ2k5uRGUJKM9DkiXtSK9fWQ0dgZA>
    <xmx:szgMZdhlbVuvE6wcaIpPCZj_Tje7ahxZ3cAIO0wYbilLkJdhVnWfKg>
    <xmx:szgMZbRcg-V4gVaPPSxuDkVT8thJyJmeK7USR1ZFRDlv65ldCatUsA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 08:35:59 -0400 (EDT)
Message-ID: <df932642-4c78-768d-2f6d-aaa9ae960c8f@themaw.net>
Date:   Thu, 21 Sep 2023 20:35:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/8] autofs - convert to to use mount api
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
 <20230921-altpapier-knien-1dd29cd78a2f@brauner>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230921-altpapier-knien-1dd29cd78a2f@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 21/9/23 17:13, Christian Brauner wrote:
> On Thu, Sep 21, 2023 at 03:03:26PM +0800, Ian Kent wrote:
>> There was a patch from David Howells to convert autofs to use the mount
>> api but it was never merged.
>>
>> I have taken David's patch and refactored it to make the change easier
>> to review in the hope of having it merged.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> ---
>>
>> Ian Kent (8):
>>        autofs: refactor autofs_prepare_pipe()
>>        autofs: add autofs_parse_fd()
>>        autofs - refactor super block info init
>>        autofs: reformat 0pt enum declaration
>>        autofs: refactor parse_options()
>>        autofs: validate protocol version
>>        autofs: convert autofs to use the new mount api
>>        autofs: fix protocol sub version setting
>>
> Yeah sure, but I only see 4 patches on the list? Is my setup broken or
> did you accidently forget to send some patches?

Sorry, but no, my email has gone very pair shaped.


The above send failed part way through and I haven't been able to send

anything via the command line since. I'm guessing the email app I'm

using to send this will work and the other email accounts I use will

probably work from an app too but the command line is broken for some

unknown reason.


Please ignore these, I'll send them when I can get my problem fixed ...

*sigh*!


Ian

