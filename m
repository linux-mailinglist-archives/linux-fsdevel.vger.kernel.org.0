Return-Path: <linux-fsdevel+bounces-28322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7868C9693E8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 08:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D7F1F2401D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 06:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265131D54F1;
	Tue,  3 Sep 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="vUrE0kaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCAE1CB527;
	Tue,  3 Sep 2024 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345693; cv=none; b=tqqSuK428WmOIKe0APkuY1wjADbI9oojG02jOlFfeGVwcgrhr4zikBEmebpG3Ty46Fd+AHhp0t7KPSVh5uulSorEl6Xx//SFsrcboU5DBAY1NxlxkXrIKoibRMoT/x8GfT7nB5dtNIr9FGdNEJ4sJhhc8pNCBFJLvWYcmyUwMoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345693; c=relaxed/simple;
	bh=10uLDIUCBY4fIvQsKOq30PPSUayb76NqE8dmAGfNE9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRH8FFSCqR/BLPoxrDyYWI44LDj8LoKX7+v2D1zmdFdGuanD9sz1F9zF5UWiMIF3agMQQLHnM2RNF/6IvYha3+3NFFawW+f8TajCqbbVpf7OFLD3YSc3XEs8SN0g0dMIrJUMQhLLN/zWe/1OtTlq8xIAJv9T6vuhY45Cq/nI7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=vUrE0kaZ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Wybck5KDpz9sWv;
	Tue,  3 Sep 2024 08:41:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725345686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0iV/a/l2V2hPvNhsAZ5+2KTyT/o+KSN/NrQZZQqanbw=;
	b=vUrE0kaZkd3MoQKoPWXQltRS6ijYNAluYWfYABJL/5eaLhgOCWO8vLIXwwqgqieh/+GBHF
	LNPPn68NbCmDf+PFt1HTDYPsubBWX5LOTDbPaiP8s0xCIdVeiB4GPgH9+693Dzfp5CEkBq
	v4maHHp2rm4gDhyPRq8BpO971gUVM2aVUYJQiV7bsVquK7xATXqJCR13MWhTWTDfpbNKBt
	XKE8rpqetJOpmKXZ1XwZphKdlSw7QFrUmX4otyvJq+2V8R8nDCanPNes5Z0vcgvVWU5rFF
	ARQSkl4SVa5d58EbwYVmpt2MB1yEbwrs6xwKfTc5hg+nhS01RRQhgF3GyO5spw==
Date: Tue, 3 Sep 2024 16:41:08 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Christoph Hellwig <hch@infradead.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH xfstests v2 2/2] open_by_handle: add tests for u64 mount
 ID
Message-ID: <20240903.044647-some.sprint.silent.snacks-jdKnAVp7XuBZ@cyphar.com>
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240902164554.928371-1-cyphar@cyphar.com>
 <20240902164554.928371-2-cyphar@cyphar.com>
 <CAOQ4uxgS6DvsbUsEoM1Vr2wcd_7Bj=xFXMAy4z9PphTu+G6RaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkptxxxh47nfrloo"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgS6DvsbUsEoM1Vr2wcd_7Bj=xFXMAy4z9PphTu+G6RaQ@mail.gmail.com>


--xkptxxxh47nfrloo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-02, Amir Goldstein <amir73il@gmail.com> wrote:
> On Mon, Sep 2, 2024 at 6:46=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> w=
rote:
> >
> > Now that open_by_handle_at(2) can return u64 mount IDs, do some tests to
> > make sure they match properly as part of the regular open_by_handle
> > tests.
> >
> > Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-v3-0-1=
0c2c4c16708@cyphar.com/
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> > v2:
> > - Remove -M argument and always do the mount ID tests. [Amir Goldstein]
> > - Do not error out if the kernel doesn't support STATX_MNT_ID_UNIQUE
> >   or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
> > - v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cyphar@cyph=
ar.com/>
>=20
> Looks good.
>=20
> You may add:
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>=20
> It'd be nice to get a verification that this is indeed tested on the late=
st
> upstream and does not regress the tests that run the open_by_handle progr=
am.

I've tested that the fallback works on mainline and correctly does the
test on patched kernels (by running open_by_handle directly) but I
haven't run the suite yet (still getting my mkosi testing setup working
to run fstests...).

> Thanks,
> Amir.
>=20
> >
> >  src/open_by_handle.c | 128 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 99 insertions(+), 29 deletions(-)
> >
> > diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> > index d9c802ca9bd1..0ad591da632e 100644
> > --- a/src/open_by_handle.c
> > +++ b/src/open_by_handle.c
> > @@ -86,10 +86,16 @@ Examples:
> >  #include <errno.h>
> >  #include <linux/limits.h>
> >  #include <libgen.h>
> > +#include <stdint.h>
> > +#include <stdbool.h>
> >
> >  #include <sys/stat.h>
> >  #include "statx.h"
> >
> > +#ifndef AT_HANDLE_MNT_ID_UNIQUE
> > +#      define AT_HANDLE_MNT_ID_UNIQUE 0x001
> > +#endif
> > +
> >  #define MAXFILES 1024
> >
> >  struct handle {
> > @@ -120,6 +126,94 @@ void usage(void)
> >         exit(EXIT_FAILURE);
> >  }
> >
> > +int do_name_to_handle_at(const char *fname, struct file_handle *fh, in=
t bufsz)
> > +{
> > +       int ret;
> > +       int mntid_short;
> > +
> > +       static bool skip_mntid_unique;
> > +
> > +       uint64_t statx_mntid_short =3D 0, statx_mntid_unique =3D 0;
> > +       struct statx statxbuf;
> > +
> > +       /* Get both the short and unique mount id. */
> > +       if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID, &statxbuf) < 0) {
> > +               fprintf(stderr, "%s: statx(STATX_MNT_ID): %m\n", fname);
> > +               return EXIT_FAILURE;
> > +       }
> > +       if (!(statxbuf.stx_mask & STATX_MNT_ID)) {
> > +               fprintf(stderr, "%s: no STATX_MNT_ID in stx_mask\n", fn=
ame);
> > +               return EXIT_FAILURE;
> > +       }
> > +       statx_mntid_short =3D statxbuf.stx_mnt_id;
> > +
> > +       if (!skip_mntid_unique) {
> > +               if (statx(AT_FDCWD, fname, 0, STATX_MNT_ID_UNIQUE, &sta=
txbuf) < 0) {
> > +                       fprintf(stderr, "%s: statx(STATX_MNT_ID_UNIQUE)=
: %m\n", fname);
> > +                       return EXIT_FAILURE;
> > +               }
> > +               /*
> > +                * STATX_MNT_ID_UNIQUE was added fairly recently in Lin=
ux 6.8, so if the
> > +                * kernel doesn't give us a unique mount ID just skip i=
t.
> > +                */
> > +               if ((skip_mntid_unique |=3D !(statxbuf.stx_mask & STATX=
_MNT_ID_UNIQUE)))
> > +                       printf("statx(STATX_MNT_ID_UNIQUE) not supporte=
d by running kernel -- skipping unique mount ID test\n");
> > +               else
> > +                       statx_mntid_unique =3D statxbuf.stx_mnt_id;
> > +       }
> > +
> > +       fh->handle_bytes =3D bufsz;
> > +       ret =3D name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
> > +       if (bufsz < fh->handle_bytes) {
> > +               /* Query the filesystem required bufsz and the file han=
dle */
> > +               if (ret !=3D -1 || errno !=3D EOVERFLOW) {
> > +                       fprintf(stderr, "%s: unexpected result from nam=
e_to_handle_at: %d (%m)\n", fname, ret);
> > +                       return EXIT_FAILURE;
> > +               }
> > +               ret =3D name_to_handle_at(AT_FDCWD, fname, fh, &mntid_s=
hort, 0);
> > +       }
> > +       if (ret < 0) {
> > +               fprintf(stderr, "%s: name_to_handle: %m\n", fname);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       if (mntid_short !=3D (int) statx_mntid_short) {
> > +               fprintf(stderr, "%s: name_to_handle_at returned a diffe=
rent mount ID to STATX_MNT_ID: %u !=3D %lu\n", fname, mntid_short, statx_mn=
tid_short);
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       if (!skip_mntid_unique && statx_mntid_unique !=3D 0) {
> > +               struct handle dummy_fh;
> > +               uint64_t mntid_unique =3D 0;
> > +
> > +               /*
> > +                * Get the unique mount ID. We don't need to get anothe=
r copy of the
> > +                * handle so store it in a dummy struct.
> > +                */
> > +               dummy_fh.fh.handle_bytes =3D fh->handle_bytes;
> > +               ret =3D name_to_handle_at(AT_FDCWD, fname, &dummy_fh.fh=
, (int *) &mntid_unique, AT_HANDLE_MNT_ID_UNIQUE);
> > +               if (ret < 0) {
> > +                       if (errno !=3D EINVAL) {
> > +                               fprintf(stderr, "%s: name_to_handle_at(=
AT_HANDLE_MNT_ID_UNIQUE): %m\n", fname);
> > +                               return EXIT_FAILURE;
> > +                       }
> > +                       /*
> > +                        * EINVAL means AT_HANDLE_MNT_ID_UNIQUE is not =
supported, so skip
> > +                        * the check in that case.
> > +                        */
> > +                       printf("name_to_handle_at(AT_HANDLE_MNT_ID_UNIQ=
UE) not supported by running kernel -- skipping unique mount ID test\n");
> > +                       skip_mntid_unique =3D true;
> > +               } else {
> > +                       if (mntid_unique !=3D statx_mntid_unique) {
> > +                               fprintf(stderr, "%s: name_to_handle_at(=
AT_HANDLE_MNT_ID_UNIQUE) returned a different mount ID to STATX_MNT_ID_UNIQ=
UE: %lu !=3D %lu\n", fname, mntid_unique, statx_mntid_unique);
> > +                               return EXIT_FAILURE;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >         int     i, c;
> > @@ -132,7 +226,7 @@ int main(int argc, char **argv)
> >         char    fname2[PATH_MAX];
> >         char    *test_dir;
> >         char    *mount_dir;
> > -       int     mount_fd, mount_id;
> > +       int     mount_fd;
> >         char    *infile =3D NULL, *outfile =3D NULL;
> >         int     in_fd =3D 0, out_fd =3D 0;
> >         int     numfiles =3D 1;
> > @@ -307,21 +401,9 @@ int main(int argc, char **argv)
> >                                 return EXIT_FAILURE;
> >                         }
> >                 } else {
> > -                       handle[i].fh.handle_bytes =3D bufsz;
> > -                       ret =3D name_to_handle_at(AT_FDCWD, fname, &han=
dle[i].fh, &mount_id, 0);
> > -                       if (bufsz < handle[i].fh.handle_bytes) {
> > -                               /* Query the filesystem required bufsz =
and the file handle */
> > -                               if (ret !=3D -1 || errno !=3D EOVERFLOW=
) {
> > -                                       fprintf(stderr, "Unexpected res=
ult from name_to_handle_at(%s)\n", fname);
> > -                                       return EXIT_FAILURE;
> > -                               }
> > -                               ret =3D name_to_handle_at(AT_FDCWD, fna=
me, &handle[i].fh, &mount_id, 0);
> > -                       }
> > -                       if (ret < 0) {
> > -                               strcat(fname, ": name_to_handle");
> > -                               perror(fname);
> > +                       ret =3D do_name_to_handle_at(fname, &handle[i].=
fh, bufsz);
> > +                       if (ret < 0)
> >                                 return EXIT_FAILURE;
> > -                       }
> >                 }
> >                 if (keepopen) {
> >                         /* Open without close to keep unlinked files ar=
ound */
> > @@ -349,21 +431,9 @@ int main(int argc, char **argv)
> >                                 return EXIT_FAILURE;
> >                         }
> >                 } else {
> > -                       dir_handle.fh.handle_bytes =3D bufsz;
> > -                       ret =3D name_to_handle_at(AT_FDCWD, test_dir, &=
dir_handle.fh, &mount_id, 0);
> > -                       if (bufsz < dir_handle.fh.handle_bytes) {
> > -                               /* Query the filesystem required bufsz =
and the file handle */
> > -                               if (ret !=3D -1 || errno !=3D EOVERFLOW=
) {
> > -                                       fprintf(stderr, "Unexpected res=
ult from name_to_handle_at(%s)\n", dname);
> > -                                       return EXIT_FAILURE;
> > -                               }
> > -                               ret =3D name_to_handle_at(AT_FDCWD, tes=
t_dir, &dir_handle.fh, &mount_id, 0);
> > -                       }
> > -                       if (ret < 0) {
> > -                               strcat(dname, ": name_to_handle");
> > -                               perror(dname);
> > +                       ret =3D do_name_to_handle_at(test_dir, &dir_han=
dle.fh, bufsz);
> > +                       if (ret < 0)
> >                                 return EXIT_FAILURE;
> > -                       }
> >                 }
> >                 if (out_fd) {
> >                         ret =3D write(out_fd, (char *)&dir_handle, size=
of(*handle));
> > --
> > 2.46.0
> >

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xkptxxxh47nfrloo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZtavhAAKCRAol/rSt+lE
b1cGAP93SA9vWj5fkqzxNGBM90T1ufd/cRop3nq+mwExBswd7QEA8/SH0WeREpjx
Yqs+yCk/fqYD0/J7MXo9Z7cc96dWeA8=
=RoQr
-----END PGP SIGNATURE-----

--xkptxxxh47nfrloo--

