Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4E6D56F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 04:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjDDC55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 22:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDDC54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:57:56 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70219BF;
        Mon,  3 Apr 2023 19:57:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 95FD55C00D0;
        Mon,  3 Apr 2023 22:57:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Apr 2023 22:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680577070; x=1680663470; bh=h6
        jLTmnRVW7snfNMmkgCLHM59jUMA2sAlcMAGdnV2Xw=; b=MBIg+WLiErbILUNtQa
        S2T/3Hu+7s7AciF4vUlBsJCrOXevl/qXdAYvyINUHVIsPS96cjOZ06+FsarDzPxO
        BJaJTc51YGnlLnJBv80xiFtRDpfW5hWcEoq8aEF2p2RQMN1J1803VoMkItMhLOTK
        0Ma73UFs0mRaKmeJTxdXg+q4NbAHpoVEdsX/vyvZP3beLqjmWaqufC0voZVKvOl5
        14sKq3Jf+NIc/QmkZWdC4uF5940OW3w4NBRlbyyDJmChtrDQ+U46JHljbtu9U/Sc
        V/LJrfMRf3ASvgaZklOHb/50Ycr5HNgcLSbFC3T9AfhP2ptW4r+pN/gjNsSaqnwN
        ri2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680577070; x=1680663470; bh=h6jLTmnRVW7sn
        fNMmkgCLHM59jUMA2sAlcMAGdnV2Xw=; b=N/q4XmWRayOyGwwitHNVIU3hybttd
        T4kvZk7GWXCoNHPK995+hwrukRNqXtljw3xLvYA+H+adVwdvlNs7JVdv6qdulKNo
        9TXB452tOfRLvdZgK4qFzJH4R7oefJmDmRq+LM1o7b72uyNpqC2AxAez6pp36cb2
        DqnHvligJ+ByDK8mR5pVISgUrOWHnZ46/fxK4rYrRruK1c1AeV6ZQ6YWOKkL8xSJ
        BvvD//OKSyiY2PK/E55bcxJVoPg6MheBkE0dj6zCxI6GodC1NJPeOD66GJ+oBlco
        pHN8IRnJoUFbbjCBZNEbZ1swHHmXQnYt676qxaY9ur/UjIafBHMpUmlvA==
X-ME-Sender: <xms:LpIrZKezI0kCc0MjYdNwLwl101Th2ey2KOY8GOnJekpdq-x_neieAA>
    <xme:LpIrZEOkhe9wtiSSQUu_TYakg1okJsh-sAiKPE0UzWVErR2UPx7s88sbRcBfTu5dL
    eoBjWzPBWw2H-gBJ-w>
X-ME-Received: <xmr:LpIrZLh6n4xwUz6RhSYaHcyi5H622He1BJQg5v0D1X14wv1uLW1e2P1MPJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeikedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpedfvfihlhgvrhcujfhitghkshculdfoihgtrhhoshhofhht
    mddfuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtthgvrhhnpeehie
    eiueevgfetlefhjeekleeutddtudelveevhfekgefhhffhtedtffehuedvteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgesthihhh
    hitghkshdrtghomh
X-ME-Proxy: <xmx:LpIrZH_8qx56kyJOj0JSvTg4me-cjY-401L8xAXiH0AdjK4fY331Pw>
    <xmx:LpIrZGtgbLeJhKIImAHQyuhAi8M6FywVUifzFsSmrtvMrgHvyMrCpg>
    <xmx:LpIrZOHLT6Ufm1Osxv4VtLSHYIIz2qm0N2eljrtGfOn6Qu3nCMT6ug>
    <xmx:LpIrZIJsfm60sLY0A_0UZxeWbrmNicGDmyrNJPHfkIZXsIE_aK3Vkg>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 22:57:49 -0400 (EDT)
Date:   Mon, 3 Apr 2023 21:57:48 -0500
From:   "Tyler Hicks (Microsoft)" <code@tyhicks.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     brauner@kernel.org, ecryptfs@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Message-ID: <ZCuSLNnFQEdOHW0c@sequoia>
References: <20230403-frolic-constant-bc5d0fb13196@brauner>
 <20230403134432.46726-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403134432.46726-1-frank.li@vivo.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-04-03 21:44:32, Yangtao Li wrote:
> > I can devote some time to limping it by until removal but would also 
> > appreciate a hand if anyone has time/interest.
> 
> I have time and interest, if possible, I would like to be a reviewer
> before ecryptfs is removed.

Hi - I don't think an additional reviewer is going to be sufficient to
get eCryptfs into a good state long term. There are fairly large design
problems that need more attention. I'll send a patch to deprecate and
mark for removal in 2025.

I'll happily add you as a reviewer and appreciate your interest in
helping.

Tyler
