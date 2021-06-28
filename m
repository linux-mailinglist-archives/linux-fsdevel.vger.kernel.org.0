Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488D53B665E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhF1QHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 12:07:16 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:37415
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232230AbhF1QHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624896286; bh=y8P8oIXs749OpjOsRxGUYjp4LVCZMPe6R8LWB2ErpAA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=BYHEgSXcrOZA9Zt2r+nyCgt/MZj9X8ZTfDIQBWeeuByIXcd3P6crcQVe0c7Re6dFt8aGkpZS+yz5WOj0M/mfhHEvk9urUSl9KyNlqRW75M0RV8QP7YZCnAN4ouLMSYxQowoWuQd3SL1agjejsKCHNtjbIWh0QXKFsObCg0nQvxR4IgrF+vEIK9DaZmWFM8DGT64TMWwwv3BStgvg3wr25ncA6vPijygRICZWSbZtXMXIlIt8zWY9M1ihBYVPwkBQhqp/2fYf6QORm9Q4aKIKrK8sk5z0B5fSKsMzzhROvoYXDmLnHP5Y5S0p6ABmjRrVwKKCOMyhQyNIDHf+mb/jgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1624896286; bh=9yysOjBPk+Y8sPPO5OMbPll2hJaw9IvsPhKDFDmVgm9=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=I12g+enZDkipTuzjrLX/VrUzqzCalpWwfpLnA/d8+FfqE08vJsQAidtVPA9kPCFfsCahwVA/aibQgypVpRkKZP2ixd06e4J41lgfocJUJpytJxlJJ6b9upHXKSWwTBoIXi2y/K9mliYArbLIdwVgEpUeyCZcvIWSBif0bYlZqnE2rRjVO7yCwPpEFshpUyUUg2+Oqy0hZXV4I917nUHJPGeU2Wq893iiNpCmntS+78F6c+wWrWu8WuDuagDAiEG+XoMr6r4rd2xondwfBQ45v+99cQknxNlzTEdFgT3o64eu+30UM/8K58KUPak8KgMELX1zc6b7grHGAZ987rUzHQ==
X-YMail-OSG: oFXmAqcVM1mJxjPgq1WXomAEHlW3BULoGUcEb3FGeZEZ0c.G.sPZcC8bRzEhi25
 Y3U6zyf2e4oW6Gln7cQnU1tR0l.K1EtWM5IQm3L.Enfsi30Qy7eaW1x5ES8RX4rc8pzO68lVJ2bM
 WyHk0Vx8QGkgSt5HL7HeNEsJopVpADdiJAKDYwd2pfzZoFj2bQTLRBrD9cEmjP.5wu1MMx4bXoXe
 liOsOUZU3KMZJLygIFvGYhul4rRKdFJ0Kv.zZs46zXJSLEhNzGieaL6LrGnceHNMmhlLn1Ca45Vi
 SCKHBnNyu66Ui.HCO.OJAmw_7dvwtTJwi6yJA.oUCf1gi9oi_YdFhMYLtH93x7jgIOPo5O7uJ0xd
 1vLvMgrQ7k_U0ERpZKjVBlFhlDQXf7apMaeT6ytGAcWx_LgBNokOaKPyOtXvCmYLM8ZZ0.TQffiz
 Pn6BbeXCtycLeL.rBj.Bx2V8Aosu2JuDI2u_Kl59K_2Hm4.ZTrp4bFSCsx4JlRPLRJ2vdKKcPxtM
 oTyIj5_GO.8iiFPkRgCnPqgbu5Za64ySP1uh5jUWcfktkfhemzR1iDtgoKNEoIAEgyH5qy.mnh12
 eJAr9l202qPV9IKMLHF3g3tMrcavXUtlcuLsgsl_HN673StVG9j6yIt0xy6bG.dfuojnf88_Qahi
 l7a2ecE1es1xw3d1MKSWgsDyA7w7UVQjrFTo0uyDgQcoh9gJURpC3gMkjQEEChDs4l2CVZAp78N_
 u5D4dLv.qdaagIreJrQJgfSmIDAJXhERratWTCiGz1ANQnsRapWWhyqRJyzrMILe94p2l8XPwNY0
 PUGyywY.LPO2nFz0n8N3FLgVHCKjCR0stVh_EuzxhnXBrS8vozeo2NL59OjJRqQsh70Qoi0ZlzVu
 nazfM4T1y4R08P1Q39.6Mb90E3LJpLrv_6_5l7wZ3oX1.JroERezzH.jHGHK8VQ79f0gDeeMHQX0
 5Cn5b7TIonopR.Tvq4q7h_UlGarzhuK8fq6ium.yuDP9iET4bl7nxyBGG47e8klfrZRHDp_8rahZ
 l2lhauTOfCUbWcVaLkeENN250ZdLJCGR5gdFgSXsl_GvUZydSu_kwv6w9vQCPFveWEACTdaRNYaK
 RsIjyUVnLeHGtkIIQmba3Wa6prQpwShCQefVxG6BApm9KPYxWW5W2P3fl.B.uTSYSMhIaAZcMTon
 NTqpQe2MXpackP.14iiupZGfX_3MExF4fE9.89GfmlV0ngiv1p6PBcG2RH1N3Fase6Ik95BWkEIg
 f0q1Lt3NWwByURdF5ZWz11LrFxp3y0CVsaFD.x_cUabbHU53_zqAXwkI518CIQTf1CfdrkaxYStG
 R99QBwQkEE.1BqcwG5GkLIHWFkdbUv9jFcvYOvq7Uv2NFjVGdeodCMrkUwv0NiBKNOsxbgL5mGs4
 FR2gIZEpnPAnCIroNwCjUkl5hJazVWWD81wsg9vT.c1Zz7NipDeYkWxQN9LG2r8vVYSnpUzne_DR
 __j2GwOhxzAeX4._DVIK2Cy5tUQgtd05wQoej5nYJKp4Su_qcy2bFkLEHtNNBuGASWU4WDGUPlWT
 4doWz5irW2HyCuRWLElBmCjRsM6xG59AXaEsIcBHfktD4d_XOolOu7mSg7tu8bERiLxwxD4loSb3
 Not9LiJWNm66erSaM5Ke1hfhsVdui4YmV8dr.kJ8l6xpTnUuMC31qGw7Dg16iAwTh2csyf4lDygV
 XQXxBYHU584nCuvmvysSd.2KReeCqOsNZoB8ooFEplUvNLi0b2am3QRvVyrAub1HY9SmcvZ7s5Uy
 hS.d6c5pMLcM5RwpDevJ6zLP2Y6U6vCjEm7JvxXfia6XgYkvc6s8.O1upoAGzKs2p_I86Cr17vXJ
 rk4eeKzgthwzsDsFwwCGZ75_VTKY8w4JXxTm4Oa8oWsN3x7YSBAIc5LiFE_2P9TnEpd37lnsHz6J
 Y77bpmq07wCsi_W2_br_M2lpoXTHfU4Kv7whZkS6UpLX7Zwz7sbUuumaGeTw7Db4IuYO2REy_jrC
 LjD6hZUiwfz6HlQ_e6x5D3HS4N4lhgimn6fRctW02uo5UH_GdBEcTww_sLvkn6gFr6tnqfOi7gRb
 jkRBnfQPMUePjii5Wk_ZAOIlp2q7kB0K4BEKFcTNfD70t54sFe9Y1H0KgJimdMaKowKtXYQDmhvk
 A8sONsKYBtsumc3KTBHfCzu7h3QZ.j72Or6o6svMo7o5NBYTNe.QcGrW8NXLmaPnOydjtYixjUeh
 kwfcZS7z8L2267tR8Is4UwmzbbZ4HacZKx3jdKiOf.geITNQjJK_Qu0FBYfzjyXWJvFP9lPlkAjN
 BRkqyPA57t7hAiMlNa7TucKwTMgCgNb6oQqBaJ4bj0y8YMqoklcsk9j.Ll9qHO3gAVktusQpkYoo
 cOEOIIbBfFHOTqt5SnGkIVypx9qPDKxBXXDGqd_j8Ny53_o.mucTwUG0YEjX2tZqKlb7HHoHXQbb
 2c9hcLwsqT7xivb12394c29NSwXdi0zMzsFxW5d56ERynRq8bN554okBc_ZUI5foIR27usItNnA1
 RJYGDYBs3GKTKyXUt48qCr5QsOnyfdb4XTwnIloJimEkpP7VaVk_9_K3PUomp3_eZtDBtdqeb6zi
 jDsg9C6gFKecRgro16j1GOeCuUOsK0C0J3TOIEavCdF8SoPqXD1lDSWjIcVwk136K49HkiM69WO1
 Ro43u_UxEEMRTAA82MNRV2KRepLV74LavKfCdZbmPmUtgvqguNUOLVl7lo3l9OUzoC_Jh8MRxB70
 ovgznhcz0EuSd1CAJ4fzypOH6VVp79zGiYVUrynFRcgOMuG.8X8ehcFy4p0VwTvpJAdkc5NVb37L
 ztrPtJbqPaiucU07Xh.HnoV1qApQhUc53jNi1cKXa9fNCBtVg9ADYdTM2U_yYicfcRm3e7oqVila
 YT_tRsy1fQoCsG76GC9QqaZwOnpXuySxZug.bgITbktFs6Mkgwj2A6EuYKzaQL2GvGzyNlhH_QLO
 VoBt8_B2oZEm4HgCQxr20_rdUCQkETNrBaKdUMWYcifgfkJ.D_fkzGZCH7kH0k2sVmHR4Zssl4VD
 vmNcJnhtGly9HRkXbim4MqX2lZCP1fq1oo3idTnCLvqGQ5OEtAiUZsUcK3_9Ol.p4j5lEl3Vqefj
 F5iV73pRFmoZsfoqRvErSA4a0P54jyiOvFoA2p36qyV2XD7lIipJddUBxlJnotdzYXinJUN_OhVw
 48UJDRBakthJLfmkWBVbdrBce_ICGofYclbqSSXrsjKYHRl094jwBw6aYgXUb9oxP9RpkI2iT1AG
 6YBpe3xr4VPrYTHHE7O.tp.HcNvs0chkKe8.S5B1rZr.XkpvabgYVPxLTafCQLLHHe0S7bexGQew
 vtoNMlCZP13M65UbAKO7C90jSJlCRY4mvWdXHhNDK45a4zGkijZr276UwdMoQreUIaZbJWvdZ017
 M4N4ZbQUOQ4qlujsKDm91bSz26gk7Iw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Jun 2021 16:04:46 +0000
Received: by kubenode547.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 539a3d9ad16b87d0e8176d07e451bff1;
          Mon, 28 Jun 2021 16:04:42 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
To:     dwalsh@redhat.com, Vivek Goyal <vgoyal@redhat.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
 <20210628131708.GA1803896@redhat.com>
 <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5d8f033c-eba2-7a8b-f19a-1005bbb615ea@schaufler-ca.com>
Date:   Mon, 28 Jun 2021 09:04:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1b446468-dcf8-9e21-58d3-c032686eeee5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/2021 6:36 AM, Daniel Walsh wrote:
> On 6/28/21 09:17, Vivek Goyal wrote:
>> On Fri, Jun 25, 2021 at 09:49:51PM +0000, Schaufler, Casey wrote:
>>>> -----Original Message-----
>>>> From: Vivek Goyal <vgoyal@redhat.com>
>>>> Sent: Friday, June 25, 2021 12:12 PM
>>>> To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> viro@zeniv.linux.org.uk
>>>> Cc: virtio-fs@redhat.com; dwalsh@redhat.com; dgilbert@redhat.com;
>>>> berrange@redhat.com; vgoyal@redhat.com
>>> Please include Linux Security Module list <linux-security-module@vger=
=2Ekernel.org>
>>> and selinux@vger.kernel.org on this topic.
>>>
>>>> Subject: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/specia=
l files if
>>>> caller has CAP_SYS_RESOURCE
>>>>
>>>> Hi,
>>>>
>>>> In virtiofs, actual file server is virtiosd daemon running on host.
>>>> There we have a mode where xattrs can be remapped to something else.=

>>>> For example security.selinux can be remapped to
>>>> user.virtiofsd.securit.selinux on the host.
>>> This would seem to provide mechanism whereby a user can violate
>>> SELinux policy quite easily.
>> Hi Casey,
>>
>> As david already replied, we are not bypassing host's SELinux policy (=
if
>> there is one). We are just trying to provide a mode where host and
>> guest's SELinux policies could co-exist without interefering
>> with each other.
>>
>> By remappming guests SELinux xattrs (and not host's SELinux xattrs),
>> a file probably will have two xattrs
>>
>> "security.selinux" and "user.virtiofsd.security.selinux". Host will
>> enforce SELinux policy based on security.selinux xattr and guest
>> will see the SELinux info stored in "user.virtiofsd.security.selinux"
>> and guest SELinux policy will enforce rules based on that.
>> (user.virtiofsd.security.selinux will be remapped to "security.selinux=
"
>> when guest does getxattr()).
>>
>> IOW, this mode is allowing both host and guest SELinux policies to
>> co-exist and not interefere with each other. (Remapping guests's
>> SELinux xattr is not changing hosts's SELinux label and is not
>> bypassing host's SELinux policy).
>>
>> virtiofsd also provides for the mode where if guest process sets
>> SELinux xattr it shows up as security.selinux on host. But now we
>> have multiple issues. There are two SELinux policies (host and guest)
>> which are operating on same lable. And there is a very good chance
>> that two have not been written in such a way that they work with
>> each other. In fact there does not seem to exist a notion where
>> two different SELinux policies are operating on same label.
>>
>> At high level, this is in a way similar to files created on
>> virtio-blk devices. Say this device is backed by a foo.img file
>> on host. Now host selinux policy will set its own label on
>> foo.img and provide access control while labels created by guest
>> are not seen or controlled by host's SELinux policy. Only guest
>> SELinux policy works with those labels.
>>
>> So this is similar kind of attempt. Provide isolation between
>> host and guests's SELinux labels so that two policies can
>> co-exist and not interfere with each other.
>>
>>>> This remapping is useful when SELinux is enabled in guest and virtio=
fs
>>>> as being used as rootfs. Guest and host SELinux policy might not mat=
ch
>>>> and host policy might deny security.selinux xattr setting by guest
>>>> onto host. Or host might have SELinux disabled and in that case to
>>>> be able to set security.selinux xattr, virtiofsd will need to have
>>>> CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
>>>> guest security.selinux (or other xattrs) on host to something else
>>>> is also better from security point of view.
>>> Can you please provide some rationale for this assertion?
>>> I have been working with security xattrs longer than anyone
>>> and have trouble accepting the statement.
>> If guest is not able to interfere or change host's SELinux labels
>> directly, it sounded better.
>>
>> Irrespective of this, my primary concern is that to allow guest
>> VM to be able to use SELinux seamlessly in diverse host OS
>> environments (typical of cloud deployments). And being able to
>> provide a mode where host and guest's security labels can
>> co-exist and policies can work independently, should be able
>> to achieve that goal.
>>
>>>> But when we try this, we noticed that SELinux relabeling in guest
>>>> is failing on some symlinks. When I debugged a little more, I
>>>> came to know that "user.*" xattrs are not allowed on symlinks
>>>> or special files.
>>>>
>>>> "man xattr" seems to suggest that primary reason to disallow is
>>>> that arbitrary users can set unlimited amount of "user.*" xattrs
>>>> on these files and bypass quota check.
>>>>
>>>> If that's the primary reason, I am wondering is it possible to relax=

>>>> the restrictions if caller has CAP_SYS_RESOURCE. This capability
>>>> allows caller to bypass quota checks. So it should not be
>>>> a problem atleast from quota perpective.
>>>>
>>>> That will allow me to give CAP_SYS_RESOURCE to virtiofs deamon
>>>> and remap xattrs arbitrarily.
>>> On a Smack system you should require CAP_MAC_ADMIN to remap
>>> security. xattrs. I sounds like you're in serious danger of running a=
foul
>>> of LSM attribute policy on a reasonable general level.
>> I think I did not explain xattr remapping properly and that's why this=

>> confusion is there. Only guests's xattrs will be remapped and not
>> hosts's xattr. So one can not bypass any access control implemented
>> by any of the LSM on host.
>>
>> Thanks
>> Vivek
>>
> I want to point out that this solves a=C2=A0 couple of other problems a=
lso.=20

I am not (usually) adverse to solving problems. My concern is with
regard to creating new ones.

> Currently virtiofsd attempts to write security attributes on the host, =
which is denied by default on systems without SELinux and no CAP_SYS_ADMI=
N.

Right. Which is as it should be.
Also, s/SELinux/a LSM that uses security xattrs/

> =C2=A0 This means if you want to run a container or VM

A container uses the kernel from the host. A VM uses the kernel
from the guest. Unless you're calling a VM a container for
marketing purposes. If this scheme works for non-VM based containers
there's a problem.

> on a host without SELinux support but the VM has SELinux enabled, then =
virtiofsd needs CAP_SYS_ADMIN.=C2=A0 It would be much more secure if it o=
nly needed CAP_SYS_RESOURCE.

I don't know, so I'm asking. Does virtiofsd really get run with limited c=
apabilities,
or does it get run as root like most system daemons? If it runs as root t=
he argument
has no legs.

> =C2=A0 If the host has SELinux enabled then it can run without CAP_SYS_=
ADMIN or CAP_SYS_RESOURCE, but it will only be allowed to write labels th=
at the host system understands, any label not understood will be blocked.=
 Not only this, but the label that is running virtiofsd pretty much has t=
o run as unconfined, since it could be writing any SELinux label.

You could fix that easily enough by teaching SELinux about the proper
use of CAP_MAC_ADMIN. Alas, I understand that there's no way that's
going to happen, and why it would be considered philosophically repugnant=

in the SELinux community.=20

>
> If virtiofsd is writing Userxattrs with CAP_SYS_RESOURCE, then we can r=
un with a confined SELinux label only allowing it to sexattr on the conte=
nt in the designated directory, make the container/vm much more secure.
>
User xattrs are less protected than security xattrs. You are exposing the=

security xattrs on the guest to the possible whims of a malicious, unpriv=
ileged
actor on the host. All it needs is the right UID.

We have unused xattr namespaces. Would using the "trusted" namespace
work for your purposes?


