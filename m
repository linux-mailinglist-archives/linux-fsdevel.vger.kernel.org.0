Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D36749AB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjGFLes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGFLer (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:34:47 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1549A19A7;
        Thu,  6 Jul 2023 04:34:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D2AC55C01E1;
        Thu,  6 Jul 2023 07:34:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Jul 2023 07:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688643276; x=1688729676; bh=t3
        /q+Yg2MyaI0HLj5wcLnTMw97EVKZ397JoVjZFMbmI=; b=FMSfz4UQudPJeTt9bj
        WC9eVWhSdkVZVDDe4+xKy3kYSFTgGEykX2Saeokzx5CVACfuq6cFbtKj5pBKp7aq
        F/xJtdQOttoIte0kGTl1wfYUgTPX8hdSnJdItsbruqQwXuHXNwdyBYaseuNoJpAQ
        K09nzc/6amwj+3rXNfoIaRhXcZz9QKq1p5xARst0pgRqMhCcLFHIbdZlpHm7WU9m
        /quk8LhxCJATG9ZATEWRl2z84T15Ok7GtYUDhxt5xyXZ66x1UkJDBBPRQpbH97RG
        3TDvcHzvPcem5tT0fg6bgXxkw65dYVUO+1DFbSUPSad7KniZOWa38t6WWDtCLGaY
        +nGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688643276; x=1688729676; bh=t3/q+Yg2MyaI0
        HLj5wcLnTMw97EVKZ397JoVjZFMbmI=; b=JgusLVIE1tEWMeIDMDlUKz/L/HNXh
        WXLIYgGG/genxnLVqGgWHfri8GC3338hUWyrRsmaZzEpoSAuawo9wjH+qV1jby1L
        rMYDEhvb36rY1+bXYFweeoK0Bmgn1bsKOuMb3hOeibrHckvbdP0aw6A3qfO4oJwf
        OIkXT8SxOY659OVarF1c7oF3PTZtfypadg/Chxg2pG/J5KdizSQcLMBihbjhLYam
        Kz/Fci301n1SVB1AjhY7Jbs6o204WBTMaJw5Bb0bqnblrqiI2tXzDn62Xg2UR6qp
        RSLAo+1nioogftKm0GIfICM/oTUe26WDgHRmqv5KxXLaukUSlEr/LnIxg==
X-ME-Sender: <xms:zKamZIifhhh3cYphtKnXVUusVqjfk00NZB2K_CNVbkOYM2FBMQUhRw>
    <xme:zKamZBA5_K2Gr9r8TtB-5Ufvukb6BjCDR4KNkk24bEjQRpZCWRQiuS1Q4YHboNyW0
    KCB16KGd12wYkY4mkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:zKamZAEEySEYPRJfw1a14xVz8ITg-mjZqe9RFccGbPDIv7eA60XvcA>
    <xmx:zKamZJQG_89fAhk6cYr31JaZ3cLILRBYK104hLs2RTFFToUMqDwUlA>
    <xmx:zKamZFyJMlS-NV6ps_X_UlaEMQ80rlShTub9ZW0Ek9VNEO8IcmGD0g>
    <xmx:zKamZMnuNI4Jd8k_yPJ4lV2CB2z-4QO_Rn2Dg5d55ubI4NHcmwdxyg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1B6EBB60086; Thu,  6 Jul 2023 07:34:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <73b584cb-ceff-4e16-bac2-02de9903b973@app.fastmail.com>
In-Reply-To: <20230705190309.579783-13-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-13-jlayton@kernel.org>
Date:   Thu, 06 Jul 2023 13:34:14 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jeff Layton" <jlayton@kernel.org>,
        "Christian Brauner" <brauner@kernel.org>,
        "Jeremy Kerr" <jk@ozlabs.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 15/92] spufs: convert to ctime accessor functions
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 5, 2023, at 21:00, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>
> Acked-by: Jeremy Kerr <jk@ozlabs.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
