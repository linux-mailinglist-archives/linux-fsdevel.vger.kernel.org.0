Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF64F7D9C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbiDGLLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 07:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiDGLLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:11:35 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB3580218;
        Thu,  7 Apr 2022 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649329773; i=@fujitsu.com;
        bh=NuHVxQHpxDDRq2/DGuIil8FquoffInn7KefBlaR0cfw=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=bw1bhqK0hvGtvKJjdOEVD6+gtvbWgDImIR20XWFGc5ZJ9hZGBDg8X5YGzQL3T3xXz
         SwdqN/cSycuZsRkOF7aeoxmcYvvRGNODdstxIN2cnBLOby/gS+yttgf4Zhpw2sS+Ul
         c1lywcinj0+/SqG1+cHfYlX/SqpxbYTfErgovpN5BLLbc0h6wKlojegRhEkxtaZPGP
         uGGOhV81Gn/s6LcGMRyR5JxQWPvdqBekddqpJJrXOaEEoQSEGZLrgnZQOGGt2PjM2x
         K85WfvnKXqAGqnWlOqDW9QS244wEy8f649HY7Bb1MiTVp7HThm2SAJhO1vi9S7TAoz
         /1nWdrARqz9ew==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8MxSTfnmF+
  SwdOZphavD39itNhy7B6jxeUnfBanW/ayW+zZe5LFgdXj1CIJj02rOtk8Pm+SC2COYs3MS8qv
  SGDN6Dr2j63gqmjF5vvzmRoYG4S6GLk4hAS2MEqs+biOFcJZwCSxf/ZVFghnN6PEtiu3gRxOD
  jYBTYlnnQuYQWwRAReJb/v/soHYzAIpEg3nmxhBbGGBGInts36zg9gsAioS91sPg9XzCnhI7P
  2/GywuIaAgMeXhe7A4p4CnxN3H38HmCAHVNN+YwQhRLyhxcuYTFoj5EhIHX7xghuhVlLjU8Y0
  Rwq6QmDWrjQnCVpO4em4T8wRGwVlI2mchaV/AyLSK0SqpKDM9oyQ3MTNH19DAQNfQ0FTXRNfI
  2FIvsUo3US+1VLc8tbhE11AvsbxYL7W4WK+4Mjc5J0UvL7VkEyMw+FOKWd7vYGzq+6l3iFGSg
  0lJlLdhp1+SEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQnexCNAOcGi1PTUirTMHGAkwqQlOHiURH
  iPHgZK8xYXJOYWZ6ZDpE4xKkqJ8+YdBUoIgCQySvPg2mDRf4lRVkqYl5GBgUGIpyC1KDezBFX
  +FaM4B6OSMK8GyBSezLwSuOmvgBYzAS2uO+gLsrgkESEl1cDkMttL/UmHtq9Y8Jvvs/8+PfhI
  KaBIY13Goj9p0VKzNq8pS7H225ovXu16XfnfoR+yPz7/VT9sLDPhbdvFpwd29b6cUeo8w/Uti
  +XZvO3XMt48O1t8IfNx9azQYo9bX5iqp+Q5PKnk2tEZvr/f4vd9oe9dnrXzXfTNP7RvbYkx+D
  b7/ws3ni/38/llOi7P2W3vHjS1ToyBR/gPq9FWhkf/D/7LXLhDPOiqX7uFz/ekO15nOMouuL7
  dcKz77+TWCSc25x9hLMoK/ehjv+bBH+fLv0se/HV5mVamVcXj2H/v0UllNb9SIYb6J8827OU6
  qN0f0fiYcfqlVUoqBxdvNki+5b7wZo9gwem43s5zOxYJKLEUZyQaajEXFScCACMYXCl5AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-591.messagelabs.com!1649329772!1296!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24241 invoked from network); 7 Apr 2022 11:09:32 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-19.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2022 11:09:32 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 62D49100441;
        Thu,  7 Apr 2022 12:09:32 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 5589F100468;
        Thu,  7 Apr 2022 12:09:32 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 12:09:24 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 4/6] idmapped-mounts: Add umask(S_IXGRP) wrapper for setgid_create* cases
Date:   Thu, 7 Apr 2022 20:09:33 +0800
Message-ID: <1649333375-2599-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since stipping S_SIGID should check S_IXGRP, so umask it to check whether
works well.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index d2638c64..d6769f08 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8031,6 +8031,27 @@ out:
 	return fret;
 }
 
+static int setgid_create_umask(void)
+{
+	pid_t pid;
+
+	umask(S_IXGRP);
+	pid = fork();
+	if (pid < 0)
+		die("failure: fork");
+
+	if (pid == 0) {
+		if (setgid_create())
+			die("failure: setgid");
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		return -1;
+	else
+		return 0;
+}
+
 static int setgid_create_idmapped(void)
 {
 	int fret = -1;
@@ -8157,6 +8178,27 @@ out:
 	return fret;
 }
 
+static int setgid_create_idmapped_umask(void)
+{
+	pid_t pid;
+
+	umask(S_IXGRP);
+	pid = fork();
+	if (pid < 0)
+		die("failure: fork");
+
+	if (pid == 0) {
+		if (setgid_create_idmapped())
+			die("failure: setgid");
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		return -1;
+	else
+		return 0;
+}
+
 static int setgid_create_idmapped_in_userns(void)
 {
 	int fret = -1;
@@ -8492,6 +8534,27 @@ out:
 	return fret;
 }
 
+static int setgid_create_idmapped_in_userns_umask(void)
+{
+	pid_t pid;
+
+	umask(S_IXGRP);
+	pid = fork();
+	if (pid < 0)
+		die("failure: fork");
+
+	if (pid == 0) {
+		if (setgid_create_idmapped_in_userns())
+			die("failure: setgid");
+		exit(EXIT_SUCCESS);
+	}
+
+	if (wait_for_pid(pid))
+		return -1;
+	else
+		return 0;
+}
+
 #define PTR_TO_INT(p) ((int)((intptr_t)(p)))
 #define INT_TO_PTR(u) ((void *)((intptr_t)(u)))
 
@@ -14100,8 +14163,11 @@ struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
 
 struct t_idmapped_mounts t_setgid[] = {
 	{ setgid_create,						false,	"create operations in directories with setgid bit set",						},
+	{ setgid_create_umask,						false,	"create operations in directories with setgid bit set by umask(S_IXGRP)",			},
 	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
+	{ setgid_create_idmapped_umask,					true,	"create operations in directories with setgid bit set on idmapped mounts by umask(S_IXGRP)",	},
 	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
+	{ setgid_create_idmapped_in_userns_umask,			true,   "create operations in directories with setgid bit set on idmapped mounts in user namespace by umask(S_IXGRP)",	},
 };
 
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
-- 
2.27.0

