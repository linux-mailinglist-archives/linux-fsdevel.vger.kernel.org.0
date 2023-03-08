Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545776B0B61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjCHOgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCHOgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:36:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54762CD677;
        Wed,  8 Mar 2023 06:36:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id da10so66694382edb.3;
        Wed, 08 Mar 2023 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678286203;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/+VzXSJ8+YNGpmelOUnAH17WkM2Hm4y5z7wV36d1jY=;
        b=qi6zRgB81pkWFhchCRcNzbw0HiD8AEmb8/eTczQh8ZtltZIxlExx//LxydEFymwbUV
         oK4DTTy1V02iaQHMAZ43rOFVstoIim4YJfX78sO6Zk+dQM2+OIDgxjvuhn+Ji/x4qs9b
         Mi+JJ+jX9CtL69A4NcvkSAKyW1b4KJ4yW/WTnfe8PveLfscr5be5tCikdLN1Xox0fpQN
         ljMnV84tGH0l8Lra+zhLwcsTu80sD2L4QJZCZ19b/JAgi4T2Q8gU171gRfdv1j9VN206
         zR4PxmtV3Km33UJWsipubzVkpq1R6ZY8SWcaAAyxT9jWTadi9vgGogmq/CD5d8rEGas0
         9Biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286203;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/+VzXSJ8+YNGpmelOUnAH17WkM2Hm4y5z7wV36d1jY=;
        b=D2LmOGNUknvlSKi7aG/MN5MhgDfmnKkFwMxtPwyahS+w+ONBZlccUizU1Y6cQHqMdl
         /bCD0rcmx0zvSI5o566md/md3FPsjmb8f6V27J/JqzNrScwkm7CsbY3qhc9u08W2OVXo
         UD31ys3SmIlEdk0G4HrMXQFjHlTaiLakOZ60tPzK2vekqP4Jq8xyjZmfqvRZKcDS3aeR
         1+Ce0UlW8EzNZJ3obrAxSh6csbwVTMTgK/UkNS0eXSi70mBX5BcpRcQ+yXXoBTIhHcUP
         M2aloJxtQU1hS7acEi2T5ApxfoA/wRh4QwDQbiFqiNnrTE2gmTDiNuBlii52WKpIzF4G
         J2tg==
X-Gm-Message-State: AO0yUKWsQ3S3/SvzhV7oEIBc51qIhFE68rqkzBG6IlzU9d+daQBG4lis
        Q8/0nPfEYnR4pxIG234jpf0=
X-Google-Smtp-Source: AK7set/gqt5L6DTs27kbRHkVnthQnbYw+0uzGm9HfqdTreImKlF8KBVpAC4ChClQEZ3wSFKGBq4pgA==
X-Received: by 2002:a17:907:7fab:b0:8b2:8876:6a3c with SMTP id qk43-20020a1709077fab00b008b288766a3cmr23360634ejc.29.1678286202830;
        Wed, 08 Mar 2023 06:36:42 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:c4be:f7db:77fd:b9e5])
        by smtp.gmail.com with ESMTPSA id p7-20020a50cd87000000b004aef147add6sm8253619edi.47.2023.03.08.06.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:36:42 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair a malformed T: entry in IDMAPPED MOUNTS
Date:   Wed,  8 Mar 2023 15:36:40 +0100
Message-Id: <20230308143640.9811-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The T: entries shall be composed of a SCM tree type (git, hg, quilt, stgit
or topgit) and location.

Add the SCM tree type to the T: entry and reorder the file entries in
alphabetical order.

Fixes: ddc84c90538e ("MAINTAINERS: update idmapping tree")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2091b15ae695..a51fdde146db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9889,10 +9889,10 @@ M:	Christian Brauner <brauner@kernel.org>
 M:	Seth Forshee <sforshee@kernel.org>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-T:	git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
 F:	Documentation/filesystems/idmappings.rst
-F:	tools/testing/selftests/mount_setattr/
 F:	include/linux/mnt_idmapping.*
+F:	tools/testing/selftests/mount_setattr/
 
 IDT VersaClock 5 CLOCK DRIVER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
-- 
2.17.1

