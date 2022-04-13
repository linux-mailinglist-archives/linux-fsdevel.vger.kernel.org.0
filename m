Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1128B5001E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 00:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbiDMW2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 18:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiDMW2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:28:23 -0400
Received: from sonic308-55.consmr.mail.gq1.yahoo.com (sonic308-55.consmr.mail.gq1.yahoo.com [98.137.68.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBEA39695
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1649888759; bh=u2HgXtQKzcDLmUt1wSTfoxnz8EXVoQ+Rb9J3fEt41h8=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=CjiGxg/ESRhMddpDO+tMbAzEUGDj75D8aAZggo0d4vz49oafW0naZTXiIpZIT/e1F0pD5LoRZ6NLLsDgVt/4lyC3OqL5cjH7ik5cf4vmVe7H7IBgNR8GIbrn0Q5XBsmpgep+b+tb72+nj7CeK5Kyjzny/ikub0MQfDAEhw7EqNVIz9mpqfvzUws0RMQjfNrwnNA4/BRawAC3olf9eZsiOrpxcBsIj1yJK6tInVKrdXI+Is4P+0KcRuSsi+4Od+1nJb/ns6uTmU3mHuh/u+jGv7q4H8eCPFk8iBC29F8Chd5+g2OQa7zo1sfatmQ8nafXxujxZBYSH+IsXjnY5x56jw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649888759; bh=6x/rO6Q1Mkt59yjPPJ+gKsFCKmUW8jHVwYxmUGeV9DS=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=uaO0fhNs2pbAkT7OamnVqh4CamZvMR1ff5x5rwFGGZLlS9vG7pwfE7M1E4uzJ0Tf7/sOLfOJ60CqdytFvI55wf5VzEIl0p7Re/+KzzqWZuwX2DJ84fcQMTX/RbbDAH/dsO9LzcrtySe1IhsdxvrF1F/47WU4bLou4Cnt/VuUiLKkhrO6RSFlJKhDNt8SZ0yreRGNnjk9rwQsHraWQsTdTWgBs+D/5L7R6UUTT+0xfOFiGD/th+3XQzrlUAWqaeYKo2Y+oNXRRROysNfK+lANqHMtTuOexpIuzW2JgN4Kdc3300ookjXKhT1JxV5H4pEW09PN2OOt5ohyJudHia9u/w==
X-YMail-OSG: dwbgK_EVM1mzbCAFLjYYwNQp7ntxjcvjLfJ9UBTBiq0WhTPKQWaOr2xjFWQ5znU
 srzDqUzAj8g_hhaFC1Ojl_nQ_IzfdV7_SUwfowOd3tLIcbnH3Frih6WcvRMTrzvcLo65G88VAEN3
 cwdnzy1Oyn1gKg4zk6qEVF6frBAG7lRlIVwx7suIHWaASfDrwNaY3eQ24pW5QoEpwnKxG.plE9Y5
 vMe_.RCY3IPbkpW.WSzOmI8yyZYp.CG2r3erbWew6Yzgu56UZR2qDPKjV9lBHILBh_M8.sHZav6k
 6ZCCAEtavVNHj46k7iaG_PfpmO2XZ3oKCGf0z.sCpp.dezk3DvZtyT8RaNBpp9rAHp9zy5QsQObb
 CJXraBm8QnRTf2_CWUllHRGYyGTpWjrS0W3GsPf8Nf9r9o0e1xqwziDTnfPon_JH5f4J4RQYuuQu
 8jDi_H.3d01bpLUzZ_R1e5jWZfWhqubXUw2pvOuE97Mt5JugHbaKwmfnBB9XD3LskfxSZsH7wF07
 jy9bfjNR2PDrweV5x64AK8rdydQDarfNV9NA8QjidzXnyWB_pm5gBMcBYwiHQKUoIUhoyUrPPKBe
 rBecjyARsilnbbfYHN6YYNtV3iQC3TWL_TBqIFMFSlbFqmmeBAMzBeHDwHsJvOXQQ_LisWj_ye.3
 ABbqt.55_Wg3Ad_jiyoLwXhDO6wKbtruki2n5DFZGJVvmOWO_kxqi6zjKG3D1a9ya1kh2bzuGOaZ
 OdwyVSJllO4Wx.b512KQB5nm4MtsrUrdSBbShV74UDE48Jg.QdmVZxgLsF1VIAuP9tQBMVVw_xci
 EYWgbRrrz1pL6PV6AXBs_mBWUObPXLGIqx4P9_6yvfu0hs802I4.YBt09aRRCbeqlIkk9ee0KP9q
 EJsQB_HlK7gpXvvbdz_2.U.u5CSZSOY8EFESGsfb5LlT0VaVoVvJp2.F0_7ov3Kta8H.f3ARSwpc
 PEEPh5p_jBzfscCMLhoyq_OyMQhUZ9v4i1ACIbtBapNdOHmJHKChKd98HJDAvO5zWs4D.m1gviKa
 f2eTs5a08TtxSNryjwPV1k.QBrvSlxhI5oX0XarzMaNNv6R_PyONf92PPKMYu9QGbR_RxSyQVoMI
 AhZV9LX2I1HcmvVwOnOX7qyY4l1IQI_sJy4489HASLgDyxrPHv5vPxAg6Y.JEukoLzFjrYTWVLcr
 LN4K1ubjQRqPACytkDEmLwqTBwNJzYHEmFQKWxPImNqfnw1ex3rMWXaytEhPo6RfxcSpwoq3KD7R
 gUHemmfYPyUufYtLhdJWOl0cMjnYMWxlMo0pFOcss8FcCGEH0.yDTxs3Vn6q08rJVXwbrFMakLYy
 HY8eLmOfYUeTAHr7iJBHyyHOSy_c.L4EP7SvqDg8OskwSYDLdVzp7n6o6W74X6jZiziuVLKaZjtY
 ldzU3DfuuuW0HVU7hmsrLGXuXI.6Kdy0pvbaeYdIYoqva5.GS6lIPsZQVPmdXjQp9Nq5R.fpLl6S
 DiX3Gcf5t3t07qh_21hcB__691aKXr.BxI78bB8Dsacv9y31nFlg8JNM_qSOTSYiKx7EEl_1ALeE
 O2X2O8EMCX9wFOfYxf.Ky4wH47I.hcN73IgaRNLHwfq8qwar7Wd6sZwFlh0H574ajUktCToVzUHL
 cUX0m6FC3T9jA3XvmvNPuwWN4M0aea_UD2EQ.gCS8wLEK7SoEgbCY0M0GwmTZUJo.1MDb_62tzcv
 G20wroPs5B2myAPjc9.2aeEYcf2PX8_me3PUDMJMiBlUczaWfQgh0rD1Oe3Ld1T8hhjo9AEAIj_v
 dK2Tq0COgFxpdcsSPJF_..evaJssSHlBCf9qdu8sIXoUr9fUycPD6pSp9ej792ivwg2J_s2Oasa9
 lhXCbskycylKE0W1UiEPayn7Ix6WzrTCRwutUX0yqqU1NhzX1Apb_xIhSoc2iSLrGxAAJE6cDPDZ
 testjdsVGo5jX1zRp1_FkbvWs7xKiO4o4WhuYPxi8AHlys1qK3K4AAX1HP4YIF8sZ82hgPXst26B
 Y7E9kTKtqXZ14OCJJPBDKLuqLc_EcrKrN370KnEXkdu.u3UslhTW823Bf7xbSFdG8E7t.fuQSznH
 On2I46TmAvvkPF6m6lrlcqiKgKCBbMnMImqIfXh3ar1NP5lxDBFMCg_kvSeRkvWo6GiY.6mJw0Gv
 JNfChOliVFKr.pZqoF3yWRPLNTwPJg8JrItKrsqbYhH4ojA4sIcm77I_vSVGjxVSF6lgzuhJtrD.
 D5Fc_b83gclSM2HPCh5AgRZtNYkY.C.6KIOzbaUWY4ErhlfrEsLPfYCKe8d52MuJaxE3R0a5V0_Y
 -
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 13 Apr 2022 22:25:59 +0000
Received: by hermes--canary-production-bf1-665cdb9985-tmblj (VZM Hermes SMTP Server) with ESMTPA ID fd626244f4329a5c70bd56ac91e1e849;
          Wed, 13 Apr 2022 22:25:56 +0000 (UTC)
Date:   Wed, 13 Apr 2022 18:25:53 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: [PATCH] mm/smaps_rollup: return empty file for kthreads instead
 of ESRCH
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
        <20220413211357.26938-1-alex_y_xu@yahoo.ca>
        <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
In-Reply-To: <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1649886492.rqei1nn3vm.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.20001 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Excerpts from Andrew Morton's message of April 13, 2022 5:27 pm:
> On Wed, 13 Apr 2022 17:13:57 -0400 "Alex Xu (Hello71)" <alex_y_xu@yahoo.c=
a> wrote:
>=20
>> This restores the behavior prior to 258f669e7e88 ("mm:
>> /proc/pid/smaps_rollup: convert to single value seq_file"), making it
>> once again consistent with maps and smaps, and allowing patterns like
>> awk '$1=3D=3D"Anonymous:"{x+=3D$2}END{print x}' /proc/*/smaps_rollup to =
work.
>> Searching all Debian packages for "smaps_rollup" did not find any
>> programs which would be affected by this change.
>=20
> Thanks.
>=20
> 258f669e7e88 was 4 years ago, so I guess a -stable backport isn't
> really needed.
>=20
> However, we need to be concerned about causing new regressions, and I
> don't think you've presented enough information for this to be determined=
.
>=20
> So please provide us with a full description of how the smaps_rollup
> output will be altered by this patch.  Quoting example output would be
> helpful.
>=20
>=20

Current behavior (4.19+):

$ cat /proc/2/smaps; echo $?
0
$ cat /proc/2/smaps_rollup; echo $?
cat: /proc/2/smaps_rollup: No such process
1
$ strace -yP /proc/2/smaps_rollup cat /proc/2/smaps_rollup
openat(AT_FDCWD</>, "/proc/2/smaps_rollup", O_RDONLY) =3D 3</proc/2/smaps_r=
ollup>
newfstatat(3</proc/2/smaps_rollup>, "", {st_mode=3DS_IFREG|0444, st_size=3D=
0, ...}, AT_EMPTY_PATH) =3D 0
fadvise64(3</proc/2/smaps_rollup>, 0, 0, POSIX_FADV_SEQUENTIAL) =3D 0
read(3</proc/2/smaps_rollup>, 0x7fa475f5d000, 131072) =3D -1 ESRCH (No such=
 process)
cat: /proc/2/smaps_rollup: No such process
close(3</proc/2/smaps_rollup>)          =3D 0
+++ exited with 1 +++

Pre-4.19 and post-patch behavior:

$ cat /proc/2/smaps; echo $?
0
$ cat /proc/2/smaps_rollup; echo $?
0
$ strace -yP /proc/2/smaps_rollup cat /proc/2/smaps_rollup
openat(AT_FDCWD</>, "/proc/2/smaps_rollup", O_RDONLY) =3D 3</proc/2/smaps_r=
ollup>
newfstatat(3</proc/2/smaps_rollup>, "", {st_mode=3DS_IFREG|0444, st_size=3D=
0, ...}, AT_EMPTY_PATH) =3D 0
fadvise64(3</proc/2/smaps_rollup>, 0, 0, POSIX_FADV_SEQUENTIAL) =3D 0
read(3</proc/2/smaps_rollup>, "", 131072) =3D 0
close(3</proc/2/smaps_rollup>)          =3D 0
+++ exited with 0 +++

I agree that this type of change must be done carefully to avoid=20
introducing inadvertent regressions. However, I think this particular=20
change is highly unlikely to introduce regressions for the following=20
reasons:

1. I cannot think of a plausible case which would be affected. The only=20
   case I can possibly imagine is a program checking whether a process=20
   is a kernel thread, but this seems like a particularly silly method.=20
   Moreover, the method is already broken on kernels before 4.14=20
   (because smaps_rollup does not exist) and before 4.19 (because=20
   smaps_rollup worked like smaps). A plausible method would be opening=20
   /proc/x/(s)maps and checking that it is empty, which some programs=20
   actually do.

2. Research on Debian Code Search did not find any apparent cases. I also=20
   searched GitHub Code Search but found too many irrelevant results with=20
   no useful way to filter them out.

3. As mentioned previously, this was already the behavior between 4.14=20
   and 4.18 (inclusive).

Cheers,
Alex.
