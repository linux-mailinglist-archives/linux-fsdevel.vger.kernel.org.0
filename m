Return-Path: <linux-fsdevel+bounces-5390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30E80B082
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 00:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE4FB20C8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD35ABA5;
	Fri,  8 Dec 2023 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nNs3yh0a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F50510DF
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 15:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702077675; bh=zmktPAx1Y2NNKX3vQWRJhNlQukhB/fvx3NWw8ob6r6w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nNs3yh0aQc8GeM4tecwPzOe+aFX7OgKA1QHD7WKJxAISr9goVr00sQHvKdP7OgKMsJVGTELMSt/fqNATETxbXvfAqNCuNjpjem3cCQNlHfJ1cU7y7pcetgqftyr+puN+rdAwAReZJ/FnMe6egX7N0Rii1o/FQth8Ih/k+YlRgbUKkY+T6iv0uYt1ho+dkLPvYLJODoCq1JFMXqI6y9afhp/bOCNaAd2W9/bG2SKESrbqU7OFPwD7NYL46ss+sx42PkL8VS+pPfy9QbsLFsV4xEhtMB9/bAQD7+gsc7S/8tMeMScaeunxf3mjAj2sCzo8F/6qOZo5i9QWWWLKAdhhgg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702077675; bh=hGCwInpMiMlORoGPfYBb2hI9Dhi8NfWjKyafm+ju3Vk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CGHOQt/l4gjvxDkNcv7fmK96LLSt/oiA919u5vENOcnKqcdy2f2CT7PsEmZTzLRnkQHlFbR2Jt3zSEXy9OBg8JLnoQvW0wB+rYygVjnPyUzcErpJYOtt+bo4MKJF1a1X3yRDmF9j3X8FUO8E4OdGI4bWWsi4/jAyotaqNyYBYHLP4pbK8a0ZRbvIiOXvxq+OMWQfKQmRRsC8dkdJVLMm/HptCUl50IpUhuE6X+fXtq0muXOQyrmSXiqRcm//GGYF7gKpxy2zkTVeCETixPeEHRC15lxr3TbFv7Axo+Gw/O5IzywBPrcC0ivxhrIb5sRGy2pxgBaf4BBTs8FhS27MdA==
X-YMail-OSG: 0P1HWBEVM1k2JknxEUnYZcR8WU4ClwcIS_6Dp8bME2OLmEcbSeP5_LDMCdRcSwR
 J51d7Fa0tiHPJzj3w04GWxg9CKnCaQpN16N_Jz8dNkHuPtZWvLyuSmxCSE2MDoEvtKpoGbGorWL9
 _DZMsctTxlAvslWyiLTbDDoQbt4Nx2SVq95HuG5dnjCo6176zSJIJnOTES8v1WE_vhBDJE19AK2I
 n6FMvQNkzOS2vW8D_eN4NvEdWfCYrYwJH5VO5heTwMOx4d27bGtzfKbUQowJ7bxmpHFfNi3qzqqn
 MPujw5pH5_z4qnyvrk9t2ysBOU74sIlARp9hc7V0XZhi1KEzdnvF_x0XTsPEmLItRlkkSWKHl3Fm
 HTkbknuiQ2cj_rkYdCopnAHywvH0hNci3DpZEB_2WXMVuGTiw0LmP0o0OX4W2xQ4hDzm88tEFmNE
 LJBAynP4lX4R7pAs1Ms6MAqWILjnFYKkiEyNC_WjqKjFAX37Vhig7P2Nx5HArqFu52xtwOSisSiO
 hEnWBZSjbIoVsmImc2.wwRxbjtuOWymbH3RUVWxC8uXzci9WeL1QcMAgmowYp_mHkbGXrLP7l91U
 LzhtMyRw9pyQTXItWnWqTWFrKn.exEyl_TdfNehFP2kruRvutauX44t3uZXZH6dLE4LHDj5t5HdC
 xJRbcfxL5YW3jGyse6UwGh3Z4J.WgGTbVfHgk3bObsE4YU70zAmvi66xkzSKfLdGDQdN53h6v5_S
 9CQwljnbVJKEcPAf6wAJVOwRWRBKx4.kvxPMLsvFygzYfpckqOXK1tr5So023YFKOSmygtDIBO5N
 KGBFRtmc9cCr72pBNxFgKAELUlAq65MNfCr3zA58kZGQIRmIB0nB8V3kYn3kYDQ3lEwBgmpZ4oq.
 u1NkprquSDh5F0h9Mu1.8fU5V9cVOhyc_RMb_NMCPLdejm1juKacOCj5JneNr0qEissi26eDIoK7
 .eZN2Q33S6_IQLHZTu_Sfz2VKSyx6vpWeKyII3hyhi3UJcpLNakmUm_z_KqYX6x6iCdVRCOjd0jn
 vLBJU0hiduNAw2b3WDEzM3q4GCkWc6A_gQjCPhmj5G5hPdtToquxMccsB4nMjSx.Da9Spk1XfeN.
 2MuXUrUMwun46pYDr4G6yCFja0Fae74Di4OKmUuUSo4JyQ688OyErjuoi0hoA3rzqee87756JgoC
 z1Muy8BTTODyo.GW1OQl_Z3ErDwJ0glz68keVWFxYxSNIKCWXNkDmHqHJ4gwq8z8u0znKOMzLMVv
 1yKH.MyJEGaWrxuEezvfIKhyVoJy9Jdr1BfxmoIcIilaGRas7Daiyzy2KkJBLhIJpdM3zocgbgC_
 w9zPDwd5jVYLpjxNTgw8ZTCBa6mZzm5dR7t8FprfrMycpI2MDEiCb5T24XaDUaQ3NR_AUCnRmGqc
 VX4aYUefX6XCqPjJM9JEOKZmxV9.k.odlNiqnfZO.eV8YG4mZgDOgsUZVfeEKRJYzdX90zUL3hc3
 zA6JicL1_9Vqp_k5YYpIcXkdHur8c1vaIZ8449U4MrhuO7A60AnYmpABn5WUFuS1fiMKGaGLrmp0
 _gTq1ktBp5bHDLK5jCMW5.N_lSlY1FgbqMgV8p16DBg05ydd.AUnmxoYVJ9UQYWbETHwXGb6jE2i
 Er6887VsPaZsb80ViATW6LDdWKokp0Tt1rrLCmfgzLW.W8.x6cWBojJkuRAYsEMUn4yGbk8WSB58
 dzwZ_3KiMHuIePLuFIJXoiUXgnqg9F2TmPiney0oBpd6xGUIzlrdKV6fvsOEwgqFal6r_RnVbEHE
 k_OXz.7Qt6LanaU5W3KH7238N4UnPabdvHdNm_Tj6SZEI36F3PCQAXyf04XJH3se2InNTwAonnsq
 QRHQKRG7ForbpvwY40OhNE4jrdV5x.lfi3EwgUNwrDIH2THIzGvyuNuERIRvGir2KkYW2S82ItRs
 Ummc5bUDDQEs_Ej1Ot.RvjLfCJ6YXtBqLNAIU3KqUHrtYJjVJkww3_jSgn2DT0tiwEu55VYNL8hv
 2ma1GszBbgaJmwvKF4tB9O8ifJ4HDn88xa_NeJUxFD6EoYr6MUXAL_JPc7NBL1kPfyTqlo.SCe9f
 WT6WHLnqR4l90n93aGr_68VSmQApRYbOv_DUqQ9EU54bEIUWHfQLUHsAU3DZ6ml30VH72hk1gpnx
 7sfMRuKgWFq.y84M67XfkM.McDy6YQ5z__cSspX9QqFn_IE1KyzM7pn33PjafdSVXuR_3I0HJkdL
 DMZAqfgsbeMhEy_MBxeTlHatiZPpJtGxHGiNY0duTY43kwrs.Ca_SOiB9zpsiHaMpcO7kBZf9.UY
 dNFr8c9Gbtw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 220c0c16-816c-435a-a204-c3b2b08f8e2b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Dec 2023 23:21:15 +0000
Received: by hermes--production-gq1-64499dfdcc-m6m9b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a8cf71e3161867b91ff40b8c25efba98;
          Fri, 08 Dec 2023 23:21:12 +0000 (UTC)
Message-ID: <0c0e8960-9221-43f0-a5d4-07c8f5342af0@schaufler-ca.com>
Date: Fri, 8 Dec 2023 15:21:12 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security
 attribute
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Munehisa Kamata <kamatam@amazon.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
 <20231208021433.1662438-1-kamatam@amazon.com>
 <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/8/2023 2:43 PM, Paul Moore wrote:
> On Thu, Dec 7, 2023 at 9:14 PM Munehisa Kamata <kamatam@amazon.com> wrote:
>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
> ..
>
>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
>>> at the top.  However, before we go too much further on this, can we
>>> get clarification that Casey was able to reproduce this on a stock
>>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
>>> this problem on Linux v6.5.
>>>
>>> However, for the moment I'm going to assume this is a real problem, is
>>> there some reason why the existing pid_revalidate() code is not being
>>> called in the bind mount case?  From what I can see in the original
>>> problem report, the path walk seems to work okay when the file is
>>> accessed directly from /proc, but fails when done on the bind mount.
>>> Is there some problem with revalidating dentrys on bind mounts?
>> Hi Paul,
>>
>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.org.uk/
>>
>> After reading this thread, I have doubt about solving this in VFS.
>> Honestly, however, I'm not sure if it's entirely relevant today.
> Have you tried simply mounting proc a second time instead of using a bind mount?
>
>  % mount -t proc non /new/location/for/proc
>
> I ask because from your description it appears that proc does the
> right thing with respect to revalidation, it only becomes an issue
> when accessing proc through a bind mount.  Or did I misunderstand the
> problem?

It's not hard to make the problem go away by performing some simple
action. I was unable to reproduce the problem initially because I 
checked the Smack label on the bind mounted proc entry before doing
the cat of it. The problem shows up if nothing happens to update the
inode. 


