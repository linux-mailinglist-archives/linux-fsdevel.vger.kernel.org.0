Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB795A1906
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbiHYSsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 14:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243309AbiHYSso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:48:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB9B08B9;
        Thu, 25 Aug 2022 11:48:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A0E735C00A7;
        Thu, 25 Aug 2022 14:48:35 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute5.internal (MEProxy); Thu, 25 Aug 2022 14:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1661453315; x=1661539715; bh=7/QJ5cEPcM
        fYYVo1y1XafN6H2GK15RMZ9wDJuYjC+3c=; b=tAJRAlKJC6gwE4HsW/KFz043yK
        24kBNzKUiqmnVincz1sRtGKAb19o0zAv/9Fy3yHUJ7me08gpSkhGFvCWlPjT4ER+
        +fNGjc/wZ6IOXNAIT2wqi5fp++4hIugMf/rc7b0/ujORdyOq64rh2quHqGtoZDdk
        dLsQf6wCXqgn8RU8Hcy812rvA86MmxNSJzKD+fXCKdMwbwgJxgW6h1iB9+o1jgA+
        IFur+F8TqAEKzz9HV8vU978jhpMJ/9UHc1JGXLoIg+JnodG27tUhcPdFWNzDDdpX
        UJ+mfLKn/kDhfRmWTKQ7v9y49Y7kQ2GfW83zU0SnddNwXV24uGXZmhQx2ZJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661453315; x=1661539715; bh=7/QJ5cEPcMfYYVo1y1XafN6H2GK1
        5RMZ9wDJuYjC+3c=; b=aa7WC/tnYeq9OEjXMIgD5gjslo07PCVNiJjuBBQdaR38
        n51GhANSSmBdeGZTtg5eDLrA4BdvWSEkvqCwaDMIfgyWc5depXXCHqTnmv8m3d8r
        fT0XK7FvIHXFXhcdMpTLHH/RNW06CX+x4fWxxT7+BSpuO3yDHayMs9RvS2M26UHW
        iNbjsaRW4egk+/gLmvM2xNiZSdbMruognidUigvjkcHjc8yNGrhD4zrxT6oImZps
        Np1MrDj8k9jtJQZo2sjU/Z4SucHTM7VJ4DksLpIRKM/y7/dCCcR0zG3W4nSOKS2V
        L18DNzyfWvFLhNSJ6GoReFAYZ8icZaxkfOMf6DkXrw==
X-ME-Sender: <xms:A8QHY82GfZAwKKwY_0T6x9zEtaLb6uf8nx0uruUK6g9bGwSe1YyFkA>
    <xme:A8QHY3GvgJ9DZvB6LI9m-3Xd4J6y_1XZJcXrLdp-0fj0YbzrrihNF-_-GmAEe38ne
    uwZn9MWVop5_BwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejfedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    ohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqne
    cuggftrfgrthhtvghrnhephfejuddthedtgfeuueeltdekfeekvdfgveeifeduteekheff
    jefgieehheekgeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:A8QHY06R9jjTowXOu19o1y47k7-QiWvVbrDyUvENlz3pvT8WGkhMQA>
    <xmx:A8QHY11eU6Qd6nefd6Gb9VL37HPxK91pI76roxyKS7OooLjewyKexQ>
    <xmx:A8QHY_F_Rr4M0DWHCqyFKNnhF_6pTnoh2MsmzQkRDS-XVvRAemOFQw>
    <xmx:A8QHY045Pks8pmIGRrvdS2iqbDXCdghu_nCsY5cdix3wFMMXOYN6Bg>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3C1E52A20075; Thu, 25 Aug 2022 14:48:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <fc59bfa8-295e-4180-9cf0-c2296d2e8707@www.fastmail.com>
In-Reply-To: <20220823215333.GC3144495@dread.disaster.area>
References: <20220819115641.14744-1-jlayton@kernel.org>
 <20220823215333.GC3144495@dread.disaster.area>
Date:   Thu, 25 Aug 2022 14:48:02 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Dave Chinner" <david@fromorbit.com>,
        "Jeff Layton" <jlayton@kernel.org>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        "Jeff Layton" <jlayton@redhat.com>,
        "David Howells" <dhowells@redhat.com>,
        "Frank Filz" <ffilzlnx@mindspring.com>
Subject: Re: [PATCH] vfs: report an inode version in statx for IS_I_VERSION inodes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, Aug 23, 2022, at 5:53 PM, Dave Chinner wrote:
> 
> THere's no definition of what consitutes an "inode change" and this
> exposes internal filesystem implementation details (i.e. on disk
> format behaviour) directly to userspace. That means when the
> internal filesystem behaviour changes, userspace applications will
> see changes in stat->ino_version changes and potentially break them.

As a userspace developer (ostree, etc. who is definitely interested in this functionality) I do agree with this concern; but a random drive by comment: would it be helpful to expose iversion (or other bits like this from the vfs) via e.g. debugfs to start?  I think that'd unblock writing fstests in the short term right?


