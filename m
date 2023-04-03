Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E766D4A5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjDCOqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjDCOq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:46:27 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE16016967
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 07:46:05 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2DE0C3F23C
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533139;
        bh=bVeWuEcFFA9BOaey9u9VyyM5TuRxdAhm6TBxfMNpyiQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ShYw+yvJL3g/L8PFFXuhOLMPSmHDcwKtiig9o+g++ghQw5cyNK5YLs1v/t0eeO+5M
         pVi+aMy3pt6lzrIFAnqeA9YKnyiXRRjjfmeHJc2+hqUc2mrSKz5AlO/HMyWmuvzWYe
         kEWpW4V9lU1nJuTfbaGCyBvv5guwZ3xPpCLSAhQ0bepQEysnDWYE+bIJ9mxuEVgXAV
         VAVDj70o5s5AtOk22X04GNoQGCjSzqmCOq6W//FZV9XzeYFGvGnsM0pUMwGkCRQuwk
         fMfbtHQq3yC2JwgP/g0fBi+VknXyPgkGB3xJeGDjYwTZOS0gOg7Sr0gYNZn28wJ/EE
         pIlrdoSwLaAUA==
Received: by mail-ed1-f69.google.com with SMTP id u30-20020a50c05e000000b0050299de3f82so5792556edd.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVeWuEcFFA9BOaey9u9VyyM5TuRxdAhm6TBxfMNpyiQ=;
        b=O8tZ2L5udIPLSL4zgNgHDJYoGYjLS1PSqWp3BuCU5Si+iAWoBvZjq4mLJHRp/a4W+u
         xHlP/vcLc+axFu2Yo+X0afta8FvIrt52WIPRZNk5umyVijnTIDu/bCD6nJ5XLqeQmDkA
         tOJxs5z3+2Tjly/Xt0rfpanb5JtxoDx5IFNZY2tqbzxF3zOIvOOqjRx7ntk4fsNE4L4s
         pHw+3MDZCxkFOfhwBnhe3JqLHve/ehlXmt+qUh/HRppfc9fkmZR+3Q1mHbWV5nA4OcIV
         2M9IM/6ImlhY0TWRiK6UTa9u+/wzsVqhCN626zbaR+ueC/CXhQsUNSVn1pdzA9pGYT66
         paLw==
X-Gm-Message-State: AAQBX9eVfYU6RIcFa6vKj4dc5YtaTJwyDJ3KVVl+frUg/ROPgnk443vq
        HRlUeBlIxh6PvtZaGvzz7LUpktoLZnsyIr83GG6mbuaQGdlRirdpyI0oKyw9qERFOUW0QSkfIGa
        0rhufpG4PF/ItjYOuoJswNQwTduJVE+Sx8zKIJ58ALCI=
X-Received: by 2002:a05:6402:8d9:b0:4fe:19cb:4788 with SMTP id d25-20020a05640208d900b004fe19cb4788mr32810321edz.42.1680533138915;
        Mon, 03 Apr 2023 07:45:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350bS7ivnPsfOURPfqkG6FOqAtwZfDP530jIkSKpQXVUZ0EH3RYfr+0dokF69qX0VO76OHuKjPA==
X-Received: by 2002:a05:6402:8d9:b0:4fe:19cb:4788 with SMTP id d25-20020a05640208d900b004fe19cb4788mr32810305edz.42.1680533138636;
        Mon, 03 Apr 2023 07:45:38 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bd076.dynamic.kabel-deutschland.de. [95.91.208.118])
        by smtp.gmail.com with ESMTPSA id i5-20020a50d745000000b004fa19f5ba99sm4735804edj.79.2023.04.03.07.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     flyingpeng@tencent.com,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Bernd Schubert <bschubert@ddn.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH v2 2/9] fuse: add const qualifiers to common fuse helpers
Date:   Mon,  3 Apr 2023 16:45:10 +0200
Message-Id: <20230403144517.347517-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230403144517.347517-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/fuse_i.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 69af0acecb69..6d3d3ca4f136 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -870,32 +870,32 @@ struct fuse_mount {
 	struct list_head fc_entry;
 };
 
-static inline struct fuse_mount *get_fuse_mount_super(struct super_block *sb)
+static inline struct fuse_mount *get_fuse_mount_super(const struct super_block *sb)
 {
 	return sb->s_fs_info;
 }
 
-static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
+static inline struct fuse_conn *get_fuse_conn_super(const struct super_block *sb)
 {
 	return get_fuse_mount_super(sb)->fc;
 }
 
-static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
+static inline struct fuse_mount *get_fuse_mount(const struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb);
 }
 
-static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
+static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb)->fc;
 }
 
-static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
+static inline struct fuse_inode *get_fuse_inode(const struct inode *inode)
 {
 	return container_of(inode, struct fuse_inode, inode);
 }
 
-static inline u64 get_node_id(struct inode *inode)
+static inline u64 get_node_id(const struct inode *inode)
 {
 	return get_fuse_inode(inode)->nodeid;
 }
@@ -905,7 +905,7 @@ static inline int invalid_nodeid(u64 nodeid)
 	return !nodeid || nodeid == FUSE_ROOT_ID;
 }
 
-static inline u64 fuse_get_attr_version(struct fuse_conn *fc)
+static inline u64 fuse_get_attr_version(const struct fuse_conn *fc)
 {
 	return atomic64_read(&fc->attr_version);
 }
@@ -923,7 +923,7 @@ static inline void fuse_make_bad(struct inode *inode)
 	set_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state);
 }
 
-static inline bool fuse_is_bad(struct inode *inode)
+static inline bool fuse_is_bad(const struct inode *inode)
 {
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
-- 
2.34.1

