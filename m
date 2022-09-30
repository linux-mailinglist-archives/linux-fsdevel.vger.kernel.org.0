Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234BB5F11A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiI3Scb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 14:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiI3Sca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:32:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9122214E753;
        Fri, 30 Sep 2022 11:32:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so10799019eja.6;
        Fri, 30 Sep 2022 11:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=dE6obZiIgfKr0o00fT11Cpooh4R4nzb/jAZ1FqF/O4g=;
        b=bbAyirm0fXi75Lqp0T6cxdK0fTjVxb9UoDECZk4FEGzOsOPPfTHUfk3+bwPfbMEaC9
         wg6LC7W03/Eoh6nSEAbwd70/YZ8bDTvAPbk4oyfXwt7sCvXINRMNpKZ2yuM9wavcF141
         5WqCfKlnMAOidlf1ByY2Fi0Vs6QXGAlAFUjl9x8L7d31dZ3Or7Z0ooCfhnpTjOgaA0i2
         NDnXuFtNap5lagLwG0L8d3i9GFwltqjZ8gH3ju8q/LlX9qoROXsLCZdAngm52re2ua4T
         pU2Y8RovMDrLK470+g+R6wYgt6cNj2vc9T7px5XYVaho/4II0bp7vrXX4JYEYG/TD2dP
         RRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dE6obZiIgfKr0o00fT11Cpooh4R4nzb/jAZ1FqF/O4g=;
        b=jDIustHNIG3Zp+FN52pqKEjGxObZ3tXcPXUOgudZ4cWzqa93FSMcmo4mC3WwPTV+tt
         JBU+eYhH/7uIEUAWOG2EmgbJ3us75wRo7L4u/rdA4Rbs/o66xtAMAC4Xij3I63JRgKds
         crofooB6F4kwAFZuNnD1bMtT5oG9WQUEUp/2KojLowwj09UgLbdqaF9WbftTYVCo1p4P
         0I4BTTox/JYHyHSCziUAsM0GA+16r5xlT4f0sWSXMOrnCaBUVUobgDtHF9bSup9173SS
         qX5nTdG8LTm/CnZH8rCukgn2b0kFMdRXNVb0KD+M8rVAopT3LGaMrEyWqgqu6hhNDTHR
         yhig==
X-Gm-Message-State: ACrzQf16zc+5H3VMpRFpYD8l918BNX+dpqvm8RBJUpgaaMCoFiX1chj9
        SkYPNXL4CXB6qEjyBuheYNbO8l6bbus=
X-Google-Smtp-Source: AMsMyM43GrRlCSrPxlzmuYESg1LvIYHtaVUeVcds1EugnEIeU7WGTWaDfY0e0PAOAmegd7Cb59I9Cg==
X-Received: by 2002:a17:907:2c41:b0:77d:8aed:cf7c with SMTP id hf1-20020a1709072c4100b0077d8aedcf7cmr7377335ejc.447.1664562746965;
        Fri, 30 Sep 2022 11:32:26 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d10-20020a170906304a00b0073d5948855asm1346999ejd.1.2022.09.30.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:32:26 -0700 (PDT)
Date:   Fri, 30 Sep 2022 20:32:24 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v7 5/7] selftests/landlock: Test FD passing from a
 Landlock-restricted to an unrestricted process
Message-ID: <Yzc2ONgHFHwGS6y3@nuc>
References: <20220930160144.141504-1-gnoack3000@gmail.com>
 <20220930160144.141504-6-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930160144.141504-6-gnoack3000@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 06:01:42PM +0200, Günther Noack wrote:
> A file descriptor created in a restricted process carries Landlock
> restrictions with it which will apply even if the same opened file is
> used from an unrestricted process.
> 
> This change extracts suitable FD-passing helpers from base_test.c and
> moves them to common.h. We use the fixture variants from the ftruncate
> fixture to exercise the same scenarios as in the open_and_ftruncate
> test, but doing the Landlock restriction and open() in a different
> process than the ftruncate() call.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  tools/testing/selftests/landlock/base_test.c | 36 +----------
>  tools/testing/selftests/landlock/common.h    | 67 ++++++++++++++++++++
>  tools/testing/selftests/landlock/fs_test.c   | 62 ++++++++++++++++++
>  3 files changed, 132 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> index 72cdae277b02..6d1b6eedb432 100644
> --- a/tools/testing/selftests/landlock/base_test.c
> +++ b/tools/testing/selftests/landlock/base_test.c
> @@ -263,23 +263,6 @@ TEST(ruleset_fd_transfer)
>  		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
>  	};
>  	int ruleset_fd_tx, dir_fd;
> -	union {
> -		/* Aligned ancillary data buffer. */
> -		char buf[CMSG_SPACE(sizeof(ruleset_fd_tx))];
> -		struct cmsghdr _align;
> -	} cmsg_tx = {};
> -	char data_tx = '.';
> -	struct iovec io = {
> -		.iov_base = &data_tx,
> -		.iov_len = sizeof(data_tx),
> -	};
> -	struct msghdr msg = {
> -		.msg_iov = &io,
> -		.msg_iovlen = 1,
> -		.msg_control = &cmsg_tx.buf,
> -		.msg_controllen = sizeof(cmsg_tx.buf),
> -	};
> -	struct cmsghdr *cmsg;
>  	int socket_fds[2];
>  	pid_t child;
>  	int status;
> @@ -298,33 +281,20 @@ TEST(ruleset_fd_transfer)
>  				    &path_beneath_attr, 0));
>  	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
>  
> -	cmsg = CMSG_FIRSTHDR(&msg);
> -	ASSERT_NE(NULL, cmsg);
> -	cmsg->cmsg_len = CMSG_LEN(sizeof(ruleset_fd_tx));
> -	cmsg->cmsg_level = SOL_SOCKET;
> -	cmsg->cmsg_type = SCM_RIGHTS;
> -	memcpy(CMSG_DATA(cmsg), &ruleset_fd_tx, sizeof(ruleset_fd_tx));
> -
>  	/* Sends the ruleset FD over a socketpair and then close it. */
>  	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
>  				socket_fds));
> -	ASSERT_EQ(sizeof(data_tx), sendmsg(socket_fds[0], &msg, 0));
> +	ASSERT_EQ(0, send_fd(socket_fds[0], ruleset_fd_tx));
>  	ASSERT_EQ(0, close(socket_fds[0]));
>  	ASSERT_EQ(0, close(ruleset_fd_tx));
>  
>  	child = fork();
>  	ASSERT_LE(0, child);
>  	if (child == 0) {
> -		int ruleset_fd_rx;
> +		int ruleset_fd_rx = recv_fd(socket_fds[1]);
>  
> -		*(char *)msg.msg_iov->iov_base = '\0';
> -		ASSERT_EQ(sizeof(data_tx),
> -			  recvmsg(socket_fds[1], &msg, MSG_CMSG_CLOEXEC));
> -		ASSERT_EQ('.', *(char *)msg.msg_iov->iov_base);
> +		ASSERT_LE(0, ruleset_fd_rx);
>  		ASSERT_EQ(0, close(socket_fds[1]));
> -		cmsg = CMSG_FIRSTHDR(&msg);
> -		ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(ruleset_fd_tx)));
> -		memcpy(&ruleset_fd_rx, CMSG_DATA(cmsg), sizeof(ruleset_fd_tx));
>  
>  		/* Enforces the received ruleset on the child. */
>  		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
> index 7ba18eb23783..8ec8971e9580 100644
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -10,6 +10,7 @@
>  #include <errno.h>
>  #include <linux/landlock.h>
>  #include <sys/capability.h>
> +#include <sys/socket.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> @@ -187,3 +188,69 @@ clear_cap(struct __test_metadata *const _metadata, const cap_value_t caps)
>  {
>  	_effective_cap(_metadata, caps, CAP_CLEAR);
>  }
> +
> +/* Receives an FD from a UNIX socket. Returns the received FD, -1 on error. */
> +__maybe_unused static int recv_fd(int usock)

Ah bummer, the definition of "__maybe_unused" is not visible here
(last minute change before sending it off...). Will fix it.

> +{
> +	int fd_rx;
> +	union {
> +		/* Aligned ancillary data buffer. */
> +		char buf[CMSG_SPACE(sizeof(fd_rx))];
> +		struct cmsghdr _align;
> +	} cmsg_rx = {};
> +	char data = '\0';
> +	struct iovec io = {
> +		.iov_base = &data,
> +		.iov_len = sizeof(data),
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &io,
> +		.msg_iovlen = 1,
> +		.msg_control = &cmsg_rx.buf,
> +		.msg_controllen = sizeof(cmsg_rx.buf),
> +	};
> +	struct cmsghdr *cmsg;
> +	int res;
> +
> +	res = recvmsg(usock, &msg, MSG_CMSG_CLOEXEC);
> +	if (res < 0)
> +		return -1;
> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	if (cmsg->cmsg_len != CMSG_LEN(sizeof(fd_rx)))
> +		return -1;
> +
> +	memcpy(&fd_rx, CMSG_DATA(cmsg), sizeof(fd_rx));
> +	return fd_rx;
> +}
> +
> +/* Sends an FD on a UNIX socket. Returns 0 on success or -1 on error. */
> +__maybe_unused static int send_fd(int usock, int fd_tx)
> +{
> +	union {
> +		/* Aligned ancillary data buffer. */
> +		char buf[CMSG_SPACE(sizeof(fd_tx))];
> +		struct cmsghdr _align;
> +	} cmsg_tx = {};
> +	char data_tx = '.';
> +	struct iovec io = {
> +		.iov_base = &data_tx,
> +		.iov_len = sizeof(data_tx),
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &io,
> +		.msg_iovlen = 1,
> +		.msg_control = &cmsg_tx.buf,
> +		.msg_controllen = sizeof(cmsg_tx.buf),
> +	};
> +	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
> +
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(fd_tx));
> +	cmsg->cmsg_level = SOL_SOCKET;
> +	cmsg->cmsg_type = SCM_RIGHTS;
> +	memcpy(CMSG_DATA(cmsg), &fd_tx, sizeof(fd_tx));
> +
> +	if (sendmsg(usock, &msg, 0) < 0)
> +		return -1;
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 308f6f36e8c0..93ed80a25a74 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -3541,6 +3541,68 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
>  	}
>  }
>  
> +TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
> +{
> +	int child, fd, status;
> +	int socket_fds[2];
> +
> +	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0,
> +				socket_fds));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		/*
> +		 * Enable Landlock in the child process, open a file descriptor
> +		 * where truncation is forbidden and send it to the
> +		 * non-landlocked parent process.
> +		 */
> +		const char *const path = file1_s1d1;
> +		const struct rule rules[] = {
> +			{
> +				.path = path,
> +				.access = variant->permitted,
> +			},
> +			{},
> +		};
> +		int fd, ruleset_fd;
> +
> +		/* Enable Landlock. */
> +		ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
> +		ASSERT_LE(0, ruleset_fd);
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		ASSERT_EQ(0, close(ruleset_fd));
> +
> +		fd = open(path, O_WRONLY);
> +		ASSERT_EQ(variant->expected_open_result, (fd < 0 ? errno : 0));
> +
> +		if (fd >= 0) {
> +			ASSERT_EQ(0, send_fd(socket_fds[0], fd));
> +			ASSERT_EQ(0, close(fd));
> +		}
> +
> +		ASSERT_EQ(0, close(socket_fds[0]));
> +
> +		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
> +	}
> +
> +	if (variant->expected_open_result == 0) {
> +		fd = recv_fd(socket_fds[1]);
> +		ASSERT_LE(0, fd);
> +
> +		EXPECT_EQ(variant->expected_ftruncate_result,
> +			  test_ftruncate(fd));
> +		ASSERT_EQ(0, close(fd));
> +	}
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	ASSERT_EQ(1, WIFEXITED(status));
> +	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
> +
> +	ASSERT_EQ(0, close(socket_fds[0]));
> +	ASSERT_EQ(0, close(socket_fds[1]));
> +}
> +
>  /* clang-format off */
>  FIXTURE(layout1_bind) {};
>  /* clang-format on */
> -- 
> 2.37.3
> 

-- 
