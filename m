Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C110B74BA8C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 02:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjGHAaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 20:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGHAaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:30:23 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8790C1991;
        Fri,  7 Jul 2023 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688776218;
        bh=+VpZJR3o46hwfqWgWb4IXi4Xxjl642iOcNwJEJI/tk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsFdKSEZwh+Q5vO2SgV+GdK9Ks15rH4IgBVVjTLTiGvv8+lWbKg9nwEg/rl391FGA
         Voq4ZC5cP8AlUQiFo/zIjDsF1pTrHBPqrz/OZR9JC7kPXKkCqB352IqYNRxE+8/qTB
         E9iajFwqjp69Nu8YbKPO8mUKHA5v9PrEKYAVN2eGdQVEptINPcvUNvl0qDKNDFfYeS
         7KfNcx8sbJ943PXHDI+a0AfQI1F9x75j6DEJ8it5Ms37yzs9PXRk95dBJbxO+YA0yZ
         D9jn/4GJ43ivxlMjfjcHzXDdmVKAjZBZJnKAnhsmarGOLZWSQaFZOQOB5H7os8XXrG
         QPtc5Y4m/V/nA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 29C2F20F4;
        Sat,  8 Jul 2023 02:30:18 +0200 (CEST)
Date:   Sat, 8 Jul 2023 02:30:16 +0200
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
Message-ID: <ltbgocygx4unco6ssoiszwsgjmztyuxkqja3omvvyqvpii6dac@5abamn33galn>
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
 <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner>
 <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <20230707-konsens-ruckartig-211a4fb24e27@brauner>
 <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
 <zu7gnignulf7qqnoblpzjbu6cx5xtk2qum2uqr7q52ahxjbtdx@4ergovgpfuxt>
 <CAHk-=wjEC_Rh8+-rtEi8C45upO-Ffw=M_i1211qS_3AvWZCbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xd6fvopdq4tido3u"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEC_Rh8+-rtEi8C45upO-Ffw=M_i1211qS_3AvWZCbOg@mail.gmail.com>
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


--xd6fvopdq4tido3u
Content-Type: multipart/mixed; boundary="jidelvqglewikzxp"
Content-Disposition: inline


--jidelvqglewikzxp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2023 at 03:57:40PM -0700, Linus Torvalds wrote:
> On Fri, 7 Jul 2023 at 15:41, Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > (inlined by) eat_empty_buffer at fs/splice.c:594
> Ahh, eat_empty_buffer() ends up releasing the buffer without waiting for =
it.
>=20
> And the reason for that is actually somewhat interesting: we do have that
>=20
>         while (!pipe_readable(pipe)) {
>              ..
>=20
> above it, but the logic for this all is that pipes with pipe buffers
> are by *default* considered readable until they try to actually
> confirm the buffer, and at that point they might say "oh, I have to
> return -EAGAIN and set 'not_ready'".
>=20
> And that splice_from_pipe_next() doesn't do that.
>=20
> End result: it will happily free that pipe buffer that is still in the
> process of being filled.
>=20
> The good news is that I think the fix is probably trivial. Something
> like the attached?
>=20
> Again - NOT TESTED
Same reproducer, backtrace attached:
$ scripts/faddr2line vmlinux splice_from_pipe_next+0x6e
splice_from_pipe_next+0x6e/0x180:
pipe_buf_confirm at include/linux/pipe_fs_i.h:233
(inlined by) eat_empty_buffer at fs/splice.c:597
(inlined by) splice_from_pipe_next at fs/splice.c:647

Looks like the same place.

> > Besides that, this doesn't solve the original issue, inasmuch as
> >   ./v > fifo &
> >   head fifo &
> >   echo zupa > fifo
> > (where ./v splices from an empty pty to stdout; v.c attached)
> > echo still sleeps until ./v dies, though it also succumbs to ^C now.
> Yeah, I concentrated on just making everything interruptible,
>=20
> But the fact that the echo has to wait for the previous write to
> finish is kind of fundamental. We can't just magically do writes out
> of order. 'v' is busy writing to the fifo, we can't let some other
> write just come in.
(It's no longer busy writing to it when it gets killed by timeout in my
 second example, but echo still doesn't wake up.)

> (We *could* make the splice in ./v not fill the whole pipe buffer, and
> allow some other writes to fill in buffers afterwards, but at _some_
> point you'll hit the "pipe buffers are full and busy, can't add any
> more without waiting for them to empty").
You are, but, well, that's also the case when the pipe is full.
As it stands, the pipe is /empty/ and yet /no-one can write to it/.
This is the crux of the issue at hand.

(Coincidentally, you're describing what looks quite similar to pt 1.
 from <naljsvzzemr6pjiwwcdpdsdh5vtycdr6fmi2fk2dlr4nn4kq6o@ycanbgxhslti>.)

I think we got away with it for so long because most files behave
like regular files/blockdevs and the read is always guaranteed to
complete ~instantly, but splice is, fundamentally, /not/ writing
the whole time because it's not /reading/ the whole time when it's
reading an empty socket/a chardev/whatever.

Or, rather: splice() from a non-seekable (non-mmap()pable?)
fundamentally doesn't really make much sense, because you're not
gluing a bit of the pro-verbial page cache (forgive me my term
abuse here, you see what I'm getting at tho) to the end of the pipe,
you're just telling the kernel to run a read()/write() loop for you.

sendfile() works around this by reading and then separately writing
to its special buffer (in the form of an anonymous process-local pipe).
splice() just raw-dogs the read with the write lock held,
but just doesn't check if it can do it.

That's how it's, honestly, shaking out to me: someone just forgot
a check the first time they wrote it.
Because the precondition for "does reading directly into the pipe
buffer make sense" is "is it directly equivalent to read(f)/write(p)",
and that holds only for seekables.

/Maybe/ for, like, sockets if there's already data, or as a special
case similar to pipe->pipe. But then for sockets you're already
using sendfile(), so?

To that end, I'm including a patch based on
  4f6b6c2b2f86b7878a770736bf478d8a263ff0bc
that does just that: EINVAL.

Maybe if you're worried about breaking compatibility
(which idk if it's an issue since splice and sendfile
 are temperamental w.r.t. what they take anyway across versions;
 you need a read()/write() fallback anyway)
that case could become sendfile-like by first reading into a buffer
once then pipe->pipe splicing out of it separately.
Though, even the usual sendfile read/write loop only works on seekables.

> One thing we could possibly do is to say that we just don't accept any
> new writes if there are old busy splices in process. So we could make
> new writes return -EBUSY or something, I guess.
Same logic as above applies + no-one's really expecting EBUSY +
what /would/ you do about EBUSY in this case?
-- >8 --
=46rom 552d93bee8e1b8333ce84ed0ca8490f6712c5b8b Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Ahelenia=3D20Ziemia=3DC5=3D84ska?=3D
 <nabijaczleweli@nabijaczleweli.xyz>
Date: Sat, 8 Jul 2023 01:47:59 +0200
Subject: [PATCH] splice: file->pipe: -EINVAL if file non-seekable
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Both the logical semantic of "tie a page from the page cache to the pipe"
and the implemented semantic of "lock the pipe, then read into it"
(thus holding the write lock for as as long as the read is outstanding)
only make sense if the read is guaranteed to complete instantly.

This has been a long-standing omission and, when the read doesn't
immediately complete (because it's a tty, socket, &c.), the write lock
=E2=80=92 which for pipes is a pipe-global mutex =E2=80=92 is held until,
thus excluding all mutual users of the pipe, until it does.

Refuse it. Use read()/write() in userspace instead of getting the kernel
to do it for you, badly, when there's no point to doing so.

Link: https://lore.kernel.org/linux-fsdevel/CAHk-=3DwjEC_Rh8+-rtEi8C45upO-F=
fw=3DM_i1211qS_3AvWZCbOg@mail.gmail.com/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 fs/splice.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 004eb1c4ce31..14cf3cea1091 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1309,6 +1309,8 @@ long do_splice(struct file *in, loff_t *off_in, struc=
t file *out,
 	if (opipe) {
 		if (off_out)
 			return -ESPIPE;
+		if (!(in->f_mode & FMODE_LSEEK))
+			return -EINVAL;
 		if (off_in) {
 			if (!(in->f_mode & FMODE_PREAD))
 				return -EINVAL;
--=20
2.39.2


--jidelvqglewikzxp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=BUG

sh-5.2# echo a | grep a > /dev/null
[  137.724183] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  137.726038] #PF: supervisor read access in kernel mode
[  137.727408] #PF: error_code(0x0000) - not-present page
[  137.728757] PGD 0 P4D 0
[  137.729454] Oops: 0000 [#1] PREEMPT SMP PTI
[  137.730574] CPU: 1 PID: 227 Comm: grep Not tainted 6.4.0-12317-g1b28a3c9606a-dirty #1
[  137.732638] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  137.735124] RIP: 0010:splice_from_pipe_next+0x6e/0x180
[  137.736514] Code: 80 fe 01 75 04 85 c9 75 62 8b 43 5c 44 8b 73 54 83 e8 01 44 21 f0 48 8d 14 80 48 8b 83 98 00 00 00 4c 8d 24 d0 49 8b 44 24 10 <48> 8b 00 48 85 c0 74 16
[  137.741360] RSP: 0018:ffff93c28037fd68 EFLAGS: 00010202
[  137.742755] RAX: 0000000000000000 RBX: ffff8ed7012bc600 RCX: 0000000000000000
[  137.744647] RDX: 0000000000000005 RSI: 0000000000000000 RDI: ffff8ed7012bc600
[  137.746525] RBP: ffff93c28037fde0 R08: 0000000000000001 R09: ffffffffa6228df0
[  137.748414] R10: 0000000000018000 R11: 0000000000000000 R12: ffff8ed701e04828
[  137.750288] R13: ffff8ed701d68000 R14: 0000000000000001 R15: ffff93c28037fde0
[  137.752178] FS:  00007fe8d094d740(0000) GS:ffff8ed71d900000(0000) knlGS:0000000000000000
[  137.754293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  137.755845] CR2: 0000000000000000 CR3: 0000000002aba000 CR4: 00000000000006e0
[  137.757734] Call Trace:
[  137.758436]  <TASK>
[  137.759035]  ? __die+0x1e/0x60
[  137.759893]  ? page_fault_oops+0x17c/0x470
[  137.760989]  ? search_module_extables+0x14/0x50
[  137.762201]  ? exc_page_fault+0x67/0x150
[  137.763251]  ? asm_exc_page_fault+0x26/0x30
[  137.764378]  ? __pfx_pipe_to_null+0x10/0x10
[  137.765494]  ? splice_from_pipe_next+0x6e/0x180
[  137.766703]  __splice_from_pipe+0x39/0x1c0
[  137.767807]  ? __pfx_pipe_to_null+0x10/0x10
[  137.768922]  ? __pfx_pipe_to_null+0x10/0x10
[  137.770039]  splice_from_pipe+0x5c/0x90
[  137.771069]  do_splice+0x35c/0x840
[  137.772002]  __do_splice+0x1eb/0x210
[  137.772975]  __x64_sys_splice+0xad/0x120
[  137.774027]  do_syscall_64+0x3e/0x90
[  137.774999]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  137.776363] RIP: 0033:0x7fe8d0a58dd3
[  137.777335] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b9 66 2e 0f 1f 84 00 00 00 00 00 90 80 3d 11 18 0d 00 00 49 89 ca 74 14 b8 13 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 74
[  137.781970] RSP: 002b:00007ffe3e611af8 EFLAGS: 00000202 ORIG_RAX: 0000000000000113
[  137.783801] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe8d0a58dd3
[  137.785516] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
[  137.787229] RBP: 0000558b41c02000 R08: 0000000000018000 R09: 0000000000000001
[  137.788954] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000a
[  137.790666] R13: 0000558b41c02002 R14: 0000558b41c02000 R15: 0000000000000000
[  137.792280]  </TASK>
[  137.792767] Modules linked in:
[  137.793445] CR2: 0000000000000000
[  137.794224] ---[ end trace 0000000000000000 ]---
[  137.795235] RIP: 0010:splice_from_pipe_next+0x6e/0x180
[  137.796378] Code: 80 fe 01 75 04 85 c9 75 62 8b 43 5c 44 8b 73 54 83 e8 01 44 21 f0 48 8d 14 80 48 8b 83 98 00 00 00 4c 8d 24 d0 49 8b 44 24 10 <48> 8b 00 48 85 c0 74 16
[  137.800291] RSP: 0018:ffff93c28037fd68 EFLAGS: 00010202
[  137.801430] RAX: 0000000000000000 RBX: ffff8ed7012bc600 RCX: 0000000000000000
[  137.802958] RDX: 0000000000000005 RSI: 0000000000000000 RDI: ffff8ed7012bc600
[  137.804462] RBP: ffff93c28037fde0 R08: 0000000000000001 R09: ffffffffa6228df0
[  137.805915] R10: 0000000000018000 R11: 0000000000000000 R12: ffff8ed701e04828
[  137.807389] R13: ffff8ed701d68000 R14: 0000000000000001 R15: ffff93c28037fde0
[  137.808837] FS:  00007fe8d094d740(0000) GS:ffff8ed71d900000(0000) knlGS:0000000000000000
[  137.810467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  137.811662] CR2: 0000000000000000 CR3: 0000000002aba000 CR4: 00000000000006e0

--jidelvqglewikzxp--

--xd6fvopdq4tido3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSorhYACgkQvP0LAY0m
WPH8ww//W6rTokyffskLV5RGrBskQ0lKYEq5xzMDYGiisQB718jRSExqKutpD1pF
RDv4i7cw1eVp1QQk1+naQOaiNcbmYgkzdrLGJ6Fm1bdwcFby/D9lKmFgZJiIYshe
D37T5noJBCXgzTO0j6HVXDqro6a6kBK6yz/P2ImfFHe4hzjpCquORTeSrPuMdKWt
/RW8kf4FTtVS4mrgCHL8Oya0rkTeAwJuZC/eiz0Tacrydext0UVsGktli2h3zhO3
/Is7XOQM8NWga4LVuY2nwdPyA7CT3k9YtudEnqqo78QdLcNLosn+gCSxPv2y6I3P
j3s+yWrrgPD/ix+6smK2LCcU8abST8wjJkvpuUcaKsYszs4xyvJ3PjJFD1luFuzV
QqJfBi/lhYnGKu8fsF/4CgcI3iOzD06kmeW+/UEiJKIMX/Epzv7aXxe9TYiV+cfK
9q+x1m4dyPjFLTrg3a09uRpgjCnEwDb6FMcpg4XzNjoUFQE6yUnEN4JlKwxw1sDQ
BEcu+mQ9pn2+Tood/bNIInvNK0PNnSfS3YEPKXN5L/Bt2w27HGGGbEeAp53CimIB
PJaNTE4zVC0+NAeLwmCmm6wutXXHePjcHC69mzZGtWRKlQ3kOQ1FTMztQ4dXboJm
9MjD+EH96ZtEdcBr5+mcZBMW0RSs4/XjbEIU0ztK5AkV+dRSB7Q=
=GsCT
-----END PGP SIGNATURE-----

--xd6fvopdq4tido3u--
