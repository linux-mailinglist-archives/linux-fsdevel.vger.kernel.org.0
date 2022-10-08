Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC65F8443
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 10:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJHIZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 04:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJHIZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:25:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698801CB27;
        Sat,  8 Oct 2022 01:25:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z3so8797955edc.10;
        Sat, 08 Oct 2022 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5wJQn5HejSWqpqDhl29mgQlrlsWCcpu9EfQRqAkO9fI=;
        b=FauiGavHGiukhfEOrC5nm1iGLHMs6gycvmq09foH2whr7GltkF6u4t7zTmwXGcETXL
         nEminySBatZ2hNYq51rLnd7+cjRsrnjqeTGAJI85j+HmjQA85Iu6aZXN81aMmkvKd5pG
         UJp/0sLCYflX2FNKmMMR2QZ+6Lz8fOyvVtsDPTExzGtgG1n34HuxiE7aXp9UG0AkZFfM
         V0jw95TpPPVoY7tloVJq7cdQgMpNhzcpfMrBIGlXGWDaO/IvlGlQG+nO8aVgEWbUwQ2T
         rralF2qNcdiElJprAvid3dC+uoTjF4KVP1CIk62I3mor97iLO7oXYEUeQNlJf4C8m2ei
         jFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wJQn5HejSWqpqDhl29mgQlrlsWCcpu9EfQRqAkO9fI=;
        b=IBZWavcbJt8d7U1ORP8TYxwnEhVvaIujEJ7Q0L0rrUuzhbD8zIkFz2JwUDRQoyw1jR
         ntOT5Vi4cd/una4Uqf8U4ePhmwga+VBK6U+2a01tsZOOLXd3x1X16bd4c+r5TuVIwSwN
         Ome3E6FAkGTf1V3h4inHtKXZOAGu6Zm5FfETA1hw4nD2llYcQtRMHvMa7te/IST1PxAk
         h3oFhonXZTV8gwZ8h/0Tx6cVZbwGkrJygcP3M3bHn0uhPCeYoV+w0ZptApR5nT+mHhyW
         6YnBXPiYatM3o3zEbleF2jS8bnZNFxB3y9iax/+3DfptPsTWuhnKHTaoJVMIo1YfU+l1
         TKIQ==
X-Gm-Message-State: ACrzQf3uyfRIkPflbphzEbc4YIYTbPGqeYN28yIdQGsxBckOXlIy/Guw
        6/dLY+hHxH053iByfYOpa3c=
X-Google-Smtp-Source: AMsMyM5OHouT75o6Bnaz9RxfzCJZfh7XhaeSGXdBmeUF+y5OxqbNMDdqdhsYaTs0gwhrhyE6yTv70w==
X-Received: by 2002:a05:6402:4307:b0:459:4c7b:e843 with SMTP id m7-20020a056402430700b004594c7be843mr7894549edc.153.1665217540848;
        Sat, 08 Oct 2022 01:25:40 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0564020b4a00b00456cbd8c65bsm3078607edb.6.2022.10.08.01.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:25:40 -0700 (PDT)
Date:   Sat, 8 Oct 2022 10:25:38 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v8 7/9] selftests/landlock: Test FD passing from a
 Landlock-restricted to an unrestricted process
Message-ID: <Y0E0AuxsnwOYV8TL@nuc>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-8-gnoack3000@gmail.com>
 <ffacf78b-991f-3476-b3b8-9d8b847141fb@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffacf78b-991f-3476-b3b8-9d8b847141fb@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:57:12PM +0200, Mickaël Salaün wrote:
> Thanks for this refactoring.
> 
> We need a shorter subject though. ;)

Done, changed to:
"selftests/landlock: Test FD passing from restricted to unrestricted processes"

> On 01/10/2022 17:49, Günther Noack wrote:
> > A file descriptor created in a restricted process carries Landlock
> > restrictions with it which will apply even if the same opened file is
> > used from an unrestricted process.
> > 
> > This change extracts suitable FD-passing helpers from base_test.c and
> > moves them to common.h. We use the fixture variants from the ftruncate
> > fixture to exercise the same scenarios as in the open_and_ftruncate
> > test, but doing the Landlock restriction and open() in a different
> > process than the ftruncate() call.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   tools/testing/selftests/landlock/base_test.c | 36 +----------
> >   tools/testing/selftests/landlock/common.h    | 67 ++++++++++++++++++++
> >   tools/testing/selftests/landlock/fs_test.c   | 62 ++++++++++++++++++
> >   3 files changed, 132 insertions(+), 33 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> > index 72cdae277b02..6d1b6eedb432 100644
> > --- a/tools/testing/selftests/landlock/base_test.c
> > +++ b/tools/testing/selftests/landlock/base_test.c
> > @@ -263,23 +263,6 @@ TEST(ruleset_fd_transfer)
> >   		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
> >   	};
> >   	int ruleset_fd_tx, dir_fd;
> > -	union {
> > -		/* Aligned ancillary data buffer. */
> > -		char buf[CMSG_SPACE(sizeof(ruleset_fd_tx))];
> > -		struct cmsghdr _align;
> > -	} cmsg_tx = {};
> > -	char data_tx = '.';
> > -	struct iovec io = {
> > -		.iov_base = &data_tx,
> > -		.iov_len = sizeof(data_tx),
> > -	};
> > -	struct msghdr msg = {
> > -		.msg_iov = &io,
> > -		.msg_iovlen = 1,
> > -		.msg_control = &cmsg_tx.buf,
> > -		.msg_controllen = sizeof(cmsg_tx.buf),
> > -	};
> > -	struct cmsghdr *cmsg;
> >   	int socket_fds[2];
> >   	pid_t child;
> >   	int status;
> > @@ -298,33 +281,20 @@ TEST(ruleset_fd_transfer)
> >   				    &path_beneath_attr, 0));
> >   	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
> > -	cmsg = CMSG_FIRSTHDR(&msg);
> > -	ASSERT_NE(NULL, cmsg);
> > -	cmsg->cmsg_len = CMSG_LEN(sizeof(ruleset_fd_tx));
> > -	cmsg->cmsg_level = SOL_SOCKET;
> > -	cmsg->cmsg_type = SCM_RIGHTS;
> > -	memcpy(CMSG_DATA(cmsg), &ruleset_fd_tx, sizeof(ruleset_fd_tx));
> > -
> >   	/* Sends the ruleset FD over a socketpair and then close it. */
> >   	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
> >   				socket_fds));
> > -	ASSERT_EQ(sizeof(data_tx), sendmsg(socket_fds[0], &msg, 0));
> > +	ASSERT_EQ(0, send_fd(socket_fds[0], ruleset_fd_tx));
> >   	ASSERT_EQ(0, close(socket_fds[0]));
> >   	ASSERT_EQ(0, close(ruleset_fd_tx));
> >   	child = fork();
> >   	ASSERT_LE(0, child);
> >   	if (child == 0) {
> > -		int ruleset_fd_rx;
> > +		int ruleset_fd_rx = recv_fd(socket_fds[1]);
> 
> We can now make it const.

Done.

> > -		*(char *)msg.msg_iov->iov_base = '\0';
> > -		ASSERT_EQ(sizeof(data_tx),
> > -			  recvmsg(socket_fds[1], &msg, MSG_CMSG_CLOEXEC));
> > -		ASSERT_EQ('.', *(char *)msg.msg_iov->iov_base);
> > +		ASSERT_LE(0, ruleset_fd_rx);
> >   		ASSERT_EQ(0, close(socket_fds[1]));
> > -		cmsg = CMSG_FIRSTHDR(&msg);
> > -		ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(ruleset_fd_tx)));
> > -		memcpy(&ruleset_fd_rx, CMSG_DATA(cmsg), sizeof(ruleset_fd_tx));
> >   		/* Enforces the received ruleset on the child. */
> >   		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> > diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> > index 7d34592471db..15149d34e43b 100644
> > --- a/tools/testing/selftests/landlock/common.h
> > +++ b/tools/testing/selftests/landlock/common.h
> > @@ -10,6 +10,7 @@
> >   #include <errno.h>
> >   #include <linux/landlock.h>
> >   #include <sys/capability.h>
> > +#include <sys/socket.h>
> >   #include <sys/syscall.h>
> >   #include <sys/types.h>
> >   #include <sys/wait.h>
> > @@ -189,3 +190,69 @@ static void __maybe_unused clear_cap(struct __test_metadata *const _metadata,
> >   {
> >   	_effective_cap(_metadata, caps, CAP_CLEAR);
> >   }
> > +
> > +/* Receives an FD from a UNIX socket. Returns the received FD, -1 on error. */
> > +static int __maybe_unused recv_fd(int usock)
> > +{
> > +	int fd_rx;
> > +	union {
> > +		/* Aligned ancillary data buffer. */
> > +		char buf[CMSG_SPACE(sizeof(fd_rx))];
> > +		struct cmsghdr _align;
> > +	} cmsg_rx = {};
> > +	char data = '\0';
> > +	struct iovec io = {
> > +		.iov_base = &data,
> > +		.iov_len = sizeof(data),
> > +	};
> > +	struct msghdr msg = {
> > +		.msg_iov = &io,
> > +		.msg_iovlen = 1,
> > +		.msg_control = &cmsg_rx.buf,
> > +		.msg_controllen = sizeof(cmsg_rx.buf),
> > +	};
> > +	struct cmsghdr *cmsg;
> > +	int res;
> > +
> > +	res = recvmsg(usock, &msg, MSG_CMSG_CLOEXEC);
> > +	if (res < 0)
> > +		return -1;
> 
> It could be useful to return -errno for recv_fd() and send_fd(), and update
> the description accordingly. That would enable to quickly know the error
> with the ASSERT_*() calls.

Done, good idea.


> > +	cmsg = CMSG_FIRSTHDR(&msg);
> > +	if (cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
> > +		return -1;

I made it return -EIO in the case where the other side sends invalid data.


> > +	memcpy(&fd_rx, CMSG_DATA(cmsg), sizeof(fd_rx));
> > +	return fd_rx;
> > +}
> > +
> > +/* Sends an FD on a UNIX socket. Returns 0 on success or -1 on error. */
> > +static int __maybe_unused send_fd(int usock, int fd_tx)
> > +{
> > +	union {
> > +		/* Aligned ancillary data buffer. */
> > +		char buf[CMSG_SPACE(sizeof(fd_tx))];
> > +		struct cmsghdr _align;
> > +	} cmsg_tx = {};
> > +	char data_tx = '.';
> > +	struct iovec io = {
> > +		.iov_base = &data_tx,
> > +		.iov_len = sizeof(data_tx),
> > +	};
> > +	struct msghdr msg = {
> > +		.msg_iov = &io,
> > +		.msg_iovlen = 1,
> > +		.msg_control = &cmsg_tx.buf,
> > +		.msg_controllen = sizeof(cmsg_tx.buf),
> > +	};
> > +	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
> > +
> > +	cmsg->cmsg_len = CMSG_LEN(sizeof(fd_tx));
> > +	cmsg->cmsg_level = SOL_SOCKET;
> > +	cmsg->cmsg_type = SCM_RIGHTS;
> > +	memcpy(CMSG_DATA(cmsg), &fd_tx, sizeof(fd_tx));
> > +
> > +	if (sendmsg(usock, &msg, 0) < 0)
> > +		return -1;
> > +	return 0;
> > +}
> > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > index 308f6f36e8c0..93ed80a25a74 100644
> > --- a/tools/testing/selftests/landlock/fs_test.c
> > +++ b/tools/testing/selftests/landlock/fs_test.c
> > @@ -3541,6 +3541,68 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
> >   	}
> >   }
> > +TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
> > +{
> > +	int child, fd, status;
> > +	int socket_fds[2];
> > +
> > +	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
> > +				socket_fds));
> > +
> > +	child = fork();
> > +	ASSERT_LE(0, child);
> > +	if (child == 0) {
> > +		/*
> > +		 * Enable Landlock in the child process, open a file descriptor
> 
> "Enables"…

Done.

> > +		 * where truncation is forbidden and send it to the
> > +		 * non-landlocked parent process.
> > +		 */
> > +		const char *const path = file1_s1d1;
> > +		const struct rule rules[] = {
> > +			{
> > +				.path = path,
> > +				.access = variant->permitted,
> > +			},
> > +			{},
> > +		};
> > +		int fd, ruleset_fd;
> > +
> > +		/* Enable Landlock. */
> 
> This comment is not necessary.

Done.

> > +		ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> > +		ASSERT_LE(0, ruleset_fd);
> > +		enforce_ruleset(_metadata, ruleset_fd);
> > +		ASSERT_EQ(0, close(ruleset_fd));
> > +
> > +		fd = open(path, O_WRONLY);
> > +		ASSERT_EQ(variant->expected_open_result, (fd < 0 ? errno : 0));
> > +
> > +		if (fd >= 0) {
> > +			ASSERT_EQ(0, send_fd(socket_fds[0], fd));
> > +			ASSERT_EQ(0, close(fd));
> > +		}
> > +
> > +		ASSERT_EQ(0, close(socket_fds[0]));
> > +
> > +		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
> 
> You might want to add a "return" here to help the compiler (and the reader).

Done.

> > +	}
> > +
> > +	if (variant->expected_open_result == 0) {
> > +		fd = recv_fd(socket_fds[1]);
> > +		ASSERT_LE(0, fd);
> > +
> > +		EXPECT_EQ(variant->expected_ftruncate_result,
> > +			  test_ftruncate(fd));
> > +		ASSERT_EQ(0, close(fd));
> > +	}
> > +
> > +	ASSERT_EQ(child, waitpid(child, &status, 0));
> > +	ASSERT_EQ(1, WIFEXITED(status));
> > +	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> > +
> > +	ASSERT_EQ(0, close(socket_fds[0]));
> > +	ASSERT_EQ(0, close(socket_fds[1]));
> > +}
> > +
> >   /* clang-format off */
> >   FIXTURE(layout1_bind) {};
> >   /* clang-format on */

-- 
