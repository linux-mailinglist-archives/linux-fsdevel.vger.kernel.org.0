Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958B5310E7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhBEPi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 10:38:27 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:46649
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233260AbhBEPf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612545422; bh=LGQ2+Oq5r94j/3FnA4uP6fw1KLX7JE1Bzu43eSjT32U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=JQwgIIVSfJ/RxfDuueFn8U5oFm1PdjJJ95+ou7tInOTBy0cwuLvM0yCRC+ih5SsnJjwZChAk6UphG9dRBI1VGmqulbYfjN1kVKGgjaZoPaHo4bJ/FMSWAJjKYOjX58bUt8+iDJGy/h8kJFUzza8SghZCCppHJ1fdWQSzluSBoE6X9vI8LlVg0mZUTMGAPNTUxqg8ADLuzoSYR381Tx8odZ1zB2dcHmZRAc5e7hHhPAkCsUrAt4g369XvuAaaXVLj09OCsyAEpOkfLZnKVlaIGanC2hICVFcs3Rc7iHpkJJM8Dvow8vnQ0onZi2Fv19QGOfodWisIdJh4MZ4FJ4TiVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612545422; bh=bQdEPtYVTEV0BSM4Mv4it+iFySVlyOxgkPJpOGSkSxs=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=twnam1awzaetkCdnQZgSd5RHRUus7ZGic7KaVakcKpAulCm/9DVwG1Urd7g4NR6G1PvqNvApNuO992y6mrOjighG13EmIU4mSHWAKSIW/0mVa+kQMH4WbXmfleK8pAOOJ5IzVxlw6M6IoLEPcA2TxRqIGUSrhMYCCI1R4q2CHjKw2kdKPJZ3gHiINV/i4W5R/NnRvCOzpCzAsXJUo/8qcSwGJ3/FnbormekeIuCU3AfUUHksv2komGEwli4qSMUY1cm7qFJ4xKjV22pJxqMtj4+cq0/CL5Njy9Ylx5XEgeKUqWQZDtJgbaaVzeSzv2pE/Vyfrqx32CCuiT9YRHUTNg==
X-YMail-OSG: 4vk6bXoVM1neecdW7wnU5zezuyUc1WRLeXhj8yQJQhIu2KtYXYd28tosTbxPxcR
 UrgCw4yaZH5U2lQXeyB9yBAIy0rwxN.rJT7pbFlH_AtqnBxj5cnG.H9NPOSFe2OYuI09WiNvdbs2
 V6ZsZxSe3NZzYQRE7aW.q6amUOkLgLhxcE_N.xJeCoCw5THeoyAbRpRfhoKFsgQ0f_S_zuCP9pDI
 iv6SkEhIIox2X22.afQptbIGBFMhynIZszfNjOEp4CPeD2QNd..SisHA6FZhKn4DFjwxKWNpuVDZ
 kWp72CtdaPSsz.yy60I3Q7PjqASg88FlCVRugf6EIWFMfjX2svZD99rHJXWA76xvhClPoJ4h8jzs
 VbGg9sZe1veNCX2IseMxYvjPG7TS3iAlyFGNJDyZDS2ROlmXKJseGrEmJLhHdK_f1wyNhWYenTFL
 p.vEWU0FCkk485OYQkxSsIySjwJX3HziHXBljQ67Da8Go2VDDbuaTLqDYoeNKozFXtDebTutEuKS
 m4R6sugwHTlIHmNHLMUEB4MukcGtof6AJxK6hVFrY2_Z_usb.vKDoGspF.miOiXIkkpyKF.VW_lb
 HFQgz10VobTqp67nFY7ziF6wqrpnlfnTjDCaoxZMEvPEIvByqPYn1Js8OqcEyszo5ER8GXPMjSQu
 .5pbKyQXJVDAw7qTUH8sfqAVUxyhpp6SFZoVTA34ZinQD5lM4yaCex7SVzd6MPX7ZtNqjStXWRjA
 3gVrp5mkhLCJQf5373a.KVjzC21kcSmwG2iffGadZ6IBEad1A_03oWU6F_pohXulRE9DNDrM6VLF
 UKGovhVSlImQQwSuWhTh6Lmq6dCeOhbfHAQL14zpjpcAwJi9ZMM3ZyPzN3aeIwolZ64JG2Ltcnxk
 zTaQkylzVdKB8ucf3x8citpTKu6Nh4NX1o0ER.iTzjmOzJTtldfismsgGS8qN58xgBZi9_QfLhmq
 BREiYMUUbc.Beqb_JZ9e.hZST5SfMx_OaduvFd77wWJ7lj_0ahrKLBcAQ999bLD5ZK.zewlgxLkP
 Y0QYpw_.Df9skZxay_VhOgAiZWqBpE01nSxNR4DA.B7d0OoZL_kQW2Yne3hzqOTtSMijAx6HGMnV
 uRnpV_cB74ovP0roDKjwKs7VHMbUOVJ8.kdXABWnakvCEpdRzQ7QdtQFIIxrYAcuJo0h0DX2N1Yl
 SKQoDR.5nv5Yw8j705V4sSsa4TQy25DV8XKjZ3KDzRa2gP1k9fL5nhHWE5IUcxupy5Qia4WTKEZ6
 WcZeInLwPzs4mtVXjfEUwaXxr1gF4d2nOGgNFdcU9hmRHpZEyIX9gFSxgS3hO6MsFhebz4ammkdH
 nTLC9xxBSsmhbt7jUEk7LXTjoqAKXW3fl1T_uQxkfrnlctFWhXYNXljJe62H8.hubANX4nChN6BD
 CF6hkABc2X6LT8mr0c5yjOuH5twGJIxj5xwx6aPlZDegHKLF3hp8DlheLlSlfrstu_3U7QE_8ncb
 yvTDN20SvcJWlyCRNoHmcX5cW02KFFlMNOA.XoSFHTIyrE5OXKsGsMfpsG2sr0R4iHmJmUD_kzzx
 Y3XLexSfhtTQYgc392fpmJMZmvYHu44aG22h1Dqub3.3ZbAPioptx.h.1A7x4xHbWxF0eB.gQZe3
 iOjewLa1BzcuyGSDaE6jPBIRg3NQLmO6idWF_Mm8h0y4hmNYHkiOM7NQntJ1TT._NiWPcO6pcvco
 GW_6kSfSCv_WMG9z.Oy8RpevcEV1PWUtDyGEoNnltM66ZioWI3BhpD67MzNaFgU0RwlJn2RSjHXM
 dlrYGVHQlpIKAVt1kIaWiXtJf47uCyLyFYM2qbkfYPCZE7chkdX2FfVpENhZqES786vW1gBRJkwb
 UT_xbrRyZbtrtexASkXzRrpcIaxOafRHAE6a5AIUTisU.ymZJ0Kx.3A_nm.Q.rmA4AIpBIWnRUnP
 9T_u.Sfla279vVfjU1.nTx8NkOhfLM_dsOSyck3.ugMwaa.GpwPRdLcM_FAOtNKbUtJmfWI1m.6_
 UCggP9jn7dDyrtrBInYBJSWaw149dnBOoBxrbA6jR2NJpig8N8b3crUpHvpMFeeeLimbTSweEHXz
 40eytbATLle5Lr4lg4BbT6OryZfNaeQA5dlTXfE2aKtexKp.BK_Mrg3ol8h307sT2YjIGNJbTVM6
 ZjDbouOn5rmeP2Ow9pBCmRS2.aG3PrOGdY0DtcD.rPpaI7XM2grCMtVUYqfOy9nRBuj6OmXrvPI9
 r9.4rWaDK6Y6BEMqc5of.DnNoVG13zV3FLfAmJADOdR1xcb7P7bkPcKHMY6qQaHhFSGe0nKep3Fd
 UTSkGH68egJUeP5g73tRe_AyNtLU.Ehkh.Pr_9RChFWr5bnB9hATgvjz_RKnpDjcPtjkXe1YLtSZ
 qrb6T0ULSROP0UhNH4CCR5JOEr5uRGhp2d9XH70Lt7adSWeck1nbNcP5MZCVGseJ08y4MaRjMB.H
 pEl_hGwogZz3JgYzELYE6HQaXsNTejvtZNsoUpxpIPZFGLvuclLZLUgmOp4UVudq0eQrQmstgZ5L
 csMHj8Nqt7HvG9Lg972uTdm_l238fMjwFXi7QbgefiGQ_x4hbkj9HuW3QaCxG1YvihRDvsO3ZPal
 vjpAZon2p21ONztpiCwJ5Qbl9wAKxfY4FbXUS_bYbZ6TsQenl6aKLVp_hEBBBS5.Ns_PbJjQXQy1
 XdvLDEprDx13fijlXZgUjRqFk3s19fl6FP96nRoRdsM4ou83TCPV8G9.iyXOe8prjAnj8im3Mf7d
 g7Z_haPpc9jy4tEXW9B3qrAnA0SFgI4Vr0QoQlb4eBQcs2AU9oBqz2YoOf5uOwfrDuUEjJtQAaJ7
 1aS6ztYb8P.3lJ4G_5jzRQzN3R.dv0vOU8wYdFPH6bgNk.fcZDG.oXFiSD8ZNcEAMF1O5szuecOz
 ubhWC7klruGOUByCHEOLu5G5IAmmoGqEFY5kD.bRt1sg85bDdga.09x5UsJ1iTNpUt7cRr6JeE7t
 jns5ufY86Upn3G5RytK7MBwPAd2Im9nGsix3wxLqywZEQEqGfPCb5Hxgs.DO16ge1BtOo6CcOYUi
 qzDYTQYe2PxSUDNoXui.b0OlFcohRJ8HPZMJ4tvhcrENlW7MOjMIlRHf7Rl7Soajft9fSUx_cQwE
 UW_tfMThJgYk0hh.nQxyatYeq_aiImolN5sKmPQHcdohBJuOvsWPmp.hfMHDDB4P5gUEBCR0D6i7
 032.Tkzme5KEjw_HN0_xdtfLleGGskWHL_Kgh84qmt2aYqxl2Mvvv4hbmoPhYnQfGJQ.esw78tvz
 lpD6k.RyVllO3GP.9udSefpKfb0zpmihyxKkDZCiiG6Yq_WXKQ30weM6XvccpZxN6kRoACK.OJKt
 ZVC8ivzMNFwRI0y3_5TwaABWt3mCG4tVrFoOXskhasGd7eYB9yQ1SjJoeWE43iWU9E63fSeEIeR.
 GaeaLCkyYyWwajOjGiRXyrDuKsdplMdvph1UVKx18o0PpedHbTiUaTVCgesF5H70JcJ3QzoweW6U
 TMdzmG4Dn73nF6LC10W4GYclcCioswdpxT2nQ_Ghu4E93KC7CwO9OrC2uf8uc_LP4XPIQHhSWEER
 1q.BDXXoovU5eNr7dAcnyLM9jUlVBjSQSiDmBHe_ZQs1EysOyQKG9nNpPv9ofuq5CLkPTOHkzJcV
 Lb4RmNeS9NacMDTLkG9nMGFRbpqSasr890GQK9pz8dMT66NXq3iMMsKuJhx_p4RxxjLlIhb7xDwg
 kWK5u35AstbxTHWdOj7S8o6CmRC2d6t_yGK2DCRoG28hfO0Xsr.UHRDt32PHhHmkIaBW9a41qKwp
 JdIk1SIhJF.P.7kwtMoLk9t.bx4c0.xG5rAUtJOnn94XD0snqDeknD5vK7YtxrnK58Is5f01Ppti
 FLDAFMQdGwXSmpLUGwWE1l514TxghjlILmOCZzSnXICRNZXZQ1BXVcwuHhN7Ohj6.e.4gZZozxfm
 _0qNrzSoOl4pqCtPbct0o1N_5gi.V7jsNTwExH1MBiTdouY8zW_NJhF5CjgbO4vNLIh72gBsosXy
 SbN_oJqWf5Xoa9KgKGLaLhDacKKaO_RvBVGKbzjEaC_1Smv1WGcjjfBenb4GkN20Kne4mCpTqz1R
 hIrpyVpVeS5LiT94.tYjEGKD1dG3QR1ZB7Rv_BD2Gmxp_pPGYQUxut9cEUs1Pitl9V.6w0wMzefb
 BHB.4dwr00aShdirSPJwo1z08wDKfi9lzvUC1IQ8.wHl4LW6Ek_MBo1ApzHrkhrakVdFJAkkF9yr
 rP7ALgOoJEePXmpg1iqXBq1VV2opUvaY.DQcZsE3d06FzKDjI1MAIVKTjrwAqCajLzhWIci0kbV6
 1QZiFwXKZQvON0RnQvz14mhzaokJf0tBnH7G40wr3vR3bBWPk1BPSChm4trk0wqilJdNEO0eTSiq
 dHHwzCCWXV2N1mUihfIyUHZ0LQq8GcgR.9PT3rKBEu3.wh.6o0gWA6SkenGvTBWhpU.3aKrBLjCL
 abZkg4OZhoFTUqP6A1IiIPxx9ep3ykt8ITmBEnX0V7XC4QLPZjhxOm7m3BVZ4Ka5IgYgzKH8yuLD
 eaQmy2dQsU0KF
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 5 Feb 2021 17:17:02 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 68f140bfc5e1e85057f24de192666647;
          Fri, 05 Feb 2021 16:51:38 +0000 (UTC)
Subject: Re: [PATCH v28 05/12] LSM: Infrastructure management of the
 superblock
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210202162710.657398-1-mic@digikod.net>
 <20210202162710.657398-6-mic@digikod.net>
 <20210205141749.GB17981@mail.hallyn.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cb3f290b-e4e6-44b9-9c0d-4f892cc90767@schaufler-ca.com>
Date:   Fri, 5 Feb 2021 08:51:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210205141749.GB17981@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17648 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/5/2021 6:17 AM, Serge E. Hallyn wrote:
> On Tue, Feb 02, 2021 at 05:27:03PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
>> From: Casey Schaufler <casey@schaufler-ca.com>
>>
>> Move management of the superblock->sb_security blob out of the
>> individual security modules and into the security infrastructure.
>> Instead of allocating the blobs from within the modules, the modules
>> tell the infrastructure how much space is required, and the space is
>> allocated there.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: John Johansen <john.johansen@canonical.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
> I wonder how many out of tree modules this will impact :)

There are several blobs that have already been converted
to infrastructure management. Not a peep from out-of-tree
module developers/maintainers. I can only speculate that
OOT modules are either less common than we may think, using
alternative data management models (as does eBPF) or
sticking with very old kernels. It's also possible that
they're suffering in silence, which would be sad because
every module that's worth having should be in the tree.

> Actually
> if some new incoming module does an rcu callback to free the
> sb_security, then the security_sb_free will need an update, but
> that seems unlikely.

We're already doing that for the inode blob, so it's
really just a small matter of cut-n-paste and s/inode/sb/
to make that happen.


