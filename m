Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFF574C03A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 03:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGIBD2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 21:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGIBD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 21:03:28 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8016C1BC;
        Sat,  8 Jul 2023 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688864602;
        bh=FotQzynSJPM57LvJiZhKK2Q9QzBw2jlb4dDDhGobY58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AezFNDL24+AfjxjtUwABDFCPUIanpAAHMlwDczf+1gGQe8ygLYX5x5Gnbh3lBA+yA
         RJiDPw51Y9HHtHItExS9dQAv/ABP3V1ybrGL0IW35E7hEq+q6BhvXunNwoIDDWMuns
         N9mjd+oba0xNmOu92YbW9B3jHinpbgdeTfggsVOG8yvcXTXPBhb9Z44AAdSdBtfw16
         R7DzTpagnTGzFgCLZpgkXCepHa0GmCXAqY8HDyyDEjHoPhULYt1qM4dgNnK5o3pzz/
         B8p5mljMdsWZ0F1o4esVyJc9BVkLUiU8acIfnyfppr+zVyv2G4BACXLcva0pF8CPt+
         0gMqfDYX1kcJg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 61CAE22EC;
        Sun,  9 Jul 2023 03:03:22 +0200 (CEST)
Date:   Sun, 9 Jul 2023 03:03:21 +0200
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
Message-ID: <ayhdkedfibrhqrqi7bhzvkwz4yj44cmpcnzeop3dfqiujeheq3@dmgcirri46ut>
References: <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner>
 <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <20230707-konsens-ruckartig-211a4fb24e27@brauner>
 <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
 <zu7gnignulf7qqnoblpzjbu6cx5xtk2qum2uqr7q52ahxjbtdx@4ergovgpfuxt>
 <CAHk-=wjEC_Rh8+-rtEi8C45upO-Ffw=M_i1211qS_3AvWZCbOg@mail.gmail.com>
 <ltbgocygx4unco6ssoiszwsgjmztyuxkqja3omvvyqvpii6dac@5abamn33galn>
 <CAHk-=wimmqG_wvSRtMiKPeGGDL816n65u=Mq2+H3-=uM2U6FmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="znv4omsdjrlx2ejy"
Content-Disposition: inline
In-Reply-To: <CAHk-=wimmqG_wvSRtMiKPeGGDL816n65u=Mq2+H3-=uM2U6FmA@mail.gmail.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--znv4omsdjrlx2ejy
Content-Type: multipart/mixed; boundary="zyhpgzjcvgo6r3e3"
Content-Disposition: inline


--zyhpgzjcvgo6r3e3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 08, 2023 at 01:06:56PM -0700, Linus Torvalds wrote:
> On Fri, 7 Jul 2023 at 17:30, Ahelenia Ziemia=C5=84ska
> <nabijaczleweli@nabijaczleweli.xyz> wrote:
> >
> > Same reproducer, backtrace attached:
> > $ scripts/faddr2line vmlinux splice_from_pipe_next+0x6e
> > splice_from_pipe_next+0x6e/0x180:
> > pipe_buf_confirm at include/linux/pipe_fs_i.h:233
> Bah. I should have looked more closely at your case.
>=20
> This is a buffer without an 'ops' pointer. So it looks like was
> already released.
>=20
> And the reason is that the pipe was readable because there were no
> writers, and I had put the
>=20
>         if (!pipe->writers)
>                 return 0;
>=20
> check in splice_from_pipe_next() in the wrong place. It needs to be
> *before* the eat_empty_buffer() call.
>
> Anyway, while I think that fixes your NULL pointer thing,
It does.

> So while fixing your NULL pointer check should be trivial, I think
> that first patch is actually fundamentally broken wrt pipe resizing,
> and I see no really sane way to fix it. We could add a new lock just
> for that, but I don't think it's worth it.
>=20
> > You are, but, well, that's also the case when the pipe is full.
> > As it stands, the pipe is /empty/ and yet /no-one can write to it/.
> > This is the crux of the issue at hand.
> No, I think you are mis-representing things. The pipe isn't empty.
> It's full of things that just aren't finalized yet.
Being full of no data (as part of some hidden state)
doesn't make it any less empty, but meh; neither here not there.

> > Or, rather: splice() from a non-seekable (non-mmap()pable?)
> Please stop with the non-seekable nonsense.
>=20
> Any time I see a patch like this:
>=20
> > +               if (!(in->f_mode & FMODE_LSEEK))
> > +                       return -EINVAL;
>=20
> I will just go "that person is not competent".
Accurate assessment.

> This has absolutely nothing to do with seekability.
Yes, and as noted, I was using it as a stand-in for "I/O won't
block" due to the above (and splice_direct_to_actor() already uses
it). Glad to see you've managed to synthesise my drivel into something
workable.

> But it is possible that we need to just bite the bullet and say
> "copy_splice_read() needs to use a non-blocking kiocb for the IO".
>=20
> Of course, that then doesn't work, because while doing this is trivial:
>=20
>   --- a/fs/splice.c
>   +++ b/fs/splice.c
>   @@ -364,6 +364,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *p=
pos,
>         iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
>         init_sync_kiocb(&kiocb, in);
>         kiocb.ki_pos =3D *ppos;
>   +     kiocb.ki_flags |=3D IOCB_NOWAIT;
>         ret =3D call_read_iter(in, &kiocb, &to);
>=20
>         if (ret > 0) {
>=20
> I suspectr you'll find that it makes no difference, because the tty
> layer doesn't actually honor the IOCB_NOWAIT flag for various
> historical reasons.
Indeed, neither when splicing from a tty,
nor from a socket (same setup but socketpair(AF_UNIX, SOCK_STREAM, 0); w.c).

> In fact, the kiocb isn't even passed down to the
> low-level routine, which only gets the 'struct file *', and instead it
> looks at tty_io_nonblock(), which just does that legacy
>=20
>         file->f_flags & O_NONBLOCK
>=20
> test.
>=20
> I guess combined with something like
>=20
>         if (!(in->f_mode & FMODE_NOWAIT))
>                 return -EINVAL;
>=20
> it might all work.
Yes, that makes the splice instantly -EINVAL for ttys, but doesn't
affect the socketpair() case above, which still blocks forever.

This appears to be because vfs_splice_read() does
	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
		return copy_splice_read(in, ppos, pipe, len, flags);
	return in->f_op->splice_read(in, ppos, pipe, len, flags);
so the c_s_r() isn't even called for the socket, which uses
unix_stream_splice_read().

Thus,
  diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
  index 123b35ddfd71..384d5a479b4a 100644
  --- a/net/unix/af_unix.c
  +++ b/net/unix/af_unix.c
  @@ -2880,15 +2880,12 @@ static ssize_t unix_stream_splice_read(struct soc=
ket *sock,  loff_t *ppos,
                  .pipe =3D pipe,
                  .size =3D size,
                  .splice_flags =3D flags,
  +               .flags =3D MSG_DONTWAIT,
          };
 =20
          if (unlikely(*ppos))
                  return -ESPIPE;
 =20
  -       if (sock->file->f_flags & O_NONBLOCK ||
  -           flags & SPLICE_F_NONBLOCK)
  -               state.flags =3D MSG_DONTWAIT;
  -
          return unix_stream_read_generic(&state, false);
   }
makes the splice -EAGAIN w/o data and splice whatever's in the socket
when there is data.

git grep '\.splice_read.*=3D' | cut -d=3D -f2 | tr -s ',;[:space:]' '\n' | =
sort -u
gives me 27 distinct splice_read implementations and 1 cocci config.

These are simple delegations:
  nfs_file_splice_read               filemap_splice_read
  afs_file_splice_read               filemap_splice_read
  ceph_splice_read                   filemap_splice_read
  ecryptfs_splice_read_update_atime  filemap_splice_read
  ext4_file_splice_read              filemap_splice_read
  f2fs_file_splice_read              filemap_splice_read
  ntfs_file_splice_read              filemap_splice_read
  ocfs2_file_splice_read             filemap_splice_read
  orangefs_file_splice_read          filemap_splice_read
  v9fs_file_splice_read              filemap_splice_read
  xfs_file_splice_read               filemap_splice_read
  zonefs_file_splice_read            filemap_splice_read
  sock_splice_read                   copy_splice_read or a socket-specific =
one
  coda_file_splice_read              vfs_splice_read
  ovl_splice_read                    vfs_splice_read

vfs_splice_read calls copy_splice_read (not used as a .splice_read).

And the rest are:
01. copy_splice_read you've fixed
02. filemap_splice_read is, as I understand it, only applicable to
    files/blockdevs and already has the required semantics?

03. unix_stream_splice_read can be fixed as above

04. fuse_dev_splice_read allocates a buffer and fuse_dev_do_read()s into
    it, fuse_dev_do_read does
                 if (file->f_flags & O_NONBLOCK)
                         return -EAGAIN;
    so this is likely a similarly easy fix
05. tracing_buffers_splice_read, when it doesn't read anything does
                 ret =3D -EAGAIN;
                 if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONB=
LOCK))
                         goto out;
    and waits for at least one thing to read;
    can probably just goto out instantly
06. tracing_splice_read_pipe delegates to whatever it's tracing, and
    errors if that errored, so it's fine(?)

07. shmem_file_splice_read is always nonblocking
08. relay_file_splice_read only checks SPLICE_F_NONBLOCK to turn 0 into
    -EAGAIN so I think it also just doesn't block

09. smc_splice_read falls back to an embedded socket's splice_read,
    or uses=20
                if (flags & SPLICE_F_NONBLOCK)
                        flags =3D MSG_DONTWAIT;
                else
                        flags =3D 0;
                SMC_STAT_INC(smc, splice_cnt);
                rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, flags);
    so also probably remove the condition
10. kcm_splice_read:
10a. passes flags (SPLICE_F_...) to skb_recv_datagram(), which does
        timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
     verbatim!? and forwards them to try_recv which also checks
     for socket-style bits
10b. give it MSG_DONTWAIT, call it a day?
10c. it also passes flags to skb_splice_bits() to actually splice to the
     pipe, but that discards flags, so no change needed

11. tls_sw_splice_read I don't really understand but it does
        err =3D tls_rx_reader_lock(sk, ctx, flags & SPLICE_F_NONBLOCK);
    and
                err =3D tls_rx_rec_wait(sk, NULL, flags & SPLICE_F_NONBLOCK,
                                      true);
    (and skb_splice_bits()) so make them both true?

12. tcp_splice_read uses skb_splice_bits() and timeout governed by
        timeo =3D sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
    and re-tries on empty read if timeo!=3D0 (i.e. !(sock->file->f_flags & =
O_NONBLOCK));
    so turning that into true (timeo =3D 0) and propagating that would
	make it behave accd'g to the new semantic

Would that make sense?

--zyhpgzjcvgo6r3e3
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="w.c"

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdlib.h>
#include <sys/socket.h>

int main() {
  int sp[2];
  socketpair(AF_UNIX, SOCK_STREAM, 0, sp);
  for(;;)
    splice(sp[0], 0, 1, 0, 128 * 1024 * 1024, 0);
}

--zyhpgzjcvgo6r3e3--

--znv4omsdjrlx2ejy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSqB1UACgkQvP0LAY0m
WPHcGRAAsLYcMUXoG48Vsae5EIhIzRXLdrDROEGE8AWEi4I6dHlUnnjsuFuUGER4
QWnn212cepnKQMimTW2Vyg36mPcC6avwxTN0ukLUtyAj6AleVvL6HP5/KZSZjKin
J9Jw1RoVed9YoQC5RezcjRvoBMq+EIgpQIJW8GGKL//A79ziKw744pxPmPSKqk74
ALAzxhhAAX4hlcomN9B9nnZRz9X9LCQJRBqyJTkUC+oXjBYhrU3tmJVUYUFDTaKc
7s/rgaCgLIfP73FGNbhKBhQDCkqtWW7157+oC2J2tN8Bm//bJTAPJyo8XyDAkAz9
Cks1zvFI7f/Zi7X0j/BTV/kuovP2ajZTPq+24ogRUUChLlrWr0Xl2JPb0cn+NU1p
MwoCWv/YK/vbeY4O7bGhcx6ZFg5S6swUAoTgAHdcX5LnkzqTZrrPPrWMtk5EvZmK
iRMx+PiZqmBceSyjTi/AeeEzy6eHceoP1Vs4smKOzBeM2vXGLAsXA4/P6EfOE5o7
nJJe4TK4OzfgrLvA4cyCNSk0aClDXZMu1rMZjqdYnsSw1Ub5Hki5w5mLFmVDM5F2
wiAGMP2v8OACuVP0VivMwEL5ZD3u+XTPttUyuqdkwE41mCrEntnTAStnmpiP/stc
VpJLkrPpcpQQvzOGNKNqqtac1+UMShhgxGtf+yCSqXUYWglcmiU=
=tvxk
-----END PGP SIGNATURE-----

--znv4omsdjrlx2ejy--
