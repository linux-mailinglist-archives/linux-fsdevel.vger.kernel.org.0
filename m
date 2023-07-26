Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D199763E28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGZSIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 14:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjGZSIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:08:43 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643A91FF5
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 11:08:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AA8C232005CA;
        Wed, 26 Jul 2023 14:08:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 26 Jul 2023 14:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1690394921; x=1690481321; bh=LiFTDs2ptIm9/GUnG9PO+IOhE
        8PladO/37FfCMk44W0=; b=Zjd+JdOfaXc95hyrStR7yVWwcj9Z5FRdJnDdVGvoB
        hFQcwGysZEd3hY12iGEknC7iHqBOJaBvTfmEdTUL1lwYWBPgz8IIAxUi8CNjiGPE
        qI2kjue4uo5aXzKThdvVc6f6Qqc1o8ZitO3T/QRFEgBW2bLPdeZ4mP5XoRKH/4aM
        QuTNdtTbL+DA7BzbivJm+dZqmzdw8QaixPwRkWnkHyMMeKnCv5Q3oWdoh15wkX/t
        Slf8DjanRyrYw9GXo17PSgsbGC4u6DtE2//iowF0jAdidAjCgGtbbXPd1KJEeB2U
        8x2Pfeg4eTBKPpQU7QnTfRZGMXNNxpLu6gpCV6imrQYbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690394921; x=1690481321; bh=LiFTDs2ptIm9/GUnG9PO+IOhE8PladO/37F
        fCMk44W0=; b=w7P4wiHE5NsMTulNNIOoyW1q+23I5jARt/YUnU8yDRwPo7bYKI7
        lkPjwE5THlCpPz8WwNez37SNPMcEBngGe8Xx9rpiNpuYcZcf1z9HULAgwJeCYqp+
        Q8kxpWHdgjmtkzXIhvlHRjcDB6S5bsxvvGhYdpMJiocfFNAQp81ba4K+5znSEkAh
        s459it+KkAx/GXgPypASDT/1uA4TZQ4rF+NRq68yV2/JJ6jXC4DITlSyYGJrVxoY
        kGC9W2QdEzILo3xy3PVsN22SZ9D6NiSNTvQUHYhC0E+1QT5Q+/l0RFkcoZXpa3LR
        DFFl9zjcdyewCzGIN8USBP3acLjaQt2ohqw==
X-ME-Sender: <xms:KGHBZL1fGOvn3X8f6_LriwhP451LUHIokPDYbNbNZRJhd57b85QQsg>
    <xme:KGHBZKGtlm8DAegp3E0vbiWBQABS0EAEEAWZQQUPS19WYHikyMb3bGgVLJVE89jij
    Xm0e4SU5Rl5dck8>
X-ME-Received: <xmr:KGHBZL7r8ohbYhMoY-yLIQ0X_qiSrWuV7PJHQ8uSgCnDuN7gozcjR5HfIwWGDgUShaC_BlfLmys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgfgggtsehttddttddtredtnecuhfhrohhmpefpihhkohhlrghu
    shcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepiedtueetheevledtuedvgfdvgeeghffhfeeigeejveektdfguefgjeeuvdefhedv
    necuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:KGHBZA2ARuurFBgu3nFFP4PbYzR0O9Gbh7ATO-tfV07wJuRpPw_YIg>
    <xmx:KGHBZOH3TxIcSA5p86npf8JwfUcAhSMGTUPK1PCNQevkbjNpVgPnbg>
    <xmx:KGHBZB9NE8dGyrzp_10ZPS-MoBcIWdJCEdFmrFIqW1_RnaScOHMO8g>
    <xmx:KWHBZKjum4_DHvxFjTboa0812gsdEJSHPPXct7JI9mE41jJHWZIncg>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 14:08:40 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 79A1BB3D;
        Wed, 26 Jul 2023 18:08:39 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id E41BE8053E; Wed, 26 Jul 2023 19:08:38 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     fuse-devel@lists.sourceforge.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Subject: Semantics of fuse_notify_delete()
Mail-Copies-To: never
Mail-Followup-To: fuse-devel@lists.sourceforge.net, Linux FS Devel
        <linux-fsdevel@vger.kernel.org>, miklos <mszeredi@redhat.com>
Date:   Wed, 26 Jul 2023 19:08:38 +0100
Message-ID: <87wmymk0k9.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
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

Hello,

It seems to me that fuse_notify_delete
(https://elixir.bootlin.com/linux/v6.1/source/fs/fuse/dev.c#L1512) fails
with ENOTEMPTY if there is a pending FORGET request for a directory
entry within. Is that correct?

If so, what is the expected behavior for a filesystem that has just
deleted the entire tree and wants to inform the kernel of that fact?

Calling fuse_notify_delete() synchronously seems very prone to
deadlocks, and I'm not sure that the call would actually block until
FORGET has been processed.

Is the filesystem expected to wait for FORGET before it issues
fuse_notify_delete()? Or should it actually wait with the (physical)
removal of the parent directory until all child entries have zero lookup
count?

In the former case, why is this needed? In the latter case, how are
network filesystems supposed to deal with this?

Best,
-Nikolaus
