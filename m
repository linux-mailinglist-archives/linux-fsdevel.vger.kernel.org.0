Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E015C7A12DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 03:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjIOBUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 21:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjIOBUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:20:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2B42100;
        Thu, 14 Sep 2023 18:20:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 33767320093B;
        Thu, 14 Sep 2023 21:20:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Sep 2023 21:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694740845; x=1694827245; bh=pmP7OP8Teh0wQAibyNwOhpBxRHvDRLuM8su
        1niOjxnQ=; b=NqhFWMnVCcxQHZPlXyLw0n7dKBIX2C8Jsn5W9axT3zoFM/sTGxj
        LnECOWQ4SqR878gxfxPCxd/HgY2M/ZSbwbVr59gkl42U4aJlAMfk+/nf5HWLok5S
        e3DpNyYJTIdf2aBgi3JKEFdxgXf7MBIn8FFLAX/yKQU+0BNkxyrM7f3+jJpcgL8i
        RT571MYz/JY1HNPzAuOz205Os1PT3HqMHwmHoCBW7rgwjKs8r/FC3f8HO3qvgboS
        VO6elqDybO+zYZa17Ka72MvynEGydL+3iuFv90+tXt1xVRedRjgyKeVVGg64hwe+
        mUiM5PggvTS7Qbdthzpd3EN5s9TMrLuiFyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1694740845; x=1694827245; bh=pmP7OP8Teh0wQAibyNwOhpBxRHvDRLuM8su
        1niOjxnQ=; b=jE3sXdcqMRKGAL+0avRoWasTzWML+Ek8m0C6HJCGg+2+rMqgiaT
        XX2cw0J9LpAzI2nVaYHletTIve0xGkLbQ14U1g5SdxegqbKPow4EjcMV1cUokrCS
        0OuobbOJjUAwzDw4deAmvx4qmzXr8EBiXCdykPwlfKxray0HP+FlaURGnvcLyxmS
        6Eo8xEl6/7jt8/kTEueJjK/UKnUmiZtTk88/gUtHva+fiSGqS2EQajs2jsEky1Ie
        BBnrG/0/bproKk9CGIQvpWAeUnd4DGISXc78UHFeAtbDxBoSzRc0gCje6ns2Pvz2
        EYvXhiPuUCih68Wu89aareqB/caTtuEJ5LQ==
X-ME-Sender: <xms:bbEDZYz3U3uTLR6OF7JIrHAuZvoAx4RUgbKJ3vVGIZfnlANqXm0ptw>
    <xme:bbEDZcRKLtg5DwDicCJKun8Q_0GJVrPKEmn6KY731dYv6OTYSJoPkX2IrTiLS_w9l
    Vjd8SADVrvI>
X-ME-Received: <xmr:bbEDZaVF8n4NWE0ArebMmg-JLA22gNAsyxaDbHesyOUcUewFUuTuexn0MI7ht7_cd2onncGuFsroYEH0Pb3nDJ__ndAXmV_2SfXwQJsbAiGlRwTfLoH2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgedvteevvdefiedvueeujeegtedvheelhfehtefhkefgjeeuffeguefgkeduhfejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:bbEDZWhRuUaBVlLzmQ4jUJKO7tqQJqZTWkxt77y288tkZSdyYlt2iw>
    <xmx:bbEDZaDdLhT6HMc2k2fZDM9QIw3s7zbQJg36_CFvpt1-wGQQnpx3cw>
    <xmx:bbEDZXK5eEOluEb2yRcMaBRsmQTOojCZbpvpl4aQJbDepopwt3y9zQ>
    <xmx:bbEDZSuc5We0fdnIICrw3rnOkCmJE4mHp84VZCqYZ4V5RwbPqhXb3A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Sep 2023 21:20:40 -0400 (EDT)
Message-ID: <904a8d17-b6df-e294-fcf6-6f95459e1ffa@themaw.net>
Date:   Fri, 15 Sep 2023 09:20:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] quering mount attributes
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <CAOQ4uxiuc0VNVaF98SE0axE3Mw6wMJJ1t36cmbcM5vwYLqtWSw@mail.gmail.com>
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <CAOQ4uxiuc0VNVaF98SE0axE3Mw6wMJJ1t36cmbcM5vwYLqtWSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/9/23 14:47, Amir Goldstein wrote:
> On Wed, Sep 13, 2023 at 6:22 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>> Implement the mount querying syscalls agreed on at LSF/MM 2023.  This is an
>> RFC with just x86_64 syscalls.
>>
>> Excepting notification this should allow full replacement for
>> parsing /proc/self/mountinfo.
> Since you mentioned notifications, I will add that the plan discussed
> in LFSMM was, once we have an API to query mount stats and children,
> implement fanotify events for:
> mount [mntuid] was un/mounted at [parent mntuid],[dirfid+name]
>
> As with other fanotify events, the self mntuid and dirfid+name
> information can be omitted and without it, multiple un/mount events
> from the same parent mntuid will be merged, allowing userspace
> to listmnt() periodically only mntuid whose child mounts have changed,
> with little risk of event queue overflow.
>
> The possible monitoring scopes would be the entire mount namespace
> of the monitoring program or watching a single mount for change in
> its children mounts. The latter is similar to inotify directory children watch,
> where the watches needs to be set recursively, with all the weight on
> userspace to avoid races.

It's been my belief that the existing notification mechanisms don't

quite fully satisfy the needs of users of these calls (aka. the need

I found when implementing David's original calls into systemd).


Specifically the ability to process a batch of notifications at once.

Admittedly the notifications mechanism that David originally implemented

didn't fully implement what I found I needed but it did provide for a

settable queue length and getting a batch of notifications at a time.


Am I mistaken in my belief?


Don't misunderstand me, it would be great for the existing notification

mechanisms to support these system calls, I just have a specific use case

in mind that I think is important, at least to me.


Ian

