Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734D87AA785
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjIVEMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIVEMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:12:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48C19B;
        Thu, 21 Sep 2023 21:12:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E1ADA5C007F;
        Fri, 22 Sep 2023 00:12:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 22 Sep 2023 00:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1695355951; x=1695442351; bh=uI4T7zAHEd
        SnD2K9j+HC//bD8KbiRQpQtuKbu4Xx/0I=; b=XC2jY657mOoIeQlWGw5eZmM/zV
        dxYI8g4PKY/05cSOaEdDzmeKut+6/61BmLMzFcxZRL6BkWbgJo3W4Hi6z1pmDAcR
        pfr907J8LM3enXsH873SJMfNnQndnRCeJrNRU5TLEXCdbscCESz1SwlH4JFs8MEW
        QZKO5G/p/VRwdpUAGlQCG0xk3wgmVNMOLO3mXSw85gIjbN0ptfDLBvnnRjYerhjy
        cdpjuef9wu/Cxxx/QxnjngcPzPeliQmvxxd62U9MrQ+oy4lj57s/6tcAO5ZLfJb/
        amzQMjTQuQCXn6B4TqC9HNWX622LlA0tdwJu1Z1ulbpGjOmbqZvzDk31SFsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695355951; x=1695442351; bh=uI4T7zAHEdSnD
        2K9j+HC//bD8KbiRQpQtuKbu4Xx/0I=; b=WPt5fItnj0fV1wgOK/j5pY1BU4x4H
        Sbkw/8fpJdm14klb+KKGTblJ1SzFD4U01pd2n39oSGP50/+r/7Nd4OOMFfYCI4/F
        nqjMA4d4RuSVIci/zlhB6jU6stqMsTQLk3agNZPc/dBfvlpnvJ1vy4lVTPi+DsO1
        mpAe1fI/o1F1vhf2TpJQmvGjLA3waISPOyP5X3DYWskdDRhoINUGQXbUd+R+lth2
        pqY725HkEu2ZWUMQQcRajtAgYa4N6uVk4K496TrHRoQqdxLr16RmfSkWN5b1RCbQ
        jSbbifnDQ6Do/gvFex1wUtbrW20sSgGEmc2k09m0aTTr2New18/awKhQQ==
X-ME-Sender: <xms:LxQNZW8cf1dobpttKD4AjmfCJaQWj4Ms-2rgxAHbY7J0F_YYZzPUgg>
    <xme:LxQNZWvx9DQUloyX0H3TKY8oWjFY76nHHwgQx4XjDPjJT8FNn7aAG0XAnkQB2N-0f
    njNlI-7zUnp>
X-ME-Received: <xmr:LxQNZcBENe10_EKka5uVyNkBg9cLDGUt9Pr8JmAPsbd-Dih_thPyDmu-Ka2aB2v7drnieSylKVSE5cUjy0Qgh2Uw3ek-V8b9_YosnW0kKt0_oooq9exbag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedutd
    fhveehuefhjefgffegieduhefhtdejkefhvdekteeihfehtddtgffgheduleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvth
X-ME-Proxy: <xmx:LxQNZecxVgGKKUBhdH5PzUZ1N69Rwtk7k1NoUJrrvq6USSqqkweGOA>
    <xmx:LxQNZbONwJHTGFWycuy6_9LkItUkg30rpsREQpGMa5cMG9QM2wI3WA>
    <xmx:LxQNZYnDNWrI3c76cj4iTYbbrJqW2PwSukWz3NmTscNMs9ms6FMFzA>
    <xmx:LxQNZXB7OGODTookAWRL_AZsGxwEBBtd3iqr_tu5Wu3QYBwSNu4gCQ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:12:27 -0400 (EDT)
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>
Subject: [PATCH 0/8] autofs - convert to to use mount api
Date:   Fri, 22 Sep 2023 12:12:07 +0800
Message-ID: <20230922041215.13675-1-raven@themaw.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There was a patch from David Howells to convert autofs to use the mount
api but it was never merged.

I have taken David's patch and refactored it to make the change easier
to review in the hope of having it merged.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian Kent (8):
  autofs: refactor autofs_prepare_pipe()
  autofs: add autofs_parse_fd()
  autofs: refactor super block info init
  autofs: reformat 0pt enum declaration
  autofs: refactor parse_options()
  autofs: validate protocol version
  autofs: convert autofs to use the new mount api
  autofs: fix protocol sub version setting

 fs/autofs/autofs_i.h |  15 +-
 fs/autofs/init.c     |   9 +-
 fs/autofs/inode.c    | 423 +++++++++++++++++++++++++------------------
 3 files changed, 266 insertions(+), 181 deletions(-)

-- 
2.41.0

