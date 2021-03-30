Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2164634F0F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 20:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhC3SWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 14:22:54 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:46434
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231910AbhC3SW0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617128545; bh=dsOavmNKN3u2I1eMkutBJ/i5B9RcZdVu95cN3rnbtMo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=gVrF8upEAaEOZ8Iat+PXts2Vx4fSCksBGhbkBOVs1RXBp7c1j6NRWEO/LQtNotxpQmqoNJ/ShYoQt3uwFL0B7WnsFmU4BAwi5ItYbWhgLe/BawtdCjGxxmoxwLwBQOzmdQioc0QhoorGlW6D9TuR4OTANoHWFLg3UlEWIRhC3ZdY1tCR0hiv6qEmhkCKLIIAFPNhdT59mr6nSAt0xjMkLT4fMwFZHUQUyacHOFX3ojPo+Cc5KDWVMdh2E1wFvPjmtP5UAIYnyUMXsJyHLfv5/wNDotbKbf34tyUKDOD6DUdR+WUrqPLm50mbUTCuPcg+o5OjG4GWFqZ8H7f3xwqrKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617128545; bh=MNBro66zU2glLBvTgQjhEGewh4XSgU0tyyfq9kv+AKJ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Sq7FuJoG4J8BtFYwSqdytqu5EWuei3tkNBgWvS6zpDx/h0pWr3s3h3lIAw+RL7Y0RbO30tJ+TcgVGs1XyRNnzPXdxyO+yk4P1Dx003ffqY6A188AjZS8Kyl1Urw41mfUUgMDhkaO/Xw/ElD/BqrncsulNhmh/vIv+fYd3fDMLU1VXxm6B0KaT8qzznrKTT5fsz7Uu9CetoRLjHU7kFJmz0rxkBxZ+3LrBce7pd41OwadXigH0ZvbgB7gfvNuGNMlcNmLP2PIvIzH/yGX/uCN/TBHKWmbzEeRwxVeNUt0EOl1xT9VAQTzmIEs3FZkKn2JGkvo1dCl9GGhTG/jewq0hQ==
X-YMail-OSG: .lDB5t4VM1ncCnfGnRFam2qW.3Qvxuzp_5OKU8veFPQbZgX1L0pOFBx5b6iRNl1
 LuWse1SZMxWLIPGPCWou98OsHGKHNtX5FUiGXKUD2xNtCvBhK0Aqhg5TC5OJ0maxZHKO4h_JaQGm
 wS1M3cTlX9MmKHcAdFa6aEG9TRPTetnZpDt9h7M97T.oBnD6jUTiTOa1vIPi6bnyrJcldjdsMDjL
 JhFR.QEFNeg3JnVBmWBmqTj3tdWMenraJn6oHHm1o49lu3LrAhGRO._VHapA76PPlX9XXOdvIOUf
 252sPCB5jzB2Te.tzx3QnT.Fk.76J8fTKQwVS.zS3S2gwZKa2_yDlsqRwhcR9ijXhxiAaMKR.UHe
 pAfNb8eZKWPzHakSV2jST9uNKLC5ngYOjtdtmOzQR9AqRQoWqgPzcslrsjYKvUMWZO05fYGL91Oz
 so5OfhURywBITcOmcYHjx.co1zDXlOwKULl2hiT9osCBN9fK94CSJ08eLunzbuhMwf.w.QpBXmro
 4JYOXq496xHsPy5GGQ7esyr7.czsXstQQVX1ZmUZukdTLJm6VXT.nrc17lK3wiZILFpFNIxTHc12
 _ZtgYDOPGHNySIYL11G.paCiS3OsGW2SjeL8g.s_AhYBUX8Cv_LV5Nv4s2.nnI4H0cwDA5Keqqa5
 cTrqOEaThbOzZHfD_LnPisiDvd76bGNIChJS2CREfAlMyqcptDCV2W.uUM7rydzukoA0O1MGOM_3
 ppSzsUPe8MJeXJjUFqRqEJjIox0RtuHU_DYgkTtrVeibh2Jis0Hdva8yC3vnkc9JrV_TLPSyzdsy
 oqClDMFOqLOwRLYGCnGbeaZnW2uLCFrFZjxnu4tOfodd6Q95wjg484lfGoELKAK4tdE6Atgb4DSP
 bP4rwKwjZ5zU5_dHGvt3b7sN3q6BqEKdru_UuL5WMQTsXbrziabpOhTsEFIL7EV3PsLLNanaCoTF
 2idE0YXRga3R5mCG.3.psv4.L8nkAEUkdT4t.DGusLx7HyOxMFJT_BZWpmUV_ylE_8hxCt8MX.Qx
 rQ73esWqWo6ULYmOTpfGtRKLzb_KyYXwN85VE2JGuHayTKfUGlNRi16wiSs1K_HJrV6TWEtWf4QC
 OauioLtXYU7ctlVEozj8Kmpw0lZeFYZxch4nXKhZrF8jBJ7_2u1bAlCX6t39KSCxYkmEJ8YDS7.f
 4vdN2DqWeASrhNzJ4f9nOgcWB8fh0KIjtspjw.u_lvceLLMzoJDUNsXHgkXszC2a50dAH3wy5Eug
 phqbtyAmGrac_p6vhmlXb_9uLJ_ZZ95sL_FshcTgEooH3WwF.wyvVqtCwkSqvROwWQ3DyQuL5Fgn
 pLrMipO4fBgaG2cRoBtxBGGhhUJxyu1WbKjSOsVfarOCjFNkINfkt35ZTXcwq6h5.CKX.8hrj6.Z
 UzLd1USBIiepeb2fU87Q4h2BB.f2xdLrAauJRhYReNx0o9mmpFRNbXsUld2iqetIq_cYIBOqd2BE
 5OGKTNsN3nD8w5wZcM4ix_cvUUqw5N9ty8sQjFTSp2ieGApPrilFWxOXhwNi.QTpst_usbo8VISp
 Nk_OTQev90fzeD58sqYKvzuNMW5W8WMd7pwhZ7j3mPmHjFRMueU.hTS_jgcJzaV2cg9KJWX90_VR
 KQDLvGrvXrQOI.tvYUM3zQmq0BaTnQkz9oOhlsb_9Fq6CdfTDWLenhV_gAb1Rl34vwLAL_KQYiPN
 wGPjlDwr4c1FzlaA23FvoZmHtAswGK.zP9846CooLWczwhkTK.QB78kXIEJnb1CvvdqdASzcThDi
 yTCqW9T8hsXPo3PzdN3JfCools5A0wmCamah_RUxZ.4Nt7ZcAlFT4Yva4zJxsSR_5ICmqLO8FdGu
 AF0ATqYSc2_F0q.6rbEzbYhAJHr7KILm2bVOmIgrWTNStrdz4ADlTAUHEtW_cykTQYU4nWVdX49N
 p1fz4PSruIrhfyQ4mmLZmMrexw6QkFqLydKzZIABxcH98XVV8FSEgM7jjy2dEI5YWDKgrMyqEoU1
 vmKn1vm0TZg_xQiMpBo4hhjETJEVPIDMmx0ZxnXGLjkfpKS1xHp4p19jzcE2PpQMsP8gzF1BjbGm
 qPQdTO.xLZaF.0iPCsZYoM2u_24FnXfdmjHpccLyyBgsElQgRDG0haohDmnmaTm.tWDwnR.Wz10R
 qKA_j3Ve8ZGXziueVpMRniiXvvBAvNZkCNNEx5cRFODA9wyr0BuqkGnHyW7wl1gIBwFHgbfkCICg
 VuoOXey4C7EuZFP8d7lEskOAGzAaCJhgyv1Rpx6dwf_6fni0MCntnZy1JbdN1VowCjs3Iov6VTxX
 kL3a255LsgEHyI8tFzG5GQ909Nv7dTZ4VOZ7Ei4dSD.1TCQ7IHMGstUiUDIDpAMuEIJkSOV8H_mM
 vMV8IV3oTscgGd_ShI30QCRv8OnvinzAWvF.AUNvKmoA38NezMn6CJ0ePS9J9GOqpls4zG0CRDzU
 YG_cRxj_lAmgW9K40LIiBSM3aeqGEg2Cck1oUS4e7s06kcYqARFBprFKVTMpQLdSGHQAhUyRcN9_
 xYKURArtw.w9g5A7g6M1MMm5h74E0FcGsAFP4F87cpzaIDjV9xc1NnRenOnGGNwwgi5vNsBKduPR
 hYOvY4D66.WUCDqv4lNOmZqdHpedPPt.xG2supzWx4WVdlGoT3KXdtNPJZrAv7r7KQAZ6d3q_d2a
 mC19NqmxHNlKg8RlIrPod2e8eqGo1VRtG00iZ2P2sHhkwMGsQkZ4hTbpemyOXOZZ7LXy9_gBGOWA
 ZdbnV32avpdsnAMK6dsqIseHgN.GAZyLr_CYEnuPHnY0OCac94nePmKOFsbGmPUiGPrqS3JlxjEu
 Co7uEqPRvixaGGD303V7d.Cu2Ky42Rk6njlNskX4FfJBSFZHG.LPKy9gxA75fEz3TQm6YH1b62vD
 hA7PywTWtDlJrCFxct04xKzqoGeDic2ucBmsRJ8Rolmv8yT6ZvGjmieockNqdphdlpOTnkLrgRMt
 m4_WTTd4nF_ySeAe1be0mtLjQ1n.hyKsIaMH9jWmV4800UVnjrJDpdLuXSalb7GPcDYzxS4TjE.k
 YDZraJZIgxpW7kZsnJNNARreDOpXd9A1Z_Q1dOVfnj_FalNTOyApgVhAmqMJtzi5oG6c.2Cpn5mL
 YT4v6obxr6kSyfnc3j_dZLVqcJi8UbDvx9RUGdXExkNha_jHAJuJ5FJSawibfUroZi.6gN0WT35e
 Wa6T6c99lu7Hzxly46iOigcku6a6jwlPeDLEVaQYrzhT2dteEElFNJ.0FVlKbeHuPBWVkd5gRkQ7
 c7dIVTsxbBM3yUdICdEk_eKaVSHLXJCUcE.TCpds7KVo.YDccvIkcfgkHfxmLch3AvCTfw_48P.Z
 gD.7xxDm3XwmJUHU8eOyq8FZs210ggAffiLDgrHCnwbhlG.z0VkS1Ob01YjFrmgnYzrjh2p0oSdh
 NxkU3R3UyBGY63r8.EW6lFzPFvTmy1uIUsQmMHj_lPFjzd0MHwXrZ_4ITvWXr..k8eqsimv5PimA
 pxl2qBw5gVDJbva41jFCUwf4QOLJRq9SDNN4Tjrg3EVg4URtE63qu9T96xtb5iP2jGkY9CPiwDvd
 4IKOZ3.N_pXtEC2hJwlv48_SXJkeOadRpX4ycR9nbwTA40AcTnTRgTG0HP9dCQv7wEo.ksYRbSu3
 1.6B6mP10pja5RDCOUve6BGapbSXG8Yc3n3ugyGdYNcCthwmdIPO5NnvGpVWvztP7bczfAkHHQy3
 Du5lho.mRuVmdhsCwOdPSVbL0jwYuhEqPWhPI00UUiUK_iNmoGMMYMBn0TPLm1nXQNjxWyBgP0l.
 IAsQ1CCK4I2EIW0cdrmMk9buV4e2wHbS2ogwV4ZW6VQ.egFxYVzFpCAbGYrwXDik1zNc00dwIktZ
 1CTc0gteLEoFQws3HVc0NzEqH0UUaASVubbiHVh.eYUdD.l7hRFdiaNKhlFfGfY5.jvUVXTC4BGC
 qzAYiMfpvwbX1yDmwtkUEryYFKymlxIyV8z__K6NfBe2or5f8VNaZb4XBGcivA7oODrZ2k8dsY5e
 0RGSSLT0WQZg8Jbg.3m5FI1reOIg7
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Mar 2021 18:22:25 +0000
Received: by kubenode525.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 58f0662cd0b4855022c5b5e7cb294346;
          Tue, 30 Mar 2021 18:22:22 +0000 (UTC)
Subject: Re: [PATCH v5 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210316203633.424794-1-mic@digikod.net>
 <20210316203633.424794-2-mic@digikod.net>
 <fef10d28-df59-640e-ecf7-576f8348324e@digikod.net>
 <85ebb3a1-bd5e-9f12-6d02-c08d2c0acff5@schaufler-ca.com>
 <b47f73fe-1e79-ff52-b93e-d86b2927bbdc@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ddc6d954-0237-f108-a4c9-7e1c03eaa08e@schaufler-ca.com>
Date:   Tue, 30 Mar 2021 11:22:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <b47f73fe-1e79-ff52-b93e-d86b2927bbdc@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/2021 11:11 AM, Mickaël Salaün wrote:
> On 30/03/2021 19:19, Casey Schaufler wrote:
>> On 3/30/2021 10:01 AM, Mickaël Salaün wrote:
>>> Hi,
>>>
>>> Is there new comments on this patch? Could we move forward?
>> I don't see that new comments are necessary when I don't see
>> that you've provided compelling counters to some of the old ones.
> Which ones? I don't buy your argument about the beauty of CAP_SYS_CHROOT.

>
>> It's possible to use minimal privilege with CAP_SYS_CHROOT.
> CAP_SYS_CHROOT can lead to privilege escalation.
>
>> It looks like namespaces provide alternatives for all your
>> use cases.
> I explained in the commit message why it is not the case. In a nutshell,
> namespaces bring complexity which may not be required. When designing a
> secure system, we want to avoid giving access to such complexity to
> untrusted processes (i.e. more complexity leads to more bugs). An
> unprivileged chroot would enable to give just the minimum feature to
> drop some accesses. Of course it is not enough on its own, but it can be
> combined with existing (and future) security features.
>
>> The constraints required to make this work are quite
>> limiting. Where is the real value add?
> As explain in the commit message, it is useful when hardening
> applications (e.g. network services, browsers, parsers, etc.). We don't
> want an untrusted (or compromised) application to have CAP_SYS_CHROOT
> nor (complex) namespace access.
>
>>> Regards,
>>>  Mickaël
>>>
>>>
>>> On 16/03/2021 21:36, Mickaël Salaün wrote:
>>>> From: Mickaël Salaün <mic@linux.microsoft.com>
>>>>
>>>> Being able to easily change root directories enables to ease some
>>>> development workflow and can be used as a tool to strengthen
>>>> unprivileged security sandboxes.  chroot(2) is not an access-control
>>>> mechanism per se, but it can be used to limit the absolute view of the
>>>> filesystem, and then limit ways to access data and kernel interfaces
>>>> (e.g. /proc, /sys, /dev, etc.).
>>>>
>>>> Users may not wish to expose namespace complexity to potentially
>>>> malicious processes, or limit their use because of limited resources.
>>>> The chroot feature is much more simple (and limited) than the mount
>>>> namespace, but can still be useful.  As for containers, users of
>>>> chroot(2) should take care of file descriptors or data accessible by
>>>> other means (e.g. current working directory, leaked FDs, passed FDs,
>>>> devices, mount points, etc.).  There is a lot of literature that discuss
>>>> the limitations of chroot, and users of this feature should be aware of
>>>> the multiple ways to bypass it.  Using chroot(2) for security purposes
>>>> can make sense if it is combined with other features (e.g. dedicated
>>>> user, seccomp, LSM access-controls, etc.).
>>>>
>>>> One could argue that chroot(2) is useless without a properly populated
>>>> root hierarchy (i.e. without /dev and /proc).  However, there are
>>>> multiple use cases that don't require the chrooting process to create
>>>> file hierarchies with special files nor mount points, e.g.:
>>>> * A process sandboxing itself, once all its libraries are loaded, may
>>>>   not need files other than regular files, or even no file at all.
>>>> * Some pre-populated root hierarchies could be used to chroot into,
>>>>   provided for instance by development environments or tailored
>>>>   distributions.
>>>> * Processes executed in a chroot may not require access to these special
>>>>   files (e.g. with minimal runtimes, or by emulating some special files
>>>>   with a LD_PRELOADed library or seccomp).
>>>>
>>>> Allowing a task to change its own root directory is not a threat to the
>>>> system if we can prevent confused deputy attacks, which could be
>>>> performed through execution of SUID-like binaries.  This can be
>>>> prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
>>>> prctl(2).  To only affect this task, its filesystem information must not
>>>> be shared with other tasks, which can be achieved by not passing
>>>> CLONE_FS to clone(2).  A similar no_new_privs check is already used by
>>>> seccomp to avoid the same kind of security issues.  Furthermore, because
>>>> of its security use and to avoid giving a new way for attackers to get
>>>> out of a chroot (e.g. using /proc/<pid>/root, or chroot/chdir), an
>>>> unprivileged chroot is only allowed if the calling process is not
>>>> already chrooted.  This limitation is the same as for creating user
>>>> namespaces.
>>>>
>>>> This change may not impact systems relying on other permission models
>>>> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
>>>> such systems may require to update their security policies.
>>>>
>>>> Only the chroot system call is relaxed with this no_new_privs check; the
>>>> init_chroot() helper doesn't require such change.
>>>>
>>>> Allowing unprivileged users to use chroot(2) is one of the initial
>>>> objectives of no_new_privs:
>>>> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
>>>> This patch is a follow-up of a previous one sent by Andy Lutomirski:
>>>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
>>>>
>>>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Cc: David Howells <dhowells@redhat.com>
>>>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>>>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>>>> Cc: James Morris <jmorris@namei.org>
>>>> Cc: Jann Horn <jannh@google.com>
>>>> Cc: John Johansen <john.johansen@canonical.com>
>>>> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
>>>> Cc: Serge Hallyn <serge@hallyn.com>
>>>> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>> Link: https://lore.kernel.org/r/20210316203633.424794-2-mic@digikod.net
>>>> ---
>>>>
>>>> Changes since v4:
>>>> * Use READ_ONCE(current->fs->users) (found by Jann Horn).
>>>> * Remove ambiguous example in commit description.
>>>> * Add Reviewed-by Kees Cook.
>>>>
>>>> Changes since v3:
>>>> * Move the new permission checks to a dedicated helper
>>>>   current_chroot_allowed() to make the code easier to read and align
>>>>   with user_path_at(), path_permission() and security_path_chroot()
>>>>   calls (suggested by Kees Cook).
>>>> * Remove now useless included file.
>>>> * Extend commit description.
>>>> * Rebase on v5.12-rc3 .
>>>>
>>>> Changes since v2:
>>>> * Replace path_is_under() check with current_chrooted() to gain the same
>>>>   protection as create_user_ns() (suggested by Jann Horn). See commit
>>>>   3151527ee007 ("userns:  Don't allow creation if the user is chrooted")
>>>>
>>>> Changes since v1:
>>>> * Replace custom is_path_beneath() with existing path_is_under().
>>>> ---
>>>>  fs/open.c | 23 +++++++++++++++++++++--
>>>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/open.c b/fs/open.c
>>>> index e53af13b5835..480010a551b2 100644
>>>> --- a/fs/open.c
>>>> +++ b/fs/open.c
>>>> @@ -532,6 +532,24 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
>>>>  	return error;
>>>>  }
>>>>  
>>>> +static inline int current_chroot_allowed(void)
>>>> +{
>>>> +	/*
>>>> +	 * Changing the root directory for the calling task (and its future
>>>> +	 * children) requires that this task has CAP_SYS_CHROOT in its
>>>> +	 * namespace, or be running with no_new_privs and not sharing its
>>>> +	 * fs_struct and not escaping its current root (cf. create_user_ns()).
>>>> +	 * As for seccomp, checking no_new_privs avoids scenarios where
>>>> +	 * unprivileged tasks can affect the behavior of privileged children.
>>>> +	 */
>>>> +	if (task_no_new_privs(current) && READ_ONCE(current->fs->users) == 
>> 1 &&
>>>> +			!current_chrooted())
>>>> +		return 0;
>>>> +	if (ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>>>> +		return 0;
>>>> +	return -EPERM;
>>>> +}
>>>> +
>>>>  SYSCALL_DEFINE1(chroot, const char __user *, filename)
>>>>  {
>>>>  	struct path path;
>>>> @@ -546,9 +564,10 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
>>>>  	if (error)
>>>>  		goto dput_and_out;
>>>>  
>>>> -	error = -EPERM;
>>>> -	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>>>> +	error = current_chroot_allowed();
>>>> +	if (error)
>>>>  		goto dput_and_out;
>>>> +
>>>>  	error = security_path_chroot(&path);
>>>>  	if (error)
>>>>  		goto dput_and_out;
>>>>
