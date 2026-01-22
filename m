Return-Path: <linux-fsdevel+bounces-75152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPhQOoCQcmnQmAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:02:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D186D9A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60C1630053AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CB43AE710;
	Thu, 22 Jan 2026 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M5dQvsEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D537AA9A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115768; cv=pass; b=YO5JcpzXAFW9JHZFkUi1DSX69J6taxgU8wb8YIcl62FKfXi2uXg9K6Tufu3HJKuXhomWwKo0OFfsLmaejyzbXqOmXwyiDVf87E1VhpE6dfRuN75VmMPFvg8hKePkZLrS8Fhfu16WZ7EmoJBHOb0HhlSfDxLXvpoTj6JBmTtnzno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115768; c=relaxed/simple;
	bh=e/QVsuEdSwNyET3wwB3q69H2wHyH0tAfoogUFj06q2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym/MKUnJJixI3i5n3jN6Ecma/WclObdY9En9r5MuQHKV9Dm6khpoJHaGoKjcqjma9LfHx9UvyatGbPlAMFt9qC0scP4CAAKVDVm9TMSIAbqkiM5C3ZczxN1YsBdzNCsXyxzOvV/67RR2V+lNJ4govlTrwXVyYJ26fjS/+MHdb4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M5dQvsEj; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-123387e3151so128536c88.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 13:02:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769115757; cv=none;
        d=google.com; s=arc-20240605;
        b=hlKN2BzRP/+HWQi1hHHQlccnminCXNVN+8WDoMoqdHqqu54t6JCy3adVuZn7BdfGyr
         eqJL7sI38EIasteY20l/UblGuortQg9b5fq3oPPbzJsRHrwS53ZW7vcmLNnfm4CoiF9s
         HGgPHwtDLizNctxHi2WX0uNyPuKjzkv3WiobPrfVy770doFDnLDU9ApXL2eprWlyBCCt
         QyRYoEsLAlhQTObz/mqtsTHGheO0fMm88bqifMc+5Oe23vRppEz8/3Ck0LL4bCpFNQZN
         u8mtTBpYSD7UoIfa8FXqYw7nzk/flvwkxxLQfeIv5bIB6UJKe/XE4uTl7/eFSGtAW+G4
         OyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AqQnMCpGuh+PP41KooEigfpzr6TswhXwK3MFMdrApQo=;
        fh=3u7oA6qENfdKYUlzCILyBspHo3V3EeXFClVrYiUckNY=;
        b=kNVguX/9aGVw5AOTuwwFbBPldCA2aHAHjYcx7+vXKEe8XmLfoDyMXWjyjyT5LYRbzV
         lQzG+nxsWqQ6ELsO5N7ybULrTXjwprreitw/ZCVJvdSiFtdmO0nA8D20VVHNIacYczSq
         pX2FfXOrAgUFN6h6Moz6A0GFTUsJsjwN/dWlccKnZn7f2qH79UEq2Bez9JKtbSIdKZQH
         SQlH/qx2yQcrshuxpDo1oAuNV5SMF955vJQEW/5ctNFCFv6owE70Hv1FqqIpeMgRfKI4
         0u+mOrji1XzJiGnjLsqtOOp6TkfQQZWbyfQjVhwAp9EmtG7B3nWIbo2s24DNKCfTZe5v
         PDKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769115757; x=1769720557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqQnMCpGuh+PP41KooEigfpzr6TswhXwK3MFMdrApQo=;
        b=M5dQvsEjaGNMCO9pXoWQBui1/Wlca9nJtEhg4QUUlIXaXFGBA+DTShJnE/TnYEllf1
         zyr2GK9Cmqhy8l8S+/v8kA44Qy4TaWNo9HSrERVARcPSDmFCuayaA2wYEPG6NHnfpDYW
         Lx5q3Moxn8L30lSdDvym2Hz8q+sj0inJeNsiZCqA8N0PeFcpbIBkdXPw6sZKGk5pWvS8
         wyBZ3FkIHgQouHgk1gtC8t9DkGh7ShuxssUIC55qwbwUgccT3SbozPuTqaJKNkIAPSy/
         vO6uIzjIbjss1XpKZgRheyXB5fdrATg//fC8CVItLdhJO6zsUaknX0dfIsdtMaJzrgaT
         6aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769115757; x=1769720557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AqQnMCpGuh+PP41KooEigfpzr6TswhXwK3MFMdrApQo=;
        b=J+LpLM3AFlYwYE+hhMJ34hqoPs0iO/13q8Swn5Q6HCuDQIYUfgkSWcjHsvk2eSRlId
         z/uFUfNlTtE3+dKs/y4Gn77RYFAWLNR0FYo/s0DmF8uB4a1OLGfdpCsazlSN/Hw/YkfW
         Ni9rTSZ3TtWWhV4dGLmnrQ4BFUEpoiidfguaRVIqVhwLl2zYcItKDM3HGOYRhurh44Hv
         ZrTMuUvmoPrcnRrq9hOUEDOUSQAU8pJhs1wFfzGFXzX8HVQetboK+Su0M+3rks2hAVF+
         fRAxJqRaWS3Zdm5FUdQcll9M0mSj7odM5W0sJNB2MFqj1LZxw/0kkdl7ET5vCPJAHCyy
         C3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFLiYIZ44vpFcR5cas1eOikuhb06bhiT7t8waBivkDnA8d+aVEOw/k7UpR+xLclfwqhVIeR+B1gcLk5QPd@vger.kernel.org
X-Gm-Message-State: AOJu0YzDaSCKUc3MihZRUvGSF8tq5WC8qBhrn1Fzos3F4fwiBxOkbizY
	CcsniY6yH8BgsvJ+kdEWLwp2K3bkfBzhzkoVcW29lbspZVJh8ezGk4zVchvAaLx7KqpmpABpcB7
	hIS7spzOMDY1RqbvC8b/wbh3QWYBBPty9Hce3Dy0mJA==
X-Gm-Gg: AZuq6aIChuSAnHL3Awge8SoiPcw1659Z0KDq6IM1P5TCdrvNGtTt75MgyJX+tLAYdzU
	ShjBnPB6c37EI8lxMwXCys3edt3mS9imM4mAEPXVWWdELbnY/ANKRplLPTCffL5UveeucokZkXm
	AqJVlq5vbtgqEBz7pveWEqAVsS6c8bvlefZCpJk7onilVUQi9jqqlHnU9EevkGgwlDD6rqzggZL
	RjUOGrKFjtip+F3EZOx1BSbFbOn4RDsLPVCr5XgcKSuF2dSfHZaeKjRLAlh1algKFW8FU5FCAkr
	V0cYLQ==
X-Received: by 2002:a05:7022:2385:b0:123:2d38:929b with SMTP id
 a92af1059eb24-1247dc01168mr190633c88.6.1769115756669; Thu, 22 Jan 2026
 13:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com> <20260116233044.1532965-9-joannelkoong@gmail.com>
In-Reply-To: <20260116233044.1532965-9-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 22 Jan 2026 13:02:25 -0800
X-Gm-Features: AZwV_QglS7d7muhiOx01JyBnjM9VKzOJncuZ1lNjPAcn3AtNEhRnbxQyk88GRDo
Message-ID: <CADUfDZruYbRfpftns3a17HHF=ZqayztP-t5uVzSRB3APhree+Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/25] io_uring: add io_uring_fixed_index_get() and io_uring_fixed_index_put()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com, krisman@suse.de, 
	io-uring@vger.kernel.org, asml.silence@gmail.com, xiaobing.li@samsung.com, 
	safinaskar@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75152-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,ddn.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[csander@purestorage.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 66D186D9A2
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 3:31=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Add two new helpers, io_uring_fixed_index_get() and
> io_uring_fixed_index_put(). io_uring_fixed_index_get() constructs an
> iter for a fixed buffer at a given index and acquires a refcount on
> the underlying node. io_uring_fixed_index_put() decrements this
> refcount. The caller is responsible for ensuring
> io_uring_fixed_index_put() is properly called for releasing the refcount
> after it is done using the iter it obtained through
> io_uring_fixed_index_get().
>
> The struct io_rsrc_node pointer needs to be returned in
> io_uring_fixed_index_get() because the buffer at the index may be
> unregistered/replaced in the meantime between this and the
> io_uring_fixed_index_put() call. io_uring_fixed_index_put() takes in the
> struct io_rsrc_node pointer as an arg.
>
> This is a preparatory patch needed for fuse-over-io-uring support, as
> the metadata for fuse requests will be stored at the last index, which
> will be different from the buf index set on the sqe.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/cmd.h | 20 ++++++++++++
>  io_uring/rsrc.c              | 59 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index a488e945f883..de3f550598cf 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -44,6 +44,14 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd =
*ioucmd,
>                                   size_t uvec_segs,
>                                   int ddir, struct iov_iter *iter,
>                                   unsigned issue_flags);
> +struct io_rsrc_node *io_uring_fixed_index_get(struct io_uring_cmd *cmd,
> +                                             int buf_index, unsigned int=
 off,
> +                                             size_t len, int ddir,
> +                                             struct iov_iter *iter,
> +                                             unsigned int issue_flags);
> +void io_uring_fixed_index_put(struct io_uring_cmd *cmd,
> +                             struct io_rsrc_node *node,
> +                             unsigned int issue_flags);
>
>  /*
>   * Completes the request, i.e. posts an io_uring CQE and deallocates @io=
ucmd
> @@ -108,6 +116,18 @@ static inline int io_uring_cmd_import_fixed_vec(stru=
ct io_uring_cmd *ioucmd,
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline struct io_rsrc_node *
> +io_uring_fixed_index_get(struct io_uring_cmd *cmd, int buf_index,
> +                        unsigned int off, size_t len, int ddir,
> +                        struct iov_iter *iter, unsigned int issue_flags)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline void io_uring_fixed_index_put(struct io_uring_cmd *cmd,
> +                                           struct io_rsrc_node *node,
> +                                           unsigned int issue_flags)
> +{
> +}
>  static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret=
,
>                 u64 ret2, unsigned issue_flags, bool is_cqe32)
>  {
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 41c89f5c616d..fa41cae5e922 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1152,6 +1152,65 @@ int io_import_reg_buf(struct io_kiocb *req, struct=
 iov_iter *iter,
>         return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
>  }
>
> +struct io_rsrc_node *io_uring_fixed_index_get(struct io_uring_cmd *cmd,
> +                                             int buf_index, unsigned int=
 off,
> +                                             size_t len, int ddir,
> +                                             struct iov_iter *iter,
> +                                             unsigned int issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +       struct io_rsrc_node *node;
> +       struct io_mapped_ubuf *imu;
> +       u64 addr;
> +       int err;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       node =3D io_rsrc_node_lookup(&ctx->buf_table, buf_index);
> +       if (!node) {
> +               io_ring_submit_unlock(ctx, issue_flags);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       node->refs++;
> +
> +       io_ring_submit_unlock(ctx, issue_flags);
> +
> +       imu =3D node->buf;
> +       if (!imu) {

How is this possible?

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +               err =3D -EFAULT;
> +               goto error;
> +       }
> +
> +       if (check_add_overflow(imu->ubuf, off, &addr)) {
> +               err =3D -EINVAL;
> +               goto error;
> +       }
> +
> +       err =3D io_import_fixed(ddir, iter, imu, addr, len);
> +       if (err)
> +               goto error;
> +
> +       return node;
> +
> +error:
> +       io_uring_fixed_index_put(cmd, node, issue_flags);
> +       return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_fixed_index_get);
> +
> +void io_uring_fixed_index_put(struct io_uring_cmd *cmd,
> +                             struct io_rsrc_node *node,
> +                             unsigned int issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +       io_put_rsrc_node(ctx, node);
> +       io_ring_submit_unlock(ctx, issue_flags);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_fixed_index_put);
> +
>  /* Lock two rings at once. The rings must be different! */
>  static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx =
*ctx2)
>  {
> --
> 2.47.3
>

