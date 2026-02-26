Return-Path: <linux-fsdevel+bounces-78624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOUFMWudoGlVlAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:22:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2221AE487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC3AB3046F4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7533C1996;
	Thu, 26 Feb 2026 19:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEK7WE+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531DB3603C5
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133134; cv=pass; b=SUPHjNE14siXdu0mKh5AgFPmcp6e9E+GV6pAJRJE1MIzI9BQv+ze/HuytIoVIM27gM+VUhDo9IRHcK/jor+TNUSG4eijYtF5xkcDq8APwrFQG0LWyKzgHogk7dNolnSVF0MjyOojWlvuvvzsjsrPnwvhHi1E0q1BM+Xt5PK2VOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133134; c=relaxed/simple;
	bh=Uc7WbgMVB/udrGq37f5VNegLOg2BQRF0XJJ9jXBZ33Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftYzOoAXuZNVBqRt84F2TruC+yKyWSvLk+CLE+H2irgck7aRnXARU8UBLwL2DVeu8bZiWiLt/lthib3unLnLEFXqA/zDf3wpnitOURsgQCcW/0qWPECveaLa/XxtdxlaMMDy6Co3P+C4aioG/oUvdR1CWG6Db+FQNhDS0xKcRpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEK7WE+1; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506251815a3so10373331cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 11:12:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772133131; cv=none;
        d=google.com; s=arc-20240605;
        b=lCyCUf2J0hSgR/dVDUUuOvcLSBemSClsEv5MIKV/7VpH/UGiUJD5iX/BvNnnvRPVTf
         CUmANTb+aKJO+462sGdUCyTqXur5tzV4JDfHUeBmrQguFxru14OlrYW142+hOF0BggER
         vwa6MntCDMSVZoyIr+Klg5Z1KJTMGk1IxGOU8lWm4hMb1f1dWpid3aaBOqbGK1ai4ARA
         OSUOjJdgLJXrFjghR117yNwjShJSRHMQAGZiFm8enUWVISJFiiGZfwFzvEhEPV0lip2y
         VYPunWwJScKhhwOzASTU/6CHkrxAS8/AduTZ9Emwp9yhHdYykI/o4C2sM/C8q2eIX7Dn
         Szow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4EEBmL5KBxI+KSECYqxoF7VO8+7e1awDT4mppzVmIJM=;
        fh=BAAZ4Jf3/VV6W/oAEPykx7nVsbkycY2MF0wBfGARfr8=;
        b=L8Tbq2/bCQdsV2EzT/U9m1vL8SeH7oSb+hhgtBwHrZFdUAV/3zrpvbfSdY9Is7qrlW
         4xuHfUzFu1NR5oIhmL2Ibq/X3rCoNDnE1v6g83rYb3y9SYTZCp2FKQOg9L7C+D/ImPDT
         pHTBpvyws7m7GvJ/N9axx5/2WavrzzeyKUrNi9I3WeGGLw5kqlvXnainHeSM8cXdTWrI
         8isSZE5E5wfcvc9OlJYL7quUlicAtQwCCFFA/Irkdnnu4wU4U9jfsRSTKgZEDBHRgSgo
         iZ898swweHdi7K225DY5pZ+UaLwjoZcx0Vmy6b+Df5TdzdkG56VdGZ2U/r9kvblGlKbQ
         /SoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772133131; x=1772737931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EEBmL5KBxI+KSECYqxoF7VO8+7e1awDT4mppzVmIJM=;
        b=UEK7WE+1TBbTNrVMoyf/CFxJyciUmCcXecz+Ff8Vl66+iXN5JeBCXGRflsDK2szAEa
         ZnXXpMNnogxj7LOkQlV3d+U6Jk0u6dXazfCAGmD57GRQgIxt2ZSM9ghIFbX/RMvCWt84
         MR1/1wTcXhHnlMwSCT7oOFNMkE7keHa+dMsljF3F3Jvh76rCd4isb+GyFS+Yp0VWUYey
         O2Q9/mEEUEotuypkTAq78P5DWszIzrDcrvz6Dat2oqkuPVwvCI+P/LbMtrsh1chduKLV
         CXAAuRhIH6qSbQeWURx+Y8YxEzjE6O4FhLp6pq3tVmqN9dWbsRLdpVW68C2woyWRknfl
         V7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772133131; x=1772737931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4EEBmL5KBxI+KSECYqxoF7VO8+7e1awDT4mppzVmIJM=;
        b=Qjr15v1J3dr7eUpakL89BCye7umZ27AfLLdwOwfUGzP4Cl8G232qv2mdT/4KYyXJLh
         vkpCe5s5DUicWsigAjsu0RAMgFofmqi0xVWQO35dZ/FIrIUoRqDelZHUwE46Sh4XxWvG
         ifd5JqOobFWAKAm9LZ3Kxlh/kWZ6KiSseBy2NrUazLDwaANXT50P7Gbbo5l8Otmk08X4
         5h1fBviQ12L8HazReAOIDPbr6Xcrtq9XaDJ8OfXTbqMP6Yv0sxiXGd49NFnY9C/BJVNm
         cH94wHtRgq3n5SQgFQEPZLEAQ07alFHLVsLlktkitwcpDmFz8i+x/V+QmoWI4rxOFRe1
         oJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHHN0MAUMf9TC8GXY74Co7clhSsC4w3aIuxTU2aEg5TD7iVFBunyIJjOtBLth0Z11ZovVGZ6iDO6sd3DVz@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIab8uwCrdSH91ETX8TR0nRUZgXNLmPb5nh2efk4PUIBKLM+X
	pDDpYI7q/VL7pFI0RJaWL2iITrUgMQCifvHtg7dkS0KkMtJQdz8+eA5RHGvfw45FsuoQ/Zkq+h1
	AG6l9DH/3E+spLJx3TPZRaLGHcIYB+OE=
X-Gm-Gg: ATEYQzy3qC2FhOsIVnG0yL/tUN+lySVSH/n5bca/pDxwTj0igPcLgbRlbAmBR7pK2LZ
	Fn0QKXe/eXpPshYJikiucAxprFZ9xfG7avu3PmwsjuIc4zfhXxozJ46skDaamHs5TRPUmvpoOdJ
	xLa8oYVDvkdkx19h9fvCApOWRe2Y4pA+rOAiss+1RcSYeD9AvHbxcyL6qd9/a6aEiw9cVux7ZjX
	EJ8NbOFButq3N6I0AGUVMcVjtCuLdt0K7CRm4fOCLvyMocdSayvg56gGGGTzB0BH1djp4+0ZQN7
	nkSsyA==
X-Received: by 2002:ac8:5e0c:0:b0:502:a3b:f367 with SMTP id
 d75a77b69052e-507529b4cbdmr15001cf.51.1772133131092; Thu, 26 Feb 2026
 11:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com> <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
In-Reply-To: <20260226-fuse-compounds-upstream-v6-3-8585c5fcd2fc@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Feb 2026 11:12:00 -0800
X-Gm-Features: AaiRm51LGTHPPATd9L_-sBOQR-iOhXIxy2aOF4ic8uX8mwrQ1jVDSQ1I5A6YxCg
Message-ID: <CAJnrk1ZsvtZh9vZoN=ca_wrs5enTfAQeNBYppOzZH=c+ARaP3Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] fuse: add an implementation of open+getattr
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78624-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,birthelmer.com:email,mail.gmail.com:mid,ddn.com:email]
X-Rspamd-Queue-Id: CC2221AE487
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 8:43=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> The discussion about compound commands in fuse was
> started over an argument to add a new operation that
> will open a file and return its attributes in the same operation.
>
> Here is a demonstration of that use case with compound commands.
>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
>  fs/fuse/file.c   | 111 +++++++++++++++++++++++++++++++++++++++++++++++--=
------
>  fs/fuse/fuse_i.h |   4 +-
>  fs/fuse/ioctl.c  |   2 +-
>  3 files changed, 99 insertions(+), 18 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index a408a9668abbb361e2c1e386ebab9dfcb0a7a573..daa95a640c311fc393241bdf7=
27e00a2bc714f35 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -136,8 +136,71 @@ static void fuse_file_put(struct fuse_file *ff, bool=
 sync)
>         }
>  }
>
> +static int fuse_compound_open_getattr(struct fuse_mount *fm, u64 nodeid,
> +                                     struct inode *inode, int flags, int=
 opcode,
> +                                     struct fuse_file *ff,
> +                                     struct fuse_attr_out *outattrp,
> +                                     struct fuse_open_out *outopenp)
> +{
> +       struct fuse_conn *fc =3D fm->fc;
> +       struct fuse_compound_req *compound;
> +       struct fuse_args open_args =3D {};
> +       struct fuse_args getattr_args =3D {};
> +       struct fuse_open_in open_in =3D {};
> +       struct fuse_getattr_in getattr_in =3D {};
> +       int err;
> +
> +       compound =3D fuse_compound_alloc(fm, 2, FUSE_COMPOUND_SEPARABLE);
> +       if (!compound)
> +               return -ENOMEM;
> +
> +       open_in.flags =3D flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> +       if (!fm->fc->atomic_o_trunc)
> +               open_in.flags &=3D ~O_TRUNC;
> +
> +       if (fm->fc->handle_killpriv_v2 &&
> +           (open_in.flags & O_TRUNC) && !capable(CAP_FSETID))
> +               open_in.open_flags |=3D FUSE_OPEN_KILL_SUIDGID;

Do you think it makes sense to move this chunk of logic into
fuse_open_args_fill() since this logic has to be done in
fuse_send_open() as well?

> +
> +       fuse_open_args_fill(&open_args, nodeid, opcode, &open_in, outopen=
p);
> +
> +       err =3D fuse_compound_add(compound, &open_args, NULL);
> +       if (err)
> +               goto out;
> +
> +       fuse_getattr_args_fill(&getattr_args, nodeid, &getattr_in, outatt=
rp);
> +
> +       err =3D fuse_compound_add(compound, &getattr_args, NULL);
> +       if (err)
> +               goto out;
> +
> +       err =3D fuse_compound_send(compound);
> +       if (err)
> +               goto out;
> +
> +       err =3D fuse_compound_get_error(compound, 0);
> +       if (err)
> +               goto out;
> +
> +       ff->fh =3D outopenp->fh;
> +       ff->open_flags =3D outopenp->open_flags;

It looks like this logic is shared between here and the non-compound
open path, maybe a bit better to just do this in fuse_file_open()
instead? That way we also don't need to pass the struct fuse_file *ff
as an arg either.

> +
> +       err =3D fuse_compound_get_error(compound, 1);
> +       if (err)
> +               goto out;

For this open+getattr case, if getattr fails but the open succeeds,
should this still succeed the open since they're separable requests? I
think we had a conversation about it in v4, but imo this case should.

> +
> +       fuse_change_attributes(inode, &outattrp->attr, NULL,
> +                              ATTR_TIMEOUT(outattrp),
> +                              fuse_get_attr_version(fc));
> +
> +out:
> +       fuse_compound_free(compound);
> +       return err;
> +}
> +
>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> -                                unsigned int open_flags, bool isdir)
> +                               struct inode *inode,

As I understand it, now every open() is a opengetattr() (except for
the ioctl path) but is this the desired behavior? for example if there
was a previous FUSE_LOOKUP that was just done, doesn't this mean
there's no getattr that's needed since the lookup refreshed the attrs?
or if the server has reasonable entry_valid and attr_valid timeouts,
multiple opens() of the same file would only need to send FUSE_OPEN
and not the FUSE_GETATTR, no?


> +                               unsigned int open_flags, bool isdir)
>  {
>         struct fuse_conn *fc =3D fm->fc;
>         struct fuse_file *ff;
> @@ -163,23 +226,40 @@ struct fuse_file *fuse_file_open(struct fuse_mount =
*fm, u64 nodeid,
>         if (open) {
>                 /* Store outarg for fuse_finish_open() */
>                 struct fuse_open_out *outargp =3D &ff->args->open_outarg;
> -               int err;
> +               int err =3D -ENOSYS;
>
> -               err =3D fuse_send_open(fm, nodeid, open_flags, opcode, ou=
targp);
> -               if (!err) {
> -                       ff->fh =3D outargp->fh;
> -                       ff->open_flags =3D outargp->open_flags;
> -               } else if (err !=3D -ENOSYS) {
> -                       fuse_file_free(ff);
> -                       return ERR_PTR(err);
> -               } else {
> -                       if (isdir) {
> +               if (inode) {
> +                       struct fuse_attr_out attr_outarg;
> +
> +                       err =3D fuse_compound_open_getattr(fm, nodeid, in=
ode,
> +                                                        open_flags, opco=
de, ff,
> +                                                        &attr_outarg, ou=
targp);

instead of passing in &attr_outarg, what about just having that moved
to fuse_compound_open_getattr()?

> +               }
> +
> +               if (err =3D=3D -ENOSYS) {
> +                       err =3D fuse_send_open(fm, nodeid, open_flags, op=
code,
> +                                            outargp);
> +                       if (!err) {
> +                               ff->fh =3D outargp->fh;
> +                               ff->open_flags =3D outargp->open_flags;
> +                       }
> +               }
> +
> +               if (err) {
> +                       if (err !=3D -ENOSYS) {
> +                               /* err is not ENOSYS */
> +                               fuse_file_free(ff);
> +                               return ERR_PTR(err);
> +                       } else {
>                                 /* No release needed */
>                                 kfree(ff->args);
>                                 ff->args =3D NULL;
> -                               fc->no_opendir =3D 1;
> -                       } else {
> -                               fc->no_open =3D 1;
> +
> +                               /* we don't have open */
> +                               if (isdir)
> +                                       fc->no_opendir =3D 1;
> +                               else
> +                                       fc->no_open =3D 1;

kfree(ff->args) and ff->args =3D NULL should not be called for the
!isdir case or it leads to the deadlock that was fixed in
https://lore.kernel.org/linux-fsdevel/20251010220738.3674538-2-joannelkoong=
@gmail.com/

I think if you have the "ff->fh =3D outargp..." and "ff->open_flags =3D
..." logic shared between fuse_compound_open_getattr() and
fuse_send_open() then the original errorr handling for this could just
be left as-is.

Thanks,
Joanne

>                         }
>                 }
>         }
> @@ -195,11 +275,10 @@ struct fuse_file *fuse_file_open(struct fuse_mount =
*fm, u64 nodeid,
>  int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
>                  bool isdir)
>  {
> -       struct fuse_file *ff =3D fuse_file_open(fm, nodeid, file->f_flags=
, isdir);
> +       struct fuse_file *ff =3D fuse_file_open(fm, nodeid, file_inode(fi=
le), file->f_flags, isdir);
>
>         if (!IS_ERR(ff))
>                 file->private_data =3D ff;
> -
>         return PTR_ERR_OR_ZERO(ff);
>  }
>  EXPORT_SYMBOL_GPL(fuse_do_open);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index ff8222b66c4f7b04c0671a980237a43871affd0a..40409a4ab016a061eea20afee=
76c8a7fe9c15adb 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1588,7 +1588,9 @@ void fuse_file_io_release(struct fuse_file *ff, str=
uct inode *inode);
>
>  /* file.c */
>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
> -                                unsigned int open_flags, bool isdir);
> +                                                               struct in=
ode *inode,
> +                                                               unsigned =
int open_flags,
> +                                                               bool isdi=
r);
>  void fuse_file_release(struct inode *inode, struct fuse_file *ff,
>                        unsigned int open_flags, fl_owner_t id, bool isdir=
);
>
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index fdc175e93f74743eb4d2e5a4bc688df1c62e64c4..07a02e47b2c3a68633d213675=
a8cc380a0cf31d8 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -494,7 +494,7 @@ static struct fuse_file *fuse_priv_ioctl_prepare(stru=
ct inode *inode)
>         if (!S_ISREG(inode->i_mode) && !isdir)
>                 return ERR_PTR(-ENOTTY);
>
> -       return fuse_file_open(fm, get_node_id(inode), O_RDONLY, isdir);
> +       return fuse_file_open(fm, get_node_id(inode), NULL, O_RDONLY, isd=
ir);
>  }
>
>  static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_fil=
e *ff)
>
> --
> 2.53.0
>

