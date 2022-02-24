Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5434C3579
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 20:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiBXTNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 14:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiBXTNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:13:42 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818F1A9078
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645729987; bh=OoF4JMI2ZoJPr6TPefJDmJPYE97esf6zSwrftcebKd0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=DyTMyQIlLmGt34dlzYd3pbwT4k9hq1DpTT+OXO+do6WU1IUEBO3krm7nW9NiUFUtds3gsx7C/SxE/Vxuz/vN65lHhj1FOZv/y6c4Ef9+3dZy6vEK5Y15moKqag1a1oEZj0S/5ZDvgaG1lCcP1I3DafSP7PKPiuz9/uDB0VaP7J1orCy0rPajnn0w/8oYWjSEVACBJ8wf2i70V2BPjy1ZK0W4D+9yndaUExAwo8C+aXKAtmfDVvNEWZ5IZv7e1DztaNLOmpHltj3/od6foJ2Ef7db56KDJ4ZspyUfiZmCnhGX6fPCwHkzT6dQgtwgB9Dj1gzI1tN06Povr5142pl7Hw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645729987; bh=tXvpoG4/bRkk7GHZT71rAvliypiGwvK1XqsKEC/X0On=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bhSmTg/eAI/zQGr9x0T9U8oNyylTy4nYH5xMfhLwrLCyztbXyenJhMuIxiFGPW+hzxWMeOTgTi04HJIY8liFqjoKdHPOKnjoo4eV5C3v5xqZ1XKB6UcwtLwhKMrv6H1qE3QBGOhqTjsctAIDYG4J7RxFIy+DuAAwyVkD78cgH57K3c49P/V8GHAjM1RGlNuVJJMVZj8rMn3R8LXX9IqdDz4+/sR9xLf26WrrFOK1Kg4hrYfoMQI/pWlfrI7AiKjdOvJ6a1gpsyvBsAs6Fi5Q053gdl8HJmXrj6sYSVOePfAc5iofXMnTaA6rTNiYjA24zMYiHyPSWewdUjCyICQZxQ==
X-YMail-OSG: Di.eRy4VM1nxdh6DhpoSLapmPcq4ZPWIVMKhU74JptgSERWfPP_AzbqbRzuEUlU
 pJMbJmE00tmNV6cZkl8FRQ0QflQjaUDnwuSoGzhWsMt3Rq6NRBdkbuAyqs5h0k6ceGmoghLJL.3k
 89vrGMBVY2VrMTmi9jPnsqTgcfIsgNO2qAdYxTAtdHktfO_fDVQYwOFsc1Mrq5WFJbqEFzqW3DU4
 26O.7q1RsSj_Hbrfr1okCVNQ_uq0ChMXPjhk2NwrMgOHXCO5Wit6HPQ3PcBOfS_3gO3a9sdc43bw
 kpcafHYRaKcVVcZvJgmNuJdXt7hlKDKNbTpzYuE3IhQLucPYlLo4Ww0zgMMs2HWuCkIdLymb3vXJ
 nmIRSlJMp1ZE0pZ35usTAR34g0K6rSMBx3Q5KlIpSzGIrXt9jXxpXEMDqzP1gJ7CMCYjsy2ewOvd
 V9ae9fCGnCG3fl1rLk471v4CvfP4LvYTXDpI5R03cG9R0QYPOJbN16A3QPnK.NocoYMkxzG7O2x5
 iILXbSKjhYjBtuaYkckKnNrPZPeviHmxCyoqlaYNcHJC5kKeBjnyNNN_lnpLJsWOaSUIJ4ysYRR7
 AaBQLj6EfgqPMEGomjFrDtnyHT5GEV1Q2vUJ0p0Lr9YIZSJCbTyWMOfxvyO5LT6.FrlOSK2C2QQP
 Qe4bFnbIIxWj4MvIxgfQZcOUaC6CoWK9ysYjnjBS8FoLyE.65C7laV4Poj9jx3j68Qv4thgaf2r3
 8.Ryk2YH9do3A2xj9VZXrEdjwiCcf10rKW94.td2._2iLo9MddhszPo4hujfXMpVeeVB6Ft87Y0p
 9BeBNrjBVj2aR9zEFUatwaT_bxlg1FRxGyFTG1A7gvMoMafV_H39YPRkTGgmi7C_l0sV6_abEYys
 u5gj55FOnxY4TJPFTALfXgArK8afRx34GbMMokyON7IgxvAdjT2fEqOs7hiO2HdG.Ex2g.TFFJi8
 SpKVXuYkSbKNOMoc.wPIAkVbVZbAhUo0hX5GL2b6Qy9dUOXdsL8mFNY9h74mz885xyWRU34LZ5db
 AW6x_fj.2DjCl2HZEngkDya2tZbLvwvk43I27v0Nb.Sn5Q54HwjGgt.lfzC8R9zQXugXvX4aLKpt
 KFmsBGMHisbtooiUICv4_VhRNmi0lnTicKl785DBMZNnQ194rNThjIzt9uqO2WAULwhWvdEc3R6m
 7UNIWP2RIaUqkp2jUn0pq3clGlq5GCAoh0eiku3TWGTvlB4vpoifYtC9s2P6Xkr3P.dzjvIJP_jv
 9Wsg2WO6jX1tcVjAL5EE4cO..yqSkIpxEWsAg109gYmuBWV3tlUuNNhxFP0kjVvtbhRdrLbfrzHR
 sMU3aNPu2Wxmk4OJ0pvNFDQbLXVapaCb6qOvDvAYGfI9hnc_gCmFW208LD9OJzwP0HRHzrHYzB7r
 SoyPSC1qWU_cEfMtzrMfhDcHKFxqGcwSmpQu673iivtI69PS7i5e._SPRBQmLSHXmq6Bv4Pj5RrC
 MkoTbLt0AYvzC2Y6hqnxU2QyjBusI2Ep5IqoCadncSuv_FEX_3T.GrVL1j36PruSOY.GrWS_qu1j
 vO9NldJ9DG1VWJVLrSJXMeu..eDVoODozN422bBPQyuNRWqd42CKqy45Q8weQO3gVVsy5I.bGcj0
 J0Pe2jb4v5iKBJl91YtKRkIoLdS8D7cKYxCo2b4kZ.Gtn4LnYjF9rZ7_TzUClgN6YjCaEmiy7QUX
 mVGzDvNxd1rfFBJigEXNkgcyPdghqa6EuvxpLgnw5UPdk2wmbXqhLjfpRbVvRTDtY8MiC_kUau7F
 VbZQRMqCpDVZ.FltI7fx4Gv8g7Q6kYEc0ZbvjTeNrZsBXBhoiVR9QZCA.Ylnb6RadoDUNlcvIoHo
 wNFOcddx1c9CnU42AeYVvVXoDXsMlB8XQDj9BECxsfCjL.fCnwSeb1og2b.6pzXHvouEeMJJzPka
 Vp.bd5LHj3ivxNdGv0Rj0No923Vd9ayWZ2W62MdK1CrEO4GptdZKw6Z4mgA1Sj7WTwJP6DxlAurW
 OL7cijz.frZwQWJZGn8rsCni42xR_ScheLiIdv2ifpR0s9IqjoAnkR71_YO1B187cl5ngBVXDDOU
 s_1YaUhX7d974d24JyTZvJINh2IQlYV0MmMtIIZ40_Hzt5LV5nrr5m0eilA7Tq4g1mGAy32xWxIo
 R.34GxSHe5nlyJ0kcePQMWdZkLDthuL_CWlSl9R5rGYhi.hQcR3pAvdzbDqctLCeGdOABojcWaeI
 paHu75mYVfcgvkSDe9J_YAvqlck6JW1NDgNqzR_3ZR7tZlizJxG476PokzwGMHQJQqO40lLpn2RK
 gr_0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Feb 2022 19:13:07 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cc56d1031199f3bb567281e072ff2100;
          Thu, 24 Feb 2022 19:13:04 +0000 (UTC)
Message-ID: <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com>
Date:   Thu, 24 Feb 2022 11:13:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
References: <20220224181953.1030665-1-axelrasmussen@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220224181953.1030665-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/24/2022 10:19 AM, Axel Rasmussen wrote:
> Historically, it has been shown that intercepting kernel faults with
> userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
> of time) can be exploited, or at least can make some kinds of exploits
> easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
> changed things so, in order for kernel faults to be handled by
> userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
> must be configured so that any unprivileged user can do it.
>
> In a typical implementation of a hypervisor with live migration (take
> QEMU/KVM as one such example), we do indeed need to be able to handle
> kernel faults. But, both options above are less than ideal:
>
> - Toggling the sysctl increases attack surface by allowing any
>    unprivileged user to do it.
>
> - Granting the live migration process CAP_SYS_PTRACE gives it this
>    ability, but *also* the ability to "observe and control the
>    execution of another process [...], and examine and change [its]
>    memory and registers" (from ptrace(2)). This isn't something we need
>    or want to be able to do, so granting this permission violates the
>    "principle of least privilege".
>
> This is all a long winded way to say: we want a more fine-grained way to
> grant access to userfaultfd, without granting other additional
> permissions at the same time.
>
> So, add CAP_USERFAULTFD, for this specific case.

TL;DR - No. We don't add new capabilities for a single use.

You have a program that is already using a reasonably restrictive
capability (compared to CAP_SYS_ADMIN, for example) and which I
assume you have implemented appropriately for the level of privilege
used. If you can demonstrate that this CAP_USERFAULTD has applicability
beyond your specific implementation (and the name would imply otherwise)
it could be worth considering, but as it is, no.

>
> Setup a helper which accepts either CAP_USERFAULTFD, or for backward
> compatibility reasons (existing userspaces may depend on the old way of
> doing things), CAP_SYS_PTRACE.
>
> One special case is UFFD_FEATURE_EVENT_FORK: this is left requiring only
> CAP_SYS_PTRACE, since it is specifically about manipulating the memory
> of another (child) process, it sems like a better fit the way it is. To
> my knowledge, this isn't a feature required by typical live migration
> implementations, so this doesn't obviate the above.
>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   fs/userfaultfd.c                    | 6 +++---
>   include/linux/capability.h          | 5 +++++
>   include/uapi/linux/capability.h     | 7 ++++++-
>   security/selinux/include/classmap.h | 4 ++--
>   4 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e26b10132d47..1ec0d9b49a70 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -411,7 +411,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>   	    ctx->flags & UFFD_USER_MODE_ONLY) {
>   		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
>   			"sysctl knob to 1 if kernel faults must be handled "
> -			"without obtaining CAP_SYS_PTRACE capability\n");
> +			"without obtaining CAP_USERFAULTFD capability\n");
>   		goto out;
>   	}
>   
> @@ -2068,10 +2068,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>   
>   	if (!sysctl_unprivileged_userfaultfd &&
>   	    (flags & UFFD_USER_MODE_ONLY) == 0 &&
> -	    !capable(CAP_SYS_PTRACE)) {
> +	    !userfaultfd_capable()) {
>   		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
>   			"sysctl knob to 1 if kernel faults must be handled "
> -			"without obtaining CAP_SYS_PTRACE capability\n");
> +			"without obtaining CAP_USERFAULTFD capability\n");
>   		return -EPERM;
>   	}
>   
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 65efb74c3585..f1e7b3506432 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -270,6 +270,11 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>   		ns_capable(ns, CAP_SYS_ADMIN);
>   }
>   
> +static inline bool userfaultfd_capable(void)
> +{
> +	return capable(CAP_USERFAULTFD) || capable(CAP_SYS_PTRACE);
> +}
> +
>   /* audit system wants to get cap info from files as well */
>   int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>   			   const struct dentry *dentry,
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> index 463d1ba2232a..83a5d8601508 100644
> --- a/include/uapi/linux/capability.h
> +++ b/include/uapi/linux/capability.h
> @@ -231,6 +231,7 @@ struct vfs_ns_cap_data {
>   #define CAP_SYS_CHROOT       18
>   
>   /* Allow ptrace() of any process */
> +/* Allow everything under CAP_USERFAULTFD for backward compatibility */
>   
>   #define CAP_SYS_PTRACE       19
>   
> @@ -417,7 +418,11 @@ struct vfs_ns_cap_data {
>   
>   #define CAP_CHECKPOINT_RESTORE	40
>   
> -#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
> +/* Allow intercepting kernel faults with userfaultfd */
> +
> +#define CAP_USERFAULTFD		41
> +
> +#define CAP_LAST_CAP         CAP_USERFAULTFD
>   
>   #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
>   
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 35aac62a662e..98e37b220159 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -28,9 +28,9 @@
>   
>   #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>   		"wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
> -		"checkpoint_restore"
> +		"checkpoint_restore", "userfaultfd"
>   
> -#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
> +#if CAP_LAST_CAP > CAP_USERFAULTFD
>   #error New capability defined, please update COMMON_CAP2_PERMS.
>   #endif
>   
