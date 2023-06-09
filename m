Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6266372997B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjFIMU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFIMU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:20:56 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E9AE50;
        Fri,  9 Jun 2023 05:20:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E588C320095F;
        Fri,  9 Jun 2023 08:20:51 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Fri, 09 Jun 2023 08:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686313251; x=1686399651; bh=Ae
        PGK7j6br0Bw6PqeF/qCZRh62N2SRkRIZC6pDml/1w=; b=EzqpDP1XRFz3tW6Bl2
        ngxQeChONv4lIlRRUF1mGT9Lgd/pUVxMz4k83h/rDwfqSYBwt25VeCbmyNln8rc+
        MEmhzegXrbgKuyNT77PiKtUJcSAU5azDDEbWV/l6mgGept06vVmgtDJgzXOdyE+d
        0llhRAHU7/hyqxDTt5Gub8TiREafwtjoX0GF8CXRjPxwUdjmFyx8LCUryF62m7Qj
        7Righ02JqONv2Hn+a0XUBq68LO25pnokXa6eZSjB9JbPyBVcTypoig9ZTwIejb2O
        IevBKCujdL4PGzp7Zf/eYmb1UwKIcUI7jAbOFgsttfrAzKV0WTu6vzU9WeYM1UGH
        9CTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686313251; x=1686399651; bh=AePGK7j6br0Bw
        6PqeF/qCZRh62N2SRkRIZC6pDml/1w=; b=rewdMrpWrNATTMkPvmmdEU3s/JE2d
        v0qlkVkKq4fvy0PZSP9/jI39UQitkwpcME5u0DqH7nY6nGiCyi4RWTe6ni0To5Kn
        0veMiRo4A7iTAQExvSknqgHZl/e26poGoJzevS+gG4CMNZIAOxXJvGrkGEFKNILa
        k0Alg9s9zI9a5B1Op/W+EH5UjrqKehPNPpV5IGxeBCUpgINC17Ud3q5YyvGtB4X7
        6dvsGSbgTDF8az+cZKiFNGsHHdnBl1xj+2lLx3x1m3FoWTcMsVlkoCJ4rJ9vEkrx
        QLfWs+yph35Oo0UM1Rf5jItAVbZ1sp/4RDBAUa/ywbhcz3jwcgFeGUB5Q==
X-ME-Sender: <xms:IxmDZA3YLIEx6OBy11UBRDxv5yoAYX_heJsHQ90k_U8nX33nf13ZAw>
    <xme:IxmDZLHHJQSe05ujPdF4SUPWM2P56M63rPvpSPcI1QumUnr92Lx6tw01jZx5P1VCI
    mRoqby7VWI6SU-F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtkedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeljeeuveeiffeuvdefhfekgfeuffejgfeuhfektdeuvdffvdeg
    vedvgeetleelfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgs
    uhhmrdhorhhg
X-ME-Proxy: <xmx:IxmDZI5kC0J2LBYYPmMPHJsVy_Fwai00yPdPQSCWn90zGe_wR8LSFg>
    <xmx:IxmDZJ3Q_HbLmY034MGqVWwmcHA4BIpScJ1ycEx021xBwvbWm0MFbw>
    <xmx:IxmDZDGlEYAQ9f1Mcjp8Mgo9UgJAbeGnf6iRJT4J9y5mh5GPqIEGoA>
    <xmx:IxmDZITHv4Mh-eZkCOdMZCYND1epXZq1wFD7R5G9XKPJKOjYiUkf4g>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A4682A20080; Fri,  9 Jun 2023 08:20:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
In-Reply-To: <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
Date:   Fri, 09 Jun 2023 08:20:30 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Christian Brauner" <brauner@kernel.org>,
        "Ariel Miculas (amiculas)" <amiculas@cisco.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Fri, Jun 9, 2023, at 7:45 AM, Christian Brauner wrote:
>
> Because the series you sent here touches on a lot of things in terms of
> infrastructure alone. That work could very well be rather interesting
> independent of PuzzleFS. We might just want to get enough infrastructure
> to start porting a tiny existing fs (binderfs or something similar
> small) to Rust to see how feasible this is and to wet our appetite for
> bigger changes such as accepting a new filesystem driver completely
> written in Rust.

(Not a kernel developer, but this argument makes sense to me)

> But aside from the infrastructure discussion:
>
> This is yet another filesystem for solving the container image problem
> in the kernel with the addition of yet another filesystem. We just went
> through this excercise with another filesystem. So I'd expect some
> reluctance here. Tbh, the container world keeps sending us filesystems
> at an alarming rate. That's two within a few months and that leaves a
> rather disorganized impression.

I am sure you are aware there's not some "container world" monoculture, there are many organizations, people and companies here with some healthy co-opetition but also some duplication inherent from that.

That said at a practical level, Ariel in the https://github.com/containers GH organization we're kind of a "big tent" place.  A subset of the organization is very heavily Rust oriented now (certainly the parts I touch) and briefly skimming the puzzlefs code, there are definitely some bits of code we could consider sharing in userspace.  Actually though since this isn't releated to the in-kernel discussion I'll file an issue on Github and we can discuss there.

But there is definitely a subset of the discussion that Christian is referring to here that is about the intersections/overlap with the composefs approach that is relevant for this list.  Maybe we could try to collaborate on an unbiased "puzzlefs vs composefs" document?  (What's in https://github.com/anuvu/puzzlefs/tree/master/doc is a bit sparse right now)
