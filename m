Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4CE5858B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jul 2022 07:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiG3FL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jul 2022 01:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiG3FL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jul 2022 01:11:28 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD064B0CE;
        Fri, 29 Jul 2022 22:11:27 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:50274)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oHel4-007lNd-3m; Fri, 29 Jul 2022 23:11:26 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:47520 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oHel3-00GJeY-2g; Fri, 29 Jul 2022 23:11:25 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220727191949.GD18822@redhat.com> <YuGUyayVWDB7R89i@tycho.pizza>
        <20220728091220.GA11207@redhat.com> <YuL9uc8WfiYlb2Hw@tycho.pizza>
        <87pmhofr1q.fsf@email.froward.int.ebiederm.org>
        <YuPlqp0jSvVu4WBK@tycho.pizza>
        <87v8rfevz3.fsf@email.froward.int.ebiederm.org>
        <YuQPc51yXhnBHjIx@tycho.pizza>
        <87h72zes14.fsf_-_@email.froward.int.ebiederm.org>
        <20220729204730.GA3625@redhat.com> <YuR4MRL8WxA88il+@ZenIV>
Date:   Sat, 30 Jul 2022 00:10:33 -0500
In-Reply-To: <YuR4MRL8WxA88il+@ZenIV> (Al Viro's message of "Sat, 30 Jul 2022
        01:15:45 +0100")
Message-ID: <875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oHel3-00GJeY-2g;;;mid=<875yjfdw3a.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/LqhIvVPqMhw9lZ6gy83GJGTB7oURvop8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 466 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (2.2%), b_tie_ro: 9 (1.9%), parse: 0.98 (0.2%),
         extract_message_metadata: 14 (3.0%), get_uri_detail_list: 2.1 (0.4%),
        tests_pri_-1000: 16 (3.5%), tests_pri_-950: 1.20 (0.3%),
        tests_pri_-900: 0.96 (0.2%), tests_pri_-90: 81 (17.5%), check_bayes:
        80 (17.2%), b_tokenize: 9 (1.8%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 2.6 (0.6%), b_tok_touch_all: 56 (11.9%), b_finish: 0.85
        (0.2%), tests_pri_0: 324 (69.5%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 3.3 (0.7%), poll_dns_idle: 1.54 (0.3%), tests_pri_10:
        3.2 (0.7%), tests_pri_500: 10 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH v2] fuse: In fuse_flush only wait if someone wants the
 return code
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


In my very light testing this resolves a hang where a thread of the
fuse server was accessing the fuse filesystem (the fuse server is
serving up), when the fuse server is killed.

The practical problem is that the fuse server file descriptor was
being closed after the file descriptor into the fuse filesystem so
that the fuse filesystem operations were being blocked for instead of
being aborted.  Simply skipping the unnecessary wait resolves this
issue.

This is just a proof of concept and someone should look to see if the
fuse max_background limit could cause a problem with this approach.

Additionally testing PF_EXITING is a very crude way to tell if someone
wants the return code from the vfs flush operation.  As such in the
long run it probably makes sense to get some direct vfs support for
knowing if flush needs to block until all of the flushing is complete
and a status/return code can be returned.

Unless I have missed something this is a generic optimization that can
apply to many network filesystems.

Al, vfs folks? (igrab/iput sorted so as not to be distractions).

Perhaps a .flush_async method without a return code and a
filp_close_async function without a return code to take advantage of
this in the general sense.

Waiting potentially indefinitely for user space in do_exit seems like a
bad idea.  Especially when all that the wait is for is to get a return
code that will never be examined.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fuse/file.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 05caa2b9272e..2bd94acd761f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -464,6 +464,62 @@ static void fuse_sync_writes(struct inode *inode)
 	fuse_release_nowrite(inode);
 }
 
+struct fuse_flush_args {
+	struct fuse_args args;
+	struct fuse_flush_in inarg;
+	struct inode *inode;
+};
+
+static void fuse_flush_end(struct fuse_mount *fm, struct fuse_args *args, int err)
+{
+	struct fuse_flush_args *fa = container_of(args, typeof(*fa), args);
+
+	if (err == -ENOSYS) {
+		fm->fc->no_flush = 1;
+		err = 0;
+	}
+
+	/*
+	 * In memory i_blocks is not maintained by fuse, if writeback cache is
+	 * enabled, i_blocks from cached attr may not be accurate.
+	 */
+	if (!err && fm->fc->writeback_cache)
+		fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);
+
+	iput(fa->inode);
+	kfree(fa);
+}
+
+static int fuse_flush_async(struct file *file, fl_owner_t id)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_flush_args *fa;
+	int err;
+
+	fa = kzalloc(sizeof(*fa), GFP_KERNEL);
+	if (!fa)
+		return -ENOMEM;
+
+	fa->inarg.fh = ff->fh;
+	fa->inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
+	fa->args.opcode = FUSE_FLUSH;
+	fa->args.nodeid = get_node_id(inode);
+	fa->args.in_numargs = 1;
+	fa->args.in_args[0].size = sizeof(fa->inarg);
+	fa->args.in_args[0].value = &fa->inarg;
+	fa->args.force = true;
+	fa->args.end = fuse_flush_end;
+	fa->inode = igrab(inode);
+
+	err = fuse_simple_background(fm, &fa->args, GFP_KERNEL);
+	if (err)
+		fuse_flush_end(fm, &fa->args, err);
+
+	return err;
+}
+
 static int fuse_flush(struct file *file, fl_owner_t id)
 {
 	struct inode *inode = file_inode(file);
@@ -495,6 +551,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (fm->fc->no_flush)
 		goto inval_attr_out;
 
+	if (current->flags & PF_EXITING)
+		return fuse_flush_async(file, id);
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.fh = ff->fh;
 	inarg.lock_owner = fuse_lock_owner_id(fm->fc, id);
-- 
2.35.3

