Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534E1158EB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgBKMkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:40:53 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54258 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbgBKMkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:40:52 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so1270849pjc.3;
        Tue, 11 Feb 2020 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1fCpWU/d5xs7NUCvrmDKGMeeRnc0bIclJxjOjXgUjow=;
        b=IrfQbQ76rup+LAY4+H50Es2hiAZkc1zNAgrNL2k+Zhi003ojxnqXCIXQPmiujwfFYv
         N/Hkq/b8r/YHPaRLoduEHz59MvVyGzMTy6IFsON+wwQQzn4mPauQbOYnKHMrBPVpZ6ef
         o6Jkeg573Z1R20vcz//q3ZSQ04v9IoCicw85y56MEiVNUDnjYfvtTEKdBTQpPRHxMXyc
         ZOrCURaEIkXIyZ2+N+pvpeLk0jhIMRpedPpPfTurSTdsNTnnD7YpsLfnArePEhTLKJOc
         rYLciqV/ttGc6V0/Q1D11RDw+62lQxQ0yVcYkCXVCcjqLNphpfUI1D9Byu+WrBDMkl5g
         Ew0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1fCpWU/d5xs7NUCvrmDKGMeeRnc0bIclJxjOjXgUjow=;
        b=IaTd1EOtnUyrkDuHi+PMy2mqUJ0NNFgyUJXSAD2nmVmuy8+uMlj4A5SLd/61zB1DU5
         x1j2LdaVmHoCjM1Ymy4ycfHFWim7GGwZMPlJuN58F/TwtSArKMdqb1M/nMRkiwAQWElp
         zUUHwgaTJ01gNsngmeSIhwZkfIjP7XBFxZy/x16uZ09+CcLl9yCPCok6IufWYyqRFTeU
         JXGotzZMepGvVeex4Xq2AwTcBfA8eKTgrfS4fN3teAaKc7n7t4g6oaaFDJfuRvyAzCbA
         EldP/LIdsChBH5EaxmAEQrgu2I77QmDduVK0wgRBYf/x0dv3wmzm3EarDHpNQ2GwSRyJ
         KiWg==
X-Gm-Message-State: APjAAAUWuczQDVu3MpWNikOOgdbPe/2b7V3jz0OxPrCinjlzMr6FxwnH
        3RA1QbfHZTkHYoBy/ZMxipg=
X-Google-Smtp-Source: APXvYqwCbqNlO3+v0lqITUqYR+IlHYPL+6mgE0IZx2bC0+Wsb/IY0cx2r/upy5kmK6IkFoGgwT9rnw==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr17269417ple.226.1581424852284;
        Tue, 11 Feb 2020 04:40:52 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:40:51 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 06/18] staging: exfat: Rename function "ffsReadFile" to "ffs_read_file"
Date:   Tue, 11 Feb 2020 18:08:47 +0530
Message-Id: <20200211123859.10429-7-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsReadFile" to "ffs_read_file" in
source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5080de9b289a..c7f56f77e4bb 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -662,8 +662,8 @@ static int ffs_create_file(struct inode *inode, char *path, u8 mode,
 	return ret;
 }
 
-static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
-		       u64 count, u64 *rcount)
+static int ffs_read_file(struct inode *inode, struct file_id_t *fid, void *buffer,
+			 u64 count, u64 *rcount)
 {
 	s32 offset, sec_offset, clu_offset;
 	u32 clu;
@@ -2329,8 +2329,8 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 			err = -ENOMEM;
 			goto error;
 		}
-		ffsReadFile(dir, &fid, EXFAT_I(inode)->target,
-			    i_size_read(inode), &ret);
+		ffs_read_file(dir, &fid, EXFAT_I(inode)->target,
+			      i_size_read(inode), &ret);
 		*(EXFAT_I(inode)->target + i_size_read(inode)) = '\0';
 	}
 
-- 
2.17.1

