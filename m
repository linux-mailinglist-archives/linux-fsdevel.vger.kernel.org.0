Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493FA1F7441
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 09:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFLHBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 03:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFLHBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:01:23 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B9C03E96F;
        Fri, 12 Jun 2020 00:01:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e16so6448625qtg.0;
        Fri, 12 Jun 2020 00:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mN4fOTndqYkvKBuPQlQqFgEQGw71rQkWNJnMF6fOW8I=;
        b=iNZttPvcGNIW4njiUlnMqAdNV8ziBhu5BVVHairzMp2DTmr7g9cS3df4Dt4IdDlQhS
         97uA7XVrAcU1INT5wnEmFeisgj7dOrX4CyIMQWgibZNRWzsqKIxrCz/aNyoKjL2ImjqA
         zuGvEv7mz8FseLYHm3DQ22/0+sbcL9diKaOQz+65PapzBb+1g5DnCB0gp8zknsM7n3yQ
         ZAMdQZ7Ty6NiLzcYPd7UPMl0FUvDAtPMKxEAXt4YNJY08hum4pRRJDI3sviTQxiIFps0
         T85IayqXFrWfE3eZfZk9eSMNkffgotdvu0XdS9IruhOyVG+La6DvIJu3tEeEAGlm6ZkG
         ShVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mN4fOTndqYkvKBuPQlQqFgEQGw71rQkWNJnMF6fOW8I=;
        b=aiE1KHEahPPi+faIAFMHF7r2w42Wuztq+f2W/EmCScNGWcrKCZF3VqBE55WsBuya7P
         Vm80hbxaODzv70QkR1nNkfKoI3h4K9BWlH1ymL97Ax2/UVe8qreeIvXlHLrAbwySudcH
         rOGP0XBpb8vtfPITq8P9bT6v2OTegbkba1fFu13hKvvuWGgExGtZC0BRtzahT0xZ9ZzO
         NAlIojMPK9UG4XbFTg9pPaRrht+fux8YMnwHzulR64aQZB80sWDzZbIBD7M7KhVwXzZG
         56KGlOMlhRzgvJOtr75IAexXy7rmLiZvFgIEgNlocDXWETLUa3B+cvTOBFyA1CWi8zbg
         DWrg==
X-Gm-Message-State: AOAM530ye5h9B5eG1f8aX4zG6dhZKyomhd909bIV0nGJP0tn3cRMeOCQ
        4gKqiSXtaIyMNqDNzMggQq0=
X-Google-Smtp-Source: ABdhPJzwu+8w9TYwAapEXLOqGb2boi/iE2yqPkUrG0SqWBjCxYQ3aLUjr5BjhRFShekhlfXjdIAszA==
X-Received: by 2002:ac8:1013:: with SMTP id z19mr1647528qti.130.1591945281674;
        Fri, 12 Jun 2020 00:01:21 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id s15sm4300022qtc.95.2020.06.12.00.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2020 00:01:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7920D27C0054;
        Fri, 12 Jun 2020 03:01:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 12 Jun 2020 03:01:19 -0400
X-ME-Sender: <xms:NijjXjh_PMTo4Q6eouga8WuSX44fRVWFNwCywly1n9RVGmM_y00L-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeitddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgfeufeejfeffteevfeejjeevvdfhuedtiedvgffgvdeludfgueekvdeg
    uddviefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddtuddrkeeird
    egjedrudejvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:NijjXgCXpAfAgtFNXrRVxMTIrdWtUIL0ZtQe0eSNbeouEFsNwPE3Vw>
    <xmx:NijjXjGjHkxhfrt0_DJ6nTmgCfCj2stPA7t1bQiX0Uo7jdazYjGKFQ>
    <xmx:NijjXgTuuCNWNG8az0j3ot2MYPzCGkT0NuEZApgK8F0vGgkmvkiBtQ>
    <xmx:PyjjXsENf6ahHsRrCE0oieW9Q2f6wz6nCR0aFilwtNoFo_JgfZOoZWSu_cw>
Received: from localhost (unknown [101.86.47.172])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27F5C3060F09;
        Fri, 12 Jun 2020 03:01:09 -0400 (EDT)
Date:   Fri, 12 Jun 2020 15:01:01 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, allison@lohutok.net,
        areber@redhat.com, aubrey.li@linux.intel.com,
        Andrei Vagin <avagin@gmail.com>,
        Bruce Fields <bfields@fieldses.org>,
        Christian Brauner <christian@brauner.io>, cyphar@cyphar.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, guro@fb.com,
        Jeff Layton <jlayton@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>, linmiaohe@huawei.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, sargun@sargun.me,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: possible deadlock in send_sigio
Message-ID: <20200612070101.GA879624@tardis>
References: <000000000000760d0705a270ad0c@google.com>
 <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
 <CACT4Y+brpePBoR7EUwPiSvGAgo6bhvpKvLTiCaCfRSadzn6yRw@mail.gmail.com>
 <88c172af-46df-116e-6f22-b77f98803dcb@redhat.com>
 <20200611142214.GI2531@hirez.programming.kicks-ass.net>
 <b405aca6-a3b2-cf11-a482-2b4af1e548bd@redhat.com>
 <20200611235526.GC94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200611235526.GC94665@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:55:26AM +0800, Boqun Feng wrote:
> Hi Peter and Waiman,
>=20
> On Thu, Jun 11, 2020 at 12:09:59PM -0400, Waiman Long wrote:
> > On 6/11/20 10:22 AM, Peter Zijlstra wrote:
> > > On Thu, Jun 11, 2020 at 09:51:29AM -0400, Waiman Long wrote:
> > >=20
> > > > There was an old lockdep patch that I think may address the issue, =
but was
> > > > not merged at the time. I will need to dig it out and see if it can=
 be
> > > > adapted to work in the current kernel. It may take some time.
> > > Boqun was working on that; I can't remember what happened, but ISTR it
> > > was shaping up nice.
> > >=20
> > Yes, I am talking about Boqun's patch. However, I think he had moved to
> > another company and so may not be able to actively work on that again.
> >=20
>=20
> I think you are talking about the rescursive read deadlock detection
> patchset:
>=20
> 	https://lore.kernel.org/lkml/20180411135110.9217-1-boqun.feng@gmail.com/
>=20
> Let me have a good and send a new version based on today's master of tip
> tree.
>=20

FWIW, with the following patch, I think we can avoid to the false
positives. But solely with this patch, we don't have the ability to
detect deadlocks with recursive locks..

I've managed to rebase my patchset, but need some time to tweak it to
work properly, in the meantime, Dmitry, could you give this a try?

Regards,
Boqun

------------->8
Subject: [PATCH] locking: More accurate annotations for read_lock()

On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
read lock, actually it's only recursive if in_interrupt() is true. So
change the annotation accordingly to catch more deadlocks.

Note we used to treat read_lock() as pure recursive read locks in
lib/locking-seftest.c, and this is useful, especially for the lockdep
development selftest, so we keep this via a variable to force switching
lock annotation for read_lock().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h | 35 ++++++++++++++++++++++++++++++++++-
 lib/locking-selftest.c  | 11 +++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 8fce5c98a4b0..50aedbba0812 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -43,6 +43,7 @@ enum lockdep_wait_type {
 #include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
+#include <linux/preempt.h>
=20
 /*
  * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
@@ -640,6 +641,31 @@ static inline void print_irqtrace_events(struct task_s=
truct *curr)
 }
 #endif
=20
+/* Variable used to make lockdep treat read_lock() as recursive in selftes=
ts */
+#ifdef CONFIG_DEBUG_LOCKING_API_SELFTESTS
+extern unsigned int force_read_lock_recursive;
+#else /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
+#define force_read_lock_recursive 0
+#endif /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
+
+#ifdef CONFIG_LOCKDEP
+/*
+ * read_lock() is recursive if:
+ * 1. We force lockdep think this way in selftests or
+ * 2. The implementation is not queued read/write lock or
+ * 3. The locker is at an in_interrupt() context.
+ */
+static inline bool read_lock_is_recursive(void)
+{
+	return force_read_lock_recursive ||
+	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
+	       in_interrupt();
+}
+#else /* CONFIG_LOCKDEP */
+/* If !LOCKDEP, the value is meaningless */
+#define read_lock_is_recursive() 0
+#endif
+
 /*
  * For trivial one-depth nesting of a lock-class, the following
  * global define can be used. (Subsystems with multiple levels
@@ -661,7 +687,14 @@ static inline void print_irqtrace_events(struct task_s=
truct *curr)
 #define spin_release(l, i)			lock_release(l, i)
=20
 #define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, =
i)
-#define rwlock_acquire_read(l, s, t, i)		lock_acquire_shared_recursive(l, =
s, t, NULL, i)
+#define rwlock_acquire_read(l, s, t, i)					\
+do {									\
+	if (read_lock_is_recursive())					\
+		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
+	else								\
+		lock_acquire_shared(l, s, t, NULL, i);			\
+} while (0)
+
 #define rwlock_release(l, i)			lock_release(l, i)
=20
 #define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL=
, i)
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 14f44f59e733..caadc4dd3368 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -28,6 +28,7 @@
  * Change this to 1 if you want to see the failure printouts:
  */
 static unsigned int debug_locks_verbose;
+unsigned int force_read_lock_recursive;
=20
 static DEFINE_WD_CLASS(ww_lockdep);
=20
@@ -1978,6 +1979,11 @@ void locking_selftest(void)
 		return;
 	}
=20
+	/*
+	 * treats read_lock() as recursive read locks for testing purpose
+	 */
+	force_read_lock_recursive =3D 1;
+
 	/*
 	 * Run the testsuite:
 	 */
@@ -2073,6 +2079,11 @@ void locking_selftest(void)
=20
 	ww_tests();
=20
+	force_read_lock_recursive =3D 0;
+	/*
+	 * queued_read_lock() specific test cases can be put here
+	 */
+
 	if (unexpected_testcase_failures) {
 		printk("----------------------------------------------------------------=
-\n");
 		debug_locks =3D 0;
--=20
2.26.2


