Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB83B67DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 19:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhF1Rnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 13:43:39 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:43262
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234792AbhF1Rnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 13:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624902069; bh=qmoxYEMA7LrB3a7Ujqu2HpPAZip17EtNOkikOqYyUXM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=puC017rPoaQSKQncK74VMjTF/nd9njh2rVHZHyYh/1lCEp5iJU8FpYhM7FGMGHQoE2rXqtiy/Ka9UnCk85cw+MdihmiUWhCM3zNBHi9d1j88cbn0setwLnif2fRo5FB+FLDu3110Bygw0jeHA5iTrFfypbVkZvXco0unBltI21iZckkF9xKKqqzPg+WBtOQD28WU6Q4OxOSSxO9CIVUBuDjO98gMZ8FD9H/OvG4Ir6rs5hztkjCGelk2FY3SMZiMPd63UUH6MGvF22bS9ehsLhsz4pMN28LpBeo7sOwKsyaPubgPbqe9eXya8iU8Ecss6ocfTOZ9nW4U9TDnwIYJyg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624902069; bh=r4/9058lsVWz2oVlxOTwhi9Xq7CEah/+wQCYxvtB78M=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=c3u2HhYVDPAanNFQASkTzveAvBMR5WreSnpLf02qOEGWHK3J1eMmfHHQ5ustxzlUn5iAh4SCygk5JbIa/h+koiDmJedn7/1LDUnh8GuyhcpQ1KyB1nDPrsBDRptAMorXTyJHCkUuc5FTXm6LIKSCtSj7A+M5X0UsItLhPbsQgINiYMMR0VEfBA/5TlQfFmUXjw8hCRJhrK4Bs0hSnsLw1BWl3oNZwJUw5Aj5pGTgvwas1SGJOnCltgKJ/mwtjZSLk6443B31tfVXLsVu83p7rPl5LcL7a6w1mjAB+OFWR0I+B5YslnC8ycyav+lPRghvrs63AXb4R/WVXDcWB+FkxA==
X-YMail-OSG: _8ta84MVM1n7LMjUB50UkdW4gT1Xnnw.23XtRSw8wDHb6LSc9g7PQJHJDnJdywU
 72OVj98jgSz8iVMXhWzJCGMYSuuDY.VPEyqFe5xKeQNS2POPgHro97nnS_ncLmnXob_q0hf3Yb4A
 3Kn0dm1lkhXcIffJNLk8G_0HFkI9XclFsBd_.R1MIuiYfMM8lZhlAkukB26opGNE28ARdC6JoCdU
 sRcB0GEWcsIaX88.RfatDmu.h3xUPqWg9f.38G7MFy2_5GT3T6vCswDVMHuwBykHEogwP5mPue7Y
 ggwK22H8JS7rtZCmSZAOCboUpArhUAV_FShy3Wao.gC68KUoYaOmQaOJAlbCY5_C6RAEikRgo9bX
 WW87yiXX6290apFjc3wYTSXIj8IhL9ZxVXaqWO5xfzGCzNg.anKrz6YcjVc_xisSrYNA8jmdF_Q3
 .CpxFi1rJuKDWjqgBHztlthqJndVf5onpbRHwpLW8vSC2vGckppuUjYq89jbUlHlWPW4yhZyeGmc
 V1oAdsExOpxoPhUJJJaLR46MS78Ebl_RZtPx3XL8KGmdFgsmoo0_1bm0kg4JR0cVFdZj_0R8s9QQ
 QWzmjNFlj3NjGRd1juDGJ40asN9Q5Xpjar3TbCqoezrNaGxLy1t5355BSjQA30B5vqsbn6ciz5Zh
 cWkP.9eMAtV0sgk3RhS3y6XQCo.ThmVyKolNFq2oKkgPw9Ff9K8pt.yhEnYuwqTnBtUSms0Nb_Sj
 7fZ1OGiWJOXdAW0y07s6h_iUZ8fa3QIx0VriPbFwyrnaVsQCueWYO7H23tkvxIbCOFq2QOtS5LMW
 dwCtt3w3GAfPJRNrcSkKKNqkAwneWmTyeLyZINf01FOUp1GZhFtGdwOH1TRWNw_Zyx9WenrOoReP
 Zt3oZwoqDsu1bRx9b63ZHqxx9_Wkl8bMjobS2GMSzMBLim5fDuO.lwgoRBcMVVG.jrWjy6K3kfuJ
 ssRJ1cYzT2oTS9b9SmrxrVKwgoyHIICNOR0Uua5xA7cniD0QsH2T6zZ1Hq2nVltNKBfpVreyoUrY
 GnRoGSF2keKYBH5JYV2A4pdpsThuYjujU.GoXCOFtrtNs5pmlYUnd8JiIH0JTxnjGWb.DvQjYcUd
 cHqHJ.zkKEc85O7cQmFZdyXZ8oYskMxXJfuaXrHDra1TJUeT9aEfi1FLDDL45kik3njuaVRjLsZr
 wBeX7HticJtEA79eaXTlhFuMiaxgiUxs.0FT16I3i1DOYfN4P4OA.O28wKWUzRFQ17CdwjbhmyGE
 HuKRNglV2kJ1eMVMbmC87nPuEeuHrD_KOJu2Mhkpcdua9cAvoG0zGLQat_T1TjA5Dz7_78kkCZS_
 mlzTbd2yb12fNxRNAKkmxboR4kiDGsuEkZ9vQLHBDSqpkTj.9HsWXI7wPxGOyxi5gJmnQcp2UB1J
 u_ncZAzQCVS2ntznxglsUOHm6PqClgX9Vso4DpXCFe3jM1fPE7bKiQbTNUd99iK4htN2O08qGgky
 id.kPfyKN_99RZxIaeOvef1BXggIyT32_N7w_800P.PdWjFMcxBZYF.uXoz0f5.Im1zKLhWwIGow
 Oz3CXJj4ivULWu8YMPBaDfYgNZd0zTd3uTb6vY77lK_u0Lxna1qSxtkLfPaLL0EGzMr8z0uCEUAF
 dv79.KswNHosojVMxFhTxLB91k9BbOybcsfhocLN2dtdwvjkBqTVmnabqSwxyLz74M02tXCqFmLt
 Xk5rca4jxnO5ek56sN4S4kdms9C90zN.NWSudV2i.HRPTygCcbg9iZuJvPO7URuGFvadYgn3aPOW
 6CrfMfwBScm2GBB9iHFmZ5hL86Y9ylwEQgGDmljorPw2L33RLe5DylK1A4ryHIJt3UkOJ1ntvioY
 a1DQHpSPhvMaiJvfYN11r14gyuKpr7CCq37akTAQ26Gk0M5snYeKinbf5lNo0DOIinP9gBwUvlbb
 SxG_qIwMZ0xTREbj_LLAc.dGGTbrDMmu7ZREJWwTNWHKsGUGNxIxqUwlNM4mfig4udpakCatyXFW
 JzdPuQCOl8VJPpMeKuc6.aBilPYgZg17c0izorO.WrBgfjTTb15Q1pD262IA6luIx5zoaLVmw37n
 YvDPrNBa83o7RJcb9myodAHF4.ShHjMoW2sDsoshxF56dJJdyO231mVjszhmL.17G_GVqYuVDi5l
 BqWBDRS8YmsqCB7nIAmQcRfRndrGUm8Gs7ltJN6kcUfz0wGozG.xEhjjxTnVcCI9qBPytp1Yu1w.
 fjw7VcyPvKEo19xRecHpuTcbs4Guq6UtQTVbZ5g8bEHuftI166MrJmTOiuWVjXVoO2WL.dG6N4de
 MOKENXBQyM8n6tNg.PQzwMXL6uTtyWpimxsrQNRC2A0.E4SztHJbcHtiCW93EG25fBHqHFR9S8Y4
 2uYMHaD8GBhmmVVE9doSYVupbJ9dvyYZ9nY.UjInNh7URihfLM3GWNrVcp5yMOWOpbqGBG0.fQ6W
 XZE7Ri45zNGuQogFKmbrAY2513X29IoZ8P5QW.rQwn3qnvMewybc.41yQn6d7qeVEz.fisj0NzYP
 Rfit6iqTpDS_rJcsvUodI13DBUzztrvKVa9IttPmWivyu8ReGNaOgv1uDo6ez.12V6qo7txUYAkN
 YZA4AqmE.N8q1mMP6iNNWS9fmatHsjCaPxA9ZIpA8eQsJMK51mxNvXmi0sjzm10CTmhRFn14BbGA
 YMBXNBhEQUGmZ4Kmmv_bKeWxbDH7vt31Fk3CLWOc8hUGV49cSMfeGMkAUX4aiRJZB3xueUWVWeFb
 fLblyUDWxqOkE8LeRtW9mK6gDBbcj5wY7fyOykPT8XqoRhpuW6u.Pm4vr1A8MjZ8OYbnEMIY8Puq
 UayMtkr0fTwi_jwgHlgv10fzgDitEHHppy4VLf8W7x9WM.9H8.eSOUUsr0y9ILLjscepsJI7IlNu
 9VOZOUYaUF.2PEm19.nrRs46JTs8cL8pnytK5fPwpiH8dF6E74oIaO.TtC6mmbrmq7kzQpo42DPo
 DSHWpglzuwYnoxVvqHLUC5C_QrCF.XgZq5OUfXo7yn6WhV939DPWNpjWx0O_NgM.gbEOuAjZhAoq
 lLWl_3QqNqnA_gpvwHw_nPpiHFna7rrGCAWxfV9lxWwJEIio5UnZTf78cU77KCx4lhCEnLXiXbOX
 KytygkQBkFMqXVl648wZ9rEjiW23aWk.v6bJeaFUFn1HUhXkif380g_Pc2xxhgfulnIRgEeh24QJ
 bH_oRETb3FqF6LRTj6MGAY3e4pvNB5A4vwuEe6lsGVqTgEC4H1JfWYEwd1BQ3x7QtQBdfqNkW6Bt
 o1FFogCEw8QRKJUDf6pS2u3mg.SxZ9HGPPtUE.OUN_L3kBDg6hqXm52RI10HItxmpg0tv0ejvBtO
 oQNZewUZ0BlTVzzy2dEUeq1OHM6xYw7Q_10lxgUHaSvcbMaI_YHACs7FeffSnTNz_9Y7AK4TjVId
 nIaaxfHUF5Z0_2onvW.80iNtcwIFegHoNoGDbuhknHi6TfA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Jun 2021 17:41:09 +0000
Received: by kubenode505.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b6a3a4b4e03c3cbdf506474aaa7bd3b7;
          Mon, 28 Jun 2021 17:41:07 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     dwalsh@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
 <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
 <YNn4p+Zn444Sc4V+@work-vm>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
Date:   Mon, 28 Jun 2021 10:41:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNn4p+Zn444Sc4V+@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/2021 9:28 AM, Dr. David Alan Gilbert wrote:
> * Casey Schaufler (casey@schaufler-ca.com) wrote:
>> On 6/28/2021 6:36 AM, Daniel Walsh wrote:
>>> On 6/28/21 09:17, Vivek Goyal wrote:
>>>> On Fri, Jun 25, 2021 at 09:49:51PM +0000, Schaufler, Casey wrote:
>>>>>> -----Original Message-----
>>>>>> From: Vivek Goyal <vgoyal@redhat.com>
>>>>>> Sent: Friday, June 25, 2021 12:12 PM
>>>>>> To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>>> viro@zeniv.linux.org.uk
>>>>>> Cc: virtio-fs@redhat.com; dwalsh@redhat.com; dgilbert@redhat.com;
>>>>>> berrange@redhat.com; vgoyal@redhat.com
>>>>> Please include Linux Security Module list <linux-security-module@vg=
er.kernel.org>
>>>>> and selinux@vger.kernel.org on this topic.
>>>>>
>>>>>> Subject: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/spec=
ial files if
>>>>>> caller has CAP_SYS_RESOURCE
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> In virtiofs, actual file server is virtiosd daemon running on host=
=2E
>>>>>> There we have a mode where xattrs can be remapped to something els=
e.
>>>>>> For example security.selinux can be remapped to
>>>>>> user.virtiofsd.securit.selinux on the host.
>>>>> This would seem to provide mechanism whereby a user can violate
>>>>> SELinux policy quite easily.
>>>> Hi Casey,
>>>>
>>>> As david already replied, we are not bypassing host's SELinux policy=
 (if
>>>> there is one). We are just trying to provide a mode where host and
>>>> guest's SELinux policies could co-exist without interefering
>>>> with each other.
>>>>
>>>> By remappming guests SELinux xattrs (and not host's SELinux xattrs),=

>>>> a file probably will have two xattrs
>>>>
>>>> "security.selinux" and "user.virtiofsd.security.selinux". Host will
>>>> enforce SELinux policy based on security.selinux xattr and guest
>>>> will see the SELinux info stored in "user.virtiofsd.security.selinux=
"
>>>> and guest SELinux policy will enforce rules based on that.
>>>> (user.virtiofsd.security.selinux will be remapped to "security.selin=
ux"
>>>> when guest does getxattr()).
>>>>
>>>> IOW, this mode is allowing both host and guest SELinux policies to
>>>> co-exist and not interefere with each other. (Remapping guests's
>>>> SELinux xattr is not changing hosts's SELinux label and is not
>>>> bypassing host's SELinux policy).
>>>>
>>>> virtiofsd also provides for the mode where if guest process sets
>>>> SELinux xattr it shows up as security.selinux on host. But now we
>>>> have multiple issues. There are two SELinux policies (host and guest=
)
>>>> which are operating on same lable. And there is a very good chance
>>>> that two have not been written in such a way that they work with
>>>> each other. In fact there does not seem to exist a notion where
>>>> two different SELinux policies are operating on same label.
>>>>
>>>> At high level, this is in a way similar to files created on
>>>> virtio-blk devices. Say this device is backed by a foo.img file
>>>> on host. Now host selinux policy will set its own label on
>>>> foo.img and provide access control while labels created by guest
>>>> are not seen or controlled by host's SELinux policy. Only guest
>>>> SELinux policy works with those labels.
>>>>
>>>> So this is similar kind of attempt. Provide isolation between
>>>> host and guests's SELinux labels so that two policies can
>>>> co-exist and not interfere with each other.
>>>>
>>>>>> This remapping is useful when SELinux is enabled in guest and virt=
iofs
>>>>>> as being used as rootfs. Guest and host SELinux policy might not m=
atch
>>>>>> and host policy might deny security.selinux xattr setting by guest=

>>>>>> onto host. Or host might have SELinux disabled and in that case to=

>>>>>> be able to set security.selinux xattr, virtiofsd will need to have=

>>>>>> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
>>>>>> guest security.selinux (or other xattrs) on host to something else=

>>>>>> is also better from security point of view.
>>>>> Can you please provide some rationale for this assertion?
>>>>> I have been working with security xattrs longer than anyone
>>>>> and have trouble accepting the statement.
>>>> If guest is not able to interfere or change host's SELinux labels
>>>> directly, it sounded better.
>>>>
>>>> Irrespective of this, my primary concern is that to allow guest
>>>> VM to be able to use SELinux seamlessly in diverse host OS
>>>> environments (typical of cloud deployments). And being able to
>>>> provide a mode where host and guest's security labels can
>>>> co-exist and policies can work independently, should be able
>>>> to achieve that goal.
>>>>
>>>>>> But when we try this, we noticed that SELinux relabeling in guest
>>>>>> is failing on some symlinks. When I debugged a little more, I
>>>>>> came to know that "user.*" xattrs are not allowed on symlinks
>>>>>> or special files.
>>>>>>
>>>>>> "man xattr" seems to suggest that primary reason to disallow is
>>>>>> that arbitrary users can set unlimited amount of "user.*" xattrs
>>>>>> on these files and bypass quota check.
>>>>>>
>>>>>> If that's the primary reason, I am wondering is it possible to rel=
ax
>>>>>> the restrictions if caller has CAP_SYS_RESOURCE. This capability
>>>>>> allows caller to bypass quota checks. So it should not be
>>>>>> a problem atleast from quota perpective.
>>>>>>
>>>>>> That will allow me to give CAP_SYS_RESOURCE to virtiofs deamon
>>>>>> and remap xattrs arbitrarily.
>>>>> On a Smack system you should require CAP_MAC_ADMIN to remap
>>>>> security. xattrs. I sounds like you're in serious danger of running=
 afoul
>>>>> of LSM attribute policy on a reasonable general level.
>>>> I think I did not explain xattr remapping properly and that's why th=
is
>>>> confusion is there. Only guests's xattrs will be remapped and not
>>>> hosts's xattr. So one can not bypass any access control implemented
>>>> by any of the LSM on host.
>>>>
>>>> Thanks
>>>> Vivek
>>>>
>>> I want to point out that this solves a=C2=A0 couple of other problems=
 also.=20
>> I am not (usually) adverse to solving problems. My concern is with
>> regard to creating new ones.
>>
>>> Currently virtiofsd attempts to write security attributes on the host=
, which is denied by default on systems without SELinux and no CAP_SYS_AD=
MIN.
>> Right. Which is as it should be.
>> Also, s/SELinux/a LSM that uses security xattrs/
>>
>>> =C2=A0 This means if you want to run a container or VM
>> A container uses the kernel from the host. A VM uses the kernel
>> from the guest. Unless you're calling a VM a container for
>> marketing purposes. If this scheme works for non-VM based containers
>> there's a problem.
> And 'kata' is it's own kernel, but more like a container runtime - woul=
d
> you like to call this a VM or a container?

I would call it a VM.

On the other hand, there has been a concerted effort to ensure that there=

is no technical definition of a container. I hope to exploit this for
personal wealth and glory before too long myself. If kata wants to identi=
fy
as a container, who am I to say otherwise?

> There's whole bunch of variations people are playing around with; I don=
't
> think there's a single answer, or a single way people are trying to use=

> it.

Just so.

>>> on a host without SELinux support but the VM has SELinux enabled, the=
n virtiofsd needs CAP_SYS_ADMIN.=C2=A0 It would be much more secure if it=
 only needed CAP_SYS_RESOURCE.
>> I don't know, so I'm asking. Does virtiofsd really get run with limite=
d capabilities,
>> or does it get run as root like most system daemons? If it runs as roo=
t the argument
>> has no legs.
> It's typically run without CAP_SYS_ADMIN; (although we have other
> problems, like wanting to use file handles that make caps tricky).
> Some people are trying to run it in user namespaces.
> Given that it's pretty complex and playing with lots of file syscalls
> under partial control of the guest, giving it as few capabilities
> as possible is my preference.

It would be mine as well. I expect/fear that many developers find
capabilities too complicated to work with and drop back to good old
fashioned root. The whole rationale for user namespaces seems to be
that it makes running as root in the namespace "safe".

>>> =C2=A0 If the host has SELinux enabled then it can run without CAP_SY=
S_ADMIN or CAP_SYS_RESOURCE, but it will only be allowed to write labels =
that the host system understands, any label not understood will be blocke=
d. Not only this, but the label that is running virtiofsd pretty much has=
 to run as unconfined, since it could be writing any SELinux label.
>> You could fix that easily enough by teaching SELinux about the proper
>> use of CAP_MAC_ADMIN. Alas, I understand that there's no way that's
>> going to happen, and why it would be considered philosophically repugn=
ant
>> in the SELinux community.=20
>>
>>> If virtiofsd is writing Userxattrs with CAP_SYS_RESOURCE, then we can=
 run with a confined SELinux label only allowing it to sexattr on the con=
tent in the designated directory, make the container/vm much more secure.=

>>>
>> User xattrs are less protected than security xattrs. You are exposing =
the
>> security xattrs on the guest to the possible whims of a malicious, unp=
rivileged
>> actor on the host. All it needs is the right UID.
> Yep, we realise that; but when you're mainly interested in making sure
> the guest can't attack the host, that's less worrying.

That's uncomfortable.

> It would be lovely if there was something more granular, (e.g. allowing=

> user.NUMBER. or trusted.NUMBER. to be used by this particular guest).

We can't do that without breaking the "kernels aren't container aware"
mandate. I suppose that if someone wanted to implement xattr namespaces
(like user namespaces, not just the prefix) you could get away with that.=

Namespaces for everything. :)

>> We have unused xattr namespaces. Would using the "trusted" namespace
>> work for your purposes?
> For those with CAP_SYS_ADMIN I guess.
>
> Note the virtiofsd takes an option allowing you to set the mapping
> however you like, so there's no hard coded user. or trusted. in the
> daemon itself.
>
> Dave
>
>>

