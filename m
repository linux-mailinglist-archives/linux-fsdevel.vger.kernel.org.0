Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765CB33450D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhCJRWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 12:22:35 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:34154
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233340AbhCJRWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615396939; bh=+Loh3xxfpBT+y85qqEDSrP4zjimJVjMXFRqS42pGqPA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=E1wuzBEL1TaCpKSgsSQYwyLYOi5WKKtVGIOdOggoA0KvYde8HV30uI6zVHGIZkZNCuAGZcpfSYQoBGP99LjwBtS0hhZaAxHNi+SkxoduTJw4EmsmH9NL8ZTNDhFk1lddM0QBMJValK+sya9pz4Dw05EdEz2uaq5lMXn2RPWSUbIh0ZbnNK2WKaeshokDXboBd/WnAl65eccYQc94iHWaPUtO3e5558xR84tUxG2Dlj+1RCxI44kndrbNTsVm7Oc7e9DXyFhec52/oELtHhzaAv3jrcDLNkYaYSCn6NfKcKHG6JVOb2z+tSwDrIOnY8SEihWXOFhb4sAhFRdbUAtlCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615396939; bh=nS5FRGVz2OlUxHs1IwfkQz36GQMYV+kUKMI0S9ZJcp8=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=AWLxzpiDkcZqlz3dIDRVdSGP22Vu7mUupVBFiJpzD2t/Yu7M/LSNdAK/nTvo3Im7ZO11F8Gs/8QyJJXE94XNea0b0Vr/AEc6DQGigFwfpAgVkW1pm+flDfuoyKBZjJbRydcke0EMCao5etaXfLrPbmYjKIoOXavZIdGiCwNEJd7Ad4Qh9KnEO+Q9bDIQMUtZCIblMrLBjCRultD14NEU8U7qvwNTgoj/8eHjeldm7wlnJn/UgrfuxrHgTBQ8Y1H+cTt+Bql2EkCyPrQZGQgogImiYUPZL6WRl3G0hkZttwI8T7vtCVHqIAAwNh3in4ri7sWQUfmo91ujzJ5mZM9Cew==
X-YMail-OSG: CfWGai0VM1mtPjmFrgEwIwzHuJ79d_iisi9mPSWcff6xtOiQD4KiZHtLzB5n9py
 CfFmYdZ4nkjB9tgAKtUK3MUiOHeA9M2kUfXKYPw1pvGAZycnzuHnERgHlcaaLvmcflUSmSUlV7d3
 fkShnhZi3FWXx8hdFiNgrOprzOzc9WJOQOCCUrWn.asLAA.KQiUKwLkZF.t0Bvg37lAaf0P0d1nL
 nxH4gIMzT_34uLxo3yEg.JEDLzZoroDcWJHgehPhXN03BdGSaFRElPXjlggG7sKEYHuVbwRzah_I
 YU4EhIYcvLFLWlgzdcQBNzI_v9YbJHqaRUpJ8DVE2MAG1Jq0JSua9wZkFA4ilqagSVW.klhW4sbM
 6LDAGCIdj0feyi_IUkhzmMP0fhbmMncI0RPMYc9vJ104qpauSXfTPD0GkrziAbBODVypV_Kg0269
 QwQNxCKa32DHkcsFbP4xixJ.KKXQteWnfPdTTEi_rbeMUlQ_vIV3QAUzEQi6N__dEl8FIK7dqztT
 l78MnQOkZWuC.Z3uqloeVMjB7Zkb0IjRTv6Ql1wN0pfOrMDnLFgs6mF_x5OnYWzTWyxd6l97aq3.
 8eh_XOSxei5VAhPRC0a7lEUFW6tNBk93jZJp8.PpxwHOE6UW22PIYCqXyac_G5aKgnTvmAjGLkzi
 aR7Ei7sZF5OlMa.Y2pePgRXelPa8kD8zRjdlUZjYSxD52DbEByQfVV3Zvqx31QO1pmRllPK1u4nW
 sq1BF1wDk7lDMt9LpH69VtbFqL3bGkTyFb75KqBlyjRn8L9GA2jYrZZ5HCLkWjMbjBxH7oH2sHmR
 3u7.rZZ.EYBeY6soYoi8eLSaT4z246OjpMU3nBY4Z9Dvz5c6Dw8qnBRPJXjmwLsdJa5urYMTf6eR
 Es9Fty6XnMp3nymmqoNJaC8Rlo_T68r7b8e_Hu3Yofjgd6fOBtcXhqPgQuFNrL9wi_LU6C7XaaoW
 XkpSidGu6rstJCnoq4btSqquF4XOhW2logrgMKhFLSNymFOdUBUdhYG5S51J.rzo3UKmyCAk5oBf
 tENsHhM7F0P9JQEqP6zsQhCp9_AyZd9jJoTl9d5J1mRdPRxHoPkcG2E1S_oQQkMbPIbc51r4yERF
 wxk3rHSig_q7VvX5RZcdJ2U0PWmJqQ_F4yPmGfdLJMn_kvrkFgpnTvwRoW1teRHQ3NDcYEYKFJ1G
 5DrMrUV9rLs87xs3g5GOs2siUkVeYS4E35EzEEHLQvcYVrQ.n6lX8BEp64kfbqDAzLYVF89ooA0f
 kg7KKhzGQmuw7.6leLyR7VIfQVuC92_APUPUL0M3NVRxdHK74UNdLcVp8S.oe4g8vUIGRX9Wh5QA
 bpvwgZqny5P800X_vzsUtthHkf8VTG5EShvoEJWzzYOYQqxwOb8ejIFNEe2qpm34j_iWu_8FQ28R
 wSopbdqoW84ZFJej84oAVAyxMYB.mcH5qaqNprXDxYdUX_ECOQwues8fzOqo4vCv6kFdYZbQH79E
 Nn3xJ2oDG2x7Zy787zOdO5FdIpbYMrYsJLp4Tc5QNuvTuTNNLhOiiSfUFrD.9Au277ze6XjmwCFs
 Msf.sIC.SzWuv40uuGRPDqXg1NGWdGYWYcbahnC_iftXlhlrU1ho0OL5k3gVnB_i.IfJkdqRSdM6
 jhlTIrdoFo0pjfU1bkc3TuhOx8cBEpHUTIVzp5mKZvjeQydQlSPsuY48uM.2OpT.4S_1Ip77RN4G
 2oDHOC_pBYL4m6IBr20r56k9nhfdlgSK_jhttIuQnBR1Fbz8e0Sj2hg0SM6vwJ88hihwsOGDJlrf
 I2h7mdpT2n44OQ8x35PeDTGqrctVx0_5rpIPAKP2ij08koFdKtXMn8pgqHrt0l1kZ7vCU8BqO2m5
 ESmeynm5_OV_Rq2YF2FmTScCYGtO4Bn6jiDwt4S1wgIJFHpXka7gbS8EsYL6Jbgt5E_7FuquonS_
 h0ET2Z4GlZAS6Z5pxLu92Mm5V811ZQkEEx8rgODFBWbRtWfrf8wCfxB7y7_3ZKW5Viyk5vwUH_Ri
 2KX5eKG63QtmogiEo49oxLGgr6TQXJine40afCca7OJ6toCwpg51ocvKfnBkIAdcQcAK9agz27OQ
 ycLeId2uXepIHqdVr.3tVmqvqkJaIXActKPjtzv5RjihZmCjom17P7xGTRO6_oZ3afgucZSmqS.w
 0DjbNYcSbO66EUaBiJ8LqjCFIS6IsN.UWmh_JJjVkzKGNoUyEWkqjJ.7_lDrHoT8TOAZd8uEKxE3
 rtWjrovBXEkhrTGM1nS4q9uSKQ73LllZ8JAO6YbTDAJCjRroJfVAoxMVusm3GxjCa4oMjzQgzGjs
 E2lCcqyx4ZNlml6k.yDrYCzHSY6KH6CIapdMSHof7tTMtNEr8toPjKChBBvzPmgpukMn7xL_ftbd
 BWSvNfaeAmkSf34P4Pxt8CEBzD_ZqTiEwli5pqpNKAxXvCkrXw6bHufu0rhSiZjIAtCFjhKEclqX
 xt8SZhYyCCoqi6bOrioPhBMzfWRacffn7MfJZahwb7ueIsX3uvYtxx6ku69rKB0aFm.DY227hzLZ
 ZRMN.IKLEaOcDweb_.MsxipKLQYrT96xqJGp5aAiwfOKxJu7v.nxJmDPQRAmBjjY_HwmyywAAXJG
 ReL_qZ4cYzGDOqkd__At30C6c.T8bMYARaoXi4zZAo6Nea.5oTRkkIhW0dwnSil_dXtfadSIjovN
 WTTywGQobWLB19uhWulbTIQrRGk5VkUcpBJkv0N7GjBe1MnTY0mcP8yiWqpo27iytWfcn6xoZLE6
 cRq70XDl0iXT_o_1NZ.5ksvrdnCSg0Zx8NX3LFJEZoOrCQxdJGSbk8CCOyKLkbl4I3tsD2arNegd
 yAbijbvWkDSBTvt.CFAuZV9ZxUXiJqsSMIIZXZeg0RUglpaX1hQdD3J8xa.OKtaWvsC2K6IbAY61
 heS.diDVBxjcTMieu03IKZxF4RjDc68EQMU6XRBejw6Y8dvG.BrABUO_YIT4WckUGtnPBhbpFhmj
 CJpiB7Q12MNbVGR7.X.yKYq2jpbKUhw2LTeUnbPOZlHFX5qJDdUj3AKLV7ztY0YBB6ci3Fujv5qH
 NBHRybnjvpVOBnAy2hvgjQlYg9.pAbSv7dpuKfoXzMVj.yuN.i_vQKlp2qtLP67eq4TYqCe2UCTT
 kjYYa9gYImfwuZOy21Ni.1u47UGpyP6oWvTFy8sMydCiOZJEFiyY0iyuIT99hDfu.0doc4zaKobl
 2AOJ_3NXQhSXzoj301pMaWSlu_yQq9o5yWM0P5LIUtHGnRntr4lrJGspRdWKyPl6UCxhnRY8yc7S
 TnZZc_DysyxICw61I1Y8nf3uFroPW4RROlj7wkJ_Vx5sAj7fbd5F7tBopD1DVPyeCDNPR7sqII.K
 D1ydgXWlQtR4SSNuC76U42L1i9vASPL753Xy7fbA9Tbd0ZFzy87_W.LS.3WFBcVFrvDODMf.cpEs
 nMVGJGqjWSnegYx8UXwMpk5jHKKVP6Lz8X8NVv8gCmY6FR1jSuanGRCEbcFuhHgPzMkjoEpky0H4
 bXKGVx6jXutfa8gx3dOTWmApPxC33Dm0zf7Iw647tzL2n74Kio_QwIjJ6DxjAgumBzmZ4PjOV22T
 GS5uCpAfQ9yc2bdX2K57H3LOaLANgMYCx5YjPmtB5xQSzt1h.Yc6gxt7ZSU3MKmEgc1dxDuPNPat
 RUuoOVrUM3mzVU.ACmciUAn8imK5cE2kYiflUEK5PF8WwGtS9Qu7wMX7kbxs.4PENZbd74LuwnWA
 5_fFebpt28o9J.jPPNT9iUACmyXTY_dMXOdoR3PwPQzHNFFezkjpoPcSF3zTXoNPZOlVw2cU1sdv
 mJ6mC.g1S
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Mar 2021 17:22:19 +0000
Received: by kubenode539.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ba9bffa2d7f179da830e683e77ac8886;
          Wed, 10 Mar 2021 17:22:18 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4b9a1bb3-94f0-72af-f8f6-27f1ca2b43a2@schaufler-ca.com>
Date:   Wed, 10 Mar 2021 09:22:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310161000.382796-1-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17872 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/2021 8:09 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> Hi,
>
> The chroot system call is currently limited to be used by processes wit=
h
> the CAP_SYS_CHROOT capability.  This protects against malicious
> procesess willing to trick SUID-like binaries.  The following patch
> allows unprivileged users to safely use chroot(2).

Mount namespaces have pretty well obsoleted chroot(). CAP_SYS_CHROOT is
one of the few fine grained capabilities. We're still finding edge cases
(e.g. ptrace) where no_new_privs is imperfect. I doesn't seem that there
is a compelling reason to remove the privilege requirement on chroot().

>
> This patch is a follow-up of a previous one sent by Andy Lutomirski som=
e
> time ago:
> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1=
327858005.git.luto@amacapital.net/
>
> This patch can be applied on top of v5.12-rc2 .  I would really
> appreciate constructive reviews.
>
> Regards,
>
> Micka=C3=ABl Sala=C3=BCn (1):
>   fs: Allow no_new_privs tasks to call chroot(2)
>
>  fs/open.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++---=

>  1 file changed, 61 insertions(+), 3 deletions(-)
>
>
> base-commit: a38fd8748464831584a19438cbb3082b5a2dab15

