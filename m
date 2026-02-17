Return-Path: <linux-fsdevel+bounces-77372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAI+GAqOlGn6FQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 16:49:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE9E14DB11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF65301AD36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853136C5B7;
	Tue, 17 Feb 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpbOOvSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033D3563F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343363; cv=pass; b=cSW9QaqSMO09LlTLpCjQWaq24EALlLASEcCVzdNtsOEkJxZhhd73uD3r77hVAVgQEC9+/+TIic65WqEftXzXsljMr9Q0xhF6w4/dLZP5/Q8W6/52nVb3YCGSaBnCfVpdXtNmCalIERx30er3eaxNV9idJTk53mnTfoOT3ToWE3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343363; c=relaxed/simple;
	bh=DL6R2tKFdN0Uez29EBRpEPY21UQJIMPKZkH7N6S2saM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3TRCaHC1MWkTikUjdaeOtfCLvwY/ymcRNPCsLeSgOuMjstGtRS/7uBhnvVq6vQbK54rSMvC0nGxmb5WLYRfpQSQ51Tji0W2VGNY4+8P3/CuthFvtvWlAk+xo/e3XGPiR0zAH2cU4Sz7IZN9m+wMWBBxj/SSZKipOsnLTV8fUfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpbOOvSx; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8f9b5240a2so624371566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 07:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771343361; cv=none;
        d=google.com; s=arc-20240605;
        b=fQ81r7TL6M79po1+ZlDpyaj+dYVnla7iNSTCwcxg1uCAohswdWiDXow/P9uHGTHse6
         jyLP5Vzjy57AJlVWLQpDCYpTjj4tEuH16Y3uBlhHnn/EMtzJNPZVmLE5b8ntdn5PIVhY
         pcnhffkCFDMwI3xUG1kgpmHgowfxaZRadGvMsnPEAlK7Az0shif22t5RcWmzR+XOqqwW
         90KWtcvbZTRIXqo0pLxscTxajOPDdT7UO3qcl/PZeWeiYLW2g1k+d48wZS7Aesz4lAyf
         MtcFvaJivf89+PFEINZ8nH04S+Hs3TjgL/BfNO5rjx65b21t6uztK6gFAV9NqzqNwqHP
         YGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eoan/39HjVF3qt9+NYCQepGk7by5yTHWKMyqzAPnThk=;
        fh=AbiP1ZRFvL7ppqhnf3f9nunmlTkUTvU6dpLlN49PA/0=;
        b=g3WqQVcOw9FYnusVZSguTJ4kaUd8yFNimjc+1tdYaDBvY3CLV+e8qMocnzACthD1eY
         MtwDZt3DTS8mfLySNV6udo4JLfGRYdReeIlS7a6e5Xotq4B1VJ91U4fLJXy5mLiQafLs
         Z3O5RK4mQHT071flxfWEm6YYcY73fzimPwSHWV3mHxGCToUQ3mIsE92SAgtUJ9dbqmKH
         TffvsuC8DgayGOj5T7Gfltp8jYUWtJBKgB9dAfJ08HMhBeQY+VH9jnA5AvAygtIxj0er
         5AbuXj8oQWCzJomcD2vw75i/MdBOp6eN8a9ArFFDEP51Prm+7wozBsWzmbGP7grH/zta
         xz3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771343361; x=1771948161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoan/39HjVF3qt9+NYCQepGk7by5yTHWKMyqzAPnThk=;
        b=hpbOOvSxb0atLYpg0jUR7K+CrWFihILGes0PfvyxhBXysFTUlpUQbxNGC60ExUgE3E
         1JWhAn24BiuwgXfGrlpEdWqL1gki4pA48tFB9xQGLuQMnWxJUM2YyYbYmn2s6pHtU5D/
         a+G0xNz9x8qyr8RZmcYARFyx2IUPQQT89NzlAcqgfwZZfD04vqesQ9vGIzTbgqTJkfeH
         8bnoHJ9lO/v6j77ho7hUi788luK3haYTk8XUzSyIMH8KZh/XyfCsRjJzS36WW9wR+mNC
         Tk+TXOB8aORPkZq9UP0IdF8VyKOfIUXYmNfr0MQRzZbnhHG39KtS4nntrbdesVt837SV
         sBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771343361; x=1771948161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eoan/39HjVF3qt9+NYCQepGk7by5yTHWKMyqzAPnThk=;
        b=P8IBhtKTnFQyyFMqUV4Vffh+jYer3MBu9v+MUwOVMn1XANGrcpJx1V2dYxd5IQgQL0
         lZ/Pj9+eWm179aWoy7CgwYqbnSlV+f2yHpGT+CkIS0/0WrgY9eNQ3EIvSULJD1SPDstg
         nBXVn24+hU1JG3W1uSqqWRN7h5slJS94aq4UEuFYU3QEdZez52IIgeENFBNVieIKQIZL
         /WPkyK3K8gD2VpmkbbHrHkICjFMwuVlobs3CPctRksu7dctIeuPPgQ8/8S1jhuJBY5nO
         2nNKnYg48fs/NL7Gu8jOUYzqsWiBwZ/OLAXoCigNR4AHv9aH1jf1vM3u3NECBy/Zp4aK
         fjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt/Fhy7ZI2oktYhjcfmD+iUjNsZdW+eGSRWAXg4fKuFY+rPxkbh7DyBtSrWbX88zGL23zdhvTfaZRreQRP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4Kcxq6gs1bt7viO9/j7YWLHG7n5upXS/0nMui6U6Tyo4jx6u
	ttixJyIU3wOg0OMaPtB9e4wsmnD5fKY8k8XDM9M5PNVsYbm4WWrqKzZ21ZEVTkMtcLU63eayZVb
	pZDjTj1QZHkdGyq5tOm19VXIjHJWiQ8I=
X-Gm-Gg: AZuq6aL2cnWgQQaot8GU+ysPJ04YTdMPptUZG0rBkBcyOJBDdwNb6G7iVUC5IhupdWP
	/1EC1FGrK/RCFLiYEGicWXDuYuXzu9Jma0uqh3n57i4rAcp4gnm+IfZSxUl2VJMNmOD/AYNnOtR
	onaswOkr87PKtZbCh99f14c2/TIl+T5QS7wCSeyYndcoD+uxnTvv3kTiVivqRxwmBBeQYsyP1+N
	OCzjdJnobjpDHaO1U2DXxJJ7zfOuFkQhujWi2LIDOG9zVWnfRpNXP3uHo4JE6YfzyFZqJFhCsl2
	l3jrzw==
X-Received: by 2002:a17:907:e158:b0:b87:38e0:4403 with SMTP id
 a640c23a62f3a-b8fb4476ceamr514132166b.40.1771343360318; Tue, 17 Feb 2026
 07:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216073158.75151-1-ytohnuki@amazon.com>
In-Reply-To: <20260216073158.75151-1-ytohnuki@amazon.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 17 Feb 2026 10:49:08 -0500
X-Gm-Features: AaiRm52u51kxwpNseipcjIXVCf67FJxEQOVcnJ2EWlVmF9xXSFDFWy0iRQcKQZ4
Message-ID: <CAJSP0QWjbQh2XxNaY4+POf-auBTjW8SG4Fk1TRpP2fpT0_hf8w@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: add FUSE protocol validation
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: German Maglione <gmaglione@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77372-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanha@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADE9E14DB11
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 2:32=E2=80=AFAM Yuto Ohnuki <ytohnuki@amazon.com> w=
rote:
>
> Add virtio_fs_verify_response() to validate that the server properly
> follows the FUSE protocol by checking:
>
> - Response length is at least sizeof(struct fuse_out_header).
> - oh.len matches the actual response length.
> - oh.unique matches the request's unique identifier.
>
> On validation failure, set error to -EIO and normalize oh.len to prevent
> underflow in copy_args_from_argbuf().
>
> Addresses the TODO comment in virtio_fs_request_complete().
>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
> ---
>  fs/fuse/virtio_fs.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

