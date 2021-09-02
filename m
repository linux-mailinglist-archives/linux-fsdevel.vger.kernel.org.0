Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08AD3FF068
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbhIBPo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:44:59 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:41112
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345735AbhIBPo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630597438; bh=CMnoZ/z+WCWqz9q0+OWHxHAsEKwK8gfCAByMzG17zlc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=LL1DeJ4PgBoj42RjYAmPM2HZ8gP2b5YRFxo8kfXnmv1W7/liWY7iS8P8vVuQf7+5k/71nF1AvyMrlnyn0PMkOeAK3ELtsYUeoxxMLYQE0Q34YO4IRffq1y8F1p11qVtM85y+niy6j3cvd7dQuppZUjAPfZLSYLSWJPPb1SnB5Mwcl+r/KUu3QqgjEsGB38ugtk70uJs476ndSba7qKqFQWRufdRr3n9D6eq3B/8sxYRMF9CL8x78Kmqu/VXPmUqK1d7WlSFgJAslgOoJ6F7oAtqdUi5TkKXImqoNf2TAKm/jZM2hG9BlseEcykbkjo2gyE14qvDtN8nf561R8anluA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1630597438; bh=v7YKDwBsX/9bZwWX7SqyNcNss+A3MacF2cpHAJ/3v/I=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=BKHHS3QjEtFsHxqPu+FtyikuJ3D6AIaZ/ZGpgPQqEd58WcPm5iFjRrPFm3qNSRWRmgsZOI34iPvslMmbygYm4H1ODMxoqXiqe3YD7+rmZf22GeLcvyHA+5aPX2B4LoAN2TQml4dMOSWPPTC4sIOQMA1H7vzcVxQB2PLkBRpp2Xf4Q9w3qPIXsa9j/QSOYpCZIoITystseazU+V/9FoBYxC4jB6zCIsB9RRi195pCmEe9fvlRRBmCo2uN8ETFhH5Z+PafK3mpbg3Xo946gYPA3WSlGm0+Vf1NvcvxHSC/BBNzEb99v/BbyeM02o5mHJ9giADs2pG7sWTvyZOvJ/ExDw==
X-YMail-OSG: k6H_CZ4VM1nidKRD.43oA7hT5UhAAVuB1EkPRFafErnvCgRsC7UH_b1WDAReV0O
 XlqRzE2aRpnpHDkJgfiwrE.mJDfppRCv0oT.wSyLr3QcEJT0VOFtiZEAquggUtt0FvAQyQzceb.T
 P9GMGR_FahuizNZv51p95sJZv1XVS9l4PNWmsvODaQIW91ABtJppBqt6RI8UA0GgxKm2_r9h0Vwz
 Kz2mNe20I9QKdqxvdmaY3YQcGHwEGt5TeaceH91ymLQIW0vdmyXGv_a2Pc9bTDkGddDsYFCGqG1V
 w4a4ZtNvxIv9iAugPVjiocaJrgi1mf8A1H7p5vbs90ZlfvZLGkH7ueXhiMyHra7MuezmAGK1GoHM
 uAoa4qy9ppJ0HXRVP62OMeTp3QMS8165CGrLMnhGi_kBgq6gSCtMBy7Dw8gnMBxUqXo.DWjUZ.cB
 lhplsUlohWTokv9ohAq.p9yOnPVQ3iIAcH2aXVpFI_ilmnWavnS17FivZu.T3nrbqMjv2yxa0utE
 ezGOFp9jXzG4sWDScAi_NX.TS0rMH4sQDVqa346WkTvQL7WBXdhPZBHkX3ceYyQFJU_pfZl5u4KP
 6d2e_OjXtEiXHq86heBFPT8HJcrFjxuNw.58byp6T1AHjaLfivS8LcAQtHVfLBVcgSrkiQI.5axZ
 iRXozM5grS4t8kN359ntV1XINV6YQ4TGkArehcKNTwhMMalzaVtKITZ3GYAZaHBRIQDvp4RYZ3UV
 CjgnUpbcoTgI6FtCiO4CQeInniTRJCcS3Tvv9W7KqngSNGjqH1IObE5uUcc4cDHUWBG9OuTLj208
 WL5uNxBuLdGZmzVUrgY6xJlNicofi8_wD.okAR.bVIw7Qvc7QhKCakq_.HcycvqTE_sMBeF78vaW
 Vs2328h9U7dDyFHVezDW52aH_y0aZ0UiThiCHem9mGadugxeatetSc7JElk57ELAqIser8W7VScw
 DqeWjmJlnNoFkjvASyTOdpcKHOWLoR0viwlkuqdgBlFTSPmRTwnS8BQLcrJnn5OQjwRG2JQJLNz_
 5rz8isGNw18qIP0dsw0lWmLqclcxqZimGFevdIwWB_zrIfG8_L5x5cqVmucm15GVqj4pU7EXaDWZ
 GqQk6UcmWS7yic9NRjBGxJf8_cLFOUkoDuAXYM3VKNBFVzrkZs4sxBTdVM3wK5CqDB1L.whCz_Nc
 7jfz783ghgrOJW.9vgRl21ntDhTXSbKaQEX0q3KGsqVogyZPbZd7K_MjEGtAQHfYXXzvfuEOf8n5
 AkqQOyzvWbCcPyXpipDEULRVrM4IGHe4emuUVBtC3_zoHF4_AkgGD9Q.YECt2HFLj3dN_UsdpXpu
 3T6tmqlYjMyxBSD9QJ1wkrbQvFP7Gj3rRKvVFDYw9zxRgz1FrGSjYYFiyic14iR9iPDiwgz2Yv9C
 1WXKlFuqkdrlFr9wzHuab_rTG6zHiTbTSeYgwaNr4E0KgY64QUyn06Pts6_B_A_HsADMFWq9jyNE
 KvGYYpOvhOgF2_T4uX_qYjYQvogKTbjrSO7rGwes5zaoTJ8D2O741Y6cnoEkihpB90bpF6sYKRjH
 zuH2JJJv9ELRUAZIUHiudfhRpURqhbkhVzB9S5VKa.KJh27GDjjUG1IQi_g1b293ufix8ZRL3TKY
 hCnQVc.Ne80cLgafYyHJCJPQ59745UThga4P00mijhwB5pPfEvttw586.Sq56Io4VYE9KY1Ucmy4
 Aa6TXxboqVF1Xtgm9hPrvkcgR5W5c566cKeLtbARNR71Gz7NS0gnchFtALkgXKJ1qAqW3BfHo0U.
 sTvQ.3oN629Z3xg44Ab4m1IIK3rBILNLNuCio4.M1JLERZgB6k7WZiRzuow6aIleRuR41_HPiiQS
 PW0buXRlHq6GCditvJNqqQFPRSD7fhEsj1OVk83FZ513sV1c_lxhEhfqtaAYGPsXwvL8jSagrJ7B
 Fka4y39jIIvVI7UwkNbYVbyoJ97fR4mSz5uRlC4nHi6oMLInr0npTE14NayfGtoZsv46HH5Akrto
 K5nvnHFNZhCttomkuAaACMzJ_OnZtTIWy7hVg6DxQGZlOwDDDrntYiBtE18B.o83ujAt6.E4hA4V
 Hx1vFJnmiT.jJM0VS.aC2ygGvYB3l.UFP3SagbQeyeHtcd.IZBqNKPOdVAYnRF7vBCbVRA3t3D1S
 SHpa6gB2HfA7pKOYvqYI90R0dXABVws3gSphEYXS8LvePRlp6pG6Q8A4Ua4sJyxFtM3NUfYXH04a
 viWN1YbuhESSU0Wnu5p.dKSg8TFH2YEv8ZSZE0cncO7TlC8_HJxf1FcjjsqeE07t.6ih30wnGaID
 yNGRXO_C4IbYn
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Sep 2021 15:43:58 +0000
Received: by kubenode520.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 869f6cf839dbfeb4ab142416924cbaa4;
          Thu, 02 Sep 2021 15:43:54 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
Date:   Thu, 2 Sep 2021 08:43:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902152228.665959-1-vgoyal@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.18924 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/2021 8:22 AM, Vivek Goyal wrote:
> Hi,
>
> This is V3 of the patch. Previous versions were posted here.
>
> v2:
> https://lore.kernel.org/linux-fsdevel/20210708175738.360757-1-vgoyal@re=
dhat.com/
> v1:
> https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@r=
edhat.co
> +m/
>
> Changes since v2
> ----------------
> - Do not call inode_permission() for special files as file mode bits
>   on these files represent permissions to read/write from/to device
>   and not necessarily permission to read/write xattrs. In this case
>   now user.* extended xattrs can be read/written on special files
>   as long as caller is owner of file or has CAP_FOWNER.
> =20
> - Fixed "man xattr". Will post a patch in same thread little later. (J.=

>   Bruce Fields)
>
> - Fixed xfstest 062. Changed it to run only on older kernels where
>   user extended xattrs are not allowed on symlinks/special files. Added=

>   a new replacement test 648 which does exactly what 062. Just that
>   it is supposed to run on newer kernels where user extended xattrs
>   are allowed on symlinks and special files. Will post patch in=20
>   same thread (Ted Ts'o).
>
> Testing
> -------
> - Ran xfstest "./check -g auto" with and without patches and did not
>   notice any new failures.
>
> - Tested setting "user.*" xattr with ext4/xfs/btrfs/overlay/nfs
>   filesystems and it works.
> =20
> Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Right now we don't allow setting user.* xattrs on symlinks and special
> files at all. Initially I thought that real reason behind this
> restriction is quota limitations but from last conversation it seemed
> that real reason is that permission bits on symlink and special files
> are special and different from regular files and directories, hence
> this restriction is in place. (I tested with xfs user quota enabled and=

> quota restrictions kicked in on symlink).
>
> This version of patch allows reading/writing user.* xattr on symlink an=
d
> special files if caller is owner or priviliged (has CAP_FOWNER) w.r.t i=
node.

This part of your project makes perfect sense. There's no good
security reason that you shouldn't set user.* xattrs on symlinks
and/or special files.

However, your virtiofs use case is unreasonable.

> Who wants to set user.* xattr on symlink/special files
> -----------------------------------------------------
> I have primarily two users at this point of time.
>
> - virtiofs daemon.
>
> - fuse-overlay. Giuseppe, seems to set user.* xattr attrs on unprivilig=
ed
>   fuse-overlay as well and he ran into similar issue. So fuse-overlay
>   should benefit from this change as well.
>
> Why virtiofsd wants to set user.* xattr on symlink/special files
> ----------------------------------------------------------------
> In virtiofs, actual file server is virtiosd daemon running on host.
> There we have a mode where xattrs can be remapped to something else.
> For example security.selinux can be remapped to
> user.virtiofsd.securit.selinux on the host.

As I have stated before, this introduces a breach in security.
It allows an unprivileged process on the host to manipulate the
security state of the guest. This is horribly wrong. It is not
sufficient to claim that the breach requires misconfiguration
to exploit. Don't do this.

> This remapping is useful when SELinux is enabled in guest and virtiofs
> as being used as rootfs. Guest and host SELinux policy might not match
> and host policy might deny security.selinux xattr setting by guest
> onto host. Or host might have SELinux disabled and in that case to
> be able to set security.selinux xattr, virtiofsd will need to have
> CAP_SYS_ADMIN (which we are trying to avoid).

Adding this mapping to virtiofs provides the breach for any
LSM using xattrs.

>  Being able to remap
> guest security.selinux (or other xattrs) on host to something else
> is also better from security point of view.
>
> But when we try this, we noticed that SELinux relabeling in guest
> is failing on some symlinks. When I debugged a little more, I
> came to know that "user.*" xattrs are not allowed on symlinks
> or special files.
>
> So if we allow owner (or CAP_FOWNER) to set user.* xattr, it will
> allow virtiofs to arbitrarily remap guests's xattrs to something
> else on host and that solves this SELinux issue nicely and provides
> two SELinux policies (host and guest) to co-exist nicely without
> interfering with each other.

virtiofs could use security.* or system.* xattrs instead of user.*
xattrs. Don't use user.* xattrs.

>
> Thanks
> Vivek
>
> Vivek Goyal (1):
>   xattr: Allow user.* xattr on symlink and special files
>
>  fs/xattr.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>

