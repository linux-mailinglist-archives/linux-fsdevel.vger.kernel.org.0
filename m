Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340B9109B96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 10:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKZJ4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 04:56:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:57567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfKZJ4f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574762192;
        bh=VpvycKW78m8Tny68PRS337gHW3Qist9GghGv0ECx258=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=ZG16Fsk1upt6cEGbZqX+keSLj/sUyYswoejVdCpBn3Ow3Wo4ccjh2ykCYjmxlg/PG
         TuOvuAt7heacxN0u3z3Wiwwe6tbxD+nin48GXuDHpQkNSIFIGjIqlAMY5E+4b2yWX7
         AziScnD/JnxhJUwKQey9g7DyNO5zeTL0HhLzscU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFKGZ-1ibyR43Zur-00FmkE; Tue, 26
 Nov 2019 10:56:32 +0100
Subject: Re: btrfs/058 deadlock with lseek
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
References: <3310d598-bd2f-6024-e5ac-c1c6080c0fd7@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <b99618bc-1215-6c2d-5bdb-e43cb79cbd8e@gmx.com>
Date:   Tue, 26 Nov 2019 17:56:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3310d598-bd2f-6024-e5ac-c1c6080c0fd7@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ecgI3Yf6QlNUfyBCjk8fhKB2vq3LAIImf"
X-Provags-ID: V03:K1:KEJ314lmnLnvbhj0GOA4nthFUXJK0EKzltuElC2bQh/ZErhQt19
 c8OG4hoL9+QE19ZmR8Ksf802kcrBScztGLDQeTOCmxSLolefG1+dHbj9RBX9aCOaX0oopf9
 wXjrfUNq5N/B1sNDQ8ADZbZsJXEqizDOloPl0t2bI2oStqdSjY/oZYSeDV6ZN/V6TMSSRd0
 pm0zJ8pzbhoZHayNJE3uw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:McVKMgu8IiE=:rQN+2H8u4JwtBj8EmAROPg
 VRmISAHVPFwKpnV4OyYKtDOHL8MMi8CrdqAVPwyVeyiv18JjbmxUjmGd4fVtnIYCJPYjS02Lt
 UR8Za+381qTF4ErB+zW9Tq4ypDvEQjcZYGsDy0Im55GmUHGYW+xYiRfL3EF9mzdWcvMHCWTT4
 Jw8hxEgLSZdRtS6dIuHinwWAtroWQpRGtQ5x8ZFMIKCpR8EbUufaxDxQKiMiur0PQqb5cppE+
 OM6qprl7SgMGgojKmHw4CnEl0NWYJUZVgjtarA+uxn8vF3PJhtWTTtizotuaXLoFPTJ6szK0R
 0LJdymQ7oFrar87GtMayOAyHLy9GTRb1iAcZEjH07KLc1Yn1NrpsTOZ7lKiGB4vWKx3G47orf
 kgCgxv3Qhi1M0kccE3rcOnKCAXtk1l57vPHuog0l+yDqnjSO1DyNULIofE0TPJI7zLrGePjOK
 82Ui3rh/s3alsnev9xHxmgEguF6ivwUQ/Zcjb9LCe9kKizytKH4Jwr59NEKvLLsoU7TzeTf1M
 R0Oj4mzjgN0/aeKOZUknNxMK3+otYOk1LkyK7lJdFp3dD6awGDc9pFzTWNjXgG/yEuol5AxN0
 lQ8HdoSOvNuwK70nnZWrNy1/Lj4HjvAaHRG8dv4oUU15YUU322wGHfPJhUOiEBUcjz0ENlJDg
 SS8pXVurNrNA5r8W/v6fz6sv5lMAelHHech2rzkY5dZ2kXP15QAK1R2nb5E25J/0aRDIPz4TE
 fVLvEh3HqUYo6prIeAS6IbEqntKdDIcCNLI/PAC3nIuyYBadBG+VhSjYCOF8pBhN6GY86/Sx3
 707l4+SxCObGuUrLPmQZx0HzUibXpnZrVYJyQPdZUztyiyUZ1UIK2txvm+e8L5ukPX8oB3QBF
 KM9PU220HnWmMEwW35chJL0wKHS3F1RrvzA0qTBxXS9/jCclGodnBaM0lqOpr7qhtaKOy95dQ
 RRzjuLYGHB8Bl+LNdBeZQgbQt3DRtV8MGAmK8LISuxMP6RAMeMDiRJL9C3+wFIXLmlmT5fLVD
 SGyYvsGPWlLJZ1LpIPixxCV5PqfQBqUMufk+VDuYEH6p0jXaZXjw/LumYbeD9RiVDtbL81is9
 erW+Rr4iLEd9cy3ytE8pEKbaNp2eoUzG+/y7Y1x+Qaviu3Q2o+lNdQTe3wkSdWCnTk0JpGPHs
 X+2S7TPisCBxuzEDtRoP4fM5qcJkzuhDNRyiyowQS+LVEFo8vuOLqfLhVuRHIasI6ysll+8Sq
 sQ1kmd/9Y3AprreTIVmeLnWFRSiCNBkePN7l7255N739ZK6pLjVl09FMCKtI=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ecgI3Yf6QlNUfyBCjk8fhKB2vq3LAIImf
Content-Type: multipart/mixed; boundary="E1ivtHTUZ01qqBxok0xP9IlNJ212PPRNe"

--E1ivtHTUZ01qqBxok0xP9IlNJ212PPRNe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/26 =E4=B8=8B=E5=8D=884:17, Qu Wenruo wrote:
> Hi guys,
>=20
> Just got a reproducible error in btrfs/058.
> The backtrace is completely in VFS territory, not btrfs related lock at=
 all:

With the help of Nikolay and Johannes, the offending commit is pinned
down to 0be0ee71816b ("vfs: properly and reliably lock f_pos in
fdget_pos()"), and Linus will soon revert it.

Not a big deal, but testers would have a much easier life using David's
misc-5.5 (still based on v5.4-rc).

And to David, would you please keep your misc-5.5 branch until the
offending patch get reverted?

Thanks,
Qu

> BTRFS info (device dm-5): checking UUID tree
> sysrq: Show Blocked State
>   task                        PC stack   pid father
> rm              D    0 560678 560445 0x00000000
> Call Trace:
>  __schedule+0x5c7/0xea0
>  ? __sched_text_start+0x8/0x8
>  ? lock_downgrade+0x380/0x380
>  ? lock_contended+0x730/0x730
>  ? debug_check_no_locks_held+0x60/0x60
>  schedule+0x7b/0x170
>  schedule_preempt_disabled+0x18/0x30
>  __mutex_lock+0x481/0xc70
>  ? __fdget_pos+0x7e/0x80
>  ? mutex_trylock+0x190/0x190
>  ? debug_lockdep_rcu_enabled+0x26/0x40
>  ? kmem_cache_free+0x157/0x3b0
>  ? putname+0x73/0x80
>  ? __ia32_sys_rmdir+0x30/0x30
>  ? __check_object_size+0x134/0x1e6
>  mutex_lock_nested+0x1b/0x20
>  ? mutex_lock_nested+0x1b/0x20
>  __fdget_pos+0x7e/0x80
>  ksys_lseek+0x1d/0xf0
>  __x64_sys_lseek+0x43/0x50
>  do_syscall_64+0x79/0xe0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7f7518e5652b
> Code: Bad RIP value.
> RSP: 002b:00007ffead7508e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7518e5652b
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00007f7518f267e0 R08: 0000000000000001 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000002 R14: 00007f7518f2be68 R15: 00007f7518f287e0
>=20
> Is this a known bug in VFS layer?
>=20
> Thanks,
> Qu
>=20


--E1ivtHTUZ01qqBxok0xP9IlNJ212PPRNe--

--ecgI3Yf6QlNUfyBCjk8fhKB2vq3LAIImf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3c9ssACgkQwj2R86El
/qjrjQgAqVQz8K4bilA1qqBXVKdWaTmuSBjRzP5nslHwXErZHrEJNe6R9DUg//i6
EpsapiMI40dP7FTcXQAyDljWJrZW1IvIGaFIBJu/m87TdEpClJNDDCBVOg15LmpS
O1rtQsCBi8ns75vTRslflAuBgqSwI8o3i371cVp2pmdugLFfOisSfXw2Sh7/TE6n
HYIcU95MZy9HbvL1YSp4ia+dfw5RTcu3R/l806tw4qd7Z0Eja5v6Ah0VfbC9PQBD
8g8At9MWZyMZdeccnKl9jZgnyOIi1VY9L+qlpveE863Lce1cH5NHSxU+ThxTZqIc
3oyQ1he5KaGr4a4cv5yLJ04dNnqSUQ==
=R3Is
-----END PGP SIGNATURE-----

--ecgI3Yf6QlNUfyBCjk8fhKB2vq3LAIImf--
