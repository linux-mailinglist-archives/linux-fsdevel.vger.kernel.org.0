Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F01414F94F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBASCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 13:02:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41804 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgBASCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:02:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so12531368wrw.8;
        Sat, 01 Feb 2020 10:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NM/pbohHEKe89fsQ4Z0K2U4L1TVRzefhLxg0l5jnnS4=;
        b=GRfsATbnaYmhVnY3VBTa0PZDoYMA8sYUob6BnKmwM3YUSx3gyUzNHimjN7ts9Q5jaT
         2BReX7H+x4Jq5C83bKT5C7h/pdW8sUIVmNPcCbaSUG568kIaafA+6qE5gsYzcOYywAqh
         gcJQ38aG4nk4t7DerKzJQDlF4JGsH2V0FfOxgpimNgQ6jlprzlrDu5i9jUuH4gQgJWNc
         rT5Y4NWnfhKVwupBOOm3FltFNfiUbeIwHnJBC2TGo7QgP3E0vzdvbKWduwRI5gFdfrgY
         Dxj4aHKEj/GfdWy4RENxipOiTCMVm3cGvAYUXkAFZt8vnEQQCuw4o2Xl3maiMqsGsVYg
         4X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NM/pbohHEKe89fsQ4Z0K2U4L1TVRzefhLxg0l5jnnS4=;
        b=FWAnqM8cYWTxPzG/oYu8UWJIwmf8PX9riapAhckk8pOZeSzIGCg8HorDH8c4snjsld
         jbNWDjhKaw0MmdXYPBUDLMWnyTWn6I1QgoPBdVNBOiSy67AGfqYQoXL7SN2Rlwt1woEd
         SUqWQWsa2urfQfUF/hVHTsZ3z8Zq0hmZ9NQ/VAqwkTUzk0roYOUepHLpPwJraHfdwVJg
         yyQ5kat1Db2iVXnxHcKp7FoVX2cjIfYi6sT/hiEhapidFsUXPOZvs2rHgvIwY26lMpeC
         gtA3v0DfnGnk9c5Aw85l0GoQ5ZY/061Obam/blvfhj6ZnPBqWcZh6qxl/onrZ8LFvGMv
         N7xQ==
X-Gm-Message-State: APjAAAWR0zqsfDpd46f20h3K2u+5Ac97lZb1Xss+3m7VlJYclL2c96V4
        8Cdc0hUpTZp3C2O8nkaG4IQ=
X-Google-Smtp-Source: APXvYqw+cHb2Gw5j53CxGQhNp5e6C2hSGkdHgk7Wtg4mnIvYBhAc58qyZNHoTGQOVSHqjtFSYVCzAg==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr5687411wrn.351.1580580163219;
        Sat, 01 Feb 2020 10:02:43 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d5f:200:619d:5ce8:4d82:51eb])
        by smtp.gmail.com with ESMTPSA id q130sm16814333wme.19.2020.02.01.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 10:02:42 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify radix-tree testing entry in XARRAY
Date:   Sat,  1 Feb 2020 19:02:34 +0100
Message-Id: <20200201180234.4960-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The initial commit 3d5bd6e1a04a ("xarray: Add MAINTAINERS entry")
missed a trailing slash to include all files and subdirectory files.
Hence, all files in tools/testing/radix-tree were not part of XARRAY,
but were considered to be part of "THE REST".

Rectify this to ensure patches reach the actual maintainer.

This was identified with a small script that finds all files only
belonging to "THE REST" according to the current MAINTAINERS file, and I
acted upon its output.

Fixes: 3d5bd6e1a04a ("xarray: Add MAINTAINERS entry")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Matthew, please pick this small fixup patch.

applies cleanly on current master and next-20200131

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f77fb8cdde3..4ebcc2f09028 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18198,7 +18198,7 @@ F:	lib/idr.c
 F:	lib/xarray.c
 F:	include/linux/idr.h
 F:	include/linux/xarray.h
-F:	tools/testing/radix-tree
+F:	tools/testing/radix-tree/
 
 XBOX DVD IR REMOTE
 M:	Benjamin Valentin <benpicco@googlemail.com>
-- 
2.17.1

