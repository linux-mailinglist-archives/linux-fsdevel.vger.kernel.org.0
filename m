Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8957C5B7C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 22:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiIMUOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 16:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIMUOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:14:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC9BC3F
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 13:14:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso2014430pjq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date;
        bh=tkdXf6hNxI7AIwIk1d1ONUg0Hbrfp0qbRtaSMbEsIJs=;
        b=D0aQK8EaQdYnpAU0C7f49xeshFOfVoaLmi2sBAOZUp10fXBPMtCJ2OE2Oj+4oOPWNm
         qWBSCMMe2BxpLfnW1tafgL1fBfI93R0onkmhQ26jtK7P0lzHN7kk4oPYNyBAc4BDrWjQ
         uM3kFC1VhP8gYWHG5MMyUOr/UVnUF6gMXFM/ud7mEPzPYM06KhgltY09rK0oBqnvhkFz
         bQS0CDlvyECxpZKq41Us4lLBsPlaUhavX8e3coZt4JWl4M9mwlb4h1JSP3eOE9gthsgD
         Sdsycatu72RhDvMII6bsNQdZwWKRb3dmdrNTMGF92fbg1h9qLew9ltsgUMaAZ+QxUGK9
         VDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=tkdXf6hNxI7AIwIk1d1ONUg0Hbrfp0qbRtaSMbEsIJs=;
        b=pcYvUC8kSaGm+YinJkRbLB7xfqjF9NotYE0C18Ahgn1mK8IxskjNB9Wvl6TYhhtFVi
         iLGMpAvbnSnRMIi9XBN8DU0DrlPz+d19F1icATqZPm2xTNLeEoG1MJT8eSVbSzJzmIMi
         uAFl4rAD9MELXjK8321FXAGi1jrWVo9JNtwgrxA23X6xrrMKCS9uPErsH6A5eZmpL7g3
         S+4KBZgyj4iV176fR3kXKjOWr4Lt6JbIePhO3ZFLYsB/3xo+rQiTnSmplwa+uB+E4TEo
         VfAfHudLiMb/Hp/jdEhP21YPUNmF1ksUkL/+51aRYfAKwsvQ/lv9i+cf+1XLd+qzv8XT
         eodg==
X-Gm-Message-State: ACgBeo0VMSv6Zu4JFLFt16O/XRhcf03OG7OoiqBtSW+iGRZye+tfBmaX
        VoralITywCU3MzTe73unysALQQ==
X-Google-Smtp-Source: AA6agR6MIRgCc6rTQBv2PBcKcN1FagcdWs+0J5PbPsRmAc4mnt5zx/PAJeBQudwDydKfAsqmAQyTsw==
X-Received: by 2002:a17:902:820a:b0:178:456e:138 with SMTP id x10-20020a170902820a00b00178456e0138mr5306590pln.145.1663100089216;
        Tue, 13 Sep 2022 13:14:49 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s90-20020a17090a2f6300b001f2ef3c7956sm7614729pjd.25.2022.09.13.13.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Sep 2022 13:14:47 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <223BB0AD-2E62-4248-A068-476039D17710@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_34F3978C-CE0A-4698-A464-B2CE63FB36EC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in
 __d_instantiate
Date:   Tue, 13 Sep 2022 14:14:43 -0600
In-Reply-To: <0000000000005c2d1f05e8945724@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ntfs3@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     syzbot <syzbot+29dc75ed37be943c610e@syzkaller.appspotmail.com>
References: <0000000000005c2d1f05e8945724@google.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_34F3978C-CE0A-4698-A464-B2CE63FB36EC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Sep 13, 2022, at 1:51 PM, syzbot =
<syzbot+29dc75ed37be943c610e@syzkaller.appspotmail.com> wrote:
>=20
> Hello,
>=20
> syzbot found the following issue on:

This is almost certainly an NTFS3 error handling bug due to mounting the
broken filesystem image, but the NTFS3 maintainer and list were not =
CC'd.

Cheers, Andreas

>=20
> HEAD commit:    a6b443748715 Merge branch 'for-next/core', =
remote-tracking..
> git tree:       =
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git =
for-kernelci
> console output: =
https://syzkaller.appspot.com/x/log.txt?x=3D16271d4f080000
> kernel config:  =
https://syzkaller.appspot.com/x/.config?x=3De79d82586727c5df
> dashboard link: =
https://syzkaller.appspot.com/bug?extid=3D29dc75ed37be943c610e
> compiler:       Debian clang version =
13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld =
(GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      =
https://syzkaller.appspot.com/x/repro.syz?x=3D162474a7080000
> C reproducer:   =
https://syzkaller.appspot.com/x/repro.c?x=3D119b6b78880000
>=20
> Downloadable assets:
> disk image: =
https://storage.googleapis.com/1436897f0dc0/disk-a6b44374.raw.xz
> vmlinux: =
https://storage.googleapis.com/68c4de151fbb/vmlinux-a6b44374.xz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> Reported-by: syzbot+29dc75ed37be943c610e@syzkaller.appspotmail.com
>=20
> ntfs3: loop0: Different NTFS' sector size (1024) and media sector size =
(512)
> ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size =
0.00 Gb. Mount in read-only
> ntfs3: loop0: Failed to load $Extend.
> Unable to handle kernel NULL pointer dereference at virtual address =
0000000000000008
> Mem abort info:
>  ESR =3D 0x0000000096000006
>  EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>  SET =3D 0, FnV =3D 0
>  EA =3D 0, S1PTW =3D 0
>  FSC =3D 0x06: level 2 translation fault
> Data abort info:
>  ISV =3D 0, ISS =3D 0x00000006
>  CM =3D 0, WnR =3D 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000109094000
> [0000000000000008] pgd=3D080000010aed9003, p4d=3D080000010aed9003, =
pud=3D080000010738d003, pmd=3D0000000000000000
> Internal error: Oops: 96000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 3027 Comm: syz-executor119 Not tainted =
6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 08/26/2022
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : d_flags_for_inode fs/dcache.c:1980 [inline]
> pc : __d_instantiate+0x2a0/0x2e4 fs/dcache.c:1998
> lr : d_flags_for_inode fs/dcache.c:1979 [inline]
> lr : __d_instantiate+0x80/0x2e4 fs/dcache.c:1998
> sp : ffff8000126f3ac0
> x29: ffff8000126f3ac0 x28: 0000000040000000 x27: ffff0000cd3a0000
> x26: ffff80000cf0e000 x25: fffffc0000000000 x24: 000000000001f000
> x23: ffff0000cd3a0000 x22: 0000000000000008 x21: 0000000000000000
> x20: ffff0000ca50ce48 x19: ffff0000c7732750 x18: 00000000000000c0
> x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c4f13500
> x14: 00000000000000b8 x13: 00000000ffffffff x12: ffff0000c4f13500
> x11: ff808000085e2a88 x10: 0000000000000000 x9 : ffff0000c4f13500
> x8 : 0000000000000000 x7 : ffff8000085e2e0c x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
> d_flags_for_inode fs/dcache.c:1980 [inline]
> __d_instantiate+0x2a0/0x2e4 fs/dcache.c:1998
> d_instantiate fs/dcache.c:2036 [inline]
> d_make_root+0x64/0xa8 fs/dcache.c:2071
> ntfs_fill_super+0x1420/0x14a4 fs/ntfs/super.c:180
> get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
> ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
> vfs_get_tree+0x40/0x140 fs/super.c:1530
> do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
> path_mount+0x358/0x914 fs/namespace.c:3370
> do_mount fs/namespace.c:3383 [inline]
> __do_sys_mount fs/namespace.c:3591 [inline]
> __se_sys_mount fs/namespace.c:3568 [inline]
> __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
> __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
> invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
> el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
> do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
> el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
> el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
> el0t_64_sync+0x18c/0x190
> Code: 79000688 52a00417 17ffff83 f9401288 (f9400508)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>   0:	79000688 	strh	w8, [x20, #2]
>   4:	52a00417 	mov	w23, #0x200000              	// =
#2097152
>   8:	17ffff83 	b	0xfffffffffffffe14
>   c:	f9401288 	ldr	x8, [x20, #32]
> * 10:	f9400508 	ldr	x8, [x8, #8] <-- trapping instruction
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches


Cheers, Andreas






--Apple-Mail=_34F3978C-CE0A-4698-A464-B2CE63FB36EC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmMg5LQACgkQcqXauRfM
H+C0Bg//buvSmpgOXoJBcsaEogkwWgkPxzOZgBjega4AOj9c3xy888bfof7b6xeK
QgM5rD8Q0uj4EzFq63txILA811SOtMKnHZkEBaHnQRa3cI7HVcO5ti2oeCcI9NuF
9SH4aeCvuvZE+9WIbbqJWckRr1DUl3TmXe/spboUOpe3f/KYRn9UhZFGfH3RCMIl
Mta7HFZ95qXaP2rSCv+hpQfmeofTr3q8yHPTJ5QN7GEQwrfb1rW45SwYR/Afpb7M
yLXx2mrwEcTa83Iod6F6pdrrUcM0gO8kdSVd3PGwj3/X3l+KVo8Rnm5AbVd6xVcS
1uJZTfwIsJnworn6NCQsWkwOb1hDvcoZMolkOJ00OzHV9VVsIzdyvoIlEZ2ZYOPo
tKdLxqe4fNx+h+yrsXxc0oqwDs3l3AvAzHCBzkoXX/aQY9piYh8YuOa1xyanHcgC
dsR0/PEd1qeoyUn1nF/yZQFuz8C1PTdRknjEBh7OUsrfNzNL//0tujEM9G13FCz2
KGt+Gol4WRzc8hM7W16yO3f7npii9tZhFrPEORDFVXuLL8Ff/WJPbiSe5iGNGTvd
04aRUxvDbF9CU+dS57ggKXn9v4+h/zzFFMBc3vDpj0XYdwifxFqvw7SeK55KqyV9
x+idKrtazoILjw176ws4AFY4ad5G6o9n7HVWrs9aHYwUSjLcNvs=
=KLw2
-----END PGP SIGNATURE-----

--Apple-Mail=_34F3978C-CE0A-4698-A464-B2CE63FB36EC--
