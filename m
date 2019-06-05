Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9B35F9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 16:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfFEOvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 10:51:12 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:42854
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbfFEOvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559746268; bh=vQ863yDV2wmdCZygtxSI5wsL7fPddox6Fd+/Zoc7GU0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=d2f2F7/mifDiveMDb2TFbH3W+TzBqbAkUxvolGn0V1MCLxwp8he1PGODogV/6qMgT1pBF29GeGoJxXGaFd+jxj4U+tAPcjUJjFgS3t3CUnXSMQOPXe8AdBgspQnWWJrs0b3bChv8rLohmkJXoAh1Sy400B0/+3o2wAyjLk6ONHwwSF/UkGYCip5IYRDuB1qPoRQhact5z+4QFd+eA8S2ZOqgW6uqF87KExiMZHoSYQeGqIpd5fWOOKFeULPf7ihvQ1WZ/QQ9WR1ePk1K0DYvWBumOuwCGmKmhM1rf3Tl6z5FJtkzstuwnB4X4ls6hIlDqP7ESg7lP6GrYJyBfXSmUA==
X-YMail-OSG: tYcK9qwVM1kZxMtAaFGS0PcbaOsZsC2pfIzOuSNNseXF_WKJ1MuFrHD0NLIUGEV
 pClQ9woS6reiHOVcBafr3Seln50nEQafdLnwWEGJHsc7apt6CrE93sZGtrelWQzsMQizL9p3SWLc
 ZcYWztgvlRIAmiOveNoaTntpZM3ijxq.uu5SAcAQmctYbVYpCJhMFoDuknpflOq.GUIRwjoVLkTL
 BZPyO.jb0M7jdnUAPJiNs3hYKZXMG2fzBln425SA6NnHniqN.uoQ78pjW5dWvOBJOw21N.ejIEF8
 IpudUYsrq8tbXtF6QhBWY_es7p7pye4I0IUlcX3Yy1gLQuUPml_lAL2ElKqtiljgFn2UGV84_cUq
 La8i3UaYiyKeStXzZd81yZ8VwVP_a8OD3DG4DGf_P6heilaD1mXU84L2YABDHaeZHxrubvAd6094
 TW6ZYpHUYzQwuuInDQAdy6dUQ08ciwFe5V72fEhxwDPsZRDopsQC7PeEYt0WpfMRhXSRMszerV8X
 PVjGxnyV7Q99arC_iAvKQio_uIfefgt5bjjybDo8o_4q66KFSioTj0rYp5nWIUMTpooCGMuRQYjr
 tpwzkIQdb0smkHvfSz48K3sqsULjWXvWjTk9o7oHE7Rej9OLe_9UK9Ldk36hvX6nptC6o21Xh72D
 95suyHJepoIzTkhjHCGhYVG3weBbPqi2Inrn16.RbOJOFfn6riqh6E1WzNAxwmFkipg0JVtrCDat
 w3jEb3CE7vIvlsNCCLrh8a5ZQ.nQAshxp3USKDNunBybUevXGfRyc3c3nCiZLJGECPPhomkej7P1
 a8OprpGEgsJqff0ea6V20_tURysUiJuyIPVE_59WkBAZdRVdNj5kRHe1yxduK2NeoOq37YDeVTus
 PTIu57S94wwAkEq1ShUXPRMkmc_MiKdPvkR6LzVP_0BNOcJdd1_hDFYw3s56TQ7JYPuLo1BePapF
 4oEKK27.94jIqszojw3iStyWNh0V5qT8vxbcSQshccI3uZYc2yCqJUBmWMk3VCMKrpE8Hct7p2bi
 aVBvvKPEjQmHfXRKmld9Zv1fXAfXer2SZr12efGlo.RqXG2OpHBepOuXMh24KtmalD6JIpYCBy73
 Ytyxw.Pie47HXe8gJS4RsymY3Pd48_DJJ2gTSPfZprt60XmmrUs2ON_2bQIq1fbOLC9sWxX3sO9m
 Bmac24ZB3rZ9v.FUfqAALla0R6jUWWDavdzizQ6ecBFu7CYeVA3ZNv3hCjMm2WmHskg62ZqxU0Cp
 _xtucNwdkxuTzt9AlYZ.I2zk5bDnbMcVE
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Jun 2019 14:51:08 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 610f9da3c63d75c55bf190f4c4eb0731;
          Wed, 05 Jun 2019 14:51:05 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver
 #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
Date:   Wed, 5 Jun 2019 07:50:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20192.1559724094@warthog.procyon.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nAYbsaLPWvSYgBq1ZgUViHpZIInmpNbp5"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nAYbsaLPWvSYgBq1ZgUViHpZIInmpNbp5
Content-Type: multipart/mixed; boundary="txkkq0wOFA671eV9SlTrRrBSRAcaZSaKJ";
 protected-headers="v1"
From: Casey Schaufler <casey@schaufler-ca.com>
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 raven@themaw.net, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, linux-block@vger.kernel.org,
 keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, casey@schaufler-ca.com
Message-ID: <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver
 #2]
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk>
In-Reply-To: <20192.1559724094@warthog.procyon.org.uk>

--txkkq0wOFA671eV9SlTrRrBSRAcaZSaKJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 6/5/2019 1:41 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> I will try to explain the problem once again. If process A
>> sends a signal (writes information) to process B the kernel
>> checks that either process A has the same UID as process B
>> or that process A has privilege to override that policy.
>> Process B is passive in this access control decision, while
>> process A is active. In the event delivery case, process A
>> does something (e.g. modifies a keyring) that generates an
>> event, which is then sent to process B's event buffer.
> I think this might be the core sticking point here.  It looks like two
> different situations:
>
>  (1) A explicitly sends event to B (eg. signalling, sendmsg, etc.)
>
>  (2) A implicitly and unknowingly sends event to B as a side effect of =
some
>      other action (eg. B has a watch for the event A did).
>
> The LSM treats them as the same: that is B must have MAC authorisation =
to send
> a message to A.

YES!

Threat is about what you can do, not what you intend to do.

And it would be really great if you put some thought into what
a rational model would be for UID based controls, too.

> But there are problems with not sending the event:
>
>  (1) B's internal state is then corrupt (or, at least, unknowingly inva=
lid).

Then B is a badly written program.

>  (2) B can potentially figure out that the event happened by other mean=
s.

Then why does it need the event mechanism in the first place?

> I've implemented four event sources so far:
>
>  (1) Keys/keyrings.  You can only get events on a key you have View per=
mission
>      on and the other process has to have write access to it, so I thin=
k this
>      is good enough.

Sounds fine.

>  (2) Block layer.  Currently this will only get you hardware error even=
ts,
>      which is probably safe.  I'm not sure you can manipulate those wit=
hout
>      permission to directly access the device files.

There's an argument to be made that this should require CAP_SYS_ADMIN,
or that an LSM like SELinux might include hardware error events in
policy, but generally I agree that system generated events like this
are both harmless and pointless for the general public to watch.

>  (3) Superblock.  This is trickier since it can see events that can be
>      manufactured (R/W <-> R/O remounting, EDQUOT) as well as events th=
at
>      can't without hardware control (EIO, network link loss, RF kill).

The events generated by processes (the 1st set) need controls
like keys. The events generated by the system (the 2nd set) may
need controls like the block layer.


>  (4) Mount topology.  This is the trickiest since it allows you to see =
events
>      beyond the point at which you placed your watch (in essence, you p=
lace a
>      subtree watch).

Like keys.

>      The question is what permission checking should I do?  Ideally, I'=
d
>      emulate a pathwalk between the watchpoint and the eventing object =
to see
>      if the owner of the watchpoint could reach it.

That will depend, as I've been saying, on what causes
the event to be generated. If it's from a process, the
question is "can the active process, the one that generated
the event, write to the passive, watching process?"
If it's the system on a hardware event, you may want the watcher
to have CAP_SYS_ADMIN.

>      I'd need to do a reverse walk, calling inode_permission(MAY_NOT_BL=
OCK)
>      for each directory between the eventing object and the watchpoint =
to see
>      if one rejects it - but some filesystems have a permission check t=
hat
>      can't be called in this state.

This is for setting the watch, right?

>      It would also be necessary to do this separately for each watchpoi=
nt in
>      the parental chain.
>
>      Further, each permissions check would generate an audit event and =
could
>      generate FAN_ACCESS and/or FAN_ACCESS_PERM fanotify events - which=
 could
>      be a problem if fanotify is also trying to post those events to th=
e same
>      watch queue.

If you required that the watching process open(dir) what
you want to watch you'd get this for free. Or did I miss
something obvious?

> David


--txkkq0wOFA671eV9SlTrRrBSRAcaZSaKJ--

--nAYbsaLPWvSYgBq1ZgUViHpZIInmpNbp5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEC+9tH1YyUwIQzUIeOKUVfIxDyBEFAlz31tgACgkQOKUVfIxD
yBEU8hAAj4xd0kV0Ucnk5ru/+nPSqV1JaihLZ77GVirKuvVGICRr78mNeNmZk6n2
u9YVwbFCdB/O/cLE9RtjQzB3PGbGuCNn9JOvKFPfSIARHmBpg93wj8KPamYmMzdJ
xltRCnoLwHwHJdZEKgAEIUEQajqIj36opyx7bshsYP8j36Pzn48F1f3Fg8Kg2X2d
MeDbje3oXdqf9tVQ8lVLv2EOfF4ZVBH8IqHfO1a7o8UpfZ2ZKilDF5ari5i0+L20
vvom1Xasat1j9BxFsNwwtDXU94LHK0XP5nMAHgHBjNlRQGpZ5Y7ET7RqbRxcuRNA
JznODlWUqba6wsY7tnQD1cV6WLRoVzzKi66qhRONJoM8l38916mqzwoneK141fv6
JNdlwq/xkniImrKIVKBszu3LmZsorLWRdlsnxy0XLBZvbbxegLRukiUnSu62m1DV
hrfGbTDKh6U1UPwaBrteSn0RNNdvl2cF5+GAc/BOMYTae4zSMJacpfX+R4GcPfpj
cTpLYExK2bfYvkIcmrrbt7H38Zhdk4cxEz1Z4UykohjkLdNmuv3kwAUih78JcUbh
bZe4OAGR9VYDyBqPxWlDHjrTlTZ3bIcjNAuArVZ4woBTtRaBdsAOhgomRR5S9fYF
HTbMjASC6nhlc+Rthv1pXPk4nr/PrAXiRvrqLQyNYOjXxWV8ix8=
=G8mX
-----END PGP SIGNATURE-----

--nAYbsaLPWvSYgBq1ZgUViHpZIInmpNbp5--
