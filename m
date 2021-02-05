Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18428310E83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 18:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhBEPj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 10:39:29 -0500
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:38277
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233311AbhBEPeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612545370; bh=LGQ2+Oq5r94j/3FnA4uP6fw1KLX7JE1Bzu43eSjT32U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=E5Q3AHC7DrRTGTsWfwbVH/vY2ynDAPHpRKCt/EuZ59E+7FPCmkn/mZjw0Kau9q6GS5kPpCzuPrIyWCmwTAONGipXMrc+q+mLWYsPqJZrbFouCbWoJGlyWpVXfd/EupkhHNBQZW/8t3omo8omfzYCUYVBBb7z3Uu6VbP+snNIo8UiSxCxbh7umPhk1NFEXzX8nihG0EFtVwzz2OzkflNjC4Xjjv8cp9bH2XH+zPik9WTcwkx4+5MwTqPYfyy0cGmEobGIUfJ4y8RhLaBnHyN8WgNwC7TvLn4d/TjTxnvTIuX8qB5FJELhBmT3LHyXFp7xEVLsozxHQ3B/nDft+M65Pw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1612545370; bh=DdrNLdMiq5f08synoygNBdLkNEkQLXrYKPFlCK5/HPx=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=q17JHb8ydxxvKyE/MLy0q/Z8j0RYckf7LecscmXGh2DI5xgZrsSv+EGAnvCcO4rzqp8R+hVelU8cQsIoITuMK6EsJBjkZiV4OhG59EOATXKMadrx+6m0mKwsgHTWF4Ba1BRE7H3kFsBtWfHjo8sjrAfi6FxOtDIUIQeKfzGc9H5hYK/FpjDZyz1TA+tt4az7K7p4bZJJNb5ZrJirvm852K3leNVuREQPmChRRin4dRrkSU1uHp3GDxElPMeqmSVmob0oNQ9ry/76yMvepYXIiGxRfjK1IzrZwhHtwjc+yyPx5dhDQpQpXxF6MN2frkRLYT2CVpRJdJ4vFO/31VCw2w==
X-YMail-OSG: ZjJJ_xIVM1kunllM1eH67wULJ1tnM5MUGY1TOnLrNcjuw_tmlIrZn6iJEZ5NmYk
 o8FpD4aBRfRTh1SvDSJw2QZS3vZ406f5WfjUo9KmxyiMbRRGAuMuE1WePT88UFJ0O_wQqZXGFtpL
 0CtlltkSGETb9uKXg602HONBi3QON1.I77WBMCkLozMZYl2PiKo8qdlRflpELwv4vrHpIOf_qwcQ
 flvP3gHp9BFpZE1u5UWxh7IlquiVOtmu4KNePwQX3ootb1e4obbSr2hOgRPsYZwTZ1MlA8qoH_3g
 fMn840d3Ts3wfU91leMY.BrVYIabrJLCR483FAX2oNAvRSeeUtqLslnVzbqSWZo7WqW2UnDvDtsX
 JExOpLsgg_99y5uiApfdxtvC4L2kLAWo1FhMgkLZ5nRfR71FZfZt6FrYuun23LSNDdFTSndhKU3O
 cXg8pr2IQpYw1p65_cYbBO1PslNq467Y_TY4tL99UMBtrZ9laa9Xo3u8rNT.MKCcCPtPL9C4DtAm
 Mwdw1Btr5jK0qNV9b1hIpWhWq9W3KtQzn85EI.N37LJJhpT_emyqCk0E9Pke.nECaa9KRPtSxhSG
 rfrbN2vjgdpkTRLG1IlxUcbSDuFY7J2DqlQ12qCisGsFJOXX1TyEBncFism4JShMb1Xbiihk0xZ6
 BIPSP5SqW1FisDoIwXV8ydrDyuWlOWt_0sSXPX2gypqT6uMXnjsxMGIUgTPVk8Lv3jhkTpkiaxtb
 WVivogYFByYWlLDwG7lxQd.RMZsCNl4XGb3hySTzw6Scs_H8_WUlUpLx3CiqzA2MvL3NX6MQhe92
 hHnIIvdBRuWAPpqS9frxZz5tmLs6MFDCaWTxdZettJHE79KNOgtOnm0vX4jhTtbpxamRibdXPt8A
 LJECtqTkLJMmoeabN3Om0hWf4Ta4NTOceT1MRwJO_Dy4a8t1IP35NXevCW1eELTDf.KDHV1xddZY
 4XOqpbuW6k4YdtFmQ63iM5w8zSmDGPXD3wN262a0k1jpTzuPbGXGgKl7t4vlrg8OI.SP1f9FVMa_
 N48rXvqN5IGMXNhX0uJetxLgub2Ac30M7HqrBFxH4XR2aIi4qb.6iFQrLP7PsZJPLRtG.t5DYv2Z
 RT9SQhyRCtqw2lh1L6oTIHtQvRTsLJAJvTd3IOocH07mxHdsM8JkFqW2SNk6WKOvRwhyFqtofx_w
 OzItS_85lHv0u3H3P29DrkoWLQB4GG6tCj2DcDVgnb2xaL5eiuj0p1uhS0DNlTDPm7BZiFS9XFDM
 7LynlL95QEbnQJDq5gXh91PALBQEAcGCnwql2hgC3WpwLt9kdNCM6IwlLnw1qqSOu34bV_ni2vIH
 zt8fQsOjnI7NCMWyaiqSA_uVZlxhtQQ4i1x_vixHzOxaI2iyoMVy7EFPFX5z045DYEmWVI00XDmS
 aa9GTA9u05X1epCsRbphTvlU.o0u4Hs4WyICg2Twdf5Bz90VBuxk20zMCVyb1Ewn.Dh4O_f3OGFP
 Y0sHipvHJGSOHuqAXBMeRWXJubINzi5oLMtrTWTxxHWh_8ratU8YFYCQk_6GvQTOP_bRZdfZsmOM
 i2Gxbv6y60vhafJzEKJyMni4tnSZ9Wng24nDLfM2VCguys8t5zfJW3XQOjwpW7PqkpJcsjbG5wZP
 GHN0Ux4Z_Xo3.JXr3yZ1TtU2GRnNPPc.K0nss8.jp7VjC5lKQ9NmeECa60Efsv93cVLf3g100MpR
 _FkXsGjsnjMA8fkpnGR4HU_qb0fAiRIggaaECOZVdZOLvZLlKbY.5NUK3oc9QEzzrN4IPrj2i8gz
 V5XbqvOjT_f.oGoFEMMrsuPVZiN59Mcq_Z3urGUIeFdejq50u_q05A7.Fz_CM9eBIS.5eVWCt27U
 EmA3Dwd69B4Lsfz1i.N3taX_ZJj8Rzyrcn9Vr1Y7X.LS_tZeltOeZKFW6nBAjwr6u3jzkbAW7NPd
 tP5HYd9XJ1iB.giDVppiDu2jmSt7q.3NTAqcZiw5hrJi9O5JRIKGaH8a8JXA2NgGWZACgW8B_wj.
 NUNvYCOuUN5DPkjjrmubVWLXo_9NIkPx3KHM_2pRAD0pjj4VcljRV48fVJHG0D._bGOolqCQTkfg
 x.begYB2Hpn4.LqNSQgHiLi7Teyb2D4XedoSCQGG0_HRkFMiULcaARDeUrKuXC9tRW_KkRcV0fF8
 WqKVSRrge1x_auKz1Ba43LYR12mb1NiGAK2SDkk5gAz17zCnGllvU5Yi2.K3xMlzC5n4w78LpWAe
 0f42WIVW5on0HeB3RlzMr5XZ13zyX_Zyw57Yc7nWIDi0mLbOZcILSZ_NWQx_g8TAChdbQEbvNGKV
 jTwVm.sVX73tnrTPbblEIQQP.bvYedxOOkWQYs8xJgWGowQ.04ENwmk6nRf8iXwoWk.KDpgIjhda
 R21I_I5gJ4egX_xgnolPoOP19IJcDuyVUPF_pU77xa1UMBinSLTozCfJViZQfpJ_nd1nQzLStSB9
 JOc3_bpJYz7bJ18fdeklII1k2F1ZwIGqfv7BgjBOtObSYNlz9T_LIirVYvwWuZzezPLXqLy2XdeO
 x7sR8m8s3D20.U0yzZhFmAISHi3zEVhQ1V4TQfBBBp6BwMEMbtDGutqKrBfr_5FIWFeR._vmeIku
 CiqnzDXjJAaBNEyu7ODFgQM6MK0XDxVTBLArFzNbysPgPmbZove1PW88nKGZ_J_AxQ546QwGsSIu
 dR1Mg7wzggCPV5GTEezOpS_oNzRXmOlpyYp50Jl92a.JeoCGIuegHPwR86VRi2NI03OpiBvHtZpZ
 Bz_KYRXoaDJ__naP6bhp__OKhk1LetRWboiVVtPeFqeMUVho.6j6B9ANNNtSKMhF6Bj5uJWV9KZQ
 AdBZ3uTo.gZpyYdF4zoukVtkBKFJTEPv_nE29vxJXmdYsLPQGocPFQAJbDbd978atlHROhxsZ4dT
 QHNM920hisHlYPc83wLO1WFZHNRQRIlWs09ylQ650KNEE.nSilcSOB5jtmqbClIQjtH7KI9.41P0
 21OYIcu9AqA6MZXU7PNCYSrZS9jU2P453qqmD_SI.kkploGlJBJVcPRpxzI_.YBDwP5_vu5wzmpv
 BhQqag7NBxo9xBxAy.LRnANOQhl5RvUM180K5uvt0Ad06LHlY4DpbboQ5U6YqcjtNLXisyPQhsOW
 0D0PkzEsleJWdxID1BRdC2EzfSLvMvg170zKYD1YswZEDR9p5_ytSMkT_RPAzQiyeWcsB0ke7okD
 XQKhf7HB6A28Jhbl1cafWqsf8maYsQH1M2FbJLGp2PXMwhK_JiiJxJX0BYSxfjdcV4FVWNGrDbeG
 h4moW2OoRCdamLyUkjRg5T38rvChTAZD_YHPkk.NW683x4Mmoa83NSBcm7rwlS_thP_Y0kVouP0R
 spUG9qPYMpCBgjlXG5g8DI_TEbp55IV9tYVZRgDIFYv2TU8cWM00vkX6nUl3sLZaPKih4ZzJXBv1
 q88Axpb3WYnOO79sybjpd60Cq50YFO7wU5UABw1FGUSaRSljkhUYREVvasCf2eddUDk_qfUyqq_3
 HAvgOMJ89ZNvF7F2QWPaCU8CxlD54as5NLCEZOC18JfyuPNEerA5uQqXYp998QUDJHwid00uRh2r
 DHYQIm_Rhig4V7gsTnWvuCd_diydegfN_AEsbWnoO48.8aUM3zrnm8Y_9fS9mwgLZFCa5By11SfK
 hCGO3wCgSJsWTgqtcWc16i5qRLWrvqxxDVa.6E0sVWctENrGbSPYgwi6npeetws6NfbqRc3Xbbtv
 Lwb4TLX5Usx3EASZik57eB7dNtMGr79mYjslhRNhARAMdEpVy_eSn7XDOcjcNOcFl98IuSZaqNYX
 X5fa.Sp92gLIZiSy.xAG630NrB6mfXHb3V37K1ocoZPA4Rs_bj5U0UEm50aiXDuNxvU7zgMmKUqQ
 4SDgvW6gapT2TV5NNkQDPgSXe9eVDtDKrMJl5nCUQJWHOHe.HxMuFDy3K88os_gy5owYTFLEyB8w
 4SsW0cAHmJjfHk8U53cO5VUF9sCeUsECKfMkZ9YcVS3WfRkeNNxbzvtJDFBAy_4r898hCJXw93uv
 12RKcNm4xIRhcF0XDgiBRHYdtg6iyHubgqVenG1yNV7n2fCU.x38lUyZRyKhUbDzQcuGOqfiOkAL
 7j35_80DSeF5AP3VP9ic7PN29Hl8VeI2i03acF4QUu6_D51Ot17UeyPJBhVP54WuUfsZcMGpxH1W
 9JJ3cka2xVQp5b95CIevhPIhjmCbBcnb7af3qpqEbZ8zL7Q1ogrWAwUxFckXq2A3tdmf3C3PeRv8
 jZe3i7RJRy8n5ectMUHDbvS41n6R1KPhbfRukKGDfS1goxDfIKS56FatE1JPcYB6Z3td_m8bBmdY
 _pZLt4RvP778qJdaycSHCHyWYcxStbnHwAOLjw_kIDkyDk6lLhFJsxerCb26gphthuwiytgkOgYm
 nO_K6w99i2w4wri9iS9vtFWD31HFn.MwzJl5Fh7HlZ0RNbf9H0WcfaOYrENQgRuG_i.odfGqJh0k
 3OHPfzXXEfgXcWWkCE4eDA7VlrIGnMdsh5hs22jsTAmEl9zxukOzcN0sIu3atwu4eiVnZE2vOsg_
 _hSpyB00kt5gs
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 5 Feb 2021 17:16:10 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID bf260dce1b146895c8ce430a238f7200;
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
Message-ID: <1fbca26f-57b6-27ca-b522-36a63e4fdf09@schaufler-ca.com>
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


