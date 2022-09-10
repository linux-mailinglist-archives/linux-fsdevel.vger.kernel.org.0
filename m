Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC715B48F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 23:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIJVNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 17:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiIJVNo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 17:13:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D242E4B4A4
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 14:13:42 -0700 (PDT)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A079B413CD
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 21:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1662844420;
        bh=YIXqxtSbGe6vWCX7g0eeSDhgSl7mx2fz9QQkdP6SCjU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Q0TwgsaOSFCRJguD1ghJ2rz87+8dJtC/6PUu80y/+w7mehDloMDkS206iTGW6QNk2
         jc7zsxTJzIt83cpummD/rKIHUhB4H9Dpt8sE5nuUms0wO2SJ9+4SnueAjb7B/YTCf1
         z8Jfji/SauUDGO4VM7h7EA5MXpojMfK9+BlfAj6dEFQR5HKRCfZC+dNS2gqHfVWYfP
         l9eRuv/vUdfPJjOwLNRjhmkvnT7+ldU67J7RfDQ2/gAzBMpzNPH8qr65VYmaOX/TA2
         49R/nkroN3l1teezI48AjIcB6B9EL1gV2NiIZ2L+puUZJ4oeYH4OwV/sjEPEOAg3xI
         im0sxb9fdZM1A==
Received: by mail-ot1-f72.google.com with SMTP id z26-20020a05683020da00b00655d8590ed3so132581otq.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 14:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YIXqxtSbGe6vWCX7g0eeSDhgSl7mx2fz9QQkdP6SCjU=;
        b=QiZO3eCdqJKB0YGpWl9GNl4XGZUCYcEiAFRXOegjvmBzXINvc0xeNpu+6q0VD5yGHc
         PVhfo1Qe1WjPxdIWFK1Nn0o+hZ503JDOsFQeqnivdxBMvib3CGC+Qq5GzZxB6uYry6yV
         mHrpN3EFaegSYlUXekdk0WGRM9T464Zx9id8uDhIm04Xy8MJKn67fWiYViWHZVy1TlrS
         pvd1Zg7ijcftrJ4TDcsSQ/D05afJxOAs+A2wupKSYHZvBupQA+/UglEPFAa/v0DEZJy3
         bwvzgjIB29JOHmQIozVLaSXv5+9MelNNd9VVq4ny4mAOq6Jjqca2yns7rim/0rtOU6zE
         nVSw==
X-Gm-Message-State: ACgBeo0YGc8Vxt88MgBkHabQOvBMI22OVRQ6uzjCtayZp5fnJDLzQIbS
        0iZ3614fFJqt11Vrm3pPJSqOCguTaU1/6sLxr9Z3cbTUSenZ+36nm+61QQowjWCxT5RCJQExeUa
        TBUn1IW+Ay+v8aF+mKW21mPnjXCfQIXfn+u8GETuvZCI=
X-Received: by 2002:a05:6830:1f2e:b0:655:ca83:ddf2 with SMTP id e14-20020a0568301f2e00b00655ca83ddf2mr1151065oth.235.1662844414860;
        Sat, 10 Sep 2022 14:13:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5pGsEEItr/aSLMNOIU+AZmK8M+PFn+4mg2dcqIyP1lfX4BseZAUG23BVX+s27yE6qxA8684g==
X-Received: by 2002:a05:6830:1f2e:b0:655:ca83:ddf2 with SMTP id e14-20020a0568301f2e00b00655ca83ddf2mr1151054oth.235.1662844414569;
        Sat, 10 Sep 2022 14:13:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:67c:1562:8007::aac:4084])
        by smtp.gmail.com with ESMTPSA id z14-20020a056870e30e00b0012769122387sm2892567oad.54.2022.09.10.14.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 14:13:34 -0700 (PDT)
From:   Jorge Merlino <jorge.merlino@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     Jorge Merlino <jorge.merlino@canonical.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fix race condition when exec'ing setuid files
Date:   Sat, 10 Sep 2022 18:12:14 -0300
Message-Id: <20220910211215.140270-1-jorge.merlino@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fixes a race condition in check_unsafe_exec when a heavily
threaded program tries to exec a setuid file. check_unsafe_exec counts the
number of threads sharing the same fs_struct and compares it to the total
number of users of the fs_struct by looking at its users counter. If there
are more users than process threads using it the setuid exec fails with
LSM_UNSAFE_SHARE. The problem is that, during the kernel_clone code
execution, the fs_struct users counter is incremented before the new thread
is added to the thread_group list. So there is a race when the counter has
been incremented but the thread is not visible to the while_each_tread loop
in check_unsafe_exec.

This patch sort of fixes this by setting a process flag to the parent
process during the time this race is possible. Thus, if a process is
forking, it counts an extra user fo the fs_struct as the counter might be
incremented before the thread is visible. But this is not great as this
could generate the opposite problem as there may be an external process
sharing the fs_struct that is masked by some thread that is being counted
twice. I submit this patch just as an idea but mainly I want to introduce
this issue and see if someone comes up with a better solution.

This is a simple code to reproduce this issue:

$ cat Makefile
ALL=a b
all: $(ALL)

a: LDFLAGS=-pthread

b: b.c
	$(CC) b.c -o b
	sudo chown root:root b
	sudo chmod u+s b

test:
	for I in $$(seq 1000); do echo $I; ./a ; done

clean:
	rm -vf $(ALL)

$ cat a.c

void *nothing(void *p)
{
	return NULL;
}

void *target(void *p) {
	for (;;) {
		pthread_t t;
		if (pthread_create(&t, NULL, nothing, NULL) == 0)
			pthread_join(t, NULL);
    	}
	return NULL;
}

int main(void)
{
	struct timespec tv;
	int i;

	for (i = 0; i < 10; i++) {
		pthread_t t;
		pthread_create(&t, NULL, target, NULL);
	}
	tv.tv_sec = 0;
	tv.tv_nsec = 100000;
	nanosleep(&tv, NULL);
	if (execl("./b", "./b", NULL) < 0)
		perror("execl");
	return 0;
}

$ cat b.c

int main(void)
{
	const uid_t euid = geteuid();
	if (euid != 0) {
		printf("Failed, got euid %d (expecting 0)\n", euid);
        	return 1;
	}
	return 0;
}

$ make
make
cc   -pthread  a.c   -o a
cc b.c -o b
sudo chown root:root b
sudo chmod u+s b
$ make test

Without this fix, one will see 'Failed, got euid 1000 (expecting 0)' messages
---
 fs/exec.c             | 2 ++
 include/linux/sched.h | 1 +
 kernel/fork.c         | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 9a5ca7b82bfc..a6f949a899d5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1581,6 +1581,8 @@ static void check_unsafe_exec(struct linux_binprm *bprm)
 	while_each_thread(p, t) {
 		if (t->fs == p->fs)
 			n_fs++;
+			if (t->flags & PF_IN_FORK)
+				n_fs++;
 	}
 	rcu_read_unlock();
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..f307165a434a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1722,6 +1722,7 @@ extern struct pid *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
+#define PF_IN_FORK		0x02000000	/* Process is forking, prevents race condition on fs_struct users value */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
diff --git a/kernel/fork.c b/kernel/fork.c
index 8a9e92068b15..54e1e1fbe0bd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2245,6 +2245,7 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_files(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
+	current->flags |= PF_IN_FORK;
 	retval = copy_fs(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_files;
@@ -2474,6 +2475,7 @@ static __latent_entropy struct task_struct *copy_process(
 		attach_pid(p, PIDTYPE_PID);
 		nr_threads++;
 	}
+	current->flags &= ~PF_IN_FORK;
 	total_forks++;
 	hlist_del_init(&delayed.node);
 	spin_unlock(&current->sighand->siglock);
@@ -2556,6 +2558,7 @@ static __latent_entropy struct task_struct *copy_process(
 	spin_lock_irq(&current->sighand->siglock);
 	hlist_del_init(&delayed.node);
 	spin_unlock_irq(&current->sighand->siglock);
+	current->flags &= ~PF_IN_FORK;
 	return ERR_PTR(retval);
 }
 
-- 
2.34.1

