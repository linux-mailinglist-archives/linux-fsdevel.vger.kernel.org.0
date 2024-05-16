Return-Path: <linux-fsdevel+bounces-19581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69B8C76C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 14:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129E91F21E34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 12:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6705146584;
	Thu, 16 May 2024 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlcHoaQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AA3145FE8;
	Thu, 16 May 2024 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863492; cv=none; b=He0sVezODFYZhkR53Wq914787H81KTWR/FsXyieJjcyVagXHliSn6tGNes9DnU01cTQnhM+ABwLKYiDWGuS+uL5mXF0ime3blxt9gLEDv04ks3X8w+a0U8+HKS0ergz6kp6VQ73Ohmry7G9wjDQPldRwZ9KjYk9wM2S/o+8ckxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863492; c=relaxed/simple;
	bh=HNOtQUG9MUiVrbS1Rj3PWqKRiSI6WizkIia5pGml0tM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RFyTvLiOFOmrJ0LZwYoDyBcLZI1Wd7kmHxF397VEVt3vO6+naumLDlOS75TjvhdkP+451Pb+mkoKKL4tluSg3BUQhiOZeVNgK9Ug4Z49AABQy9NMZQq0YX3KaqZ8e1SPGsrEoujxtWuMssWY2+QDGoaigDZh9JOgVPK+kIdMpwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlcHoaQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A0BC113CC;
	Thu, 16 May 2024 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715863491;
	bh=HNOtQUG9MUiVrbS1Rj3PWqKRiSI6WizkIia5pGml0tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlcHoaQUzF1XSoHvAzPPMhNekinp3krzfJQF1pCbS8yC9EscVaJ6Ptn/35p05Be4Z
	 wIFUAak38MWHjTIREBMNa+yje67qXlt2U2JQPWKuXsilqnw5953dbcw9AD/BUoBX4Y
	 WPI4x9rKt6otw9zrvoYmfhhZR+6LiBxcGwmfgBnm89NGjuCGjgo/QESzrLAWFkOG0m
	 0THqK/z36jaQ1s2NeOI/s1w3QV5+0pp15vIXYhzbbAXDovyTLBXB+9wKOSVCi1TFt6
	 GWm0Dardjn3SRkEyepZl9OepphGvVgl+kJM6qDRIKkcncU+kWoxXt/uBQ3YdQC2kOC
	 OEdpQmFnQwn/Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 15:44:46 +0300
Message-Id: <D1B2UBTP0QTI.2LJ7B6NUNHNOJ@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jonathan Calmels" <jcalmels@3xx0.net>, <brauner@kernel.org>,
 <ebiederm@xmission.com>, "Luis Chamberlain" <mcgrof@kernel.org>, "Kees
 Cook" <keescook@chromium.org>, "Joel Granados" <j.granados@samsung.com>,
 "Serge Hallyn" <serge@hallyn.com>, "Paul Moore" <paul@paul-moore.com>,
 "James Morris" <jmorris@namei.org>, "David Howells" <dhowells@redhat.com>
Cc: <containers@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <keyrings@vger.kernel.org>
Subject: Re: [PATCH 3/3] capabilities: add cap userns sysctl mask
X-Mailer: aerc 0.17.0
References: <20240516092213.6799-1-jcalmels@3xx0.net>
 <20240516092213.6799-4-jcalmels@3xx0.net>
In-Reply-To: <20240516092213.6799-4-jcalmels@3xx0.net>

On Thu May 16, 2024 at 12:22 PM EEST, Jonathan Calmels wrote:
> This patch adds a new system-wide userns capability mask designed to mask
> off capabilities in user namespaces.
>
> This mask is controlled through a sysctl and can be set early in the boot
> process or on the kernel command line to exclude known capabilities from
> ever being gained in namespaces. Once set, it can be further restricted t=
o
> exert dynamic policies on the system (e.g. ward off a potential exploit).
>
> Changing this mask requires privileges over CAP_SYS_ADMIN and CAP_SETPCAP
> in the initial user namespace.
>
> Example:
>
>     # sysctl -qw kernel.cap_userns_mask=3D0x1fffffdffff && \
>       unshare -r grep Cap /proc/self/status
>     CapInh: 0000000000000000
>     CapPrm: 000001fffffdffff
>     CapEff: 000001fffffdffff
>     CapBnd: 000001fffffdffff
>     CapAmb: 0000000000000000
>     CapUNs: 000001fffffdffff
>
> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> ---
>  include/linux/user_namespace.h |  7 ++++
>  kernel/sysctl.c                | 10 ++++++
>  kernel/user_namespace.c        | 66 ++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespac=
e.h
> index 6030a8235617..e3478bd54ee5 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_USER_NAMESPACE_H
>  #define _LINUX_USER_NAMESPACE_H
> =20
> +#include <linux/capability.h>
>  #include <linux/kref.h>
>  #include <linux/nsproxy.h>
>  #include <linux/ns_common.h>
> @@ -14,6 +15,12 @@
>  #define UID_GID_MAP_MAX_BASE_EXTENTS 5
>  #define UID_GID_MAP_MAX_EXTENTS 340
> =20
> +#ifdef CONFIG_SYSCTL
> +extern kernel_cap_t cap_userns_mask;
> +int proc_cap_userns_handler(struct ctl_table *table, int write,
> +			    void *buffer, size_t *lenp, loff_t *ppos);
> +#endif
> +
>  struct uid_gid_extent {
>  	u32 first;
>  	u32 lower_first;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 81cc974913bb..1546eebd6aea 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -62,6 +62,7 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/mount.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/user_namespace.h>
>  #include <linux/pid.h>
> =20
>  #include "../lib/kstrtox.h"
> @@ -1846,6 +1847,15 @@ static struct ctl_table kern_table[] =3D {
>  		.mode		=3D 0444,
>  		.proc_handler	=3D proc_dointvec,
>  	},
> +#ifdef CONFIG_USER_NS
> +	{
> +		.procname	=3D "cap_userns_mask",
> +		.data		=3D &cap_userns_mask,
> +		.maxlen		=3D sizeof(kernel_cap_t),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_cap_userns_handler,
> +	},
> +#endif
>  #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
>  	{
>  		.procname       =3D "unknown_nmi_panic",
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 53848e2b68cd..e0cf606e9140 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -26,6 +26,66 @@
>  static struct kmem_cache *user_ns_cachep __ro_after_init;
>  static DEFINE_MUTEX(userns_state_mutex);
> =20
> +#ifdef CONFIG_SYSCTL
> +static DEFINE_SPINLOCK(cap_userns_lock);

Generally new global or file-local locks are better to have a comment
that describes their use.

> +kernel_cap_t cap_userns_mask =3D CAP_FULL_SET;
> +

Non-static symbol should have appropriate kdoc with alll arguments
and return values documented.

> +int proc_cap_userns_handler(struct ctl_table *table, int write,
> +			    void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct ctl_table t;
> +	unsigned long mask_array[2];
> +	kernel_cap_t new_mask, *mask;
> +	int err;
> +
> +	if (write && (!capable(CAP_SETPCAP) ||
> +		      !capable(CAP_SYS_ADMIN)))
> +		return -EPERM;
> +
> +	/*
> +	 * convert from the global kernel_cap_t to the ulong array to print to
> +	 * userspace if this is a read.
> +	 *
> +	 * capabilities are exposed as one 64-bit value or two 32-bit values
> +	 * depending on the architecture
> +	 */
> +	mask =3D table->data;
> +	spin_lock(&cap_userns_lock);
> +	mask_array[0] =3D (unsigned long) mask->val;
> +#if BITS_PER_LONG !=3D 64
> +	mask_array[1] =3D mask->val >> BITS_PER_LONG;
> +#endif

Why not just "if (BITS_PER_LONG !=3D 64)"?

Compiler will do its job here.

> +	spin_unlock(&cap_userns_lock);
> +
> +	t =3D *table;
> +	t.data =3D &mask_array;
> +
> +	/*
> +	 * actually read or write and array of ulongs from userspace.  Remember
> +	 * these are least significant bits first
> +	 */
> +	err =3D proc_doulongvec_minmax(&t, write, buffer, lenp, ppos);
> +	if (err < 0)
> +		return err;
> +
> +	new_mask.val =3D mask_array[0];
> +#if BITS_PER_LONG !=3D 64
> +	new_mask.val +=3D (u64)mask_array[1] << BITS_PER_LONG;
> +#endif

Ditto.

> +
> +	/*
> +	 * Drop everything not in the new_mask (but don't add things)
> +	 */
> +	if (write) {
> +		spin_lock(&cap_userns_lock);
> +		*mask =3D cap_intersect(*mask, new_mask);
> +		spin_unlock(&cap_userns_lock);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  static bool new_idmap_permitted(const struct file *file,
>  				struct user_namespace *ns, int cap_setid,
>  				struct uid_gid_map *map);
> @@ -46,6 +106,12 @@ static void set_cred_user_ns(struct cred *cred, struc=
t user_namespace *user_ns)
>  	/* Limit userns capabilities to our parent's bounding set. */
>  	if (iscredsecure(cred, SECURE_USERNS_STRICT_CAPS))
>  		cred->cap_userns =3D cap_intersect(cred->cap_userns, cred->cap_bset);
> +#ifdef CONFIG_SYSCTL
> +	/* Mask off userns capabilities that are not permitted by the system-wi=
de mask. */
> +	spin_lock(&cap_userns_lock);
> +	cred->cap_userns =3D cap_intersect(cred->cap_userns, cap_userns_mask);
> +	spin_unlock(&cap_userns_lock);
> +#endif
> =20
>  	/* Start with the capabilities defined in the userns set. */
>  	cred->cap_bset =3D cred->cap_userns;

BR, Jarkko

