Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306877A12FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 03:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjIOBbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 21:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjIOBbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:31:42 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F812100;
        Thu, 14 Sep 2023 18:31:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CCA6B320047A;
        Thu, 14 Sep 2023 21:31:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 14 Sep 2023 21:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694741496; x=1694827896; bh=0JHBCsnC5ZrLuDmlCEBUAWK22MKwJq+tD4g
        Vi2w5PPg=; b=HXWfi0cEUBqQPIYddb9OehCOk3cBKCnsnoYh8PcT4MVUQGSdjy/
        54sPgfa2PYuEg1qf+9cLKCJQ9f5Tp1wadq6kOqNG7abVGE3OwDJux93XWeir1/IA
        QBfINh0scmMe4huDWtncrGPxQzY/NjL5igt71oj7SFMYWUsganjD4Zt0WPFLdqgU
        ZwS0gdAUT2qI7eJmVqCQfSPK4WF4WEojxwHbBG1q+5cHKnMVft5inkpNXmtokQ7j
        eVc9yY9XLsYtXopwOZzTAqlDOXmaLzHgPXfs3yefLuo3O7XehgFWI9Xo4fwHrSEO
        n7CqPshDAfbyZg8KfRaH4IfRm6+bfwUKCiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694741496; x=1694827896; bh=0JHBCsnC5ZrLuDmlCEBUAWK22MKwJq+tD4g
        Vi2w5PPg=; b=Yz9AZEYqFfn+F4huwafWBIZl8zESY2kNxWKeJt05mP6MSr9nE8Q
        GftysHf5gjgMPRpTkbbaEZ5L6eMQVE+2DSl7/Nrb7ez5qnTv7v3klvF2ghuY+vLc
        0v/DWvQeXhCGToVp33hGFqatas4frz6JvmitxcU4voHzysrXQk+ISZsN/tcKQcJf
        5zjbWSd0CyAR4rOmBbkgjYcAzZQt0ZGfv700+Zj0VSeLV5A5hMIaMLizTLikoadq
        ZmzBqGIoXwYlGqpZUzYGtVNOUwM/eNH5GSN4kC3Tu6PH324DQdHmc7jtBaJZ/cOq
        pVBXOkOnIHUZ7TwQVQqWewDjNedf6OZJuNg==
X-ME-Sender: <xms:-LMDZTt1bjkufVhwgbpbtSoOo5WHaqPx6X5rt5fKhXcRos1IzDSJxw>
    <xme:-LMDZUcItTXOnRPIOMBdxWzOFyFgF_1IeQsxethE65P5_SvMBfMh-41ihLsR4u014
    kJUvTl1sdOp>
X-ME-Received: <xmr:-LMDZWyoWK4VBZCtbeWySozszNIzQbMmKpbdf70927aq3yWKPf7JVol1RXxxh45XaWu9kYZYQhVGjvYHkzXnFlZoG9i_hdWyJvBlVopHjUC7vzcpmp9d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:-LMDZSMqhBM8a4-swjZ0ipZOL1zw41CRggIpXhlwx6cI7gvtfPrdCg>
    <xmx:-LMDZT8nqXvtU49d508PJeG_NjhLVTcCSRUudOZ-F8ROv4ppB_aehw>
    <xmx:-LMDZSXsQvHnFqJ3p_1dJv995ci4FJ091teFE61Tz0NFuN4s2QTQTw>
    <xmx:-LMDZSVSMOe1zoa-CuvuX6CUrNpZlbeSYoY1LPF6E83EixhLDFonlQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 21:31:30 -0400 (EDT)
Message-ID: <e4437a13-5cf7-c1bb-351f-b984495ad2bd@themaw.net>
Date:   Fri, 15 Sep 2023 09:31:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/3] add unique mount ID
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-2-mszeredi@redhat.com>
 <20230914-himmel-imposant-546bd73250a8@brauner>
 <CAJfpegv8ZVyyZN7ppSYMD4g8i7rAP1_5UBxzSo869_SKmFhgvw@mail.gmail.com>
 <20230914-jeweiligen-normung-47816c153531@brauner>
 <CAJfpeguJ+H7HkZOgZrJ7VmTY_GhQ5uqueZH+DL9EuEeX5kgXQw@mail.gmail.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAJfpeguJ+H7HkZOgZrJ7VmTY_GhQ5uqueZH+DL9EuEeX5kgXQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/9/23 17:43, Miklos Szeredi wrote:
> On Thu, 14 Sept 2023 at 11:36, Christian Brauner <brauner@kernel.org> wrote:
>>> Yes, one concern is that humans confuse the old and the new ID.
>>>
>>> I also think it makes sense to allow the new interfaces to look up the
>>> mount based on either the old or the new ID.   But I could be wrong
>> Hm, mount id recycling may happen so quickly that for service restarts
>> with a lot of mounts this becomes mostly useless...
> Agreed.  The old ID is mostly useful for human interaction.
>
>>> there, since that might encourage bad code.  Maybe the new interface
>>> should only use take the new ID, which means no mixed use of
>>> /proc/$$/mountinfo and statmnt/listmnt.
>> ... so I think that is indeed the better way of doing things. There's no
>> need to encourage userspace to mix both identifiers.
> Okay.

I think having both is leaving more opportunity for confusion and the new

mount id has a different name so I think start the move to using that now

and only allow the new one for lookups.


>
> But I'd still leave the 2^32 offset for human confusion avoidance.

Yep, agreed.


Ian

