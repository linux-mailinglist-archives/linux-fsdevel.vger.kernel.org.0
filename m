Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812677B8CF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbjJDTEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbjJDTBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:01:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BC42712;
        Wed,  4 Oct 2023 11:56:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C352C116A3;
        Wed,  4 Oct 2023 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445762;
        bh=sLBQkX6C3uZBg0HDRv8gvWKbTBaFbLFrj7RUWYAQhtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDZrwTkRfcCOZGW15481BzgRhMnUfqbehqGZ70SkT07TpnQHXu6UZfqn2H3DH/IgB
         NREMwV+WxrirSQUoJ/gwdJuN20x7Oz09gVp00C5J4jUQVvPa7HndP8pgLhpw+3XdE6
         sgwldkiPDhzPzj2g3RqGA/gLpn5OXG2RxT2QYd/q9czrrGxn2+biB5bnvlPb+wW7mJ
         1yXSUZIQbCkJJ9A+zsHeXrou8bbwxUhD+l+R1pwZkVAnrBM97dSGO7YTQ9XanaOiAq
         xtFzLLS3PpGLDldOhnDRuM8I6A6BQmH5bnq3JkmbbMZcpJWkhUCscVq82P/pMn/I9p
         +1GtWq5/j2IpA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mattia Dongili <malattia@linux.it>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ian Kent <raven@themaw.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Copeland <me@bobcopeland.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anders Larsen <al@alarsen.net>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-afs@lists.infradead.org, autofs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
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
        selinux@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 88/89] fs: switch timespec64 fields in inode to discrete integers
Date:   Wed,  4 Oct 2023 14:55:29 -0400
Message-ID: <20231004185530.82088-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185530.82088-1-jlayton@kernel.org>
References: <20231004185530.82088-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This shaves 8 bytes off struct inode with a garden-variety Fedora
Kconfig.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/fs.h | 53 ++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 84fdaf399fbe..485b5e21c8e5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -671,9 +671,12 @@ struct inode {
 	};
 	dev_t			i_rdev;
 	loff_t			i_size;
-	struct timespec64	__i_atime;
-	struct timespec64	__i_mtime;
-	struct timespec64	__i_ctime; /* use inode_*_ctime accessors! */
+	time64_t		i_atime_sec;
+	time64_t		i_mtime_sec;
+	time64_t		i_ctime_sec;
+	u32			i_atime_nsec;
+	u32			i_mtime_nsec;
+	u32			i_ctime_nsec;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	u8			i_blkbits;
@@ -1517,23 +1520,27 @@ struct timespec64 inode_set_ctime_current(struct inode *inode);
 
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {
-	return inode->__i_atime.tv_sec;
+	return inode->i_atime_sec;
 }
 
 static inline long inode_get_atime_nsec(const struct inode *inode)
 {
-	return inode->__i_atime.tv_nsec;
+	return inode->i_atime_nsec;
 }
 
 static inline struct timespec64 inode_get_atime(const struct inode *inode)
 {
-	return inode->__i_atime;
+	struct timespec64 ts = { .tv_sec  = inode_get_atime_sec(inode),
+				 .tv_nsec = inode_get_atime_nsec(inode) };
+
+	return ts;
 }
 
 static inline struct timespec64 inode_set_atime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_atime = ts;
+	inode->i_atime_sec = ts.tv_sec;
+	inode->i_atime_nsec = ts.tv_nsec;
 	return ts;
 }
 
@@ -1542,28 +1549,32 @@ static inline struct timespec64 inode_set_atime(struct inode *inode,
 {
 	struct timespec64 ts = { .tv_sec  = sec,
 				 .tv_nsec = nsec };
+
 	return inode_set_atime_to_ts(inode, ts);
 }
 
 static inline time64_t inode_get_mtime_sec(const struct inode *inode)
 {
-	return inode->__i_mtime.tv_sec;
+	return inode->i_mtime_sec;
 }
 
 static inline long inode_get_mtime_nsec(const struct inode *inode)
 {
-	return inode->__i_mtime.tv_nsec;
+	return inode->i_mtime_nsec;
 }
 
 static inline struct timespec64 inode_get_mtime(const struct inode *inode)
 {
-	return inode->__i_mtime;
+	struct timespec64 ts = { .tv_sec  = inode_get_mtime_sec(inode),
+				 .tv_nsec = inode_get_mtime_nsec(inode) };
+	return ts;
 }
 
 static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_mtime = ts;
+	inode->i_mtime_sec = ts.tv_sec;
+	inode->i_mtime_nsec = ts.tv_nsec;
 	return ts;
 }
 
@@ -1577,34 +1588,30 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 
 static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
-	return inode->__i_ctime.tv_sec;
+	return inode->i_ctime_sec;
 }
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	return inode->__i_ctime.tv_nsec;
+	return inode->i_ctime_nsec;
 }
 
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
 {
-	return inode->__i_ctime;
+	struct timespec64 ts = { .tv_sec  = inode_get_ctime_sec(inode),
+				 .tv_nsec = inode_get_ctime_nsec(inode) };
+
+	return ts;
 }
 
 static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->__i_ctime = ts;
+	inode->i_ctime_sec = ts.tv_sec;
+	inode->i_ctime_nsec = ts.tv_nsec;
 	return ts;
 }
 
-/**
- * inode_set_ctime - set the ctime in the inode
- * @inode: inode in which to set the ctime
- * @sec: tv_sec value to set
- * @nsec: tv_nsec value to set
- *
- * Set the ctime in @inode to { @sec, @nsec }
- */
 static inline struct timespec64 inode_set_ctime(struct inode *inode,
 						time64_t sec, long nsec)
 {
-- 
2.41.0

