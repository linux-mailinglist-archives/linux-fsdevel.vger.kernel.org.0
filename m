Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC024C3A6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 01:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiBYAkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 19:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiBYAkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:40:23 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E92C031E
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 16:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645749591; bh=JOxcuIoAlv3cdgM+wmjt/1KHy3bkxqK6TX96bc0VRGc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=s3Si6IqMy++7A0tEm+dVQoVD2XOScMoTjIaOG4AIWyyUJ9ussvTAGbrsYz691jIebkvAlPNNwf+SeRfez6nqZ7Q7ITFbVRNPrzMHm4YGrnXvL3vhAv7mQeeWJyj01kfdNsZXgNYhy/7WMjJ+2Hj3C6KWZXmo3mUdFWS2Pk03jOpFaAzapf+F0SvrzZM+rhvWMh1P6yacRJYT1ykRGulf9Ks5H894Td7LN4GlPwtZg/3U894yrJlxjHtgwu/00TVR8Ww5mqSlLNQAxFba1DMuA37hm84vc0zBh1uY5WzWWczw1ulEc/KFzhUJuwjDHZj1pVhhrIPKzCuWShXmSD9mEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645749591; bh=tt7M1NpJNYsyCewzIETG0dCaD0ipXft+ZGPRFz0TWvS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gjDduCbCV+03NjSUN619i+DcXuVpkFgvA/oQuw0qThUmMbg3wNpnpus8EUvVJJOH7ia1MVSo3Z5Zm3Yc46EK4M3lcKiHigASJO1j9h9kvg8GbsfFCWqHobmWkdDp5DLZd6vMYzESk+tdjZV6qSvU7dTE3IhWoSygOZWmYETLA5wXTTDoEYvOsdKPct8BTExx2vEIsiTNDguOEvlh+lwa8zNuKjYBs0IgP9nrP3i3ZaTyUp4Yyo/8GncVncxEDrPo5gbQMzRLTESCoIlwfYabMZ7gzjU/MUB/c+SYcrA52Ql2hyxWuJFa8V8X2q4BAlnH702tucoQl+1hmNZrn3hI/Q==
X-YMail-OSG: 9EfXppYVM1lIxv5wRyaXykC8wMtIexl5HOE27bA3fPJQv2tZLPTyczxmOmIe.Qn
 YoQOFoTnEr21a4mQr8O8zqg6HY9PT1WqmB14OLLYgmLlSYh37u4pKPE6.VcM1a1t9CJFxFg7i8Rq
 QX1T.eHSLCmbcSCQYYqfS6hoXNgKZOLxaP_5729wSpCDpN7mbf2uuLdNJqwhTMlpAu_7bl9fYwQI
 fTGu8qoSGr6l6.HdGrWI7vQok1CsVJnUgCCMuoGfpFRKFkGrtkU7xrGKdi6TopcVxzwk7LxyX5tU
 s_YYGWfS5cewgeq2azghLJf2YQobe3EiC1vSmO6geBenqwNHTele.Q_pB7M5xX0.LwUQapL2kQRT
 zovx0gT5QqBfoc6UKniveY4p9jyTXyJ1PbsUboXLHwB7nQEMIeuohtIKF3YwiuTiTMBqzlAyC0Fa
 QH2m.NXRbORd9aKMfww4rF79B3VhBc_hLv7oAsmB_T4C4WZJkOtpiWTtjRti_w2nnk6uk2NxiVsw
 nXafH7Nc3sIs6bFR.0YjNFm2fP0gFUvdmDNezslZCvBkiVOV0ObDKkbF12mrzizry_FpfPQUm9D4
 LdDm6SkVlDEmWUpzLC9FqxwVf_8xHw2JLO3iuhR9GKXMm_NO09pwsWH5MmBy7P9FuuE.hr5J7ZO6
 RVWHAFO4ybCvnvMmkGJJaanO953WbpIOPRBhUWnPhnz2yFgLnl7wzjv6MDClvWHywnY2.j9MCFZT
 jTT1b4x9bp8SqtdCSxsrOze9aWy5D1eB_LTy2ffqQEdQjZF.76Ha5MTKqcgK_M6Lv2S9Fl_5unc7
 Bf2uieisxivA2M8MFACpmzeengiMaghTXxTwzVUSdRW6mhKOL8bFdTL3xLrecszWQ8wyDOw7.kcc
 Jx6hVQrK7qQGuEDZ6DXtfFUpBiSwGtREWAC3djgc48GmHiRdG_PYhgFj2IbzbFWKZnBs0NCUu0YM
 VD6KC.YuDAKkYJ65XkElFPgYmIJA02pk3khKZNSADEbKjgCf42u8gY9bYvgcTgpfrFSxQD4vt_Hd
 rNftdgo.ehXJg95UXIGm_PkMOsTWbnpELjAI8l0oCFY0RRr5nfvNsJvMfyccXewoRFIZkxWmt28Q
 BIAGDXqwEyFXLRYk6AW4KTCoLtYfYo.sAveWqHjmnuWRko57Xwcc5yImxBeC3Ka8_JlcRFPzNMiJ
 arAbkNSVo1zEvuDmSZh9wv5R7UCetAWlHUC32_PRLuG6_k5a_Oxm35hzh6lqVI6P90PwoLawpc8M
 oL.r8cBZYLnY50wg8VdK2XDkvt9P3pTg.Z_G0vhpY6SzjX94e.Ln9xdLqkNYWSWKiPkEnIvuhsJB
 Jl4bVKMBatCAf6FOGM3f.4Ygj.3QkjN_OI_okd0Itv8oIbuAPTHPv2OytVkpueGHUwf9JmZnsGZO
 T0xrqe2IJ00KWjemkqbGA5gkJxxNDe9vQBbaquW6y9scm2I7WjrM9d_A_Hd3TTAUDHR0iAfxBk46
 MbjDXyPK10MWhDmp4fgOo_KlCj3UYC1JZO35J_v5gdj4g.546LsrHZUemeGA.M36ZqRJseY8lVMP
 lKQ7uP0d24etZDLeOuX4wiN_t6sY1hP6ANXm98RdFo9UhpmIwcPOh.1SziNzb5rvLhTQKgOf_22h
 5RW_EvIanImOJWBEDIcXNhM.jFMOv0DeEjuMke_vv.tEynhAQH6j24._xlhoXj6az4km6NKqGzIn
 _x60SY.Jjci0GYrbqwGXzxdMfuOKdpFmTCW2l9MFniPOFLxGOrmgwzTNSyMa08IGSohqE9Ai5_HA
 P7h4STpyPAVc__TvWSKXiSX2muNyccM5yG5ipC1uqnH_66c2CFvIqTcJg2G4g6ZTurwK9ImZIXU.
 Ft_d52QE2b4FdrgDKVF9weMBrC7AJsr6WpE7q2Rm12kNApX5Wq2hQIxq6shNi2TuAmhG9A08Z3cl
 bBqBdJmjY01TdRtcj4Yl5q6owQpse_IkW.8SBgUeInTyxd8dP3AJ.OcW.bp5.18isuB9X6U_4.vL
 DN6JUbywQPPgoQq8hiPf8JZJJHxc3dC2Q6eSU1bnaU0SURlTBE.FaqVpWSduUsWM7J5pTtvEE2Lh
 UoV8D06iXThDvHiJbE2hLG5DAX44xe2ESDN.3c2bdHOxvNrYdcNlYu6ASwbALnikQU7GdT7esQ3m
 I2b9Y8yCPIOBHnabdyWjSorilXIZrAoUekuKVzz.tLq_RzwECeykn87LpidGWyVHOUZHFvQVs4BM
 VCwAms8sup9uaglgaxA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 25 Feb 2022 00:39:51 +0000
Received: by kubenode548.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c5e3409641cab90dc37c286030b4b88d;
          Fri, 25 Feb 2022 00:39:46 +0000 (UTC)
Message-ID: <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com>
Date:   Thu, 24 Feb 2022 16:39:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220224181953.1030665-1-axelrasmussen@google.com>
 <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com>
 <CAJHvVcgbCL7+4bBZ_5biLKfjmz_DKNBV8H6NxcLcFrw9Fbu7mw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAJHvVcgbCL7+4bBZ_5biLKfjmz_DKNBV8H6NxcLcFrw9Fbu7mw@mail.gmail.com>
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

On 2/24/2022 2:07 PM, Axel Rasmussen wrote:
> On Thu, Feb 24, 2022 at 11:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/24/2022 10:19 AM, Axel Rasmussen wrote:
>>> Historically, it has been shown that intercepting kernel faults with
>>> userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
>>> of time) can be exploited, or at least can make some kinds of exploits
>>> easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
>>> changed things so, in order for kernel faults to be handled by
>>> userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
>>> must be configured so that any unprivileged user can do it.
>>>
>>> In a typical implementation of a hypervisor with live migration (take
>>> QEMU/KVM as one such example), we do indeed need to be able to handle
>>> kernel faults. But, both options above are less than ideal:
>>>
>>> - Toggling the sysctl increases attack surface by allowing any
>>>     unprivileged user to do it.
>>>
>>> - Granting the live migration process CAP_SYS_PTRACE gives it this
>>>     ability, but *also* the ability to "observe and control the
>>>     execution of another process [...], and examine and change [its]
>>>     memory and registers" (from ptrace(2)). This isn't something we need
>>>     or want to be able to do, so granting this permission violates the
>>>     "principle of least privilege".
>>>
>>> This is all a long winded way to say: we want a more fine-grained way to
>>> grant access to userfaultfd, without granting other additional
>>> permissions at the same time.
>>>
>>> So, add CAP_USERFAULTFD, for this specific case.
>> TL;DR - No. We don't add new capabilities for a single use.
>>
>> You have a program that is already using a reasonably restrictive
>> capability (compared to CAP_SYS_ADMIN, for example) and which I
>> assume you have implemented appropriately for the level of privilege
>> used. If you can demonstrate that this CAP_USERFAULTD has applicability
>> beyond your specific implementation (and the name would imply otherwise)
>> it could be worth considering, but as it is, no.
> Thanks for taking the time to look at this Casey!
>
> I'm not exactly clear, would you want more evidence of userspace use
> cases besides just mine? Besides Google's VM implementation: Peter and
> Andrea expressed interest in this to me a while back for use with
> QEMU/KVM-based VMs [*], and I suspect Android folks would also use
> this if it were merged (+Suren and Lokesh to CC).

What I'd want to see is multiple users where the use of CAP_USERFAULTD
is independent of the use of CAP_SYS_PTRACE. That is, the programs would
never require CAP_SYS_PTRACE. There should be demonstrated real value.
Not just that a compromised program with CAP_SYS_PTRACE can do bad things,
but that the programs with CAP_USERFAULTDD are somehow susceptible to
being exploited to doing those bad things. Hypothetical users are just
that, and often don't materialize.

> Or, do you just mean that userfaultfd is too narrow a feature to
> warrant a capability?

Consider that if we implemented every capability at this level of
granularity we'd have 400 to 900 of them, and they'd have to change
regularly as underlying implementations are revised.

>   When writing this I was encouraged by CAP_BPF
> and CAP_CHECKPOINT_RESTORE, they seemed to me to be somewhat similar
> in terms of scope (specific to a single kernel feature).

CAP_BPF controls use of an entire access control sub-system.
I'm not going to argue about CAP_CHECKPOINT_RESTORE.

> [*] Although, we talked about fine grained permissions in general, not
> necessarily a capability based approach.

Capabilities don't lend themselves well to really fine granularity.
The real intention of capabilities is to separate the privilege mechanism
from the discretionary access control (i.e UID) mechanism.
Most people are still using root as the basis of privilege because they
find the existing capability granularity too hard to work with.

Additionally, as you're with Google I expect you're going to be
using SELinux with this, and that's going to give you all the
granularity you could possibly wish for.

>   An alternative we talked
> about was to add a userfaultfd device node like /dev/userfaultfd. The
> idea being, access to it could be controlled using normal filesystem
> permissions (chmod/chown), and userfaultfds created that way (as
> opposed to the userfaultfd() syscall) would be able to intercept
> kernel faults, regardless of CAP_SYS_PTRACE. My gut feeling was that
> this was significantly more complicated than the patch I'm proposing
> here.

When I implemented Smack I was faced with the same kind of choice.
I found that filesystem based interfaces (e.g. /sys/fs/smackfs/load2)
were much easier for scripts and existing programs to use than were
syscalls. Yes, there's more kernel code involved, but you also have
more policy flexibility.

>
>>> Setup a helper which accepts either CAP_USERFAULTFD, or for backward
>>> compatibility reasons (existing userspaces may depend on the old way of
>>> doing things), CAP_SYS_PTRACE.
>>>
>>> One special case is UFFD_FEATURE_EVENT_FORK: this is left requiring only
>>> CAP_SYS_PTRACE, since it is specifically about manipulating the memory
>>> of another (child) process, it sems like a better fit the way it is. To
>>> my knowledge, this isn't a feature required by typical live migration
>>> implementations, so this doesn't obviate the above.
>>>
>>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>>> ---
>>>    fs/userfaultfd.c                    | 6 +++---
>>>    include/linux/capability.h          | 5 +++++
>>>    include/uapi/linux/capability.h     | 7 ++++++-
>>>    security/selinux/include/classmap.h | 4 ++--
>>>    4 files changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>>> index e26b10132d47..1ec0d9b49a70 100644
>>> --- a/fs/userfaultfd.c
>>> +++ b/fs/userfaultfd.c
>>> @@ -411,7 +411,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>>>            ctx->flags & UFFD_USER_MODE_ONLY) {
>>>                printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
>>>                        "sysctl knob to 1 if kernel faults must be handled "
>>> -                     "without obtaining CAP_SYS_PTRACE capability\n");
>>> +                     "without obtaining CAP_USERFAULTFD capability\n");
>>>                goto out;
>>>        }
>>>
>>> @@ -2068,10 +2068,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>>>
>>>        if (!sysctl_unprivileged_userfaultfd &&
>>>            (flags & UFFD_USER_MODE_ONLY) == 0 &&
>>> -         !capable(CAP_SYS_PTRACE)) {
>>> +         !userfaultfd_capable()) {
>>>                printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
>>>                        "sysctl knob to 1 if kernel faults must be handled "
>>> -                     "without obtaining CAP_SYS_PTRACE capability\n");
>>> +                     "without obtaining CAP_USERFAULTFD capability\n");
>>>                return -EPERM;
>>>        }
>>>
>>> diff --git a/include/linux/capability.h b/include/linux/capability.h
>>> index 65efb74c3585..f1e7b3506432 100644
>>> --- a/include/linux/capability.h
>>> +++ b/include/linux/capability.h
>>> @@ -270,6 +270,11 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>>>                ns_capable(ns, CAP_SYS_ADMIN);
>>>    }
>>>
>>> +static inline bool userfaultfd_capable(void)
>>> +{
>>> +     return capable(CAP_USERFAULTFD) || capable(CAP_SYS_PTRACE);
>>> +}
>>> +
>>>    /* audit system wants to get cap info from files as well */
>>>    int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
>>>                           const struct dentry *dentry,
>>> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
>>> index 463d1ba2232a..83a5d8601508 100644
>>> --- a/include/uapi/linux/capability.h
>>> +++ b/include/uapi/linux/capability.h
>>> @@ -231,6 +231,7 @@ struct vfs_ns_cap_data {
>>>    #define CAP_SYS_CHROOT       18
>>>
>>>    /* Allow ptrace() of any process */
>>> +/* Allow everything under CAP_USERFAULTFD for backward compatibility */
>>>
>>>    #define CAP_SYS_PTRACE       19
>>>
>>> @@ -417,7 +418,11 @@ struct vfs_ns_cap_data {
>>>
>>>    #define CAP_CHECKPOINT_RESTORE      40
>>>
>>> -#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
>>> +/* Allow intercepting kernel faults with userfaultfd */
>>> +
>>> +#define CAP_USERFAULTFD              41
>>> +
>>> +#define CAP_LAST_CAP         CAP_USERFAULTFD
>>>
>>>    #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
>>>
>>> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
>>> index 35aac62a662e..98e37b220159 100644
>>> --- a/security/selinux/include/classmap.h
>>> +++ b/security/selinux/include/classmap.h
>>> @@ -28,9 +28,9 @@
>>>
>>>    #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
>>>                "wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
>>> -             "checkpoint_restore"
>>> +             "checkpoint_restore", "userfaultfd"
>>>
>>> -#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
>>> +#if CAP_LAST_CAP > CAP_USERFAULTFD
>>>    #error New capability defined, please update COMMON_CAP2_PERMS.
>>>    #endif
>>>
