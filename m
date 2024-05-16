Return-Path: <linux-fsdevel+bounces-19579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DEB8C7658
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 14:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC7B1F21656
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4DD14E2E1;
	Thu, 16 May 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoxnaF+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C73145FE7;
	Thu, 16 May 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862441; cv=none; b=lCQGxRWJw38Jmgh1zGPbJO+2w7aHmxIWX40fjUSrWqtiQbokE7wKWI9SIKA4hxXFSNNV3fpfMGJNhovye/ssj7f34ounuuQqodZ+kzXxOOoMzcj9B7n4h8bJTEw0IXDhPldDnFY/ofVH/+priKcCjw0GxsBOOTWnJaRdnBcx5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862441; c=relaxed/simple;
	bh=4wTWkHVGv/d85cL7MC+Zxb3BiV8bHTecOKCtqb7PGak=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OHr7IRdh7JMxfrMAL9JF6bLuiVBIP+gb0I+4m8/lTWl7139yy4Lrb4QngotMkwtjII8kS8W67X4IZDmvrByXAQPy0bavYUBO0/svcKlG+OjZGmTOR3XnJCpe5/mJuNE6U07m3tI1AlOMHEHMgu8iKsgacWdkG5r68xw/KtviE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoxnaF+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF214C113CC;
	Thu, 16 May 2024 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715862440;
	bh=4wTWkHVGv/d85cL7MC+Zxb3BiV8bHTecOKCtqb7PGak=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VoxnaF+mGVgu7krUQVYi9L3GaAXF2twF1NTijVjn0k5y2q3SL6nrA3opfhjGUk4BX
	 iHgiq4ujjtt+op2LhoqoWaWEsJHcLSWkaDPHSjMEUm6QzGuiM6nKwaiwuOzdunmGUa
	 Ls81+Q5OA/Ts5Fu4cWvvAiSXgszjWPv6zlmAYZtcIpujFkzzoLLobGBc9wgKe9yz0w
	 ES2VBtWXW5fIYjNvErjHeS96EKWIKpJUK+WkJYUQWNbvjZKA+MONJAdIZrADBwZh7v
	 xRW8rkXqbPG0MDde5NgZ6InRP6OvHYuOPsaqWlOwIa7N1rEk6KAZ/NipkFR2EZ2Rmz
	 yV7HQt+l0a8nw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 15:27:15 +0300
Message-Id: <D1B2GWN6W2J1.18JFE7W9J0BI5@kernel.org>
To: "Jonathan Calmels" <jcalmels@3xx0.net>, <brauner@kernel.org>,
 <ebiederm@xmission.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Kees
 Cook" <keescook@chromium.org>, "Joel Granados" <j.granados@samsung.com>,
 "Serge Hallyn" <serge@hallyn.com>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>
Cc: <containers@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <keyrings@vger.kernel.org>
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
In-Reply-To: <20240516092213.6799-2-jcalmels@3xx0.net>

Some quick remarks, no bandwidth to understand this.

First of all short summary does not define any action so it should be
rather e.g.

"capabilities: Add userns capabilities"

Much more understandable.

On Thu May 16, 2024 at 12:22 PM EEST, Jonathan Calmels wrote:
> Attackers often rely on user namespaces to get elevated (yet confined)
> privileges in order to target specific subsystems (e.g. [1]). Distributio=
ns
> have been pretty adamant that they need a way to configure these, most of
> them carry out-of-tree patches to do so, or plainly refuse to enable them=
.
> As a result, there have been multiple efforts over the years to introduce
> various knobs to control and/or disable user namespaces (e.g. [2][3][4]).
>
> While we acknowledge that there are already ways to control the creation =
of
> such namespaces (the most recent being a LSM hook), there are inherent
> issues with these approaches. Preventing the user namespace creation is n=
ot
> fine-grained enough, and in some cases, incompatible with various userspa=
ce
> expectations (e.g. container runtimes, browser sandboxing, service
> isolation)
>
> This patch addresses these limitations by introducing an additional
> capability set used to restrict the permissions granted when creating use=
r
> namespaces. This way, processes can apply the principle of least privileg=
e
> by configuring only the capabilities they need for their namespaces.
>
> For compatibility reasons, processes always start with a full userns
> capability set.
>
> On namespace creation, the userns capability set (pU) is assigned to the
> new effective (pE), permitted (pP) and bounding set (X) of the task:
>
>     pU =3D pE =3D pP =3D X
>
> The userns capability set obeys the invariant that no bit can ever be set
> if it is not already part of the task=E2=80=99s bounding set. This ensure=
s that no
> namespace can ever gain more privileges than its predecessors.
> Additionally, if a task is not privileged over CAP_SETPCAP, setting any b=
it
> in the userns set requires its corresponding bit to be set in the permitt=
ed
> set. This effectively mimics the inheritable set rules and means that, by
> default, only root in the initial user namespace can gain userns
> capabilities:
>
>     p=E2=80=99U =3D (pE & CAP_SETPCAP) ? X : (X & pP)
>
> Note that since userns capabilities are strictly hierarchical, policies c=
an
> be enforced at various levels (e.g. init, pam_cap) and inherited by every
> child namespace.
>
> Here is a sample program that can be used to verify the functionality:
>
> /*
>  * Test program that drops CAP_SYS_RAWIO from subsequent user namespaces.
>  *
>  * ./cap_userns_test unshare -r grep Cap /proc/self/status
>  * CapInh: 0000000000000000
>  * CapPrm: 000001fffffdffff
>  * CapEff: 000001fffffdffff
>  * CapBnd: 000001fffffdffff
>  * CapAmb: 0000000000000000
>  * CapUNs: 000001fffffdffff
>  */
>
> int main(int argc, char *argv[])
> {
>         if (prctl(PR_CAP_USERNS, PR_CAP_USERNS_LOWER, CAP_SYS_RAWIO, 0, 0=
) < 0)
>                 err(1, "cannot drop userns cap");
>
>         execvp(argv[1], argv + 1);
>         err(1, "cannot exec");
> }
>
> Link: https://security.googleblog.com/2023/06/learnings-from-kctf-vrps-42=
-linux.html
> Link: https://lore.kernel.org/lkml/1453502345-30416-1-git-send-email-kees=
cook@chromium.org
> Link: https://lore.kernel.org/lkml/20220815162028.926858-1-fred@cloudflar=
e.com
> Link: https://lore.kernel.org/containers/168547265011.24337.4306067683997=
517082-0@git.sr.ht
>
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> ---
>  fs/proc/array.c              |  9 ++++++
>  include/linux/cred.h         |  3 ++
>  include/uapi/linux/prctl.h   |  7 +++++
>  kernel/cred.c                |  3 ++
>  kernel/umh.c                 | 16 ++++++++++
>  kernel/user_namespace.c      | 12 +++-----
>  security/commoncap.c         | 59 ++++++++++++++++++++++++++++++++++++
>  security/keys/process_keys.c |  3 ++
>  8 files changed, 105 insertions(+), 7 deletions(-)
>
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 34a47fb0c57f..364e8bb19f9d 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -313,6 +313,9 @@ static inline void task_cap(struct seq_file *m, struc=
t task_struct *p)
>  	const struct cred *cred;
>  	kernel_cap_t cap_inheritable, cap_permitted, cap_effective,
>  			cap_bset, cap_ambient;
> +#ifdef CONFIG_USER_NS
> +	kernel_cap_t cap_userns;
> +#endif
> =20
>  	rcu_read_lock();
>  	cred =3D __task_cred(p);
> @@ -321,6 +324,9 @@ static inline void task_cap(struct seq_file *m, struc=
t task_struct *p)
>  	cap_effective	=3D cred->cap_effective;
>  	cap_bset	=3D cred->cap_bset;
>  	cap_ambient	=3D cred->cap_ambient;
> +#ifdef CONFIG_USER_NS
> +	cap_userns	=3D cred->cap_userns;
> +#endif
>  	rcu_read_unlock();
> =20
>  	render_cap_t(m, "CapInh:\t", &cap_inheritable);
> @@ -328,6 +334,9 @@ static inline void task_cap(struct seq_file *m, struc=
t task_struct *p)
>  	render_cap_t(m, "CapEff:\t", &cap_effective);
>  	render_cap_t(m, "CapBnd:\t", &cap_bset);
>  	render_cap_t(m, "CapAmb:\t", &cap_ambient);
> +#ifdef CONFIG_USER_NS
> +	render_cap_t(m, "CapUNs:\t", &cap_userns);
> +#endif
>  }
> =20
>  static inline void task_seccomp(struct seq_file *m, struct task_struct *=
p)
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 2976f534a7a3..adab0031443e 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -124,6 +124,9 @@ struct cred {
>  	kernel_cap_t	cap_effective;	/* caps we can actually use */
>  	kernel_cap_t	cap_bset;	/* capability bounding set */
>  	kernel_cap_t	cap_ambient;	/* Ambient capability set */
> +#ifdef CONFIG_USER_NS
> +	kernel_cap_t	cap_userns;	/* User namespace capability set */
> +#endif
>  #ifdef CONFIG_KEYS
>  	unsigned char	jit_keyring;	/* default keyring to attach requested
>  					 * keys to */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 370ed14b1ae0..e09475171f62 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -198,6 +198,13 @@ struct prctl_mm_map {
>  # define PR_CAP_AMBIENT_LOWER		3
>  # define PR_CAP_AMBIENT_CLEAR_ALL	4
> =20
> +/* Control the userns capability set */
> +#define PR_CAP_USERNS			48
> +# define PR_CAP_USERNS_IS_SET		1
> +# define PR_CAP_USERNS_RAISE		2
> +# define PR_CAP_USERNS_LOWER		3
> +# define PR_CAP_USERNS_CLEAR_ALL	4

Kernel coding style does not support this way but instead recommends
enum but apparently the whole header is not following that so I
guess it is fine ;-)

> +
>  /* arm64 Scalable Vector Extension controls */
>  /* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
>  #define PR_SVE_SET_VL			50	/* set task vector length */
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 075cfa7c896f..9912c6f3bc6b 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -56,6 +56,9 @@ struct cred init_cred =3D {
>  	.cap_permitted		=3D CAP_FULL_SET,
>  	.cap_effective		=3D CAP_FULL_SET,
>  	.cap_bset		=3D CAP_FULL_SET,
> +#ifdef CONFIG_USER_NS
> +	.cap_userns		=3D CAP_FULL_SET,
> +#endif
>  	.user			=3D INIT_USER,
>  	.user_ns		=3D &init_user_ns,
>  	.group_info		=3D &init_groups,
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 1b13c5d34624..51f1e1d25d49 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -32,6 +32,9 @@
> =20
>  #include <trace/events/module.h>
> =20
> +#ifdef CONFIG_USER_NS
> +static kernel_cap_t usermodehelper_userns =3D CAP_FULL_SET;
> +#endif
>  static kernel_cap_t usermodehelper_bset =3D CAP_FULL_SET;
>  static kernel_cap_t usermodehelper_inheritable =3D CAP_FULL_SET;
>  static DEFINE_SPINLOCK(umh_sysctl_lock);
> @@ -94,6 +97,10 @@ static int call_usermodehelper_exec_async(void *data)
>  	new->cap_bset =3D cap_intersect(usermodehelper_bset, new->cap_bset);
>  	new->cap_inheritable =3D cap_intersect(usermodehelper_inheritable,
>  					     new->cap_inheritable);
> +#ifdef CONFIG_USER_NS
> +	new->cap_userns =3D cap_intersect(usermodehelper_userns,
> +					new->cap_userns);

Could be also a single line (checkpatch.pl does not complain).

> +#endif
>  	spin_unlock(&umh_sysctl_lock);
> =20
>  	if (sub_info->init) {
> @@ -560,6 +567,15 @@ static struct ctl_table usermodehelper_table[] =3D {
>  		.mode		=3D 0600,
>  		.proc_handler	=3D proc_cap_handler,
>  	},
> +#ifdef CONFIG_USER_NS
> +	{
> +		.procname	=3D "userns",
> +		.data		=3D &usermodehelper_userns,
> +		.maxlen		=3D 2 * sizeof(unsigned long),
> +		.mode		=3D 0600,
> +		.proc_handler	=3D proc_cap_handler,
> +	},
> +#endif
>  	{ }
>  };
> =20
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 0b0b95418b16..7e624607330b 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -42,15 +42,13 @@ static void dec_user_namespaces(struct ucounts *ucoun=
ts)
> =20
>  static void set_cred_user_ns(struct cred *cred, struct user_namespace *u=
ser_ns)
>  {
> -	/* Start with the same capabilities as init but useless for doing
> -	 * anything as the capabilities are bound to the new user namespace.
> -	 */
> -	cred->securebits =3D SECUREBITS_DEFAULT;
> +	/* Start with the capabilities defined in the userns set. */
> +	cred->cap_bset =3D cred->cap_userns;
> +	cred->cap_permitted =3D cred->cap_userns;
> +	cred->cap_effective =3D cred->cap_userns;
>  	cred->cap_inheritable =3D CAP_EMPTY_SET;
> -	cred->cap_permitted =3D CAP_FULL_SET;
> -	cred->cap_effective =3D CAP_FULL_SET;
>  	cred->cap_ambient =3D CAP_EMPTY_SET;
> -	cred->cap_bset =3D CAP_FULL_SET;
> +	cred->securebits =3D SECUREBITS_DEFAULT;
>  #ifdef CONFIG_KEYS
>  	key_put(cred->request_key_auth);
>  	cred->request_key_auth =3D NULL;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..b3d3372bf910 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -228,6 +228,28 @@ static inline int cap_inh_is_capped(void)
>  	return 1;
>  }
> =20
> +/*
> + * Determine whether a userns capability can be raised.
> + * Returns 1 if it can, 0 otherwise.
> + */
> +#ifdef CONFIG_USER_NS
> +static inline int cap_uns_is_raiseable(unsigned long cap)
> +{
> +	if (!!cap_raised(current_cred()->cap_userns, cap))
> +		return 1;

Empty line.

> +	/* a capability cannot be raised unless the current task has it in

Incorrectly formatted comment:

/*
 * Foo

That is what's the correct format.

> +	 * its bounding set and, without CAP_SETPCAP, its permitted set.
> +	 */
> +	if (!cap_raised(current_cred()->cap_bset, cap))
> +		return 0;

Empty line might be appropriate here.

> +	if (cap_capable(current_cred(), current_cred()->user_ns,
> +			CAP_SETPCAP, CAP_OPT_NONE) !=3D 0 &&
> +	    !cap_raised(current_cred()->cap_permitted, cap))

I'd consider being dummy here to make this more easy to verify
also in the future: create two bools and use them for final
comparison.

My head hurts reading that.

> +		return 0;
> +	return 1;
> +}
> +#endif
> +
>  /**
>   * cap_capset - Validate and apply proposed changes to current's capabil=
ities
>   * @new: The proposed new credentials; alterations should be made here
> @@ -1382,6 +1404,43 @@ int cap_task_prctl(int option, unsigned long arg2,=
 unsigned long arg3,
>  			return commit_creds(new);
>  		}
> =20
> +#ifdef CONFIG_USER_NS
> +	case PR_CAP_USERNS:
> +		if (arg2 =3D=3D PR_CAP_USERNS_CLEAR_ALL) {
> +			if (arg3 | arg4 | arg5)
> +				return -EINVAL;
> +
> +			new =3D prepare_creds();
> +			if (!new)
> +				return -ENOMEM;
> +			cap_clear(new->cap_userns);
> +			return commit_creds(new);
> +		}
> +
> +		if (((!cap_valid(arg3)) | arg4 | arg5))
> +			return -EINVAL;
> +
> +		if (arg2 =3D=3D PR_CAP_USERNS_IS_SET) {
> +			return !!cap_raised(current_cred()->cap_userns, arg3);
> +		} else if (arg2 !=3D PR_CAP_USERNS_RAISE &&
> +			   arg2 !=3D PR_CAP_USERNS_LOWER) {
> +			return -EINVAL;
> +		} else {
> +			if (arg2 =3D=3D PR_CAP_USERNS_RAISE &&
> +			    !cap_uns_is_raiseable(arg3))
> +				return -EPERM;
> +
> +			new =3D prepare_creds();
> +			if (!new)
> +				return -ENOMEM;
> +			if (arg2 =3D=3D PR_CAP_USERNS_RAISE)
> +				cap_raise(new->cap_userns, arg3);
> +			else
> +				cap_lower(new->cap_userns, arg3);
> +			return commit_creds(new);
> +		}
> +#endif
> +
>  	default:
>  		/* No functionality available - continue with default */
>  		return -ENOSYS;
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index b5d5333ab330..e3670d815435 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -944,6 +944,9 @@ void key_change_session_keyring(struct callback_head =
*twork)
>  	new->cap_effective	=3D old->cap_effective;
>  	new->cap_ambient	=3D old->cap_ambient;
>  	new->cap_bset		=3D old->cap_bset;
> +#ifdef CONFIG_USER_NS
> +	new->cap_userns		=3D old->cap_userns;
> +#endif
> =20
>  	new->jit_keyring	=3D old->jit_keyring;
>  	new->thread_keyring	=3D key_get(old->thread_keyring);

BR, Jarkko

