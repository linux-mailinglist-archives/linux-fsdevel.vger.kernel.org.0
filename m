Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3B36458D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbhDSOCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 10:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhDSOCW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:02:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA35C06174A;
        Mon, 19 Apr 2021 07:01:52 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g8so56165786lfv.12;
        Mon, 19 Apr 2021 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OHJkleqpyvjmiOFbDvAvEGD009+ja/8LFw1JG/SPO0=;
        b=TgOIIOC470Eb8w3o0XnUaNSscLa7QU5h7kviUpR1xOQicCKbGE+fkUsrrAEclB9sQR
         3hfyknkYirE2Up5E+vlV6q9Q6hsVsGyWgrEkkFWHzb5msn2hQW6fx1T16UhlnqRZRzb/
         rfpmA2s4dxnR+Zc7cH2Tw34cNY7eGh26K8EZNp3NOChwg/DApASZadZzrypdJHe7FXLn
         amUQxDr/en88BM7lWnEAJeQ98M2FlkN7uws34juYBBNnaI/9lhCTbsrkwJuB/BQ8OfLG
         MaA1mZYfemfGJ0CxMstqf3k9sPgITBRrgtCyfbS0n41Rnn2ic+v9qXnhhHbAhBvLoMum
         s+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3OHJkleqpyvjmiOFbDvAvEGD009+ja/8LFw1JG/SPO0=;
        b=jSUSr9xWo4C/SAfvll4iEzfHmkCU1SVnx1MEYOFC388mkranm/xeGAF4KpunzO9G6r
         gmmJ6LO74hoD0a3eTJRzcVVph6P3bSe40ZPZmmXVVX3Sx2nAO5KoEAMygDFxxMdJhrFj
         pwd6mLqtkrxpsLDZr8mOiuskm3rx2rLLn2/dTFstNn7oLccDhj5sictSEn7k18rO3i86
         b7u4RPuaQqT5XO/EPEp3YOhJqYuCE8vh9vtT4yKHeAM8mLq8Ii10cPj7V7Rl68d1tURy
         y7I0/nofXXpyqSkzd0kO4iEb4lXKFv1OZpZAYb/NDaEw42fLQiG6qYxFo4xSsZFf1xR9
         HA0w==
X-Gm-Message-State: AOAM533NtpkG3IEJfz3G7526FuCVFqh1LB3y02UW1bNVe6kwLRxR8KMV
        aQUzxSzbkUOB/RP21TdNqrs=
X-Google-Smtp-Source: ABdhPJwETRJ5iomkI7LRrj9Bm5SoC4WDLG8vFZ5DlosZpvnmQnekPbNTlUWCys90B7PC6mDUC6pQDA==
X-Received: by 2002:a19:ee0f:: with SMTP id g15mr3823063lfb.407.1618840911043;
        Mon, 19 Apr 2021 07:01:51 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id m28sm1195023lfq.180.2021.04.19.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 07:01:50 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH vfs.git] MAINTAINERS: Add git tree for the FILESYSTEMS entry
Date:   Mon, 19 Apr 2021 16:01:38 +0200
Message-Id: <20210419140138.22752-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps finding the latest development code.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85ca831d..67317bfd46e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6890,6 +6890,7 @@ FILESYSTEMS (VFS and infrastructure)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
 F:	fs/*
 F:	include/linux/fs.h
 F:	include/linux/fs_types.h
-- 
2.26.2

