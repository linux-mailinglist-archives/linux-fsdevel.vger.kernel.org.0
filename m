Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF97D4FDE80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350926AbiDLLvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 07:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355040AbiDLLtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:49:09 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89D06165;
        Tue, 12 Apr 2022 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649759590; i=@fujitsu.com;
        bh=CIzjA74MEWi+h5owqklrQgjAz3Lbuv5+Ro+Bd5ui2SA=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=cWvc+RNJfuMp6pdMclfWbYhJQ038JvIhpg2CmbN1MPXalcwCxvtaZxW+0oZS65gVv
         1EfU5Fv066cYhj05CeVs7vO1Hgyy4Py0yih1QKU2uqRFbIoUOX1sdb0rVwlSPzAtCO
         5qNZwjRqgh6yOxb1+bMK5/S6ZcpFRc2mzTsB61NUHkSZYQW+FSpmoHdcFaIxLByClO
         Tl2tk1BaQV/iwQ+CZGxKaTPbXaG0Sz5wydWZ+a4evgcPJisNjL0/ISEUycducZD/rv
         caiDSm3T3mSgDhsgW0qcUsYlxE6KKnWFRc92yWmhZ6BEZ/lkDyqXdTF2Ql2+1AwOl5
         ag9NEyIM8RHIQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRWlGSWpSXmKPExsViZ8MxSTc1NDT
  JoHWGscXrw58YLbYcu8docfkJn8Xplr3sFnv2nmRxYPU4tUjCY9OqTjaPz5vkApijWDPzkvIr
  ElgzWlpOsRd8Yqt4veAJewPjB9YuRk4OIYEtjBL/1vJ1MXIB2QuYJObe3MEE4exhlLiz8ywzS
  BWbgKbEs84FYLaIgIvEt/1/2UBsZoEUiYbzTYwgtrBAhMT6HROZQGwWAVWJvsabYBt4BTwkdj
  X+AquREFCQmPLwPTNEXFDi5MwnLBBzJCQOvnjBDFGjKHGp4xtUfYXErFltTBC2msTVc5uYJzD
  yz0LSPgtJ+wJGplWMVklFmekZJbmJmTm6hgYGuoaGprpA0shYL7FKN1EvtVS3PLW4RNdQL7G8
  WC+1uFivuDI3OSdFLy+1ZBMjMJRTihmqdzD+7/2pd4hRkoNJSZTXgCc0SYgvKT+lMiOxOCO+q
  DQntfgQowwHh5IEr1wwUE6wKDU9tSItMwcYVzBpCQ4eJRHe2ECgNG9xQWJucWY6ROoUo6KUOC
  9nCFBCACSRUZoH1waL5UuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHn5QabwZOaVwE1/BbS
  YCWhx6LZAkMUliQgpqQamSQ9ebbJXSOKU6tnJozz7XUdI5vuEpbpdEx4s4Zt095Miu20a49Xp
  VdpezI96N/3MPGj5ziNJtK1BfH42w4vkx2rWTTeqcoV8zjHYHo24nfKwWuGcfl0Pb89nt4rZV
  WbGLIlHPlraLluTl3z80rfXm2+2Cb968fOYVeRXl7Dw///Evtx+Xle199qzyz99Dc6/71Sc/z
  cjeMaG8ktdMRtqOrx1cj6vZb9r86HCeaHN15iD5uJdZyzZlBrYEnWczW9N6Fq1vlFG5Xvrs8Z
  jsWufbGZvFBTcsnLXr6QP3pcsW5aI+J2we6S6nD+u3CD/0vTjkppr/bvDJ3U+T5t+vPJq4t9d
  ji63novsNL+QF7RdiaU4I9FQi7moOBEAFB/db2ADAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-587.messagelabs.com!1649759589!2976!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20749 invoked from network); 12 Apr 2022 10:33:09 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-14.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Apr 2022 10:33:09 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5CA13100445;
        Tue, 12 Apr 2022 11:33:09 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 4E120100331;
        Tue, 12 Apr 2022 11:33:09 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 12 Apr 2022 11:33:03 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 1/5] idmapped-mounts: Reset errno to zero after detect fs_allow_idmap
Date:   Tue, 12 Apr 2022 19:33:42 +0800
Message-ID: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
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

If we run case on old kernel that doesn't support mount_setattr and
then fail on our own function before call is_setgid/is_setuid function
to reset errno, run_test will print "Function not implement" error.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 4cf6c3bb..8e6405c5 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -14070,6 +14070,8 @@ int main(int argc, char *argv[])
 		die("failed to open %s", t_mountpoint_scratch);
 
 	t_fs_allow_idmap = fs_allow_idmap();
+	/* don't copy ENOSYS errno to child process on older kernel */
+	errno = 0;
 	if (supported) {
 		/*
 		 * Caller just wants to know whether the filesystem we're on
-- 
2.27.0

