Return-Path: <linux-fsdevel+bounces-5994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A81811CAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 19:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0A31F21A22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926924B54;
	Wed, 13 Dec 2023 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZWwZgfYX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10998B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 10:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702492538; bh=F3ILWaOaE11kj+zcXUvpO5EwRjGJ4Usw8j8ahHmYLUY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZWwZgfYXkQXbT09bjrTknAWAv/k3iM5fPucWDr/qy9GA9x072SlO9AgLHSABDrBYEJ3XZApfg1aUxQ4lJfz5mNh/gNhlIKjLSztXjVZ34Ze5Qbv1duijPs96ps3fpcBMfBdF73GN5HgApFSrPGelpCUvYTDCm+eroD41srtF5ggH19q1ydidWWfn9J/kWcQpqYuXxRxkX+bvSnIwzM4ZpOxHRo16z3dO40phkcU5pSvr3TtEpJ0x7vRyMs813ADfkGRZZSvAWn/l+hwTnDSi5Bva9dpF+FL+A6F//G1sIglp5DN3YC3uJIWJ+1gnVHNoAg90Pep5WkPWr6q5+TOv0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702492538; bh=xg0ZjtPFZLPYvyzFgM5qVRSflwUEjxT6NS85SeeSLeL=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NjtkJiddK7tyPBbrQ90uhs0BcDcUIgo1UygXJubUub1KXWiz78cCFUh8IlW7AM8Axjc2cj9b5Fr2UagulgGnUM5TqGfYFcw/ALioL//6kmT2gnxfpqjpSO0eiZMf1VKrCfqB64OZo7tea5Se37rnODLSUJP+zcmL5L3YtXFqEIgqJAVRQfQrQ9AosK/XXsEGJ2DjifFUHIa8mkDq/X7C8jPZjZYaBB7PV4louDrKk7okZnI570WbsceZS0VypFgQLwM11plxU8rCjfiedifUz8bcQbuQiodOBDWzw2CIaQL6esYRLxoc+RwUgoIXGurxHfmncpLa/Lqe3zue53Rang==
X-YMail-OSG: 0r7oZOMVM1mSnzVHyXN8KIPqZIWnhysu5pcAtwcdDMquDNlK3GDwerbatD01YMU
 FQz_7VQQkw7Fdfg6XzIGuwcR5rj0Gj4AG5aJj0WSQ8xPmOnX12Xn_yLD3RiR.Sxkd3_UFDptgccb
 IhtbmFr0sygB2UW9BClSqTLZVgmMml_G2pmAIQmwQZeepexLcwiksTE6yJQ2DnwOiKYsG758Xtlc
 kLsPQr8RI5jUu1n32RQQXYB1M3BdUWKk.KwaDz.I_TTGXCMYjvu9C585hCNwX4M5vL778OpCuufB
 KNawAgCSSB7skbil1dO.94mV9cGZPaqLH3PctDBFolW4FRkmfSvgNpvYXQHHb3JYlcyPnr7YGn1i
 c1isqZ8ZqgEvEChlyWrv.O51ZqGL5Ur9Ot9r_oKwrGPuG7I4voZNtAg_zCEPl0rhPFK7WgZR0Yfc
 44XaiTKM8181UydLuIWhOCtKw3xk71GuIaW._1ts0VrvPymX4VIuAtuUK83rK2FkEKF_w7Szf_VK
 gBVSks.icaMy5uqUk2jWuoqGxkvX_MHZtTJRjujPz6oGHxgQiMpWZLoWDdiDKT0cwpKL2.WrKeDx
 e5at0giascb6dnCC91vK5dYF7aLN9110PclMzy2ybBiu7x19ST8Zu88f_JhqvfR_iRXr_s740Q9k
 LUse0gB7FlF8r3riHUt0s0aXINsl3nKMLAYKzDeHOXApZ2ZkuZwwB.pTJoiSKmMMEH1QPMX3kzeH
 JPjDtbehhSu._9YSWlcPKgTlwbGA3I.4shL5ZoN2IAbh261TRFl6gs0e4rfT4203i5YU8JMsiv1I
 tqcaOiS._Qe9r70EB04Eqa.EC61zFNOgz_OyhjQnBDrVgHGJF5KVgx43g90jYmKTlOuMNJJPLCzm
 Z9jNzK5fOhf6N8xY5DZg3WLPqVP.qmv_H6DIkf0TLTnVFd2F3gpchJkJQ9wfOBAzr_Y4.U35P84b
 w3KVDN5KFnCS_hLxUzekc1Fdg8IWfwCtdcMHBw_wTepcJ1RM0.ddc9QUFFP3Bhn0qQ7anS9XQZfE
 T564JdTbfg8iZPmpv81k9ofQt29tbrIOJ3LqLzcH7HbYQc9Q1ABswM_y_uFozI8DsKRPjkJNIRkw
 KZgCwy13KwAmwJt1xbJTCNsUieIZxdeEmkGrmPhKqjvU7WVfKatpW21AK0PfcF_asdGCYLzXXPAG
 vO9i20qVsE584voPV1NLnCuaeeE4RSGJ9IPQvlnwCcjXAb8jRlnFfhDZ8Hi5WVYqGlCt9EvsFq.j
 tEXY4GOEaumeLGVPVtJ9jIMYUQLyk1vNDZTPN4CyJJR6mxJW7c72o2x71qSWeDWc5nQveELTsjwL
 6dg9gk1iWCwh1ZGwQs4ugI.Egnj_Hnqd7qbojHOaQlhrCh7eWxQLit49cGN999ayKD9GWnOiySIN
 .jA99IeegktY5zvne4D0W1qLfhdKvZ1ftwYL9_rs_2f9pVr4aEq3KNPSv.IoHT.4BBHk1p9tDM5k
 09l9vQLSoTY7cF611YPUmS5fvKYVoxSkdiRDw.887_eVO.rUu5RKEZeTcgh5FH8XRxv_pZjSuKav
 0ZkDh3fPQYu7IHf_ObRRBJ3POuGwIXJeIgSfG_0nl_lixqz.rmqKWNhbGXldkk9xPBI1av9q53ct
 Do5FUD9N2PSYklV3dVM94PKS7n7FgeckvoAgTGBF4vc08fEVqkezv0roAmdCNWgah2oIr0IRgtAb
 AKmW3FECgrP9fnlaTn9bG3HwOFxlqCtYpePCz1i.63RG_cvDgAhP32DTMXBtG4NHeKgXAznw7oOq
 AjsIgaDJpGd22yDf742PsiOQIQQaQdfiYSb.YJKiUMLrmowiZxmyQSbBAPX.u1p15MI9TaSLBXCs
 JBSQ6Ku8JQgM5zEA4wQAwB2A_8VyDtw2X4ewFAPFESi2_sHt.rXIfDG8_lx3oPsVuOrvphq7JmCj
 UQubrD89QTXxyXv79t0HnnS7P7Bl_JeYKzgcT1iSdz43kqJmzNioULUOXjnJZMLB88_ZMxP1A975
 m0Kx649e.dq5al7AzI1whA9AD6z_8FTl2bNiJMLN_tZeOj_toAWlKtHIFFgX9lkFDAgdVrPL1rK1
 eN4FA4pU48r7ohh2_J6g3VbFbH1A451jMcivQ_IZM9En8bdupipXGImX2MbdSrYZT815iwlXILdv
 v6SA64kRIFbzja_WRRh3V7Lgtgrw2FqjQqPURretjaAx0BDE.TDDV_Y5by5JtWYJa35l9a4rgrIs
 YyJfH7jjB2wuMN8KYs4WGjUv.GI0CmtWI_MwzeMjot.VhfCtqikivJRCzSfsJYU5SOw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5bf1e823-cd45-4553-87a4-d657d3be01a9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Dec 2023 18:35:38 +0000
Received: by hermes--production-gq1-6949d6d8f9-hnk4w (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 566ac33d3e608f8110bfa5f0010a199d;
          Wed, 13 Dec 2023 18:35:32 +0000 (UTC)
Message-ID: <6df822d8-8413-413e-8ecd-cac1cfae4a3b@schaufler-ca.com>
Date: Wed, 13 Dec 2023 10:35:31 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Content-Language: en-US
To: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Quentin Monnet <quentin@isovalent.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, gyroidos@aisec.fraunhofer.de,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21952 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/13/2023 6:38 AM, Michael Weiß wrote:
> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> namespace in cooperation of an attached cgroup device program. We
> just need to implement the security_inode_mknod() hook for this.
> In the hook, we check if the current task is guarded by a device
> cgroup using the lately introduced cgroup_bpf_current_enabled()
> helper. If so, we strip out SB_I_NODEV from the super block.
>
> Access decisions to those device nodes are then guarded by existing
> device cgroups mechanism.
>
> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> ---
>  security/Kconfig             | 11 +++++----
>  security/Makefile            |  1 +
>  security/devguard/Kconfig    | 12 ++++++++++
>  security/devguard/Makefile   |  2 ++
>  security/devguard/devguard.c | 44 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 65 insertions(+), 5 deletions(-)
>  create mode 100644 security/devguard/Kconfig
>  create mode 100644 security/devguard/Makefile
>  create mode 100644 security/devguard/devguard.c
>
> diff --git a/security/Kconfig b/security/Kconfig
> index 52c9af08ad35..7ec4017745d4 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -194,6 +194,7 @@ source "security/yama/Kconfig"
>  source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
> +source "security/devguard/Kconfig"
>  
>  source "security/integrity/Kconfig"
>  
> @@ -233,11 +234,11 @@ endchoice
>  
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> -	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
> +	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf,devguard" if DEFAULT_SECURITY_SMACK
> +	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf,devguard" if DEFAULT_SECURITY_APPARMOR
> +	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf,devguard" if DEFAULT_SECURITY_TOMOYO
> +	default "landlock,lockdown,yama,loadpin,safesetid,bpf,devguard" if DEFAULT_SECURITY_DAC
> +	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf,devguard"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list, except for those with order
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8f85cd..82a0d8cab3c3 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
>  obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)			+= bpf/
>  obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
> +obj-$(CONFIG_SECURITY_DEVGUARD)		+= devguard/
>  
>  # Object integrity file lists
>  obj-$(CONFIG_INTEGRITY)			+= integrity/
> diff --git a/security/devguard/Kconfig b/security/devguard/Kconfig
> new file mode 100644
> index 000000000000..592684615a8f
> --- /dev/null
> +++ b/security/devguard/Kconfig
> @@ -0,0 +1,12 @@
> +config SECURITY_DEVGUARD
> +	bool "Devguard for device node creation"
> +	depends on SECURITY
> +	depends on CGROUP_BPF
> +	default n
> +	help
> +	  This enables devguard, an LSM that allows to guard device node
> +	  creation in non-initial user namespace. It may allow mknod
> +	  in cooperation of an attached cgroup device program.
> +	  This security module stacks with other LSMs.
> +
> +	  If you are unsure how to answer this question, answer N.
> diff --git a/security/devguard/Makefile b/security/devguard/Makefile
> new file mode 100644
> index 000000000000..fdaff8dc2fea
> --- /dev/null
> +++ b/security/devguard/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SECURITY_DEVGUARD) += devguard.o
> diff --git a/security/devguard/devguard.c b/security/devguard/devguard.c
> new file mode 100644
> index 000000000000..3a0c9c27a691
> --- /dev/null
> +++ b/security/devguard/devguard.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device guard security module
> + *
> + * Simple in-kernel LSM to allow cap_mknod in non-initial
> + * user namespace if current task is guarded by device cgroup.
> + *
> + * Copyright (C) 2023 Fraunhofer AISEC. All rights reserved.
> + *
> + * Authors: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
> + */
> +
> +#include <linux/bpf-cgroup.h>
> +#include <linux/lsm_hooks.h>
> +
> +static int devguard_inode_mknod(struct inode *dir, struct dentry *dentry,
> +				umode_t mode, dev_t dev)
> +{
> +	if (dentry->d_sb->s_iflags & ~SB_I_NODEV)
> +		return 0;
> +
> +	// strip SB_I_NODEV on super block if device cgroup is active

Please use block style comments. We don't use // comments here.

	/*
	 * Strip SB_I_NODEV on super block if device cgroup is active
	 */

> +	if (cgroup_bpf_current_enabled(CGROUP_DEVICE))
> +		dentry->d_sb->s_iflags &= ~SB_I_NODEV;
> +
> +	return 0;
> +}
> +
> +static struct security_hook_list devguard_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_mknod, devguard_inode_mknod),
> +};
> +
> +static int __init devguard_init(void)
> +{
> +	security_add_hooks(devguard_hooks, ARRAY_SIZE(devguard_hooks),
> +			   "devguard");
> +	pr_info("devguard: initialized\n");
> +	return 0;
> +}
> +
> +DEFINE_LSM(devguard) = {
> +	.name = "devguard",
> +	.init = devguard_init,
> +};

