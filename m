Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03014334945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 22:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhCJU7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 15:59:40 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:34630
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231221AbhCJU71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615409967; bh=HpDgp6rO8+BYmY8QNRx0Y1zETcKTSIcY9+YpO+fdU6U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=dThnHUtPjbPEASpRt05BbBiTHuDrj3N6OEta46YXMEI7YhnSk8hmoWo+iL4u1HpaIBLcMslOngJ6ynC+fPaDkNmsLTSIYLK8UmJDIk6Q4+qv4/or2fnLsLVbvdFB2ULI3WkmC2R+bYMAC894w/fDGyYEVWJ+944bAXRzUazWUtENE3jnx7V9M7TIhYK1VeB9C8WHVHC5enHYtzRRtIx5ctTtKfDuND6Q/RqSa9GpOotRS1BgJGWgQBj3EJzv9QxFmJUiQ1gL4Zvkf6Xu/gfwfuisYZfu3kfRzXnxK85xQxxz+bFLav/MElsx8C+0L+9O1XuihYRt2nM9waBk4ncwGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615409967; bh=YNkT0Jtm+bhOHuSwmpayVR2TLdsPPeaoc/cbccRU9ew=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=jNjrib61JWr57A8eVUKhJ+JrVLCk6HlTSo8dnkmjSL6pidx6eq6V9r6HkGF9mx+K8e6xlrkU6Ob8DspbGXuAquOyE1FbxMjp1ijtA4D4cJDIW3vgoO9aN+8wPyCBJ/HCk8AMyBgIk2LVfVpvuO2UgfLu+av4c0prlq1Pr5sh7B+pVJJA114phSo9EmRFzCT15tu2//d+ybo0HBaiMI0ci2OH2F1RaIFIvw38MWQEUHMaJi3CH6JrTiHEYf8Huy3vWPjDSYO5s2KPTdVmTkSpuYxzWOXacGTOX1ToaFQ6CZtb1Xm9soQgeKAxXjFBgA338nqINQxTAYp5gPrFALVWBA==
X-YMail-OSG: y1rHEZIVM1lO1ASo1fJyvfLm8dI5o.jq0c3OWp_DVhWAlxXwlztRN92Ym0Zt178
 WLS0QC4I292.4iEfWfxZdfDsketDw_9fAT7QPcVIyD3zH0LJBrvNtF5NOFPb7s257guTLEy.YG.O
 H4zQrc0.AcyelTtPiCXyK1W9pUaLVUgEzM51BiT3RDeCHXhhQBEkEII6ZNFVOieQtIJLpRd7S27V
 0UC9NG.7XFuOSePoJrVLk2915JbJ6MQHuz58InaZ43del7XEZzoZWD49jzrSp9cbkWcfkZLJU95A
 wXG1JBnwHR0dDUxqdZr_ps1XstIGyQJscr0uRTC8Z.fG1JcXgu14WlIO1dIdetR._noCZ_2TVE1b
 38tgPpHoc6zOfCaXrIuB2alE0D7PAiPkUHPfMiCJQTw6i_CSdLV6hpUnr6jC4hKWyJEQ2.8abFuc
 bxb3lZVV8p73ZRc7PQqWY1NJBZFEJnTvFY7MA2hBZqGFdfN3amN62_S5LV5oxDqAlELbRFcmerZS
 Av87sufvB3fNKHS23sN_Vk_N.j.tJeUQQIMTeRDm_1sou.KeaQ.aJnEZv.f7R2GLnzykQ4FHYOqq
 n6QzOtD.g5dxCT_lH17qXstO3jZDLkDnDXCAFC8EMQujQ5IQCltCVZWqnxsYMkJB4TyhEr02cDGS
 ii.N0u.2FgO7.myfrWR75k7ye5XMiRCpiukEidtUkCSLXnhLfjbE.8OhkryeHkpCLMrvM9XxvcJe
 DRkA0hKKZ16pU_6eKtMyOF41RYIVJIs8areS.kSda9iUnsscW_74dRRmmPUWepElwCDTswpmqMDa
 DGOw_HSg5XjPpqEUZBActtB1RCeqr9DsY72DXXXRwhnavMziQ5zcTwFNOXjRYkopILSU8FLbjV3o
 OxA8.Wvnkq5704FCOJXmm6fuaJ63_EDQ.b6OPFdB5kIrMgI0FajVZ_Ws9O1DaeqF.8kw0Q0gLECo
 Dm5p2FdxFWxWRJqaEgsjrG0n4YhBvLv3GnXmzQhRfzZvEsItQYcT9Ua_1tJZhtb2lk2p7YHqT6V8
 18NL9CtQBw3Erwemmb4R9zs6hQ1aSzfmjCa8rASp_byjnZFy9jjVIwyeY1T_RYLaDqAIDGMMGJ8h
 iPOWXpKfKscHk68smMYXybo2c2yIRBL7Z.NI1aD44FoZ.sEFXrW3Wk10W5xZoojrsIPs6NtPyu8Z
 wtH1.5M3LY1T6Ho2PZC1kPt1yNph3NyT64BDmHnhXL4U0FFOg_UJborTYel0ftzhXNRVsLGEMMID
 mecZK.3wOiuC0olPtGwIOt_7wek17i8Xnm80CKG7W4xQLcJG0PY_erL2fDL6veLm.IWrh0LOTQTq
 06SqocGko3wW1YFaKCxAm5Bj22J2O2i8_jAz6KIFsvUkpkqwgFqb7olUu6LaHHBfQnpxZT9er5P4
 0yGDl9LRrMN.hKqTi19p_kqT5oHocU1chCo5r.d1LFY8zAnDUbr4U8ADVfRLbQYi_w4sdUtLAyLu
 pa3.xRqjslNv.cH68._IoVPQ2SDroCsjdyRD.XHqsX5Xb7ZZE4wXwKLIwrDROjoi753tsCoU1H3k
 zlxs8EdDrqb4oi8TzQqQR.RBzHoLbtnvzmMWQLwr2mSqeN1y3_SyJ89m6lD0vsgRLavl6WZ8mu6W
 zYr6zsQ63uaOFntx3HZnJR2yl7pl3IWlD3Zt1In3yGBeY1ORzOGMZ89N0cAQLEciQUO_P1LV2R94
 OUopgsIQexwCt.f3Qh73eUXXz9CIDibpO7_6_pypqcLC_3cJGrycIKgazWmQIiRv_UvnUre9Z6vc
 Fvrfb06PWAb6sAXcpc0.KxkpTGbWJKMgvqIOZrcgmLU2F_iPxuE81nB8rtEc2wQ6_h_P.bOc_62B
 2qxlQo2pzQeHEdwFOTQsjC7TA4fAHi6XFzf9oMr6yb6KYViaBxprx27i0Fs6_lPObHyJfJwc8NdD
 6fRetpGGwY.GaRpaP9VIR7FwfGt2AZxrZo9x9Q2XUOecab0eC22AgXXNYNHhcMvUrfw.rfZb4Bk9
 wDKwbg5li_IT84n.bZi3SGRnwfmDcckyyqs_FOAH8772AIi01fSfyF0DL9svKklpFsGxX8Luw6Pw
 x6hgkDVPwEdNMFRfdHhx1YBBEN09HhsjA7qmLx.XTXwDsYCbrQamRYgrQOhbQLbBjq_Ltgwgbdy7
 rKzdCLiHkTLv82318PU35Y7jPY6H0pFTVuM12PqkPDohtyTS.rhE2mQ28tIrim0FCS4BWsiABUiT
 xfhGgpNw3OkGNBMKpuPQsAnspnurxtDxAA0DxhI_Rz16al4YOV8JHoinBBantjeVnIuwUGaVYXuu
 0xbyqVvNuODJ_1y.qxUEVhe10Y00j85zTVH1JI6F9i1fzMR0kee7hSTClA9OzhiHIEOpBa8BK.gL
 AoJfJBMcQVcE0uOSwBa5vWE9DvO0mWdyxI7CaBCOSyKi.4fLRQcr599CpVyZ5Fk1hTWrAzXuih5d
 A6Cjn2fsIwY3i.nbk4L0zeUaZFuYcYTGkoOZ0IVNXmE6OLMPdc7lGlYtF5jWw5ksv0uQiBVnl4Br
 hHMxPfrVzBCW5kfK527adpFO2EvC9AgPF2X714WVkdhfCmuyepCtDFS48X0XhP1ZcfUHobm.B1pO
 FXLCAN4BCZWFWgKjiYU848yrzh59V5Hb_i2q1wSJfvR5Mu3pmGt6rtQbQieLo5U67YTedNsvyU7v
 eoQdu4euVM7Knf_wiEkS0on7sDoTbp1vfQ7QC1AAjcnHSM5D_9WFnXkFkgHzf53XVvxakSsOH2kw
 tDhfqbx0qyn3Z0SQzvK..NGgAWvDxz4_8aifUK03V0S0p2ngCNivm6m0HzpUG5Jl8Wenz6BvM492
 glJQVyQSfSfZpbRmQiR8Oixi2emRoctfc7Qk7D5TE9m9WH4FrEz1gU96EeTQrwkiUNh.YIkjA2xF
 7OvThYq4xAo82Stdr2N0TY2YOQHoXsoA.GVtPjIbS_z2n_SylwRsNwMF7jGvVRxg8tI.RCBs4T7v
 O0dvpxLu734uxx6_e3iFZPcZcoITYKNtmtBctaWRdqCgS9NWVjlByF70ZwQZxk06bH_x4s0emTIx
 iJxoFoQejHQkPJLa4Y4POWvZ2ytp6v9JgNFkwGjPRndto1PyiRviuRXq3yrax28cl3wEEZNV.Hd_
 2XNKBkjj.F21ygbZTktuMxAD__5GTRp2GEoJoFVceY6uY6QXX0VvbR5l9o92klZG3T6C8zzNqo0H
 KR53nx9TjoUU30M9qi3PPhcRVmD3i5YWC0_BlIvfM8TdqRv_IH8L2mxTVDK0LdY.6KpK7GhtV7Ss
 ihUN5LmXnPaPgdz5d93F4V.WADtTctl_eTz3M_ojI7cBw9JahVOW3FZVkKKzXEPuICvcyckDxeIV
 EVXM_wDWVdpWOa3lyfJrsK..rMbZKNgB1.GrhcgL1gOsSiXSm26aiQDoqSQdYKyD.Dk_U1gXNcMn
 9u_9BbTbc7ZEW7lqeeXLwtwGSAXZyRJCWAGO2sYuSIyCQBEy.9Yw1lYnTCb89z8gaUaMC72F6Vvb
 a9GcXfMdhTqbVje0aK0GBwG70GN9VuaviujV8KEf9.h16gGHBngo1wK9Xau83JC1qy3D6geU8zU.
 0i7dHDcedr_3JPU3sTXx.4tudDChAlb1U7Ayz8sCAKfSkgJNdTDZSKieZ7UFolECelmITQ0JOvRr
 2LCvFwdb_fMTNZYRVnpNk14ve__Swi_n3a8bGIJR8evYATvNCMI6VGUWOOZ7ZpUEFGR0KCCjaB44
 duS1sZ3d6eMDe4WRfcKaxUIGX_BGxF.cbICTGixpWEFHyLY1rgqW1BBjZFALvWcJUVtMetJZyua8
 JOGjkEJZG
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Mar 2021 20:59:27 +0000
Received: by kubenode571.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d4f7d60fe07ce389a303c1395a2a05f9;
          Wed, 10 Mar 2021 20:59:23 +0000 (UTC)
Subject: Re: [PATCH v1 0/1] Unprivileged chroot
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biederman <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210310161000.382796-1-mic@digikod.net>
 <4b9a1bb3-94f0-72af-f8f6-27f1ca2b43a2@schaufler-ca.com>
 <e0b03cf2-8e37-6a41-5132-b74566a8f269@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0dfd4306-8e7c-239b-2829-d4103395ea44@schaufler-ca.com>
Date:   Wed, 10 Mar 2021 12:59:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <e0b03cf2-8e37-6a41-5132-b74566a8f269@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17872 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/2021 10:17 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> On 10/03/2021 18:22, Casey Schaufler wrote:
>> On 3/10/2021 8:09 AM, Micka=C3=ABl Sala=C3=BCn wrote:
>>> Hi,
>>>
>>> The chroot system call is currently limited to be used by processes w=
ith
>>> the CAP_SYS_CHROOT capability.  This protects against malicious
>>> procesess willing to trick SUID-like binaries.  The following patch
>>> allows unprivileged users to safely use chroot(2).
>> Mount namespaces have pretty well obsoleted chroot(). CAP_SYS_CHROOT i=
s
>> one of the few fine grained capabilities. We're still finding edge cas=
es
>> (e.g. ptrace) where no_new_privs is imperfect. I doesn't seem that the=
re
>> is a compelling reason to remove the privilege requirement on chroot()=
=2E
> What is the link between chroot and ptrace?

The possibility of sophisticated interactions with no_new_privs.

> What is interesting with CAP_SYS_CHROOT?

CAP_SYS_CHROOT is specific to chroot. It doesn't give you privilege
beyond what you expect, unlike CAP_CHOWN or CAP_SYS_ADMIN. Making chroot
unprivileged is silly when it's possibly the best example of how the
capability mechanism is supposed to work.

>
>>> This patch is a follow-up of a previous one sent by Andy Lutomirski s=
ome
>>> time ago:
>>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d=
=2E1327858005.git.luto@amacapital.net/
>>>
>>> This patch can be applied on top of v5.12-rc2 .  I would really
>>> appreciate constructive reviews.
>>>
>>> Regards,
>>>
>>> Micka=C3=ABl Sala=C3=BCn (1):
>>>   fs: Allow no_new_privs tasks to call chroot(2)
>>>
>>>  fs/open.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++-=
--
>>>  1 file changed, 61 insertions(+), 3 deletions(-)
>>>
>>>
>>> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15

