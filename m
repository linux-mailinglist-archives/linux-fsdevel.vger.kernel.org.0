Return-Path: <linux-fsdevel+bounces-29988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9945984A86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 20:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2677B1F21A28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DCA1AC8B2;
	Tue, 24 Sep 2024 18:00:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91EF1AC45E;
	Tue, 24 Sep 2024 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200805; cv=none; b=OgXwkMkCMRi1u2dt1uyqNQjDbs5BY9uU7+9R0/3dBNDVP7KUAbKWuPEfbDy+fy1EeDhYwLRDOSc2guptM3omUD8i2Q2vUNDdD7P5DX3yF7TkDqlAse4hfgfA7fWqWKnNab6RCBCh5o1l36A0o/ylsZDCeEP393araAaz9UgCtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200805; c=relaxed/simple;
	bh=DPUpuU4fGTqB9gqh9Pvq9fF3HhZb2/YHamHccF9iFsM=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=YaNaPu3ikhcEwwQ+LDATBTTy410FggrgwIs3sLSxYQ5p/08nuutC5x9LqoCP/j1Y2LsBWLekFVUzkfRGiwqDm3f8hBijNLr86oqnIK7XnHvWm+uBE+ivsLAHtUWr42iQPzWZL/tGXPk2tcl2Ksa9dRLVBBerNX9cdw8HK1BATDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:55804)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1st9Wk-005D2q-Vn; Tue, 24 Sep 2024 11:40:43 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:34342 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1st9Wj-005TZN-MX; Tue, 24 Sep 2024 11:40:42 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Kees Cook
 <kees@kernel.org>,  Jeff Layton <jlayton@kernel.org>,  Chuck Lever
 <chuck.lever@oracle.com>,  Alexander Aring <alex.aring@gmail.com>,
  linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Tycho Andersen <tandersen@netflix.com>,
  Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,  Aleksa
 Sarai
 <cyphar@cyphar.com>
References: <20240924141001.116584-1-tycho@tycho.pizza>
Date: Tue, 24 Sep 2024 12:39:35 -0500
In-Reply-To: <20240924141001.116584-1-tycho@tycho.pizza> (Tycho Andersen's
	message of "Tue, 24 Sep 2024 08:10:01 -0600")
Message-ID: <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1st9Wj-005TZN-MX;;;mid=<87msjx9ciw.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+fnbih3tUHG8eMw0G+LQU28U/qMv8L3Bk=
X-Spam-Level: *******
X-Spam-Report: 
	*  7.0 XM_URI_RBL URI blacklisted in uri.bl.xmission.com
	*      [URIs: waw.pl]
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4613]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *******;Tycho Andersen <tycho@tycho.pizza>
X-Spam-Relay-Country: 
X-Spam-Timing: total 682 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 12 (1.7%), b_tie_ro: 10 (1.4%), parse: 1.60
	(0.2%), extract_message_metadata: 23 (3.4%), get_uri_detail_list: 5
	(0.8%), tests_pri_-2000: 37 (5.4%), tests_pri_-1000: 2.8 (0.4%),
	tests_pri_-950: 1.43 (0.2%), tests_pri_-900: 1.25 (0.2%),
	tests_pri_-90: 141 (20.7%), check_bayes: 138 (20.3%), b_tokenize: 15
	(2.2%), b_tok_get_all: 17 (2.5%), b_comp_prob: 5 (0.8%),
	b_tok_touch_all: 95 (13.9%), b_finish: 1.49 (0.2%), tests_pri_0: 446
	(65.4%), check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 3.3
	(0.5%), poll_dns_idle: 1.41 (0.2%), tests_pri_10: 2.1 (0.3%),
	tests_pri_500: 9 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: cyphar@cyphar.com, zbyszek@in.waw.pl, tandersen@netflix.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, alex.aring@gmail.com, chuck.lever@oracle.com, jlayton@kernel.org, kees@kernel.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, tycho@tycho.pizza
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Tycho Andersen <tycho@tycho.pizza> writes:

> From: Tycho Andersen <tandersen@netflix.com>
>
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
>
> This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
> contents of argv[0], instead of the fdno.

The kernel allows prctl(PR_SET_NAME, ...)  without any permission
checks so adding an AT_ flat to use argv[0] instead of the execed
filename seems reasonable.

Maybe the flag should be called AT_NAME_ARGV0.


That said I am trying to remember why we picked /dev/fd/N, as the
filename.

My memory is that we couldn't think of anything more reasonable to use.
Looking at commit 51f39a1f0cea ("syscalls: implement execveat() system
call") unfortunately doesn't clarify anything for me, except that
/dev/fd/N was a reasonable choice.

I am thinking the code could reasonably try:
	get_fs_root_rcu(current->fs, &root);
	path =3D __d_path(file->f_path, root, buf, buflen);

To see if a path to the file from the current root directory can be
found.  For files that are not reachable from the current root the code
still need to fallback to /dev/fd/N.

Do you think you can investigate that and see if that would generate
a reasonable task->comm?

If for no other reason than because it would generate a usable result
for #! scripts, without /proc mounted.



It looks like a reasonable case can be made that while /dev/fd/N is
a good path for interpreters, it is never a good choice for comm,
so perhaps we could always use argv[0] if the fdpath is of the
form /dev/fd/N.


All of that said I am not a fan of the implementation below as it has
the side effect of replacing /dev/fd/N with a filename that is not
usable by #! interpreters.  So I suggest an implementation that affects
task->comm and not brpm->filename.

Eric


> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> Suggested-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> ---
> There is some question about what to name the flag; it seems to me that
> "everyone wants this" instead of the fdno, but probably "REASONABLE" is n=
ot
> a good choice.
>
> Also, requiring the arg to alloc_bprm() is a bit ugly: kernel-based execs
> will never use this, so they just have to pass an empty thing. We could
> introduce a bprm_fixup_comm() to do the munging there, but then the code
> paths start to diverge, which is maybe not nice. I left it this way becau=
se
> this is the smallest patch in terms of size, but I'm happy to change it.
>
> Finally, here is a small set of test programs, I'm happy to turn them into
> kselftests if we agree on an API
>
> #include <stdio.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
>
> int main(void)
> {
> 	int fd;
> 	char buf[128];
>
> 	fd =3D open("/proc/self/comm", O_RDONLY);
> 	if (fd < 0) {
> 		perror("open comm");
> 		exit(1);
> 	}
>
> 	if (read(fd, buf, 128) < 0) {
> 		perror("read");
> 		exit(1);
> 	}
>
> 	printf("comm: %s", buf);
> 	exit(0);
> }
>
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <syscall.h>
> #include <stdbool.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <sys/wait.h>
>
> #ifndef AT_EMPTY_PATH
> #define AT_EMPTY_PATH                        0x1000  /* Allow empty relat=
ive */
> #endif
>
> #ifndef AT_EXEC_REASONABLE_COMM
> #define AT_EXEC_REASONABLE_COMM         0x200
> #endif
>
> int main(int argc, char *argv[])
> {
> 	pid_t pid;
> 	int status;
> 	bool wants_reasonable_comm =3D argc > 1;
>
> 	pid =3D fork();
> 	if (pid < 0) {
> 		perror("fork");
> 		exit(1);
> 	}
>
> 	if (pid =3D=3D 0) {
> 		int fd;
> 		long ret, flags;
>
> 		fd =3D open("./catprocselfcomm", O_PATH);
> 		if (fd < 0) {
> 			perror("open catprocselfname");
> 			exit(1);
> 		}
>
> 		flags =3D AT_EMPTY_PATH;
> 		if (wants_reasonable_comm)
> 			flags |=3D AT_EXEC_REASONABLE_COMM;
> 		syscall(__NR_execveat, fd, "", (char *[]){"./catprocselfcomm", NULL}, N=
ULL, flags);
> 		fprintf(stderr, "execveat failed %d\n", errno);
> 		exit(1);
> 	}
>
> 	if (waitpid(pid, &status, 0) !=3D pid) {
> 		fprintf(stderr, "wrong child\n");
> 		exit(1);
> 	}
>
> 	if (!WIFEXITED(status)) {
> 		fprintf(stderr, "exit status %x\n", status);
> 		exit(1);
> 	}
>
> 	if (WEXITSTATUS(status) !=3D 0) {
> 		fprintf(stderr, "child failed\n");
> 		exit(1);
> 	}
>
> 	return 0;
> }
> ---
>  fs/exec.c                  | 22 ++++++++++++++++++----
>  include/uapi/linux/fcntl.h |  3 ++-
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index dad402d55681..36434feddb7b 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1569,11 +1569,15 @@ static void free_bprm(struct linux_binprm *bprm)
>  	kfree(bprm);
>  }
>=20=20
> -static struct linux_binprm *alloc_bprm(int fd, struct filename *filename=
, int flags)
> +static struct linux_binprm *alloc_bprm(int fd, struct filename *filename,
> +				       struct user_arg_ptr argv, int flags)
>  {
>  	struct linux_binprm *bprm;
>  	struct file *file;
>  	int retval =3D -ENOMEM;
> +	bool needs_comm_fixup =3D flags & AT_EXEC_REASONABLE_COMM;
> +
> +	flags &=3D ~AT_EXEC_REASONABLE_COMM;
>=20=20
>  	file =3D do_open_execat(fd, filename, flags);
>  	if (IS_ERR(file))
> @@ -1590,11 +1594,20 @@ static struct linux_binprm *alloc_bprm(int fd, st=
ruct filename *filename, int fl
>  	if (fd =3D=3D AT_FDCWD || filename->name[0] =3D=3D '/') {
>  		bprm->filename =3D filename->name;
>  	} else {
> -		if (filename->name[0] =3D=3D '\0')
> +		if (needs_comm_fixup) {
> +			const char __user *p =3D get_user_arg_ptr(argv, 0);
> +
> +			retval =3D -EFAULT;
> +			if (!p)
> +				goto out_free;
> +
> +			bprm->fdpath =3D strndup_user(p, MAX_ARG_STRLEN);
> +		} else if (filename->name[0] =3D=3D '\0')
>  			bprm->fdpath =3D kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
>  		else
>  			bprm->fdpath =3D kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
>  						  fd, filename->name);
> +		retval =3D -ENOMEM;
>  		if (!bprm->fdpath)
>  			goto out_free;
>=20=20
> @@ -1969,7 +1982,7 @@ static int do_execveat_common(int fd, struct filena=
me *filename,
>  	 * further execve() calls fail. */
>  	current->flags &=3D ~PF_NPROC_EXCEEDED;
>=20=20
> -	bprm =3D alloc_bprm(fd, filename, flags);
> +	bprm =3D alloc_bprm(fd, filename, argv, flags);
>  	if (IS_ERR(bprm)) {
>  		retval =3D PTR_ERR(bprm);
>  		goto out_ret;
> @@ -2034,6 +2047,7 @@ int kernel_execve(const char *kernel_filename,
>  	struct linux_binprm *bprm;
>  	int fd =3D AT_FDCWD;
>  	int retval;
> +	struct user_arg_ptr user_argv =3D {};
>=20=20
>  	/* It is non-sense for kernel threads to call execve */
>  	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
> @@ -2043,7 +2057,7 @@ int kernel_execve(const char *kernel_filename,
>  	if (IS_ERR(filename))
>  		return PTR_ERR(filename);
>=20=20
> -	bprm =3D alloc_bprm(fd, filename, 0);
> +	bprm =3D alloc_bprm(fd, filename, user_argv, 0);
>  	if (IS_ERR(bprm)) {
>  		retval =3D PTR_ERR(bprm);
>  		goto out_ret;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 87e2dec79fea..7178d1e4a3de 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -100,7 +100,8 @@
>  /* Reserved for per-syscall flags	0xff. */
>  #define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
>  						   links. */
> -/* Reserved for per-syscall flags	0x200 */
> +#define AT_EXEC_REASONABLE_COMM		0x200   /* Use argv[0] for comm in
> +						   execveat */
>  #define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
>  #define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
>  						   traversal. */
>
> base-commit: baeb9a7d8b60b021d907127509c44507539c15e5

