Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317C4F7D9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbiDGLLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 07:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243676AbiDGLLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:11:35 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6465C86D;
        Thu,  7 Apr 2022 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649329773; i=@fujitsu.com;
        bh=xf6+5wjCnSr1IQPy1/isKnVuwpthvPxO6tJ0PS14GZ4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ovQEkC9jjW2JEu7rP6+9jExekKbgXNqazgGl+SDy0ZtCcaN/70SP8QC7npX+6dRmY
         81Nn1F7Io5kJmz2uPRr8pTULVbxfhnT52TEFiN5G5gB7egks8ucqiBZ4D+/XutiJ9O
         eUb3OpQJl6oqfcg+6hF/tFZRLiTIqlb4mc7LOg5X4Yzp494rbmTg+UhWvWFUdGOQQ5
         +p2U2bC+LetWdMUmSLarL620dg7UBO4ZTrqpe9kH4SfeFYmtMabSBfTQWYddNS2BwS
         2UFyJpPVxGV19FRQ8tP3qYaMrqZuw1HQhJgF/Ki01ronbBMEOH9oM02OQJStXM6XuA
         K0GWymR5wlLzw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRWlGSWpSXmKPExsViZ8MxSTfnmF+
  SwZ0tehavD39itNhy7B6jxeUnfBanW/ayW+zZe5LFgdXj1CIJj02rOtk8Pm+SC2COYs3MS8qv
  SGDNWDm5tOADW8Xzf59ZGxg/sHYxcnEICWxhlFjY9p4JwlnAJLF+VjNUZjejxJHLT4AcTg42A
  U2JZ50LmEFsEQEXiW/7/7KB2MwCKRIN55sYuxg5OIQFIiQO9yWDhFkEVCTm3+5gBLF5BTwkDv
  SdYAexJQQUJKY8fA82hlPAU+Lu4+9gY4SAappvzICqF5Q4OfMJC8R4CYmDL14wQ/QqSlzq+MY
  IYVdIzJrVxgRhq0lcPbeJeQKj4Cwk7bOQtC9gZFrFaJ1UlJmeUZKbmJmja2hgoGtoaKprbKFr
  aGSul1ilm6iXWqpbnlpcomukl1herJdaXKxXXJmbnJOil5dasokRGPopxWr1OxhfrPypd4hRk
  oNJSZS3YadfkhBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3sQjQDnBotT01Iq0zBxgHMKkJTh4lE
  R4jx4GSvMWFyTmFmemQ6ROMSpKifPmHQVKCIAkMkrz4NpgsX+JUVZKmJeRgYFBiKcgtSg3swR
  V/hWjOAejkjCvBsgUnsy8Erjpr4AWMwEtrjvoC7K4JBEhJdXA5PK9nWPT/Ke3limbJTQdWPnn
  kuADTv3bClE/FqsZPr6S+a6ho37Hx/bq4985hd9/MOtMZZecdiTo0JbXvpKzyy6F3dHU+tkf2
  /ejavKnham3rlnoScycMDn4zcHz6XwNEgFzmJ0K7Q5I5zvMS1aW3nLfO+Gfov2O/0JZR8Xnmc
  hbZbTn9nUebgy/cn3p4Ue1ojavbcQWPNGwb3T/1B758c7+ST+UJ068fmnxLakw0av5Jsdv7oq
  esXfC8UlPzgk7qro9+7No08OUzny2hvnCOanzTHSUfuk/uSFdYMfzd/HPluOHky8olGf8U2a7
  ldsvwDNNjYf7O98cj63FL3XZTTP3bdunOTV3Sc+CuWsLFJVYijMSDbWYi4oTAUnEpLB4AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-16.tower-565.messagelabs.com!1649329772!1478!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29577 invoked from network); 7 Apr 2022 11:09:32 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-16.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Apr 2022 11:09:32 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5F7101000FF;
        Thu,  7 Apr 2022 12:09:32 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 52A09100465;
        Thu,  7 Apr 2022 12:09:32 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 7 Apr 2022 12:09:19 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <brauner@kernel.org>, <djwong@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <fstests@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 3/6] idmapped-mounts: Reset errno to zero after detect fs_allow_idmap
Date:   Thu, 7 Apr 2022 20:09:32 +0800
Message-ID: <1649333375-2599-3-git-send-email-xuyang2018.jy@fujitsu.com>
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

If we run case on old kernel that doesn't support mount_setattr and
then fail on our own function before call is_setgid/is_setuid function
to reset errno, run_test will print "Function not implement" error.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index e8a856de..d2638c64 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -14254,6 +14254,8 @@ int main(int argc, char *argv[])
 		die("failed to open %s", t_mountpoint_scratch);
 
 	t_fs_allow_idmap = fs_allow_idmap();
+	/*Don't copy ENOSYS errno to child proecss on older kernel*/
+	errno = 0;
 	if (supported) {
 		/*
 		 * Caller just wants to know whether the filesystem we're on
-- 
2.27.0

