Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382967AA786
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 06:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjIVEMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 00:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIVEMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:12:42 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93FE197;
        Thu, 21 Sep 2023 21:12:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4996C5C0222;
        Fri, 22 Sep 2023 00:12:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 22 Sep 2023 00:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355956; x=
        1695442356; bh=Orfn+zsuM68FHIsSvumK/hPQ+xdBHw1ePrGBE2OK2hE=; b=N
        KYYXYpo+MooxRerSaDOtajao5gkfFD5+zVqKlWdG3i+MqOgNeleLoTf1ioTDWBt4
        cLK1j77m9Kdl7lANkCB3XjzMkkHgs09hQO/JcgM90sLFjwyU7mtDsKZLH57y5Biw
        S6M6OJNKHwveFhh96Ldm3jtawickWqkZGzyb25UMboFLQyvKGmy9qFXNw7y8G8xQ
        pZc9iH5X8mFKGedwMfqVULjHjP7YgQ0MLLViGAlNvs5lhTLbQcE+zYA3F/J8s0xC
        L0aZz9Is7EoVd3l1bVMU8XAn5m317X6B3IDcWz7hvR+K3ERjrZ4y8pBXJTMqrvak
        SSbHhFScEWBauYveVkzEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355956; x=
        1695442356; bh=Orfn+zsuM68FHIsSvumK/hPQ+xdBHw1ePrGBE2OK2hE=; b=j
        GrLgkJVgl2gjOoYSv+olMjthDTifVDgMhEIPQfQkiLjFFb8IxesvOpYBcxAZVMiM
        GB42oY5qR29b72Y2Dd0sCXznDYB/HZhR5iHa4jbm2miBpHAd47H9L13hm+2zJK79
        zRdeZepjDLFBErFzI41QiDO1eM7Qw5QVZDiI7koHTQgV4Mgdavz65OzIm6+IakC6
        NeTeJcC0p5qJHfMjvDvJVpDk6zlSaKWGY0ISbetiIepW4GBWFRmYkslVDdU0qcXC
        Z0y1LhPPO5h9pIEp0b/O28CAXW5qJ0GMToFK4u6vy1jenpuuoLNQLCQMXnHFkyY4
        vQWUoXvdMry/wUy5IP/nQ==
X-ME-Sender: <xms:NBQNZYav0Roeok0zJCWp1gUWlG01yds0RG8uDVEAaIZVtwwVWlm6Vg>
    <xme:NBQNZTY8eBpgIU7gdPz7Skjo4l1i6ONQHy9F0zscIabH6TBRyJCRM2gOG0VEpRT8S
    XH-Qj8PLatp>
X-ME-Received: <xmr:NBQNZS9_cpgK6ybwgpuN9heqcsJ1dqk44AsBKN-dqt5rLZb6XtxSczqNwCbSXCxksqp9kwDZgLkKX4fBVIpOM98__yciIgeV6yoZexyLFN2OuOzxMvyadg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duleegueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:NBQNZSrNOw1DXlUOQuw25xfIhd9mv8Tt8l13Npa6N3dqv_Uaf6YtQA>
    <xmx:NBQNZTrbxSery5c1gduvZoMc3685qtG1ac2DxgpXXY7TgbwDMuSxJQ>
    <xmx:NBQNZQQQk5gvP7DpnWUNHgtTS9WOSHhDxEBEUglrsJHkvB4gdp4bWw>
    <xmx:NBQNZUcCwuauia4f-NcESR_ijJ605jYiOoaYFS8iCMw-4-agqaaovw>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 00:12:32 -0400 (EDT)
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
Subject: [PATCH 1/8] autofs: refactor autofs_prepare_pipe()
Date:   Fri, 22 Sep 2023 12:12:08 +0800
Message-ID: <20230922041215.13675-2-raven@themaw.net>
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

Refactor autofs_prepare_pipe() by seperating out a check function
to be used later.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index d5a44fa88acf..c24d32be7937 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -209,12 +209,20 @@ int autofs_fill_super(struct super_block *, void *, int);
 struct autofs_info *autofs_new_ino(struct autofs_sb_info *);
 void autofs_clean_ino(struct autofs_info *);
 
-static inline int autofs_prepare_pipe(struct file *pipe)
+static inline int autofs_check_pipe(struct file *pipe)
 {
 	if (!(pipe->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 	if (!S_ISFIFO(file_inode(pipe)->i_mode))
 		return -EINVAL;
+	return 0;
+}
+
+static inline int autofs_prepare_pipe(struct file *pipe)
+{
+	int ret = autofs_check_pipe(pipe);
+	if (ret < 0)
+		return ret;
 	/* We want a packet pipe */
 	pipe->f_flags |= O_DIRECT;
 	/* We don't expect -EAGAIN */
-- 
2.41.0

