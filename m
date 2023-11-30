Return-Path: <linux-fsdevel+bounces-4436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C737FF675
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A05C2816A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254E5100A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jEZjYd4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4233A10DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701360925; bh=AOAMVPgzT8X/21xydPilgKz1D3zPYH2CrnLCARetHwo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=jEZjYd4KzkbLbk9UgErEknkgnqltIcrT8MX3oS+gA8YOQhp9gkrFhKqngZ0bL4JsUlalkhB+xaWMdrehycY4j/r/SHzo2iokt7X3c7iH9BH/CxNXzHU1KjWi9ii/ttBazP9Ua7Gi3N8zkCyul1fuVt5TxDlOQWLwaKU9QtQ1e920ao7rA+fDfKq1stEll0QPEIIswx+DGuccbZPpiGvKz9UZD/AGU6S0NO212Hqna0I6TR/6aAFa9BhRwifQB2sJhrYINmXW6///Ig5GgYS7iTIP5wsDB9O3U7aeBwgEElPPmsS+WzPJnZUk8RthQj5IzSRmjgQcesNfr4j1zHgfvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701360925; bh=vTI71AUTfLUtFzy0LHyLZsYxcU79FAUVS/ixe+nsnDJ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LGzlSQAz0sog2HB5R7nlR5BB1nLniKTYHJ4QyTvYTMxCkEwHA/aWij6xE7i4fcmCPidjMpV62617/RaH9EK/n1/dTN+gC6VQ/LxKFEYa3NJ9hQ0ApgsieQRz0SAV+O3wR5uNV525DIwNtXdqkVf8oEuZC0yOtpsUMXnJ9Bb/3jTaIntSj08XvxeF3RxvPzT5wQLWH39KCUnRnArklo/YNrQPXe0SLt5URIoDEXwgjb4HD8qcUHAIxQzQ5hQiG1+9PO4R0QdXMkUUIIign8yNX3lKIbvhnRp01AWRzFucyoqOtsRujvXSVi9JpqOlTT3mFyZuOrDZ++B7IUjqNYdCjA==
X-YMail-OSG: W2HpEWQVM1mK97g9_sHC0dVdEyzz1Ph2gyheZg9flMb0M.9zz5Ydsb9_xn3H8zx
 YKDZD_Eh.aSA.G7e9m8G__ZEw.Fb6XiymdfhWsX1eBuYX79IXS9rUZRhPsITC3G2M4AQ0M5Gdw9c
 EWVF_bW66db3Zx5I3oXKjErmgr_8Ou.2NMJEHveywoTfNECxhklQyjQHUiH_nFnrO9cQnJ9a94ql
 l4I.6ixM6C5.96nDBnbAzB2q_55yS0DRQNjteI27EtqewG47GXoP.N7pmjdsU9YwNSU80mrGDcA2
 Q3fqmxxCfuuy5BmWU5zkYPnQuw986UEgILibLhBorf_w8TvN5sxH_ZgF2JuhxJs5BIM_GQxUq.6c
 yZdf6Cjt3mmEqNT5DgksPWV0ajl4SRArVQBHnO1kiZeOfK7RimtwEmx8.4cjZmyozJIIv095.Y2X
 PEWpDusn4VPNvIBs4Kwt94W1iIMhvlWBPKWbjiaZlUC98b6WJZvAW2qYPO3o473Uhy1GZ_osRjF6
 3Tq80l_km6NWRgk5mAn3Rfny86xBdB12bGhvMUtul6b_jiKf0Ro8o.kzoOjNt36OK9a2Wrk6z8.i
 P3lMgUF6MFtbxnHfOKbX8pNans4c9sKKjCG5oZCezYtV02Wy9MSa4S5vmZHNxGLq9gQ6r6oEZKhN
 na1oyRqknPlm4lVOirLAm4fw2dsQiQe5.qi12N80JX1jT15iZ1c4XFk_ElBj036UodX2BbX18Fj0
 XBV1zqd2cZhkzxVsLYX.rQhNcW8u1xkvWbizUyos8sBPCjeIrijAz10_22wa3xP9aA2QT.vWZj6O
 PNowGM3pimQBVS0EDHZ1e61PPNb77l2R4066PQXRtU3W14i31HzrXSvv7xUdEo8RM4aPR.Hq1uhK
 aVCHH1_dHHK8CMxLSfW.RXOwB6utmJjg5srpw9WDPAjnjYFiGhBjRSVuRwSgAJm5vDwgmWJ7qixQ
 xs2_wlR_rbibeRqCjfaxDBfbpDxKnKDKEbu1.hCQsF.XhX83v5U7sxpn1KgsA78bgvV9pzu.akVN
 Ymw6UPoxtjOFD.9TC2bdaU0Co0P_L9dmxKUzxmQOSlU2.nOW4yEmYCzmyAsLie.bIsLmPIrySrht
 q1n5lUR.N93Kn_m6ul8TRLUuWP78m5RyfHFFiiv2f7cs1cFROEhom8tu6y9hU14z2EHft3HbJo4i
 SJz5BHdztjdEklBYmQL6N5rBJkGW_iHpVSjd81vGE_abBpUKWNSEvEX0DlqdxMAwKaEpYuUChxTF
 7z4Kl79LY34GrqudviM1WAgbJhoauDbznvdUsM0ocwU.pPRgNUatwujCl2A3DyrUHaCpqKnzMitn
 6snqP_N3_Tx1k4x1Zi.YfTT8KLNhOogqsbT6RXV5hii1oKoUD4Y_Hi3P1AOlpVOiddS8X2KOrSlr
 yBi1W2DBxII5_yz2RtDx7JRW3vN0E0wCxk2Wb.qtMdwxQLbYYGQG60fjzZD1xtYAbbx6HHMY6aAC
 Pc4VIIQ5QDta90NUrTYsTfHahDcC3ETOquvnom6.kSR7OvzIfGzMm88Oul4UzFWjtols.7PydH.F
 gE3.BlK_Tyu3mzApL1_93BTOzcKu04gswml4bAcn36iWhsLWZ7zZ3s_kNPpaN2kSAClXP2zyktKg
 aTg.iBfUCYYJ_y.LU.eUaOH_frSbuJjK7OD5l3EIHoOBrsTOXYFBCIbI_.e6Hi.TonD8nizbnnnx
 QRZ3o1xeDP_DiJ4Yf_7lfrViFkWvk2O_9YymPc898ymNOkkcLqPlp9krTfPVjT7xhUPxYjELqbk1
 QUXrOmYAZQEroXWFju0XfQAiw1lkWMcR6JSxZZtQGPBtCnAaeO95TzW8DmlsggX1ayrYk53giGEc
 uDR6_I50VU8YS5biuBQH.5fYMTDJvTr.umEhPDuGEagGsja_r1Ltrb9mquDqEOMgiVHM3x3RwkV7
 oWkWrjdP34Q2mZdhVTP_htcj262_hvn1eOr9_lJi66hehtaX9dm_CaJYL1nV5alIrkVbpzu18n6g
 YVyXjTbJxUctqqCbXUdH7ZFJKMQSWaCqohHTUzXkeben_CxcNpyN3hof2WMln_U5wZ616PYKVDS9
 AgOKTR9F5Z3.E8fu4I4Nw9mXgpfBquXcfojl8ko3XEOr5qjDXoOt2YYSYFrJ7SoRNLMDPOG7K_1T
 0R383MW2HPyS3gwfuBYdbPoT3HTVT_bo26YHSHv9Ctxz2.tq2wUCS9FVwTExNru7DXhbCiaiS2cl
 C137Ac.SWYZiIcUD.p57KGr2VHKDeqzdS26GbKS1KedOR.c927icLOTporrfsdqw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d11a2efc-096d-4e03-a68a-f7a2225b217f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Nov 2023 16:15:25 +0000
Received: by hermes--production-gq1-5cf8f76c44-dxf8l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID eecf19e073635f6c94e743f6e68eccbe;
          Thu, 30 Nov 2023 16:15:20 +0000 (UTC)
Message-ID: <a121c359-03c9-42b1-aa19-1e9e34f6a386@schaufler-ca.com>
Date: Thu, 30 Nov 2023 08:15:17 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
Content-Language: en-US
To: Petr Tesarik <petrtesarik@huaweicloud.com>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com,
 tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, mic@digikod.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
 <366a6e5f-d43d-4266-8421-a8a05938a8fd@schaufler-ca.com>
 <66ec6876-483a-4403-9baa-487ebad053f2@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <66ec6876-483a-4403-9baa-487ebad053f2@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/30/2023 12:30 AM, Petr Tesarik wrote:
> Hi all,
>
> On 11/30/2023 1:41 AM, Casey Schaufler wrote:
>> ...
>> It would be nice if the solution directly addresses the problem.
>> EVM needs to be after the LSMs that use xattrs, not after all LSMs.
>> I suggested LSM_ORDER_REALLY_LAST in part to identify the notion as
>> unattractive.
> Excuse me to chime in, but do we really need the ordering in code?

tl;dr - Yes.

>  FWIW
> the linker guarantees that objects appear in the order they are seen
> during the link (unless --sort-section overrides that default, but this
> option is not used in the kernel). Since *.a archive files are used in
> kbuild, I have also verified that their use does not break the
> assumption; they are always created from scratch.
>
> In short, to enforce an ordering, you can simply list the corresponding
> object files in that order in the Makefile. Of course, add a big fat
> warning comment, so people understand the order is not arbitrary.

Not everyone builds custom kernels.

>
> Just my two eurocents,
> Petr T
>
>

