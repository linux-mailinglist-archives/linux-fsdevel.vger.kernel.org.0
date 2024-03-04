Return-Path: <linux-fsdevel+bounces-13474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2661870357
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B0528A036
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC083E468;
	Mon,  4 Mar 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOKZ+5YY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F43FB22;
	Mon,  4 Mar 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560377; cv=none; b=HES/QCSBMgNlW8IelfKCzviJ4xNo3VsBKZnFW3pFeUDk36Sv8RqQ6G9VdHPYCuwNQsgtgIMhUxqKx6FsG3DRMueDirvj4SVtNRjn3/ZqmA3W6LaWsle8BRdQDgUoQSCb8R8bF+fCnpOeUUAXWxP5GvSULG6YiZ1zUfvoidw78WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560377; c=relaxed/simple;
	bh=OoFrPQTcL04921q4XEMUZnUgL72Ub60qBvej+i6/2IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlnOdV++StbcIuTKmXkXu5DIr1HDU5JBNzbsBgpVltQunqruTVb9QCO01ipztrj3DOmjgL0sREJO8DzLF4PP8e59yDbQyHv5Z1jZ60eGQ3YsB/rG+F59cva0R4ioZuuyxNaY+HbIVsjgw2DP9fW+hOuCtVGX3D0surGVX9VuSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOKZ+5YY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1D4C433F1;
	Mon,  4 Mar 2024 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709560376;
	bh=OoFrPQTcL04921q4XEMUZnUgL72Ub60qBvej+i6/2IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOKZ+5YYiUi/CU6nl3knVZ+qnV0JosBBHPhNxQ9TdVggSpAklESndkADtadLpzH61
	 GpgzO/e2a05C3L5Q8clwkYueg6BD1mXcAx8pGQnwIotzmLEeWHbQVIZ345MhY53V4M
	 hcgi/3BztcafKYIS+nNTNXcsGGTmeKkyD927NRGF1bHfx+/BfNazrSiK7hgE7NnTT8
	 RaGMzNwExRqC8SSjE7xsOZWrT4+DlvSORvUH4N26VcyADJ9NRomK1JjZL+WC6XmUeW
	 DkhJHI+tILkhba/yVk2gDQpvHktyE/mN6dfmx0LtSgW+ce8uwdRuXKcBGPKn6UuLeE
	 K8O2PyTlFfg9w==
Date: Mon, 4 Mar 2024 14:52:46 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: sendfile(2) erroneously yields EINVAL on too large counts
Message-ID: <ZeXSNSxs68FrkLXu@debian>
References: <38nr2286-1o9q-0004-2323-799587773o15@vanv.qr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EKq123TC/P2K2t3q"
Content-Disposition: inline
In-Reply-To: <38nr2286-1o9q-0004-2323-799587773o15@vanv.qr>


--EKq123TC/P2K2t3q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 14:52:46 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jan Engelhardt <jengelh@inai.de>
Cc: linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: sendfile(2) erroneously yields EINVAL on too large counts

Hi Jan!

On Thu, Feb 15, 2024 at 02:49:05PM +0100, Jan Engelhardt wrote:
>=20
> Observed:
> The following program below leads to sendfile returning -1 and setting=20
> errno=3DEINVAL.
>=20
> Expected:
> Return 0.

I disagree.  The program has some problems, and should report an error.

> System: Linux 6.7.4 amd64 glibc-2.39
>=20
> Rationale:
>=20
> As per man-pages 6.60's sendfile.2 page:
>=20
>        EINVAL Descriptor is not valid or locked, or an mmap(2)-like=20
>               operation is not available for in_fd, or count is=20
>               negative.
>=20
> (Invalid descriptors should yield EBADF instead, I think.)
> mmap is probably functional, since the testcase works if write() calls=20
> are removed.
> count is not negative.

count + file offset *is* negative.  You forgot to lseek(2).

> It appears that there may be a
> `src offset + count > SSIZE_MAX || dst offset + count > SSIZE_MAX`
> check in the kernel somewhere,

There are several.  See at the bottom.

> which sounds an awful lot like the documented EOVERFLOW behavior:
>=20
>        EOVERFLOW
>               count is too large, the operation would result in
>               exceeding the maximum size of either the input file or
>               the output file.
>=20
> but the reported error is EINVAL rather than EOVERFLOW.  Moreover, the
> (actual) result from this testcase does not go above a few bytes
> anyhow, so should not signal an overflow anyway.

The kernel detects that offset+count would overflow, and aborts early.
That's actually a good thing.  Otherwise, we wouldn't have noticed that
the program is missing an lseek(2) call until much later.  Also, given
addition of count+offset would cause overflow, that is, undefined
behavior, it's better to not even start.  Otherwise, it gets tricky to
write code that doesn't invoke UB.

(By inspecting the kernel code I'm not sure if it avoids UB; I think it
might be triggering UB; let me debug that and come with an update.)

> #define _GNU_SOURCE 1
> #include <errno.h>
> #include <fcntl.h>
> #include <limits.h>
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
> #include <sys/sendfile.h>
> int main(int argc, char **argv)
> {
>         int src =3D open(".", O_RDWR | O_TMPFILE, 0666);
>         write(src, "1234", 4);
>         int dst =3D open(".", O_RDWR | O_TMPFILE, 0666);
>         write(src, "1234", 4);
>         ssize_t ret =3D sendfile(dst, src, NULL, SSIZE_MAX);

Even if you pass SSIZE_MAX - 8, which will be accepted by the kernel,
this call will always copy exactly 0 bytes.  Rationale: the file
descriptor is positioned at the end of the source file.

>         printf("%ld\n", (long)ret);
>         if (ret < 0)
>                 printf("%s\n", strerror(errno));
>         return 0;
> }
>=20
> As it stands, a sendfile() user just wanting to shovel src to dst
> cannot just "fire-and-forget" but has to compute a suitable count=20
> beforehand.

You can.  But you need to put the file descriptor at the begining of the
file (or if you really want to start reading mid-file, you'll need to
pass SSIZE_MAX-offset).

> Is this really what we want?

I'm not entirely sure if the kernel should report EINVAL or EOVERFLOW,
nor what should the manual page specify.

But regarding the fire-and-offset question, it's possible to do it:


alx@debian:~/tmp$ cat sf.c=20
#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <limits.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/sendfile.h>


int
main(void)
{
	int      src, dst;
	ssize_t  ret;
	char     buf[BUFSIZ];

	src =3D open(".", O_RDWR | O_TMPFILE, 0666);
	if (src =3D=3D -1)
		err(EXIT_FAILURE, "open");
	dst =3D open(".", O_RDWR | O_TMPFILE, 0666);
	if (dst =3D=3D -1)
		err(EXIT_FAILURE, "open");

	ret =3D write(src, "1234", 4);
	if (ret !=3D 4)
		err(EXIT_FAILURE, "write: %zd", ret);
	write(src, "asd\n", 4);
	if (ret !=3D 4)
		err(EXIT_FAILURE, "write: %zd", ret);

	if (lseek(src, 0, SEEK_SET) =3D=3D -1)
		err(EXIT_FAILURE, "lseek");
	ret =3D sendfile(dst, src, NULL, SSIZE_MAX);
	if (ret !=3D 8)
		err(EXIT_FAILURE, "sendfile: %zd", ret);

	if (lseek(dst, 0, SEEK_SET) =3D=3D -1)
		err(EXIT_FAILURE, "lseek");
	ret =3D read(dst, buf, BUFSIZ);
	if (ret !=3D 8)
		err(EXIT_FAILURE, "read: %zd", ret);

	ret =3D write(STDOUT_FILENO, buf, ret);
	if (ret !=3D 8)
		err(EXIT_FAILURE, "write: %zd", ret);
	return 0;
}
alx@debian:~/tmp$ cc -Wall -Wextra sf.c=20
alx@debian:~/tmp$ ./a.out=20
1234asd
alx@debian:~/tmp$

Or the same thing without error handling, to make it more readable:

alx@debian:~/tmp$ cat sf2.c=20
#define _GNU_SOURCE
#include <fcntl.h>
#include <limits.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/sendfile.h>


int
main(void)
{
	int      src, dst;
	ssize_t  ret;
	char     buf[BUFSIZ];

	src =3D open(".", O_RDWR | O_TMPFILE, 0666);
	dst =3D open(".", O_RDWR | O_TMPFILE, 0666);

	ret =3D write(src, "1234", 4);
	write(src, "asd\n", 4);

	lseek(src, 0, SEEK_SET);
	sendfile(dst, src, NULL, SSIZE_MAX);

	lseek(dst, 0, SEEK_SET);
	ret =3D read(dst, buf, BUFSIZ);
	write(STDOUT_FILENO, buf, ret);
	return 0;
}
alx@debian:~/tmp$ cc -Wall -Wextra sf2.c=20
alx@debian:~/tmp$ ./a.out=20
1234asd
alx@debian:~/tmp$


TL;DR:

I'm not sure if this should EINVAL or EOVERFLOW, but other than that, I
think we're good.  Feel free to suggest that the page or the kernel is
wrong regarding errno.

Have a lovely day!
Alex


----

See where the kernel reports EINVAL or EOVERFLOW:


alx@debian:~/src/linux/linux/master$ find . -type f \
				| grep '\.c$' \
				| xargs grepc -tfld -m1 sendfile;
=2E/fs/read_write.c:SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd, off_=
t __user *, offset, size_t, count)
{
	loff_t pos;
	off_t off;
	ssize_t ret;

	if (offset) {
		if (unlikely(get_user(off, offset)))
			return -EFAULT;
		pos =3D off;
		ret =3D do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
		if (unlikely(put_user(pos, offset)))
			return -EFAULT;
		return ret;
	}

	return do_sendfile(out_fd, in_fd, NULL, count, 0);
}
alx@debian:~/src/linux/linux/master$ find fs/ -type f \
				| grep '\.c$' \
				| xargs grepc -tfd do_sendfile;
fs/read_write.c:static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *p=
pos,
			   size_t count, loff_t max)
{
	struct fd in, out;
	struct inode *in_inode, *out_inode;
	struct pipe_inode_info *opipe;
	loff_t pos;
	loff_t out_pos;
	ssize_t retval;
	int fl;

	/*
	 * Get input file, and verify that it is ok..
	 */
	retval =3D -EBADF;
	in =3D fdget(in_fd);
	if (!in.file)
		goto out;
	if (!(in.file->f_mode & FMODE_READ))
		goto fput_in;
	retval =3D -ESPIPE;
	if (!ppos) {
		pos =3D in.file->f_pos;
	} else {
		pos =3D *ppos;
		if (!(in.file->f_mode & FMODE_PREAD))
			goto fput_in;
	}
	retval =3D rw_verify_area(READ, in.file, &pos, count);
	if (retval < 0)
		goto fput_in;
	if (count > MAX_RW_COUNT)
		count =3D  MAX_RW_COUNT;

	/*
	 * Get output file, and verify that it is ok..
	 */
	retval =3D -EBADF;
	out =3D fdget(out_fd);
	if (!out.file)
		goto fput_in;
	if (!(out.file->f_mode & FMODE_WRITE))
		goto fput_out;
	in_inode =3D file_inode(in.file);
	out_inode =3D file_inode(out.file);
	out_pos =3D out.file->f_pos;

	if (!max)
		max =3D min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);

	if (unlikely(pos + count > max)) {
		retval =3D -EOVERFLOW;
		if (pos >=3D max)
			goto fput_out;
		count =3D max - pos;
	}

	fl =3D 0;
#if 0
	/*
	 * We need to debate whether we can enable this or not. The
	 * man page documents EAGAIN return for the output at least,
	 * and the application is arguably buggy if it doesn't expect
	 * EAGAIN on a non-blocking file descriptor.
	 */
	if (in.file->f_flags & O_NONBLOCK)
		fl =3D SPLICE_F_NONBLOCK;
#endif
	opipe =3D get_pipe_info(out.file, true);
	if (!opipe) {
		retval =3D rw_verify_area(WRITE, out.file, &out_pos, count);
		if (retval < 0)
			goto fput_out;
		retval =3D do_splice_direct(in.file, &pos, out.file, &out_pos,
					  count, fl);
	} else {
		if (out.file->f_flags & O_NONBLOCK)
			fl |=3D SPLICE_F_NONBLOCK;

		retval =3D splice_file_to_pipe(in.file, opipe, &pos, count, fl);
	}

	if (retval > 0) {
		add_rchar(current, retval);
		add_wchar(current, retval);
		fsnotify_access(in.file);
		fsnotify_modify(out.file);
		out.file->f_pos =3D out_pos;
		if (ppos)
			*ppos =3D pos;
		else
			in.file->f_pos =3D pos;
	}

	inc_syscr(current);
	inc_syscw(current);
	if (pos > max)
		retval =3D -EOVERFLOW;

fput_out:
	fdput(out);
fput_in:
	fdput(in);
out:
	return retval;
}
alx@debian:~/src/linux/linux/master$ find fs/ -type f \
				| grep '\.c$' \
				| xargs grepc -tfd rw_verify_area;
fs/read_write.c:int rw_verify_area(int read_write, struct file *file, const=
 loff_t *ppos, size_t count)
{
	int mask =3D read_write =3D=3D READ ? MAY_READ : MAY_WRITE;
	int ret;

	if (unlikely((ssize_t) count < 0))
		return -EINVAL;

	if (ppos) {
		loff_t pos =3D *ppos;

		if (unlikely(pos < 0)) {
			if (!unsigned_offsets(file))
				return -EINVAL;
			if (count >=3D -pos) /* both values are in 0..LLONG_MAX */
				return -EOVERFLOW;
		} else if (unlikely((loff_t) (pos + count) < 0)) {
			if (!unsigned_offsets(file))
				return -EINVAL;
		}
	}

	ret =3D security_file_permission(file, mask);
	if (ret)
		return ret;

	return fsnotify_file_area_perm(file, mask, ppos, count);
}


--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--EKq123TC/P2K2t3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXl0i4ACgkQnowa+77/
2zJCJQ//XwBTwKW0OKRG9JNg2WUldDIpnoumA/+TPsvMGbh2XNCX8/6Y2r0ybt7x
YeEf8ZbCltSqHLEUDzpKDpR/0adxxlkS7LEWpsRQRfpSgID/8sHOpqNhbmpLyCmH
Ouyx5Efwl0iSuunbDfdbzpd7LpvFEjgHu1KVEPXlM/9T5dEarv38GHTi/wehiS02
BBsH6J0JoaWXplHLq+wgCD30jQJQ6OtGHQzqv1qww4Jjp2J2g5DrqfRe+LXIFRz6
YUWUiui2cwaYp1YSk1RONq1NpR0gaZdl3/SjFMhGyD/pHilknmiaoMXCl7I7yq0a
qv8nYxhoY0hj5lklKr6wI19sPOGyV5u3GLJxGhNH2AOFXEy6zGR5biVuShzewNjL
Y/9+knegdYF4syzdJNlCDB4fEyQzB4SlPQyIFYIRC65Iyqmu0zSC9K/Xr+BZEt4v
DImnlkZH/763uGoBOgLQMBLe6YxWA11QEdLaa9Onb5QbKCezasaTUxy7Fdo++kKP
iusolODvyiqKKNjbr+bWxQ4G1KogutoCjO051MaVMTv/jGOVJAUSczSrVO+12ial
8BLiARV8YHbXuG8NZAM6sHkGTmT+OkycW7UKpsHp2bGjYOjlgO9JD1y/UBf6kosN
xk5Gbu9h7xYmKC0Ab0q7kE6Yp47RNbuURUs6PKK45TEB99woyck=
=9p6i
-----END PGP SIGNATURE-----

--EKq123TC/P2K2t3q--

