Return-Path: <linux-fsdevel+bounces-75308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIOcCH3Ec2kpygAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 19:57:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBF79E53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 19:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A4AD3004413
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD0B26B2D2;
	Fri, 23 Jan 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrcQUD0Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5281DDC33
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194588; cv=pass; b=c4l6T3HVfWLCKWOPzL3oyzvMegOykYPFbsQdzY+cKMiVm2ws9sbRj8sYr2xmePMGR3u6D3aXyUMTg2JV7M7HqfUTxCA+QeCqVycw5HpFyrp2zqvuqQ2Ro0hzWSb/Sjrud4r4dbwyQ6+78YobgW2URfYtpwrzB7HCHkTpnLIrhAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194588; c=relaxed/simple;
	bh=qvDn2dd6cXcs2qCT2fe8qTWKWIvL3O/EeSyyoze2as0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9Iboh/oDHfDP2NZpllt9mhapyzoKkEkEiqaRjvoDgCa5zxdpailel4vVtTA92OO03c5m4eJoMkFKPKd+R8fWKUIs9dAPLKbgLW+uZ4VK4yYbTKPPhS2C6OiilvsK5Sne2jmRGPzGMx3Pf+vQId631rCs4PLADe9YgPLWhPbELc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrcQUD0Y; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014e8a42aeso38162071cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 10:56:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769194585; cv=none;
        d=google.com; s=arc-20240605;
        b=BKT/cuyjbnzNLD5TIwp0+XbzGpG9SZKjTF3kPe1dZ5SASenlfy712oVqEWcUHu8yZs
         0O2yRMMDkckvc9ssFrq5ruvZLUPDU6ciWe78blvB/577j896ymyPhJsX9AP86QAEJgDV
         Q9GP2F7uPJO5iQtmv1/+USf7T3o6LUeprRKNdslEylzDekfc+TcUdIaiHPIrIBfXDA6l
         LFtd7zy1MYoIuAxIlMqb4OdePpfkYIVw17oysOvjnY3tTWmttHCXzUoN1oqgIquiwjdU
         gafuaImEOFZsPWhyzhF4AeqIsZTAR6YN3pHH1r9LvjISPIihkLceuJVGVhl0xCLSZuyF
         CHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k2g0WbT5A3qq/uwHKvs0HzddcBD+so7zYKx4wXJqdMI=;
        fh=ifuhLxHQU5bY/fLoGQnR6ksjdlXM3ieUzHDdNDgdODA=;
        b=O8cBQt/cpJIa0luV+LeGdQh7JAtrZCCMyKL8sx2Zk/30tYF79Mv4b710oZlqfskw5N
         kHyWO575ntlK4Hpc5FjE+lceGJCeMHIxV/5r/hkeh7vHiH0wtL2uuFwQxWx8JgFgWuzo
         SQRVqeJpJ6u2Q8lfJuOMZGAD7gFlnrSksMFj3uP0NrALQYK0K++SCrWphFQIZ7xom5i7
         OpOybpYnQeH9g7Ooc44cQCZaM+wpWy86RYudS75tnYAc96+Jw8LdyvVFykvJnCp9uf0G
         myXDL580HxBL668h9aUnhhoSQUgF73tDlMB/x+Za1z2QG1yJughtOiTFhZ/Ob4ZdZ2T5
         fkzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194585; x=1769799385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2g0WbT5A3qq/uwHKvs0HzddcBD+so7zYKx4wXJqdMI=;
        b=ZrcQUD0YQQZW1mGBtMNWCIPtknzfhK1F+WnF6oWK46yOHHFdo8yKXROn1w1GTOoKUU
         bj4iaZSuy8irIXzwhwSr53jyEw7jWycP8+lPm68e5rLYBkl+0hmFpbYPjOXCUFU93DuI
         SxHDjBxuhtX5Tjz5JYu5TgdSlE7Dhm3uJ1TPngKMQ8X9mwjisJWFtl9Se3dX6qVlWa5t
         o6liZE2SmDf1W1hsvPuIi4smxFgJjhW/uzfskq53v+bhf3XYELvUjOPgFNpUJgGcMkEa
         xZWRu7TtIN1X0pZKINkXPGfC48KlvNLpYeS+9KPwsomnGuo712f7++yB2pDH93gS9iI9
         LT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194585; x=1769799385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k2g0WbT5A3qq/uwHKvs0HzddcBD+so7zYKx4wXJqdMI=;
        b=mcLqvNUqE9QZqym8dyx4RpvUJRLWnHi1HuqzSDCwdqeO8EyydFLdqfF7HMM+vNHPbQ
         Gq1nDAMdQyDG390NCCexX1LJibJYi1F/ltDcCyrTjW3LRJzNao0bcT2SpR5/SzmsSsRf
         YSrHzNNx4CtvZwJPfmmkWz6oZ0mlLmKN5AA/nD9QSqKTRGu1TBpbeXjNXqYac+1R9Yo4
         Q9oy7nyjSdVj/STL5GocPKGeacVPIlXEPNTEudn24MhIvbr9byx7HK0l33gfL3WgI6j6
         sg3qmw5uIZnu4/gn/naK48FCLnXz3L1PsPE1iVrbQGmN/kqgsGQTpf/JQjaw3Axf44O/
         uBPw==
X-Forwarded-Encrypted: i=1; AJvYcCU+RJNP+gcf1GqhStqO1cp8D2yZPCY5PUGDL2koqv5wGoJBDWoR0UZCC6yvj/JTi1V/MmdqcF3fC+RtFZdA@vger.kernel.org
X-Gm-Message-State: AOJu0YyRF63WOxw5fGezyNoMhd4jYQeaQDscjwN07j6Jnl6bNlQ/aq47
	ofufkjmav/1nwxMxE6ZoTJ7BXIu7olezzzp1EuqgC5wtqkzUlFVXGT+EBz24npqvmDB77wpwT3E
	fuEXqLAcCel9/UzRkVoZc9LzptBqUJZ8=
X-Gm-Gg: AZuq6aLM8IAKBx830A81fipsBnGJmR0IypfNSr5dG0mU0P01gixlhj6wm28wexAwm4K
	tOWQCqYdtQbnFpUonLQQ15mVyOSAHT3TpbJ1F+I1FRZVlwQBPkvKodQu8KzeuQNlAYZ2pmaIb6k
	jAC+VRewjg5JLdhSoKUtvlKseM5VmbxHfH+O4RbMKmfivd1v3ERdtcZM6KFX+d9hpzVRsVmcjd1
	2ZHjrA8XeeiHEWz6uKkFe7dbBFWbC5Ep6aUI9pSuEFLTkdtQqHpDxU/3bVjRAQT7Q8rlA==
X-Received: by 2002:a05:622a:1988:b0:4ee:9b1:e2b with SMTP id
 d75a77b69052e-502f770bb81mr55970411cf.6.1769194585269; Fri, 23 Jan 2026
 10:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810612.1424854.16053093294573829123.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810612.1424854.16053093294573829123.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 23 Jan 2026 10:56:14 -0800
X-Gm-Features: AZwV_QhDNuCMuEXs2XxfaawYkKNfd4dudrezfwIQMLyO5eoBwSPwwAixb24l4O8
Message-ID: <CAJnrk1Yo82LgK2_NSswSiY+YxoxKh71GDTeQSVs1Tf5sgLHEMA@mail.gmail.com>
Subject: Re: [PATCH 12/31] fuse: implement direct IO with iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75308-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DBBF79E53
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:48=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Start implementing the fuse-iomap file I/O paths by adding direct I/O
> support and all the signalling flags that come with it.  Buffered I/O
> is much more complicated, so we leave that to a subsequent patch.

Overall, this makes sense to me. Left a few comments below.

>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h          |   30 +++++
>  include/uapi/linux/fuse.h |   22 ++++
>  fs/fuse/dir.c             |    7 +
>  fs/fuse/file.c            |   16 +++
>  fs/fuse/file_iomap.c      |  249 +++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/trace.c           |    1
>  6 files changed, 323 insertions(+), 2 deletions(-)
>
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index e949bfe022c3b0..be0e95924a24af 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -672,6 +672,7 @@ enum fuse_opcode {
>         FUSE_STATX              =3D 52,
>         FUSE_COPY_FILE_RANGE_64 =3D 53,
>
> +       FUSE_IOMAP_IOEND        =3D 4093,
>         FUSE_IOMAP_BEGIN        =3D 4094,
>         FUSE_IOMAP_END          =3D 4095,
>
> @@ -1406,4 +1407,25 @@ struct fuse_iomap_end_in {
>         struct fuse_iomap_io    map;
>  };
>
> +/* out of place write extent */
> +#define FUSE_IOMAP_IOEND_SHARED                (1U << 0)
> +/* unwritten extent */
> +#define FUSE_IOMAP_IOEND_UNWRITTEN     (1U << 1)
> +/* don't merge into previous ioend */
> +#define FUSE_IOMAP_IOEND_BOUNDARY      (1U << 2)
> +/* is direct I/O */
> +#define FUSE_IOMAP_IOEND_DIRECT                (1U << 3)
> +/* is append ioend */
> +#define FUSE_IOMAP_IOEND_APPEND                (1U << 4)
> +
> +struct fuse_iomap_ioend_in {
> +       uint32_t ioendflags;    /* FUSE_IOMAP_IOEND_* */

Hmm, maybe just "flags" is descriptive enough? Or if not, then "ioend_flags=
"?

> +       int32_t error;          /* negative errno or 0 */
> +       uint64_t attr_ino;      /* matches fuse_attr:ino */
> +       uint64_t pos;           /* file position, in bytes */
> +       uint64_t new_addr;      /* disk offset of new mapping, in bytes *=
/
> +       uint32_t written;       /* bytes processed */

Is uint32_t enough here or does it need to be bigger? Asking mostly
because I see in fuse_iomap_ioend() that the written passed in is
size_t.

> +       uint32_t reserved1;     /* zero */
> +};
> +
>  #endif /* _LINUX_FUSE_H */
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index bafc386f2f4d3a..171f38ba734d16 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -712,6 +712,10 @@ static int fuse_create_open(struct mnt_idmap *idmap,=
 struct inode *dir,
>         if (err)
>                 goto out_acl_release;
>         fuse_dir_changed(dir);
> +
> +       if (fuse_inode_has_iomap(inode))
> +               fuse_iomap_open(inode, file);
> +
>         err =3D generic_file_open(inode, file);
>         if (!err) {
>                 file->private_data =3D ff;
> @@ -1743,6 +1747,9 @@ static int fuse_dir_open(struct inode *inode, struc=
t file *file)
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> +       if (fuse_inode_has_iomap(inode))
> +               fuse_iomap_open(inode, file);
> +
>         err =3D generic_file_open(inode, file);
>         if (err)
>                 return err;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 8a981f41b1dbd0..43007cea550ae7 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -246,6 +246,9 @@ static int fuse_open(struct inode *inode, struct file=
 *file)
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> +       if (is_iomap)
> +               fuse_iomap_open(inode, file);
> +

AFAICT, there aren't any calls to generic_file_open() where we don't
also do this "if (is_iomap) ..." check, so maybe we should just put
this logic inside generic_file_open()?

>         err =3D generic_file_open(inode, file);
>         if (err)
>                 return err;
> @@ -1751,10 +1754,17 @@ static ssize_t fuse_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
>         struct file *file =3D iocb->ki_filp;
>         struct fuse_file *ff =3D file->private_data;
>         struct inode *inode =3D file_inode(file);
> +       ssize_t ret;
>
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> +       if (fuse_want_iomap_directio(iocb)) {

In fuse, directio is also done if the server sets FOPEN_DIRECT_IO as
part of the struct fuse_open_out open_flags arg, even if
iocb->ki_flags  doesn't have IOCB_DIRECT set.

> +               ret =3D fuse_iomap_direct_read(iocb, to);
> +               if (ret !=3D -ENOSYS)

Hmm, where does fuse_iomap_direct_read() return -ENOSYS? afaict,
neither fuse_iomap_ilock_iocb() nor iomap_dio_rw() do?

> +                       return ret;
> +       }

I see that later on, in the patch that adds the implementation for
buffered IO with iomap, this logic later becomes something like

        if (fuse_want_iomap_directio(iocb)) {
                ...
        }

        if (fuse_want_iomap_buffered_io(iocb))
                return fuse_iomap_buffered_read(iocb, to);

imo (if -ENOSYS is indeed not possible) something like this is maybe cleane=
r:

        if (fuse_inode_has_iomap(inode))
                 fuse_iomap_read_iter(iocb, to);

to move as much iomap-specific logic away from generic fuse files?

And then I think this would also let us get rid of the
fuse_want_iomap_directio()/fuse_want_iomap_buffered_io() helpers, eg:

ssize_t fuse_iomap_read_iter(struct kiocb *iocb, struct iov_iter *to) {
         if (iocb->ki_flags & IOCB_DIRECT)
                  return fuse_iomap_direct_read(iocb, to);
         return fuse_iomap_buffered_read(iocb, to);
}

> +
>         if (FUSE_IS_DAX(inode))
>                 return fuse_dax_read_iter(iocb, to);
>
> @@ -1776,6 +1786,12 @@ static ssize_t fuse_file_write_iter(struct kiocb *=
iocb, struct iov_iter *from)
>         if (fuse_is_bad(inode))
>                 return -EIO;
>
> +       if (fuse_want_iomap_directio(iocb)) {
> +               ssize_t ret =3D fuse_iomap_direct_write(iocb, from);
> +               if (ret !=3D -ENOSYS)
> +                       return ret;
> +       }

Same questions as above about -ENOSYS
> +
>         if (FUSE_IS_DAX(inode))
>                 return fuse_dax_write_iter(iocb, from);
>
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index c63527cec0448b..4db2acd8bc9925 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -495,10 +495,15 @@ static int fuse_iomap_begin(struct inode *inode, lo=
ff_t pos, loff_t count,
>  }
>
>  /* Decide if we send FUSE_IOMAP_END to the fuse server */
> -static bool fuse_should_send_iomap_end(const struct iomap *iomap,
> +static bool fuse_should_send_iomap_end(const struct fuse_mount *fm,
> +                                      const struct iomap *iomap,
>                                        unsigned int opflags, loff_t count=
,
>                                        ssize_t written)
>  {
> +       /* Not implemented on fuse server */
> +       if (fm->fc->iomap_conn.no_end)
> +               return false;
> +
>         /* fuse server demanded an iomap_end call. */
>         if (iomap->flags & FUSE_IOMAP_F_WANT_IOMAP_END)
>                 return true;
> @@ -523,7 +528,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t=
 pos, loff_t count,
>         struct fuse_mount *fm =3D get_fuse_mount(inode);
>         int err =3D 0;
>
> -       if (fuse_should_send_iomap_end(iomap, opflags, count, written)) {
> +       if (fuse_should_send_iomap_end(fm, iomap, opflags, count, written=
)) {
>                 struct fuse_iomap_end_in inarg =3D {
>                         .opflags =3D fuse_iomap_op_to_server(opflags),
>                         .attr_ino =3D fi->orig_ino,
> @@ -549,6 +554,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t=
 pos, loff_t count,
>                          * libfuse returns ENOSYS for servers that don't
>                          * implement iomap_end
>                          */
> +                       fm->fc->iomap_conn.no_end =3D 1;
>                         err =3D 0;
>                         break;
>                 case 0:
> @@ -567,6 +573,95 @@ static const struct iomap_ops fuse_iomap_ops =3D {
>         .iomap_end              =3D fuse_iomap_end,
>  };
>
> +static inline bool
> +fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
> +                            const struct fuse_iomap_ioend_in *inarg)
> +{
> +       /* Not implemented on fuse server */
> +       if (fm->fc->iomap_conn.no_ioend)
> +               return false;
> +
> +       /* Always send an ioend for errors. */
> +       if (inarg->error)
> +               return true;
> +
> +       /* Send an ioend if we performed an IO involving metadata changes=
. */
> +       return inarg->written > 0 &&
> +              (inarg->ioendflags & (FUSE_IOMAP_IOEND_SHARED |
> +                                    FUSE_IOMAP_IOEND_UNWRITTEN |
> +                                    FUSE_IOMAP_IOEND_APPEND));
> +}
> +
> +/*
> + * Fast and loose check if this write could update the on-disk inode siz=
e.
> + */
> +static inline bool fuse_ioend_is_append(const struct fuse_inode *fi,
> +                                       loff_t pos, size_t written)
> +{
> +       return pos + written > i_size_read(&fi->inode);
> +}
> +
> +static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t writ=
ten,
> +                           int error, unsigned ioendflags, sector_t new_=
addr)
> +{
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +       struct fuse_mount *fm =3D get_fuse_mount(inode);
> +       struct fuse_iomap_ioend_in inarg =3D {
> +               .ioendflags =3D ioendflags,
> +               .error =3D error,
> +               .attr_ino =3D fi->orig_ino,
> +               .pos =3D pos,
> +               .written =3D written,
> +               .new_addr =3D new_addr,
> +       };
> +
> +       if (fuse_ioend_is_append(fi, pos, written))
> +               inarg.ioendflags |=3D FUSE_IOMAP_IOEND_APPEND;
> +
> +       if (fuse_should_send_iomap_ioend(fm, &inarg)) {
> +               FUSE_ARGS(args);
> +               int err;
> +
> +               args.opcode =3D FUSE_IOMAP_IOEND;
> +               args.nodeid =3D get_node_id(inode);
> +               args.in_numargs =3D 1;
> +               args.in_args[0].size =3D sizeof(inarg);
> +               args.in_args[0].value =3D &inarg;
> +               err =3D fuse_simple_request(fm, &args);
> +               switch (err) {
> +               case -ENOSYS:
> +                       /*
> +                        * fuse servers can return ENOSYS if ioend proces=
sing
> +                        * is never needed for this filesystem.
> +                        */
> +                       fm->fc->iomap_conn.no_ioend =3D 1;
> +                       err =3D 0;

It doesn't look like we need to set err here or maybe I'm missing something

> +                       break;
> +               case 0:
> +                       break;
> +               default:
> +                       /*
> +                        * If the write IO failed, return the failure cod=
e to
> +                        * the caller no matter what happens with the ioe=
nd.
> +                        * If the write IO succeeded but the ioend did no=
t,
> +                        * pass the new error up to the caller.
> +                        */
> +                       if (!error)
> +                               error =3D err;
> +                       break;
> +               }
> +       }
> +       if (error)
> +               return error;
> +
> +       /*
> +        * If there weren't any ioend errors, update the incore isize, wh=
ich

Not sure if incore is a standard term, but it had me confused for a
bit. I think incore just means kernel-internal?

> +        * confusingly takes the new i_size as "pos".
> +        */
> +       fuse_write_update_attr(inode, pos + written, written);
> +       return 0;
> +}
> +
>  static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags=
)
>  {
>         if (!fc->iomap)
> @@ -618,6 +713,8 @@ void fuse_iomap_mount(struct fuse_mount *fm)
>          * freeze/thaw properly.
>          */
>         fc->sync_fs =3D true;
> +       fc->iomap_conn.no_end =3D 0;
> +       fc->iomap_conn.no_ioend =3D 0;

fc after it's first allocated has all its fields memset to 0

>  }
>
>  void fuse_iomap_unmount(struct fuse_mount *fm)
> @@ -760,3 +857,151 @@ loff_t fuse_iomap_lseek(struct file *file, loff_t o=
ffset, int whence)
>                 return offset;
>         return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
>  }
> +
> +void fuse_iomap_open(struct inode *inode, struct file *file)
> +{
> +       ASSERT(fuse_inode_has_iomap(inode));
> +
> +       file->f_mode |=3D FMODE_NOWAIT | FMODE_CAN_ODIRECT;
> +}
> +
> +enum fuse_ilock_type {
> +       SHARED,
> +       EXCL,
> +};
> +
> +static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
> +                                enum fuse_ilock_type type)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +
> +       if (iocb->ki_flags & IOCB_NOWAIT) {
> +               switch (type) {
> +               case SHARED:
> +                       return inode_trylock_shared(inode) ? 0 : -EAGAIN;
> +               case EXCL:
> +                       return inode_trylock(inode) ? 0 : -EAGAIN;
> +               default:
> +                       ASSERT(0);
> +                       return -EIO;
> +               }
> +       } else {

nit: the else {} scoping doesn't seem needed here

> +               switch (type) {
> +               case SHARED:
> +                       inode_lock_shared(inode);
> +                       break;
> +               case EXCL:
> +                       inode_lock(inode);
> +                       break;
> +               default:
> +                       ASSERT(0);
> +                       return -EIO;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +ssize_t fuse_iomap_direct_read(struct kiocb *iocb, struct iov_iter *to)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +       ssize_t ret;
> +
> +       ASSERT(fuse_inode_has_iomap(inode));
> +
> +       if (!iov_iter_count(to))
> +               return 0; /* skip atime */
> +
> +       file_accessed(iocb->ki_filp);

Does it make sense for this to be moved below so it's called only if
fuse_iomap_ilock_iocb() succeeded?

> +
> +       ret =3D fuse_iomap_ilock_iocb(iocb, SHARED);
> +       if (ret)
> +               return ret;
> +       ret =3D iomap_dio_rw(iocb, to, &fuse_iomap_ops, NULL, 0, NULL, 0)=
;
> +       inode_unlock_shared(inode);
> +
> +       return ret;
> +}
> +
> +static int fuse_iomap_dio_write_end_io(struct kiocb *iocb, ssize_t writt=
en,
> +                                      int error, unsigned dioflags)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +       unsigned int nofs_flag;
> +       unsigned int ioendflags =3D FUSE_IOMAP_IOEND_DIRECT;
> +       int ret;
> +
> +       if (fuse_is_bad(inode))
> +               return -EIO;
> +
> +       ASSERT(fuse_inode_has_iomap(inode));
> +
> +       if (dioflags & IOMAP_DIO_COW)
> +               ioendflags |=3D FUSE_IOMAP_IOEND_SHARED;
> +       if (dioflags & IOMAP_DIO_UNWRITTEN)
> +               ioendflags |=3D FUSE_IOMAP_IOEND_UNWRITTEN;
> +
> +       /*
> +        * We can allocate memory here while doing writeback on behalf of
> +        * memory reclaim.  To avoid memory allocation deadlocks set the
> +        * task-wide nofs context for the following operations.
> +        */
> +       nofs_flag =3D memalloc_nofs_save();

I'm a bit confused by this part. Could you explain how it's invoked
while doing writeback for memory reclaim? As I understand it,
writeback goes through buffered io and not direct io?

> +       ret =3D fuse_iomap_ioend(inode, iocb->ki_pos, written, error, ioe=
ndflags,
> +                              FUSE_IOMAP_NULL_ADDR);
> +       memalloc_nofs_restore(nofs_flag);
> +       return ret;
> +}
> +
> +static const struct iomap_dio_ops fuse_iomap_dio_write_ops =3D {
> +       .end_io         =3D fuse_iomap_dio_write_end_io,
> +};
> +
> +ssize_t fuse_iomap_direct_write(struct kiocb *iocb, struct iov_iter *fro=
m)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +       loff_t blockmask =3D i_blocksize(inode) - 1;
> +       size_t count =3D iov_iter_count(from);
> +       unsigned int flags =3D 0;
> +       ssize_t ret;
> +
> +       ASSERT(fuse_inode_has_iomap(inode));
> +
> +       if (!count)
> +               return 0;
> +
> +       /*
> +        * Unaligned direct writes require zeroing of unwritten head and =
tail
> +        * blocks.  Extending writes require zeroing of post-EOF tail blo=
cks.
> +        * The zeroing writes must complete before we return the direct w=
rite
> +        * to userspace.  Don't even bother trying the fast path.
> +        */
> +       if ((iocb->ki_pos | count) & blockmask)
> +               flags =3D IOMAP_DIO_FORCE_WAIT;
> +
> +       ret =3D fuse_iomap_ilock_iocb(iocb, EXCL);
> +       if (ret)
> +               goto out_dsync;

I wonder if we need the out_dsync goto at all. Maybe just return ret
here directly?

> +       ret =3D generic_write_checks(iocb, from);
> +       if (ret <=3D 0)
> +               goto out_unlock;
> +
> +       /*
> +        * If we are doing exclusive unaligned I/O, this must be the only=
 I/O
> +        * in-flight.  Otherwise we risk data corruption due to unwritten
> +        * extent conversions from the AIO end_io handler.  Wait for all =
other
> +        * I/O to drain first.
> +        */
> +       if (flags & IOMAP_DIO_FORCE_WAIT)
> +               inode_dio_wait(inode);
> +

Should we add a file_modified() call here?

> +       ret =3D iomap_dio_rw(iocb, from, &fuse_iomap_ops,
> +                          &fuse_iomap_dio_write_ops, flags, NULL, 0);
> +       if (ret)
> +               goto out_unlock;

I think we could get rid of this if (ret) check

> +
> +out_unlock:
> +       inode_unlock(inode);
> +out_dsync:
> +       return ret;
> +}
> diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
> index 68d2eecb8559a5..300985d62a2f9b 100644
> --- a/fs/fuse/trace.c
> +++ b/fs/fuse/trace.c
> @@ -9,6 +9,7 @@
>  #include "iomap_i.h"
>
>  #include <linux/pagemap.h>
> +#include <linux/iomap.h>

Was this meant to be part of the subsequent trace.h patch? I haven't
tried compiling this though so maybe I' mmissing something but I'm not
seeing which part of the logic above needs this.

Thanks,
Joanne
>
>  #define CREATE_TRACE_POINTS
>  #include "fuse_trace.h"
>

