Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD07E69D1D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 18:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjBTRDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 12:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjBTRDC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:03:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C16E2057C;
        Mon, 20 Feb 2023 09:02:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cq23so6955650edb.1;
        Mon, 20 Feb 2023 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CjDGIyXrDVwRmg3z7SdubnJ/uKdcf6AES35XcMjYHxg=;
        b=Gd+ayI5ehL9eskS8eBUUlMzeQ0htprUQRitwDun1kBGVL+PmuNsIlDlgGA4Ip7KFSZ
         VqIlS+uqJx8GrI0e8TiNYQom3zfxhzZX5ppD9t8EoXf5rS5faZr9z37pX/LOwT5oW3Go
         GGsLsYMNgs4N7onl5RjpbLp30FsnHeCDgcm69ps5EoS6VwdfP6SYD95oW9T85lfP8EdP
         1sI8KnRsEr5Nllkd9+Fdj0vjhaYElM7+AYo00HA8VCKlzlkFR+k8zXo+04xoDl/MDea2
         al7ZvJoRZI9812rUv+U0pOfFklsfb7vvbPvyMVQGueR5uWUDABL81osMRu4B05ZH5yfL
         Cr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjDGIyXrDVwRmg3z7SdubnJ/uKdcf6AES35XcMjYHxg=;
        b=a+HvFGN9YvBCTG2OjVaHm/21kqbNsIEYVrJgvCH0R5afcUp0ROoxjVv5omEbllreCz
         pd+97KCMZXEXaOlRxBufd8Mptb9YyRiEFunMB3gjgc0WddR04hCiHDcQXQJHpmkM7dcr
         o/RSejqIcIuSFfW2XLwVbIm/wNGs2xn81LqyOOXklDhh2Vy+7EJ8YIBGUtzj1RbDcxKc
         o4K/gR2smehoUjJqFOdn0/IpqsZx7bxondeDf0qkDsyHA1oSWkY2QadbCxeODEzYhN3t
         P7o+z2PIptJFfbn+ojPRjehM2Hmge3a2oJvJ12vjVlKsw4X6z4HsaiOxXXML+3kkoHBc
         27tA==
X-Gm-Message-State: AO0yUKWOjQMIX77YSmb/2IbPxC4bginyqGVHL+zrWyFDhN3rxDQ1DSj7
        dpNoLDPjx0GQwsfsBsecOtk=
X-Google-Smtp-Source: AK7set/NYHadUI1sUQ1e6koWL6pGtag4aMM383bmzuLt+OEKftNObrKyUxbK9G894tecB3o2jEnHBg==
X-Received: by 2002:aa7:df96:0:b0:49d:a60f:7827 with SMTP id b22-20020aa7df96000000b0049da60f7827mr2728886edy.6.1676912556763;
        Mon, 20 Feb 2023 09:02:36 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:ad0f:1d29:d8a4:7999])
        by smtp.gmail.com with ESMTPSA id h10-20020a50c38a000000b004ad75c5c0fdsm927227edf.18.2023.02.20.09.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:02:36 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Anders Larsen <al@alarsen.net>,
        linux-doc@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] qnx4: credit contributors in CREDITS
Date:   Mon, 20 Feb 2023 18:02:10 +0100
Message-Id: <20230220170210.15677-3-lukas.bulwahn@gmail.com>
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

Replace the content of the qnx4 README file with the canonical place for
such information.

Add the credits of the qnx4 contribution to CREDITS. As there is already a
QNX4 FILESYSTEM section in MAINTAINERS, it is clear who to contact and send
patches to.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 CREDITS        | 12 ++++++++++++
 fs/qnx4/README |  9 ---------
 2 files changed, 12 insertions(+), 9 deletions(-)
 delete mode 100644 fs/qnx4/README

diff --git a/CREDITS b/CREDITS
index 07e871d60cf0..b6c93e0a62c3 100644
--- a/CREDITS
+++ b/CREDITS
@@ -890,6 +890,10 @@ W: http://jdelvare.nerim.net/
 D: Several hardware monitoring drivers
 S: France
 
+N: Frank "Jedi/Sector One" Denis
+E: j@pureftpd.org
+D: QNX4 filesystem
+
 N: Peter Denison
 E: peterd@pnd-pc.demon.co.uk
 W: http://www.pnd-pc.demon.co.uk/promise/
@@ -1263,6 +1267,10 @@ S: USA
 N: Adam Fritzler
 E: mid@zigamorph.net
 
+N: Richard "Scuba" A. Frowijn
+E: scuba@wxs.nl
+D: QNX4 filesystem
+
 N: Fernando Fuganti
 E: fuganti@conectiva.com.br
 E: fuganti@netbank.com.br
@@ -2222,6 +2230,10 @@ D: Digiboard PC/Xe and PC/Xi, Digiboard EPCA
 D: NUMA support, Slab allocators, Page migration
 D: Scalability, Time subsystem
 
+N: Anders Larsen
+E: al@alarsen.net
+D: QNX4 filesystem
+
 N: Paul Laufer
 E: paul@laufernet.com
 D: Soundblaster driver fixes, ISAPnP quirk
diff --git a/fs/qnx4/README b/fs/qnx4/README
deleted file mode 100644
index 1f1e320d91da..000000000000
--- a/fs/qnx4/README
+++ /dev/null
@@ -1,9 +0,0 @@
-
-  This is a snapshot of the QNX4 filesystem for Linux.
-  Please send diffs and remarks to <al@alarsen.net> .
-  
-Credits :
-
-Richard "Scuba" A. Frowijn     <scuba@wxs.nl>
-Frank "Jedi/Sector One" Denis  <j@pureftpd.org>
-Anders Larsen                  <al@alarsen.net> (Maintainer)
-- 
2.17.1

