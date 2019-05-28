Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388B92C35F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE1Jiu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 05:38:50 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45343 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfE1Jit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 05:38:49 -0400
Received: by mail-wr1-f53.google.com with SMTP id b18so19395223wrq.12;
        Tue, 28 May 2019 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:in-reply-to
         :references:user-agent:content-transfer-encoding;
        bh=88EYeeV52/R4oCCVo7mFS9dZzJ/eyssK02VZOUitP4M=;
        b=KHDYMat8UNjMGoluYQAsJTUcqg13McipzxcM/0ipo4IkNdkVYfmNRxDliZ8gkBgnJS
         jbILH7tMj0olQwYU7xljDYF4GuhqkEC7EphcLYUOS9RfKvbq/q+HaaGUdxWyyD8Dli4i
         Ntal1hfpvmfRCyphcizpDWa8yv52JbVPxmozmqdGB/rVL2Jct651p4uy+93yglzChk9O
         q4I1yjq82y7WE03fncWCa+bRaolWpN5cN4XdU4fWIa00hd3sLXmeg9r7G86tsrYqrXos
         txemKyIXiKFXhtEejhBKTvnKIsLJYEyfucJB/WWLUE+6KeTuZhPQBdrzxEHkpgSIfBKk
         LJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :in-reply-to:references:user-agent:content-transfer-encoding;
        bh=88EYeeV52/R4oCCVo7mFS9dZzJ/eyssK02VZOUitP4M=;
        b=lYiFKkPhB+2hRTHf2pvuqa3xmOT6WHnm3mlU52Xwwo2EBjzgvPnW4mPeEoEd+1taw+
         YaIYCLXx9muDsZL2jz+519wnjohFjk1kxO8BVEDBzvJiCx7L5UF9IpFZRN4qopgRLOAf
         ndJdE81Ql14ohQbLp6+OK/VWHtCXzeHYQdAsMX5I3GJ9KxPzISEqNmaaXzaJ2BZ7z4QA
         SCgPGTRbUlJR61vacCesXuBhBRX4sdpASZhLtDRoW9W6KdrwvbmreZ/WUuv6K+mC4RoZ
         LAiuUE2t6g719gkzfYv6lOj+8w613grX/xkA0sXz7VYBSP7Xcujly5N3lboNkpR4uyUI
         mbEQ==
X-Gm-Message-State: APjAAAX1T+tH3ma7ojrckohpn5zwrlDyI6MRyoaaexiz85Z3SDuuaP1l
        Xp6HWjUNsbJKIQE7DEs1selRJbO79ng=
X-Google-Smtp-Source: APXvYqydxJDDu2FDv3Z0FQgSLWAEWOyCOqxZS9iTD7D7w9TEpOHRtzaGCIHwuxZtFDCgNyYF8WBsCQ==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr2398274wrw.214.1559036325696;
        Tue, 28 May 2019 02:38:45 -0700 (PDT)
Received: from localhost ([92.59.185.54])
        by smtp.gmail.com with ESMTPSA id f2sm3187760wme.12.2019.05.28.02.38.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 02:38:44 -0700 (PDT)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: =?iso-8859-1?Q?d=5Flookup:_Unable_to_handle_kernel_paging_request?=
Date:   Tue, 28 May 2019 11:38:43 +0200
MIME-Version: 1.0
Message-ID: <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
In-Reply-To: <20190522162945.GN17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, May 22, 2019 6:29:46 PM CEST, Al Viro wrote:
>...
> IOW, here we have also run into bogus hlist forward pointer or head -
> same 0x1000000 in one case and 0x0000880001000000 in two others.
>
> Have you tried to see if KASAN catches anything on those loads?
> Use-after-free, for example...  Another thing to try: slap
> =09WARN_ON(entry->d_flags & DCACHE_NORCU);
> in __d_rehash() and see if it triggers.

Hi Al,
after 5 days with v5.2-rc1 + KASAN + WARN_ON could not reproduce the issue.
Neither the first day running v5.3-rc2 + WARN_ON. But today 6 times.
So, there is no KASAN and also the WARN_ON, being there, did not trigger.
The first trace hapenned while untaring a big file into tmpfs. The other
five while "git pull -r" severeal repos on f2fs.

Regards,
  Vicen=C3=A7.

Unable to handle kernel paging request at virtual address 0000000001000018
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000aeab4000
[0000000001000018] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#1] SMP
CPU: 4 PID: 1172 Comm: tar Not tainted 5.2.0-rc2 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup+0x58/0x198
lr : d_lookup+0x38/0x68
sp : ffff000012663b90
x29: ffff000012663b90 x28: ffff000012663d58=20
x27: 0000000000000000 x26: ffff8000ae7cc900=20
x25: 0000000000000001 x24: ffffffffffffffff=20
x23: 00000000ce9c8f81 x22: 0000000000000000=20
x21: 0000000000000001 x20: ffff000012663d58=20
x19: 0000000001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: b4fea3d0a3a4b4fe=20
x9 : d237122a91454b69 x8 : a0591ae4450bed6a=20
x7 : 5845a2c80f79d4e7 x6 : 0000000000000004=20
x5 : 0000000000000000 x4 : ffff000012663d58=20
x3 : ffff000010828a68 x2 : ffff000010828000=20
x1 : ffff8000f3000000 x0 : 00000000000674e4=20
Call trace:
 __d_lookup+0x58/0x198
 d_lookup+0x38/0x68
 path_openat+0x4a8/0xfb8
 do_filp_open+0x60/0xd8
 do_sys_open+0x144/0x1f8
 __arm64_sys_openat+0x20/0x28
 el0_svc_handler+0x74/0x140
 el0_svc+0x8/0xc
Code: 92800018 a9025bf5 d2800016 52800035 (b9401a62)=20
---[ end trace 7fc40d1e6d2ed53e ]---
Unable to handle kernel paging request at virtual address 0000000000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000007af3e000
[0000000000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#1] SMP
CPU: 4 PID: 2124 Comm: git Not tainted 5.2.0-rc2 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup_rcu+0x68/0x198
lr : lookup_fast+0x44/0x2e8
sp : ffff0000130b3b60
x29: ffff0000130b3b60 x28: 00000000ce99d070=20
x27: ffffffffffffffff x26: 0000000000000026=20
x25: ffff8000ecec6030 x24: ffff0000130b3c2c=20
x23: 0000000000000006 x22: 00000026ce99d070=20
x21: ffff8000811f3d80 x20: 0000000000020000=20
x19: 0000000001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: e4d0b2e6e2b4b6e9=20
x9 : 5096e90463dfacb0 x8 : 2b4f8961c30ebc93=20
x7 : aec349fb204a7256 x6 : 4fd9025392b5761a=20
x5 : 02ff010101030100 x4 : ffff8000f3000000=20
x3 : ffff0000130b3d58 x2 : ffff0000130b3c2c=20
x1 : 00000000000674ce x0 : ffff8000811f3d80=20
Call trace:
 __d_lookup_rcu+0x68/0x198
 lookup_fast+0x44/0x2e8
 path_openat+0x19c/0xfb8
 do_filp_open+0x60/0xd8
 do_sys_open+0x144/0x1f8
 __arm64_sys_openat+0x20/0x28
 el0_svc_handler+0x74/0x140
 el0_svc+0x8/0xc
Code: 9280001b 14000003 f9400273 b4000793 (b85fc265)=20
---[ end trace 6bd1b3b7588a78fe ]---
Unable to handle kernel paging request at virtual address 0000880000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000867ac000
[0000880000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#2] SMP
CPU: 4 PID: 2183 Comm: git Tainted: G      D           5.2.0-rc2 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup_rcu+0x68/0x198
lr : lookup_fast+0x44/0x2e8
sp : ffff00001325ba90
x29: ffff00001325ba90 x28: 00000000ce99f075=20
x27: ffffffffffffffff x26: 0000000000000007=20
x25: ffff8000ecec402a x24: ffff00001325bb5c=20
x23: 0000000000000007 x22: 00000007ce99f075=20
x21: ffff80007a810c00 x20: 0000000000000000=20
x19: 0000880001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: d0bbbcbfa6b2b9bc=20
x9 : 0000000000000000 x8 : ffff80007a810c00=20
x7 : 6cad9ff29d8de19c x6 : ff94ec6f0ce3656c=20
x5 : ffff8000ecec402a x4 : ffff8000f3000000=20
x3 : ffff00001325bc78 x2 : ffff00001325bb5c=20
x1 : 00000000000674cf x0 : ffff80007a810c00=20
Call trace:
 __d_lookup_rcu+0x68/0x198
 lookup_fast+0x44/0x2e8
 walk_component+0x34/0x2e0
 path_lookupat.isra.0+0x5c/0x1e0
 filename_lookup+0x78/0xf0
 user_path_at_empty+0x44/0x58
 vfs_statx+0x70/0xd0
 __se_sys_newfstatat+0x20/0x40
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x74/0x140
 el0_svc+0x8/0xc
Code: 9280001b 14000003 f9400273 b4000793 (b85fc265)=20
---[ end trace 6bd1b3b7588a78ff ]---
Unable to handle kernel paging request at virtual address 0000880000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000867ac000
[0000880000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#3] SMP
CPU: 4 PID: 2180 Comm: git Tainted: G      D           5.2.0-rc2 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup_rcu+0x68/0x198
lr : lookup_fast+0x44/0x2e8
sp : ffff000012a3ba90
x29: ffff000012a3ba90 x28: 00000000ce99f075=20
x27: ffffffffffffffff x26: 0000000000000007=20
x25: ffff8000ecec702a x24: ffff000012a3bb5c=20
x23: 0000000000000007 x22: 00000007ce99f075=20
x21: ffff80007a810c00 x20: 0000000000000000=20
x19: 0000880001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: d0bbbcbfa6b2b9bc=20
x9 : 0000000000000000 x8 : ffff80007a810c00=20
x7 : 6cad9ff29d8de19c x6 : ff94ec6f0ce3656c=20
x5 : ffff8000ecec702a x4 : ffff8000f3000000=20
x3 : ffff000012a3bc78 x2 : ffff000012a3bb5c=20
x1 : 00000000000674cf x0 : ffff80007a810c00=20
Call trace:
 __d_lookup_rcu+0x68/0x198
 lookup_fast+0x44/0x2e8
 walk_component+0x34/0x2e0
 path_lookupat.isra.0+0x5c/0x1e0
 filename_lookup+0x78/0xf0
 user_path_at_empty+0x44/0x58
 vfs_statx+0x70/0xd0
 __se_sys_newfstatat+0x20/0x40
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x74/0x140
 el0_svc+0x8/0xc
Code: 9280001b 14000003 f9400273 b4000793 (b85fc265)=20
---[ end trace 6bd1b3b7588a7900 ]---
Unable to handle kernel paging request at virtual address 0000880000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000073f2f000
[0000880000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#4] SMP
CPU: 4 PID: 2210 Comm: git Tainted: G      D           5.2.0-rc2 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup_rcu+0x68/0x198
lr : lookup_fast+0x44/0x2e8
sp : ffff0000132bba90
x29: ffff0000132bba90 x28: 00000000ce99e1a6=20
x27: ffffffffffffffff x26: 000000000000000c=20
x25: ffff8000f21dd036 x24: ffff0000132bbb5c=20
x23: 0000000000000004 x22: 0000000cce99e1a6=20
x21: ffff800074dd8d80 x20: 0000000000000000=20
x19: 0000880001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: d0d0d0d0b8fea4b3=20
x9 : 40bcd8645005512e x8 : c433ade89ebd10f9=20
x7 : c6b69091eeb194d2 x6 : 848f758ca69635b4=20
x5 : ffff8000f21dd036 x4 : ffff8000f3000000=20
x3 : ffff0000132bbc78 x2 : ffff0000132bbb5c=20
x1 : 00000000000674cf x0 : ffff800074dd8d80=20
Call trace:
 __d_lookup_rcu+0x68/0x198
 lookup_fast+0x44/0x2e8
 walk_component+0x34/0x2e0
 path_lookupat.isra.0+0x5c/0x1e0
 filename_lookup+0x78/0xf0
 user_path_at_empty+0x44/0x58
 vfs_statx+0x70/0xd0
 __se_sys_newfstatat+0x20/0x40
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x74/0x140
 el0_svc+0x8/0xc
Code: 9280001b 14000003 f9400273 b4000793 (b85fc265)=20
---[ end trace 6bd1b3b7588a7901 ]---
Unable to handle kernel paging request at virtual address 0000880000fffffc
Mem abort info:
  ESR =3D 0x96000004
  Exception class =3D DABT (current EL), IL =3D 32 bits
  SET =3D 0, FnV =3D 0
  EA =3D 0, S1PTW =3D 0
Data abort info:
  ISV =3D 0, ISS =3D 0x00000004
  CM =3D 0, WnR =3D 0
user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000073f2f000
[0000880000fffffc] pgd=3D0000000000000000
Internal error: Oops: 96000004 [#5] SMP
CPU: 5 PID: 2200 Comm: git Tainted: G      D           5.2.0-rc2 #1
Hardware name: Sapphire-RK3399 Board (DT)
pstate: 00000005 (nzcv daif -PAN -UAO)
pc : __d_lookup_rcu+0x68/0x198
lr : lookup_fast+0x44/0x2e8
sp : ffff000013263a90
x29: ffff000013263a90 x28: 00000000ce99e1a6=20
x27: ffffffffffffffff x26: 000000000000000c=20
x25: ffff8000f0a6f036 x24: ffff000013263b5c=20
x23: 0000000000000004 x22: 0000000cce99e1a6=20
x21: ffff800074dd8d80 x20: 0000000000000000=20
x19: 0000880001000000 x18: 0000000000000000=20
x17: 0000000000000000 x16: 0000000000000000=20
x15: 0000000000000000 x14: 0000000000000000=20
x13: 0000000000000000 x12: 0000000000000000=20
x11: fefefefefefefeff x10: d0d0d0d0b8fea4b3=20
x9 : 40bcd8645005512e x8 : c433ade89ebd10f9=20
x7 : c6b69091eeb194d2 x6 : 848f758ca69635b4=20
x5 : ffff8000f0a6f036 x4 : ffff8000f3000000=20
x3 : ffff000013263c78 x2 : ffff000013263b5c=20
x1 : 00000000000674cf x0 : ffff800074dd8d80=20
Call trace:
 __d_lookup_rcu+0x68/0x198
 lookup_fast+0x44/0x2e8
 walk_component+0x34/0x2e0
 path_lookupat.isra.0+0x5c/0x1e0
 filename_lookup+0x78/0xf0
 user_path_at_empty+0x44/0x58
 vfs_statx+0x70/0xd0
 __se_sys_newfstatat+0x20/0x40
 __arm64_sys_newfstatat+0x18/0x20
 el0_svc_handler+0x74/0x140
 el0_svc+0x8/0xc
Code: 9280001b 14000003 f9400273 b4000793 (b85fc265)=20
---[ end trace 6bd1b3b7588a7902 ]---



00000000000001c8 <__d_rehash>:
=09return dentry_hashtable + (hash >> d_hash_shift);
     1c8:=0990000001 =09adrp=09x1, 0 <find_submount>
=09=09=091c8: R_AARCH64_ADR_PREL_PG_HI21=09.data..read_mostly
     1cc:=0991000022 =09add=09x2, x1, #0x0
=09=09=091cc: R_AARCH64_ADD_ABS_LO12_NC=09.data..read_mostly

static void __d_rehash(struct dentry *entry)
{
=09struct hlist_bl_head *b =3D d_hash(entry->d_name.hash);

=09WARN_ON(entry->d_flags & DCACHE_NORCU);
     1d0:=09b9400003 =09ldr=09w3, [x0]
=09return dentry_hashtable + (hash >> d_hash_shift);
     1d4:=09f9400025 =09ldr=09x5, [x1]
=09=09=091d4: R_AARCH64_LDST64_ABS_LO12_NC=09.data..read_mostly
     1d8:=09b9400841 =09ldr=09w1, [x2, #8]
     1dc:=09b9402002 =09ldr=09w2, [x0, #32]
     1e0:=091ac12442 =09lsr=09w2, w2, w1
     1e4:=098b020ca1 =09add=09x1, x5, x2, lsl #3
=09WARN_ON(entry->d_flags & DCACHE_NORCU);
     1e8:=0937f00343 =09tbnz=09w3, #30, 250 <__d_rehash+0x88>
=09__READ_ONCE_SIZE;
     1ec:=09f9400023 =09ldr=09x3, [x1]
=09if (READ_ONCE(*p) & mask)
     1f0:=0937000283 =09tbnz=09w3, #0, 240 <__d_rehash+0x78>
     1f4:=09f9800031 =09prfm=09pstl1strm, [x1]
     1f8:=09c85ffc23 =09ldaxr=09x3, [x1]
     1fc:=09b2400064 =09orr=09x4, x3, #0x1
     200:=09c8067c24 =09stxr=09w6, x4, [x1]
     204:=0935ffffa6 =09cbnz=09w6, 1f8 <__d_rehash+0x30>
=09while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
     208:=09370001c3 =09tbnz=09w3, #0, 240 <__d_rehash+0x78>
=09=09((unsigned long)h->first & ~LIST_BL_LOCKMASK);
     20c:=09f86278a3 =09ldr=09x3, [x5, x2, lsl #3]
=09hlist_bl_lock(b);
=09hlist_bl_add_head_rcu(&entry->d_hash, b);
     210:=0991002004 =09add=09x4, x0, #0x8
     214:=09927ff863 =09and=09x3, x3, #0xfffffffffffffffe
=09struct hlist_bl_node *first;

=09/* don't need hlist_bl_first_rcu because we're under lock */
=09first =3D hlist_bl_first(h);

=09n->next =3D first;
     218:=09f9000403 =09str=09x3, [x0, #8]
=09if (first)
     21c:=09b4000043 =09cbz=09x3, 224 <__d_rehash+0x5c>
=09=09first->pprev =3D &n->next;
     220:=09f9000464 =09str=09x4, [x3, #8]
=09rcu_assign_pointer(h->first,
     224:=09b2400084 =09orr=09x4, x4, #0x1
=09n->pprev =3D &h->first;
     228:=09f9000801 =09str=09x1, [x0, #16]
=09rcu_assign_pointer(h->first,
     22c:=09c89ffc24 =09stlr=09x4, [x1]
     230:=09f86278a0 =09ldr=09x0, [x5, x2, lsl #3]
=09old &=3D ~BIT_MASK(nr);
     234:=09927ff800 =09and=09x0, x0, #0xfffffffffffffffe
     238:=09c89ffc20 =09stlr=09x0, [x1]
=09hlist_bl_unlock(b);
}
     23c:=09d65f03c0 =09ret
     240:=09d503203f =09yield
     244:=09f9400023 =09ldr=09x3, [x1]
=09=09} while (test_bit(bitnum, addr));
     248:=093707ffc3 =09tbnz=09w3, #0, 240 <__d_rehash+0x78>
     24c:=0917ffffe8 =09b=091ec <__d_rehash+0x24>
=09WARN_ON(entry->d_flags & DCACHE_NORCU);
     250:=09d4210000 =09brk=09#0x800
=09preempt_disable();
     254:=0917ffffe6 =09b=091ec <__d_rehash+0x24>

...

0000000000002d10 <__d_lookup_rcu>:
{
    2d10:=09a9b97bfd =09stp=09x29, x30, [sp, #-112]!
    2d14:=09aa0103e3 =09mov=09x3, x1
=09return dentry_hashtable + (hash >> d_hash_shift);
    2d18:=0990000004 =09adrp=09x4, 0 <find_submount>
=09=09=092d18: R_AARCH64_ADR_PREL_PG_HI21=09.data..read_mostly
{
    2d1c:=09910003fd =09mov=09x29, sp
    2d20:=09a90153f3 =09stp=09x19, x20, [sp, #16]
=09return dentry_hashtable + (hash >> d_hash_shift);
    2d24:=0991000081 =09add=09x1, x4, #0x0
=09=09=092d24: R_AARCH64_ADD_ABS_LO12_NC=09.data..read_mostly
{
    2d28:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    2d2c:=09a9046bf9 =09stp=09x25, x26, [sp, #64]
=09const unsigned char *str =3D name->name;
    2d30:=09a9406476 =09ldp=09x22, x25, [x3]
=09return dentry_hashtable + (hash >> d_hash_shift);
    2d34:=09b9400821 =09ldr=09w1, [x1, #8]
    2d38:=09f9400084 =09ldr=09x4, [x4]
=09=09=092d38: R_AARCH64_LDST64_ABS_LO12_NC=09.data..read_mostly
    2d3c:=091ac126c1 =09lsr=09w1, w22, w1
=09__READ_ONCE_SIZE;
    2d40:=09f8617893 =09ldr=09x19, [x4, x1, lsl #3]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2d44:=09f27ffa73 =09ands=09x19, x19, #0xfffffffffffffffe
    2d48:=0954000920 =09b.eq=092e6c <__d_lookup_rcu+0x15c>  // b.none
    2d4c:=09aa0003f5 =09mov=09x21, x0
=09=09=09if (dentry_cmp(dentry, str, hashlen_len(hashlen)) !=3D 0)
    2d50:=09d360feda =09lsr=09x26, x22, #32
    2d54:=09a90363f7 =09stp=09x23, x24, [sp, #48]
    2d58:=09aa0203f8 =09mov=09x24, x2
    2d5c:=09d3608ad7 =09ubfx=09x23, x22, #32, #3
    2d60:=09a90573fb =09stp=09x27, x28, [sp, #80]
    2d64:=092a1603fc =09mov=09w28, w22
=09mask =3D bytemask_from_count(tcount);
    2d68:=099280001b =09mov=09x27, #0xffffffffffffffff    =09// #-1
    2d6c:=0914000003 =09b=092d78 <__d_lookup_rcu+0x68>
    2d70:=09f9400273 =09ldr=09x19, [x19]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2d74:=09b4000793 =09cbz=09x19, 2e64 <__d_lookup_rcu+0x154>
    2d78:=09b85fc265 =09ldur=09w5, [x19, #-4]
=09smp_rmb();
    2d7c:=09d50339bf =09dmb=09ishld
=09=09if (dentry->d_parent !=3D parent)
    2d80:=09f9400a64 =09ldr=09x4, [x19, #16]
    2d84:=09d1002260 =09sub=09x0, x19, #0x8
    2d88:=09eb0402bf =09cmp=09x21, x4
    2d8c:=0954ffff21 =09b.ne=092d70 <__d_lookup_rcu+0x60>  // b.any
=09return ret & ~1;
    2d90:=09121f78b4 =09and=09w20, w5, #0xfffffffe
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2d94:=09aa0003e9 =09mov=09x9, x0
=09=09if (d_unhashed(dentry))
    2d98:=09f9400664 =09ldr=09x4, [x19, #8]
    2d9c:=09b4fffea4 =09cbz=09x4, 2d70 <__d_lookup_rcu+0x60>
=09=09if (unlikely(parent->d_flags & DCACHE_OP_COMPARE)) {
    2da0:=09b94002a4 =09ldr=09w4, [x21]
    2da4:=0937080404 =09tbnz=09w4, #1, 2e24 <__d_lookup_rcu+0x114>
=09=09=09if (dentry->d_name.hash_len !=3D hashlen)
    2da8:=09f9401000 =09ldr=09x0, [x0, #32]
    2dac:=09eb16001f =09cmp=09x0, x22
    2db0:=0954fffe01 =09b.ne=092d70 <__d_lookup_rcu+0x60>  // b.any
    2db4:=09f9401265 =09ldr=09x5, [x19, #32]
=09const unsigned char *cs =3D READ_ONCE(dentry->d_name.name);
    2db8:=092a1a03e6 =09mov=09w6, w26
    2dbc:=09cb050328 =09sub=09x8, x25, x5
    2dc0:=0914000006 =09b=092dd8 <__d_lookup_rcu+0xc8>
=09=09cs +=3D sizeof(unsigned long);
    2dc4:=09910020a5 =09add=09x5, x5, #0x8
=09=09if (unlikely(a !=3D b))
    2dc8:=09eb07001f =09cmp=09x0, x7
    2dcc:=0954fffd21 =09b.ne=092d70 <__d_lookup_rcu+0x60>  // b.any
=09=09if (!tcount)
    2dd0:=09710020c6 =09subs=09w6, w6, #0x8
    2dd4:=0954000160 =09b.eq=092e00 <__d_lookup_rcu+0xf0>  // b.none
=09=09cs +=3D sizeof(unsigned long);
    2dd8:=098b0800a4 =09add=09x4, x5, x8
=09=09if (tcount < sizeof(unsigned long))
    2ddc:=096b1700df =09cmp=09w6, w23
static inline unsigned long load_unaligned_zeropad(const void *addr)
{
=09unsigned long ret, offset;

=09/* Load word from unaligned pointer addr */
=09asm(
    2de0:=09f9400087 =09ldr=09x7, [x4]

static __no_kasan_or_inline
unsigned long read_word_at_a_time(const void *addr)
{
=09kasan_check_read(addr, 1);
=09return *(unsigned long *)addr;
    2de4:=09f94000a0 =09ldr=09x0, [x5]
    2de8:=0954fffee1 =09b.ne=092dc4 <__d_lookup_rcu+0xb4>  // b.any
=09mask =3D bytemask_from_count(tcount);
    2dec:=09531d72e1 =09lsl=09w1, w23, #3
=09return unlikely(!!((a ^ b) & mask));
    2df0:=09ca070000 =09eor=09x0, x0, x7
=09mask =3D bytemask_from_count(tcount);
    2df4:=099ac12361 =09lsl=09x1, x27, x1
=09=09=09if (dentry_cmp(dentry, str, hashlen_len(hashlen)) !=3D 0)
    2df8:=09ea21001f =09bics=09xzr, x0, x1
    2dfc:=0954fffba1 =09b.ne=092d70 <__d_lookup_rcu+0x60>  // b.any
=09=09*seqp =3D seq;
    2e00:=09b9000314 =09str=09w20, [x24]
}
    2e04:=09aa0903e0 =09mov=09x0, x9
    2e08:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    2e0c:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
=09=09return dentry;
    2e10:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
}
    2e14:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
=09=09return dentry;
    2e18:=09a94573fb =09ldp=09x27, x28, [sp, #80]
}
    2e1c:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2e20:=09d65f03c0 =09ret
=09=09=09if (dentry->d_name.hash !=3D hashlen_hash(hashlen))
    2e24:=09b9402001 =09ldr=09w1, [x0, #32]
    2e28:=096b01039f =09cmp=09w28, w1
    2e2c:=0954fffa21 =09b.ne=092d70 <__d_lookup_rcu+0x60>  // b.any
=09=09=09tlen =3D dentry->d_name.len;
    2e30:=09b9402401 =09ldr=09w1, [x0, #36]
=09=09=09tname =3D dentry->d_name.name;
    2e34:=09f9401402 =09ldr=09x2, [x0, #40]
=09smp_rmb();
    2e38:=09d50339bf =09dmb=09ishld
=09return unlikely(s->sequence !=3D start);
    2e3c:=09b85fc264 =09ldur=09w4, [x19, #-4]
=09=09=09if (read_seqcount_retry(&dentry->d_seq, seq)) {
    2e40:=096b04029f =09cmp=09w20, w4
    2e44:=0954000221 =09b.ne=092e88 <__d_lookup_rcu+0x178>  // b.any
=09=09=09if (parent->d_op->d_compare(dentry,
    2e48:=09f94032a4 =09ldr=09x4, [x21, #96]
    2e4c:=09a90627e3 =09stp=09x3, x9, [sp, #96]
    2e50:=09f9400c84 =09ldr=09x4, [x4, #24]
    2e54:=09d63f0080 =09blr=09x4
    2e58:=09a94627e3 =09ldp=09x3, x9, [sp, #96]
    2e5c:=0934fffd20 =09cbz=09w0, 2e00 <__d_lookup_rcu+0xf0>
    2e60:=0917ffffc4 =09b=092d70 <__d_lookup_rcu+0x60>
    2e64:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
    2e68:=09a94573fb =09ldp=09x27, x28, [sp, #80]
=09return NULL;
    2e6c:=09d2800009 =09mov=09x9, #0x0                   =09// #0
}
    2e70:=09aa0903e0 =09mov=09x0, x9
    2e74:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    2e78:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    2e7c:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
    2e80:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2e84:=09d65f03c0 =09ret
    2e88:=09d503203f =09yield
=09__READ_ONCE_SIZE;
    2e8c:=09b85fc265 =09ldur=09w5, [x19, #-4]
=09smp_rmb();
    2e90:=09d50339bf =09dmb=09ishld
=09=09if (dentry->d_parent !=3D parent)
    2e94:=09f9400c01 =09ldr=09x1, [x0, #24]
=09return ret & ~1;
    2e98:=09121f78b4 =09and=09w20, w5, #0xfffffffe
    2e9c:=09eb15003f =09cmp=09x1, x21
    2ea0:=0954fff681 =09b.ne=092d70 <__d_lookup_rcu+0x60>  // b.any
    2ea4:=0917ffffbd =09b=092d98 <__d_lookup_rcu+0x88>

0000000000002ea8 <__d_lookup>:
{
    2ea8:=09a9b97bfd =09stp=09x29, x30, [sp, #-112]!
=09return dentry_hashtable + (hash >> d_hash_shift);
    2eac:=0990000002 =09adrp=09x2, 0 <find_submount>
=09=09=092eac: R_AARCH64_ADR_PREL_PG_HI21=09.data..read_mostly
    2eb0:=0991000043 =09add=09x3, x2, #0x0
=09=09=092eb0: R_AARCH64_ADD_ABS_LO12_NC=09.data..read_mostly
{
    2eb4:=09910003fd =09mov=09x29, sp
    2eb8:=09a90573fb =09stp=09x27, x28, [sp, #80]
    2ebc:=09aa0103fc =09mov=09x28, x1
    2ec0:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    2ec4:=09a90363f7 =09stp=09x23, x24, [sp, #48]
    2ec8:=09a9046bf9 =09stp=09x25, x26, [sp, #64]
    2ecc:=09aa0003fa =09mov=09x26, x0
=09unsigned int hash =3D name->hash;
    2ed0:=09b9400397 =09ldr=09w23, [x28]
=09return dentry_hashtable + (hash >> d_hash_shift);
    2ed4:=09b9400860 =09ldr=09w0, [x3, #8]
    2ed8:=09f9400041 =09ldr=09x1, [x2]
=09=09=092ed8: R_AARCH64_LDST64_ABS_LO12_NC=09.data..read_mostly
    2edc:=091ac026e0 =09lsr=09w0, w23, w0
    2ee0:=09f8607833 =09ldr=09x19, [x1, x0, lsl #3]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2ee4:=09f27ffa73 =09ands=09x19, x19, #0xfffffffffffffffe
    2ee8:=0954000320 =09b.eq=092f4c <__d_lookup+0xa4>  // b.none
=09smp_store_release(&lock->locked, 0);
    2eec:=095280001b =09mov=09w27, #0x0                   =09// #0
=09mask =3D bytemask_from_count(tcount);
    2ef0:=0992800018 =09mov=09x24, #0xffffffffffffffff    =09// #-1
    2ef4:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    2ef8:=09d2800016 =09mov=09x22, #0x0                   =09// #0
    2efc:=0952800035 =09mov=09w21, #0x1                   =09// #1
=09=09if (dentry->d_name.hash !=3D hash)
    2f00:=09b9401a62 =09ldr=09w2, [x19, #24]
    2f04:=09d1002274 =09sub=09x20, x19, #0x8
    2f08:=096b17005f =09cmp=09w2, w23
    2f0c:=09540001a1 =09b.ne=092f40 <__d_lookup+0x98>  // b.any
    2f10:=0991014279 =09add=09x25, x19, #0x50
    2f14:=09f9800331 =09prfm=09pstl1strm, [x25]
    2f18:=09885fff21 =09ldaxr=09w1, [x25]
    2f1c:=094a160020 =09eor=09w0, w1, w22
    2f20:=0935000060 =09cbnz=09w0, 2f2c <__d_lookup+0x84>
    2f24:=0988007f35 =09stxr=09w0, w21, [x25]
    2f28:=0935ffff80 =09cbnz=09w0, 2f18 <__d_lookup+0x70>
    2f2c:=0935000521 =09cbnz=09w1, 2fd0 <__d_lookup+0x128>
=09=09if (dentry->d_parent !=3D parent)
    2f30:=09f9400e82 =09ldr=09x2, [x20, #24]
    2f34:=09eb1a005f =09cmp=09x2, x26
    2f38:=09540001a0 =09b.eq=092f6c <__d_lookup+0xc4>  // b.none
    2f3c:=09089fff3b =09stlrb=09w27, [x25]
    2f40:=09f9400273 =09ldr=09x19, [x19]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2f44:=09b5fffdf3 =09cbnz=09x19, 2f00 <__d_lookup+0x58>
    2f48:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
=09struct dentry *found =3D NULL;
    2f4c:=09d2800008 =09mov=09x8, #0x0                   =09// #0
}
    2f50:=09aa0803e0 =09mov=09x0, x8
    2f54:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    2f58:=09a94363f7 =09ldp=09x23, x24, [sp, #48]
    2f5c:=09a9446bf9 =09ldp=09x25, x26, [sp, #64]
    2f60:=09a94573fb =09ldp=09x27, x28, [sp, #80]
    2f64:=09a8c77bfd =09ldp=09x29, x30, [sp], #112
    2f68:=09d65f03c0 =09ret
=09=09if (d_unhashed(dentry))
    2f6c:=09f9400660 =09ldr=09x0, [x19, #8]
    2f70:=09b4fffe60 =09cbz=09x0, 2f3c <__d_lookup+0x94>
=09if (likely(!(parent->d_flags & DCACHE_OP_COMPARE))) {
    2f74:=09b9400340 =09ldr=09w0, [x26]
=09hlist_bl_for_each_entry_rcu(dentry, node, b, d_hash) {
    2f78:=09aa1403e8 =09mov=09x8, x20
=09if (likely(!(parent->d_flags & DCACHE_OP_COMPARE))) {
    2f7c:=09b9402681 =09ldr=09w1, [x20, #36]
    2f80:=09370802e0 =09tbnz=09w0, #1, 2fdc <__d_lookup+0x134>
=09=09if (dentry->d_name.len !=3D name->len)
    2f84:=09b9400784 =09ldr=09w4, [x28, #4]
    2f88:=096b04003f =09cmp=09w1, w4
    2f8c:=0954fffd81 =09b.ne=092f3c <__d_lookup+0x94>  // b.any
=09=09return dentry_cmp(dentry, name->name, name->len) =3D=3D 0;
    2f90:=09f9400787 =09ldr=09x7, [x28, #8]
static inline int dentry_string_cmp(const unsigned char *cs, const unsigned=20=

char *ct, unsigned tcount)
    2f94:=0912000881 =09and=09w1, w4, #0x7
    2f98:=09f9401265 =09ldr=09x5, [x19, #32]
    2f9c:=09cb0500e7 =09sub=09x7, x7, x5
    2fa0:=0914000003 =09b=092fac <__d_lookup+0x104>
=09=09if (!tcount)
    2fa4:=0971002084 =09subs=09w4, w4, #0x8
    2fa8:=0954000300 =09b.eq=093008 <__d_lookup+0x160>  // b.none
=09=09cs +=3D sizeof(unsigned long);
    2fac:=098b0700a2 =09add=09x2, x5, x7
=09=09if (tcount < sizeof(unsigned long))
    2fb0:=096b04003f =09cmp=09w1, w4
    2fb4:=09f9400046 =09ldr=09x6, [x2]
=09return *(unsigned long *)addr;
    2fb8:=09f94000a0 =09ldr=09x0, [x5]
    2fbc:=0954000340 =09b.eq=093024 <__d_lookup+0x17c>  // b.none
=09=09cs +=3D sizeof(unsigned long);
    2fc0:=09910020a5 =09add=09x5, x5, #0x8
=09=09if (unlikely(a !=3D b))
    2fc4:=09eb06001f =09cmp=09x0, x6
    2fc8:=0954fffee0 =09b.eq=092fa4 <__d_lookup+0xfc>  // b.none
    2fcc:=0917ffffdc =09b=092f3c <__d_lookup+0x94>
=09queued_spin_lock_slowpath(lock, val);
    2fd0:=09aa1903e0 =09mov=09x0, x25
    2fd4:=0994000000 =09bl=090 <queued_spin_lock_slowpath>
=09=09=092fd4: R_AARCH64_CALL26=09queued_spin_lock_slowpath
    2fd8:=0917ffffd6 =09b=092f30 <__d_lookup+0x88>
=09return parent->d_op->d_compare(dentry,
    2fdc:=09f9403340 =09ldr=09x0, [x26, #96]
    2fe0:=09aa1c03e3 =09mov=09x3, x28
    2fe4:=09f9401682 =09ldr=09x2, [x20, #40]
    2fe8:=09f90037f4 =09str=09x20, [sp, #104]
    2fec:=09f9400c04 =09ldr=09x4, [x0, #24]
    2ff0:=09aa1403e0 =09mov=09x0, x20
    2ff4:=09d63f0080 =09blr=09x4
=09=09=09=09       name) =3D=3D 0;
    2ff8:=097100001f =09cmp=09w0, #0x0
    2ffc:=091a9f17e0 =09cset=09w0, eq  // eq =3D none
    3000:=09f94037e8 =09ldr=09x8, [sp, #104]
=09=09if (!d_same_name(dentry, parent, name))
    3004:=0934fff9c0 =09cbz=09w0, 2f3c <__d_lookup+0x94>
=09=09dentry->d_lockref.count++;
    3008:=09b9405e80 =09ldr=09w0, [x20, #92]
=09smp_store_release(&lock->locked, 0);
    300c:=0952800001 =09mov=09w1, #0x0                   =09// #0
    3010:=0911000400 =09add=09w0, w0, #0x1
    3014:=09b9005e80 =09str=09w0, [x20, #92]
    3018:=09089fff21 =09stlrb=09w1, [x25]
}
    301c:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    3020:=0917ffffcc =09b=092f50 <__d_lookup+0xa8>
=09mask =3D bytemask_from_count(tcount);
    3024:=09531d7021 =09lsl=09w1, w1, #3
=09return unlikely(!!((a ^ b) & mask));
    3028:=09ca060000 =09eor=09x0, x0, x6
=09mask =3D bytemask_from_count(tcount);
    302c:=099ac12301 =09lsl=09x1, x24, x1
    3030:=09ea21001f =09bics=09xzr, x0, x1
    3034:=091a9f17e0 =09cset=09w0, eq  // eq =3D none
=09=09if (!d_same_name(dentry, parent, name))
    3038:=0934fff820 =09cbz=09w0, 2f3c <__d_lookup+0x94>
    303c:=0917fffff3 =09b=093008 <__d_lookup+0x160>

0000000000003040 <d_lookup>:
{
    3040:=09a9bd7bfd =09stp=09x29, x30, [sp, #-48]!
    3044:=09910003fd =09mov=09x29, sp
    3048:=09a90153f3 =09stp=09x19, x20, [sp, #16]
    304c:=0990000013 =09adrp=09x19, 0 <find_submount>
=09=09=09304c: R_AARCH64_ADR_PREL_PG_HI21=09.data..cacheline_aligned
    3050:=09aa0103f4 =09mov=09x20, x1
    3054:=0991000273 =09add=09x19, x19, #0x0
=09=09=093054: R_AARCH64_ADD_ABS_LO12_NC=09.data..cacheline_aligned
    3058:=09a9025bf5 =09stp=09x21, x22, [sp, #32]
    305c:=09aa0003f5 =09mov=09x21, x0
=09__READ_ONCE_SIZE;
    3060:=09b9400276 =09ldr=09w22, [x19]
=09if (unlikely(ret & 1)) {
    3064:=09370001d6 =09tbnz=09w22, #0, 309c <d_lookup+0x5c>
=09smp_rmb();
    3068:=09d50339bf =09dmb=09ishld
=09=09dentry =3D __d_lookup(parent, name);
    306c:=09aa1403e1 =09mov=09x1, x20
    3070:=09aa1503e0 =09mov=09x0, x21
    3074:=0994000000 =09bl=092ea8 <__d_lookup>
=09=09=093074: R_AARCH64_CALL26=09__d_lookup
=09=09if (dentry)
    3078:=09b50000a0 =09cbnz=09x0, 308c <d_lookup+0x4c>
=09smp_rmb();
    307c:=09d50339bf =09dmb=09ishld
=09} while (read_seqretry(&rename_lock, seq));
    3080:=09b9400261 =09ldr=09w1, [x19]
    3084:=096b16003f =09cmp=09w1, w22
    3088:=0954fffec1 =09b.ne=093060 <d_lookup+0x20>  // b.any
}
    308c:=09a94153f3 =09ldp=09x19, x20, [sp, #16]
    3090:=09a9425bf5 =09ldp=09x21, x22, [sp, #32]
    3094:=09a8c37bfd =09ldp=09x29, x30, [sp], #48
    3098:=09d65f03c0 =09ret
    309c:=09d503203f =09yield
    30a0:=0917fffff0 =09b=093060 <d_lookup+0x20>
    30a4:=09d503201f =09nop

