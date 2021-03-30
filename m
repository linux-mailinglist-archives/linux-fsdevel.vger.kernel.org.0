Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2334F11E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 20:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhC3Ski (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 14:40:38 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:43714
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232882AbhC3Skb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 14:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617129630; bh=cup2qwkOpAh65xj3pLt+ivg9u2EgUzzXWsL45OAq3Jo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=CX9MM/ytuaN4vAnu8/q+QOy+65xTMD6LNWEpcctjfHy4l3nDbqzvlP+7rhCl+iYoIoUSncg/4Sni3kNMRcGk6ByZw3qik5O/rcPJMyi7BHsVF57sCUBfT7fXK5UkWzuCTRFCX6agl3pPM85/62vNwdNYBKLK249OFrGkab46SzzV4OQ/bkGFUMoHzH0PY2FbuIzTAbMs5cV0o0e/kusAF8R2TsIkAVpNTe7wb1jExqI1rsRTNb0H4DkJ4VsWs96wUgoEiH65Tm+buydzX8/Jad7gIsc4wsu2bDVCG963Gu/j85cmAmMONNoSr7Q+ZV+t3NIstv6KyQoKQ26bFiKiXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617129630; bh=UJA5D4MDHJDUwKlgSl9n6atb5sNsvuHJ3SZuIGsSwDN=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=OlRzGpqiiatisL3XtC51Tyr5pGX6g2VBF1r4ZQ5NGgtaHtOa/LAwtnCVw1FNnrbYl22g+opa/qe9PtkbDg0po93drKJTb9y1uZzwYx7N9EEyQKBNJx3JZ15x7IrSEa9N0sWIxlGp2W4243IEm+MuUn3ARBJTBeSvUMzYopyE3d4SNQJ6x86K0W/V7ZsjL6qXeumyw5+yz8dCUGR02ZOKmu+Rws5BXq+Ub5iodPEtfPnM/zmfcDTnp+Wyj6iLOykH2pmlOpIOxVovEZAnCbkEM0+A2AhiuAfOjlqcB97qF3Xvx48zLe3/lmveVvFjq/+nm46cIPuAgaOci2PAbeCWMw==
X-YMail-OSG: Pe3qRdYVM1l708zMJkydbIIyGngsyldmt6bUHKmEHi.kJoXmadi7UAP4LBgZrot
 Rn.yJzi0zT7Q5bGD8HAaoJQCD7ZKrhwToEbebYKFzV_5HrFn4ZLNlPoRiOjwpWdZ.HvcHnTjDjXX
 GOnuTGZ0uD.z2e64.uROLT0eFts6HkyrwIAQM6P1GMW1JV8Xb.GxXc0CzIXZOk.NAfM5M8FStk2n
 Z1lWkehBKMZr8fcaX2WTtB5581eL4xlB137Gz9ODDji8kyczNLlLTRe_2VQjZQE0DnvrRl1R.kpR
 N7uuNz_TlB.a3c99c7568QxLQqMPpgctGFKHPZwKUP9WClXuWX2AVHy_P1_Gk97._LH32ePfh2pj
 7Jc5QL86Q41c6s3UufXqHEVVO44HD8GvNOC4Gc2TOIRRrDIWUi20JHv2eanKS3a7Bs0KKDiSAx_l
 MUax.pUigdQA53LUPsLgz0AKvBN_r5OqqsP5U8Hsmh3XkYj3B1teXmvUI_zIxsM8MI8ZVilgEM74
 87Yv4WykoE9TrB.hDhcEg4cVQJ4t8fmIrTp54Kfbe055lJJwkJS.rb09daqho4YK5BW_Xoqtlpgn
 5a2DtlLl0t6ds8iHmMwJfIusBHb7CEh7uaLz980JySVyrsSL65NUtON6B1KO8OF2wMD.0mRxkcJz
 dRyRoIKrVsrz6Wn927eKuqeJavbUDfyEg1hhj_rzIzeJqobgDkNwMc1.Vi1TyFhM7JWDwe7XbCSQ
 LYpmRamfAYeS5OVqZ6Uh5vYC2DqRFC4hmbR7ybYQQt_fsb2UQQg6xnX4scgwIez20vFuSr7euXst
 7DMxGlHnywUXw8RcTq1BjlRTlhojblQG.J7uWbeVJf3WicSCvn9Rla6DTM3GF31_0Qf8GINMoE00
 gx5KUUMJ9qy8tO.mWQL.bTDxH0rKgYHt_mbYBCB7HB3EK6Kq9A3ZJjCcfVKR6CS7xM8cZlzqszph
 Ndwp6UYWShmSbg4.Qs7uE0vog_j9bVhS29CVlA9VbzlKozGqGYsYR6w8eM.6MtHRUOGBMEZfFruv
 7M0trZ7OfL952cGoUjdEy5bv20ZeK6oojLyYU0nnErWOgBOnh8clEXlFU_SGXDNojQeXqDG93ORU
 mQBN7XxN_7BGjAkNktzldvHoQMsIZ4tRqHUkLFaURwVgLg5AaoXE4P39sOfXTmrsBMD7nZCz60_1
 ipDeHRMzKNB183ZSPjXMw8F8_.mMBonh.KnLdNuxbDCT_8ecdekJQ6xUrQstJKGKLL7cQ7xxT.wm
 5w615LsvN2knIEJ7n2xKZ3NN0IhSHQZsFQaC3T.t.WXGsH_bd8.MCO8nXF4Z4REP_gXlW6._x.92
 ENNZnRP8qwU6xlk.Bj_y1K8sxGjExYIR4jDpUvwdaO3G4NQgvK7smTuXj_CCmXSMsyVyWsmqWAb7
 nUGNeduRtjBklz3kzLRKkKXEBmkWxjNfVek1y27ZU1oliUfXqqk7BGH1BnEw8ATzpfjATcqZ7Z1R
 PgyrNYxtAnbSLIhhulQFOPrtNCV9Rq_b6seYEzLG9rWzlS4SjN6znqZF6RD3nk_pHSPK6UcZ_1ce
 l_TpNun4ZVEPNzcIKaExAQLpFnA9RQl6lVdutFPjlDr.jIvC3q5_LXIA52NaYGtlcQFWWFEa0B6P
 22E9XYjy91zg2DBR_gcMWzqtKsweRZy_jSqeIetnsIJRgxmegeHIWYAL86BzbCNmDGrupPj5KT1S
 PvMYl4pRkiXcwSoA1JS.XZqUUNo1fS.cpOqMQa_snyOW_US3ehnAnYYDAsdHCbKZicEuel5Q.jCl
 nn42UjOMQMGy6DUvaAQPc_T2sqqIymwvRke70eUW1Ky42KfNO5OyqF.uM792XXedur_SJgnCFGMG
 aEh5Hl32mcKCixKfCek2xdII1r0J_ygsUCw0es0rR0yleO2wmkCrciXhyKJ_doNHQIqGQ6CFM4ln
 eVTbZi3K1uYG1OAArwIWg2WPWJJol.77FEkU_8HtflbTG7fJJe482c.duf4nQC5ZnbptQg6P9QiU
 9DFQKbsB5EKTCX1cwVjvwi1pTp2TSS5lMrd6x72oGy.oQB7CuloHb8F.HqOTK1pXpKDkvCKW56pG
 cRHNWlzDZCV0nAG4ceZT4mSEpb90FHzcPTSIPdnCwxG4.D03_wd_X02.a7QVHn7D_RykO81KsaOO
 1IK2PqybA504TrSKc8_OpQzMba4PDpkcPEn6D29sJg6rcqmP3JHvl6BtO9Xt.RKt3FcmWYr820M4
 ljzyWblYxW4W8mdqiI.OhDoo4pM1gqrRPcl.2g5bEIbSBAz3Ybb3IJqDRBa08G4PhPvBbwn5fwux
 EHtRJkPdial_GRIjyFUh1.IO3gINVfM6XIGbyacooibaz.2.NfpNIjQtBWvb6uG7_y_XSsCDIvWi
 qc7u6CURfO3QrbUc192l_ZaOyU3TMAcVOMmkQ8z9ip92Ek9amxnb3OVwnQM8CAEp7DevFDAHw9AG
 FWDDcHKlXGQizRKhceRBHFgmtnlsN5QmeyhkeTPOwwHElrrr4ejehETqUgQwACSEtVMNHgfldvGw
 cclGx8s_lvRQuaIRbAGH6HNU.HaACFLlPQ3sbR.wxBfrDQjl33VQGtJAVzcMuVm0dJkHgOaGHRom
 XCxNRZxLf4tnfNrQ6y2eqC.v2NTHca_gTKyQhB5uRePvsVxM2a2V1q3.z4T1NEOpEvgAHBJpe9Zk
 4s7IYoCMMztOw9thDNmlIQHYXLXlrDHYMBu2mE3odWCoF.RETlWp2bo7wc6grhBwlVDwOuEmpKvj
 U7ZwkS_jYUDA5wdUmL6fBXCSAmvBAx9N7rkp3k8D_vtrrGWN4O7A_P6.GINH3GONlbbROahM3qWZ
 E8YT1ppQb5pMMJU.Avs8TE5DcrdYKPIA56dV_0FJxLhS.O8QNtUxhbNJbsIhiVRNclkZWOL0oZwU
 4.cDh57D_dSycOKnDz1xRtUVyGk3KAXtjSZHuXdd6VhWYyBeUEcDk27WDw6Idw7RFobU22fnlDfV
 Ga6kJ.dRSSRigF1Biy9CV4LUM.iDm81U2oLZ9qWYVa1D0cHGWBdOFxaU_D1gfIMYX5WzpOPZGk.e
 CnTbitQnwzbSkXWznoT1uDJJAHyyDkyN2MOMRYO3012J28UR8VFVePvdzfKvne.yPSmWXm1SyOZd
 .l0fLUMNcArBf0vUj1V7ZuvJvFM.2dRVebuIZm3BmW7Q7LG730.W67Vni_topkEqd1XadAoLAseY
 dpyBTjvv9FdCbWS6_kqL.P3jopf_SEcc7qUkaGdW.OEa5CN4klNOYeiY6zATA7S5RM_OZCZEKpJS
 XgQFNHxUHTsbhh545DQfCq4nGEnrMX2RkCsqRy5JSLrkIcqOTCB3gZabQ23MvH2FuaRsgryq0mE5
 RmZQO5PylEKs6Gabco6biiHcIviSteFF98RhHFgiubyFUGh0ua.vLHF8ZP67nwAhJC1R8BGdP_yg
 MtCM3clIqzEcYBRL7pDpf6skDeOsE7v1hBo.jtn9Zmb.stoQIHrtwtAeC6GeS4K0NkkBcyF3sFpX
 wR633RpkgUqb.SsWyD97J3VZDGccUcmaRwU7C22cD2P8iY7.DgIfoWfu6CCw3Lm_jEg2ADzOWQfu
 GLqxvpJMe5gx_RuQVLSCUml9FIls5K3Egv9R9Q_8ZEoJyJrgpv0I2f7UqY_nXwZVVYyn1t8IMQdR
 _APTeNyqN9fncgaUmXBAIy.hBcLnTtbKBiyjtMWal7wb3uO.B.GFWTfheWECrSfRboWmycxOT4Rt
 L7R8CqZMtVi1y4kTxu0axgOJcXIVxce5QSl5SD291jDLCGXyrcZfTxVSa6L_tWsi1fJN3teEE6m3
 MqEfpBDmmdSWYPAWJ3rd4sVIurTmo7eg9oYMgLiMO06aksrhXgziBPWpoIJnzsp3cEAyb1uiFVZd
 aaByLi._Z7D_Q7jg5IXJC0Z8Z76kBLEe0afqYulUdvy2McsCEc3euTRt_2xp6..NAQEDM7sNi2iG
 kE4FVlaAqEResmBjb4vr7obyXG2BfqtCpcI9G.yxv92.v9IDC9gdwfqatl4BxPJ2e6uQ8m3qAS4c
 sBkd7xujfWWtVDk2YXCXaxW..Sgst
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Mar 2021 18:40:30 +0000
Received: by kubenode543.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID db6875f64f29ff0b478ac55f3a858658;
          Tue, 30 Mar 2021 18:40:27 +0000 (UTC)
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
Message-ID: <77ec5d18-f88e-5c7c-7450-744f69654f69@schaufler-ca.com>
Date:   Tue, 30 Mar 2021 11:40:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <b47f73fe-1e79-ff52-b93e-d86b2927bbdc@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/2021 11:11 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> On 30/03/2021 19:19, Casey Schaufler wrote:
>> On 3/30/2021 10:01 AM, Micka=C3=ABl Sala=C3=BCn wrote:
>>> Hi,
>>>
>>> Is there new comments on this patch? Could we move forward?
>> I don't see that new comments are necessary when I don't see
>> that you've provided compelling counters to some of the old ones.
> Which ones? I don't buy your argument about the beauty of CAP_SYS_CHROO=
T.

CAP_SYS_CHROOT, namespaces. Bind mounts. The restrictions on
"unprivileged" chroot being sufficiently onerous to make it
unlikely to be usable.

>> It's possible to use minimal privilege with CAP_SYS_CHROOT.
> CAP_SYS_CHROOT can lead to privilege escalation.

Not when used in conjunction with the same set of
restrictions you're requiring for "unprivileged" chroot.=20

>> It looks like namespaces provide alternatives for all your
>> use cases.
> I explained in the commit message why it is not the case. In a nutshell=
,
> namespaces bring complexity which may not be required.

So? I can use a Swiss Army Knife to cut a string even though it
has a corkscrew.

>  When designing a
> secure system, we want to avoid giving access to such complexity to
> untrusted processes (i.e. more complexity leads to more bugs).

If you're *really* designing a secure system you can design it to
use existing mechanisms, like CAP_SYS_CHROOT!

>  An
> unprivileged chroot would enable to give just the minimum feature to
> drop some accesses. Of course it is not enough on its own, but it can b=
e
> combined with existing (and future) security features.

Like NO_NEW_PRIVS, namespaces and capabilities!
You don't need anything new!

>> The constraints required to make this work are quite
>> limiting. Where is the real value add?
> As explain in the commit message, it is useful when hardening
> applications (e.g. network services, browsers, parsers, etc.). We don't=

> want an untrusted (or compromised) application to have CAP_SYS_CHROOT
> nor (complex) namespace access.

If you can ensure that an unprivileged application is
always run with NO_NEW_PRIVS you could also ensure that
it runs with only CAP_SYS_CHROOT or in an appropriate
namespace. I believe that it would be easier for your
particular use case. I don't believe that is sufficient.

>>> Regards,
>>>  Micka=C3=ABl
>>>
>>>
>>> On 16/03/2021 21:36, Micka=C3=ABl Sala=C3=BCn wrote:
>>>> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>>>
>>>> Being able to easily change root directories enables to ease some
>>>> development workflow and can be used as a tool to strengthen
>>>> unprivileged security sandboxes.  chroot(2) is not an access-control=

>>>> mechanism per se, but it can be used to limit the absolute view of t=
he
>>>> filesystem, and then limit ways to access data and kernel interfaces=

>>>> (e.g. /proc, /sys, /dev, etc.).
>>>>
>>>> Users may not wish to expose namespace complexity to potentially
>>>> malicious processes, or limit their use because of limited resources=
=2E
>>>> The chroot feature is much more simple (and limited) than the mount
>>>> namespace, but can still be useful.  As for containers, users of
>>>> chroot(2) should take care of file descriptors or data accessible by=

>>>> other means (e.g. current working directory, leaked FDs, passed FDs,=

>>>> devices, mount points, etc.).  There is a lot of literature that dis=
cuss
>>>> the limitations of chroot, and users of this feature should be aware=20
of
>>>> the multiple ways to bypass it.  Using chroot(2) for security purpos=
es
>>>> can make sense if it is combined with other features (e.g. dedicated=

>>>> user, seccomp, LSM access-controls, etc.).
>>>>
>>>> One could argue that chroot(2) is useless without a properly populat=
ed
>>>> root hierarchy (i.e. without /dev and /proc).  However, there are
>>>> multiple use cases that don't require the chrooting process to creat=
e
>>>> file hierarchies with special files nor mount points, e.g.:
>>>> * A process sandboxing itself, once all its libraries are loaded, ma=
y
>>>>   not need files other than regular files, or even no file at all.
>>>> * Some pre-populated root hierarchies could be used to chroot into,
>>>>   provided for instance by development environments or tailored
>>>>   distributions.
>>>> * Processes executed in a chroot may not require access to these spe=
cial
>>>>   files (e.g. with minimal runtimes, or by emulating some special fi=
les
>>>>   with a LD_PRELOADed library or seccomp).
>>>>
>>>> Allowing a task to change its own root directory is not a threat to =
the
>>>> system if we can prevent confused deputy attacks, which could be
>>>> performed through execution of SUID-like binaries.  This can be
>>>> prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself wit=
h
>>>> prctl(2).  To only affect this task, its filesystem information must=20
not
>>>> be shared with other tasks, which can be achieved by not passing
>>>> CLONE_FS to clone(2).  A similar no_new_privs check is already used =
by
>>>> seccomp to avoid the same kind of security issues.  Furthermore, bec=
ause
>>>> of its security use and to avoid giving a new way for attackers to g=
et
>>>> out of a chroot (e.g. using /proc/<pid>/root, or chroot/chdir), an
>>>> unprivileged chroot is only allowed if the calling process is not
>>>> already chrooted.  This limitation is the same as for creating user
>>>> namespaces.
>>>>
>>>> This change may not impact systems relying on other permission model=
s
>>>> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) =
on
>>>> such systems may require to update their security policies.
>>>>
>>>> Only the chroot system call is relaxed with this no_new_privs check;=20
the
>>>> init_chroot() helper doesn't require such change.
>>>>
>>>> Allowing unprivileged users to use chroot(2) is one of the initial
>>>> objectives of no_new_privs:
>>>> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.ht=
ml
>>>> This patch is a follow-up of a previous one sent by Andy Lutomirski:=

>>>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4=
d.1327858005.git.luto@amacapital.net/
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
>>>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>> Link: https://lore.kernel.org/r/20210316203633.424794-2-mic@digikod.=
net
>>>> ---
>>>>
>>>> Changes since v4:
>>>> * Use READ_ONCE(current->fs->users) (found by Jann Horn).
>>>> * Remove ambiguous example in commit description.
>>>> * Add Reviewed-by Kees Cook.
>>>>
>>>> Changes since v3:
>>>> * Move the new permission checks to a dedicated helper
>>>>   current_chroot_allowed() to make the code easier to read and align=

>>>>   with user_path_at(), path_permission() and security_path_chroot()
>>>>   calls (suggested by Kees Cook).
>>>> * Remove now useless included file.
>>>> * Extend commit description.
>>>> * Rebase on v5.12-rc3 .
>>>>
>>>> Changes since v2:
>>>> * Replace path_is_under() check with current_chrooted() to gain the =
same
>>>>   protection as create_user_ns() (suggested by Jann Horn). See commi=
t
>>>>   3151527ee007 ("userns:  Don't allow creation if the user is chroot=
ed")
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
>>>> =20
>>>> +static inline int current_chroot_allowed(void)
>>>> +{
>>>> +	/*
>>>> +	 * Changing the root directory for the calling task (and its futur=
e
>>>> +	 * children) requires that this task has CAP_SYS_CHROOT in its
>>>> +	 * namespace, or be running with no_new_privs and not sharing its
>>>> +	 * fs_struct and not escaping its current root (cf. create_user_ns=
()).
>>>> +	 * As for seccomp, checking no_new_privs avoids scenarios where
>>>> +	 * unprivileged tasks can affect the behavior of privileged childr=
en.
>>>> +	 */
>>>> +	if (task_no_new_privs(current) && READ_ONCE(current->fs->users) =3D=
=3D=20
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
>>>> @@ -546,9 +564,10 @@ SYSCALL_DEFINE1(chroot, const char __user *, fi=
lename)
>>>>  	if (error)
>>>>  		goto dput_and_out;
>>>> =20
>>>> -	error =3D -EPERM;
>>>> -	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>>>> +	error =3D current_chroot_allowed();
>>>> +	if (error)
>>>>  		goto dput_and_out;
>>>> +
>>>>  	error =3D security_path_chroot(&path);
>>>>  	if (error)
>>>>  		goto dput_and_out;
>>>>

