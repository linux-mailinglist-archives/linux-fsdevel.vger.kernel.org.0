Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE921D9B61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 17:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgESPe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 11:34:29 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:43802
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729163AbgESPe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 11:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589902466; bh=u6y7jD7irIPrz4ygvm5ho2cGuh2fc+VLGBO1XaL/vh0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=L3eVjYkmLk2P+06xWemIb6Bh/4J1pBvoX8B6PzZj71dhOcNptuAX57ixdmupeSK0C30VQvQ8ASxpGcjQls96j3hwOoFZkgTwFTej+HIWvnK7nX4wMUxjqA1G6scAZLPGR0IOsbriYG0giYdAGfqPjPl1Xyzl/IerpxBvfV4dw5JTWue76nP+3dEka9byK4fBPmvvAPpt0GYZZhOeteBNEah0FtSKPIjAWfKSx3JS5HJkyioAvXj4u/qyjT2kXlL33EJEhheWMkyLUH3lY0FH2BA0xv3T1hQGszoSwtoqC78l/Abtd21N8gqoMVoWBERDQJRj2Cs4mNBtJDSRk/GWpA==
X-YMail-OSG: RvL2Fq4VM1kML1LOti7R12CS4FkaASEd7ibAP85PAoU0cVemQ0lW0.4uOIK5GKy
 Rb8NULeebJJb7f55UV_DNx4mDdkPHiVd2AEz2tRWl7nQ6hj0b2NpFDYMn2Uz43qxh8LksWxzzm0S
 97YuSgg5JcZtouaEitNFE6kxAjS3dp6r5_kOLtoHb3OjUnOLr90WymjOb5FHfi3zZdSvDEL0Ekxx
 f1a226KJQCiOM_VekxAWYGWB6AYfEkKWijtnmvcfbbHN9Kj6azCOCZ_IwcX5j3sfYUvYkJIsMSZE
 1gD6OWxRBi_4Q3vq8HEZdsNe6Nq1ug3BPGb1uCAQNXswK2nf0IT2cdPgaQz5scsKzb8Tm.fPJ4xk
 oAtqIT6fo.HoQM7qaLIE_PhCduSIMtcWJuxFkOiEBn2oSoFr5dPuRvSg3cwWQq_ChuRThqfM1Ft3
 p6t0XDYD3DTDXh9Lyaure4YTP8GLmxXnw9QnV8n0n0wpz5UWGhGa_M.cC3fRuFn3jdVlznSu3xj6
 YMIBTJ8eTdyDz3lh.13ByXqNHTC_Fq0076BTbVx8BRyWh_jaTvUspDIRn3sOtW6oVFPURhTnxzT0
 cpoiPZOx5Tq.49gvV3hn7axfeggXW0YE4qID0cssaA7iTk3w7ihJqTQ1gaU0yFF2Yzf8DMwAHqbC
 edG3fyghalu1mbO3JGwK4qdp6WOnLOw3eEmJ8IRanYlr1dey2n9mEbaya5dMPGpriT8lJzUksXxd
 Ta7CbtGimu0icIw.V6RUDzTDva0N4MPaIYfTi0O4BseB4E_pTSmJCJ1oA1Sd7urB7Fmn9UxqkN5v
 iYUjHG5qTJluY0.CyihyHgri59hDfztsExV3c0HEMPYg9UEnn9cAXU6UCihB2LqFN4UkXTVOpGUr
 fvEiAiEyMdwFYwiaTrXgYAaVr5dpWN0._8rUjy5LKpQ9.SpTU6DN5I3j_1w3sWZumU4_Gb38TPD9
 K8qQO4MlAkzhURvXcL9_EJWu6oc3j_TbG2f58EID8OVyUEeNR9vCXEP4ESpwMKg2rza2aMe1Nqtc
 NYnOu0jt0Rm_Mmruslc6s.pGhYN_HJFSbuOImoPWqqkBcuqUg74Mrcvmv3tlFf0d9tstpOk4XCLu
 yOjXY06QmeykC_fAP47ECLaUQCUFNV1JgOU3H0zQkFAnPSxny9cdAZzMZ43eVMViax2I5Oyy_X4z
 esSTWjooc21Y3SedVwXBy1OtDIIc56dJQfUtuA2VLqTlLcxjtDOrvyG_yczFqac2qMxh68sQdRor
 XWZ0q0KR3loOBDm5mJktnDuFKjfa1pht53HvEGrkLPhHQMLIhBJRlv7J_k1hRZdXv79vyQhiQYws
 I6ckrILfCxEb1JcIzA_1u.e.zchdTm4w9c5hQHDj1iYcci_dBOASdpyU.Swg7aplwVyy57.dDtMD
 YuX72C46.jqKxn1GaEA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 May 2020 15:34:26 +0000
Received: by smtp424.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cfd52f5f1afed04a4902dc3e057c6d56;
          Tue, 19 May 2020 15:34:24 +0000 (UTC)
Subject: Re: [PATCH v2 2/8] exec: Factor security_bprm_creds_for_exec out of
 security_bprm_set_creds
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87v9kszrzh.fsf_-_@x220.int.ebiederm.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9187b42f-f877-ac9e-f7ff-cdcaef6546bc@schaufler-ca.com>
Date:   Tue, 19 May 2020 08:34:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87v9kszrzh.fsf_-_@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15960 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/2020 5:30 PM, Eric W. Biederman wrote:
> Today security_bprm_set_creds has several implementations:
> apparmor_bprm_set_creds, cap_bprm_set_creds, selinux_bprm_set_creds,
> smack_bprm_set_creds, and tomoyo_bprm_set_creds.
>
> Except for cap_bprm_set_creds they all test bprm->called_set_creds and
> return immediately if it is true.  The function cap_bprm_set_creds
> ignores bprm->calld_sed_creds entirely.
>
> Create a new LSM hook security_bprm_creds_for_exec that is called just
> before prepare_binprm in __do_execve_file, resulting in a LSM hook
> that is called exactly once for the entire of exec.  Modify the bits
> of security_bprm_set_creds that only want to be called once per exec
> into security_bprm_creds_for_exec, leaving only cap_bprm_set_creds
> behind.
>
> Remove bprm->called_set_creds all of it's former users have been moved
> to security_bprm_creds_for_exec.
>
> Add or upate comments a appropriate to bring them up to date and
> to reflect this change.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

For the LSM and Smack bits

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/exec.c                          |  6 +++-
>  include/linux/binfmts.h            | 18 +++--------
>  include/linux/lsm_hook_defs.h      |  1 +
>  include/linux/lsm_hooks.h          | 50 +++++++++++++++++-------------=

>  include/linux/security.h           |  6 ++++
>  security/apparmor/domain.c         |  7 ++---
>  security/apparmor/include/domain.h |  2 +-
>  security/apparmor/lsm.c            |  2 +-
>  security/security.c                |  5 +++
>  security/selinux/hooks.c           |  8 ++---
>  security/smack/smack_lsm.c         |  9 ++----
>  security/tomoyo/tomoyo.c           | 12 ++-----
>  12 files changed, 63 insertions(+), 63 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 14b786158aa9..9e70da47f8d9 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1640,7 +1640,6 @@ int prepare_binprm(struct linux_binprm *bprm)
>  	retval =3D security_bprm_set_creds(bprm);
>  	if (retval)
>  		return retval;
> -	bprm->called_set_creds =3D 1;
> =20
>  	memset(bprm->buf, 0, BINPRM_BUF_SIZE);
>  	return kernel_read(bprm->file, bprm->buf, BINPRM_BUF_SIZE, &pos);
> @@ -1855,6 +1854,11 @@ static int __do_execve_file(int fd, struct filen=
ame *filename,
>  	if (retval < 0)
>  		goto out;
> =20
> +	/* Set the unchanging part of bprm->cred */
> +	retval =3D security_bprm_creds_for_exec(bprm);
> +	if (retval)
> +		goto out;
> +
>  	retval =3D prepare_binprm(bprm);
>  	if (retval < 0)
>  		goto out;
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 1b48e2154766..d1217fcdedea 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -27,22 +27,14 @@ struct linux_binprm {
>  	unsigned long argmin; /* rlimit marker for copy_strings() */
>  	unsigned int
>  		/*
> -		 * True after the bprm_set_creds hook has been called once
> -		 * (multiple calls can be made via prepare_binprm() for
> -		 * binfmt_script/misc).
> -		 */
> -		called_set_creds:1,
> -		/*
> -		 * True if most recent call to the commoncaps bprm_set_creds
> -		 * hook (due to multiple prepare_binprm() calls from the
> -		 * binfmt_script/misc handlers) resulted in elevated
> -		 * privileges.
> +		 * True if most recent call to cap_bprm_set_creds
> +		 * resulted in elevated privileges.
>  		 */
>  		cap_elevated:1,
>  		/*
> -		 * Set by bprm_set_creds hook to indicate a privilege-gaining
> -		 * exec has happened. Used to sanitize execution environment
> -		 * and to set AT_SECURE auxv for glibc.
> +		 * Set by bprm_creds_for_exec hook to indicate a
> +		 * privilege-gaining exec has happened. Used to set
> +		 * AT_SECURE auxv for glibc.
>  		 */
>  		secureexec:1,
>  		/*
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> index 9cd4455528e5..aab0695f41df 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -49,6 +49,7 @@ LSM_HOOK(int, 0, syslog, int type)
>  LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
>  	 const struct timezone *tz)
>  LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
> +LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
>  LSM_HOOK(int, 0, bprm_set_creds, struct linux_binprm *bprm)
>  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binpr=
m *bprm)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 988ca0df7824..c719af37df20 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -34,40 +34,46 @@
>   *
>   * Security hooks for program execution operations.
>   *
> + * @bprm_creds_for_exec:
> + *	If the setup in prepare_exec_creds did not setup @bprm->cred->secur=
ity
> + *	properly for executing @bprm->file, update the LSM's portion of
> + *	@bprm->cred->security to be what commit_creds needs to install for =
the
> + *	new program.  This hook may also optionally check permissions
> + *	(e.g. for transitions between security domains).
> + *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set=
 to
> + *	request libc enable secure mode.
> + *	@bprm contains the linux_binprm structure.
> + *	Return 0 if the hook is successful and permission is granted.
>   * @bprm_set_creds:
> - *	Save security information in the bprm->security field, typically ba=
sed
> - *	on information about the bprm->file, for later use by the apply_cre=
ds
> - *	hook.  This hook may also optionally check permissions (e.g. for
> + *	Assuming that the relevant bits of @bprm->cred->security have been
> + *	previously set, examine @bprm->file and regenerate them.  This is
> + *	so that the credentials derived from the interpreter the code is
> + *	actually going to run are used rather than credentials derived
> + *	from a script.  This done because the interpreter binary needs to
> + *	reopen script, and may end up opening something completely differen=
t.
> + *	This hook may also optionally check permissions (e.g. for
>   *	transitions between security domains).
> - *	This hook may be called multiple times during a single execve, e.g.=
 for
> - *	interpreters.  The hook can tell whether it has already been called=
 by
> - *	checking to see if @bprm->security is non-NULL.  If so, then the ho=
ok
> - *	may decide either to retain the security information saved earlier =
or
> - *	to replace it.  The hook must set @bprm->secureexec to 1 if a "secu=
re
> - *	exec" has happened as a result of this hook call.  The flag is used=
 to
> - *	indicate the need for a sanitized execution environment, and is als=
o
> - *	passed in the ELF auxiliary table on the initial stack to indicate
> - *	whether libc should enable secure mode.
> + *	The hook must set @bprm->cap_elevated to 1 if AT_SECURE should be s=
et to
> + *	request libc enable secure mode.
>   *	@bprm contains the linux_binprm structure.
>   *	Return 0 if the hook is successful and permission is granted.
>   * @bprm_check_security:
>   *	This hook mediates the point when a search for a binary handler wil=
l
> - *	begin.  It allows a check the @bprm->security value which is set in=
 the
> - *	preceding set_creds call.  The primary difference from set_creds is=

> - *	that the argv list and envp list are reliably available in @bprm.  =
This
> - *	hook may be called multiple times during a single execve; and in ea=
ch
> - *	pass set_creds is called first.
> + *	begin.  It allows a check against the @bprm->cred->security value
> + *	which was set in the preceding creds_for_exec call.  The argv list =
and
> + *	envp list are reliably available in @bprm.  This hook may be called=

> + *	multiple times during a single execve.
>   *	@bprm contains the linux_binprm structure.
>   *	Return 0 if the hook is successful and permission is granted.
>   * @bprm_committing_creds:
>   *	Prepare to install the new security attributes of a process being
>   *	transformed by an execve operation, based on the old credentials
>   *	pointed to by @current->cred and the information set in @bprm->cred=
 by
> - *	the bprm_set_creds hook.  @bprm points to the linux_binprm structur=
e.
> - *	This hook is a good place to perform state changes on the process s=
uch
> - *	as closing open file descriptors to which access will no longer be
> - *	granted when the attributes are changed.  This is called immediatel=
y
> - *	before commit_creds().
> + *	the bprm_creds_for_exec hook.  @bprm points to the linux_binprm
> + *	structure.  This hook is a good place to perform state changes on t=
he
> + *	process such as closing open file descriptors to which access will =
no
> + *	longer be granted when the attributes are changed.  This is called
> + *	immediately before commit_creds().
>   * @bprm_committed_creds:
>   *	Tidy up after the installation of the new security attributes of a
>   *	process being transformed by an execve operation.  The new credenti=
als
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a8d9310472df..1bd7a6582775 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -276,6 +276,7 @@ int security_quota_on(struct dentry *dentry);
>  int security_syslog(int type);
>  int security_settime64(const struct timespec64 *ts, const struct timez=
one *tz);
>  int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
> +int security_bprm_creds_for_exec(struct linux_binprm *bprm);
>  int security_bprm_set_creds(struct linux_binprm *bprm);
>  int security_bprm_check(struct linux_binprm *bprm);
>  void security_bprm_committing_creds(struct linux_binprm *bprm);
> @@ -569,6 +570,11 @@ static inline int security_vm_enough_memory_mm(str=
uct mm_struct *mm, long pages)
>  	return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages))=
;
>  }
> =20
> +static inline int security_bprm_creds_for_exec(struct linux_binprm *bp=
rm)
> +{
> +	return 0;
> +}
> +
>  static inline int security_bprm_set_creds(struct linux_binprm *bprm)
>  {
>  	return cap_bprm_set_creds(bprm);
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 6ceb74e0f789..0b870a647488 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -854,14 +854,14 @@ static struct aa_label *handle_onexec(struct aa_l=
abel *label,
>  }
> =20
>  /**
> - * apparmor_bprm_set_creds - set the new creds on the bprm struct
> + * apparmor_bprm_creds_for_exec - Update the new creds on the bprm str=
uct
>   * @bprm: binprm for the exec  (NOT NULL)
>   *
>   * Returns: %0 or error on failure
>   *
>   * TODO: once the other paths are done see if we can't refactor into a=
 fn
>   */
> -int apparmor_bprm_set_creds(struct linux_binprm *bprm)
> +int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm)
>  {
>  	struct aa_task_ctx *ctx;
>  	struct aa_label *label, *new =3D NULL;
> @@ -875,9 +875,6 @@ int apparmor_bprm_set_creds(struct linux_binprm *bp=
rm)
>  		file_inode(bprm->file)->i_mode
>  	};
> =20
> -	if (bprm->called_set_creds)
> -		return 0;
> -
>  	ctx =3D task_ctx(current);
>  	AA_BUG(!cred_label(bprm->cred));
>  	AA_BUG(!ctx);
> diff --git a/security/apparmor/include/domain.h b/security/apparmor/inc=
lude/domain.h
> index 21b875fe2d37..d14928fe1c6f 100644
> --- a/security/apparmor/include/domain.h
> +++ b/security/apparmor/include/domain.h
> @@ -30,7 +30,7 @@ struct aa_domain {
>  struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex=
,
>  				const char **name);
> =20
> -int apparmor_bprm_set_creds(struct linux_binprm *bprm);
> +int apparmor_bprm_creds_for_exec(struct linux_binprm *bprm);
> =20
>  void aa_free_domain_entries(struct aa_domain *domain);
>  int aa_change_hat(const char *hats[], int count, u64 token, int flags)=
;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index b621ad74f54a..3623ab08279d 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1232,7 +1232,7 @@ static struct security_hook_list apparmor_hooks[]=
 __lsm_ro_after_init =3D {
>  	LSM_HOOK_INIT(cred_prepare, apparmor_cred_prepare),
>  	LSM_HOOK_INIT(cred_transfer, apparmor_cred_transfer),
> =20
> -	LSM_HOOK_INIT(bprm_set_creds, apparmor_bprm_set_creds),
> +	LSM_HOOK_INIT(bprm_creds_for_exec, apparmor_bprm_creds_for_exec),
>  	LSM_HOOK_INIT(bprm_committing_creds, apparmor_bprm_committing_creds),=

>  	LSM_HOOK_INIT(bprm_committed_creds, apparmor_bprm_committed_creds),
> =20
> diff --git a/security/security.c b/security/security.c
> index 7fed24b9d57e..4ee76a729f73 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -823,6 +823,11 @@ int security_vm_enough_memory_mm(struct mm_struct =
*mm, long pages)
>  	return __vm_enough_memory(mm, pages, cap_sys_admin);
>  }
> =20
> +int security_bprm_creds_for_exec(struct linux_binprm *bprm)
> +{
> +	return call_int_hook(bprm_creds_for_exec, 0, bprm);
> +}
> +
>  int security_bprm_set_creds(struct linux_binprm *bprm)
>  {
>  	return call_int_hook(bprm_set_creds, 0, bprm);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b77..718345dd76bb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2286,7 +2286,7 @@ static int check_nnp_nosuid(const struct linux_bi=
nprm *bprm,
>  	return -EACCES;
>  }
> =20
> -static int selinux_bprm_set_creds(struct linux_binprm *bprm)
> +static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
>  {
>  	const struct task_security_struct *old_tsec;
>  	struct task_security_struct *new_tsec;
> @@ -2297,8 +2297,6 @@ static int selinux_bprm_set_creds(struct linux_bi=
nprm *bprm)
> =20
>  	/* SELinux context only depends on initial program or script and not
>  	 * the script interpreter */
> -	if (bprm->called_set_creds)
> -		return 0;
> =20
>  	old_tsec =3D selinux_cred(current_cred());
>  	new_tsec =3D selinux_cred(bprm->cred);
> @@ -6385,7 +6383,7 @@ static int selinux_setprocattr(const char *name, =
void *value, size_t size)
>  	/* Permission checking based on the specified context is
>  	   performed during the actual operation (execve,
>  	   open/mkdir/...), when we know the full context of the
> -	   operation.  See selinux_bprm_set_creds for the execve
> +	   operation.  See selinux_bprm_creds_for_exec for the execve
>  	   checks and may_create for the file creation checks. The
>  	   operation will then fail if the context is not permitted. */
>  	tsec =3D selinux_cred(new);
> @@ -6914,7 +6912,7 @@ static struct security_hook_list selinux_hooks[] =
__lsm_ro_after_init =3D {
> =20
>  	LSM_HOOK_INIT(netlink_send, selinux_netlink_send),
> =20
> -	LSM_HOOK_INIT(bprm_set_creds, selinux_bprm_set_creds),
> +	LSM_HOOK_INIT(bprm_creds_for_exec, selinux_bprm_creds_for_exec),
>  	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
>  	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
> =20
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8c61d175e195..0ac8f4518d07 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -891,12 +891,12 @@ static int smack_sb_statfs(struct dentry *dentry)=

>   */
> =20
>  /**
> - * smack_bprm_set_creds - set creds for exec
> + * smack_bprm_creds_for_exec - Update bprm->cred if needed for exec
>   * @bprm: the exec information
>   *
>   * Returns 0 if it gets a blob, -EPERM if exec forbidden and -ENOMEM o=
therwise
>   */
> -static int smack_bprm_set_creds(struct linux_binprm *bprm)
> +static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
>  {
>  	struct inode *inode =3D file_inode(bprm->file);
>  	struct task_smack *bsp =3D smack_cred(bprm->cred);
> @@ -904,9 +904,6 @@ static int smack_bprm_set_creds(struct linux_binprm=
 *bprm)
>  	struct superblock_smack *sbsp;
>  	int rc;
> =20
> -	if (bprm->called_set_creds)
> -		return 0;
> -
>  	isp =3D smack_inode(inode);
>  	if (isp->smk_task =3D=3D NULL || isp->smk_task =3D=3D bsp->smk_task)
>  		return 0;
> @@ -4598,7 +4595,7 @@ static struct security_hook_list smack_hooks[] __=
lsm_ro_after_init =3D {
>  	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
>  	LSM_HOOK_INIT(sb_set_mnt_opts, smack_set_mnt_opts),
> =20
> -	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),
> +	LSM_HOOK_INIT(bprm_creds_for_exec, smack_bprm_creds_for_exec),
> =20
>  	LSM_HOOK_INIT(inode_alloc_security, smack_inode_alloc_security),
>  	LSM_HOOK_INIT(inode_init_security, smack_inode_init_security),
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92ec941a..f9adddc42ac8 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -63,20 +63,14 @@ static void tomoyo_bprm_committed_creds(struct linu=
x_binprm *bprm)
> =20
>  #ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
>  /**
> - * tomoyo_bprm_set_creds - Target for security_bprm_set_creds().
> + * tomoyo_bprm_for_exec - Target for security_bprm_creds_for_exec().
>   *
>   * @bprm: Pointer to "struct linux_binprm".
>   *
>   * Returns 0.
>   */
> -static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
> +static int tomoyo_bprm_creds_for_exec(struct linux_binprm *bprm)
>  {
> -	/*
> -	 * Do only if this function is called for the first time of an execve=

> -	 * operation.
> -	 */
> -	if (bprm->called_set_creds)
> -		return 0;
>  	/*
>  	 * Load policy if /sbin/tomoyo-init exists and /sbin/init is requeste=
d
>  	 * for the first time.
> @@ -539,7 +533,7 @@ static struct security_hook_list tomoyo_hooks[] __l=
sm_ro_after_init =3D {
>  	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
>  	LSM_HOOK_INIT(task_free, tomoyo_task_free),
>  #ifndef CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER
> -	LSM_HOOK_INIT(bprm_set_creds, tomoyo_bprm_set_creds),
> +	LSM_HOOK_INIT(bprm_creds_for_exec, tomoyo_bprm_creds_for_exec),
>  #endif
>  	LSM_HOOK_INIT(bprm_check_security, tomoyo_bprm_check_security),
>  	LSM_HOOK_INIT(file_fcntl, tomoyo_file_fcntl),

