Return-Path: <linux-fsdevel+bounces-5392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5180B0ED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 01:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DDDB20C9F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 00:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5312E64E;
	Sat,  9 Dec 2023 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HK48EzTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic312-31.consmr.mail.ne1.yahoo.com (sonic312-31.consmr.mail.ne1.yahoo.com [66.163.191.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923AD1724
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 16:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702081488; bh=FupKcwsUuVApym5nZw09jZZpB4rPXEI1SLNgMEs4q+8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HK48EzTwNvsKAP8zbdk8KsqToT+SmKt9flGHHOcWLJJb/WSQPDP2jbb1exKIOutiMGVxhyekVKmNDStRtzNJz7+HVXz5+AB98U2j39L4p4JbfH7VxQXPgYvDUQ21ps+RVZgyQORdQzInhIutBH62OcFWhAOpeD6C6sgfuF2EWBLmmIQM4c6Fp5wZQ1V5HKnL1Bm08ALHzAo1xXVfLgdMYLSb+8vyTJUf7e4TfdbRHxh29uSy2zrK8eGvMgWFgkZNIqErycsqTumS+oY7bJCXwY85k4AElq2m6B2M9pe2sOAQRZqSJ0fL283LIAurNMfiPyOtsSEkedQbRLuknE/QDg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1702081488; bh=HC6jVNF8p28r7BUwLDpMfbHBhpOv58RB2lzvkNf+ACK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jlJyKTNLPMAmJsNF8lBoTBVZaKpA3bqsyXISf5oERklUlXyRNCwfnJsJ4TQ+l77iat5MnjF3ONptrvjzIRG85WLosD3gp0IxY46XMl1+5PuTbFNLw3r77KuXYayzSzSKhlD3S/L8IMpA8JP0RwP7Fg1CsmFvewmVMaDfUvpRQmtqr3gu7YMQU4eLMD0xkqRDeR2RBLHHwBRMqPo3Nbn6VfqeqsNIZlRN5Zo7FIiqv2emTEAxggI2HJWs11xox/vcLFRUz2EkrBreplEjfVNMUExVAthEeqJ4lA0D7cPPjSvSDmmsLsp2KgPF3wXSWg2CBe0SwFH9C8WA9Qmdl7cPmw==
X-YMail-OSG: Eln5aXUVM1kZY0nGt1wui0hT.BdV9LUiBq4FjOHkggJU9FtczCE.HoCJXx3D4X1
 hRTBCtr.MDIubswTmgREFoIbtMfZ6sFFgMrdshJ91bjc4TBsJSe_Fv9sFGrCvUJ9QJVCB6TZ0pAd
 3gN_kZ8OYaXXDVKKJpbckiugg4ixHlkshKefIbOvifKY80mphD41CiltZev_FAhxI1nVbfJrQQgU
 AYpl1DVhx10ALgZbMHdnUdcfja1W46lIyJMod..8FOaSCcj474dVLab5QEj2O1Bk64dq2CNnXcUE
 RZFwxxsj1jDeaQqoNm6nbmw4Me3wP8u2oVRYaz04v4PV_76azjCOIeCjgVDKtJTrk7vfqUDF_N6Z
 2jsIRTrdrcnUn0M_2Zx6cFvntgzBM.gPq6ixytAAcV5wLk79O08dRfO7G4F73zbftMHZO2Qn43Xo
 gJAozclaZSy5WcfTY2DQfZgxLC4DUa_sMTpZi1vjqQQ.UdLmG0JO9YCKyoH8FqXibbmyn6epwlyh
 AfAIua8TctwKwlUefmuZCzt3jMSVICmD1HnNoF0t5KmqUjdUIucsHZ30MwuS7odRJBZVOubZWnXQ
 pdq.BgGY18Kub6ZBoSOv34KklK.eI9.IqYs5xLwzrvhrWcV.ZMtpC12qmYK_Eq12DfAW78TLrmcS
 ipcLCpPwmaMGNPC4EeWYwEhcAR.z7teBvp70ZgLyOoE1MchoKx7Eh1jF7Rba8wM3IO2YtNP9H_mC
 LFrniH2Ikqm_ITdht5EABx.mCh6vHtWiNhGn8VzamdTDzE7B5EC2.kCYrwf0sBg.aiPlqPK_hote
 rI0hVPVGBjWf3VM1N5D3PGAcNZ9ge7bGSxin2HeBNTHcQ_AvnTOUXKcuJaaSZ2pzLmqXfSLw1MQB
 qZlLeio6jf1ebWPpCSt4SHut7BgeZWa29.kuOWTLRnbuU78n.8be_QQp0nblur_Vl6XIU8A.FmMd
 ebjnCjTNDm.Q9BMj4zc7L_XuBv1fJgpNLMoGUjrAZrmCrxdMNqTuYWIdTc13hKXYxNwYnskJG0D1
 Piy5UrpOxOA7cnlf0WKhAkzSUhSnrNYx9dardwWW2Oad9AJd7XafrSz_Ev0DGvl1tF4WyBfY.p1B
 U2N08kv8wbzdVBxM9VV0WgddmYdE1gh_vUMYVEEKDO017ja0FdbM.hTCU72FFMhrklnZAGXe4WLB
 .cYj5qZSlbWtr.Xd5vBKDhWfkSqBUxfPyYBr82tYTg2nb_NfX_qClnNslpU6D1WGyyHvl_Bm23Tu
 ALvgbTqok7dGtBVACAbcityYQCDt_ExNzh.c0yCTAiQAmRUwgkYqW5onoI9_wsLzE_syfPhdsUhj
 bzoBN4y2OTfcforOEnSr2j5x_i.kraSIXSRWpMibEOWADsh7om7Ogm4EXFnZlxczSuB6jGlW3GMH
 bx4TIZTLrabhoMnwXbFuIfNWZXSLDAH9P9ZxqG3ytmhIMsjiF0Myw8xosEs2h8qThToNw2Y2U0UD
 uooYRlngM3_TwxrY9BqDOTgoVme0I_hdD2nzHBXASj2ewi_wq_BGwxazNg5i.BbkU1CxBBl61mar
 MoGAKoffnSYaY0fruiYy2GDPyXPhdJqmRKpATArzAdiU9sIh7xeU4B3bsH.FIGG5PoNLvsRquCOn
 74zWwG_kIQggzkZnjrOcHo4hMzCJ7N9hl6nOaM_PNOcJ10arngbmUX7xv5AQ38B7kWmY38Q61FfD
 6IUKSCJedmfDR4d7JkufzzGsh32VHhOOEmzdDYvoo3kI6HamD2Mu_e7DPbLc98A9dizxFCQEZenl
 xW7LA0YHpaMyahGqznKGLMyWh8XSQ5k7jwKciu30aj2BJPOVSEozj_Ln0uEvoQRhESz2YnipuOQK
 kADb_R2LiCy3AT.B5E_qpfTgCFWEHACIemNA8N4TO2HhvCxYdktc_8PiwKq2wcxSjpfYPTNZb2JT
 059ZbsFm4tduFtOciMBNZJT7B0n0ZABSqViElop3XIw7cr674Zn5v1EYTrM66tFvn1DQKnp9T12U
 UUFqNaTaxzci0R_spA27HvGTw40I0K3i619cYZhB7JXscQLN8fXcPxozl9dHVaO0gXizafccwy4V
 h6PnfZdXjnlHNKeyXtxj.Hj2cMaD3n2J_0k3Z1PsphrknROudxHN_T4dpnTBljlEy4BCd2IszFVC
 1FyA3myyvlACIcVxrX9JsmXEQ.VVG0V6oOPtQPHlF1iH6FmHvRZAltpemwkKiaYZbLsJwF8uc.aO
 9n6Pm3_jmnTX6bbomdAmXgzEiFw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 755ca37d-fb56-4637-b3f5-07158bf16357
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Sat, 9 Dec 2023 00:24:48 +0000
Received: by hermes--production-gq1-64499dfdcc-m6m9b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7ca408e72ae3d6602b5fa725ef0edcd4;
          Sat, 09 Dec 2023 00:24:43 +0000 (UTC)
Message-ID: <7ba17c0d-49c6-4322-b196-3ecb7a371c62@schaufler-ca.com>
Date: Fri, 8 Dec 2023 16:24:42 -0800
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
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQyziaxvbCCfb4YWQ0-L0qASa-yHG4tuNfbnNLecKDG0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21943 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/8/2023 3:32 PM, Paul Moore wrote:
> On Fri, Dec 8, 2023 at 6:21 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 12/8/2023 2:43 PM, Paul Moore wrote:
>>> On Thu, Dec 7, 2023 at 9:14 PM Munehisa Kamata <kamatam@amazon.com> wrote:
>>>> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:
>>> ..
>>>
>>>>> I think my thoughts are neatly summarized by Andrew's "yuk!" comment
>>>>> at the top.  However, before we go too much further on this, can we
>>>>> get clarification that Casey was able to reproduce this on a stock
>>>>> upstream kernel?  Last I read in the other thread Casey wasn't seeing
>>>>> this problem on Linux v6.5.
>>>>>
>>>>> However, for the moment I'm going to assume this is a real problem, is
>>>>> there some reason why the existing pid_revalidate() code is not being
>>>>> called in the bind mount case?  From what I can see in the original
>>>>> problem report, the path walk seems to work okay when the file is
>>>>> accessed directly from /proc, but fails when done on the bind mount.
>>>>> Is there some problem with revalidating dentrys on bind mounts?
>>>> Hi Paul,
>>>>
>>>> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.org.uk/
>>>>
>>>> After reading this thread, I have doubt about solving this in VFS.
>>>> Honestly, however, I'm not sure if it's entirely relevant today.
>>> Have you tried simply mounting proc a second time instead of using a bind mount?
>>>
>>>  % mount -t proc non /new/location/for/proc
>>>
>>> I ask because from your description it appears that proc does the
>>> right thing with respect to revalidation, it only becomes an issue
>>> when accessing proc through a bind mount.  Or did I misunderstand the
>>> problem?
>> It's not hard to make the problem go away by performing some simple
>> action. I was unable to reproduce the problem initially because I
>> checked the Smack label on the bind mounted proc entry before doing
>> the cat of it. The problem shows up if nothing happens to update the
>> inode.
> A good point.
>
> I'm kinda thinking we just leave things as-is, especially since the
> proposed fix isn't something anyone is really excited about.

"We have to compromise the performance of our sandboxing tool because of
a kernel bug that's known and for which a fix is available."

If this were just a curiosity that wasn't affecting real development I
might agree. But we've got a real world problem, and I don't see ignoring
it as a good approach. I can't see maintainers of other LSMs thinking so
if this were interfering with their users.


