Return-Path: <linux-fsdevel+bounces-4671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A49801904
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 01:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE660B20A09
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950215A3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Hp5te8DH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D09FA
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 16:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701476272; bh=vKch3QidsuxeNNUIf5BQBU9Qu0C1vHbp3o1oqGZ8nvE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Hp5te8DHWWiWN6OZAsI5TOQNmHt1bZp00z6SQumtV+OGIkNwxBIvn7LJ14jQhADT/Wm+EdWbpTokg8zGxhSPSusVVD+nlXl/l7yV6L59Ehsq762zMu9plciWEfsAq2ILSWhmswBaqgmlCozM8OJPC3KBp8ZbDk096IQlQGYVENhUyQ9oNmeHFIWQi0UiO1VOWSDsEDuWAKFFOrc71n6JreKfeh87NvYz7w/xjABel3xxf1VoX+UTn/6+cwYN27wOHC8Zr9xa6X2GUAXbqT2Q4sUuviVEamE+tVh/3YPslrLPBG0a64IEv6OsPj74AQ9gYlOC45I0Bb7lMue+xypgMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1701476272; bh=M5MduLpj3TKXAOuEBT3K7WOY9u5VRwc9lip4GMKOe1M=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hwZA+ayTaaF92lfeoHdbwJKQanK9SgWRnSOg6/wn3TqePJdAzVTtTOaH3xNuYURg+UD3KEB8jnXnEta202yQMkPeTPVmN7Bn+ImbII5z22f0t4Tl4ARF/ewJCZYmtkiNs6HLe/BXUDAa0idseWoly3xmRFKipv8Kzm44BSHUKjwD+OkRIfT5ZvYjT8f3AwF62Zc7TZmAbnS4IZcEBvYRiyElZK/L1J2OBRvFyHf9+/FuTN+QRJ3BeWdczaBjCFIGnqf1Vzh92SKAnZC351qij0H0f6Gsa14V4s1B0u64ddNXzP7gwXgGwgVldxkJVeKGKv07F6E6dgIjs0SPocCBtw==
X-YMail-OSG: t.RdoVYVM1nFBvtuL0drGI2s96ZSFPYGBAuHuvTjYh5rC_Cg_6nI4cwj2zbsmw3
 vjK.3jmTc7yPl5_8JCRwsWzcGZGycG3hBniKi7.ULGasOAeq4OPoCDIot6CbZrBOBsUjKttXWzST
 XIbhh8vrRvMXvjJvcOlpqBPGZLpUAFY6BsT6xU0vTYPZeMN4tZzcHweBl5WRuCh6dLdAARC_GCII
 8ccdgBatCwwMqTUE8yjHx_.FAcTRcfmkhmMZfR_KYTr2JgjaLzpRAkEa4n89qN10U_RTJ1LVqC_2
 CRbjdlz1MylBuP2VvytpJDjMWkDll5Og2D6r3jCsKjQPXYGUBAf1AW8u4hhqB4AVNYSDqJRFkRx0
 ejvOG55DBaXZlF6b21aAiJhh6otFMOe7bM_UPYXhe3MifQBPho23Q.7glZVfY4QIfmi8DBFuA4Ii
 8YQ.ndAtrkO0o2eBH3z4reSshKXbKenBp6rU_th9nnywr81muU2ls1EsSl6jq7Do7OrWf7T5d3Ea
 DaaiD2OEA3TVwGBR.Lr4n6xcKjCw6GxQw9NrTUybVG.EsdtKxFLgAOQjfnfk1NkJSetHxfl9Eb3G
 h1be6RfTpFRXWxOmjkaHraVauonRObxoVKMntNdiQnatd8XslCJzY0Xz8Ry_MMJ15DiHWeCMadon
 Y4DDurJki8KwsOKsfBo0ezuRfdgEEGNXbiMU4uAisOwgDKCmBiNZ.JQS6336E4k0D8Wj8oemrJIi
 OCub.H09qVfewPB6OAdsNOGpY1_TXUgew1z56dSHKrS1xsK8XQjyWFxrjVT7fGjFZcuGSD3UO39Z
 _6JWcICfEJV1XYJrHrHG1HRlb80yxo23JGiI.QmmWInKf720ixPWMdNeg6G8yE832VOrQ6v7e4DB
 3gE.5KABJYTmYLWUzZVucsv_2gxlPVeeuoDJAPixoNpfUgSmAeypKkO.5iWdMQxFb8N.KLYciXpR
 DlE9LoBDDI2iKl7t6lfIEYfRIt3iHivMtVEFJPtLjypzQftwbU8wr3ZRpgPlaXWdEql0jjCk4.gB
 JMRQeKOpa_1yGY_OSVZsSihlJaqC53XFoMQLlspYyKAOEeToKz.GbtOaUwWrl8DzHWgxv0grzAaG
 hoxED2x.mM4G0XoLxul0PHz5s2QpmnvLiy5ddZUqnEK98hKxX1hlbI7yBJckmwDlvOMUx32Dfv6I
 neZmEfhrhSzUJdckF.z2Phfvo1vw_52sQarmRm8Mk63pcqyXEyxWdGaCrxlcVr5euXp_VUqSEi.C
 HupNbNa5g2xrNvIMfLiPo6Fd9BpvskMisatUTK1ITadC29yLq2T_YhJi1RzGv2KwE3oiAsN79q3N
 uwUlUW_rMNyYI_1_NyngPartsWTS2BGr5gd38BP7QOzBMYQXlP0kMG0SbOkBoZ7AWPTZX1gpsvfK
 OLmsd8DEQmtVCow0oqGx4iek1AnrZJF1KqZtB_rSU4q4PGP5gPm2RN2XYLJgAJFgujoRHFdWAhS6
 YCXywgR3NJAng5LRsxzCqtsbj37Nvp4aQ.Loj.1XsHL6e.Z4KbSEbIDeXUu0e5EJyPOlavcTqUsd
 p3Msnp2uNZCRNGQ.RN46_7vIOE3NQdvwnOcA2R6R.LG1rGCdlmIVbVp0OekEJNa.u6E.uwx3tuYw
 mYE1wgojijlGhKeUpvLVLpkjs.pMRtYtcypa19zyvwNiwrjppREs5TSdf3fLfLElU57tWRnNI_sH
 WSZ8M1eDoC6nzY4aggeVaQd4klnxYaa2FLnzaT4hdObE2o5Ma2b.l4BRM2ozYkNkvOUgFIAwkktE
 WGKKEqxcmrsG0LYJXhqka_qwnRSTs_wE5OrHS14z4CvXbDmCLwJLMMHmxSD4MmzZxyZo0O7wFjFw
 7neY7QGB0kxxbZq7CrKVuSKD4EiG4C_Kvo9IadFIeGuRyhSWXKjxJGdFexnihknGPApOT7Vb9mhX
 SKbnWWkaaIk9w8qjpLxphAsoocIfx.gEg5KcEE3H6VCsIS_sJXcr6ruWeUiS8iH8tfGyklzw7v0z
 1vWXZeEPTc.PjKsAoRf1WuxOUnBtITGG4b4A.9w3W5bh.ANt.YIUETjWqh1HF5514KiOLlt4nWdE
 vA4Syk5goOMBFhCSt44qT8I68pkzG4eHJhaF7vqYX4QgDsRCoV7G7g3RDq2Z1ujpqNpG9IyCkM4s
 XV_AdSGkwWu24vmh.5rCvaIFFpkov3joqMSNHF0YSm6YdhY_XZvis3cv88KCFlqWUZLR_N5YqO6J
 hDWDt6aiNTRdROnVzdGQrjZwXytHRcVCjxBw_ubrv0Ag2Dn9xyjlGZaen2w--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 99b119e8-4acb-425f-b796-43590d472285
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 2 Dec 2023 00:17:52 +0000
Received: by hermes--production-gq1-5cf8f76c44-d5256 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 686028d743dd20ff6402fe24e5d0e2d9;
          Sat, 02 Dec 2023 00:17:46 +0000 (UTC)
Message-ID: <876cdd6b-6082-4503-b2fe-3bb11c30965a@schaufler-ca.com>
Date: Fri, 1 Dec 2023 16:17:44 -0800
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
To: "Dr. Greg" <greg@enjellic.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
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
 <20231201010549.GA8923@wind.enjellic.com>
 <660e8516-ec1b-41b4-9e04-2b9fabbe59ca@schaufler-ca.com>
 <20231201235332.GA19345@wind.enjellic.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20231201235332.GA19345@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/1/2023 3:53 PM, Dr. Greg wrote:
> On Fri, Dec 01, 2023 at 10:54:54AM -0800, Casey Schaufler wrote:
>
> Good evening Casey, thanks for taking the time to respond.
>
>> On 11/30/2023 5:05 PM, Dr. Greg wrote:
>>> A suggestion has been made in this thread that there needs to be broad
>>> thinking on this issue, and by extension, other tough problems.  On
>>> that note, we would be interested in any thoughts regarding the notion
>>> of a long term solution for this issue being the migration of EVM to a
>>> BPF based implementation?
>>>
>>> There appears to be consensus that the BPF LSM will always go last, a
>>> BPF implementation would seem to address the EVM ordering issue.
>>>
>>> In a larger context, there have been suggestions in other LSM threads
>>> that BPF is the future for doing LSM's.  Coincident with that has come
>>> some disagreement about whether or not BPF embodies sufficient
>>> functionality for this role.
>>>
>>> The EVM codebase is reasonably modest with a very limited footprint of
>>> hooks that it handles.  A BPF implementation on this scale would seem
>>> to go a long ways in placing BPF sufficiency concerns to rest.
>>>
>>> Thoughts/issues?
>> Converting EVM to BPF looks like a 5 to 10 year process. Creating a
>> EVM design description to work from, building all the support functions
>> required, then getting sufficient reviews and testing isn't going to be
>> a walk in the park. That leaves out the issue of distribution of the
>> EVM-BPF programs. Consider how the rush to convert kernel internals to
>> Rust is progressing. EVM isn't huge, but it isn't trivial, either. Tetsuo
>> had a good hard look at converting TOMOYO to BPF, and concluded that it
>> wasn't practical. TOMOYO is considerably less complicated than EVM.
> Interesting, thanks for the reflections.
>
> On a functional line basis, EVM is 14% of the TOMOYO codebase, not
> counting the IMA code.

For EVM to be completely converted to BPF you'll need significant, but
as yet undiscovered, changes in IMA and, most likely, the LSM infrastructure.

> Given your observations, one would than presume around a decade of
> development effort to deliver a full featured LSM, ie. SELINUX, SMACK,
> APPARMOR, TOMOYO in BPF form.

That's not quite true. A new, from scratch LSM implementing something
like SELinux, Smack or AppArmor would take considerably less time. Converting
an existing LSM and being "bug compatible" is going to be painful.

> Very useful information, we can now return the thread to what appears
> is going to be the vexing implementation of:
>
> lsm_set_order(LSM_ORDER_FU_I_REALLY_AM_GOING_TO_BE_THE_LAST_ONE_TO_RUN);

Just so.

>
> :-)
>
> Have a good weekend.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>

