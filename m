Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43467748C76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 20:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjGES71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 14:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjGES7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:59:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5080F199E;
        Wed,  5 Jul 2023 11:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BBA9616D8;
        Wed,  5 Jul 2023 18:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEF1C4167D;
        Wed,  5 Jul 2023 18:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583549;
        bh=96h56beXLMAvkoYPxw1Hf+1T9dWrr7543/fVCrKiiH8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SV/pROPiikvWgbuJG9o5j/mdUiyRGcRaEJl1K0hVl0eCHK9Ob+YmgZ0cOVDNwxcd0
         s3XXK3FiPaVML6VBfbeTny5HiSuKA0KEKAjFDlBtEkXvpck7V4KUAdjnzKCg5fiugt
         aiOuDDRaoB7EF/ycBMYU5USexpq/ceGXPIb8HpDBW4vIvyY547qmZyivJt5T6PXA4H
         rtd7d3FTcpVX0DGPx74bauINVbOI0AHI9Zym6FoqdyCXdEJPTgmmD/blFQIJoOkcln
         fC0uEV1EXwoGgwuuPieKxDXph4tQwZUYbTrLEd3zCpi9KdekgoBzBb9kt9un4ZFr7M
         0DXS4Kyxlm/3g==
From:   Jeff Layton <jlayton@kernel.org>
To:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        cmllamas@google.com, surenb@google.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, bwarrum@linux.ibm.com, rituagar@linux.ibm.com,
        ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, dsterba@suse.com, dhowells@redhat.com,
        marc.dionne@auristor.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, luisbg@kernel.org, salah.triki@gmail.com,
        aivazian.tigran@gmail.com, ebiederm@xmission.com,
        keescook@chromium.org, clm@fb.com, josef@toxicpanda.com,
        xiubli@redhat.com, idryomov@gmail.com, jlayton@kernel.org,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, jlbec@evilplan.org,
        hch@lst.de, nico@fluxnic.net, rafael@kernel.org, code@tyhicks.com,
        ardb@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linkinjeon@kernel.org, sj1557.seo@samsung.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        hirofumi@mail.parknet.co.jp, miklos@szeredi.hu,
        rpeterso@redhat.com, agruenba@redhat.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        mikulas@artax.karlin.mff.cuni.cz, mike.kravetz@oracle.com,
        muchun.song@linux.dev, dwmw2@infradead.org, shaggy@kernel.org,
        tj@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, konishi.ryusuke@gmail.com,
        anton@tuxera.com, almaz.alexandrovich@paragon-software.com,
        mark@fasheh.com, joseph.qi@linux.alibaba.com, me@bobcopeland.com,
        hubcap@omnibond.com, martin@omnibond.com, amir73il@gmail.com,
        mcgrof@kernel.org, yzaikin@google.com, tony.luck@intel.com,
        gpiccoli@igalia.com, al@alarsen.net, sfrench@samba.org,
        pc@manguebit.com, lsahlber@redhat.com, sprasad@microsoft.com,
        senozhatsky@chromium.org, phillip@squashfs.org.uk,
        rostedt@goodmis.org, mhiramat@kernel.org, dushistov@mail.ru,
        hdegoede@redhat.com, djwong@kernel.org, dlemoal@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, hughd@google.com, akpm@linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        jgross@suse.com, stern@rowland.harvard.edu, lrh2000@pku.edu.cn,
        sebastian.reichel@collabora.com, wsa+renesas@sang-engineering.com,
        quic_ugoswami@quicinc.com, quic_linyyuan@quicinc.com,
        john@keeping.me.uk, error27@gmail.com, quic_uaggarwa@quicinc.com,
        hayama@lineo.co.jp, jomajm@gmail.com, axboe@kernel.dk,
        dhavale@google.com, dchinner@redhat.com, hannes@cmpxchg.org,
        zhangpeng362@huawei.com, slava@dubeyko.com, gargaditya08@live.com,
        penguin-kernel@I-love.SAKURA.ne.jp, yifeliu@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, ezk@cs.stonybrook.edu,
        yuzhe@nfschina.com, willy@infradead.org, okanatov@gmail.com,
        jeffxu@chromium.org, linux@treblig.org, mirimmad17@gmail.com,
        yijiangshan@kylinos.cn, yang.yang29@zte.com.cn,
        xu.xin16@zte.com.cn, chengzhihao1@huawei.com, shr@devkernel.io,
        Liam.Howlett@Oracle.com, adobriyan@gmail.com,
        chi.minghao@zte.com.cn, roberto.sassu@huawei.com,
        linuszeng@tencent.com, bvanassche@acm.org, zohar@linux.ibm.com,
        yi.zhang@huawei.com, trix@redhat.com, fmdefrancesco@gmail.com,
        ebiggers@google.com, princekumarmaurya06@gmail.com,
        chenzhongjin@huawei.com, riel@surriel.com,
        shaozhengchao@huawei.com, jingyuwang_vip@163.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: [PATCH v2 08/92] fs: new helper: simple_rename_timestamp
Date:   Wed,  5 Jul 2023 14:58:11 -0400
Message-ID: <20230705185812.579118-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705185812.579118-1-jlayton@kernel.org>
References: <20230705185812.579118-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A rename potentially involves updating 4 different inode timestamps. Add
a function that handles the details sanely, and convert the libfs.c
callers to use it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/libfs.c         | 36 +++++++++++++++++++++++++++---------
 include/linux/fs.h |  2 ++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index a7e56baf8bbd..9ee79668c909 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -692,6 +692,31 @@ int simple_rmdir(struct inode *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(simple_rmdir);
 
+/**
+ * simple_rename_timestamp - update the various inode timestamps for rename
+ * @old_dir: old parent directory
+ * @old_dentry: dentry that is being renamed
+ * @new_dir: new parent directory
+ * @new_dentry: target for rename
+ *
+ * POSIX mandates that the old and new parent directories have their ctime and
+ * mtime updated, and that inodes of @old_dentry and @new_dentry (if any), have
+ * their ctime updated.
+ */
+void simple_rename_timestamp(struct inode *old_dir, struct dentry *old_dentry,
+			     struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct inode *newino = d_inode(new_dentry);
+
+	old_dir->i_mtime = inode_set_ctime_current(old_dir);
+	if (new_dir != old_dir)
+		new_dir->i_mtime = inode_set_ctime_current(new_dir);
+	inode_set_ctime_current(d_inode(old_dentry));
+	if (newino)
+		inode_set_ctime_current(newino);
+}
+EXPORT_SYMBOL_GPL(simple_rename_timestamp);
+
 int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry)
 {
@@ -707,11 +732,7 @@ int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
 			inc_nlink(old_dir);
 		}
 	}
-	old_dir->i_ctime = old_dir->i_mtime =
-	new_dir->i_ctime = new_dir->i_mtime =
-	d_inode(old_dentry)->i_ctime =
-	d_inode(new_dentry)->i_ctime = current_time(old_dir);
-
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(simple_rename_exchange);
@@ -720,7 +741,6 @@ int simple_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		  struct dentry *old_dentry, struct inode *new_dir,
 		  struct dentry *new_dentry, unsigned int flags)
 {
-	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = d_is_dir(old_dentry);
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
@@ -743,9 +763,7 @@ int simple_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		inc_nlink(new_dir);
 	}
 
-	old_dir->i_ctime = old_dir->i_mtime = new_dir->i_ctime =
-		new_dir->i_mtime = inode->i_ctime = current_time(old_dir);
-
+	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 	return 0;
 }
 EXPORT_SYMBOL(simple_rename);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bdfbd11a5811..14e38bd900f1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2979,6 +2979,8 @@ extern int simple_open(struct inode *inode, struct file *file);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
+void simple_rename_timestamp(struct inode *old_dir, struct dentry *old_dentry,
+			     struct inode *new_dir, struct dentry *new_dentry);
 extern int simple_rename_exchange(struct inode *old_dir, struct dentry *old_dentry,
 				  struct inode *new_dir, struct dentry *new_dentry);
 extern int simple_rename(struct mnt_idmap *, struct inode *,
-- 
2.41.0

