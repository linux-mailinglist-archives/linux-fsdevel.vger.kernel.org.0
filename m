Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEA535A441
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhDIRBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 13:01:02 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:46012
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234142AbhDIRBB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617987648; bh=Hhy+oPENli+r0gy3t8YfKEFpJK30u1VunfMLKh1zTzU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=DyTO3xqF1XEWFveTZGX0y/3S5NM4vYHTTpiIKHyb2sSiBzhT2xW760b2z4z0D9Z1hy0+O1FcY66vsBGesCTMvzRRWBvn6yPwHLCkB+Ri7OAJygUPiWxtyDa3pYvsl43G7B97bfuuWXGv9s5xFTbGFVn2drDcm9Riszi11rhkIHlufR1Tyui4fy06aw/ZmmvW2cA2z5RSKHFubir2X6XkRRY1CJ4ArYuZn5uwxsuhiOB8s7XoDLegrxBwqlK+NSpuBLECwNigLKqg6xR+nbn0Tz/dG9dBV93OCQCMo4aUlJ8DGh+iCz3MBE4ZLqAGby3qaAqDaDesu8BRtGL3frUR6w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617987648; bh=cf9IUIiCS9wlIfFuAzgsfTp4RpY4yRL4QF1whhSNdzH=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=t1UoVmG6O0m9pzXW1+h3ydGIvBIwJS0FW00UNvNxv26VQf8mRtFhxwZDC/KrgjIb1fYi3zwVQanAT8BGWbKz8H+3zcSmVRxiuz8mIoYMQKXdM698uEQNDxfQbkPH2UD+22ulxymVnmZr7fxhNCxplB9YglKm1D0yBoigz3E72K5ZC4MfKWcJEwGrbdDIhD+i2WFsdwbban6CGAhafjaZQensVR3TqYnkYaZZKUyYff3+N2tNh3Z4ps+v9OF2BzH4SBwXpYzlGSmJ8KDuuKgfzS82kaM7Lhsw3XxFBNr2jSJz8cF5+m79S6IaeNmvuWnbyQpM+3qnXQW4vpql4ArRCA==
X-YMail-OSG: loRFvtgVM1naJYe1tDFbhQSD7eahcl1F1rc2tcV2cb9CdOD5mOSLUwrFRr_hkFR
 sIe512dTLOXwGHviiZHB9P5lMgTa9DsNUSY8X6cn1xVhV0sUnasRvv6KDUoIZNOh0zDLCEskKtYV
 ijfJ27FR5PRIW4vfRraY_vCemgV_Hix9xh68laC7XA3cHFGKdDNbh9StHMSuRHR8ub8Ptf2acJKa
 _s.DQ_JWzUvddnZW6NT.RMag.W_L81kW4aWPfhZ2ewKV_YvrDtV6WRNrZbWTqCbwkCBaSfw1En.9
 3snLWvnzSW13ti_m0t7fMf4WBzT.wKT13Phd2wo6enkkAnIq86a.WHY8fEH8nstj3KdSp9RG4xNn
 XmCGeFjvGhkTW42qZKHK_0cel2_SUlKUhTh8LiMKCsfZI65GSaBbyBHu2il0skMA0JoSjrgAX_gh
 Tce1W_qqdiZMw4WsqKCgAvWs.BoyC61JSyJ_uWm4N_MfxCq3AKbDKzkaVDX_mniVm6o521KKaoDU
 rILkQPC2oQv4rcqMnhOFuWaKZhxWrsny0KjG9dkXpXKj7N3mKjwYwxI4rreK2joXwrNU08UhancM
 HMF_kK9m1ZRQg6UAkL_OdN2DieXnkbG5MPltvwgOuHFIaAcP7JHvfT7_sqAt0oJECf5hVioYoaY0
 4TRkSndqPONygu01726J6jF9O9U5Os.IwzFOl4c1tjQzerYkRNWKtRunGTh9HyAxFBeS27wdyXjU
 In9QWUFgpz5eghCF9s0ax5Cz26t9pLQbf_VrOuEsjEK8aX8IBlHDwYXL1oD9xmqJm3_LsN.lcKbL
 LFjfZ69mcJSZ1Ig3OC5eB9qQMjhXbfgxjruWeE3mvQaMDgS6TmfTLilUids8gVwaCxSNz7diD8Rw
 9qpOMou_W24jfqD3HH73mXv2agd8EhvYjPVXa.bdDZcj2gaAbAVUrhRWqx5Fo.aVnMM6Mj_enXXb
 ox9UjKO24sVmxNgKepc9z5ED.2kd6Lkel8iUK5SxJB6yk2TxthhUBONRPbwfScg.Nwxr6LhIwp0a
 GT_fZB0R0MGkQF0auakO6ua7b5.GeP5HQW2F_DfcQcYbSKajq6Gry9eZj2b1adMwQONfBWWWpvvl
 Zf5PwmHB9C7SYeiam6sa0Y3crhtUeznGywrHn6lTW.kCMbmsvmNkdSCWcrX5nc21hEeZptnvevvn
 LjqADRhYSBjcwA6.5fQN4CML8lhJaaboLmdJrrKP5dGwQoDfrcpPDN0OKJbEk5q5k2T3Oihyd.e3
 gEY_Gdlj.WW80pFi5CSoAORH1zivc49tfFuUPfkm8Go_mtkyZ9DgO_JZUipgM5JkiqGQSDmU46ZS
 PFJzLAe0pM.T20kYmW0bzG4ixprUUQkljlaHpzHJWJyNTLUQ0wefNf0s0GPY_L.F7YlbALYq369M
 9Z7KVxR3NumbMyNMAo00I2YBU7chdA0nU7TIJyALTZYXrV7dHGKRagx7UuhaFj4j8xaFni67lOXj
 8LrpnEIvlIsM9uRDzErY04ofrs3yejVoKG_dmO_oI.Fs8Zrii1MK.JjRxPClyd9xAX48pJjJDJWj
 ozlvp6TfViSNnsZmdXRzvFG61sRk9I2szP9BKdxQRDWEjdSMu1yHN2XHUCLfqHU2Rj18pWfsVYhA
 fL.9KAYnEhhk4UQkddmBx9PaHDj6bUIqoZabo06EsB2KXwyjbe5MhTpLN02bDljMoMIZmDcnHCep
 Foi_idC8vEnk8MRlW7_wyAft4H2sdRnnwsKpt.UZYinNieUMkAbFEFn3apVyJpi0y4L2MizFYo40
 awBVSPKD7tX62.IMjC59Sz9B5lEtt32x5jF1fPQQGJFxOcddHRolDgohs.mh.ScfuAXlP39wQL2Z
 Z6bErJzR9n8T5QOhrAbPiiZxFhdva4E50L.GaPMMKGE5j8wNsKu4spdL9r6HUGddAenbKDjv5iIW
 YIMz0gWtMMr8kKkEbzR5mKapLAh10P.3aTHnz6S2hqJooKZ_Ukf35h1uza.CuIz7Q62WzRUPY_k7
 IgpMBnGSpgiiq_N13wCfHSWt.7THXMOu_rORg2q7P.BH7FTJ5wFaKFVSb3iFrju4IcC9QTrAmFnJ
 U..EotjZJkw2_mC0EPWD7_7M9AEXBooclrcMF9e7zBzCmN9LiHUbP..29lCZGDpmkIzFFE8LK_PP
 ynUZ.kpt8n1rQMArJdGlhoQzaSjA9273aM3UlddWzZ4BDHTGKWCY_3twUJ6kF1jClw1cHDwBC1cC
 PUlXbH13U7ZMhuGNjAs31FmkV1QaC4wfqnCZ.nqq1yX8FjbFk4iV6dOM6uooNzyF6oD3q2Sa9.3S
 QegFKIV3WnBojBTCF6vOEAczxEZxeKZdYTqGPlo2XT24nj4trH3MtfxUVD0rnP2h6TTGtfyb2H8n
 ova11PY8CztLyVPFf6NXVWtX7NkgDN5UFA1mQPCFceWLxctDmX7L5KSEc79XVw06VOgxIQeJpyh1
 fJzEI7oTgJeO6WoXnQeUrvXmYM1AiREkx1IeWSxWQPFuUM4Tztf5ZxmAXqyZJbyxcUQ71gbRbkvo
 aemKouIHvCV_jNVuIy5NRoHfiFYZxGpO3wz288ier6QtS0FnUuVLGyGYzjGL7EAtlGNoblUrMm6r
 bujQgGrTGfQs9GkVEXIUh0PxmFySQS1NuexbkpD8kv4u7l7YdPXAC2FnO4xMQOQKC2M32VOc7Mvk
 GJS5nHRcnrNoFqnNSKeiimtxn6zw1AHcJV.uMnhrFjJk6liSlBZymCFU4ZBpqCHlZQRFMrA6ea8O
 B1PiGFZF7X7zV3Gtg5ohc85BWPC2kGeZC15jaIf.rdlQn83srVvv4umd4IQsNcpzAbaXUqJZwqCF
 Qq8VF4sslCZM1JLcGxbv67EXmSlh2u7Sjc96LJC6WbGLX5meiWw4t2CwzuEFfH9VH8wmzXD7fcog
 .MvFZHh5c32DPKuLYh.6Pzn6EBTLwphz99MQEfa4h1E1aewSaVeyAr3cWjOiZ1hSLQhzc_9ihqCl
 V6floztIzSytOlarlPyqQhG4ABUOShrJrG0bgmELNH_Z9QjPZFIafFU6FqDPMpCZyHGf3djg_DDQ
 h6EvQoxLZClKZbD6l9lMrOygQ3xu0GZzcGs749Q3grDA62ebFvSuaYkm4IQyhBaxe1rE6HOwXjDG
 N7gvaNsqPRLKJqWQ8YsH02UG5.HXDjptebhPvKNptu65jlipdpotbHbL_4NCmOlFwfAVX4gWCsat
 dMml2Uih6A_uquqoZ_2TsgQMAun5E8Copv.kYKNZTxJqbk_YEuF8FYRanjawvmEzKzxkmu6M3Xd8
 6uws0gJLD3DHoYlMFpGWhBq0TbiLLzPrcJDd8xxo_b4rntSCmvII7TnMbheJlJ0JIAQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 9 Apr 2021 17:00:48 +0000
Received: by kubenode556.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 12551c7b4e7a9e6eec96764a69fcfe6c;
          Fri, 09 Apr 2021 17:00:45 +0000 (UTC)
Subject: Re: [PATCH 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option
 handling
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210409111254.271800-1-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <53c532c8-fecf-ff13-ac82-7755f11a087d@schaufler-ca.com>
Date:   Fri, 9 Apr 2021 10:00:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210409111254.271800-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18121 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/9/2021 4:12 AM, Ondrej Mosnacek wrote:
> This series attempts to clean up part of the mess that has grown around=

> the LSM mount option handling across different subsystems.
>
> The original motivation was to fix a NFS+SELinux bug that I found while=

> trying to get the NFS part of the selinux-testsuite [1] to work, which
> is fixed by patch 2.
>
> The first patch paves the way for the second one by eliminating the
> special case workaround in selinux_set_mnt_opts(), while also
> simplifying BTRFS's LSM mount option handling.
>
> I tested the patches by running the NFS part of the SELinux testsuite
> (which is now fully passing). I also added the pending patch for
> broken BTRFS LSM options support with fsconfig(2) [2] and ran the
> proposed BTRFS SELinux tests for selinux-testsuite [3] (still passing
> with all patches).

The Smack testsuite can be found at:
	https://github.com/smack-team/smack-testsuite.git

It might provide another layer of confidence.

>
> [1] https://github.com/SELinuxProject/selinux-testsuite/
> [2] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.=
org/T/
> [3] https://lore.kernel.org/selinux/20201103110121.53919-2-richard_c_ha=
ines@btinternet.com/
>     ^^ the original patch no longer applies - a rebased version is here=
:
>     https://github.com/WOnder93/selinux-testsuite/commit/212e76b5bd0775=
c7507c1996bd172de3bcbff139.patch
>
> Ondrej Mosnacek (2):
>   vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
>   selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount=

>
>  fs/btrfs/super.c         | 35 ++++++-----------------------------
>  fs/nfs/fs_context.c      |  6 ++++--
>  fs/super.c               | 10 ++++++----
>  include/linux/fs.h       |  3 ++-
>  security/selinux/hooks.c | 32 +++++++++++++++++---------------
>  5 files changed, 35 insertions(+), 51 deletions(-)
>

