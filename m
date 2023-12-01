Return-Path: <linux-fsdevel+bounces-4526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2E80004B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A291C20B52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D091CA97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uk1c/sx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB391B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 16:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701389542; bh=xhpnZHCnAPwebcdq5u2/z1zNCyM218vVIFWrLGdQofo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uk1c/sx4nYvNXQT6GNvumrPi1VUpwwwI64fUy0PFA7x0Z+as2UOYOTFtqFm4OIQUEHhlA/6va5Fkjsz+OBtBQGKHVG3wgsnlI2b+mUx//AoKbvN8WUtZDEMLTpDTKVaQtLgbWJX5cc2Vnqa0qVBvdDHK/sJelQ0gzAd338U8EYzk/Hu9Th/jKuWaurtem2faCYW3CrxVIkClp/U/uM8QK/x6LhFFdz3gUxvPSL399smsy5j9s4vVloHBd2z10+4J8HzgFndFVRKDyXhsIfKErFItwRzVKrnUllWlBcEJSXq5nw/Yg32Feyi0dXzE5t0cDf0ZgMYxlfelAbTDNDV3ew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701389542; bh=yZxo7Q5UvMeSZ2QpjVAvCN5ts3XebtrTdq+s0IjXmVm=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Z8DVEiY8jMr3d/h24e6mhgq7+L0O2HP1Osp+42SSXKu21xe1hukgqKIJjm2L0DN13UX0U1rXU1L5n5iZX8O0Yv5DLxyRQrZhYOK0MMdxqvXZTxb5uMq/daw2w1Tp/qfVKV5D8FZByX6OpzkfAr6lHPxu2psQlWaaZAmgCpZRgJrjDVQJyeDaDl7ftNhNLKBeNmFdAck954C8tu5RudIJ62JuU1oZRsgnl430NySYfsIySiWeY4y8+Q76hLPi2Y40s5fGYKv7SWKwCB2W1trJhsSC8AAhIIGN+oxdiKq+TsiexN86i1cizUWi5LeyhtDE+jQYpNBOBtubLrdBbSYwDw==
X-YMail-OSG: RDNnMhQVM1kOan0f0_bwS9_dJOExj1MVrvJF2PHokCd8Os9fgxQ9AqkXr6YG3L8
 yNrMjyay7fRiC96wvOU1kE1ZqnXx_jpAYgBWpoco_c6LMShWz_nADO.4g_5hWZVuYFUfnCkznQ3h
 hcuhbNlrshJ64cp0lKUy.q4xrng0AJfvEjwZjQf3YDjsQ.lANUAOHwRqJtxQ_PAaPe.4LoVzWUzQ
 HW6tivEruOaWiNX6qIXh54d9b_NVEhazQCWcFGaash7lRV78_awbdYVzBL6qD9N.PMgX0mf73YVC
 gmiTmFtswxwIIDyMzFYyMN4KJfB1L8ERhQY5.QpedR6O7Ato35mbqD7wWYSSTuuIOYyVEDG3keJV
 uaxP74RQ_FEImlZsY4r6Mexh7hLeOTF_B1C4fBjpiAxm8kbe5kVIszKeIOHFh1fb1nHFGWXzu3ZE
 ExAIvqdySSWYH97Qdrditzmj6RsLYPzr5dK9zqJ6vXM8TAyjOVInce6ZOyWH6wswtBg9Qfo2nONM
 gfLdFXlYFq3u5yTB.ErO3YhJB1T4NmRYUTwNxHedsVTzCZ5DEO98.ybDA71cdTVFkVvrpTIqDWN_
 1aZRTSWhcmlRYUdlCVz3gQ2252THI5ymCtLwdyNyLtv4X7BfmAME99cPq6BUJQsNRaYJ0ozElPBA
 Z5wgIViAvQlG7KPn_PGv4Whlw_iKNyzp.HZ4b.rmiNZH95xmDTP56No.aZhu2vklG1eYxmYr_5ed
 ik6YTWLQQNg7_Cj6JNKqwnG.2dqZShteBVjrAbjh9Y1dIRaykp4Jzj5T9gDa6wOjKNMRyrcpvnIM
 J5CbUs20m2wbqUtk2LjmgHg7eOLRpIF0qnIZ_SQwY4jcShY3SckM3Dd3_J1m4flemsOaKELX.xBP
 dQUh3SPgJhjxVyyhQPp81aC0QrPcZgIQqyZUtmpoQAtq7qhClurYrAuFmqmeamAmouALop6aoFup
 02ukniS8lzmUJQIZgyjFcCCh7D4N65lFsDw61aOn0341UvSyTw4fukYL42FiopAiz0.wcEFoSo_0
 .gUCeeWirzU8WD.2FuSlXscAAIcnU48zicqMsHqqijDAAOBrKd01DsIjauMHofnjrLn4tjIoGYE9
 ._XNSvOZS7vgpVpWRAfH0PUAlPo5kOlPXVwYg88oP2fZPVyqvNmy3A6iesfLnQBFa8Bu6BGCFAw.
 eBYdjKdacsqhnHf5O9huiK2JSgjmj.N7FqDu9HZVYCiyStgQaPm5.UIeU5D2oZ2oCQC9Z.32mWVU
 wsqb.8U5lSnhXR_1Uf4IEZi_9sI9EfCBosL3unRYhUgIi2nkQcQfhWKi4cl4AY0lBULaAJSS.Ko5
 LGblzX7dSK09mq_.Qulh2sQ11NhCZVW3ruiznhSHsAGu2KgtH9xj1455AmS99YcKCiYhQftqbmY8
 OjnNxmNuycbZEIGJWeS.On2Z7maNr.RYL1cIATSVomSDlSlrw6wfE.9hxEy6iPbYE5gocRt_If62
 jkPaALgM3G8w1JKo9hSVfpTCReqHtYAIVcT947CNo3zXgaMN5Mwq.Cy378IpkmO3TY8PuvNoFQen
 _PGUbKkB..BCsDgboOZDHMU34RytHOcgZCOyy23Tny.U8JZuNL6orVU3zStNctkbhi4CF1CAsNUV
 ZjowYACzvh3RYckGV5T8_2xzzBTvTknVLanttXRhOjcd.vxKjWQkVer15zLgwsPJxkfrypq5eZjZ
 JuxEfLj8RQH58NRqA2SvcEugAKFTN7tTS4HVzBolgrwbTlHeMfApFMES3sZbqh6yFR_h6ltAU90d
 amqK3vosafLlj4VYvSOpFh4Oc7a.WaZXCTStBI8.8Yqyd12awBZWYqxmAnHDzNMFn2CKrbakmkK.
 OaEHpfueWybbKDGSJvai5jFmnzYWcbiLkOOXQEkGmRbbpm378tlXwTEn4MbK6mjuB85MFUV_YHRo
 1Bv_ECzgSFFkvbm0IZN3ZrdfFqd6c5nI5SIDStagTpwFAu1TSZ7uw_.U4tuJ1HNXkKuPctPcfyF9
 73fSDb67YGetWpk3YNyYixaQkXuHtY50xGBocX5hlNbEznoOCzU4Y1N3CTLkC5rqfMlcT8W9RYgv
 hF06w_UGAXim16IMzgMUzP077ezkbAC3xwtT.XtNAN2uDDCoTCFLS8S.tF2_udZnTVWYDru2MGs.
 h3X8HxrxgxYvPNwiUN3z_nVKCxTEHiPXU09Sfjycu9ctTw5moq9rCpf6NB_V9Oy0p2O8oFhAciG5
 6WPnNkiwm3AluUvkPEfJcqofs7vqEFx3QifctpH0ZQg1cex3QfgReiXcY3enQD3_fgq1F
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bb1eb27d-23d0-4784-a7ba-7380087a1cd6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 1 Dec 2023 00:12:22 +0000
Received: by hermes--production-gq1-5cf8f76c44-ghgt9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8e72cabee57e1ff435827461e65197e2;
          Fri, 01 Dec 2023 00:12:21 +0000 (UTC)
Message-ID: <57ffb3ab-c877-4898-b01f-d146d6314b22@schaufler-ca.com>
Date: Thu, 30 Nov 2023 16:12:18 -0800
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
 <018438d4-44b9-4734-9c0c-8a65f9c605a4@schaufler-ca.com>
 <9c7860ed-b761-417b-a9ad-bd680f2c8d16@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9c7860ed-b761-417b-a9ad-bd680f2c8d16@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/30/2023 3:43 PM, Roberto Sassu wrote:
> On 12/1/2023 12:31 AM, Casey Schaufler wrote:
>> On 11/30/2023 1:34 PM, Roberto Sassu wrote:
>>> On 11/30/2023 5:15 PM, Casey Schaufler wrote:
>>>> On 11/30/2023 12:30 AM, Petr Tesarik wrote:
>>>>> Hi all,
>>>>>
>>>>> On 11/30/2023 1:41 AM, Casey Schaufler wrote:
>>>>>> ...
>>>>>> It would be nice if the solution directly addresses the problem.
>>>>>> EVM needs to be after the LSMs that use xattrs, not after all LSMs.
>>>>>> I suggested LSM_ORDER_REALLY_LAST in part to identify the notion as
>>>>>> unattractive.
>>>>> Excuse me to chime in, but do we really need the ordering in code?
>>>>
>>>> tl;dr - Yes.
>>>>
>>>>>    FWIW
>>>>> the linker guarantees that objects appear in the order they are seen
>>>>> during the link (unless --sort-section overrides that default, but
>>>>> this
>>>>> option is not used in the kernel). Since *.a archive files are
>>>>> used in
>>>>> kbuild, I have also verified that their use does not break the
>>>>> assumption; they are always created from scratch.
>>>>>
>>>>> In short, to enforce an ordering, you can simply list the
>>>>> corresponding
>>>>> object files in that order in the Makefile. Of course, add a big fat
>>>>> warning comment, so people understand the order is not arbitrary.
>>>>
>>>> Not everyone builds custom kernels.
>>>
>>> Sorry, I didn't understand your comment.
>>
>> Most people run a disto supplied kernel. If the LSM ordering were
>> determined
>> only at compile time you could never run a kernel that omitted an LSM.
>
> Ah, ok. We are talking about the LSMs with order LSM_ORDER_LAST which
> are always enabled and the last.
>
> This is the code in security.c to handle them:
>
>         /* LSM_ORDER_LAST is always last. */
>         for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>                 if (lsm->order == LSM_ORDER_LAST)
>                         append_ordered_lsm(lsm, "   last");
>         }
>
> Those LSMs are not affected by lsm= in the kernel command line, or the
> order in the kernel configuration (those are the mutable LSMs).
>
> In this case, clearly, what matters is how LSMs are stored in the
> .lsm_info.init section. See the DEFINE_LSM() macro:
>
> #define DEFINE_LSM(lsm)                                                \
>         static struct lsm_info __lsm_##lsm                             \
>                 __used __section(".lsm_info.init")                     \
>                 __aligned(sizeof(unsigned long))
>
> With Petr, we started to wonder if somehow the order in which LSMs are
> placed in this section is deterministic. I empirically tried to swap
> the order in which IMA and EVM are compiled in the Makefile, and that
> led to 'evm' being placed in the LSM list before 'ima'.
>
> The question is if this behavior is deterministic, or there is a case
> where 'evm' is before 'ima', despite they are in the inverse order in
> the Makefile.
>
> Petr looked at the kernel linking process, which is relevant for the
> order of LSMs in the .lsm_info.init section, and he found that the
> order in the section always corresponds to the order in the Makefile.

OK, that's staring to make sense. My recollection is that there wasn't
an expectation for multiple LSM_ORDER_FIRST or LSM_ORDER_LAST entries
in the beginning. They were supposed to be special cases, not general
features.

>
> Thanks
>
> Roberto
>>> Everyone builds the kernel, also Linux distros. What Petr was
>>> suggesting was that it does not matter how you build the kernel, the
>>> linker will place the LSMs in the order they appear in the Makefile.
>>> And for this particular case, we have:
>>>
>>> obj-$(CONFIG_IMA)                       += ima/
>>> obj-$(CONFIG_EVM)                       += evm/
>>>
>>> In the past, I also verified that swapping these two resulted in the
>>> swapped order of LSMs. Petr confirmed that it would always happen.
>>
>> LSM execution order is not based on compilation order. It is specified
>> by CONFIG_LSM, and may be modified by the LSM_ORDER value. I don't
>> understand why the linker is even being brought into the discussion.
>>
>>>
>>> Thanks
>>>
>>> Roberto
>

