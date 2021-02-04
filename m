Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DDA30FAB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhBDSCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbhBDSCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:02:02 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F35C0617AA;
        Thu,  4 Feb 2021 10:01:22 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id r12so6912215ejb.9;
        Thu, 04 Feb 2021 10:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7JNZbvaxyyiVUEUuHjJrc3CdySwOKE/EKFzRbZUqUUg=;
        b=hiMJQ9vF7YbkvRXH3O+AOwtAWnxiBZvxQNCF1IGUs2NnGsLJzXxfxX7ftJV1wysT7Z
         TgsIoUOvxmiXsWFqKCp4q0oYmSoYLXQFOvFHhaIAENBPsWmiHammQqmgrCdLkO4soCOJ
         XKmRoWel9urehbFwXRJP7PCZiOKqlsoB03WhNd0vGQLvAlfSouM8OoST/J7t9OeEaQlW
         XORoIi+dw3j26fpfUZwOf5QnRdeUoWZ8imUvbqcrTJuElUpnKYmUiwW1UF/NkVZ9/1gs
         HPPkZ53IGPb3tsomiKsym24p7d9MycyO6E7MeiXKNlYyQX2lORosaByln3weoUWDooWA
         zOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7JNZbvaxyyiVUEUuHjJrc3CdySwOKE/EKFzRbZUqUUg=;
        b=LnbjevYrpkR+t5p4kDZRK9FKNfdwU3WgqWnOnN4GcMA1pzfxRs78tvxk/Y1KfUeWhk
         gpywYwAOoZtuDi2uaQjFGiUrWXbJMhG5phWp+U6UnGVctybixOZJ0fBS88KdHRlgMkdv
         76Eaa9SfwSTs4E5i9rXmQddfdbYWIGzo5eoT7gPHCD7TwRtqwQAlDRLMNSwkqy1aEs/l
         gYEmWk9DkZAmLY3OivaFRBf7qrjSfsn4UDb8VQUo+3JnItTNq+/ugFgjIfUxBV0j0IGO
         PdaGsnDt3Mg+SAOLe9GEnjQ+DVfcDCm3X1QAbhRe32AF7iKmQMnUq61AumCmn37M7eK3
         u9aw==
X-Gm-Message-State: AOAM532MCJ1ZGRDY+0skk3MiPWAgl2BTpKyzp6w4vtsrpnI9Wy4n/FqX
        Fpi1R6dvUZmixN4ePRONXq0bvNxQ/ElE1w==
X-Google-Smtp-Source: ABdhPJyjypiTFKF0Q3mvhJejJev3oKMFhRkWfyAo/Bm8UL47R/JdadkhHM1U9tKVIz/aVFBkh4p3Gg==
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr333055ejz.80.1612461681675;
        Thu, 04 Feb 2021 10:01:21 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de7:9900:24e0:4d40:c49:5282])
        by smtp.gmail.com with ESMTPSA id bo24sm2810326edb.51.2021.02.04.10.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:01:21 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 4/5] fs: update kernel-doc for vfs_tmpfile()
Date:   Thu,  4 Feb 2021 19:00:58 +0100
Message-Id: <20210204180059.28360-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
References: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 6521f8917082 ("namei: prepare for idmapped mounts") adds kernel-doc
for vfs_tmpfile(), but with a small typo in one argument name.

Hence, make htmldocs warns on ./fs/namei.c:3396:

  warning: Function parameter or member 'open_flag' not described in 'vfs_tmpfile'
  warning: Excess function parameter 'open_flags' description in 'vfs_tmpfile'

Fix this typo in kernel-doc of vfs_tmpfile().

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 64a841dfbb3e..9f7d260ffb4b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3379,7 +3379,7 @@ static int do_open(struct nameidata *nd,
  * @mnt_userns:	user namespace of the mount the inode was found from
  * @dentry:	pointer to dentry of the base directory
  * @mode:	mode of the new tmpfile
- * @open_flags:	flags
+ * @open_flag:	flags
  *
  * Create a temporary file.
  *
-- 
2.17.1

