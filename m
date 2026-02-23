Return-Path: <linux-fsdevel+bounces-77962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IP9A9ZqnGmcGAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:57:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A568178510
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B443630325E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270726ED5D;
	Mon, 23 Feb 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="o+BWoZ2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268E26B2CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771858639; cv=pass; b=meitwa+lDpGo8KpYJiW4DjFHypnqFQqfDS/cdoI61XU4LZRPAzangxXmaXWcwq9fqXsgY+j6ORuQnonlqMIuMTdFEtcTC8WjWYbX1WRAS8nYTp+2CFpo+IABik78WphyLh7JcmbHk4kF97ukojxTIOmJr5o81SaMgv475wgEBUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771858639; c=relaxed/simple;
	bh=skCGFiY45cVbceebcBwjQrT24vVSaodAPQE79MWrFUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JA90QBle18xmiKEdwjKqq2TL9a9Tr5NXm1MrN1YX+wsZr/wUOzESz6ylW3u5rk6voyqGDS5imXWbeRQYZybb1bEQbatpWZhuGa6ZtdGQtbZssFMed+gh4+via6AkThUpYZzKrxWtVzxUwXdmlnvfR92yEnhYu/9aRI3PntPTlCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=o+BWoZ2S; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-502a789834fso39149081cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 06:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771858636; cv=none;
        d=google.com; s=arc-20240605;
        b=CBy5hg/GgLVdVJwK1I1oQJePvc7WahcztWteqbQW8/T9U1Blir01NgFacSg/zdRRFE
         8GRYUMUBlOaDPrBrFBMBbSMdU7qN71EfdaFZiR6yF0Mbxax4ru/tnC+kpFOdHZQaphES
         SDwKM89AtbSSBqZlXvQJyHWYLNzPROteQvgxa7ZtX+NM2BzkFWBXT/q4+RgdkBmM2uAa
         BgfV+AYdfyquhS2Gfi/NdhW5P5or3ie5TiAGbw4Hj4qHxqmRLM8qsby94mKdQjykdX4z
         rIcrpkpvzrMh5+mF5VqU6E4IMyhteJtresm3inUuK7f6mE8Tn2zfNxYnnZxQ6Wn12CgE
         WLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nyhG7uicQFlvi1QfkZ8nhDJ2r2FEZ6r+qvwVMjLIA9E=;
        fh=zSSwpdX4heaz03ni+cxia1LhULQlD4gvu8zKaeVTX4w=;
        b=Ov+y7vhBonX94Ve+oT0f8V0JJ+ZXe27eldYJs6t4PMNgxdFIhyhsy63msmGFbI4Ziw
         dIEYZXiR0HKDrdQ/xY5Sw9MDqRmXACufb252UndyHenPif/j1CH1h4xaOlmgajernsfe
         BOGsdYoL+oWXFJQB89PG2ofMC7eevUggodVf3Z79299ZxhrdKXwyJyTi0hiDQ3fXv2GB
         6XNKkmb1s5PO1IRu3LaA0zWX7Y4gtm+oD3EgwkU2cB1E6ENDH6lrhUs/QFX7JyAuk2WX
         eDaBJ8gpGyRaXhdxIHj8++MP3X9QzkDkwoODEzCKDmGvttMnoil3dgOKVmmiYMVL/CcB
         +rMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771858636; x=1772463436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nyhG7uicQFlvi1QfkZ8nhDJ2r2FEZ6r+qvwVMjLIA9E=;
        b=o+BWoZ2ScbArIoW6XiOu1zgsv6vdk0sLSYVQxbLMWG49BKNRYQ4S0lvZGkOZBRchkL
         96eQba4YxRE6fiLac3z8b8/h9nZ574jwutT6ZAOWLew3EdeqYT6geGI9Ql+2w95j1Ozf
         0gAB3dEUCdIFxVkZ10ORvrNud/7l/zyPgTkkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771858636; x=1772463436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyhG7uicQFlvi1QfkZ8nhDJ2r2FEZ6r+qvwVMjLIA9E=;
        b=mauLzWasyOpTZp3b+AepUrzUicBbWWBodPsvVjQ8n2qUyiNEExXN7jPhWM9YwoU39X
         m4Xu7iSLXu26er6Snwjusyq3uR0p5XGiqNtuL0Xcjo0lB0x55/dBMFMZwSFQJqLOuTTf
         i8u+OdShaCiQgmyUOxYs/s2JyZvp3Bj8aKw292SdpaWZL8m3/C/YSxBLv1xcp6ULxXPm
         KiDVoP64zOo+CPJ5ZNT4MP3UIm5hxzlO7cKCer8LIFDcNRJnvcRfp4nPLTjM+yv34seI
         Vnprf7MGfZs2uTqXY3g0K5HQODQ5v9aQsCz3CxbYMdG+nOdfK6QQf3bFp2kYBUzpqfkH
         ib9w==
X-Gm-Message-State: AOJu0YxC6pkEQQt4z+Wi+sDG+/2PrZ37lcjPWLsDrBB0wXFoagqe/SmP
	rnbNadZ0JIJsKf81NB6+WqoiSr2tTIY81qreWTzlDmRkiCEirHFgkeLd8oldPpOBBVlLQ3jD7W0
	RjkkfBjSfAAsRioo921ca2SwCIEPUzSirXGyk7a6uqw==
X-Gm-Gg: AZuq6aJ9RYgl2/gYpnBjC66RD6WtvKQJXykHp+cpwhfUTT2F3lao2gNsvxclb/I/FYX
	qpCSjYT+FuJ76n5shBtHHW7ny5pFFxYCQKmF9jfVwhErGJpGb79M1rlEx/ia4wewENIxd+wO4rw
	WkBhzo7hJ2/8SxkCyFFszRMONFZA/8ipwjMUPiDeCvf4wdwiHMxGJCB5FEw1933hP+6yMihp4QC
	r2s3msHkxvbCn4VPYOVBndJHe5edJN8j0PMPGyE396gpg/gY0sffVdwGIzCGaWBxYOGLZ79mxVZ
	b3YYDg==
X-Received: by 2002:ac8:7d4a:0:b0:4e2:e58a:57e1 with SMTP id
 d75a77b69052e-5070bc739bfmr113764651cf.37.1771858636298; Mon, 23 Feb 2026
 06:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220204102.21317-1-jiharris@nvidia.com>
In-Reply-To: <20260220204102.21317-1-jiharris@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Feb 2026 15:57:05 +0100
X-Gm-Features: AaiRm51X55T-wuZIEwI1HcIls77n-y2N74yR61Ak2xg3DPQpIlHZyxNtDmMJAy0
Message-ID: <CAJfpeguEK4JsFo60=yHkpLL6XkDGS7cQ5GOhiFL379KsYk0TsQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is set
To: Jim Harris <jim.harris@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mgurtovoy@nvidia.com, ksztyber@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77962-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 8A568178510
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 at 21:41, Jim Harris <jim.harris@nvidia.com> wrote:
>
> From: Jim Harris <jim.harris@nvidia.com>
>
> When O_CREAT is set, we don't need the lookup. The lookup doesn't
> harm anything, but it's an extra FUSE operation that's not required.
>
> Signed-off-by: Jim Harris <jim.harris@nvidia.com>
> ---
>  fs/fuse/dir.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f25ee47822ad..35f65d49ed2a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -895,7 +895,8 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
>                 goto out_err;
>         }
>         kfree(forget);
> -       d_instantiate(entry, inode);
> +       d_drop(entry);
> +       d_splice_alias(inode, entry);
>         entry->d_time = epoch;
>         fuse_change_entry_timeout(entry, &outentry);
>         fuse_dir_changed(dir);
> @@ -936,14 +937,15 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
>         if (fuse_is_bad(dir))
>                 return -EIO;
>
> -       if (d_in_lookup(entry)) {
> -               struct dentry *res = fuse_lookup(dir, entry, 0);
> -               if (res || d_really_is_positive(entry))
> -                       return finish_no_open(file, res);
> -       }
> +       if (!(flags & O_CREAT)) {
> +               if (d_in_lookup(entry)) {
> +                       struct dentry *res = fuse_lookup(dir, entry, 0);
>
> -       if (!(flags & O_CREAT))
> +                       if (res || d_really_is_positive(entry))
> +                               return finish_no_open(file, res);
> +               }
>                 return finish_no_open(file, NULL);
> +       }
>
>         /* Only creates */
>         file->f_mode |= FMODE_CREATED;

Now this is not necessarily true.  Setting FMODE_CREATED in case of an
existing file will have the effect of not checking permissions to open
(think open(path, O_CREAT | O_RDWR, 0444)).

Sad fact is that the same thing could happen with current code: a file
created on a remote client during the window between LOOKUP and
CREATE.

To prevent that with the current protocol we'd need to add O_EXCL and
retry on -EEXIST.

Better fix would be to add a flag to the CREATE reply indicating if
the file was created or not.

Thanks,
Miklos

