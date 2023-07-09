Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E5B74C8E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 00:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGIWdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 18:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGIWdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 18:33:12 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 232D411C;
        Sun,  9 Jul 2023 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688941987;
        bh=copD60sqR9ShfJVn1iJMw71OrVEnnBULXxUBQMdqo+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBkQNoyIy/lQbR5FYwJk/kxhVKDTdAhk+JbdQi24dPcXSgTZffWzmggKHaNfKDjKH
         6gKM8n0Kiqqh41jWuwN/3V1jrP0mJ1I2Gg/nvATZBa7M4JPdtNPaa+IdXGQwZpavZB
         qj4+tE34DHPXKuiavZAB2V7p6q4V/CncmcchlDCP+DhjfSMmXenItqY0CTRp24hnyw
         4InPmL0nwFmAd1vGiSS9JkZXs26mrBa+QocO3ccL3oc+pn8eGNDvEJ+JXHy8DsKjfX
         OQL8519Ny1Se4/ldMjw4j7VDTRpQ94bgJAP7E9V3CfOdmSEV4C3mctJVZZtp4odiX4
         HCbfuyZDfkPBw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id B33162C30;
        Mon, 10 Jul 2023 00:33:07 +0200 (CEST)
Date:   Mon, 10 Jul 2023 00:33:06 +0200
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
Message-ID: <gnj4drf7llod4voaaasoh5jdlq545gduishrbc3ql3665pw7qy@ytd5ykxc4gsr>
References: <20230626-fazit-campen-d54e428aa4d6@brauner>
 <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <20230707-konsens-ruckartig-211a4fb24e27@brauner>
 <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
 <zu7gnignulf7qqnoblpzjbu6cx5xtk2qum2uqr7q52ahxjbtdx@4ergovgpfuxt>
 <CAHk-=wjEC_Rh8+-rtEi8C45upO-Ffw=M_i1211qS_3AvWZCbOg@mail.gmail.com>
 <ltbgocygx4unco6ssoiszwsgjmztyuxkqja3omvvyqvpii6dac@5abamn33galn>
 <CAHk-=wimmqG_wvSRtMiKPeGGDL816n65u=Mq2+H3-=uM2U6FmA@mail.gmail.com>
 <ayhdkedfibrhqrqi7bhzvkwz4yj44cmpcnzeop3dfqiujeheq3@dmgcirri46ut>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ayvehwycdbypu54a"
Content-Disposition: inline
In-Reply-To: <ayhdkedfibrhqrqi7bhzvkwz4yj44cmpcnzeop3dfqiujeheq3@dmgcirri46ut>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ayvehwycdbypu54a
Content-Type: multipart/mixed; boundary="jnoq7fdqlhuvksia"
Content-Disposition: inline


--jnoq7fdqlhuvksia
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 09, 2023 at 03:03:22AM +0200, Ahelenia Ziemia=C5=84ska wrote:
> On Sat, Jul 08, 2023 at 01:06:56PM -0700, Linus Torvalds wrote:
> > I guess combined with something like
> >=20
> >         if (!(in->f_mode & FMODE_NOWAIT))
> >                 return -EINVAL;
> >=20
> > it might all work.
> Yes, that makes the splice instantly -EINVAL for ttys, but doesn't
> affect the socketpair() case above, which still blocks forever.

This also triggers for regular file -> pipe splices,
which is probably a no-go.


Attaching a summary diff that does all I said in the previous mail.

filemap_get_pages() does use and inspect IOCB_NOWAIT if set in
filemap_splice_read(), but it appears to not really make much sense,
inasmuch it returns EAGAIN for the first splice() from a
blockdev and then instantly return with data on the next go-around.

This doesn't really make much sense =E2=80=92 and open(2) says blockdevs
don't have O_NONBLOCK semantics, so I'm assuming this is not supposed
to be exposed to userspace =E2=80=92 so I'm not setting it in the diff.


I've tested this for:
  * tty: -EINVAL
  * socketpair(AF_UNIX, SOCK_STREAM): works as expected
	$ wc -c fifo &
	[1] 261
	$ ./af_unix ./s > fifo
	5       Success
	6454    Resource temporarily unavailable
	5       Success
	6445    Resource temporarily unavailable
	0       Success
	10 fifo
  * socket(AF_INET, SOCK_STREAM, 0): works as expected
	$ wc fifo &
	[1] 249
	$ ./tcp ./s > fifo
	23099   Resource temporarily unavailable
	7       Success
	2099    Resource temporarily unavailable
	4       Success
	1751    Resource temporarily unavailable
	3       Success
	21655   Resource temporarily unavailable
	95      Success
	19589   Resource temporarily unavailable
	0       Success
		  4      15     109 fifo
    corresponding to
	host$ nc 127.0.0.1 14640
	=C5=BCupan
	asd
	ad
	asdda dasj aiojd askdl; jasiopdij as[pkdo[p askd9p ias90dk aso[pjd 890pasi=
d90[ jaskl;dj il;asd
	^C
  * blockdev (/dev/vda): as expected (with filemap_splice_read() unchanged)=
, copies it all
  * regular file: -EINVAL(!)

Splicers still sleep if the pipe's full, of course,
unless SPLICE_F_NONBLOCK.

Test drivers attached as well.

--jnoq7fdqlhuvksia
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="nowait.diff"
Content-Transfer-Encoding: quoted-printable

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..4e8caf66c01e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1202,7 +1202,8 @@ __releases(fiq->lock)
  * the 'sent' flag.
  */
 static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
-				struct fuse_copy_state *cs, size_t nbytes)
+				struct fuse_copy_state *cs, size_t nbytes,
+				bool nonblock)
 {
 	ssize_t err;
 	struct fuse_conn *fc =3D fud->fc;
@@ -1238,7 +1239,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud,=
 struct file *file,
 			break;
 		spin_unlock(&fiq->lock);
=20
-		if (file->f_flags & O_NONBLOCK)
+		if (nonblock)
 			return -EAGAIN;
 		err =3D wait_event_interruptible_exclusive(fiq->waitq,
 				!fiq->connected || request_pending(fiq));
@@ -1364,7 +1365,8 @@ static ssize_t fuse_dev_read(struct kiocb *iocb, stru=
ct iov_iter *to)
=20
 	fuse_copy_init(&cs, 1, to);
=20
-	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to));
+	return fuse_dev_do_read(fud, file, &cs, iov_iter_count(to),
+				file->f_flags & O_NONBLOCK);
 }
=20
 static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
@@ -1388,7 +1390,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, =
loff_t *ppos,
 	fuse_copy_init(&cs, 1, NULL);
 	cs.pipebufs =3D bufs;
 	cs.pipe =3D pipe;
-	ret =3D fuse_dev_do_read(fud, in, &cs, len);
+	ret =3D fuse_dev_do_read(fud, in, &cs, len, true);
 	if (ret < 0)
 		goto out;
=20
diff --git a/fs/splice.c b/fs/splice.c
index 004eb1c4ce31..e52cc42fff46 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -364,6 +364,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos =3D *ppos;
+	kiocb.ki_flags |=3D IOCB_NOWAIT;
 	ret =3D call_read_iter(in, &kiocb, &to);
=20
 	if (ret > 0) {
@@ -1309,6 +1310,8 @@ long do_splice(struct file *in, loff_t *off_in, struc=
t file *out,
 	if (opipe) {
 		if (off_out)
 			return -ESPIPE;
+		if (!(in->f_mode & FMODE_NOWAIT))
+			return -EINVAL;
 		if (off_in) {
 			if (!(in->f_mode & FMODE_PREAD))
 				return -EINVAL;
diff --git a/kernel/relay.c b/kernel/relay.c
index a80fa01042e9..d3f5682c4a12 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1215,8 +1215,7 @@ static ssize_t relay_file_splice_read(struct file *in,
 		if (ret < 0)
 			break;
 		else if (!ret) {
-			if (flags & SPLICE_F_NONBLOCK)
-				ret =3D -EAGAIN;
+			ret =3D -EAGAIN;
 			break;
 		}
=20
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4529e264cb86..821bcbcd9e35 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8391,7 +8391,6 @@ tracing_buffers_splice_read(struct file *file, loff_t=
 *ppos,
 	if (splice_grow_spd(pipe, &spd))
 		return -ENOMEM;
=20
- again:
 	trace_access_lock(iter->cpu_file);
 	entries =3D ring_buffer_entries_cpu(iter->array_buffer->buffer, iter->cpu=
_file);
=20
@@ -8442,35 +8441,12 @@ tracing_buffers_splice_read(struct file *file, loff=
_t *ppos,
=20
 	/* did we read anything? */
 	if (!spd.nr_pages) {
-		long wait_index;
-
-		if (ret)
-			goto out;
-
-		ret =3D -EAGAIN;
-		if ((file->f_flags & O_NONBLOCK) || (flags & SPLICE_F_NONBLOCK))
-			goto out;
-
-		wait_index =3D READ_ONCE(iter->wait_index);
-
-		ret =3D wait_on_pipe(iter, iter->tr->buffer_percent);
-		if (ret)
-			goto out;
-
-		/* No need to wait after waking up when tracing is off */
-		if (!tracer_tracing_is_on(iter->tr))
-			goto out;
-
-		/* Make sure we see the new wait_index */
-		smp_rmb();
-		if (wait_index !=3D iter->wait_index)
-			goto out;
-
-		goto again;
+		if (!ret)
+			ret =3D -EAGAIN;
+	} else {
+		ret =3D splice_to_pipe(pipe, &spd);
 	}
=20
-	ret =3D splice_to_pipe(pipe, &spd);
-out:
 	splice_shrink_spd(&spd);
=20
 	return ret;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03e08745308..92a2be52123e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -780,7 +780,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,
 		.len =3D len,
 		.flags =3D flags,
 	};
-	long timeo;
 	ssize_t spliced;
 	int ret;
=20
@@ -795,7 +794,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,
=20
 	lock_sock(sk);
=20
-	timeo =3D sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
 	while (tss.len) {
 		ret =3D __tcp_splice_read(sk, &tss);
 		if (ret < 0)
@@ -819,35 +817,13 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *=
ppos,
 				ret =3D -ENOTCONN;
 				break;
 			}
-			if (!timeo) {
-				ret =3D -EAGAIN;
-				break;
-			}
-			/* if __tcp_splice_read() got nothing while we have
-			 * an skb in receive queue, we do not want to loop.
-			 * This might happen with URG data.
-			 */
-			if (!skb_queue_empty(&sk->sk_receive_queue))
-				break;
-			sk_wait_data(sk, &timeo, NULL);
-			if (signal_pending(current)) {
-				ret =3D sock_intr_errno(timeo);
-				break;
-			}
-			continue;
+			ret =3D -EAGAIN;
+			break;
 		}
 		tss.len -=3D ret;
 		spliced +=3D ret;
=20
-		if (!tss.len || !timeo)
-			break;
-		release_sock(sk);
-		lock_sock(sk);
-
-		if (sk->sk_err || sk->sk_state =3D=3D TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
-			break;
+		break;
 	}
=20
 	release_sock(sk);
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 393f01b2a7e6..f96b52a8be0e 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1025,7 +1025,7 @@ static ssize_t kcm_splice_read(struct socket *sock, l=
off_t *ppos,
=20
 	/* Only support splice for SOCKSEQPACKET */
=20
-	skb =3D skb_recv_datagram(sk, flags, &err);
+	skb =3D skb_recv_datagram(sk, MSG_DONTWAIT, &err);
 	if (!skb)
 		goto err_out;
=20
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index a7f887d91d89..4ba8f93ddbe5 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3172,12 +3172,8 @@ static ssize_t smc_splice_read(struct socket *sock, =
loff_t *ppos,
 			rc =3D -ESPIPE;
 			goto out;
 		}
-		if (flags & SPLICE_F_NONBLOCK)
-			flags =3D MSG_DONTWAIT;
-		else
-			flags =3D 0;
 		SMC_STAT_INC(smc, splice_cnt);
-		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, flags);
+		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, MSG_DONTWAIT);
 	}
 out:
 	release_sock(sk);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 53f944e6d8ef..7df1ea6a62a5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2136,7 +2136,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff=
_t *ppos,
 	int chunk;
 	int err;
=20
-	err =3D tls_rx_reader_lock(sk, ctx, flags & SPLICE_F_NONBLOCK);
+	err =3D tls_rx_reader_lock(sk, ctx, true);
 	if (err < 0)
 		return err;
=20
@@ -2145,8 +2145,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff=
_t *ppos,
 	} else {
 		struct tls_decrypt_arg darg;
=20
-		err =3D tls_rx_rec_wait(sk, NULL, flags & SPLICE_F_NONBLOCK,
-				      true);
+		err =3D tls_rx_rec_wait(sk, NULL, true, true);
 		if (err <=3D 0)
 			goto splice_read_end;
=20
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 123b35ddfd71..384d5a479b4a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2880,15 +2880,12 @@ static ssize_t unix_stream_splice_read(struct socke=
t *sock,  loff_t *ppos,
 		.pipe =3D pipe,
 		.size =3D size,
 		.splice_flags =3D flags,
+		.flags =3D MSG_DONTWAIT,
 	};
=20
 	if (unlikely(*ppos))
 		return -ESPIPE;
=20
-	if (sock->file->f_flags & O_NONBLOCK ||
-	    flags & SPLICE_F_NONBLOCK)
-		state.flags =3D MSG_DONTWAIT;
-
 	return unix_stream_read_generic(&state, false);
 }
=20

--jnoq7fdqlhuvksia
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="s.c"

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
int main() {
	int lasterr = -1;
	unsigned ctr = 0;
	for(;;) {
		errno = 0;
		ssize_t ret = splice(0, 0, 1, 0, 128 * 1024 * 1024, 0);
		if(ret >= 0 || errno != lasterr) {
			fprintf(stderr, "\n\t%m" + (lasterr == -1));
			lasterr = errno;
			ctr = 0;
		}
		if(ret == -1) {
			++ctr;
			fprintf(stderr, "\r%u", ctr);
		} else
			fprintf(stderr, "\r%zu", ret);
		if(!ret)
			break;
	}
	fprintf(stderr, "\n");
}

--jnoq7fdqlhuvksia
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="tcp.c"

#define _GNU_SOURCE
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <unistd.h>

int main(int argc, char ** argv) {
	int s = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_port = 12345,
		.sin_addr = 0,
	};
	if(bind(s, &addr, sizeof(addr)) == -1 || listen(s, 128))
		abort();

	int fd = accept4(s, NULL, NULL, SOCK_CLOEXEC);
	if(fd == -1)
		abort();
	dup2(fd, 0);
	execvp(argv[1], argv + 1);
}

--jnoq7fdqlhuvksia
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="af_unix.c"

#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <unistd.h>

int main(int argc, char ** argv) {
	int fds[2];
	if(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, fds))
		abort();

	if(!vfork()) {
		dup2(fds[0], 0);
		_exit(execvp(argv[1], argv + 1));
	}
	dup2(fds[1], 1);
	write(1, "dupa\n", 5);
	sleep(1);
	write(1, "dupa\n", 5);
	sleep(1);
}

--jnoq7fdqlhuvksia--

--ayvehwycdbypu54a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSrNZ8ACgkQvP0LAY0m
WPGCbw/7BcI5WW+XmSX7E6Q5x7IlD9w7CPW51zakPGE5xtEb9qWqCMxbTNL8+t4P
/tSzT0HJjpsZGdyixpibl8nbg36W0ZT1nefhZ0KcRhY2oFi6c32HtHcX3Gh0icAf
a1AcSthCq07LKHxFQy/7OWDj7pPotg0kPN+lWQpeexpi9wu2PSY+Q97WOkQKdSP3
Jk10e8wRcL1prjtUz6s8zT3/wOf2oGjMhQN8AHIsv+aqFktY5kFqbO9N69BPDIBq
TJKhnkVYASv2nYKz1uxYLLVdfSWMiRHu7HbPFvKnWfTaotsGEChlwRBmEN4vN7Mw
xg4BLVGAoTs0/mlchGrdlNjVn0Iq6SbFAvugYJMJjExDXobLsEE33OS22CaZ0N48
KccCZ8qjCq1zj1ed8lt/v4IYAet50BDGo7Y7aSCWGJy08rGO7I+hBV3eDHR5S2rd
ramYNzA0QWq0xJF8Dyp3sfs90i9ArmA7EiZA4tOcybQAU/8j/6ImwR0xZeoCCQu3
fSzdNv7lyum3iEvQwQiqXlzmqeFd0tqiv3Gm1U2nN15WAzHZaXbd0b2RTtPHr+2e
AZq+TZ2MNv1ZnSvhBuzSz42j0tPGrVowh+w04EX6M6JMCe5QAeb0PI75UG/9Isto
SQTk9gCDIXl7ChJH07l5ZhCPwjnJQj7///iTB/zZA2GE8mdKhOY=
=QPQK
-----END PGP SIGNATURE-----

--ayvehwycdbypu54a--
