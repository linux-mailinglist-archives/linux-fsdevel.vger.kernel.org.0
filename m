Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0A130995
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 20:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgAETIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 14:08:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41978 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAETIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:08:17 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so42963569ioo.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jan 2020 11:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BCTcRrTcnLIdSFlZUFovhn7ud4Us6Qx7aWDrGSYm67Q=;
        b=qYk0nmgVpoY9YoDHOxjF4mOC4ayRwWpoRM33m7Aq4+32Ri09ouv1zIeFJrMg0N803o
         EflL3e+64TtZ1YBbJaz5m45rlVlVsHD7KOhs9SnDIFvBJ5uaWZeNUtowdshTceV7mldH
         Yjz4JlEHPtoW2z8U+Wj/G1+JMj9K0Jp5JKiIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BCTcRrTcnLIdSFlZUFovhn7ud4Us6Qx7aWDrGSYm67Q=;
        b=sX5KQ8fjoTAzrkTTR3jxdU3S5JYUnuJM5wuT5VJNNq8XwmYZ4OxTzIGg8stWxoLU1c
         P74huyBPyhzzI/5Ng/05W2Ah1CsojR0Kduxr4omsEFSqgS6M1YI9e30agC3RUkxvSOW4
         2gxX/VK9P7ifdQcJCszSgpt83cdG4u9WVUh1ZJoyNx4/5nWD2OgGbSbjk1K1m9XULfJt
         XCy08iI+shgp7k3EZCVN1JzbJ9aDMdOecgbMR70Ltx2sa9429xmp4UEXD/ZkX/+iIWrO
         jg9TQhWymQIP8NrQHZnhe+GtWqPrdJIrCsWcaB8HmesMiUPNM1fNYGZAMST4mHbBxXea
         6wSg==
X-Gm-Message-State: APjAAAUJ7txCOIWecIZUzIWmyx3zPoeGusGoV3PkvH3N3OUPtC7CA5DC
        K1U38S21xKtMnvWcn9aRiAg0vg==
X-Google-Smtp-Source: APXvYqzdckJ9Zu6U6Th8Nv2+cCNO4pDtZO1eGKFxh8LVem83U1q4C3C5VApurw+rMeiVUIXzIkMvVg==
X-Received: by 2002:a02:7310:: with SMTP id y16mr8843445jab.133.1578251295532;
        Sun, 05 Jan 2020 11:08:15 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id e1sm23153880ill.47.2020.01.05.11.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jan 2020 11:08:14 -0800 (PST)
Date:   Sun, 5 Jan 2020 19:08:13 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: Re: [PATCH v8 3/3] test: Add test for pidfd getfd
Message-ID: <20200105190812.GC8522@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200103162928.5271-1-sargun@sargun.me>
 <20200103162928.5271-4-sargun@sargun.me>
 <20200105142019.umls5ff4b5433u6k@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105142019.umls5ff4b5433u6k@wittgenstein>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 05, 2020 at 03:20:23PM +0100, Christian Brauner wrote:
> On Fri, Jan 03, 2020 at 08:29:28AM -0800, Sargun Dhillon wrote:
> > +static int sys_pidfd_getfd(int pidfd, int fd, int flags)
> > +{
> > +	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
> > +}
> 
> I think you can move this to the pidfd.h header as:
> 
> static inline int sys_pidfd_getfd(int pidfd, int fd, int flags)
> {
> 	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
> }
> 
> Note, this also needs an
> 
> #ifndef __NR_pidfd_getfd
> __NR_pidfd_getfd -1
> #endif
> so that compilation doesn't fail.
> 
I'll go ahead and move this into pidfd.h, and follow the pattern there. I
don't think it's worth checking if each time the return code is ENOSYS.

Does it make sense to add something like:
#ifdef __NR_pidfd_getfd
TEST_HARNESS_MAIN
#else
int main(void)
{
	fprintf(stderr, "pidfd_getfd syscall not supported\n");
	return KSFT_SKIP;
}
#endif

to short-circuit the entire test suite?


> > +
> > +static int sys_memfd_create(const char *name, unsigned int flags)
> > +{
> > +	return syscall(__NR_memfd_create, name, flags);
> > +}
> > +
> > +static int __child(int sk, int memfd)
> > +{
> > +	int ret;
> > +	char buf;
> > +
> > +	/*
> > +	 * Ensure we don't leave around a bunch of orphaned children if our
> > +	 * tests fail.
> > +	 */
> > +	ret = prctl(PR_SET_PDEATHSIG, SIGKILL);
> > +	if (ret) {
> > +		fprintf(stderr, "%s: Child could not set DEATHSIG\n",
> > +			strerror(errno));
> > +		return EXIT_FAILURE;
> 
> return -1
> 
> > +	}
> > +
> > +	ret = send(sk, &memfd, sizeof(memfd), 0);
> > +	if (ret != sizeof(memfd)) {
> > +		fprintf(stderr, "%s: Child failed to send fd number\n",
> > +			strerror(errno));
> > +		return EXIT_FAILURE;
> 
> return -1
> 
> > +	}
> > +
> > +	while ((ret = recv(sk, &buf, sizeof(buf), 0)) > 0) {
> > +		if (buf == 'P') {
> > +			ret = prctl(PR_SET_DUMPABLE, 0);
> > +			if (ret < 0) {
> > +				fprintf(stderr,
> > +					"%s: Child failed to disable ptrace\n",
> > +					strerror(errno));
> > +				return EXIT_FAILURE;
> 
> return -1
> 
> > +			}
> > +		} else {
> > +			fprintf(stderr, "Child received unknown command %c\n",
> > +				buf);
> > +			return EXIT_FAILURE;
> 
> return -1
> 
> > +		}
> > +		ret = send(sk, &buf, sizeof(buf), 0);
> > +		if (ret != 1) {
> > +			fprintf(stderr, "%s: Child failed to ack\n",
> > +				strerror(errno));
> > +			return EXIT_FAILURE;
> 
> return -1
> 
> > +		}
> > +	}
> > +
> > +	if (ret < 0) {
> > +		fprintf(stderr, "%s: Child failed to read from socket\n",
> > +			strerror(errno));
> 
> Is this intentional that this is no failure?
> 
My thought here, is the only case where this should happen is if the "ptrace 
command" was not properly "transmitted", and the ptrace test itself would fail.

I can add an explicit exit failure here.

> > +	}
> > +
> > +	return EXIT_SUCCESS;
> 
> return 0
> 
> > +}
> > +
> > +static int child(int sk)
> > +{
> > +	int memfd, ret;
> > +
> > +	memfd = sys_memfd_create("test", 0);
> > +	if (memfd < 0) {
> > +		fprintf(stderr, "%s: Child could not create memfd\n",
> > +			strerror(errno));
> > +		ret = EXIT_FAILURE;
> 
> ret = -1;
> 
> > +	} else {
> > +		ret = __child(sk, memfd);
> > +		close(memfd);
> > +	}
> > +
> > +	close(sk);
> > +	return ret;
> > +}
> > +
> > +FIXTURE(child)
> > +{
> > +	pid_t pid;
> > +	int pidfd, sk, remote_fd;
> > +};
> > +
> > +FIXTURE_SETUP(child)
> > +{
> > +	int ret, sk_pair[2];
> > +
> > +	ASSERT_EQ(0, socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair))
> > +	{
> > +		TH_LOG("%s: failed to create socketpair", strerror(errno));
> > +	}
> > +	self->sk = sk_pair[0];
> > +
> > +	self->pid = fork();
> > +	ASSERT_GE(self->pid, 0);
> > +
> > +	if (self->pid == 0) {
> > +		close(sk_pair[0]);
> > +		exit(child(sk_pair[1]));
> 
> if (child(sk_pair[1]))
> 	_exit(EXIT_FAILURE);
> _exit(EXIT_SUCCESS);
> 
> I would like to only use exit macros where one actually calls
> {_}exit()s. It makes the logic easier to follow and ensures that one
> doesn't accidently do an exit(-21345) or something (e.g. when adding new
> code).
> 
> > +	}
> > +
> > +	close(sk_pair[1]);
> > +
> > +	self->pidfd = sys_pidfd_open(self->pid, 0);
> > +	ASSERT_GE(self->pidfd, 0);
> > +
> > +	/*
> > +	 * Wait for the child to complete setup. It'll send the remote memfd's
> > +	 * number when ready.
> > +	 */
> > +	ret = recv(sk_pair[0], &self->remote_fd, sizeof(self->remote_fd), 0);
> > +	ASSERT_EQ(sizeof(self->remote_fd), ret);
> > +}
> > +
> > +FIXTURE_TEARDOWN(child)
> > +{
> > +	int status;
> > +
> > +	EXPECT_EQ(0, close(self->pidfd));
> > +	EXPECT_EQ(0, close(self->sk));
> > +
> > +	EXPECT_EQ(waitpid(self->pid, &status, 0), self->pid);
> > +	EXPECT_EQ(true, WIFEXITED(status));
> > +	EXPECT_EQ(0, WEXITSTATUS(status));
> > +}
> > +
> > +TEST_F(child, disable_ptrace)
> > +{
> > +	int uid, fd;
> > +	char c;
> > +
> > +	/*
> > +	 * Turn into nobody if we're root, to avoid CAP_SYS_PTRACE
> > +	 *
> > +	 * The tests should run in their own process, so even this test fails,
> > +	 * it shouldn't result in subsequent tests failing.
> > +	 */
> > +	uid = getuid();
> > +	if (uid == 0)
> > +		ASSERT_EQ(0, seteuid(USHRT_MAX));
> 
> Hm, isn't it safer to do 65535 explicitly? Since USHRT_MAX can
> technically be greater than 65535.
> 
I borrowed this from the BPF tests. I can hardcode something like:
#define NOBODY_UID 65535
and setuid to that, if you think it's safer?

> > +
> > +	ASSERT_EQ(1, send(self->sk, "P", 1, 0));
> > +	ASSERT_EQ(1, recv(self->sk, &c, 1, 0));
> > +
> > +	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
> > +	EXPECT_EQ(-1, fd);
> > +	EXPECT_EQ(EPERM, errno);
> > +
> > +	if (uid == 0)
> > +		ASSERT_EQ(0, seteuid(0));
> > +}
> > +
> > +TEST_F(child, fetch_fd)
> > +{
> > +	int fd, ret;
> > +
> > +	fd = sys_pidfd_getfd(self->pidfd, self->remote_fd, 0);
> > +	ASSERT_GE(fd, 0);
> > +
> > +	EXPECT_EQ(0, sys_kcmp(getpid(), self->pid, KCMP_FILE, fd, self->remote_fd));
> 
> So most of these tests seem to take place when the child has already
> called exit() - or at least it's very likely that the child has already
> called exit() - and remains a zombie. That's not ideal because
> that's not the common scenario/use-case. Usually the task of which we
> want to get an fd will be alive. Also, if the child has already called
> exit(), by the time it returns to userspace it should have already
> called exit_files() and so I wonder whether this test would fail if it's
> run after the child has exited. Maybe I'm missing something here... Is
> there some ordering enforced by TEST_F()?
Yeah, I think perhaps I was being too clever.
The timeline roughly goes something like this:

# Fixture bringup
[parent] creates socket_pair
[parent] forks, and passes pair down to child
[parent] waits to read sizeof(int) from the sk_pair
[child] creates memfd 
[__child] sends local memfd number to parent via sk_pair
[__child] waits to read from sk_pair
[parent] reads remote memfd number from socket
# Test
[parent] performs tests
# Fixture teardown
[parent] closes sk_pair
[__child] reads 0 from recv on sk_pair, implies the other end is closed
[__child] Returns / exits 0
[parent] Reaps child / reads exit code

---
The one case where this is not true, is if the parent sends 'P' to the sk pair,
it triggers setting PR_SET_DUMPABLE to 0, and then resumes waiting for the fd to 
close.

Maybe I'm being too clever? Instead, the alternative was to send explicit stop / 
start messages across the sk_pair, but that got kind of ugly. Do you have a 
better suggestion?

> 
> Also, what does self->pid point to? The fd of the already exited child?
It's just the pid of the child. pidfd is the fd of the (unexited) child.
