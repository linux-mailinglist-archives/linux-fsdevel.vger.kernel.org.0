Return-Path: <linux-fsdevel+bounces-76948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE12DoKZjGkhrgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:00:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C181255C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 16:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63A2F3018C08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3232284671;
	Wed, 11 Feb 2026 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JdcZM0yV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E689279DB4;
	Wed, 11 Feb 2026 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822005; cv=none; b=TfILJchaXVn1G58pUOnngu4tzFoWVEgCDp5qsZ9IdH76iJg9uS4uO88MGxXQZ0+W+d4XSI15hQ9npK/gKNhyKirP4934H3HlIasVZjG9jjGQmeZM0R93QWQu7d/fILCz/7dveXONC0bGzzHoNSo8h4aAlfv01XYlhZJQ+bOHamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822005; c=relaxed/simple;
	bh=gzdEX1We3x/h72GbpmddfYn1DxWOP/QUpsVjSsZ2o5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vxxtrp4cY8YG3q2EVA1gdWkYE5niDL7bnsPaVvVGArX+6PidNAiiW48k22ePzKkXVgwp9YXUWw9+Ns/4CJCfV5mPAPzZg/oEm0oAC9oKEynB9I5d1CwUi8fJEFSPd47gnGSCl9TwZw63Em+yPihoTV8mhzrLvSOA2nu0EuyUnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JdcZM0yV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hHuPnpLZyQRL+/k96GQQR6iV30ap+OXf41TChNbGCtM=; b=JdcZM0yVvkLgGANUuoBZGjPlFf
	RgJOMtFQixtd0a1uK74ftt9M7CcPq9tzZ8vk1mvrvPUOX+VTtceFiX9tyy3ry+nF7StGb0DYa7+yb
	td8BI/F0a5FxRlgFDXh7WNl/cJGUrZlqqK4604SKSFkkbG6z6d8LMp1PpO9XcR/W2ERLirPj9MlbQ
	puFkKfIN0CAARZjfDhmCIaqVhIf+XE3piQQLxhHpwShCNMsIYwfJuaPGOaaNRGwShIY/jKjBKVDMt
	NWXLeNMza6OwrlUC7tHdedD/yOtc1T5ZlrJIU8jl39rYa7NK7TRWZTfubOIidZEySLNpM7OOpb8aQ
	0MrMkKpQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vqBgx-00H8mD-RD; Wed, 11 Feb 2026 15:59:47 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  Joanne Koong <joannelkoong@gmail.com>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: [PATCH v5 1/3] fuse: add compound command to combine multiple
 requests
In-Reply-To: <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
	(Horst Birthelmer's message of "Tue, 10 Feb 2026 09:46:16 +0100")
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
	<20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
Date: Wed, 11 Feb 2026 14:59:46 +0000
Message-ID: <87zf5fqqal.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76948-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[szeredi.hu,ddn.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wotan.olymp:mid]
X-Rspamd-Queue-Id: 87C181255C8
X-Rspamd-Action: no action

Hi Horst,

On Tue, Feb 10 2026, Horst Birthelmer wrote:

> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> For a FUSE_COMPOUND we add a header that contains information
> about how many commands there are in the compound and about the
> size of the expected result. This will make the interpretation
> in libfuse easier, since we can preallocate the whole result.
> Then we append the requests that belong to this compound.
>
> The API for the compound command has:
>   fuse_compound_alloc()
>   fuse_compound_add()
>   fuse_compound_send()

First of all, thanks a lot for this.  It looks solid to me and in general,
I'm happy with this interface.  (Note: I haven't yet tested this v5 rev --
I'll rebase my own code on top of it soon so that I can give it a try).

Please find below a few comments I have, most of them minor.

As for the two other patches in this series, they look mostly alright to
me, though I believe there's some extra clean-up work to be done in the
error paths for the actual open+getattr implementation.  Is this
open+getattr code something you'd like to get merged as well, or is it
just an example on how to implement a compound operation?  If the latter,
maybe it could be moved somewhere else (Documentation/filesystems/fuse/
maybe?).

> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
>  fs/fuse/Makefile          |   2 +-
>  fs/fuse/compound.c        | 224 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/fuse_i.h          |  11 +++
>  include/uapi/linux/fuse.h |  40 +++++++++
>  4 files changed, 276 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 22ad9538dfc4b80c6d9b52235bdfead6a6567ae4..4c09038ef995d1b9133c2b687=
1b97b280a4693b0 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_CUSE) +=3D cuse.o
>  obj-$(CONFIG_VIRTIO_FS) +=3D virtiofs.o
>=20=20
>  fuse-y :=3D trace.o	# put trace.o first so we see ftrace errors sooner
> -fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
 ioctl.o
> +fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o=
 ioctl.o compound.o
>  fuse-y +=3D iomode.o
>  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
> diff --git a/fs/fuse/compound.c b/fs/fuse/compound.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..1a85209f4e99a0e5e54955bcd=
951eaf395176c12
> --- /dev/null
> +++ b/fs/fuse/compound.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2025

Should this be 2026?  Or 2025-2026, not sure.

> + *
> + * Compound operations for FUSE - batch multiple operations into a single
> + * request to reduce round trips between kernel and userspace.
> + */
> +
> +#include "fuse_i.h"
> +
> +/*
> + * Compound request builder, state tracker, and args pointer storage
> + */
> +struct fuse_compound_req {
> +	struct fuse_mount *fm;
> +	struct fuse_compound_in compound_header;
> +	struct fuse_compound_out result_header;
> +	int op_errors[FUSE_MAX_COMPOUND_OPS];
> +	struct fuse_args *op_args[FUSE_MAX_COMPOUND_OPS];
> +};
> +
> +struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, u32=
 flags)
> +{
> +	struct fuse_compound_req *compound;
> +
> +	compound =3D kzalloc(sizeof(*compound), GFP_KERNEL);
> +	if (!compound)
> +		return NULL;
> +
> +	compound->fm =3D fm;
> +	compound->compound_header.flags =3D flags;
> +
> +	return compound;
> +}
> +
> +int fuse_compound_add(struct fuse_compound_req *compound, struct fuse_ar=
gs *args)
> +{
> +	if (!compound ||
> +	    compound->compound_header.count >=3D FUSE_MAX_COMPOUND_OPS)
> +		return -EINVAL;
> +
> +	if (args->in_pages)
> +		return -EINVAL;
> +
> +	compound->op_args[compound->compound_header.count] =3D args;
> +	compound->compound_header.count++;
> +	return 0;
> +}
> +
> +static void *fuse_copy_resp_data_per_req(const struct fuse_args *args,
> +					  char *resp)
> +{
> +	const struct fuse_arg *arg;
> +	int i;
> +
> +	for (i =3D 0; i < args->out_numargs; i++) {
> +		arg =3D &args->out_args[i];
> +		memcpy(arg->value, resp, arg->size);
> +		resp +=3D arg->size;
> +	}
> +
> +	return resp;

fuse_copy_resp_data_per_req() should probably be a void function, as it's
only caller doesn't seem to care about the return.

>=20
> +}
> +
> +int fuse_compound_get_error(struct fuse_compound_req *compound, int op_i=
dx)
> +{
> +	return compound->op_errors[op_idx];
> +}

Since this isn't being used in this file, this function could probably be
moved into fuse_i.h as a static inline instead.

> +
> +static void *fuse_compound_parse_one_op(struct fuse_compound_req *compou=
nd,
> +					 int op_index, char *response,
> +					 char *response_end)
> +{
> +	struct fuse_out_header *op_hdr =3D (struct fuse_out_header *)response;
> +	struct fuse_args *args =3D compound->op_args[op_index];
> +
> +	if (op_hdr->len < sizeof(struct fuse_out_header))
> +		return NULL;
> +
> +	if (response + op_hdr->len > response_end)
> +		return NULL;
> +
> +	if (op_hdr->error)
> +		compound->op_errors[op_index] =3D op_hdr->error;
> +	else
> +		fuse_copy_resp_data_per_req(args, response +
> +					    sizeof(struct fuse_out_header));
> +	/* in case of error, we still need to advance to the next op */
> +	return response + op_hdr->len;
> +}
> +
> +static int fuse_compound_parse_resp(struct fuse_compound_req *compound,
> +				     char *response, size_t response_size)
> +{
> +	char *response_end =3D response + response_size;
> +	int req_count;
> +	int i;
> +
> +	req_count =3D min(compound->compound_header.count,
> +			compound->result_header.count);
> +
> +	for (i =3D 0; i < req_count; i++) {
> +		response =3D fuse_compound_parse_one_op(compound, i, response,
> +						      response_end);

So, we allow the possibility of having some requests without out args.
But there seems to be something wrong here, right?  What if the first
request is e.g. a FUSE_UNLINK, which doesn't have an out arg?  In the
function above we'll be copying the arg into the first request.  Or am I
misunderstanding the logic?

> +		if (!response)
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Build a single operation request in the buffer
> + *
> + * Returns the new buffer position after writing the operation.
> + */
> +static char *fuse_compound_build_one_op(struct fuse_conn *fc,
> +					 struct fuse_args *op_args,
> +					 char *buffer_pos)
> +{
> +	struct fuse_in_header *hdr;
> +	size_t needed_size =3D sizeof(struct fuse_in_header);
> +	int j;
> +
> +	for (j =3D 0; j < op_args->in_numargs; j++)
> +		needed_size +=3D op_args->in_args[j].size;
> +
> +	hdr =3D (struct fuse_in_header *)buffer_pos;
> +	memset(hdr, 0, sizeof(*hdr));

Nit: since the buffer has kmalloc'ed using '__GFP_ZERO', this memset()
could probably be dropped.

> +	hdr->len =3D needed_size;
> +	hdr->opcode =3D op_args->opcode;
> +	hdr->nodeid =3D op_args->nodeid;
> +	hdr->uid =3D from_kuid(fc->user_ns, current_fsuid());
> +	hdr->gid =3D from_kgid(fc->user_ns, current_fsgid());
> +	hdr->pid =3D pid_nr_ns(task_pid(current), fc->pid_ns);
> +	buffer_pos +=3D sizeof(*hdr);
> +
> +	for (j =3D 0; j < op_args->in_numargs; j++) {
> +		memcpy(buffer_pos, op_args->in_args[j].value,
> +		       op_args->in_args[j].size);
> +		buffer_pos +=3D op_args->in_args[j].size;
> +	}
> +
> +	return buffer_pos;
> +}
> +
> +ssize_t fuse_compound_send(struct fuse_compound_req *compound)
> +{
> +	struct fuse_conn *fc =3D compound->fm->fc;
> +	struct fuse_args args =3D {
> +		.opcode =3D FUSE_COMPOUND,
> +		.in_numargs =3D 2,
> +		.out_numargs =3D 2,
> +		.out_argvar =3D true,
> +	};
> +	unsigned int req_count =3D compound->compound_header.count;
> +	size_t total_expected_out_size =3D 0;
> +	size_t actual_response_size;
> +	size_t buffer_size =3D 0;
> +	void *resp_payload_buffer;
> +	char *buffer_pos;
> +	void *buffer =3D NULL;
> +	ssize_t ret;
> +	int i, j;
> +
> +	for (i =3D 0; i < req_count; i++) {
> +		struct fuse_args *op_args =3D compound->op_args[i];
> +		size_t needed_size =3D sizeof(struct fuse_in_header);
> +
> +		for (j =3D 0; j < op_args->in_numargs; j++)
> +			needed_size +=3D op_args->in_args[j].size;
> +
> +		buffer_size +=3D needed_size;
> +
> +		for (j =3D 0; j < op_args->out_numargs; j++)
> +			total_expected_out_size +=3D op_args->out_args[j].size;
> +	}
> +
> +	buffer =3D kmalloc(buffer_size, GFP_KERNEL | __GFP_ZERO);

Nit: I find kzalloc() easier to read (and write!).

> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	buffer_pos =3D buffer;
> +	for (i =3D 0; i < req_count; i++)
> +		buffer_pos =3D fuse_compound_build_one_op(fc,
> +							compound->op_args[i],
> +							buffer_pos);
> +
> +	compound->compound_header.result_size =3D total_expected_out_size;
> +
> +	args.in_args[0].size =3D sizeof(compound->compound_header);
> +	args.in_args[0].value =3D &compound->compound_header;
> +	args.in_args[1].size =3D buffer_size;
> +	args.in_args[1].value =3D buffer;
> +
> +	buffer_size =3D total_expected_out_size +
> +		      (req_count * sizeof(struct fuse_out_header));
> +
> +	resp_payload_buffer =3D kmalloc(buffer_size, GFP_KERNEL | __GFP_ZERO);

Same as above.

> +	if (!resp_payload_buffer) {
> +		ret =3D -ENOMEM;
> +		goto out_free_buffer;
> +	}
> +
> +	args.out_args[0].size =3D sizeof(compound->result_header);
> +	args.out_args[0].value =3D &compound->result_header;
> +	args.out_args[1].size =3D buffer_size;
> +	args.out_args[1].value =3D resp_payload_buffer;
> +
> +	ret =3D fuse_simple_request(compound->fm, &args);
> +	if (ret < 0)
> +		goto out;
> +
> +	actual_response_size =3D args.out_args[1].size;
> +
> +	ret =3D fuse_compound_parse_resp(compound, (char *)resp_payload_buffer,
> +				       actual_response_size);
> +out:
> +	kfree(resp_payload_buffer);
> +out_free_buffer:
> +	kfree(buffer);
> +	return ret;
> +}
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d15e869db4be23a93605098588eda9..9ebcd96b6b309d75c86a9c716=
cbd88aaa55c57ef 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1273,6 +1273,17 @@ static inline ssize_t fuse_simple_idmap_request(st=
ruct mnt_idmap *idmap,
>  int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
>  			   gfp_t gfp_flags);
>=20=20
> +/**
> + * Compound request API
> + */
> +struct fuse_compound_req;
> +ssize_t fuse_compound_send(struct fuse_compound_req *compound);
> +
> +struct fuse_compound_req *fuse_compound_alloc(struct fuse_mount *fm, u32=
 flags);
> +int fuse_compound_add(struct fuse_compound_req *compound,
> +		      struct fuse_args *args);
> +int fuse_compound_get_error(struct fuse_compound_req *compound, int op_i=
dx);
> +
>  /**
>   * Assign a unique id to a fuse request
>   */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12bd39f535188cb5466688eba42263..113583c4efb67268174dbe4f6=
8e9ea1c21b45eb6 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -664,6 +664,13 @@ enum fuse_opcode {
>  	FUSE_STATX		=3D 52,
>  	FUSE_COPY_FILE_RANGE_64	=3D 53,
>=20=20
> +	/* A compound request is handled like a single request,
> +	 * but contains multiple requests as input.
> +	 * This can be used to signal to the fuse server that
> +	 * the requests can be combined atomically.
> +	 */
> +	FUSE_COMPOUND		=3D 54,
> +
>  	/* CUSE specific operations */
>  	CUSE_INIT		=3D 4096,
>=20=20
> @@ -1245,6 +1252,39 @@ struct fuse_supp_groups {
>  	uint32_t	groups[];
>  };
>=20=20
> +#define FUSE_MAX_COMPOUND_OPS   16        /* Maximum operations per comp=
ound */
> +
> +#define FUSE_COMPOUND_SEPARABLE (1<<0)
> +#define FUSE_COMPOUND_ATOMIC (1<<1)

Is there a difference between !ATOMIC and SEPARABLE?  I.e can we set both
flags for the same request?  If there is a difference, I think it should
be explicitly spelled out here.

Cheers,
--=20
Lu=C3=ADs

> +/*
> + * Compound request header
> + *
> + * This header is followed by the fuse requests
> + */
> +struct fuse_compound_in {
> +	uint32_t	count;			/* Number of operations */
> +	uint32_t	flags;			/* Compound flags */
> +
> +	/* Total size of all results.
> +	 * This is needed for preallocating the whole result for all
> +	 * commands in this compound.
> +	 */
> +	uint32_t	result_size;
> +	uint64_t	reserved;
> +};
> +
> +/*
> + * Compound response header
> + *
> + * This header is followed by complete fuse responses
> + */
> +struct fuse_compound_out {
> +	uint32_t	count;     /* Number of results */
> +	uint32_t	flags;     /* Result flags */
> +	uint64_t	reserved;
> +};
> +
>  /**
>   * Size of the ring buffer header
>   */
>
> --=20
> 2.53.0
>


