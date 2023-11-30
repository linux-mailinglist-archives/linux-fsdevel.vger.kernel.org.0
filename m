Return-Path: <linux-fsdevel+bounces-4522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC9D800047
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCA1C20A85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAFE1C681
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cAYiTDaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9806F10E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 15:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701387069; bh=KKWxRGo/AX4QeEd47QnRsF18S9N8KhU2b2kKz79X0vI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=cAYiTDaGs/kbdlVsXQ3ZuZVFA5TRYHo2+eObt78zh4Sa23pTNIXCb/lNwfjGhZBRE3yRDmtIX7ekIJPpwWEIOPPY/UaKk1sSPFJQ14e0f/0z4OETF936AMsR5Py5CsCkP9lgWuoBA1FD0m8YyDCXpN0IbgR0FVNGsaQDR/zLSCjHbJKZlWGblz+piMqqMGDGX7F75nObo2xfDYJCNWoeYETeUOkMOD0rPg6oJpthTviKibT5+69+TZGpCI6jeBo22c6QbrLjbFTSylFNzn2ZhJoOyRQxdd1kkqF6TofdTqCVgU01rkWlgc8FPnFmesSRu0SY4b7YHDNAFrOEK9zqNw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701387069; bh=rlV0Ex3CXOdWAchqeNEt2KMDS+yjt068Dx8Y7mNlP0H=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=F0tqQYfSlXR4YHDbnzWKlMxzGKOqi/su9mCSbDwgEAtnFN8aZA551z+edpGH8RIBhrU9hiF7Pl+7ha3w/6gCwm8esgiP3WIckyBeEf1oSBnH5ooSU6fmVbjDA9HUzADBNMiJ06j7AWDYbP+my52iF0aqYypFewN7p0zfWSuBgh+u6RRyCa8vFxVz39iSP1iHPqDIoF90GVzDYOaDoiUSPATBIsSKlBfc06uuehmfN6TyJZ+vIv+aAAsYiLMkyDh624Pe+9+0VPYch2vdO28ufKxjetDg+cLvaumm8nt94e9uVs8ijabUjBbDvPf+nMkBXs6ztQwytL4MeJW+1SJO8g==
X-YMail-OSG: RmbhXsgVM1lLhcaU1ne7mR6zpkzpbo7bxmuwrCU.Q2Jz597RECpRfmbO46DOQRX
 U0xQ5xBsTHuxbwW_TtCdMT2eNLcqB.9MNEIycPBCvxEIMauu4wwWKuCNsriWG17YzxZZSU5mRqMT
 nD2EjYEowKyCkwCd1Te9jq5klHYvLtxbd4bFcCFL2P1w8RMBLElSfcjca4Z8tSv0mGlkUiuzaWwG
 RBl1UsJIZ5mMgUmfLV5UijO4mDS6IGYD9xt0Ka4LyErovbxYQNiSnLkPVFektkl4NsrfOmngA95N
 kkBMRRM69yRal17E5bEl.GEetKRGjxFXrkeFBPBnvUB39vRXM1uJr9lofNBLfPsBFlSRztA01Tb1
 2.Ko5WaSMvaFu9MtaEtE8do0rdNJt710nw7v4t951twzPFAuFYKdfw3g6c3dDKSk32l.YGN7bxxE
 iJ.JRQQCbY2fVGo1dbzVUND6NRrYIQQx_mvHV_T77J0EKmoB5PjOdBf8h3yto2zOuIw_4K1oqMnB
 lpX7Mviw3TRipQFQS.QYCDE0eCrAnoXTzzpMDP9ypX_zjfS1v60CersA1yjK9TZayQa1yj27zYCe
 MqYpm4V95Z_gsdrtiyAUPvbihlhUN_RJxGrK_Gf7hMtPu3r94bBvxh7bkXd_8nCtKEtlSLmD47FF
 rL47IUcSP1slx3.T45INLMwoMSBAiBt8hZjKCp7v.tuhuOFWTq83ZX3Bgm4YIJx5fzbP2zmEoE0V
 n1LFMQTdBQksBp0SXQqDx5iGuZbQ4LT9sghGEct1VVnED8JCl2Q3eoXI.pGSoorwhte1qgKTgB_Y
 xuaouXmoDT.pBkhmN9HyNa6U0Sm69lEVSV7MWzTkWql9x5iU_JFiGZ6p1NBE6s_iQp.lA6QAwhzv
 l7pBzDvxyID3ETrwqjWvJ9.N6uLcX5usJoNfYoNZdWLEaczXKlQpCi2qL7sH9JJ8dD4sshLILMF4
 QMrLaD3CLaY1swMQoVUdBU2lVc2D9.bsMFz2bGIVsj3Agb_IkaYkjxIEdPSVSDpBpGgTUUPw4NiI
 Ao05t..Gn2zuzLJfUL009ZMhDF4WfKZKBYTRnYgcjk3mn4KMX8U7jd_9GUG88mGLAjM1mLgP5T0U
 l3ThDS8_119wMrFkYqawFpQWOXjUZwEfgOQG5Kn1mbNoTj5nmKB3xYWfcd38qV7rG2wkR_lh9ycY
 whKVcjiTWBN5oiWwxSoVp_kqeBKKpx4XHDzeg881QDlQu3me_cv1ca_fNGAB99dOfyaXmQTkbUWX
 NJC8kNTy0LDvsElYl9Lmhrj5AjcN2Ri0YkP2q4xFd4y8a7fpzpgLjhHO0eS9BJiE6TdSiwpl3emt
 m0A.hvUkcnwaYyGVzRQzDxOkSPpGHBeR.4DWH5YTHt_RDKH4BuKHZ7c9LTOiZaRcuZ.k4f.4tkEQ
 Uiv_EUfa.VV4Hz7bjE09A.6Gv6o_jhTzwt81RjilE.3Ws3mQcEVTF3ukpaJ8mqn6mP.awZ8KDNNl
 c4UZwqxoCu_QiO3p9xrMPy7QT6pgKk5NYYh2waRQ4m.kFmActr1jtPHLJqlOWJ.lozojt9n_iOTn
 FO8xYwqitXkjIyaGYjkPmQz1y4CL4XcVfOZtYyg8zVYvt9_gz.2FVxfLyx_va6B2DA49sQn_93rK
 rQZNJx9uSXy3CFcNCVYg1kjBy1w4QY5wUFHRZGYWsRb8tZS5L0TK1T2nESfRDavmjKYLisghlkj7
 QNaBx6K.HzYUPfhwXbfw__R9b4WYTEanMfFbzlUq6ybAO3uyGIkBuLxX3wgyowoV81LjD6.NLO_8
 Tr6qwmL2AbRU1yUYwz0NvLO7oRfcZKTbTyNhfFDcEa3Ita4cJaCOJHIHz.C.BtPZGz9py3l2F7px
 qS9ntBjFItpwyIUQpTPVTOqAiUrPEPCu1vpDogaG10Ly6jwQgX8ORMLQrTjxa7GTdDUcLAIe4XKE
 nW0i27YVQWZ_adsvQMLe9r.GPfyE4j1frSwX6yX6oeFmhTn9LlGIalDQxI_0o8bgkXsGa1EmQVA_
 RiYxlCnPZCXI8CHTSqZnmZZV_VYrYTtWvVrbEwin5pQwPjFwuRO3LIu0gblUo89NKTFmd1lcO4Uq
 E4myoOch9OkxyCzxMlGldOuEwJVh3bsESE2by.o8attKx1pqXAA2bgsWIe0PizFVqkhPGZgZzKmE
 LHQofP7vj1d2bnbsYYOa_eTnTKkZ9riIwU1ZpMfp7Sfvq5ElUqDevvvjbb7D_ZCPKwCd1L0GRpnU
 7gjcZZv9chYJT1qs_._JbUfhRbjnWUQMCk.NIUdYOkvfvi1zd1H8_u5XZrnz_GC.vNA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 765f1964-0fb7-4d81-8316-507c573fc21a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Nov 2023 23:31:09 +0000
Received: by hermes--production-gq1-5cf8f76c44-fz47x (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 19b1fe304cad48eecfc9a1ec502551f6;
          Thu, 30 Nov 2023 23:31:04 +0000 (UTC)
Message-ID: <018438d4-44b9-4734-9c0c-8a65f9c605a4@schaufler-ca.com>
Date: Thu, 30 Nov 2023 15:31:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Petr Tesarik <petrtesarik@huaweicloud.com>, Paul Moore <paul@paul-moore.com>
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
 <a121c359-03c9-42b1-aa19-1e9e34f6a386@schaufler-ca.com>
 <9297638a-8dab-42ba-8b60-82c03497c9cd@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9297638a-8dab-42ba-8b60-82c03497c9cd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/30/2023 1:34 PM, Roberto Sassu wrote:
> On 11/30/2023 5:15 PM, Casey Schaufler wrote:
>> On 11/30/2023 12:30 AM, Petr Tesarik wrote:
>>> Hi all,
>>>
>>> On 11/30/2023 1:41 AM, Casey Schaufler wrote:
>>>> ...
>>>> It would be nice if the solution directly addresses the problem.
>>>> EVM needs to be after the LSMs that use xattrs, not after all LSMs.
>>>> I suggested LSM_ORDER_REALLY_LAST in part to identify the notion as
>>>> unattractive.
>>> Excuse me to chime in, but do we really need the ordering in code?
>>
>> tl;dr - Yes.
>>
>>>   FWIW
>>> the linker guarantees that objects appear in the order they are seen
>>> during the link (unless --sort-section overrides that default, but this
>>> option is not used in the kernel). Since *.a archive files are used in
>>> kbuild, I have also verified that their use does not break the
>>> assumption; they are always created from scratch.
>>>
>>> In short, to enforce an ordering, you can simply list the corresponding
>>> object files in that order in the Makefile. Of course, add a big fat
>>> warning comment, so people understand the order is not arbitrary.
>>
>> Not everyone builds custom kernels.
>
> Sorry, I didn't understand your comment.

Most people run a disto supplied kernel. If the LSM ordering were determined
only at compile time you could never run a kernel that omitted an LSM.

> Everyone builds the kernel, also Linux distros. What Petr was
> suggesting was that it does not matter how you build the kernel, the
> linker will place the LSMs in the order they appear in the Makefile.
> And for this particular case, we have:
>
> obj-$(CONFIG_IMA)                       += ima/
> obj-$(CONFIG_EVM)                       += evm/
>
> In the past, I also verified that swapping these two resulted in the
> swapped order of LSMs. Petr confirmed that it would always happen.

LSM execution order is not based on compilation order. It is specified
by CONFIG_LSM, and may be modified by the LSM_ORDER value. I don't
understand why the linker is even being brought into the discussion.

>
> Thanks
>
> Roberto

