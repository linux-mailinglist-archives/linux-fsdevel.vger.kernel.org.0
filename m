Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571A25A236C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiHZIoy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiHZIow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:44:52 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D6D3BA;
        Fri, 26 Aug 2022 01:44:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B18B75C022B;
        Fri, 26 Aug 2022 04:44:43 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Fri, 26 Aug 2022 04:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661503483; x=1661589883; bh=FcASxq07SE
        JAkx76u4e1lSLrpan2odYfhNnko4gKCBs=; b=LeV864c4Muuh7j8Sy/U/pPijNm
        TT4vf3VzTnFOpQqT1U8HBAJ2kf4YS4topp8b+YOxbEH03o8CRIy3pKu5SPAoS/0/
        f5XM6WN8BJarYPAchCpEfJ6pudK4M8Hp4ot+5P9pbshg4P7cvrxFcEvNLh6GcrIQ
        D9TR1bQz7iuOzgNUQrHe6b5ONpHnbgCzO+2Wlr8HbsfkA5QT9EZZgxkRcVrXinlT
        OPNSPCq4ni2o9MHZLbRW/LrsBcOQBE8e1EXuX5GotgZYo02B6UNVIdehTsUzk9eb
        XYq5a2WX4GPnOYc8QwptfW2c2cUN99rVO+PhRcc02E0xdUOrFl/+2nQMUp+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661503483; x=1661589883; bh=FcASxq07SEJAkx76u4e1lSLrpan2
        odYfhNnko4gKCBs=; b=BXR6BlyeylwLEC6k2RMCXdPYtLeOtqahSifpvCWDJmTF
        FcekJZWUlY/f0i8L6KTUgbGGXsVuW8KD+hplG29CfrpjA4bMtg+d0WwpzzD3dSMf
        mm3MBkXWughoZJuzNVduOfVdD48KEsBydFAqri59lx+s2NId7SINaAtCPK/Er/0k
        ghFIz9X2Q7xw52mR0+Lchztf+LJLLep1NOkGioZw/yCgJklyIT+AfxToYkXxGnze
        TF37H85MvPi6rphO3Wjx2ImX79bBaysIFEAHEk6eBhCa37ss5hvh+JzrnyL9x+7g
        dF25RH5U0nJ/sDGbepZGeTdBD2zsqUEzQ9Dv/IOgvg==
X-ME-Sender: <xms:-4cIYyXn2N1ziYEEd4F2xV50QSAdb1MOCGfAr9VnFWTtKf9fvl_5qA>
    <xme:-4cIY-nEF8kMLD92jdR-3gB8T0PJsQo9ZylCZTXeHyuF7jvak8h7oFIMEDi6HpXVY
    bx1-rrDSnbrOgqX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfveho
    lhhinhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeffteeugeehlefhvddvleeljefgheegudehhfdugeffffejfeef
    gfduhffgueejleenucffohhmrghinheplhifnhdrnhgvthenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghlthgvrhhssehvvghrsghumhdr
    ohhrgh
X-ME-Proxy: <xmx:-4cIY2aFNIYb8WxEhA_OxGFmObT7bbggSBTKhH-fMKpvCV5fQfS7lg>
    <xmx:-4cIY5XcIQfigXZ0B3LzryQcWa9m2uQ1R1zif7nDYS8hr0ROoMORUA>
    <xmx:-4cIY8mNOEEVju0h-4MifiTlLd1hW1zReWB1HmuFjTXk3Y_ab3nDXg>
    <xmx:-4cIY7u547JP726GpbIP1f9YBisqZP19inE51rno9_Qbj7k1yhPxlQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4D1D92A20075; Fri, 26 Aug 2022 04:44:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <0c5ef1d2-235c-48c1-9a7a-5e52f3a34855@www.fastmail.com>
In-Reply-To: <0339f5f540010ba1bae74121d33c0643f26fefab.camel@kernel.org>
References: <20220819115641.14744-1-jlayton@kernel.org>
 <20220823215333.GC3144495@dread.disaster.area>
 <fc59bfa8-295e-4180-9cf0-c2296d2e8707@www.fastmail.com>
 <0339f5f540010ba1bae74121d33c0643f26fefab.camel@kernel.org>
Date:   Fri, 26 Aug 2022 04:44:23 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Jeff Layton" <jlayton@kernel.org>,
        "Dave Chinner" <david@fromorbit.com>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        "David Howells" <dhowells@redhat.com>,
        "Frank Filz" <ffilzlnx@mindspring.com>
Subject: Re: [PATCH] vfs: report an inode version in statx for IS_I_VERSION inodes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bigger picture, I think eventually I'm going to rework stuff related to my use case to be more similar to the container stack, specifically using overlayfs; so it's quite possible by the time iversion is exposed to userspace, I won't have any strong want/need of it myself.

On Thu, Aug 25, 2022, at 3:48 PM, Jeff Layton wrote:

> IOW, should this value mean that something _did_ change in the inode or
> that something _may_ have changed in it?

In my case it's basically the same as IMA - we want to only compute the sha256 digest of files that actually changed.  Some false positives are hence OK - but that also means the usefulness of the feature degrades in proportion to that number.

A bit more detail:

I didn't deep dive into the XFS mention about internal/background iversion changes, but AIUI at a high level it sounds like those iversion changes happen mainly (only?) when the file is recently created and pending writeback, which doesn't seem like a problem in practice.  I do agree with Ingo's old quote about atime though in https://lwn.net/Articles/244829/ and this thread reminded me to use `noatime` on my main workstation (again; I'd recently changed how I provision it).




