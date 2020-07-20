Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC907225EC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 14:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgGTMrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 08:47:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgGTMq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595249216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JMgW90psb0hughNqkcIlSEiiDi8QGnHRGKtGc1UA1SI=;
        b=aRM9XuBg/tWBVTOJk7+gaLv5WF45jBBd/w/zWWrvF9ooRLxBnBROViQcMB8MlBZIQNyL/K
        btPKjbsATlw0yKGb6L+SY8D62cHoqpo8nsL7bwDT4jmrhygIq5bLi46s2UjbTJczGiJ4x4
        Fh+KjlnhCPzsZcx8TIKLMolnb6ZIpY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-io7hXsNKMuaagJbbzEwQBw-1; Mon, 20 Jul 2020 08:46:52 -0400
X-MC-Unique: io7hXsNKMuaagJbbzEwQBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1BCB8015F7;
        Mon, 20 Jul 2020 12:46:49 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FA9B2B5BF;
        Mon, 20 Jul 2020 12:46:39 +0000 (UTC)
Date:   Mon, 20 Jul 2020 14:46:37 +0200
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200720124637.GA1788746@dcbz.redhat.com>
References: <20200719100418.2112740-1-areber@redhat.com>
 <20200719181729.6f37lilhvov5a74f@wittgenstein>
 <20200720115452.ne2vqtdneuungb3j@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720115452.ne2vqtdneuungb3j@wittgenstein>
X-Operating-System: Linux (5.6.19-300.fc32.x86_64)
X-Load-Average: 5.82 3.00 2.00
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
Organization: Red Hat
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:54:52PM +0200, Christian Brauner wrote:
> On Sun, Jul 19, 2020 at 08:17:30PM +0200, Christian Brauner wrote:
> > On Sun, Jul 19, 2020 at 12:04:10PM +0200, Adrian Reber wrote:
> > > This is v6 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. The
> > > changes to v5 are:
> > > 
> > >  * split patch dealing with /proc/self/exe into two patches:
> > >    * first patch to enable changing it with CAP_CHECKPOINT_RESTORE
> > >      and detailed history in the commit message
> > >    * second patch changes -EINVAL to -EPERM
> > >  * use kselftest_harness.h infrastructure for test
> > >  * replace if (!capable(CAP_SYS_ADMIN) || !capable(CAP_CHECKPOINT_RESTORE))
> > >    with if (!checkpoint_restore_ns_capable(&init_user_ns))
> > > 
> > > Adrian Reber (5):
> > >   capabilities: Introduce CAP_CHECKPOINT_RESTORE
> > >   pid: use checkpoint_restore_ns_capable() for set_tid
> > >   pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
> > >   proc: allow access in init userns for map_files with
> > >     CAP_CHECKPOINT_RESTORE
> > >   selftests: add clone3() CAP_CHECKPOINT_RESTORE test
> > > 
> > > Nicolas Viennot (2):
> > >   prctl: Allow local CAP_CHECKPOINT_RESTORE to change /proc/self/exe
> > >   prctl: exe link permission error changed from -EINVAL to -EPERM
> > > 
> > >  fs/proc/base.c                                |   8 +-
> > >  include/linux/capability.h                    |   6 +
> > >  include/uapi/linux/capability.h               |   9 +-
> > >  kernel/pid.c                                  |   2 +-
> > >  kernel/pid_namespace.c                        |   2 +-
> > >  kernel/sys.c                                  |  13 +-
> > >  security/selinux/include/classmap.h           |   5 +-
> > >  tools/testing/selftests/clone3/.gitignore     |   1 +
> > >  tools/testing/selftests/clone3/Makefile       |   4 +-
> > >  .../clone3/clone3_cap_checkpoint_restore.c    | 177 ++++++++++++++++++
> > >  10 files changed, 212 insertions(+), 15 deletions(-)
> > >  create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> > > 
> > > base-commit: d31958b30ea3b7b6e522d6bf449427748ad45822
> > 
> > Adrian, Nicolas thank you!
> > I grabbed the series to run the various core test-suites we've added
> > over the last year and pushed it to
> > https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=cap_checkpoint_restore
> > for now to let kbuild/ltp chew on it for a bit.
> 
> Ok, I ran the test-suite this morning and there's nothing to worry about
> it all passes _but_ the selftests had a bug using SKIP() instead of
> XFAIL() and they mixed ksft_print_msg() and TH_LOG(). I know that I
> think I mentioned to you that you can't use TH_LOG() outside of TEST*().
> Turns out I was wrong. You can do it if you pass in a specific global
> variable. Here's the diff I applied on top of the selftests you sent.
> After these changes the output looks like this:
> 
> [==========] Running 1 tests from 1 test cases.
> [ RUN      ] global.clone3_cap_checkpoint_restore
> # clone3() syscall supported
> clone3_cap_checkpoint_restore.c:155:clone3_cap_checkpoint_restore:Child has PID 12303
> clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[12302] Trying clone3() with CLONE_SET_TID to 12303
> clone3_cap_checkpoint_restore.c:55:clone3_cap_checkpoint_restore:Operation not permitted - Failed to create new process
> clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[12302] clone3() with CLONE_SET_TID 12303 says:-1
> clone3_cap_checkpoint_restore.c:88:clone3_cap_checkpoint_restore:[12302] Trying clone3() with CLONE_SET_TID to 12303
> clone3_cap_checkpoint_restore.c:70:clone3_cap_checkpoint_restore:I am the parent (12302). My child's pid is 12303
> clone3_cap_checkpoint_restore.c:63:clone3_cap_checkpoint_restore:I am the child, my PID is 12303 (expected 12303)
> clone3_cap_checkpoint_restore.c:90:clone3_cap_checkpoint_restore:[12302] clone3() with CLONE_SET_TID 12303 says:0
> [       OK ] global.clone3_cap_checkpoint_restore
> [==========] 1 / 1 tests passed.
> [  PASSED  ]
> 
> Ok with this below being applied on top of it?
> 
> diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> index c0d83511cd28..9562425aa0a9 100644
> --- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> +++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> @@ -38,7 +38,8 @@ static void child_exit(int ret)
>  	_exit(ret);
>  }
>  
> -static int call_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
> +static int call_clone3_set_tid(struct __test_metadata *_metadata,
> +			       pid_t *set_tid, size_t set_tid_size)
>  {
>  	int status;
>  	pid_t pid = -1;
> @@ -51,7 +52,7 @@ static int call_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
>  
>  	pid = sys_clone3(&args, sizeof(struct clone_args));
>  	if (pid < 0) {
> -		ksft_print_msg("%s - Failed to create new process\n", strerror(errno));
> +		TH_LOG("%s - Failed to create new process", strerror(errno));
>  		return -errno;
>  	}
>  
> @@ -59,18 +60,17 @@ static int call_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
>  		int ret;
>  		char tmp = 0;
>  
> -		ksft_print_msg
> -		    ("I am the child, my PID is %d (expected %d)\n", getpid(), set_tid[0]);
> +		TH_LOG("I am the child, my PID is %d (expected %d)", getpid(), set_tid[0]);
>  
>  		if (set_tid[0] != getpid())
>  			child_exit(EXIT_FAILURE);
>  		child_exit(EXIT_SUCCESS);
>  	}
>  
> -	ksft_print_msg("I am the parent (%d). My child's pid is %d\n", getpid(), pid);
> +	TH_LOG("I am the parent (%d). My child's pid is %d", getpid(), pid);
>  
>  	if (waitpid(pid, &status, 0) < 0) {
> -		ksft_print_msg("Child returned %s\n", strerror(errno));
> +		TH_LOG("Child returned %s", strerror(errno));
>  		return -errno;
>  	}
>  
> @@ -80,13 +80,14 @@ static int call_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
>  	return WEXITSTATUS(status);
>  }
>  
> -static int test_clone3_set_tid(pid_t *set_tid, size_t set_tid_size)
> +static int test_clone3_set_tid(struct __test_metadata *_metadata,
> +			       pid_t *set_tid, size_t set_tid_size)
>  {
>  	int ret;
>  
> -	ksft_print_msg("[%d] Trying clone3() with CLONE_SET_TID to %d\n", getpid(), set_tid[0]);
> -	ret = call_clone3_set_tid(set_tid, set_tid_size);
> -	ksft_print_msg("[%d] clone3() with CLONE_SET_TID %d says:%d\n", getpid(), set_tid[0], ret);
> +	TH_LOG("[%d] Trying clone3() with CLONE_SET_TID to %d", getpid(), set_tid[0]);
> +	ret = call_clone3_set_tid(_metadata, set_tid, set_tid_size);
> +	TH_LOG("[%d] clone3() with CLONE_SET_TID %d says:%d", getpid(), set_tid[0], ret);
>  	return ret;
>  }
>  
> @@ -144,7 +145,7 @@ TEST(clone3_cap_checkpoint_restore)
>  	test_clone3_supported();
>  
>  	EXPECT_EQ(getuid(), 0)
> -		SKIP(return, "Skipping all tests as non-root\n");
> +		XFAIL(return, "Skipping all tests as non-root\n");
>  
>  	memset(&set_tid, 0, sizeof(set_tid));
>  
> @@ -162,16 +163,20 @@ TEST(clone3_cap_checkpoint_restore)
>  
>  	ASSERT_EQ(set_capability(), 0)
>  		TH_LOG("Could not set CAP_CHECKPOINT_RESTORE");
> -	prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
> -	setgid(1000);
> -	setuid(1000);
> +
> +	ASSERT_EQ(prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0), 0);
> +
> +	EXPECT_EQ(setgid(65534), 0)
> +		TH_LOG("Failed to setgid(65534)");
> +	ASSERT_EQ(setuid(65534), 0);
> +
>  	set_tid[0] = pid;
>  	/* This would fail without CAP_CHECKPOINT_RESTORE */
> -	ASSERT_EQ(test_clone3_set_tid(set_tid, 1), -EPERM);
> +	ASSERT_EQ(test_clone3_set_tid(_metadata, set_tid, 1), -EPERM);
>  	ASSERT_EQ(set_capability(), 0)
>  		TH_LOG("Could not set CAP_CHECKPOINT_RESTORE");
>  	/* This should work as we have CAP_CHECKPOINT_RESTORE as non-root */
> -	ASSERT_EQ(test_clone3_set_tid(set_tid, 1), 0);
> +	ASSERT_EQ(test_clone3_set_tid(_metadata, set_tid, 1), 0);
>  }
>  

Thanks for the changes. That looks much better.

Can you fix the test directly or do you need a new reworked patch from us?

		Adrian

