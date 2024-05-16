Return-Path: <linux-fsdevel+bounces-19627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E48C7E77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 00:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A6CB21BFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 22:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C1A1586C9;
	Thu, 16 May 2024 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PtGpGQ4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901315820E;
	Thu, 16 May 2024 22:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715897271; cv=none; b=BvATQagVw0/5ovTA+HimKxAZjDQfJ+eiooLXzVKt8qftu53rsVGnGwN5pyhMVsWYXM4USlvgDmGpM2nXr6Y2O56VnNPUV6Q/KC9063i1dWf67x7/dd91VhmxUlNERELAkgz1yNIhUepZ/rA6lLaDciFmwGHgaTewhseqJjJJLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715897271; c=relaxed/simple;
	bh=rwn3VXNnUAUXExe9tQREbYpt9MsgG0AznI9G3zr9Qp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aroVSQxM8uXafxQiprNzGQbvNBmMBVGDsnp4+d2LeQ2FDKQMVmBxfPRxIUdzWLLIhTNH/ubQIT1+O7ab/6ashh8ISsYc7wJ+krZpe6pQvZ/qIhWGyv6ZNmluCl7D/223Af1YQUIHAu4WdF3COaJ/BTXmNtp8ymNVRih2hm5aILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PtGpGQ4L; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.8.193.2] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B1A5A40EA5;
	Thu, 16 May 2024 22:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715897258;
	bh=7XWFvgYmYletX7pWps8EeVGPlp7USahXZgSdPAfq7R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=PtGpGQ4LhUCagW9voceOJ1TAJD/TdgomXBvupOZcdJxViZBZD/QkMtSdcyigtiUBr
	 YCQkyq1OZqG+8oWJnKyuRL+BisLWKzTCoqTNUxnoW6Yv+90utPSuq+m5qzkPIhyHkG
	 rx6UG9zik8se80o89K7RjJTyT7NzAyzuRoYEfiq8mcIOgHeVfow3HbfnDnV34s80h+
	 yeHyqSvLQcWurdVR2LO10GvjUyu0SJEG6fQJs4WcdTVtYVvi8tRwzdkSqcmdLr1R+Q
	 UtObW5fCNVXoz/uTv4J+hdJOn3KOHPdvgbGdq4kmwi1kH85DthNfwjDenm8XnTX7e+
	 89WA9/2i+qxAA==
Message-ID: <641a34bd-e702-4f02-968e-4f71e0957af1@canonical.com>
Date: Thu, 16 May 2024 15:07:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] capabilities: user namespace capabilities
To: Jonathan Calmels <jcalmels@3xx0.net>, brauner@kernel.org,
 ebiederm@xmission.com, Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>,
 Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: containers@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-2-jcalmels@3xx0.net>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 xsFNBE5mrPoBEADAk19PsgVgBKkImmR2isPQ6o7KJhTTKjJdwVbkWSnNn+o6Up5knKP1f49E
 BQlceWg1yp/NwbR8ad+eSEO/uma/K+PqWvBptKC9SWD97FG4uB4/caomLEU97sLQMtnvGWdx
 rxVRGM4anzWYMgzz5TZmIiVTZ43Ou5VpaS1Vz1ZSxP3h/xKNZr/TcW5WQai8u3PWVnbkjhSZ
 PHv1BghN69qxEPomrJBm1gmtx3ZiVmFXluwTmTgJOkpFol7nbJ0ilnYHrA7SX3CtR1upeUpM
 a/WIanVO96WdTjHHIa43fbhmQube4txS3FcQLOJVqQsx6lE9B7qAppm9hQ10qPWwdfPy/+0W
 6AWtNu5ASiGVCInWzl2HBqYd/Zll93zUq+NIoCn8sDAM9iH+wtaGDcJywIGIn+edKNtK72AM
 gChTg/j1ZoWH6ZeWPjuUfubVzZto1FMoGJ/SF4MmdQG1iQNtf4sFZbEgXuy9cGi2bomF0zvy
 BJSANpxlKNBDYKzN6Kz09HUAkjlFMNgomL/cjqgABtAx59L+dVIZfaF281pIcUZzwvh5+JoG
 eOW5uBSMbE7L38nszooykIJ5XrAchkJxNfz7k+FnQeKEkNzEd2LWc3QF4BQZYRT6PHHga3Rg
 ykW5+1wTMqJILdmtaPbXrF3FvnV0LRPcv4xKx7B3fGm7ygdoowARAQABzStKb2huIEpvaGFu
 c2VuIDxqb2huLmpvaGFuc2VuQGNhbm9uaWNhbC5jb20+wsF3BBMBCgAhBQJOjRdaAhsDBQsJ
 CAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEAUvNnAY1cPYi0wP/2PJtzzt0zi4AeTrI0w3Rj8E
 Waa1NZWw4GGo6ehviLfwGsM7YLWFAI8JB7gsuzX/im16i9C3wHYXKs9WPCDuNlMc0rvivqUI
 JXHHfK7UHtT0+jhVORyyVVvX+qZa7HxdZw3jK+ROqUv4bGnImf31ll99clzo6HpOY59soa8y
 66/lqtIgDckcUt/1ou9m0DWKwlSvulL1qmD25NQZSnvB9XRZPpPd4bea1RTa6nklXjznQvTm
 MdLq5aJ79j7J8k5uLKvE3/pmpbkaieEsGr+azNxXm8FPcENV7dG8Xpd0z06E+fX5jzXHnj69
 DXXc3yIvAXsYZrXhnIhUA1kPQjQeNG9raT9GohFPMrK48fmmSVwodU8QUyY7MxP4U6jE2O9L
 7v7AbYowNgSYc+vU8kFlJl4fMrX219qU8ymkXGL6zJgtqA3SYHskdDBjtytS44OHJyrrRhXP
 W1oTKC7di/bb8jUQIYe8ocbrBz3SjjcL96UcQJecSHu0qmUNykgL44KYzEoeFHjr5dxm+DDg
 OBvtxrzd5BHcIbz0u9ClbYssoQQEOPuFmGQtuSQ9FmbfDwljjhrDxW2DFZ2dIQwIvEsg42Hq
 5nv/8NhW1whowliR5tpm0Z0KnQiBRlvbj9V29kJhs7rYeT/dWjWdfAdQSzfoP+/VtPRFkWLr
 0uCwJw5zHiBgzsFNBE5mrPoBEACirDqSQGFbIzV++BqYBWN5nqcoR+dFZuQL3gvUSwku6ndZ
 vZfQAE04dKRtIPikC4La0oX8QYG3kI/tB1UpEZxDMB3pvZzUh3L1EvDrDiCL6ef93U+bWSRi
 GRKLnNZoiDSblFBST4SXzOR/m1wT/U3Rnk4rYmGPAW7ltfRrSXhwUZZVARyJUwMpG3EyMS2T
 dLEVqWbpl1DamnbzbZyWerjNn2Za7V3bBrGLP5vkhrjB4NhrufjVRFwERRskCCeJwmQm0JPD
 IjEhbYqdXI6uO+RDMgG9o/QV0/a+9mg8x2UIjM6UiQ8uDETQha55Nd4EmE2zTWlvxsuqZMgy
 W7gu8EQsD+96JqOPmzzLnjYf9oex8F/gxBSEfE78FlXuHTopJR8hpjs6ACAq4Y0HdSJohRLn
 5r2CcQ5AsPEpHL9rtDW/1L42/H7uPyIfeORAmHFPpkGFkZHHSCQfdP4XSc0Obk1olSxqzCAm
 uoVmRQZ3YyubWqcrBeIC3xIhwQ12rfdHQoopELzReDCPwmffS9ctIb407UYfRQxwDEzDL+m+
 TotTkkaNlHvcnlQtWEfgwtsOCAPeY9qIbz5+i1OslQ+qqGD2HJQQ+lgbuyq3vhefv34IRlyM
 sfPKXq8AUTZbSTGUu1C1RlQc7fpp8W/yoak7dmo++MFS5q1cXq29RALB/cfpcwARAQABwsFf
 BBgBCgAJBQJOZqz6AhsMAAoJEAUvNnAY1cPYP9cP/R10z/hqLVv5OXWPOcpqNfeQb4x4Rh4j
 h/jS9yjes4uudEYU5xvLJ9UXr0wp6mJ7g7CgjWNxNTQAN5ydtacM0emvRJzPEEyujduesuGy
 a+O6dNgi+ywFm0HhpUmO4sgs9SWeEWprt9tWrRlCNuJX+u3aMEQ12b2lslnoaOelghwBs8IJ
 r998vj9JBFJgdeiEaKJLjLmMFOYrmW197As7DTZ+R7Ef4gkWusYFcNKDqfZKDGef740Xfh9d
 yb2mJrDeYqwgKb7SF02Hhp8ZnohZXw8ba16ihUOnh1iKH77Ff9dLzMEJzU73DifOU/aArOWp
 JZuGJamJ9EkEVrha0B4lN1dh3fuP8EjhFZaGfLDtoA80aPffK0Yc1R/pGjb+O2Pi0XXL9AVe
 qMkb/AaOl21F9u1SOosciy98800mr/3nynvid0AKJ2VZIfOP46nboqlsWebA07SmyJSyeG8c
 XA87+8BuXdGxHn7RGj6G+zZwSZC6/2v9sOUJ+nOna3dwr6uHFSqKw7HwNl/PUGeRqgJEVu++
 +T7sv9+iY+e0Y+SolyJgTxMYeRnDWE6S77g6gzYYHmcQOWP7ZMX+MtD4SKlf0+Q8li/F9GUL
 p0rw8op9f0p1+YAhyAd+dXWNKf7zIfZ2ME+0qKpbQnr1oizLHuJX/Telo8KMmHter28DPJ03 lT9Q
Organization: Canonical
In-Reply-To: <20240516092213.6799-2-jcalmels@3xx0.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/24 02:22, Jonathan Calmels wrote:
> Attackers often rely on user namespaces to get elevated (yet confined)
> privileges in order to target specific subsystems (e.g. [1]). Distributions
> have been pretty adamant that they need a way to configure these, most of
> them carry out-of-tree patches to do so, or plainly refuse to enable them.
> As a result, there have been multiple efforts over the years to introduce
> various knobs to control and/or disable user namespaces (e.g. [2][3][4]).
> 
> While we acknowledge that there are already ways to control the creation of
> such namespaces (the most recent being a LSM hook), there are inherent
> issues with these approaches. Preventing the user namespace creation is not
> fine-grained enough, and in some cases, incompatible with various userspace

agreed, though it really is application dependent. Some applications handle
the denial at userns creation better, than the capability after. Others
like anything based on QTWebEngine will crash on denial of userns creation
but handle denial of the capability within the userns just fine, and some
applications just crash regardless.

The userns cred from the LSM hook can be modified, yes it is currently
specified as const but is still under construction so it can be safely
modified the LSM hook just needs a small update.

The advantage of doing it under the LSM is an LSM can have a richer policy
around what can use them and tracking of what is allowed. That is to say the
LSM has the capability of being finer grained than doing it via capabilities.

I am not opposed to adding another mechanism to control user namespaces,
I am just not currently convinced that capabilities are the right
mechanism.

> expectations (e.g. container runtimes, browser sandboxing, service
> isolation)
> 
> This patch addresses these limitations by introducing an additional
> capability set used to restrict the permissions granted when creating user
> namespaces. This way, processes can apply the principle of least privilege
> by configuring only the capabilities they need for their namespaces.
> 
> For compatibility reasons, processes always start with a full userns
> capability set.
> 
> On namespace creation, the userns capability set (pU) is assigned to the
> new effective (pE), permitted (pP) and bounding set (X) of the task:
> 
>      pU = pE = pP = X
> 

this should be bounded by the creating task's bounding set, other wise
the capability model's bounding invariant will be broken, but having the
capabilities that the userns want to access in the task's bounding set is
a problem for all the unprivileged processes wanting access to user
namespaces.

Simply setting the userns fcap on the programs that want access to user
namespaces, does certainly reduce the attack surface, but really is
insufficient for utilities like unshare, bwrap, lxd etc. They can be
used to trivially by-pass the restriction.

> The userns capability set obeys the invariant that no bit can ever be set
> if it is not already part of the task’s bounding set. This ensures that no
> namespace can ever gain more privileges than its predecessors.
> Additionally, if a task is not privileged over CAP_SETPCAP, setting any bit
> in the userns set requires its corresponding bit to be set in the permitted
> set. This effectively mimics the inheritable set rules and means that, by
> default, only root in the initial user namespace can gain userns
> capabilities:
> 
>      p’U = (pE & CAP_SETPCAP) ? X : (X & pP)
> 
If I am reading this right for unprivileged processes the capabilities in
the userns are bounded by the processes permitted set before the userns is
created?

This is only being respected in PR_CTL, the user mode helper is straight
setting the caps.



> Note that since userns capabilities are strictly hierarchical, policies can
> be enforced at various levels (e.g. init, pam_cap) and inherited by every
> child namespace.
> 
> Here is a sample program that can be used to verify the functionality:
> 
> /*
>   * Test program that drops CAP_SYS_RAWIO from subsequent user namespaces.
>   *
>   * ./cap_userns_test unshare -r grep Cap /proc/self/status
>   * CapInh: 0000000000000000
>   * CapPrm: 000001fffffdffff
>   * CapEff: 000001fffffdffff
>   * CapBnd: 000001fffffdffff
>   * CapAmb: 0000000000000000
>   * CapUNs: 000001fffffdffff
>   */
> 
> int main(int argc, char *argv[])
> {
>          if (prctl(PR_CAP_USERNS, PR_CAP_USERNS_LOWER, CAP_SYS_RAWIO, 0, 0) < 0)
>                  err(1, "cannot drop userns cap");
> 
>          execvp(argv[1], argv + 1);
>          err(1, "cannot exec");
> }
> 
> Link: https://security.googleblog.com/2023/06/learnings-from-kctf-vrps-42-linux.html
> Link: https://lore.kernel.org/lkml/1453502345-30416-1-git-send-email-keescook@chromium.org
> Link: https://lore.kernel.org/lkml/20220815162028.926858-1-fred@cloudflare.com
> Link: https://lore.kernel.org/containers/168547265011.24337.4306067683997517082-0@git.sr.ht
> 
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> ---
>   fs/proc/array.c              |  9 ++++++
>   include/linux/cred.h         |  3 ++
>   include/uapi/linux/prctl.h   |  7 +++++
>   kernel/cred.c                |  3 ++
>   kernel/umh.c                 | 16 ++++++++++
>   kernel/user_namespace.c      | 12 +++-----
>   security/commoncap.c         | 59 ++++++++++++++++++++++++++++++++++++
>   security/keys/process_keys.c |  3 ++
>   8 files changed, 105 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 34a47fb0c57f..364e8bb19f9d 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -313,6 +313,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
>   	const struct cred *cred;
>   	kernel_cap_t cap_inheritable, cap_permitted, cap_effective,
>   			cap_bset, cap_ambient;
> +#ifdef CONFIG_USER_NS
> +	kernel_cap_t cap_userns;
> +#endif
>   
>   	rcu_read_lock();
>   	cred = __task_cred(p);
> @@ -321,6 +324,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
>   	cap_effective	= cred->cap_effective;
>   	cap_bset	= cred->cap_bset;
>   	cap_ambient	= cred->cap_ambient;
> +#ifdef CONFIG_USER_NS
> +	cap_userns	= cred->cap_userns;
> +#endif
>   	rcu_read_unlock();
>   
>   	render_cap_t(m, "CapInh:\t", &cap_inheritable);
> @@ -328,6 +334,9 @@ static inline void task_cap(struct seq_file *m, struct task_struct *p)
>   	render_cap_t(m, "CapEff:\t", &cap_effective);
>   	render_cap_t(m, "CapBnd:\t", &cap_bset);
>   	render_cap_t(m, "CapAmb:\t", &cap_ambient);
> +#ifdef CONFIG_USER_NS
> +	render_cap_t(m, "CapUNs:\t", &cap_userns);
> +#endif
>   }
>   
>   static inline void task_seccomp(struct seq_file *m, struct task_struct *p)
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 2976f534a7a3..adab0031443e 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -124,6 +124,9 @@ struct cred {
>   	kernel_cap_t	cap_effective;	/* caps we can actually use */
>   	kernel_cap_t	cap_bset;	/* capability bounding set */
>   	kernel_cap_t	cap_ambient;	/* Ambient capability set */
> +#ifdef CONFIG_USER_NS
> +	kernel_cap_t	cap_userns;	/* User namespace capability set */
> +#endif
>   #ifdef CONFIG_KEYS
>   	unsigned char	jit_keyring;	/* default keyring to attach requested
>   					 * keys to */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 370ed14b1ae0..e09475171f62 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -198,6 +198,13 @@ struct prctl_mm_map {
>   # define PR_CAP_AMBIENT_LOWER		3
>   # define PR_CAP_AMBIENT_CLEAR_ALL	4
>   
> +/* Control the userns capability set */
> +#define PR_CAP_USERNS			48
> +# define PR_CAP_USERNS_IS_SET		1
> +# define PR_CAP_USERNS_RAISE		2
> +# define PR_CAP_USERNS_LOWER		3
> +# define PR_CAP_USERNS_CLEAR_ALL	4
> +
>   /* arm64 Scalable Vector Extension controls */
>   /* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
>   #define PR_SVE_SET_VL			50	/* set task vector length */
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 075cfa7c896f..9912c6f3bc6b 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -56,6 +56,9 @@ struct cred init_cred = {
>   	.cap_permitted		= CAP_FULL_SET,
>   	.cap_effective		= CAP_FULL_SET,
>   	.cap_bset		= CAP_FULL_SET,
> +#ifdef CONFIG_USER_NS
> +	.cap_userns		= CAP_FULL_SET,
> +#endif
>   	.user			= INIT_USER,
>   	.user_ns		= &init_user_ns,
>   	.group_info		= &init_groups,
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 1b13c5d34624..51f1e1d25d49 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -32,6 +32,9 @@
>   
>   #include <trace/events/module.h>
>   
> +#ifdef CONFIG_USER_NS
> +static kernel_cap_t usermodehelper_userns = CAP_FULL_SET;
> +#endif
>   static kernel_cap_t usermodehelper_bset = CAP_FULL_SET;
>   static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
>   static DEFINE_SPINLOCK(umh_sysctl_lock);
> @@ -94,6 +97,10 @@ static int call_usermodehelper_exec_async(void *data)
>   	new->cap_bset = cap_intersect(usermodehelper_bset, new->cap_bset);
>   	new->cap_inheritable = cap_intersect(usermodehelper_inheritable,
>   					     new->cap_inheritable);
> +#ifdef CONFIG_USER_NS
> +	new->cap_userns = cap_intersect(usermodehelper_userns,
> +					new->cap_userns);
> +#endif
>   	spin_unlock(&umh_sysctl_lock);
>   
>   	if (sub_info->init) {
> @@ -560,6 +567,15 @@ static struct ctl_table usermodehelper_table[] = {
>   		.mode		= 0600,
>   		.proc_handler	= proc_cap_handler,
>   	},
> +#ifdef CONFIG_USER_NS
> +	{
> +		.procname	= "userns",
> +		.data		= &usermodehelper_userns,
> +		.maxlen		= 2 * sizeof(unsigned long),
> +		.mode		= 0600,
> +		.proc_handler	= proc_cap_handler,
> +	},
> +#endif
>   	{ }
>   };
>   
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 0b0b95418b16..7e624607330b 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -42,15 +42,13 @@ static void dec_user_namespaces(struct ucounts *ucounts)
>   
>   static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>   {
> -	/* Start with the same capabilities as init but useless for doing
> -	 * anything as the capabilities are bound to the new user namespace.
> -	 */
> -	cred->securebits = SECUREBITS_DEFAULT;
> +	/* Start with the capabilities defined in the userns set. */
> +	cred->cap_bset = cred->cap_userns;
> +	cred->cap_permitted = cred->cap_userns;
> +	cred->cap_effective = cred->cap_userns;
>   	cred->cap_inheritable = CAP_EMPTY_SET;
> -	cred->cap_permitted = CAP_FULL_SET;
> -	cred->cap_effective = CAP_FULL_SET;
>   	cred->cap_ambient = CAP_EMPTY_SET;
> -	cred->cap_bset = CAP_FULL_SET;
> +	cred->securebits = SECUREBITS_DEFAULT;
>   #ifdef CONFIG_KEYS
>   	key_put(cred->request_key_auth);
>   	cred->request_key_auth = NULL;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 162d96b3a676..b3d3372bf910 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -228,6 +228,28 @@ static inline int cap_inh_is_capped(void)
>   	return 1;
>   }
>   
> +/*
> + * Determine whether a userns capability can be raised.
> + * Returns 1 if it can, 0 otherwise.
> + */
> +#ifdef CONFIG_USER_NS
> +static inline int cap_uns_is_raiseable(unsigned long cap)
> +{
> +	if (!!cap_raised(current_cred()->cap_userns, cap))
> +		return 1;
> +	/* a capability cannot be raised unless the current task has it in
> +	 * its bounding set and, without CAP_SETPCAP, its permitted set.
> +	 */
> +	if (!cap_raised(current_cred()->cap_bset, cap))
> +		return 0;
> +	if (cap_capable(current_cred(), current_cred()->user_ns,
> +			CAP_SETPCAP, CAP_OPT_NONE) != 0 &&
> +	    !cap_raised(current_cred()->cap_permitted, cap))
> +		return 0;
> +	return 1;
> +}
> +#endif
> +
>   /**
>    * cap_capset - Validate and apply proposed changes to current's capabilities
>    * @new: The proposed new credentials; alterations should be made here
> @@ -1382,6 +1404,43 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>   			return commit_creds(new);
>   		}
>   
> +#ifdef CONFIG_USER_NS
> +	case PR_CAP_USERNS:
> +		if (arg2 == PR_CAP_USERNS_CLEAR_ALL) {
> +			if (arg3 | arg4 | arg5)
> +				return -EINVAL;
> +
> +			new = prepare_creds();
> +			if (!new)
> +				return -ENOMEM;
> +			cap_clear(new->cap_userns);
> +			return commit_creds(new);
> +		}
> +
> +		if (((!cap_valid(arg3)) | arg4 | arg5))
> +			return -EINVAL;
> +
> +		if (arg2 == PR_CAP_USERNS_IS_SET) {
> +			return !!cap_raised(current_cred()->cap_userns, arg3);
> +		} else if (arg2 != PR_CAP_USERNS_RAISE &&
> +			   arg2 != PR_CAP_USERNS_LOWER) {
> +			return -EINVAL;
> +		} else {
> +			if (arg2 == PR_CAP_USERNS_RAISE &&
> +			    !cap_uns_is_raiseable(arg3))
> +				return -EPERM;
> +
> +			new = prepare_creds();
> +			if (!new)
> +				return -ENOMEM;
> +			if (arg2 == PR_CAP_USERNS_RAISE)
> +				cap_raise(new->cap_userns, arg3);
> +			else
> +				cap_lower(new->cap_userns, arg3);
> +			return commit_creds(new);
> +		}
> +#endif
> +
>   	default:
>   		/* No functionality available - continue with default */
>   		return -ENOSYS;
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index b5d5333ab330..e3670d815435 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -944,6 +944,9 @@ void key_change_session_keyring(struct callback_head *twork)
>   	new->cap_effective	= old->cap_effective;
>   	new->cap_ambient	= old->cap_ambient;
>   	new->cap_bset		= old->cap_bset;
> +#ifdef CONFIG_USER_NS
> +	new->cap_userns		= old->cap_userns;
> +#endif
>   
>   	new->jit_keyring	= old->jit_keyring;
>   	new->thread_keyring	= key_get(old->thread_keyring);


