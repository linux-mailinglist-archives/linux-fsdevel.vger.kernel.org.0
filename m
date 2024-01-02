Return-Path: <linux-fsdevel+bounces-7126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F961821EF9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 16:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BEB283AE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736E14AAC;
	Tue,  2 Jan 2024 15:42:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48C14A92;
	Tue,  2 Jan 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so4736911fa.0;
        Tue, 02 Jan 2024 07:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704210131; x=1704814931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEi6eztajvdH1SfIE7fhB1vy4RNQCLa1wmwHBQHFKBE=;
        b=g5KcRiNtl0y42uIGJeiBGMPdNyVvGpZxJTsyhWqjEZgWnfWm1z3mA3k1ug28v46yBq
         XPhVVW1SErnrXtzOUK+hyKkvP4HQqdfyMoeijje3yHpsXbVcpn0sXpM+Ur/RDps7ep2h
         dovyY/0ZZxoho6b7KiNMFJjexGmLEWE5acPvjpyE+Wh97PdCD3SqHHC/MnuXF+qpkau9
         ab5WOefXRWSxhZNT+XySk/qsOr8zBnTlrWstYB+L+GaS3KZzzt/fzNKo6P7kwJim8XAH
         fKWsFMqckYPlcpdsAWF3pRL4YWD3WD4Of3LX2F4BiCSpc5Qua0B4E3xTuUBaGgD4oBzl
         5QZA==
X-Gm-Message-State: AOJu0YzPrXrM8+5MNpl6PMX7MVegk5lQhJEv5TxGKBq4D1IfrlLZaTiO
	VCzxHI9gOc4PSFwY0ddmwT2Wk6yOLeE=
X-Google-Smtp-Source: AGHT+IFq1YVMRmlB6w09U0C9fCSZ+WkvNpHMSudszz84giuPe5dNEKREoMfMthnV5UWGEz0XP9FriA==
X-Received: by 2002:a05:651c:10a3:b0:2cc:7159:d466 with SMTP id k3-20020a05651c10a300b002cc7159d466mr7131066ljn.25.1704210130996;
        Tue, 02 Jan 2024 07:42:10 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id h16-20020aa7c950000000b0055534d5e75csm9214019edt.6.2024.01.02.07.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 07:42:10 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a287be6dbc0so9155266b.1;
        Tue, 02 Jan 2024 07:42:10 -0800 (PST)
X-Received: by 2002:a17:906:183:b0:a28:268d:8d7a with SMTP id
 3-20020a170906018300b00a28268d8d7amr861021ejb.135.1704210130577; Tue, 02 Jan
 2024 07:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <140431.1704208899@warthog.procyon.org.uk>
In-Reply-To: <140431.1704208899@warthog.procyon.org.uk>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Tue, 2 Jan 2024 11:41:59 -0400
X-Gmail-Original-Message-ID: <CAB9dFdvGN=fkuFK++V6ovvCXCQBecQ+JVCh=a8tLzmgVqkk==w@mail.gmail.com>
Message-ID: <CAB9dFdvGN=fkuFK++V6ovvCXCQBecQ+JVCh=a8tLzmgVqkk==w@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix error handling with lookup via FS.InlineBulkStatus
To: David Howells <dhowells@redhat.com>
Cc: Jeffrey Altman <jaltman@auristor.com>, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:21=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> When afs does a lookup, it tries to use FS.InlineBulkStatus to preemptive=
ly
> look up a bunch of files in the parent directory and cache this locally, =
on
> the basis that we might want to look at them too (for example if someone
> does an ls on a directory, they may want want to then stat every file
> listed).
>
> FS.InlineBulkStatus can be considered a compound op with the normal abort
> code applying to the compound as a whole.  Each status fetch within the
> compound is then given its own individual abort code - but assuming no
> error that prevents the bulk fetch from returning the compound result wil=
l
> be 0, even if all the constituent status fetches failed.
>
> At the conclusion of afs_do_lookup(), we should use the abort code from t=
he
> appropriate status to determine the error to return, if any - but instead
> it is assumed that we were successful if the op as a whole succeeded and =
we
> return an incompletely initialised inode, resulting in ENOENT, no matter
> the actual reason.  In the particular instance reported, a vnode with no
> permission granted to be accessed is being given a UAEACCES abort code
> which should be reported as EACCES, but is instead being reported as
> ENOENT.
>
> Fix this by abandoning the inode (which will be cleaned up with the op) i=
f
> file[1] has an abort code indicated and turn that abort code into an erro=
r
> instead.
>
> Whilst we're at it, add a tracepoint so that the abort codes of the
> individual subrequests of FS.InlineBulkStatus can be logged.  At the mome=
nt
> only the container abort code can be 0.
>
> Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" con=
cept")
> Reported-by: Jeffrey Altman <jaltman@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/dir.c               |   12 +++++++++---
>  include/trace/events/afs.h |   25 +++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index c14533ef108f..ae563d2a914e 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -708,6 +708,8 @@ static void afs_do_lookup_success(struct afs_operatio=
n *op)
>                         break;
>                 }
>
> +               if (vp->scb.status.abort_code)
> +                       trace_afs_bulkstat_error(op, &vp->fid, i, vp->scb=
.status.abort_code);
>                 if (!vp->scb.have_status && !vp->scb.have_error)
>                         continue;
>
> @@ -897,12 +899,16 @@ static struct inode *afs_do_lookup(struct inode *di=
r, struct dentry *dentry,
>                 afs_begin_vnode_operation(op);
>                 afs_wait_for_operation(op);
>         }
> -       inode =3D ERR_PTR(afs_op_error(op));
>
>  out_op:
>         if (!afs_op_error(op)) {
> -               inode =3D &op->file[1].vnode->netfs.inode;
> -               op->file[1].vnode =3D NULL;
> +               if (op->file[1].scb.status.abort_code) {
> +                       afs_op_accumulate_error(op, -ECONNABORTED,
> +                                               op->file[1].scb.status.ab=
ort_code);
> +               } else {
> +                       inode =3D &op->file[1].vnode->netfs.inode;
> +                       op->file[1].vnode =3D NULL;
> +               }
>         }
>
>         if (op->file[0].scb.have_status)
> diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
> index 5194b7e6dc8d..ce865ea678d3 100644
> --- a/include/trace/events/afs.h
> +++ b/include/trace/events/afs.h
> @@ -1102,6 +1102,31 @@ TRACE_EVENT(afs_file_error,
>                       __print_symbolic(__entry->where, afs_file_errors))
>             );
>
> +TRACE_EVENT(afs_bulkstat_error,
> +           TP_PROTO(struct afs_operation *op, struct afs_fid *fid, unsig=
ned int index, s32 abort),
> +
> +           TP_ARGS(op, fid, index, abort),
> +
> +           TP_STRUCT__entry(
> +                   __field_struct(struct afs_fid,      fid)
> +                   __field(unsigned int,               op)
> +                   __field(unsigned int,               index)
> +                   __field(s32,                        abort)
> +                            ),
> +
> +           TP_fast_assign(
> +                   __entry->op =3D op->debug_id;
> +                   __entry->fid =3D *fid;
> +                   __entry->index =3D index;
> +                   __entry->abort =3D abort;
> +                          ),
> +
> +           TP_printk("OP=3D%08x[%02x] %llx:%llx:%x a=3D%d",
> +                     __entry->op, __entry->index,
> +                     __entry->fid.vid, __entry->fid.vnode, __entry->fid.=
unique,
> +                     __entry->abort)
> +           );
> +
>  TRACE_EVENT(afs_cm_no_server,
>             TP_PROTO(struct afs_call *call, struct sockaddr_rxrpc *srx),

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

