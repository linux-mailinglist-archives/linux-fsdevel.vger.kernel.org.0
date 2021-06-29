Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A98F3B7479
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 16:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhF2Oky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:40:54 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:36575
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234504AbhF2Okv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624977503; bh=g+Nx9vz7HQqYEkzcMZWqv15KtrnLR5S+Q+8UPWiUm5Y=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=fuSQ25GrN7izeEv7tmnkHpSrfOChSsq4g6kAa26Umisb9ZBIIoNjO7uvf63KBck3/8fiDXf0Hk2PgBEFbGXjWtC6hgH7BQoFOphk/gLKyV9y++2og1T+hrPCWNAmJAtQz84RVh42Uuh9aDs56DHryBK9o5aQ+1q3yG/I9b6NCzqIfcelsB+vTWwAg6vYJF3Vip7X+E0qAhxDCzqxSpNeRJlrNr5M7Pgxg4Ozki4o0H1dBiU8dDZOmThqQ5foLNFGWhtNS5xsJFrSM8GIyl5t0Ey+xC6qi9K4NW4yR2EBoW5CftK9dcRl+GomhXF1afRkG+abUec34ppUmIE1KapRag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624977503; bh=g+sZjnSVvCgoY1dXilleE0kXh5uvccbYvKiye1sie++=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=sdmL8GlaJCB9murbRo9395361SgPqoUC/I+6s6qc/mOmxkrGuoSSxE738DA4idggAwCjLAKLqVdnK8zMf1oSfun3B/4RjL9TyFJ8MtLrVMCFYQuWM85sTlNE25yRLvaikfQ9D7Bbn/CKXO9VW044P+FxEg1K/zGEenq1I25tKbT1AJStgcIx+XfwbnHEBPeeAPRCReYAdJya4dbQHtt/LWTz8cp8VT+AbZtixwv8IBnbf4HGGG4smVvtY4JtW53pNZZReVDOQHqQoQnLKTF9Fv9j1EHCdvwgeAAKzT3cX/UCejC66htxbIligcmBkvdhGzApW0zjNG6E4pjI3djzUw==
X-YMail-OSG: k8sUrVAVM1mqUkJrxNQ1lJApwnuthBev8EmPNOJRSic0sOhtVMEbRunpvvuDSpM
 0D4pLcIUG1UweLziPEeK0pDN51bjzikC_o9qmcdTYfWoNVuwTBjCutwd5hNBVaj_J3r.YEfAsSo9
 94BLRpYsdf3yQ_nMU.qx31PRV7Wq0Oct47xbKZOVYALZcPzrqjm1h9XPPMBbs6Z2sellmvm93fp9
 7eZcgU7XbbeNyVY.IFNZFcMDNIn.2e7r4sTWfTKpjrUxCpMFT_PIlX4Y.TTbeZ30vRDDJ_cjNK6r
 kG1E7Ba7Lt8HK1Kh8tnf4xHmqIPV9cX0OueRoXHovoxPtYVUjkgMsw5KBmz1.god5KIlj9lBCF_6
 75EJOCxknwZk80xa_3Dlq0xZzjb55ivlAj_EBNoKCpoXS.qOQP7XQQzNsPXxVj_7.m5xCWDREvjm
 O0.v5FFrB.dw9baCLngXtiwkG1YFh1QKUnUrVufqu0oZN0psbU1fL8PIS5mlbtqD_PxslblgiQBG
 NdY_UMYKKAc2b2ZAFE.u1a7BbCvRTOpWtKRSGUeM74fnEoMBMrpjur1YbxN7SuTQ.DhRnjrJHquG
 P9HrGBQdREsG0NHUEPE.4b1sAyPz77w4IZ2O6L_Dksmw8FAJVbJK7I.OaUPj4Ql.NkN7Z3QVmXfn
 eOpMPpMsUVMkJc6cO9nQHVU80V7FEoS7Sa.O2x9os78ENqbatT6oNZofbsa2m0CDz1MnJrIE9ceb
 siggQGIaciqj7DjUNNOCM72AQpT_EcuPmDqzkIFspfHh4Ud9Mc0VQc.aE_aVDaibUsYNJEDx_omv
 Zat0nDnoQwi2v68WVrzkcDT4IRBvKIVEUsXv58CSOAQDL6nSfqZaTIwUb1R3fhiZM4kK.lmVc._Z
 wRRzjKuTcJaR5RBaHWZ4wMBGvNyZTuA9wd93zHzHCQQVNeHcPtQBSqCywn9rcfRTwqxQO_T1jZBP
 ShOvTjBKA6uHQfkEqxyrijkBwhohODjI4mYt7vvpMhHvV79kjWk3ynLoWIsfOVEzRYf1ac3yNe51
 wieq4B8JoOceLSojyF6qWAEteL7hH4NKaEPoVZBaKh2XtOoP5iGbSS8sLVW0BqHAJWvgcxxdAkD5
 x.naa4FgJAOo.rt8NWSn7YSHnjLNT_lEEJBLp3.I4GkaIKUp9DxtJIBVYI8Pr3hjqCgPZNMUsltE
 JlFGBI.KJE1PuhqSp_nE.HOeIT8sCREUFCXrEBG4PhSWpp4eqMtZCFO5nWcQxKUnMPLgr_.LUxcd
 r7h6Dy1k2Qx9cAGxL4viwsFmReDs_EBbYJCa5CnfC9evh10Soz8s9Xh8FILqWtPHeldvfXVCf1pp
 cS245cIjEX4G_h2kKO1uFTQzbc9LbbiF14AEaJdGJg1RkrDh5n4bOF72eeqVANbPmoQFo2miWKhm
 HQ4O5Tv0vNNPf4gAz6GHmAAMGzAlArFMzY268_D3RqtIlU4Skce8H34.Y46r3L7QJnzDRidw_CMR
 qS9J_tTs1sQ6gCu6xFTfZdoexZor6p01h5sDAHUvtvYXCYVRjHzP.3PRb6IHu53Vu039tEeSm4qG
 acashnVG8A3SH1HYK54SEzG_0.kT1gceOOnDeGfJz_0v6QR4VsRdoV6l1SPtH_CfyI3ZsHT2dT4B
 6qGkw8s9ZZgjl_ZZqvhhGo_4qKjfD4UxL91A8QKQJhYLMh3o3TakugjySusv.Lp99lla6K1ykF33
 GCT5_HUXY536mUElwmB8P7ilgpGCOg9ux9Fb.hSa_xl5XiwAtpi94BqNGgnioFmXQzKVLBtYqhFw
 8o7XBBEYpw1AVz1Q1xvntlgnsMeKNKaOshClxo5Y2Kwvf4De5lNrfQp94y6TiTcCesZZqUd140Qk
 ajlatqjg5groPabCpNzDbsuZKIV87_o0tcYJ_LNxRvcwbt322Y0gyTRAgiMSkXPAefmkm2LaEBqD
 .t2MYD9Yxg3aXFY7Gk9fKBsBpl_qCHyuSb.OeIHyQ14_zSd5F7Zggoj0znkTUroShR5JReUExUw3
 l78FL_u9OPFp_ysVbU7cc8Eq8mVbh4JYhdLKFiLEmu0Z.I0a.D.nzyQf8u_GaFKVQYCAQSsDLSdk
 gWFomcW4rkXOFqc.mNsC0kUmhzBNqN7IpcoTo32mB4f_knRmAhIuG3ozcG331Wp_4la98obWfYed
 SosGcLtS4ISIL7BUk7UInoEXQ10BeqXKHVCqIy2gtkPAtOYXFlDdV.Rtbbuh2Bl8Q.FSNsoDgaP8
 GOxFJy7XciZol6dwTlpGcylRB5vO9LdBk6BwkcfmSfkLhgGYrWSl7qkzKcKsOpOHGX.SayIyvLme
 .qIKB3mShEkf4ctDU57iRpm8gTgnZ7lDt.wogzeEe9gocBg2gF918zmzcfeKqZAzxzPbDPUbryu4
 ebgV4rQk7tsPpUuZUa8gQSa052COv25TpztiU9MlkQ.M1M_mG9rzqSuhC4wBriJ3Sxu8P9Pa8NPm
 ZP4AIyi_MefIroe67euzTXn5mcH0uiBm9pfK1IEVTQTi5fkHRrCD0pG7aITOiBrZNawWOky0lMXN
 VK0ydeiDGAWZZj72.s7Mzh_72bQXe7gbYp_nGE2o.5SaCbSMeHLIZCqkd0DlwX260Pnsbv6SA_iw
 8R0P.1Yod9Qo5Zxx0FRQqSrs65PkCnZhQLflx7.l3JIU0hdhzuxwaqAzykgBBx4fTKEMJHoMOwXT
 fwct3E26Z7.pYLu69Nm_pYN3.Ue43Gcpd3_.WdUANymfAAPNVwOKmjzBd6bnnW5RCvfEpIDihLAV
 J7t.V_w.sQxjSmVeNUMm4PJItdI2UDjcnNct5KjawpVu7z5AlG9h424oFQbAd.FxlwNtDsFneOl3
 abQwJp7WDQtdgq1NVsNEzc8rtzDjhw2m5lHvMpXwG4iuDUvRV.c4rpkmoXhCM7RAGNdPlTZvL1_N
 PSJbMKtH2G3X10ONqVHIMKxH62EVw6NTMhp_pyE5GwpqkusWWiQVF6uRC_LvUxZ1NUr4fL7wVhof
 625Jx_rTMjsoF77LGxy2GmsXa1yLogdQ3OyMctnVvVwLtSfMHExiDVCPRNZEnXI9sZ2EnMi9WDuP
 w9moouxGwx2f_wgV82EmcwKU1iWUjprDeb2zuobeqprGEY0dfpsBmHR3.xZkcb8ct.tR9hTvp7br
 2QfUueYBtF81ShY0WHf5bdvstmuKy42OofS2.8giPkUVHMaXuIc.PStZTuBkoi27ZlmVikqyhznF
 9moURhvy7yMdXEPLSFO4hvp.o_sAqGdeNATBMxtfgkEvPNeRwv9dmssEg170HA6Ik9DIQqHJjx_f
 wBPx_keqYWKEf1Yf9BAQkX4PJ0a2rpocW.2EGR9RxoFMwE5gdw45dZwTtmkKwqPpg5mM8h1calvV
 9OksUHkIF2PZk6g1SaHC7wUadqRUBYKYHStDb8rspmTTg2lT98Kce3DaqIm7BggSWWNLFJNdEJKk
 oFHR3Z5NxWSEm7tAE7XSx0wh6TJlVeiB6nzIfhUR_icTGlWHkTuysOxm3ly0XiZyNmouWjRJNowJ
 r_HEGzdHkSu2npJ6.R6fPM0g-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Jun 2021 14:38:23 +0000
Received: by kubenode542.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5eba226885fa13dd000a4cfcd88b302a;
          Tue, 29 Jun 2021 14:38:17 +0000 (UTC)
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
 <a13f2861-7786-09f4-99a8-f0a5216d0fb1@schaufler-ca.com>
 <YNrhQ9XfcHTtM6QA@work-vm>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e6f9ed0d-c101-01df-3dff-85c1b38f9714@schaufler-ca.com>
Date:   Tue, 29 Jun 2021 07:38:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNrhQ9XfcHTtM6QA@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/29/2021 2:00 AM, Dr. David Alan Gilbert wrote:
> * Casey Schaufler (casey@schaufler-ca.com) wrote:
>> On 6/28/2021 9:28 AM, Dr. David Alan Gilbert wrote:
>>> * Casey Schaufler (casey@schaufler-ca.com) wrote:
>>>> On 6/28/2021 6:36 AM, Daniel Walsh wrote:
>>>>> On 6/28/21 09:17, Vivek Goyal wrote:
>>>>>> On Fri, Jun 25, 2021 at 09:49:51PM +0000, Schaufler, Casey wrote:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Vivek Goyal <vgoyal@redhat.com>
>>>>>>>> Sent: Friday, June 25, 2021 12:12 PM
>>>>>>>> To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;=

>>>>>>>> viro@zeniv.linux.org.uk
>>>>>>>> Cc: virtio-fs@redhat.com; dwalsh@redhat.com; dgilbert@redhat.com=
;
>>>>>>>> berrange@redhat.com; vgoyal@redhat.com
>>>>>>> Please include Linux Security Module list <linux-security-module@=
vger.kernel.org>
>>>>>>> and selinux@vger.kernel.org on this topic.
>>>>>>>
>>>>>>>> Subject: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/sp=
ecial files if
>>>>>>>> caller has CAP_SYS_RESOURCE
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> In virtiofs, actual file server is virtiosd daemon running on ho=
st.
>>>>>>>> There we have a mode where xattrs can be remapped to something e=
lse.
>>>>>>>> For example security.selinux can be remapped to
>>>>>>>> user.virtiofsd.securit.selinux on the host.
>>>>>>> This would seem to provide mechanism whereby a user can violate
>>>>>>> SELinux policy quite easily.
>>>>>> Hi Casey,
>>>>>>
>>>>>> As david already replied, we are not bypassing host's SELinux poli=
cy (if
>>>>>> there is one). We are just trying to provide a mode where host and=

>>>>>> guest's SELinux policies could co-exist without interefering
>>>>>> with each other.
>>>>>>
>>>>>> By remappming guests SELinux xattrs (and not host's SELinux xattrs=
),
>>>>>> a file probably will have two xattrs
>>>>>>
>>>>>> "security.selinux" and "user.virtiofsd.security.selinux". Host wil=
l
>>>>>> enforce SELinux policy based on security.selinux xattr and guest
>>>>>> will see the SELinux info stored in "user.virtiofsd.security.selin=
ux"
>>>>>> and guest SELinux policy will enforce rules based on that.
>>>>>> (user.virtiofsd.security.selinux will be remapped to "security.sel=
inux"
>>>>>> when guest does getxattr()).
>>>>>>
>>>>>> IOW, this mode is allowing both host and guest SELinux policies to=

>>>>>> co-exist and not interefere with each other. (Remapping guests's
>>>>>> SELinux xattr is not changing hosts's SELinux label and is not
>>>>>> bypassing host's SELinux policy).
>>>>>>
>>>>>> virtiofsd also provides for the mode where if guest process sets
>>>>>> SELinux xattr it shows up as security.selinux on host. But now we
>>>>>> have multiple issues. There are two SELinux policies (host and gue=
st)
>>>>>> which are operating on same lable. And there is a very good chance=

>>>>>> that two have not been written in such a way that they work with
>>>>>> each other. In fact there does not seem to exist a notion where
>>>>>> two different SELinux policies are operating on same label.
>>>>>>
>>>>>> At high level, this is in a way similar to files created on
>>>>>> virtio-blk devices. Say this device is backed by a foo.img file
>>>>>> on host. Now host selinux policy will set its own label on
>>>>>> foo.img and provide access control while labels created by guest
>>>>>> are not seen or controlled by host's SELinux policy. Only guest
>>>>>> SELinux policy works with those labels.
>>>>>>
>>>>>> So this is similar kind of attempt. Provide isolation between
>>>>>> host and guests's SELinux labels so that two policies can
>>>>>> co-exist and not interfere with each other.
>>>>>>
>>>>>>>> This remapping is useful when SELinux is enabled in guest and vi=
rtiofs
>>>>>>>> as being used as rootfs. Guest and host SELinux policy might not=
 match
>>>>>>>> and host policy might deny security.selinux xattr setting by gue=
st
>>>>>>>> onto host. Or host might have SELinux disabled and in that case =
to
>>>>>>>> be able to set security.selinux xattr, virtiofsd will need to ha=
ve
>>>>>>>> CAP_SYS_ADMIN (which we are trying to avoid). Being able to rema=
p
>>>>>>>> guest security.selinux (or other xattrs) on host to something el=
se
>>>>>>>> is also better from security point of view.
>>>>>>> Can you please provide some rationale for this assertion?
>>>>>>> I have been working with security xattrs longer than anyone
>>>>>>> and have trouble accepting the statement.
>>>>>> If guest is not able to interfere or change host's SELinux labels
>>>>>> directly, it sounded better.
>>>>>>
>>>>>> Irrespective of this, my primary concern is that to allow guest
>>>>>> VM to be able to use SELinux seamlessly in diverse host OS
>>>>>> environments (typical of cloud deployments). And being able to
>>>>>> provide a mode where host and guest's security labels can
>>>>>> co-exist and policies can work independently, should be able
>>>>>> to achieve that goal.
>>>>>>
>>>>>>>> But when we try this, we noticed that SELinux relabeling in gues=
t
>>>>>>>> is failing on some symlinks. When I debugged a little more, I
>>>>>>>> came to know that "user.*" xattrs are not allowed on symlinks
>>>>>>>> or special files.
>>>>>>>>
>>>>>>>> "man xattr" seems to suggest that primary reason to disallow is
>>>>>>>> that arbitrary users can set unlimited amount of "user.*" xattrs=

>>>>>>>> on these files and bypass quota check.
>>>>>>>>
>>>>>>>> If that's the primary reason, I am wondering is it possible to r=
elax
>>>>>>>> the restrictions if caller has CAP_SYS_RESOURCE. This capability=

>>>>>>>> allows caller to bypass quota checks. So it should not be
>>>>>>>> a problem atleast from quota perpective.
>>>>>>>>
>>>>>>>> That will allow me to give CAP_SYS_RESOURCE to virtiofs deamon
>>>>>>>> and remap xattrs arbitrarily.
>>>>>>> On a Smack system you should require CAP_MAC_ADMIN to remap
>>>>>>> security. xattrs. I sounds like you're in serious danger of runni=
ng afoul
>>>>>>> of LSM attribute policy on a reasonable general level.
>>>>>> I think I did not explain xattr remapping properly and that's why =
this
>>>>>> confusion is there. Only guests's xattrs will be remapped and not
>>>>>> hosts's xattr. So one can not bypass any access control implemente=
d
>>>>>> by any of the LSM on host.
>>>>>>
>>>>>> Thanks
>>>>>> Vivek
>>>>>>
>>>>> I want to point out that this solves a=C2=A0 couple of other proble=
ms also.=20
>>>> I am not (usually) adverse to solving problems. My concern is with
>>>> regard to creating new ones.
>>>>
>>>>> Currently virtiofsd attempts to write security attributes on the ho=
st, which is denied by default on systems without SELinux and no CAP_SYS_=
ADMIN.
>>>> Right. Which is as it should be.
>>>> Also, s/SELinux/a LSM that uses security xattrs/
>>>>
>>>>> =C2=A0 This means if you want to run a container or VM
>>>> A container uses the kernel from the host. A VM uses the kernel
>>>> from the guest. Unless you're calling a VM a container for
>>>> marketing purposes. If this scheme works for non-VM based containers=

>>>> there's a problem.
>>> And 'kata' is it's own kernel, but more like a container runtime - wo=
uld
>>> you like to call this a VM or a container?
>> I would call it a VM.
>>
>> On the other hand, there has been a concerted effort to ensure that th=
ere
>> is no technical definition of a container. I hope to exploit this for
>> personal wealth and glory before too long myself. If kata wants to ide=
ntify
>> as a container, who am I to say otherwise?
>>
>>> There's whole bunch of variations people are playing around with; I d=
on't
>>> think there's a single answer, or a single way people are trying to u=
se
>>> it.
>> Just so.
>>
>>>>> on a host without SELinux support but the VM has SELinux enabled, t=
hen virtiofsd needs CAP_SYS_ADMIN.=C2=A0 It would be much more secure if =
it only needed CAP_SYS_RESOURCE.
>>>> I don't know, so I'm asking. Does virtiofsd really get run with limi=
ted capabilities,
>>>> or does it get run as root like most system daemons? If it runs as r=
oot the argument
>>>> has no legs.
>>> It's typically run without CAP_SYS_ADMIN; (although we have other
>>> problems, like wanting to use file handles that make caps tricky).
>>> Some people are trying to run it in user namespaces.
>>> Given that it's pretty complex and playing with lots of file syscalls=

>>> under partial control of the guest, giving it as few capabilities
>>> as possible is my preference.
>> It would be mine as well. I expect/fear that many developers find
>> capabilities too complicated to work with and drop back to good old
>> fashioned root. The whole rationale for user namespaces seems to be
>> that it makes running as root in the namespace "safe".
> We're trying to be good with capabilities, basically locking it down
> until we trip over one of them and then think about it and enable it
> where appropriate;  the difficulty is that capabilities are only a bit
> better than root; they're still fairly granular - like in this case
> where you're pushed towards a wide ranging CAP even though you only
> want to give the user a trivial extra thing.
> (We have a similar problem wanting to allow separate threads to
> be in separate directories, but that requires unshare and that requires=

> another capability)

Thank you for putting in the effort.

The primary value of capabilities has always been the disassociation
of privilege from the root UID. The granularity has always been contentio=
us.
One UNIX system went the fine granularity route and ended up with 330.
Last I looked you'd need several hundred to give everyone who wants their=

own special problem solved. I admit that a solution for the granularity
issue would be grand. I think we're looking at something simpler than
capabilities to achieve that, but we'll see.

>>>>> =C2=A0 If the host has SELinux enabled then it can run without CAP_=
SYS_ADMIN or CAP_SYS_RESOURCE, but it will only be allowed to write label=
s that the host system understands, any label not understood will be bloc=
ked. Not only this, but the label that is running virtiofsd pretty much h=
as to run as unconfined, since it could be writing any SELinux label.
>>>> You could fix that easily enough by teaching SELinux about the prope=
r
>>>> use of CAP_MAC_ADMIN. Alas, I understand that there's no way that's
>>>> going to happen, and why it would be considered philosophically repu=
gnant
>>>> in the SELinux community.=20
>>>>
>>>>> If virtiofsd is writing Userxattrs with CAP_SYS_RESOURCE, then we c=
an run with a confined SELinux label only allowing it to sexattr on the c=
ontent in the designated directory, make the container/vm much more secur=
e.
>>>>>
>>>> User xattrs are less protected than security xattrs. You are exposin=
g the
>>>> security xattrs on the guest to the possible whims of a malicious, u=
nprivileged
>>>> actor on the host. All it needs is the right UID.
>>> Yep, we realise that; but when you're mainly interested in making sur=
e
>>> the guest can't attack the host, that's less worrying.
>> That's uncomfortable.
> Why exactly?

If a mechanism is designed with a known vulnerability you
fail your validation/evaluation efforts. Your mechanism is
less general because other potential use cases may not be
as cavalier about the vulnerability. I think that you can
approach this differently, get a solution that does everything
you want, and avoid the known problem.

> IMHO the biggest problem is it's badly defined when you want to actuall=
y
> share filesystems between guests or between guests and the host.

Right. The filesystem isn't the right layer for mapping xattrs.


>>> It would be lovely if there was something more granular, (e.g. allowi=
ng
>>> user.NUMBER. or trusted.NUMBER. to be used by this particular guest).=

>> We can't do that without breaking the "kernels aren't container aware"=

>> mandate. I suppose that if someone wanted to implement xattr namespace=
s
>> (like user namespaces, not just the prefix) you could get away with th=
at.
>> Namespaces for everything. :)
> Right, it's namespaces that we've used in most places to give ourselves=

> the isolation.
>
> I doubt we're the only case that wants a way to do xattr separation; yo=
u
> get lots of weird cases where it pops up (e.g. stacked overlayfs)

I can't say that I'm a major fan of namespace proliferation,
(time namespaces? really?) but what you've outlined is a
filesystem specific implementation of xattr namespaces. We've
looked into similar mechanisms for LSM specific namespaces.
When you see multiple use-case specific implementations of
the same thing its time to consider a general solution.

>
> Dave
>
>>>> We have unused xattr namespaces. Would using the "trusted" namespace=

>>>> work for your purposes?
>>> For those with CAP_SYS_ADMIN I guess.
>>>
>>> Note the virtiofsd takes an option allowing you to set the mapping
>>> however you like, so there's no hard coded user. or trusted. in the
>>> daemon itself.
>>>
>>> Dave
>>>

