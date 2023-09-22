Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A407AA7A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjIVEOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjIVENc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:13:32 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C3E5C;
        Thu, 21 Sep 2023 21:13:07 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D51735C026A;
        Fri, 22 Sep 2023 00:13:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Sep 2023 00:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355986; x=
        1695442386; bh=TVdA8h0DNl8QhVA+dGkTgVhkAap2oNQG0MwE5XL5kpw=; b=i
        KyjMpSdhrt3uQsxr6T6UxoeYCbayRCf6SkJDZKUT4DjCRR4XZI7A4vp6vVa7IWY2
        iAlx/Z5r7iLqsma8ChIdZ0uHbC6hqEiGT/J1VYhxYkNNsvNnRIPgkWk0gKhsIDFY
        WtgUstVwu6J+U17BBmdF06sF2Pr9eCAEbdMGKuA5YupM4mj7WfP9lz7h29e4/9Na
        +B2kmRJo1xVJ9ygM6cmPc2LT4bNSqqh9Y6BKwROZfdep7y87BBdKrPW6OTdFRRbQ
        iRE+MQi//Uy3JQhSGl/sLN0+4R06QVi0eVulUtvzfmVGOoEWmU/ZNJ87zlOmYE5V
        g3+OU2puQL+OQocE6EgZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355986; x=
        1695442386; bh=TVdA8h0DNl8QhVA+dGkTgVhkAap2oNQG0MwE5XL5kpw=; b=L
        7OBvXe8GQHWpMoWy0wgEbjaCZ212zowRiQ+RXQILK5CTv+qTNNaMNV3LMpx2ZncF
        jcH4elhoAb8due9ZEchpzGG0xafIPAKpgC31HpEZFHO/ASLmmanGazJslyE/WI5n
        pvXZ0OuFQyrOS8IjBkEJQOO5EP43Q9g9zzW5Q6bKwIzKOS406f4Q3WDVv+vTRuVq
        AGPpUhHDDoqaauZLdG3SxtmsGpOyog7/Zvc7YGXstxk0v+loWIjiLoviaLido0ft
        aOOR5cQmcvvdJhcqoD0M87w4DOvu5Gd+cavaQG8nXyEaQC936trU16dw+7H4ofvP
        1nUnDIL5R22VvFGLFSWQw==
X-ME-Sender: <xms:UhQNZbqQoesNkj20_2aQv05gm9VQZ6DR2aH4g6ODlwm5d9za5hJU_Q>
    <xme:UhQNZVrXP3ueb2OchjQPge8GsTxL9_6WwTHFHZM0dDgL_Hw4IscBsmBHllt-rQSVY
    mDf4lB42g_z>
X-ME-Received: <xmr:UhQNZYPlAWAyAcuA69HoE_vp84Pj0CkaxJbNFbwv2mzxq4-CA5QnsylxBCdlA9BxTKWraktmCjIHj3WY6EJ_S0nMHxdGkKl1PMXRhY9JQbdcu8PfVpJe6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duleegueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:UhQNZe7WqQhd6n1KYJU3Xzxsd20cOqlBB6TcP9mWDwi2Iil9_jG5IA>
    <xmx:UhQNZa4bFgu7VNLYR9RVxJ4BY0PoOIaerHGWpGqw8xfsuHzh7EUhVA>
    <xmx:UhQNZWi5ln45HVz_nHZIaXSDvN-KLVQumlX0boL8Zp_5V1vq7cAWsw>
    <xmx:UhQNZXuY3BZs68mD8pa516gvZZX6FZAkjNFgxthCr_onRYaQtliwaw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:13:02 -0400 (EDT)
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
Subject: [PATCH 8/8] autofs: fix protocol sub version setting
Date:   Fri, 22 Sep 2023 12:12:15 +0800
Message-ID: <20230922041215.13675-9-raven@themaw.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922041215.13675-1-raven@themaw.net>
References: <20230922041215.13675-1-raven@themaw.net>
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

There were a number of updates to protocol version 4, take account of
that when setting the super block info sub version field.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 3f2dfed428f9..53c0df354206 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -279,7 +279,17 @@ static int autofs_validate_protocol(struct fs_context *fc)
 		sbi->version = AUTOFS_MAX_PROTO_VERSION;
 	else
 		sbi->version = sbi->max_proto;
-	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
+
+	switch (sbi->version) {
+	case 4:
+		sbi->sub_version = 7;
+		break;
+	case 5:
+		sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
+		break;
+	default:
+		sbi->sub_version = 0;
+	}
 
 	return 0;
 }
-- 
2.41.0

