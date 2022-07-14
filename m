Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC596574458
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 07:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiGNFMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 01:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGNFL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:11:56 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09352DEA;
        Wed, 13 Jul 2022 22:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1657775512; i=@fujitsu.com;
        bh=dPx8xkRH+M13ldiVfjHxDDuE38BfJZItPQyU90+LlAU=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=UdL04D/PvpOcIYhycQcyhhskygebrGC9cqkFJzpFLou55zK0aTizyWJejLgWhgk+e
         iTWo5uFlR1GxfeFwPsvGos7FAIPZbFT1h5fARnYynv7g24gwlGriF/GNGFSD2y1rDM
         dvPqgekKOh8AAdGlYFQwUGyC6XyOhCTkFV0eSbY6KeceBnEUo63YqcO/ljIoPtAI6X
         y9PzK/Z7YmIxHJA9Mg4m+7GfqvIDqY0WnJonuF+SGpqOOCfwPm3l7MzDafWgL44wGx
         OD7n1/wufcFvlemTS1ITJt3gk3M+SvvqLbMJjzs1W61v9TYsMUcXR3gZkhe8fl+ACN
         4PJ54qP0b/29g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRWlGSWpSXmKPExsViZ8ORqNu/9Hy
  Swa0DTBavD39itPhwcxKTxZZj9xgtLj/hs/i5bBW7xZ69J1ksfty6wWJx/u9xVovfP+awOXB6
  nFok4bF5hZbHplWdbB5nFhxh9/i8Sc5j05O3TAFsUayZeUn5FQmsGX13frEUHOSo2HRwAnsD4
  3z2LkYuDiGBLYwSbye/Z4ZwljNJPH65CyjDCeTsYZTomigMYrMJaEo861zADGKLCDhKvGifwQ
  LSwCywl1GiadN5FpCEsIC9xNFPF5hAbBYBVYmd28+CxXkFPCQuPn7ECGJLCChITHn4HmwQp4C
  nxPFbmxkhlnlILL+1kAmiXlDi5MwnYL3MAhISB1+8YIboVZS41PENak6FxOvDl6DiahJXz21i
  nsAoOAtJ+ywk7QsYmVYxWiUVZaZnlOQmZuboGhoY6BoamuoaG+kamuglVukm6qWW6panFpfoG
  ukllhfrpRYX6xVX5ibnpOjlpZZsYgRGUEqxAt8OxuZVP/UOMUpyMCmJ8t5edD5JiC8pP6UyI7
  E4I76oNCe1+BCjDAeHkgSv/GKgnGBRanpqRVpmDjCaYdISHDxKIrxPQVp5iwsSc4sz0yFSpxh
  1OZ4+P7GXWYglLz8vVUqcN2YJUJEASFFGaR7cCFhiucQoKyXMy8jAwCDEU5BalJtZgir/ilGc
  g1FJmFceZApPZl4J3KZXQEcwAR0hF3kG5IiSRISUVAOTz4XFX1r0ri9h3PKDhbmmtCjm2GmP2
  b8/+kruyj/0yvjThlspO/XEXB8+5/M6kSR+2ag9VGb7EUuZe1V+ojlS02ws9DtfOSWeVv7AMz
  lb5vqJi9P+ymwOXxG59f3sxlaXghm1lxYlJRr5TFNLbzsqLMyhtkRmp1OKqPGNd9u62yyWFjN
  Hyp+szciTLpq8T9XffF0Jj/8H14N97N4lOp/Km8Pn/z64hY89W6s2cK7UJ6eSKV9y4hOVnl/+
  0PDOfMP3xUq/V7A0v1/yzqNtxmQu2VVHTttdv+H5v96q4X+UH1dj3bJtlWFt11cfLbDeE3pSa
  3369K+1h57N+vb67qzkyTZc92V3TLnHrP747v0EJZbijERDLeai4kQAqvXQYqcDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-571.messagelabs.com!1657775502!145405!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5696 invoked from network); 14 Jul 2022 05:11:43 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-4.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Jul 2022 05:11:43 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id AB73B100198;
        Thu, 14 Jul 2022 06:11:42 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 9D72E100197;
        Thu, 14 Jul 2022 06:11:42 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 14 Jul 2022 06:11:38 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, <xuyang2018.jy@fujitsu.com>, <pvorel@suse.cz>
Subject: [PATCH v10 4/4] ceph: rely on vfs for setgid stripping
Date:   Thu, 14 Jul 2022 14:11:28 +0800
Message-ID: <1657779088-2242-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1657779088-2242-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we finished moving setgid stripping for regular files in setgid
directories into the vfs, individual filesystem don't need to manually
strip the setgid bit anymore. Drop the now unneeded code from ceph.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/ceph/file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index da59e836a06e..5a0266ea66ff 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -657,10 +657,6 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 		/* Directories always inherit the setgid bit. */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(dir->i_gid) &&
-			 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
-			mode &= ~S_ISGID;
 	} else {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
 	}
-- 
2.27.0

