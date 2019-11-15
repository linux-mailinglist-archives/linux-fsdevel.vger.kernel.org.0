Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE18FDE82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 14:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKONCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 08:02:18 -0500
Received: from mail3.bemta25.messagelabs.com ([195.245.230.83]:54613 "EHLO
        mail3.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727329AbfKONCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1573822934; i=@ts.fujitsu.com;
        bh=k+H+CVSatppUOQyJxJ3LGwioJN5sjsx+B/C+6EaE0qc=;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
         Content-Transfer-Encoding:Content-Type;
        b=jjj6z3aZPMS6mls3d0z/s97ER0A0w8nywl7y3dDDZMhxNCyu/pp1tcUz5TBhV8KQf
         9Jp3jDTeIRVX0uyqRIjRwME8JbEnAqSQmmRJ1/rppYchFVRRiBBOj/nQrovzd/2fxV
         nLoz6o9MnE6H/nyVMhb0i7+IivMKYbNmD0dt+qpHaDELLBrX6pKwb1hTmgLhpy5ehl
         fcfJetM/Q+1HLwo7qKbjSRsZKG6ZJtIXrTphy03sG5pdu7oeM3YlvsalMvvZ0+Hykq
         heKlaU13UZPtNhyF6k+n7/m4rZ65L5AWlgePkgWLOPGZdic2xZ/3l3J23ng0mDRFrx
         o6CR9crXQ0KCg==
Received: from [46.226.52.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 8D/3D-04581-6D1AECD5; Fri, 15 Nov 2019 13:02:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRWlGSWpSXmKPExsViZ8MRqntt4bl
  Yg4+fJSy+/Wlls9iz9ySLxeVdc9gszv89zurA4rFz1l12j8+b5Dw2PXnLFMAcxZqZl5RfkcCa
  Mf3iZ8aCO9oV+xcsZGlgnKfSxcjFISQwh1Fiw+75zBDOAkaJs9cus3cxcnKwCRhI7Hp1iBnEF
  hHoZ5T4d4yxi5GDg1lAQmLCfweQsLCAvcTR+Q1gJSwCqhKfbu9nAbF5BQwlvl2azwhhC0qcnP
  kELM4soC2xbOFrZghbR2LB7k9sExi5ZyEpm4WkbBaSsgWMzKsYLZKKMtMzSnITM3N0DQ0MdA0
  NjXQNLS10jYwM9BKrdJP0Ukt1y1OLS3QN9RLLi/WKK3OTc1L08lJLNjECwy6l4NidHYxtH97q
  HWKU5GBSEuXNen02VogvKT+lMiOxOCO+qDQntfgQowwHh5IE7/I552KFBItS01Mr0jJzgDEAk
  5bg4FES4e2dD5TmLS5IzC3OTIdInWI05lj1f94iZo7r7/cuZRZiycvPS5US53VeAFQqAFKaUZ
  oHNwgWm5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfNeAVnIk5lXArfvFdApTECntBw+BXJ
  KSSJCSqqBSSz5f8HBhUuqBAKLm++u2/bqeGNMf5j+b8u3Wp0cq9nOLHqovqxdhPeH8SF2wZNb
  L1UGMz+QXiq0+PKF+yxNvz+ln9pk92gC4/qc6RYF65giX0gu+cAspX7j1WOO4PVqrR+fPHC0k
  q1/2N/0v3CPfGfYkSsOJi/CvJKLE7gm7Gd1vp7D9f5j9uspTydLz/votI7jHmf6XttdLaF1X4
  zluFWid+wqvfU4ZPkluUaXvj0nr1iX9G24NEeHif/PkuNB4VuNqvwPayQo7jry84b3g7cPWWv
  0/tRK77OdFV0S9Hq6kLaP8xJevvq65TLzWc6sbFstVVQwWzA9SEvjevPWa06Zb9yt5/z0/6od
  +c1KS4mlOCPRUIu5qDgRAEQUeCRIAwAA
X-Env-Sender: dietmar.hahn@ts.fujitsu.com
X-Msg-Ref: server-31.tower-285.messagelabs.com!1573822933!1080717!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14720 invoked from network); 15 Nov 2019 13:02:14 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-31.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Nov 2019 13:02:14 -0000
Received: from sanpedro.mch.fsc.net ([172.17.20.6])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id xAFD24we024024;
        Fri, 15 Nov 2019 13:02:04 GMT
Received: from amur.mch.fsc.net (unknown [10.172.102.131])
        by sanpedro.mch.fsc.net (Postfix) with ESMTP id C7F789CFFB35;
        Fri, 15 Nov 2019 14:01:55 +0100 (CET)
From:   Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     dieti.hahn@gmail.com
Subject: Kernel panic because of wrong contents in core_pattern
Date:   Fri, 15 Nov 2019 14:01:55 +0100
Message-ID: <1856804.EHpamdVGlA@amur.mch.fsc.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

#uname -r
5.4.0-rc7-10.g62d06a0-default+

we use our own core dump utility and by mistake I did:
# echo "| /opt/SMAW/X2000/bin/x2write_core %p" > /proc/sys/kernel/core_patt=
ern

Later a user tool dumped with SIGSEGV and the linux system crashed.
I investigated the crash dump and found the cause.

Via format_corename() in fs/coredump.c the helper_argv[] with 3 entries is
created and helper_argv[0] =3D=3D "" (because of the ' ' after the '|')
ispipe is set to 1.
Later in call_usermodehelper_setup():
  sub_info->path =3D path;  =3D=3D helper_argv[0] =3D=3D ""
This leads in call_usermodehelper_exec() to:
  if (strlen(sub_info->path) =3D=3D 0)
                goto out;
with a return value of 0.
But no pipe is created and thus cprm.file =3D=3D NULL.
This leads in file_start_write() to the panic because of dereferencing
 file_inode(file)->i_mode)

I'am not sure what's the best way to fix this so I've no patch.
Thanks.

Dietmar.


[  249.719984] a[8204]: segfault at 1 ip 00007f7fe523e3c1 sp 00007ffe9ecf03=
c0 error 4 in libc-2.22.so[7f7fe51f4000+19c000]
[  249.719989] Code: 4c 8b 85 28 fb ff ff 44 29 e8 48 98 49 39 c1 0f 87 a2 =
f7 ff ff 44 03 ad 20 fb ff ff e9 02 ec ff ff 31 c0 48 83 c9 ff 4c 89 d7 <f2=
> ae c7 85 28 fb ff ff 00 00 00 00 48 89 ce 48 f7 d6 4c 8d 4e ff
[  489.128821] a[20151]: segfault at 1 ip 00007fd584f603c1 sp 00007ffe98182=
c30 error 4 in libc-2.22.so[7fd584f16000+19c000]
[  489.128827] Code: 4c 8b 85 28 fb ff ff 44 29 e8 48 98 49 39 c1 0f 87 a2 =
f7 ff ff 44 03 ad 20 fb ff ff e9 02 ec ff ff 31 c0 48 83 c9 ff 4c 89 d7 <f2=
> ae c7 85 28 fb ff ff 00 00 00 00 48 89 ce 48 f7 d6 4c 8d 4e ff
[  489.128839] BUG: kernel NULL pointer dereference, address: 0000000000000=
020
[  489.152546] #PF: supervisor read access in kernel mode
[  489.170234] #PF: error_code(0x0000) - not-present page
[  489.187917] PGD 8000000318008067 P4D 8000000318008067 PUD 31b40b067 PMD 0
[  489.211343] Oops: 0000 [#1] SMP PTI
[  489.223600] CPU: 0 PID: 20151 Comm: a Kdump: loaded Tainted: G          =
I E     5.4.0-rc7-10.g62d06a0-default+ #1
[  489.258196] Hardware name: FUJITSU                          PRIMERGY TX3=
00 S5             /D2619, BIOS 6.00 Rev. 1.14.2619              02/04/2013
[  489.303082] RIP: 0010:do_coredump+0x717/0xb10
[  489.318229] Code: ff 48 8b bd 18 ff ff ff 48 85 ff 74 05 e8 e1 5b fa ff =
65 48 8b 04 25 c0 8b 01 00 48 8b 00 48 8b 7d a0 a8 04 0f 85 fe 02 00 00 <48=
> 8b 57 20 0f b7 02 66 25 00 f0 66 3d 00 80 0f 84 a2 01 00 00 48
[  489.381755] RSP: 0000:ffffaedc80a67cd0 EFLAGS: 00010246
[  489.399795] RAX: 0000000000000000 RBX: ffff9b68dcee72c0 RCX: 00000000000=
00000
[  489.424137] RDX: 0000000000000000 RSI: ffffaedc80a67ca0 RDI: 00000000000=
00000
[  489.448464] RBP: ffffaedc80a67df8 R08: 0000000000000000 R09: ffffaedc80a=
67c28
[  489.472806] R10: 0000000000001f30 R11: 0000000000000001 R12: ffff9b68dfa=
08cc0
[  489.497150] R13: 0000000000000001 R14: ffffffff8ed205a0 R15: ffff9b68dce=
fe1e0
[  489.521493] FS:  00007fd5854c6700(0000) GS:ffff9b68ffc00000(0000) knlGS:=
0000000000000000
[  489.548997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  489.568776] CR2: 0000000000000020 CR3: 00000003180fe000 CR4: 00000000000=
006f0
[  489.593145] Call Trace:
[  489.602067]  ? sched_clock+0x5/0x10
[  489.614420]  ? _raw_spin_lock_irqsave+0x20/0x50
[  489.630206]  get_signal+0x13c/0x860
[  489.642560]  ? printk+0x52/0x6e
[  489.653767]  do_signal+0x36/0x630
[  489.665538]  ? signal_wake_up_state+0x15/0x30
[  489.680743]  ? __send_signal+0x287/0x3f0
[  489.694514]  exit_to_usermode_loop+0x95/0x130
[  489.709705]  prepare_exit_to_usermode+0x98/0xd0
[  489.725462]  retint_user+0x8/0x18
[  489.737208] RIP: 0033:0x7fd584f603c1
[  489.749801] Code: 4c 8b 85 28 fb ff ff 44 29 e8 48 98 49 39 c1 0f 87 a2 =
f7 ff ff 44 03 ad 20 fb ff ff e9 02 ec ff ff 31 c0 48 83 c9 ff 4c 89 d7 <f2=
> ae c7 85 28 fb ff ff 00 00 00 00 48 89 ce 48 f7 d6 4c 8d 4e ff
[  489.813373] RSP: 002b:00007ffe98182c30 EFLAGS: 00010286
[  489.831437] RAX: 0000000000000000 RBX: 00007fd5852b62a0 RCX: fffffffffff=
fffff
[  489.855810] RDX: 0000000000000010 RSI: 00007ffe98183188 RDI: 00000000000=
00001
[  489.880186] RBP: 00007ffe981831c0 R08: 00000000004005fa R09: 00000000000=
00073
[  489.904551] R10: 0000000000000001 R11: 0000000000000000 R12: 00000000004=
005f4
[  489.928910] R13: 0000000000000006 R14: 0000000000000000 R15: 00007ffe981=
831d8
[  489.953261] Modules linked in: binfmt_misc(E) ebtable_filter(E) ebtables=
(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E) x_table=
s(E) bpfilter(E) rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E)=
 nfs(E) lockd(E) grace(E) sunrpc(E) fscache(E) scsi_transport_iscsi(E) mptc=
tl(E) mptbase(E) af_packet(E) bonding(E) iscsi_ibft(E) iscsi_boot_sysfs(E) =
intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) igb(E) msr(E) lpc_ich(E=
) mfd_core(E) pcspkr(E) irqbypass(E) i2c_i801(E) raid1(E) md_mod(E) ses(E) =
enclosure(E) scsi_transport_sas(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandl=
er(E) ac(E) ioatdma(E) i7core_edac(E) i5500_temp(E) dca(E) ext4(E) crc16(E)=
 mbcache(E) jbd2(E) hid_generic(E) usbhid(E) sd_mod(E) sr_mod(E) cdrom(E) m=
gag200(E) drm_vram_helper(E) i2c_algo_bit(E) ata_generic(E) ata_piix(E) drm=
_kms_helper(E) syscopyarea(E) ahci(E) sysfillrect(E) sysimgblt(E) libahci(E=
) fb_sys_fops(E) uhci_hcd(E) ttm(E) ehci_pci(E) crc32c_intel(E) ehci_hcd(E)=
 libata(E) drm(E) usbcore(E)
[  489.953296]  megaraid_sas(E) button(E) sg(E) dm_multipath(E) dm_mod(E) s=
csi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E)
[  490.288829] CR2: 0000000000000020



