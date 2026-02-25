Return-Path: <linux-fsdevel+bounces-78389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGCyEvgwn2lXZQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:27:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6271619B87C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 18:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F101D3014904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2A8288517;
	Wed, 25 Feb 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WXTaX0YK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8DE3939BE;
	Wed, 25 Feb 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040425; cv=none; b=Oo18Fq1M33Re9fOB9IiQISj0Z/4kg32K09xfxvOlYaE45UsTFyiy3lJDBGSwdKt9QuCqtjHnIegWhKPupg2qVy1susjG/KCAzTtbNhdIiz6hSTkOIyVYU65chQqf8NtWhoiZGiJAirUEt2MVNX0MM4rjI9w4HNEO3xO9bMsxBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040425; c=relaxed/simple;
	bh=UYFvFeLAK3N/hrwT6KU8VNBJlyp6N9J1wIYXrBA/8Sw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UP030fbR0TLUB26EjKm5ssm6kSyBFF1HZDbe/uE4LWRagYkKJLoGOUAZoHFyZeuhx+OwOc09FQqxUnmzS/wS14X3wR7jnSa6tmC4tYfEH32wqdM+9ReFrnk8rwJ7g6R2TtbTjJv1rD1TuryZRzA+QW/txSfim5e1IhsJZOhQOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WXTaX0YK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xfz1qZPhwEw9pdjYU7ZaaNQEZOVB6RykudPFThQA3KE=; b=WXTaX0YK+rWNaJALYLVJv6smIA
	q/OCQHmFOhJdjoyb0+3ML3wO4ELiFA+0PxL0gZQ+xVtfzgb+W6AgFmysKr0seXzryGfFHpoWoDJqv
	tsyOsR+Id4Ko8Bm90lxQ2bfFuyDqkDcKlS6+FXsBORmpKtBtHs5WbZRs6fNfq3PqwIRhkcEuBtuG4
	Kut2aksf5D2O/gtOBOotYJrb2b1XNdA5IuJ/FZhNdsXYuNlQ4zLg8A2afi5RMNFXHm4FlJ8KQqnrm
	jeKyz20KxcAGFos1otYKq55iX9yUZgDGlRjzUXUfjK9AN5SPdcyHirigNB/oLPAUdPaDdbLD44Is9
	oCUKTr3w==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvIes-005KYj-5z; Wed, 25 Feb 2026 18:26:46 +0100
From: Luis Henriques <luis@igalia.com>
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Bernd Schubert <bschubert@ddn.com>,  Bernd Schubert
 <bernd@bsbernd.com>,  "Darrick J. Wong" <djwong@kernel.org>,  Horst
 Birthelmer <hbirthelmer@ddn.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Kevin Chen <kchen@ddn.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matt Harvey <mharvey@jumptrading.com>,
  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 8/8] fuse: implementation of
 mkobj_handle+statx+open compound operation
In-Reply-To: <aZ8O2ohfGEgqE6TT@fedora.fritz.box> (Horst Birthelmer's message
	of "Wed, 25 Feb 2026 16:08:10 +0100")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-9-luis@igalia.com>
	<aZ8O2ohfGEgqE6TT@fedora.fritz.box>
Date: Wed, 25 Feb 2026 17:26:45 +0000
Message-ID: <87cy1s68fe.fsf@wotan.olymp>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78389-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: 6271619B87C
X-Rspamd-Action: no action

Hi!

On Wed, Feb 25 2026, Horst Birthelmer wrote:

> Hi Luis,
>
> On Wed, Feb 25, 2026 at 11:24:39AM +0000, Luis Henriques wrote:
>> The implementation of this compound operation allows atomic_open() to use
>> file handle.  It also introduces a new MKOBJ_HANDLE operation that will
>> handle the file system object creation and will return the file handle.
>>=20
>> The atomicity of the operation (create + open) needs to be handled in
>> user-space (e.g. the handling of the O_EXCL flag).
>>=20
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>  fs/fuse/dir.c             | 219 +++++++++++++++++++++++++++++++++++++-
>>  include/uapi/linux/fuse.h |   2 +
>>  2 files changed, 220 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 7fa8c405f1a3..b5beb1d62c3d 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -1173,6 +1173,220 @@ static int fuse_create_open(struct mnt_idmap *id=
map, struct inode *dir,
>>  	return err;
>>  }
>>=20=20
>> +static int fuse_mkobj_handle_init(struct fuse_mount *fm, struct fuse_ar=
gs *args,
>> +				  struct mnt_idmap *idmap, struct inode *dir,
>> +				  struct dentry *entry, unsigned int flags,
>> +				  umode_t mode,
>> +				  struct fuse_create_in *inarg,
>> +				  struct fuse_entry2_out *outarg,
>> +				  struct fuse_file_handle **fh)
>> +{
>> +	struct fuse_inode *fi;
>> +	size_t fh_size =3D sizeof(struct fuse_file_handle) + MAX_HANDLE_SZ;
>> +	int err =3D 0;
>> +
>> +	*fh =3D kzalloc(fh_size, GFP_KERNEL);
>> +	if (!*fh)
>> +		return -ENOMEM;
>> +
>> +	memset(inarg, 0, sizeof(*inarg));
>> +	memset(outarg, 0, sizeof(*outarg));
>> +
>> +	inarg->flags =3D flags;
>> +	inarg->mode =3D mode;
>> +	inarg->umask =3D current_umask();
>> +
>> +	if (fm->fc->handle_killpriv_v2 && (flags & O_TRUNC) &&
>> +	    !(flags & O_EXCL) && !capable(CAP_FSETID))
>> +		inarg->open_flags |=3D FUSE_OPEN_KILL_SUIDGID;
>> +
>> +	args->opcode =3D FUSE_MKOBJ_HANDLE;
>> +	args->nodeid =3D get_node_id(dir);
>> +	args->in_numargs =3D 2;
>> +	args->in_args[0].size =3D sizeof(*inarg);
>> +	args->in_args[0].value =3D inarg;
>> +	args->in_args[1].size =3D entry->d_name.len + 1;
>> +	args->in_args[1].value =3D entry->d_name.name;
>> +
>> +	err =3D get_create_ext(idmap, args, dir, entry, mode);
>> +	if (err)
>> +		goto out_err;
>> +	fi =3D get_fuse_inode(dir);
>> +	if (fi && fi->fh) {
>> +		if (!args->is_ext) {
>> +			args->is_ext =3D true;
>> +			args->ext_idx =3D args->in_numargs++;
>> +		}
>> +		err =3D create_ext_handle(&args->in_args[args->ext_idx], fi);
>> +		if (err)
>> +			goto out_err;
>> +	}
>> +
>> +	args->out_numargs =3D 2;
>> +	args->out_args[0].size =3D sizeof(*outarg);
>> +	args->out_args[0].value =3D outarg;
>> +	args->out_args[1].size =3D fh_size;
>> +	args->out_args[1].value =3D *fh;
>> +
>> +out_err:
>> +	if (err) {
>> +		kfree(*fh);
>> +		free_ext_value(args);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>> +static int fuse_mkobj_statx_open(struct mnt_idmap *idmap, struct inode =
*dir,
>> +				 struct dentry *entry, struct file *file,
>> +				 unsigned int flags, umode_t mode)
>> +{
>> +	struct fuse_compound_req *compound;
>> +	struct fuse_mount *fm =3D get_fuse_mount(dir);
>> +	struct fuse_inode *fi =3D NULL;
>> +	struct fuse_create_in mkobj_in;
>> +	struct fuse_entry2_out mkobj_out;
>> +	struct fuse_statx_in statx_in;
>> +	struct fuse_statx_out statx_out;
>> +	struct fuse_open_in open_in;
>> +	struct fuse_open_out *open_outp;
>> +	FUSE_ARGS(mkobj_args);
>> +	FUSE_ARGS(statx_args);
>> +	FUSE_ARGS(open_args);
>> +	struct fuse_forget_link *forget;
>> +	struct fuse_file *ff;
>> +	struct fuse_attr attr;
>> +	struct fuse_file_handle *fh =3D NULL;
>> +	struct inode *inode;
>> +	int epoch, ret =3D -EIO;
>> +	int i;
>> +
>> +	epoch =3D atomic_read(&fm->fc->epoch);
>> +
>> +	ret =3D -ENOMEM;
>> +	forget =3D fuse_alloc_forget();
>> +	if (!forget)
>> +		return -ENOMEM;
>> +	ff =3D fuse_file_alloc(fm, true);
>> +	if (!ff)
>> +		goto out_forget;
>> +
>> +	if (!fm->fc->dont_mask)
>> +		mode &=3D ~current_umask();
>> +
>> +	flags &=3D ~O_NOCTTY;
>> +
>> +	compound =3D fuse_compound_alloc(fm, FUSE_COMPOUND_ATOMIC);
>> +	if (!compound)
>> +		goto out_free_ff;
>> +
>
> Just to clarify for myself and maybe others.
> You want this to be processed atomic on the fuse server and never
> be separated by the upcoming 'decode and send separate' code in the
> kernel?
> Is that really necessarry? What would the consequences be,=20
> if this is not really atomic?

No, you're right -- it's unlikely that this flag is required.  If I
remember correctly from the discussion, the flags and what they mean is
one of the things still not written in stone for the compound operations,
right?

Regarding this compound specifically, what I wanted was to ensure is that:

- The operations are serialised as they are interdependent(*), and
- If one operation fails, the others can be aborted.

(*) Actually, the last 2 ops (statx and open) could be parallelised.

>> +	fi =3D get_fuse_inode(dir);
>> +	if (!fi) {
>> +		ret =3D -EIO;
>> +		goto out_compound;
>> +	}
>> +	ret =3D fuse_mkobj_handle_init(fm, &mkobj_args, idmap, dir, entry, fla=
gs,
>> +				     mode, &mkobj_in, &mkobj_out, &fh);
>> +	if (ret)
>> +		goto out_compound;
>> +
>> +	ret =3D fuse_compound_add(compound, &mkobj_args);
>> +	if (ret)
>> +		goto out_mkobj_args;
>> +
>> +	fuse_statx_init(&statx_args, &statx_in, FUSE_ROOT_ID, NULL, &statx_out=
);
>> +	ret =3D fuse_compound_add(compound, &statx_args);
>> +	if (ret)
>> +		goto out_mkobj_args;
>> +
>> +	ff->fh =3D 0;
>> +	ff->open_flags =3D FOPEN_KEEP_CACHE;
>> +	memset(&open_in, 0, sizeof(open_in));
>> +
>> +	/* XXX flags handling */
>> +	open_in.flags =3D ff->open_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
>> +	if (!fm->fc->atomic_o_trunc)
>> +		open_in.flags &=3D ~O_TRUNC;
>> +	if (fm->fc->handle_killpriv_v2 &&
>> +	    (open_in.flags & O_TRUNC) && !capable(CAP_FSETID))
>> +		open_in.open_flags |=3D FUSE_OPEN_KILL_SUIDGID;
>> +
>> +	open_outp =3D &ff->args->open_outarg;
>> +	fuse_open_args_fill(&open_args, FUSE_ROOT_ID, FUSE_OPEN, &open_in,
>> +			    open_outp);
>> +
>> +	ret =3D fuse_compound_add(compound, &open_args);
>> +	if (ret)
>> +		goto out_mkobj_args;
>> +
>> +	ret =3D fuse_compound_send(compound);
>
> Your compound looks good so far ;-)

Yey!

>> +	if (ret)
>> +		goto out_mkobj_args;
>> +
>> +	for (i =3D 0; i < 3; i++) {
>> +		int err;
>> +
>> +		err =3D fuse_compound_get_error(compound, i);
>> +		if (err && !ret)
>> +			ret =3D err;
>> +	}
>
> this is probably why you opted for that 'give me any occurred error'
> functionality?

Right, since there are interdependencies between the operations I only
care about the first failure.  Probably a pr_warning() could be used here
to log each of them.

Anyway, it's not clear that this pattern will be common enough in order to
think about an helper for it.  I guess that if we are bundling a bunch of
operations that can be parallelised, then error handling needs to be done
differently.

Cheers,
--=20
Lu=C3=ADs

>> +	if (ret)
>> +		goto out_mkobj_args;
>> +
>> +	fuse_statx_to_attr(&statx_out.stat, &attr);
>> +	WARN_ON(fuse_invalid_attr(&attr));
>> +	ret =3D -EIO;
>> +	if (!S_ISREG(attr.mode) || invalid_nodeid(mkobj_out.nodeid) ||
>> +	    fuse_invalid_attr(&attr))
>> +		goto out_mkobj_args;
>> +
>> +	ff->fh =3D open_outp->fh;
>> +	ff->nodeid =3D mkobj_out.nodeid;
>> +	ff->open_flags =3D open_outp->open_flags;
>> +	inode =3D fuse_iget(dir->i_sb, mkobj_out.nodeid, mkobj_out.generation,
>> +			  &attr, ATTR_TIMEOUT(&statx_out), 0, 0, fh);
>> +	if (!inode) {
>> +		flags &=3D ~(O_CREAT | O_EXCL | O_TRUNC);
>> +		fuse_sync_release(NULL, ff, flags);
>> +		fuse_queue_forget(fm->fc, forget, mkobj_out.nodeid, 1);
>> +		ret =3D -ENOMEM;
>> +		goto out_mkobj_args;
>> +	}
>> +	d_instantiate(entry, inode);
>> +
>> +	entry->d_time =3D epoch;
>> +	fuse_dentry_settime(entry,
>> +		fuse_time_to_jiffies(mkobj_out.entry_valid,
>> +				     mkobj_out.entry_valid_nsec));
>> +	fuse_dir_changed(dir);
>> +	ret =3D generic_file_open(inode, file);
>> +	if (!ret) {
>> +		file->private_data =3D ff;
>> +		ret =3D finish_open(file, entry, fuse_finish_open);
>> +	}
>> +	if (ret) {
>> +		fuse_sync_release(get_fuse_inode(inode), ff, flags);
>> +	} else {
>> +		if (fm->fc->atomic_o_trunc && (flags & O_TRUNC))
>> +			truncate_pagecache(inode, 0);
>> +		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
>> +			invalidate_inode_pages2(inode->i_mapping);
>> +	}
>> +
>> +out_mkobj_args:
>> +	fuse_req_free_argvar_ext(&mkobj_args);
>> +out_compound:
>> +	kfree(compound);
>> +out_free_ff:
>> +	if (ret)
>> +		fuse_file_free(ff);
>> +out_forget:
>> +	kfree(forget);
>> +	kfree(fh);
>> +
>> +	return ret;
>> +}
>> +
>>  static int fuse_mknod(struct mnt_idmap *, struct inode *, struct dentry=
 *,
>>  		      umode_t, dev_t);
>>  static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>> @@ -1201,7 +1415,10 @@ static int fuse_atomic_open(struct inode *dir, st=
ruct dentry *entry,
>>  	if (fc->no_create)
>>  		goto mknod;
>>=20=20
>> -	err =3D fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CR=
EATE);
>> +	if (fc->lookup_handle)
>> +		err =3D fuse_mkobj_statx_open(idmap, dir, entry, file, flags, mode);
>> +	else
>> +		err =3D fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_C=
REATE);
>>  	if (err =3D=3D -ENOSYS) {
>>  		fc->no_create =3D 1;
>>  		goto mknod;
>> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
>> index 89e6176abe25..f49eb1b8f2f3 100644
>> --- a/include/uapi/linux/fuse.h
>> +++ b/include/uapi/linux/fuse.h
>> @@ -243,6 +243,7 @@
>>   *
>>   *  7.46
>>   *  - add FUSE_LOOKUP_HANDLE
>> + *  - add FUSE_MKOBJ_HANDLE
>>   */
>>=20=20
>>  #ifndef _LINUX_FUSE_H
>> @@ -677,6 +678,7 @@ enum fuse_opcode {
>>  	FUSE_COMPOUND		=3D 54,
>>=20=20
>>  	FUSE_LOOKUP_HANDLE	=3D 55,
>> +	FUSE_MKOBJ_HANDLE	=3D 56,
>>=20=20
>>  	/* CUSE specific operations */
>>  	CUSE_INIT		=3D 4096,
>>=20

