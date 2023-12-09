Return-Path: <linux-fsdevel+bounces-5414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B27DE80B5EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 19:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BA5B20C42
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9F19BCF;
	Sat,  9 Dec 2023 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZBSLFcxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2B7E7
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Dec 2023 10:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702146906; bh=/JiTsY4lxJVwDFPT8/4wmoTIqrFQBrK+LdycBT3X4vQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZBSLFcxU3NQeV3kjm26mtoxp6WuWwEbcs7QUEyyBI0ueI9xpIERiMLX4kZH5OxR6mFy7s86VTpQti5YPV9JOJT40YCMSDUkzQd+YOMTJYtLIjcsDVlFKewVd46MU2VHdL1WVfroYewV3dI/y6izTnCDJyjMK2q0jWUvu6LdcwMRIaYV5XY9Fm16Y7OP5vUOmSyk0Xwmrmwt1WuuK79iepU+iOSfNelpbovZA1n39sYA/ZHjTDBVxr3fQq/fNBBCexgR2GjDhjNSajC7vHm0NWvefgD0EAU+csbBNtwuZxMxjIIF37OxoBoGpYoVIKvZc/oHgOQKZLuL7zVN0o62uqA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702146906; bh=dxWHljfzlzvq2Ur5NjLZ7kjg62mLp755zX+QQ20k6Rd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tjRIFA1ph2eldnk0FQWf2DwWbE6Jv/Gyw7WMz6rDcO4/3jjUylFKe5uYOBl1NUhREVBPOElw4ufTvSlsM8VFq9FyaNLYqgFCw/3BS7IlealNAixhO+btmgfPV/wDE30HskhBTARNOlqTB5TON1ggMbQk+bSmkgJJI6in/wFj/slSOnf7juoARLxn1t7VUfdRGcxD1h7usfFWM+jY7Dctsq7ZQ/6Xl1+2rFJNZUSUV5vUpBF0NJETdsV8t1YvXkFBux/TSSDm0rnEzXMmxwrNh9LDES/J4AGz051wJzV4onlz+dyVDhemqJ+xfizWLIUHJeeQ6gh/zUyoCIGEix4wEg==
X-YMail-OSG: D07RrkAVM1mQ1y2q8UIXGqXzkbWxKJ1r7ywDXvLAeAl0Mg.mmMdmupbfBt3hBDa
 5NYU3DX6qDxIt2tWB4cdWcHU4i2gWSNJXbv86gpv.9xSELS3pRkjB3cPcRzA00tIHxlZptjqVeLy
 VS1kc0hTsod1X59rHM82WdQ1auvqlvCzoWb1pyLgcWTPehoCE8vCLgHD.4a55QS3SJZ8I6XhALgz
 sJ63KmaazivaqtUK8SdDqvdZid0SaPT70mPF.QLAkMDt592S5wSEpXscEDxNhKitUY3Dnv1AuLSD
 ZTkDvyvk518rjBJT0hGoorUkhnkO64L732x0Qbfqb0Kzgo.Hx4toViSRuHARj1MwjAoOXxRRPZOM
 e3CDqX4y1Dc3kG0NT5di2RiXf8xcgysR0dTUrIAF3Fv84SUoQBZ9w0dvecBmvSXJggIrJLsdUC8B
 wyZC9ELTEcMEDH6SfpKct5uuWXEm.DLLH8L4UvuPJlZYycMhzuUquzWQno.1BG2cQzGowVm9f2Md
 BaDpUXK2ChTP0fwopOroU8XI7x7dCMBV2Fo.WO4LbpwjqsX9OdS3hgnn7S_EL4Baclz_f2ABF8Zk
 6UjpywJy0PgO74qwLEONqMTJRpk38c74Knjb5uNvPCRKdFnwOsz78rmD_FDL52lwr3nuNLMMu7B.
 sgfg1T07VcGPmEmyKjqUTaalAWnMLcsL7315wHIXA1R3tVmWgAMoQ_HO0Pl1S8xTQFGYuY26YcyA
 7vcIXsxxtVMtn_KOwZUSoLRHxG_GJXxPX4PpKyGEq2Dc3XxuX.q_Tx6Q7WRnARXWSh8z3C2890J9
 AXtpPKV05yLmoXFOfQfcpI.GhqxBG3lKZwKnRt8SNAQztO2FkT4Mit8qqhbbV1.AaKklC1TiWwDO
 BH5m1SKdMn52Mt9xlOk0lpFdaatGBbssPSKaMV2ZymPH80s0YrFOR.Sg84Oxiqpo.DgjIUkb.sMe
 9nPh6RrE6eO0MRO4cyyOYQboA0jL0lDa3DAwFS5xwXJzfPsDkp7N7AgeykIic5lBHVF7Hdb4gR73
 QmvUre4zMKoqJgp2EG07R1Rul7riLLKxVMIPvkQjakee3Hoa2iJ7yimbTpq7GkjRUZFmhN506k2R
 Oyg4dAt_lopB.mE2FGjgF.9o0paWzxnGu4pRFFo5E6GXA3smX_.qe9.t1Zv9WW7i0A4AaNVx_S2x
 W.fmWh83jN1ynqm095FVhWwYGP0SXROOnC4E_zuDzWpxr7tMBeCVLS2gjvzwbIBlXSqPHw_LAowA
 UITObi7aUdx9cWw7ZngUU4EDCEi0Xg3_e.67W5jl.kCUI3gj4EeKx7coqzD.1tAto_vidh_kmegI
 350xhuzhDq0HwdqEf6ZxGplZ1qd0C6ncIkFrmtDP17WZ6.T_RGBhar8nbQgUMqVM20zLxDfY0Rxz
 N.JDtbmpF.QUDBuADievcOs0vK5IH4gb6sU0PCOAhgF2A21HVYDP0ib18F_8lBgtUFHwfdjO3yBp
 EN90zXFlLEh0F.CnOdApG6FoohicPDY.Fvq5dAhmznjMLpw27H8ZI3FKfwz5x3TZWu59oJIG8rzV
 iZTXZyTkyyatmDBmxwQeb3pPXqdSkq3Xgt1_9F5NB7J2nB36XwK4MN0pm4NPYTHFOn9LUP3mj.FT
 vPbXiGZjtiax.zhqnahsl1s4YPK.1oPHcKGERfwMdGqBU3KcuPJXrLzvpb6nLwdOb0FzIjWlLCmE
 WsJz_rEmjkrsTOP89n68VCIkVahm6urkhEiwsdGDUzEWEV5GL6kxLbOjFwMkTk9JwMRvz2Om7Edr
 hbANusomMnVaISTtpD5cVF7nU1etLcWWTgq3_dxLRqN4kX6jzXSaKTjY8LQ8Gh_rqMDpCOaQxEDL
 eENcwcVdF3EnTyNWBJS_ynlCpU5ncNkQ1z36aVqQWuaOAK1f8KuU8l7YQ9CYQvQ2W.ceVT2lYGg_
 CbVzTQzA2_pbDBYb2qlQR_XH8w6BM7TDJ3g8vlceZjaDTYmPjT2Ulqema4X03tYBPRhM5pQcaL_k
 88n_vB0WEY1JB5lAO2GGY.tovmOHf8OkuSitTxIJZe6D3lPM7o3_ZFKwjkT_06v8ScHNRoluW83f
 1JAlNXBpU_mueMrGjVpg_3HbionhGGuqXmvEFeLrrDPXtcZomZXCFKHGfsKTDrmm8vOUUxolIJtj
 a5zLwtQeE5uEJ2VYhjTElh9K5CrqQtPpc8rmh36ijoFwCUkdr2WpOymchgTFQUskLsfsXZyn.ZxS
 07nLDRjq7wlqx9oF68f.NguSzjMlUWFd5_0JMUO0eeDiPHYj_nDlzr.dVEApmM4YboAFni8EEJ07
 5Krx4
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 283aa0d3-e2b7-46ae-a1e0-eb3c058d5ab9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 9 Dec 2023 18:35:06 +0000
Received: by hermes--production-gq1-64499dfdcc-pz4mv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3f5a83e34bd88e44fcc3cfb06ae007f2;
          Sat, 09 Dec 2023 18:35:02 +0000 (UTC)
Message-ID: <5b61d1a4-89a0-4ec3-9832-9cb84552fba7@schaufler-ca.com>
Date: Sat, 9 Dec 2023 10:35:01 -0800
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
To: Paul Moore <paul@paul-moore.com>
Cc: Munehisa Kamata <kamatam@amazon.com>, adobriyan@gmail.com,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
 <20231208021433.1662438-1-kamatam@amazon.com>
 <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
 <0c0e8960-9221-43f0-a5d4-07c8f5342af0@schaufler-ca.com>
 <CAHC9VhQyziaxvbCCfb4YWQ0-L0qASa-yHG4tuNfbnNLecKDG0A@mail.gmail.com>
 <7ba17c0d-49c6-4322-b196-3ecb7a371c62@schaufler-ca.com>
 <CAHC9VhT_m6+a2fOCJcdjhx0dUdWDxtZEu3yXCyy+1cSr6GFBag@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhT_m6+a2fOCJcdjhx0dUdWDxtZEu3yXCyy+1cSr6GFBag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/9/2023 10:08 AM, Paul Moore wrote:
> On Fri, Dec 8, 2023 at 7:24 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 12/8/2023 3:32 PM, Paul Moore wrote:
>>> On Fri, Dec 8, 2023 at 6:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> On 12/8/2023 2:43 PM, Paul Moore wrote:
>>>>> On Thu, Dec 7, 2023 at 9:14 PM Munehisa Kamata <kamatam@amazon.com> wrote:
>>>>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
>>>>> ..
>>>>>
>>>>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
>>>>>>> at the top.  However, before we go too much further on this, can we
>>>>>>> get clarification that Casey was able to reproduce this on a stock
>>>>>>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
>>>>>>> this problem on Linux v6.5.
>>>>>>>
>>>>>>> However, for the moment I'm going to assume this is a real problem, is
>>>>>>> there some reason why the existing pid_revalidate() code is not being
>>>>>>> called in the bind mount case?  From what I can see in the original
>>>>>>> problem report, the path walk seems to work okay when the file is
>>>>>>> accessed directly from /proc, but fails when done on the bind mount.
>>>>>>> Is there some problem with revalidating dentrys on bind mounts?
>>>>>> Hi Paul,
>>>>>>
>>>>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.org.uk/
>>>>>>
>>>>>> After reading this thread, I have doubt about solving this in VFS.
>>>>>> Honestly, however, I'm not sure if it's entirely relevant today.
>>>>> Have you tried simply mounting proc a second time instead of using a bind mount?
>>>>>
>>>>>  % mount -t proc non /new/location/for/proc
>>>>>
>>>>> I ask because from your description it appears that proc does the
>>>>> right thing with respect to revalidation, it only becomes an issue
>>>>> when accessing proc through a bind mount.  Or did I misunderstand the
>>>>> problem?
>>>> It's not hard to make the problem go away by performing some simple
>>>> action. I was unable to reproduce the problem initially because I
>>>> checked the Smack label on the bind mounted proc entry before doing
>>>> the cat of it. The problem shows up if nothing happens to update the
>>>> inode.
>>> A good point.
>>>
>>> I'm kinda thinking we just leave things as-is, especially since the
>>> proposed fix isn't something anyone is really excited about.
>> "We have to compromise the performance of our sandboxing tool because of
>> a kernel bug that's known and for which a fix is available."
>>
>> If this were just a curiosity that wasn't affecting real development I
>> might agree. But we've got a real world problem, and I don't see ignoring
>> it as a good approach. I can't see maintainers of other LSMs thinking so
>> if this were interfering with their users.
> While the reproducer may be written for Smack, there are plenty of
> indications that this applies to all LSMs and my comments have taken
> that into account.
>
> If you're really that upset, try channeling that outrage into your
> editor and draft a patch for this that isn't awful.

We could "just" wait for the lsm_set_self_attr() syscall to land, and
suggest that it be used instead of the buggy /proc interfaces.

I would love to propose a patch that's less sucky, but have not come
up with one. My understanding of VFS internals isn't up to the task,
I fear.


