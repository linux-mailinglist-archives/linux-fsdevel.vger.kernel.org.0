Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C152674B997
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGGWl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 18:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjGGWlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:41:25 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C03BA2125;
        Fri,  7 Jul 2023 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688769679;
        bh=66EhCKrke0Iq+SSG8cBd23leIIdYLwkKIKEa7Istidg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3aiF2y+Yl6hlfV/jPFar6UUEqQgWGw/iRe+ArZwJ6vtaFSUKwCxBDdwaFl6kLbyl
         3mNX4/6CkWHZavdr5g/znKItp0AzTuedDP7ttPemunAzy9+Uv+f12r+nRNVAXTCLZN
         kKqQgb0m1pbMq8OG6nUQdSOw/Hx/vjxg/oVckApRo3+Tkr9XacGirc9T5SyDlXI6cF
         uYTiYRzTDeZ9juNfr5+sntqzCod9Mtx3oWzVoxmhJ6rGaex7sI99sahVBR5oJeWiM2
         Id05lpKHrsnHffzfrkiTI2v3dlubdzmuATLOmviXlxgVugSgG4+lOaOS0qo9d+zPPR
         2dGaccIx5ooSg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 9B0DA207E;
        Sat,  8 Jul 2023 00:41:19 +0200 (CEST)
Date:   Sat, 8 Jul 2023 00:41:18 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read
 side?)
Message-ID: <zu7gnignulf7qqnoblpzjbu6cx5xtk2qum2uqr7q52ahxjbtdx@4ergovgpfuxt>
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
 <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner>
 <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <20230707-konsens-ruckartig-211a4fb24e27@brauner>
 <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwikc4e2rdpqmnxf"
Content-Disposition: inline
In-Reply-To: <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--rwikc4e2rdpqmnxf
Content-Type: multipart/mixed; boundary="3mjbekeuyt4r3h3w"
Content-Disposition: inline


--3mjbekeuyt4r3h3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 12:10:36PM -0700, Linus Torvalds wrote:
> On Fri, 7 Jul 2023 at 10:21, Christian Brauner <brauner@kernel.org> wrote:
> > Forgot to say, fwiw, I've been running this through the LTP splice,
> > pipe, and ipc tests without issues. A hanging reader can be signaled
> > away cleanly with this.
> NOTE! NOTE! NOTE! Once more, this "feels right to me", and I'd argue
> that the basic approach is fairly straightfoward. The patch is also
> not horrendous. It all makes a fair amount of sense. BUT! I haven't
> tested this, and like the previous patch, I really would want people
> to think about this a lot.
>=20
> Comments? Jens?
I applied the patch upthread + this diff to 4f6b6c2b2f86b7878a770736bf478d8=
a263ff0bc;
during test setup I got a null deref (building defconfig minus graphics).
Reproducible, full BUG dump attached; trace of
[  149.878931]  <TASK>
[  149.879533]  ? __die+0x1e/0x60
[  149.880309]  ? page_fault_oops+0x17c/0x470
[  149.881313]  ? search_module_extables+0x14/0x50
[  149.882422]  ? exc_page_fault+0x67/0x150
[  149.883397]  ? asm_exc_page_fault+0x26/0x30
[  149.884426]  ? __pfx_pipe_to_null+0x10/0x10
[  149.885451]  ? splice_from_pipe_next+0x129/0x150
[  149.886580]  __splice_from_pipe+0x39/0x1c0
[  149.887594]  ? __pfx_pipe_to_null+0x10/0x10
[  149.888615]  ? __pfx_pipe_to_null+0x10/0x10
[  149.889635]  splice_from_pipe+0x5c/0x90
[  149.890579]  do_splice+0x35c/0x840
[  149.891407]  __do_splice+0x1eb/0x210
[  149.892176]  __x64_sys_splice+0xad/0x120
[  149.893019]  do_syscall_64+0x3e/0x90
[  149.893798]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

$ scripts/faddr2line vmlinux splice_from_pipe_next+0x129
splice_from_pipe_next+0x129/0x150:
pipe_buf_release at include/linux/pipe_fs_i.h:221
(inlined by) eat_empty_buffer at fs/splice.c:594
(inlined by) splice_from_pipe_next at fs/splice.c:640

I gamed this down to=20
  echo c | grep c >/dev/null
where grep is
  ii  grep           3.8-5        amd64        GNU grep, egrep and fgrep
and strace of the same invocation (on the host) ends with
  newfstatat(1, "", {st_mode=3DS_IFCHR|0666, st_rdev=3Dmakedev(0x1, 0x3), .=
=2E.}, AT_EMPTY_PATH) =3D 0
  newfstatat(AT_FDCWD, "/dev/null", {st_mode=3DS_IFCHR|0666, st_rdev=3Dmake=
dev(0x1, 0x3), ...}, 0) =3D 0
  newfstatat(0, "", {st_mode=3DS_IFIFO|0600, st_size=3D0, ...}, AT_EMPTY_PA=
TH) =3D 0
  lseek(0, 0, SEEK_CUR)                   =3D -1 ESPIPE (Illegal seek)
  read(0, "c\n", 98304)                   =3D 2
  splice(0, NULL, 1, NULL, 98304, SPLICE_F_MOVE) =3D 0
  close(1)                                =3D 0
  close(2)                                =3D 0
  exit_group(0)                           =3D ?
  +++ exited with 0 +++

And can also reproduce it with
  echo | { read -r _; exec ./wr; } > /dev/null
(where ./wr is "while (splice(0, 0, 1, 0, 128 * 1024 * 1024, 0) > 0) {}").
However:
  echo | ./wr > /dev/null
does NOT crash.


Besides that, this doesn't solve the original issue, inasmuch as
  ./v > fifo &
  head fifo &
  echo zupa > fifo
(where ./v splices from an empty pty to stdout; v.c attached)
echo still sleeps until ./v dies, though it also succumbs to ^C now.

"OTOH, on 4f6b6c2b2f86b7878a770736bf478d8a263ff0bc,
"timeout 10 ./v > fifo &" (then lines 2 and 3 as above) does
  kill ./v -> unblock echo -> head copies "zupa",
i.e. life resumes as normal after the splicer went away.

With the patches, echo zupa is stuck forever (until you signal it)!
This is kinda worse.

--3mjbekeuyt4r3h3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=BUG

[  149.843966] BUG: kernel NULL pointer dereference, address: 0000000000000008
[  149.845820] #PF: supervisor read access in kernel mode
[  149.847190] #PF: error_code(0x0000) - not-present page
[  149.848540] PGD 0 P4D 0
[  149.849231] Oops: 0000 [#1] PREEMPT SMP PTI
[  149.850345] CPU: 0 PID: 230 Comm: grep Not tainted 6.4.0-12317-gabf530ed3e36-dirty #3
[  149.852411] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  149.854900] RIP: 0010:splice_from_pipe_next+0x129/0x150
[  149.856328] Code: ff c6 45 38 00 eb af 5b b8 00 fe ff ff 5d 41 5c 41 5d c3 cc cc cc cc 48 8b 46 10 41 83 c5 01 48 89 df 48 c7 46 10 00 00 00 00 <48> 8b 40 08 e8 ce a5 9a
[  149.861118] RSP: 0018:ffffb2ed40347d70 EFLAGS: 00010202
[  149.862488] RAX: 0000000000000000 RBX: ffff8c06c1d9a0c0 RCX: 0000000000000000
[  149.864357] RDX: 0000000000000005 RSI: ffff8c06c8c98028 RDI: ffff8c06c1d9a0c0
[  149.866217] RBP: ffffb2ed40347de0 R08: 0000000000000001 R09: ffffffffaa428db0
[  149.868088] R10: 0000000000018000 R11: 0000000000000000 R12: ffff8c06c2625580
[  149.869950] R13: 0000000000000002 R14: ffff8c06c1d9a0c0 R15: ffffb2ed40347de0
[  149.871828] FS:  00007fa5a6b3e740(0000) GS:ffff8c06dd800000(0000) knlGS:0000000000000000
[  149.873937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.875459] CR2: 0000000000000008 CR3: 000000000269a000 CR4: 00000000000006f0
[  149.877327] Call Trace:
[  149.878931]  <TASK>
[  149.879533]  ? __die+0x1e/0x60
[  149.880309]  ? page_fault_oops+0x17c/0x470
[  149.881313]  ? search_module_extables+0x14/0x50
[  149.882422]  ? exc_page_fault+0x67/0x150
[  149.883397]  ? asm_exc_page_fault+0x26/0x30
[  149.884426]  ? __pfx_pipe_to_null+0x10/0x10
[  149.885451]  ? splice_from_pipe_next+0x129/0x150
[  149.886580]  __splice_from_pipe+0x39/0x1c0
[  149.887594]  ? __pfx_pipe_to_null+0x10/0x10
[  149.888615]  ? __pfx_pipe_to_null+0x10/0x10
[  149.889635]  splice_from_pipe+0x5c/0x90
[  149.890579]  do_splice+0x35c/0x840
[  149.891407]  __do_splice+0x1eb/0x210
[  149.892176]  __x64_sys_splice+0xad/0x120
[  149.893019]  do_syscall_64+0x3e/0x90
[  149.893798]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  149.894881] RIP: 0033:0x7fa5a6c49dd3
[  149.895682] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b9 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 11 18 0d 00 00 49 89 ca 74 14 b8 13 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 74
[  149.899538] RSP: 002b:00007ffc83d77768 EFLAGS: 00000202 ORIG_RAX: 0000000000000113
[  149.901116] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa5a6c49dd3
[  149.902602] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
[  149.904048] RBP: 0000564d8aaeb000 R08: 0000000000018000 R09: 0000000000000001
[  149.905439] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000a
[  149.906832] R13: 0000564d8aaeb010 R14: 0000564d8aaeb000 R15: 0000000000000000
[  149.908239]  </TASK>
[  149.908692] Modules linked in:
[  149.909326] CR2: 0000000000000008
[  149.910050] ---[ end trace 0000000000000000 ]---
[  149.910986] RIP: 0010:splice_from_pipe_next+0x129/0x150
[  149.912063] Code: ff c6 45 38 00 eb af 5b b8 00 fe ff ff 5d 41 5c 41 5d c3 cc cc cc cc 48 8b 46 10 41 83 c5 01 48 89 df 48 c7 46 10 00 00 00 00 <48> 8b 40 08 e8 ce a5 9a
[  149.915639] RSP: 0018:ffffb2ed40347d70 EFLAGS: 00010202
[  149.916589] RAX: 0000000000000000 RBX: ffff8c06c1d9a0c0 RCX: 0000000000000000
[  149.917877] RDX: 0000000000000005 RSI: ffff8c06c8c98028 RDI: ffff8c06c1d9a0c0
[  149.919172] RBP: ffffb2ed40347de0 R08: 0000000000000001 R09: ffffffffaa428db0
[  149.920457] R10: 0000000000018000 R11: 0000000000000000 R12: ffff8c06c2625580
[  149.921737] R13: 0000000000000002 R14: ffff8c06c1d9a0c0 R15: ffffb2ed40347de0
[  149.923021] FS:  00007fa5a6b3e740(0000) GS:ffff8c06dd800000(0000) knlGS:0000000000000000
[  149.924481] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.925529] CR2: 0000000000000008 CR3: 000000000269a000 CR4: 00000000000006f0

--3mjbekeuyt4r3h3w
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="v.c"



#define _GNU_SOURCE
#include <fcntl.h>
#include <stdlib.h>
       #include <sys/sendfile.h>

int main() {
  int pt = posix_openpt(O_RDWR);
  grantpt(pt);
  unlockpt(pt);
  int cl = open(ptsname(pt), O_RDONLY);
  for(;;)
    splice(cl, 0, 1, 0, 128 * 1024 * 1024, 0);
//  	sendfile(1, 0, 0, 128 * 1024 * 1024);
}


--3mjbekeuyt4r3h3w--

--rwikc4e2rdpqmnxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSolIsACgkQvP0LAY0m
WPFR2xAAutKJ8LrQOMyNIQvL/bVuVfel3GVUngaZO3QgZpJ8oriEHS4fVgSNwZA2
+HE3JUrJWJoJs/36pJFGOSZWl4t51DWlKdgcpOK6I8qmmjxv8prVZLO7GIwybmLW
Wn6Tr0tiWYnz1C1qs1ub6kENccWnkxMg0v8zhzoGz2lcGXYGBWqdlOV+hdO4Mmte
pMs8XIrValG8/u3sIvTToniKNaq9yz8w+ZuxkFPvIYxr9sWSF1O+D/4IGFWxHWbk
2LkGc0Q/U7nVA/Zhbnbh3LEao63+tlUcDIiaXcAuMKa9cMhILrJ1XB6hcKQWNd40
cJ+sjwRfCGHDO7FhRULETd0Du45faun0nlEdgCDVIcMwfimkHzfcJLUev+k1E5QE
fC7QzwGHE9L1megok4N7e7oxQhHtE7zPFim+6/uYsT8TeGCIz34ujKAKfQyB4yj9
n7c3xe3V8rH9Gse91g9jcm4PWlp7cNIkhVHsl+lQj5aLrTsQUm+wyq/hfkCrBnt7
f2b/85afkFOVtb6O9GZcESz+FFN6A6bk/jCLYW3xBqiQxSHGCf4Vm6TqemFVWa2G
FQZNua3R8alqRwfGFMCG4yGMrVQOvWozD41UTsgbXxp8hCYrRB6HGBAw7mCzmhp9
zlUZRgfexQUSUF8u0Em+5I8p+9oh1/dfxbLQozGdJ/1GSfGF4aU=
=7vhL
-----END PGP SIGNATURE-----

--rwikc4e2rdpqmnxf--
