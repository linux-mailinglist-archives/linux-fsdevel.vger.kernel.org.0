Return-Path: <linux-fsdevel+bounces-75643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNoxG7YaeWmPvQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:06:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8A59A336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 21:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAA88301387B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 20:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331842264C0;
	Tue, 27 Jan 2026 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itJDAsDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F323D2A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544360; cv=pass; b=are2kolJ7h/Cmc3+2W7ZayVYEhivvATpcU4KRgap1E1UGC0n951gyKu6TNzmtWS5dUhfOGW52BvEm3srXHM7wguWr8VRtrdoL5eWJupd6SoQTY1W0CBRd6lFfHtK4bns78awz5bcPGycE99Rf1Hw6sB0u5SjFs6E/iXuU/SH8pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544360; c=relaxed/simple;
	bh=icI95fFOv3tMi/jB90IaeFcTs/ruZ0giOxBrLhXe7ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAsXezHipIxD9FcwtWY5AnV7EbW8KZxIMrlaT8uJcZ0PcyIJ3KAxOfAxbtrf6iKNby2y0CZQqp1D7EOSK1HFXqVHPF0i7bJY45NUX6qetSVG+EjY9S9e1SMGmWLNkngTRzjLlzgZX3rovC3gbYgJ4n9LYU8Io/4a7hCyC/wEcH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itJDAsDj; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c711959442so17692485a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 12:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769544358; cv=none;
        d=google.com; s=arc-20240605;
        b=Ggor9oAaAwA4m2W1jKMQ0B6kNNV923ICyKXr4Pg1ZRETxOsZt+XC+QD6KJ1wjr3sWS
         Tnm5k5AIl1DBOgbDKKBcgaNvyNNN1eq8dRULCmM7luKcu8hI2GOHm+siWhN/OpM7sVBV
         IGN/ZX/WTuw26XAs08BMbHmAViGUd1M4bLYAEpRuYSbwlW+fqRpB5pnamaIP0ckCrMXm
         /rnFwy6lk4jGGZwZHEx0bfcdYJAPds7ohHlMYsAe6bmZJ4z3vc992Na7pBpH2yR7N7mQ
         LuWRmqcu+7RnsAhh0Lag9sokbz5nkukjeaYt0oFCyDVeAqvd2l8UkafL0Vclntrv7L11
         9ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CJsSVDxKTWVCl1kXW2ng0AR2wLLtclJzNKgDiXG68WY=;
        fh=8LTY9/3BOgjL6LRP4xBWgmsCSzScCa+SYduNsK3XOrM=;
        b=eVI/oPZkwrnUf59NA26twpuT8jlF29p2ckmEjhAbhyjWOwH5AtSmkdfaMGj7r2foVa
         teMXkaxlvTzVWBDGkYbvDHyTuFevpYU+aF49wzJYFJzvWMsBZRBaLAC7gJ9zYXxlyO/5
         7BL4WoOTABL+tihFsJDAzeUkqQEkkhLqtE27Di7DsJbCH/7g7721RE05DfSf4upi0ZZ8
         Iqe1fMt1E/k6ZklllOzl9JArqQEEtTR0oSXcMrAdHT8TvNeLpeeStnO46lUrBPYK0WvP
         Hs3O3eSTVPiKvFdXJA2Fp/Ml6tFMIwlXiwcqAKRWGAFuqbAqBTXMGi++gJnGTfrwxRPQ
         E0BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769544358; x=1770149158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJsSVDxKTWVCl1kXW2ng0AR2wLLtclJzNKgDiXG68WY=;
        b=itJDAsDjNER9zIo2SgPy/pqPzKAeHVVwYHv9gJEeMso7MaRhv77F+lghpoaW8aXU6Z
         fOdmj5Ip30SOLzXb00WI2ZFxK2+X6OE7VsEP8noqOMNWZ5XawGDTV4Fvh7ALwV5dMdfP
         qS+uVmjas4zp25qHgVKHfE16QE0g/qeCMHvNKt9yJu0bQlUaZbfX6GSNAqCZHB893MFY
         bgNRVV9HHrSVaeOtOBeDgClxKWByX2o8BESE/eDyUds/6enzhalNQjpFUotk3Wngslw5
         p8EzVbA1wSQI1sEj1sApzUuc2gM89Zqf2jFKVPUBZMdl0y3tOlrlkt3K4HC/U6s35OmL
         4sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769544358; x=1770149158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJsSVDxKTWVCl1kXW2ng0AR2wLLtclJzNKgDiXG68WY=;
        b=WQ4yt5KCToJ8sxIASqseeOaNUyS4efUghQvNM7XQlL47u77uD/1N2B2/XH/8dBOY45
         eGrP79ljDXsslSov/6TTap6eud6Ap3vKEN+iqt9fkTZCZN6FZyeh2DLaWbbe7+roNSg2
         jWSLNR4ZmxLmwbAOIMaVzhI5lcs6F/ULQJVgrYm6GmV931QHZWH9LFvEaGdUTIA7ZGjY
         gjL18AcDB39Fr4D0wdUQHa2xjsnu++n984B+TDfT5rCbUixZzsPp4SztXME4ntiyQAjI
         cVMRFAezWlA9eVM8lNGuzkUR5txgDSCF/LvQXE2p7ojrgz9xYkveqFnavAJ7DYHoVORL
         3mrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4IJaI8Fu96ssMQovXUuhKTaXwCAO4tLtd1qUG1/yFqSpmM51FpKmoFy0XUfsHB/exiHG8h1jxJBpFIyvA@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWZmTpzZTi6ZhuC0Ht3CRpg94qKbS5ykG4q/tb/J7dv9JejbW
	qghGFaSu58NE/twAfd9SGpAOS1TRj+LMFyNv4GuvuqnrE3wGIRRxfvbPNxj95JB5fzN5xoaXMib
	plI37vM1oFjnh5VpsOsXPZIR+MG06MEI=
X-Gm-Gg: AZuq6aIENknAfITSuQ85UEioq+lPvLEQrynjhWpx+x5y5En3tJurrH4LWpKg6c+75e8
	BSbkPspNRrOdPUhXTQtJU19tyE3joewnN3qCKu4k4fLU9RqnhoQM7iGPRJ7e6DOtB6I73c9rMXL
	g5+SyaGIhC6J7LjqRwhC7zDFuM2A5uOd2O5964L9Ew9h+ZyXUAUhh4RKNBZ/q7NQT2NWpcYCpH9
	7Lf4DdcDnsXSxqhunxTnoP+hDv3yPnFAglhaz6gXhOiD41gYL2h4xrwY87B9IjOrQ0CJA==
X-Received: by 2002:a05:620a:44c4:b0:8b9:f737:2006 with SMTP id
 af79cd13be357-8c70c2252e8mr313395885a.37.1769544358324; Tue, 27 Jan 2026
 12:05:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <20260116233044.1532965-9-joannelkoong@gmail.com> <CADUfDZruYbRfpftns3a17HHF=ZqayztP-t5uVzSRB3APhree+Q@mail.gmail.com>
In-Reply-To: <CADUfDZruYbRfpftns3a17HHF=ZqayztP-t5uVzSRB3APhree+Q@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 12:05:46 -0800
X-Gm-Features: AZwV_Qhcl5kA2omf9KC3B_M0T2ItkthtaTdO1lT_2FU1UQX29xeLbA3n4-NE028
Message-ID: <CAJnrk1Z_73pVY6LsN33=LqcM5v1Z-w_uiUYb65bhFL3LiXXYxw@mail.gmail.com>
Subject: Re: [PATCH v4 08/25] io_uring: add io_uring_fixed_index_get() and io_uring_fixed_index_put()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com, krisman@suse.de, 
	io-uring@vger.kernel.org, asml.silence@gmail.com, xiaobing.li@samsung.com, 
	safinaskar@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,ddn.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-75643-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: DB8A59A336
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 1:02=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Fri, Jan 16, 2026 at 3:31=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Add two new helpers, io_uring_fixed_index_get() and
> > io_uring_fixed_index_put(). io_uring_fixed_index_get() constructs an
> > iter for a fixed buffer at a given index and acquires a refcount on
> > the underlying node. io_uring_fixed_index_put() decrements this
> > refcount. The caller is responsible for ensuring
> > io_uring_fixed_index_put() is properly called for releasing the refcoun=
t
> > after it is done using the iter it obtained through
> > io_uring_fixed_index_get().
> >
> > The struct io_rsrc_node pointer needs to be returned in
> > io_uring_fixed_index_get() because the buffer at the index may be
> > unregistered/replaced in the meantime between this and the
> > io_uring_fixed_index_put() call. io_uring_fixed_index_put() takes in th=
e
> > struct io_rsrc_node pointer as an arg.
> >
> > This is a preparatory patch needed for fuse-over-io-uring support, as
> > the metadata for fuse requests will be stored at the last index, which
> > will be different from the buf index set on the sqe.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/cmd.h | 20 ++++++++++++
> >  io_uring/rsrc.c              | 59 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 79 insertions(+)
> >
> > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > index 41c89f5c616d..fa41cae5e922 100644
> > --- a/io_uring/rsrc.c
> > +++ b/io_uring/rsrc.c
> > @@ -1152,6 +1152,65 @@ int io_import_reg_buf(struct io_kiocb *req, stru=
ct iov_iter *iter,
> >         return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
> >  }
> >
> > +struct io_rsrc_node *io_uring_fixed_index_get(struct io_uring_cmd *cmd=
,
> > +                                             int buf_index, unsigned i=
nt off,
> > +                                             size_t len, int ddir,
> > +                                             struct iov_iter *iter,
> > +                                             unsigned int issue_flags)
> > +{
> > +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> > +       struct io_rsrc_node *node;
> > +       struct io_mapped_ubuf *imu;
> > +       u64 addr;
> > +       int err;
> > +
> > +       io_ring_submit_lock(ctx, issue_flags);
> > +
> > +       node =3D io_rsrc_node_lookup(&ctx->buf_table, buf_index);
> > +       if (!node) {
> > +               io_ring_submit_unlock(ctx, issue_flags);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       node->refs++;
> > +
> > +       io_ring_submit_unlock(ctx, issue_flags);
> > +
> > +       imu =3D node->buf;
> > +       if (!imu) {
>
> How is this possible?

You're right, this null check is unnecessary. I'll drop it.

Thank you for reviewing the patches, Caleb.

>
> Other than that,
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
>
> > +               err =3D -EFAULT;
> > +               goto error;
> > +       }

