Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF817AA791
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjIVENK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjIVEND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:13:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450ACCC3;
        Thu, 21 Sep 2023 21:12:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 49AB95C0251;
        Fri, 22 Sep 2023 00:12:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 22 Sep 2023 00:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355969; x=
        1695442369; bh=ryCXqbIXzg6S6gQUjvoPfXhRLeM6IuhwCFN5VCJzJFc=; b=A
        QJ22VOomJC0WZVbO0CwEOPShSyigDPVMPrsRKLnaEDOcf3JSYevhn0tGuLgL9TvP
        EQQvYm5xA0MKGgoFyc4MNdmyBkXT9ssgx5Gz61Om//QySzFtwPQBs7J4Vq+TQGKE
        9BfX3tZE7ubgRZSvo/GL+tJNcfz8ZiW5/DiifY6caxitzl55pMGwb/oSeW6vF99W
        iFQogkGgkb8OvdaDicWU15foke8vUcI8zFJPkWVPSvJMGmUhD93QRK4XKUIbj4kY
        qk9bMa3j5Arg15+NSyJMmF99e3/tikxwzTk1ypXobQ1MzXhpMHsE+XF+bEIEkEcy
        vawxBu5ILeLXOS5H8WfgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355969; x=
        1695442369; bh=ryCXqbIXzg6S6gQUjvoPfXhRLeM6IuhwCFN5VCJzJFc=; b=X
        zPj8XBtqSEcH359KhBDLDTJ4lr3B+eObBDUY4RUL1LwWdn53BwlNUQiGwpN2cFi/
        EUIQ52MR5QF92UdJSxySibGePcy/xyIplfL6PLgJMOijM+z9AyG+k1mF+N72wTvp
        BZKd4cyUiuJtBUPfujAyEhVQR7RLeM5peY+HyXpYIVQ4lPHnjDlrZcw7nnYvxIpd
        JbiGc3Ps50s6akEdr7YBwyb1x0UbVuZe1s9l8aIEmCpK9nde/clAWW/GqyNFbPJT
        rIiy01WYrp5YzcaofTaolKrXhaDOnCZQ3TLBrE7+Q1Ba2ceMNyHQo8IhEQFLcal6
        v3FlSzloinL89kPzGFrBA==
X-ME-Sender: <xms:QRQNZSn3M1FH4-OF_Sn87XNM2bJrMhoRu4EFGOrn9340pzMMEGC7Hg>
    <xme:QRQNZZ0u8fL5m-EYq6aw10HDj_bnF30r-GeaT5YFJWarzoxWBTHPzvtPMXmUyx3gG
    hqBwVLNzTTn>
X-ME-Received: <xmr:QRQNZQo_rjaP_zSHu3PSey0FeVB457h9GTcaWewHKsqzN_Ma0VAObxihEvz2g23F7Ip1JBlwiaoRu38uaIZnVoqSpnGLjPPa_nSTcVj66GOsJn55UmHSmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duleegueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:QRQNZWk_7-KbGL5vU0dhP2N-StqnViYMviDz5CMbvTC6HLliycbpJg>
    <xmx:QRQNZQ0a5lHsj1yb169g0kdHpAscoiudQrM7pmEMRD3sB5qvZSJS1w>
    <xmx:QRQNZdthQ2VgASEZv2MnS4tcEm5uBc9TYUa5DUWBK1Wr1Ku9vUTgMA>
    <xmx:QRQNZap4IRARN8JMss75mAbCP72wzxgpgFf6hVpUCHSYkCth68S56g>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:12:45 -0400 (EDT)
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
Subject: [PATCH 4/8] autofs: reformat 0pt enum declaration
Date:   Fri, 22 Sep 2023 12:12:11 +0800
Message-ID: <20230922041215.13675-5-raven@themaw.net>
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

The enum of options is only reformated in the patch to convert autofs
to use the mount API so do that now to simplify the conversion patch.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 992d6cb29707..d2b333c0682a 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -110,9 +110,20 @@ static const struct super_operations autofs_sops = {
 	.evict_inode	= autofs_evict_inode,
 };
 
-enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire,
-	Opt_ignore};
+enum {
+	Opt_err,
+	Opt_direct,
+	Opt_fd,
+	Opt_gid,
+	Opt_ignore,
+	Opt_indirect,
+	Opt_maxproto,
+	Opt_minproto,
+	Opt_offset,
+	Opt_pgrp,
+	Opt_strictexpire,
+	Opt_uid,
+};
 
 static const match_table_t tokens = {
 	{Opt_fd, "fd=%u"},
-- 
2.41.0

