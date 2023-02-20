Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA64669D1CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 18:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjBTRCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 12:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjBTRCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:02:17 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF121ADDD;
        Mon, 20 Feb 2023 09:02:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s26so7202685edw.11;
        Mon, 20 Feb 2023 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yfugm/m5Cr0fTsBnS53U1NHSsEy5zCWigKnLIzVj5t0=;
        b=HejyTNEwPWoL+g9B9OB8/LxbWHvzdayZwHq4ssATfH6rsx3iGqrga/Mrgi603DAT4D
         mShTv0RpTEnQxroj/ZnVHMpMCGt0Ho92o6qcNrgqmLtvgSHbeNE56WGFStdGDpGLX3JG
         V85w1khve/pfP2SmkvEKe7BSQRc1Af4pWrUuVqyacTgPY+wiBfXt4UiXdWBZD5FucCJg
         n07Oo5CAkQp1MulxvlMum4XnJimAQr3gyHDabjHa2kPsFhQbTDq7KGnMfR0a5oYVb2lp
         g/VvmD4codf5aacHF9vzjEcNJeJGT5hTpcUwdqs+dzkr9vSzSbvz7eZDoHCf/ACzL0OE
         oh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfugm/m5Cr0fTsBnS53U1NHSsEy5zCWigKnLIzVj5t0=;
        b=4ev86FaIv1sjmAyNMTrFsYTuhqYWHh6xXjKcebCavWfh0CCLIgSugH2WW/BzesSUQ2
         BODS8MmwUAmfESIvrz6HcdvPdqbS3P3z3BO1JezF2F8GHXIYp9IC3YkQ9wrxVWXTGhK/
         3X+K2YCp0w/MSY1/xMteU2LyZGunfOjaDDC8rBIt70bV9hxmYoBOkMj9GXkrSmZ3YQWH
         1ze7jRuQkYxnovIkgYlNsr9dSw+JbLH9zD3atzqjoKr4OVMMXSxJET2Gq4g4qC0iZUWZ
         7tSHZO0CR/HvCbm4sYgS2EKXCajOjfHRtnWX68dsBg3sn4q8XvD8/J9VYKlL6L0M3aqT
         RmNw==
X-Gm-Message-State: AO0yUKWGLxaA/rDS9nCYdTdW+7ilYDkQMeuncMlTgn5FFCLM/ZZpYmRv
        IXPbi7V2cb9fwEwIrzxO+kw=
X-Google-Smtp-Source: AK7set8NPejudc0hauK7xZnLEEftWTSy8kxT/ObXTzYPFSXAWaOZyNKmrmu310CLNO89JwJWpFdFEg==
X-Received: by 2002:a05:6402:6cd:b0:4ac:b59b:60dd with SMTP id n13-20020a05640206cd00b004acb59b60ddmr2668769edy.23.1676912535196;
        Mon, 20 Feb 2023 09:02:15 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:ad0f:1d29:d8a4:7999])
        by smtp.gmail.com with ESMTPSA id h10-20020a50c38a000000b004ad75c5c0fdsm927227edf.18.2023.02.20.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:02:14 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Anders Larsen <al@alarsen.net>,
        linux-doc@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] qnx6: credit contributor and mark filesystem orphan
Date:   Mon, 20 Feb 2023 18:02:09 +0100
Message-Id: <20230220170210.15677-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230220170210.15677-1-lukas.bulwahn@gmail.com>
References: <20230220170210.15677-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the content of the qnx6 README file with the canonical places for
such information.

Add the credits of the qnx6 contribution to CREDITS, and add an section in
MAINTAINERS to mark this filesystem as Orphan, as the domain ontika.net and
email address does not resolve to an IP address anymore.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 CREDITS        | 4 ++++
 MAINTAINERS    | 6 ++++++
 fs/qnx6/README | 8 --------
 3 files changed, 10 insertions(+), 8 deletions(-)
 delete mode 100644 fs/qnx6/README

diff --git a/CREDITS b/CREDITS
index 847059166a15..07e871d60cf0 100644
--- a/CREDITS
+++ b/CREDITS
@@ -229,6 +229,10 @@ S: University of Notre Dame
 S: Notre Dame, Indiana
 S: USA
 
+N: Kai Bankett
+E: chaosman@ontika.net
+D: QNX6 filesystem
+
 N: Greg Banks
 E: gnb@alphalink.com.au
 D: IDT77105 ATM network driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 6b91bcbbc22f..2657a35dd96e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17174,6 +17174,12 @@ F:	fs/qnx4/
 F:	include/uapi/linux/qnx4_fs.h
 F:	include/uapi/linux/qnxtypes.h
 
+QNX6 FILESYSTEM
+S:	Orphan
+F:	Documentation/filesystems/qnx6.rst
+F:	fs/qnx6/
+F:	include/linux/qnx6_fs.h
+
 QORIQ DPAA2 FSL-MC BUS DRIVER
 M:	Stuart Yoder <stuyoder@gmail.com>
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
diff --git a/fs/qnx6/README b/fs/qnx6/README
deleted file mode 100644
index 116d622026cc..000000000000
--- a/fs/qnx6/README
+++ /dev/null
@@ -1,8 +0,0 @@
-
-  This is a snapshot of the QNX6 filesystem for Linux.
-  Please send diffs and remarks to <chaosman@ontika.net> .
-
-Credits :
-
-Al Viro		<viro@ZenIV.linux.org.uk> (endless patience with me & support ;))
-Kai Bankett	<chaosman@ontika.net> (Maintainer)
-- 
2.17.1

