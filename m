Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9A538E57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 12:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbiEaKAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245390AbiEaKAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 06:00:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39682172;
        Tue, 31 May 2022 03:00:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id wh22so25593194ejb.7;
        Tue, 31 May 2022 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/d7KhR0z000Hs/IA+QwE65RKZidQwaLcmmsuNIx8Rk=;
        b=jlmbD0lwi6rUzLqjCUjXO1DNk/hQQjjKuOHlr6e8k22ViZDgKVzUz93W5EYx10np0/
         Xh2ALDpQ6yIyeIe45k8a2sJl4amrOM+41IYI/txxFcT5UiQiv8db1GOFm4nHNEit2nsT
         t6Lk/Ru1k3XgR2+zaythLqoBQNPWx0Sq35QwntG6y1Dagw4XSMLJoD/MgsY7xDjJfu0E
         RDqGAq6AuvEeKHy4q+b3C0gubIRXhKGHY2dodSyKGXyL5yGmdZeVPY58oq3Uvft0jR6c
         xVeACw7Idp6VxMTOsOvsq4Sy7+v2x6+Yzp3O+8Z7K9aogRlAi/UblC7icee5ruMftqkd
         rgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/d7KhR0z000Hs/IA+QwE65RKZidQwaLcmmsuNIx8Rk=;
        b=u47bou2MSfYPwxeW8YW0TkiX6HUA8TA8YI7++5N3En49HffsuAFkr1Merkv28FTVyd
         eULoiFPy+7MxTsEg4935/+8rT1n98/otIEgG+C7+8RFZFUxKXpY4Gb79KZCpbl05vicY
         KMCrEoJxB0swc5vOC/IpQMMycp/PQXZawJocIoNCkxLT0KnHwqP86HjpS5mt9VptbSZ6
         MGuaNTsnK0EyvBjUzRvPJ0rprqQ6HbBUDhYz1QSNHuTKWEe19KUxGUpE0gLheYj7s4bQ
         +xSH4CxfVPutVDTIDF6QuGG5IlwWqpb/181aN3JyOOyxK0eQNRDVs4IdundU2GZxMhtz
         tWug==
X-Gm-Message-State: AOAM531Ytxi6chJGAN7tPJFmeBSF7oTfh4ZRTBOoXsdivCKgDWxJRpvF
        cmF+JiEZGfWd5qeoA19hZWmXgd7iFwY=
X-Google-Smtp-Source: ABdhPJyprdDlfIYDCtP3JSXlPBRA6lpUaNM/DoimNqu/NR7jJ7DMpCFACqCWHS14mUBV5Y9XUPfxDg==
X-Received: by 2002:a17:907:9483:b0:6ff:b1:467a with SMTP id dm3-20020a170907948300b006ff00b1467amr31727121ejc.683.1653991211970;
        Tue, 31 May 2022 03:00:11 -0700 (PDT)
Received: from able.fritz.box (p5b0ea02f.dip0.t-ipconnect.de. [91.14.160.47])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402018d00b0042617ba6389sm582062edv.19.2022.05.31.03.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:00:11 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     christian.koenig@amd.com, alexander.deucher@amd.com,
        daniel@ffwll.ch, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, hughd@google.com,
        andrey.grodzovsky@amd.com
Subject: [PATCH 01/13] fs: add OOM badness callback to file_operatrations struct
Date:   Tue, 31 May 2022 11:59:55 +0200
Message-Id: <20220531100007.174649-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531100007.174649-1-christian.koenig@amd.com>
References: <20220531100007.174649-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

This allows file_operation implementations to specify an additional
badness for the OOM killer when they allocate memory on behalf of
userspace.

This badness is per file because file descriptor and therefor the
reference to the allocated memory can migrate between processes.

For easy debugging this also adds printing of the per file oom badness
to fdinfo inside procfs.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 fs/proc/fd.c       | 4 ++++
 include/linux/fs.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 172c86270b31..d1905c05cb3a 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -59,6 +59,10 @@ static int seq_show(struct seq_file *m, void *v)
 		   real_mount(file->f_path.mnt)->mnt_id,
 		   file_inode(file)->i_ino);
 
+	if (file->f_op->oom_badness)
+		seq_printf(m, "oom_badness:\t%lu\n",
+			   file->f_op->oom_badness(file));
+
 	/* show_fd_locks() never deferences files so a stale value is safe */
 	show_fd_locks(m, file, files);
 	if (seq_has_overflowed(m))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23..d5222543aeb0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1995,6 +1995,7 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+	long (*oom_badness)(struct file *);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.25.1

