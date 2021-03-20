Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129AC342F49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 20:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTTgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 15:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTTgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:36:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3353BC061574;
        Sat, 20 Mar 2021 12:36:11 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j7so9496185qtx.5;
        Sat, 20 Mar 2021 12:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMHEua3Rqr0sCD6Y2P3gntqRo/krgVUNh1JAQn8GyqI=;
        b=UFGNAVvkEoRnHc3HK4NfJKOAVcYOX8AbHLfLejALUCwpYyP5OSR1VL5ezpsRSecU9K
         TahqbTMkoMIhMQU66MwFlPBMZZfoy7Hi6oxGimaa2jz1ZdcExiagrh2XuO1u9RENIPEW
         KXOkKIQc+OaDpMWjX1GeDnkgAbBZQOEtqgB1v/eeTL8N9Vr9sVvsuRk+oKaDS7i8o0PC
         SYq0NHL+oyzbJU8MmGkiIoBHoM6n2eV4UQ8WfJ+cDpURfB+hhfwQWvllW9eeJ+sF/J0K
         Jv6dl8Vx+Ve/yiEXRGs7f7yAoIkGy8alJW5/5rYty7FpHkhSS23RP0I017q238TNJETa
         DBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zMHEua3Rqr0sCD6Y2P3gntqRo/krgVUNh1JAQn8GyqI=;
        b=qteq9SW0rId0W1UlKMuYsHaBoSLjV3ekBqv83T/MOJBq7cX/HlzVGZiNKKcPyeJeDl
         /rFE5TqhDT6foPPXYMU9ZmOphVUL8OROeivqlwpXhUi6yKmbZMUZtJkYRbyiWnR2lTKX
         bHzaH2L0/lLYdpftNLmZtNHQHkCgvLAHCEUM0QQfnmYSjyJlw3nW+aAGiog07RnCDWJj
         H5iLvtUHJqp6ld3MGHVc0aYzMPz/SRkN5m0LPZDVow9BYi23id4Asruqao33Ecy4ngm9
         H8YG9OPfiWBqM6ebBH7R7jqxA2wFT1zIKc5fz0T7Ab01KMHBg6r4hljHTMWg1jSpnlX0
         gJwg==
X-Gm-Message-State: AOAM53339Rrwn79+nb8OOJEQbbt97xRpwpmUcoka0GcY3JV4PkfNLwZm
        YYzIWMMoRtG9jdlYKWAwbT8=
X-Google-Smtp-Source: ABdhPJze/j5CMlUibXCG6vXffBskEqG4/hc9Ue080S1Fb0GjnifY7PJTf7bKuvJ0dFT/weszgUmGig==
X-Received: by 2002:ac8:70d1:: with SMTP id g17mr4104088qtp.380.1616268970242;
        Sat, 20 Mar 2021 12:36:10 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id i6sm3692813qkf.96.2021.03.20.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 12:36:09 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] fs/attr.c: Couple of typo fixes
Date:   Sun, 21 Mar 2021 01:03:53 +0530
Message-Id: <20210320193353.30059-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


s/filesytem/filesystem/
s/asssume/assume/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 fs/attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 87ef39db1c34..e5330853c844 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -250,7 +250,7 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
 EXPORT_SYMBOL(setattr_copy);

 /**
- * notify_change - modify attributes of a filesytem object
+ * notify_change - modify attributes of a filesystem object
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @dentry:	object affected
  * @attr:	new attributes
@@ -265,7 +265,7 @@ EXPORT_SYMBOL(setattr_copy);
  * caller should drop the i_mutex before doing so.
  *
  * If file ownership is changed notify_change() doesn't map ia_uid and
- * ia_gid. It will asssume the caller has already provided the intended values.
+ * ia_gid. It will assume the caller has already provided the intended values.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
--
2.26.2

