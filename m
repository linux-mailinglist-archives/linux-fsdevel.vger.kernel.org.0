Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D404C3572
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 20:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiBXTN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 14:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiBXTN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:13:28 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0A17B0F9
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 11:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645729972; bh=OoF4JMI2ZoJPr6TPefJDmJPYE97esf6zSwrftcebKd0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZjGOa9ZQGBpW8QxDxHfCD0EgPRzKE1IThfLbDTR18mB6c912Hw6Q3GvMbILNTFslhnV9kbuVtMRlxM5ejWFiqUbqE8bMjjdgP3KABp6DCulfjrrhUhjQ42muVJCw+4bhqkCnlPwZWF6bGSOdbe1C7KqKgza0ph20tZLINfAtsNpyIABxSNZj2/JBqrCsR3FEvYrZ/dYw4A8A8eQ/pMfIYuiY+E2hbRAh8UjelSCr+w3gBVtcdvvleISvPZtSoKOtdxjaLZ4Bxg0CcoLtEhsz1DOsZRaZHGsYfQg4LnGeiki0Mm7wWVmtm8OrCQFhOnVE40QZkAQv9FlmpEdyJArbEQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645729972; bh=P6msowb+wkGm91V3GczcRyb7ojdXVUOK6EBPAwHaOn/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rQ7hIL90NcAzV9ADtgz7R5aY1b0lI4vK4FIYbOXrK9Wxz70vkLxpunbcZ4LlT0K/Nc8xQKZSdzOvwWbUHe2UYE8Vtw95B2aoD3nwTgjFVZROLtOXXXsQBtsPkEefva+WsL+kt+3TIZ024h+cCfpzsRnUmlVJQZBXC4TPezz70sYw+B+NO+deVju0747RGzRKM4qymb2viiTi4Yx/oUfGaFtYPy4cfb69VVVW4qJ3qJHfLF5pDvS0iLPjJ2iJBaCDSX2OSOxMD0os4izconAH0owTRhiVxbWTp3lXZdI4lp6xjcebggrHrh6UTNLHca11BsLmVLbDvfnAXKwt+9dcLw==
X-YMail-OSG: 0KWVBxAVM1l9VS9v.2W5xVM4Q2.4n.93hLGpHUm8OvQl0Djx0ZekfffAuWzaA9g
 JX94tkm5u0VosLmqbC6dCcYImPOCg4usTwGBhpvbrg5HEWD_esxiaDzooqta0guK8za7QxHfPlOJ
 cqEl1_2_miCER2uPGdKvz51QO6XcMgtD5mLbVZCjy1BoQaxqxYmXEMLXSjWPBwm2fdirMC7uG4m.
 n.f1uTYD6JgWQ1ZpSyokbIs8tuQJG3m631VCCz8fPMayvva8hEeqfa2nfILnskgHNTM.hpDiWa_G
 s9PYklePeudmbozguNwuo.DlHUzWYTYK4sXmtPD.AKsvlTDa3BPqh82ej2RFgdWFpyIBk2zYNCYm
 tNZz_MXTuegvE617p2HbgID.S567MFwdUDWcAIuiWYs2inOPx5FwokU2FQz3C8B74exd10GW7UNl
 SjoSmtX588YfpqOM5D8uPjHuIpxnbjpKQ.I3qOGcjxfqaC0VDTueM80fGYQiVaRzUcYvXx8rpT7Q
 tixBem1g9pIfhLcKst8uBLTH.nwOFR0YmhscoA.hYQnOJv3pFBlt.oR9y0K2JmPUmenkuyn0XmEc
 Zz8ilbrO6Qf4R.GevxSBoaXDGy6XGg_qUjIrrbkCbmdUHB4cSvjjIwD0YC8QY2YD6q_NPVC5foqI
 yyJ65hKzvCvPr4SGiBp5CxsYxo00QRKEEf79j6_gOyADBID6pa_.FfANkwn8xN01M4gnIVXUDx5k
 NytLa2HrDi17._ZwBKhw4eeXNr4JereHmPDNM9DgBy6qKfk9TXMqinSHqhx4V_lN74yKr_OzAONG
 2ZWPV9LApdwKy5FwcO0gly9hfxuMkSQ8U5m21rn1wv8twHMGeoO4oqn4qxBR7fgZI2nbW8bXMalu
 1ckjDgS2dK6LnSyWEQPkLxG3t64M_UOLUhidhZjQBBlc8uI36Yvlke1CUfPY8M3ak3qXBP4TscBE
 TKiaNmny_YPPhSKRy6oNsG7nt1dlZuguf3geQ5_wQ7ysO9EVtdxzr4CjGWnzfyQnvPky3eVQZLS5
 j01WkDL3fCCVdfmQ0cxbBcDzwZrh3N2VwdwJrBwU6JIx7ccpKkBYWODWZddZ9vAmowKAcqas3Nce
 6qlIl8KCr0gxcmwt74GJl8xqNOdKTGw1ZZWN2sTxi7neUsLyck7I0SlXKnY1c43sz1XB0NnYYmfj
 Mubqrb51Xmb0miiVg8gre1RpH6hwkqYyMALfzZwK_T61av_xWQTHF.XliyHtSlKPXPM01SkSvSIW
 2IvW23W5mrkJKQP70MkRRgbGSl15CW8FrJz._wPY0_WZNngFYLgK7J2PivY_8MkWM6XlpVwNHn.o
 2WjEWHyAZXRHazAK7uXugXGk1.5VJPk4BsTEvFTrYglEOnCrCeKsXFJeOj5hJpZrO5zys7Pg.qUi
 bW09ayM4mT5o.1SFs2m5KWDnu3R_LzzZaxRf4AyS0rG2_iRharCVvYQ.Hq6DBl.St4hM.7iJXesW
 U9x66oG_7TX2TnUESPCCoe.1Y99aZvdT41f8srh3_e0JuvGUQVdzDlQyAD6SbfnmZ1mdjaNUToxc
 pa5QbjtjBMxF63_BfqLE_oqfZqCjqNlp__vSchI8dmaqxLR4YQK2DGu.TyY_vHIfVMT0V9vVsFj4
 ecba9Ko2AE4r3xbSyni09ZuQA1YHRIrUAoOON7fCu8U5qE33q1t2RPHdsKD1NZa8gBjQKt_fGQUX
 6XycIp.xIhtcxQvth.nzAbjdblAmCMM6.gt93knTqd1JBSUhRxVS0zeRGLD3cle2FC_nuPug4ccm
 D6JC9WkYffeIDK74I6dJpFAN0Ydqo.LP3wJ9B4Qotj2AH8eDuNnFXTpaWRY7CJybP0Ou6vpS3IjO
 b8Yvy2NZZA1t5yQupMir22juwLTlLe330maf17U9v7ChDna8tyQvEiTwrSAFl5UZdx8ilTBTSgHw
 fzKmb.g0YoPmODTXtRxUrMfTBziU.sXUTpEVDixSdjs2kedcQ9k1574wN0JESKZGPAuG.F3XWve.
 RooZW1A8Z_lbf33ThEVvGaZXFDUTHrzTroZ4RPRNyllaFMURY9XTvvIft.Lg6c0VzPuTzUtD15q_
 kDA3j60l36jbWvWNdCPKExuG3XNi2vaBuXrOcwH5j8DeeRswTVZ9qiE83V9nWTp6awtRtbYZhumj
 44VPIXgM3lJglOG5CkiROeVpBte5eqFH3cFCRIwz.vLnf7LC7g2.DJk1H1UbYDo0ZvoYmqHFgzf9
 rcPoq3jnYrVSQ1m.gE5g1u6oDO61H52W5yVBbFIEhAUU4O_XV.BOF6EDuinzN26pST0PlwhbSBRk
 fQ8eX
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Feb 2022 19:12:52 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 47e7bca4462e87587fa2ec7510147bac;
          Thu, 24 Feb 2022 19:12:47 +0000 (UTC)
Message-ID: <e5c6c188-650a-78fd-4937-c37d201c97b9@schaufler-ca.com>
Date:   Thu, 24 Feb 2022 11:12:44 -0800
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
