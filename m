Return-Path: <linux-fsdevel+bounces-78723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JLgFD21oWmMvgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:16:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C31231B98AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92DE9311DD5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FB7439011;
	Fri, 27 Feb 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CQLZ08Ot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A20438FE1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204960; cv=pass; b=Lxp7fl6WkVNQRD3ymWs9FjJf7BZafQn/3lj38gzmyNWavyn/ceogYhC+M7c2Asu0pZ+fUP9w8LRjShcwsTvsxxn2IWUBTdrjCoNhe1ziZ3OqzCMy6hCJm4h13SWec65awuKNfU86elHeg4NbzV0w57GRqGfSRnDCisfQepY0Odo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204960; c=relaxed/simple;
	bh=SNezquXlRvPUbw6WVotPxqNcwLw56ZMIFvmLqshjY0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiiqyKzU58TtV0ImvKGAz8/OrJf6KFbwhvW7Ix6jlSyuYt/okJn6pEH+p7uTMHQR9s8AnTHtNgwkZlVd1S0wohAhblm7Lfy+pguI7+uhV+qIhMt+7cRyMGfYy3OG1tMmOV3BpSVVIDICB4WhMJkS2Ie+jNpchUoohrJqMhBpXkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CQLZ08Ot; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506aa685d62so12639611cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:09:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772204957; cv=none;
        d=google.com; s=arc-20240605;
        b=lQs0ppI6hpF+EbTci7K9VFEC71S4si3l+VSm1hOf3ZDS5dQslCxuXRiacmvpuZgjVu
         YnMeHKi4LH/tkK0uUby4aS48j6Ce/dKL6oBeZcBVeYJhY3bEyH6VwAPDoqvCXrnUx2GL
         6OqS4FJSgsUSa8T+/txDD9auCOeCzEMLM8mq7mJkM5exJNC1Dce6hYKDsh/SvnVhz5z6
         xLOmQ2ln7lJvFPJsmay766CNYO2ZWaelDWWSWtSkNc5OsaVAwdeAqHq8QN3Cv+Rz6OgV
         zByphaOawhJYEbSzuT2n3BS9jJums2NfM4mL45mTMJrLwwQVUFP4hWPLdFW6npGdGKNG
         Wm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+k730C0R+Pi70VqxBjKSUyuJT6sjaxDcUSEzMZtx3QA=;
        fh=jxN+Ojlmf29Io7YwVd0kYvGzoHLjV8nN91nYbbzz1R4=;
        b=LoGLn2sfj6Q9jpSxQrz8Ne/U+pxxgXX6NsBJrJIF9yM9ZlJHEKOQ8Jckbkul1V/jxd
         mZg4sdyRajW3xdmZP2wRlU+mhnu/4ROn8K2x8bHemRBTNriKSg1m8trqB15WWASsiAXD
         jLDgN2Qef52zEjudYLzxAuSq/fv5nEFjdI8NwbtZ4eT4NzduXw6De7dyxEmak6/LTS4o
         c35JKx042XFkXjcMHEnktjdA9Cn2r3igsHHLFuaWH87AMfh9zNNWMOdbUMvdNgiLW5gt
         mG2G/H47F/S3rKqhfKcMfXW4+fxJQB1F3nDcqnbiRiv0JJlcsv/bd4dYu6PlH/gUaiAR
         1UUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772204957; x=1772809757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+k730C0R+Pi70VqxBjKSUyuJT6sjaxDcUSEzMZtx3QA=;
        b=CQLZ08OtFUhRuN5G784XpAHPZlsyZBAPCbqwR/fJuhWddBTEvST/KQZIrq1nfkSr+1
         OOLCTUf1zr5UOILszWVsBjO8sgffJ+0JDLC0CPrP2I3Dm1OKK9nqgRw2tHWctDNmYfdb
         ljOHDNp3dMlCWw6Ps23V326bXj2i1DaZIvBY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772204957; x=1772809757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k730C0R+Pi70VqxBjKSUyuJT6sjaxDcUSEzMZtx3QA=;
        b=qNkEspPzb/bFxQHCdxSu3gKumf3vkKA/dZDLZB8NA79s4yftSoo0IjZKf+hZkdTCVd
         W0L41gckgxKqWleS9xrYB8GnI8HXKm/3usYrTpscWcYQzgu+ZN+Xj3gXwnYwnUgZEyNp
         TQpde9ccS3si4RgC9CX/qY3NO7yR3JFs/BhF14Bv7aLF+VD4U/4mmoOY87Xf9udaBjg5
         XXWRjBhqku4YPUJYQc7a/D5yUE4maZ6204FHrchrDQjOeH2WlKQVbsTqr4IPEZZD4NUD
         6YXDv8bptFr9mdkd4MsrIRzqgWkn4EX9SL58k2TLGuz6rbGWZra2xT+pnYswiJk+xg7K
         Jbaw==
X-Gm-Message-State: AOJu0YxqtdFyNXVyF9m0rIqnKTCWgggCt0kJIMMO34wJcxNdwwLmOcz2
	RWyMg1I/gRiKDJVRcCLVzov7otx5eTuSXAVeUWPq4Nv4uUUQcch7F0smv2l6hjlM9RTpNpcvel2
	Td27vstcUZJjWTeUecI4iDRo1XviX8VrVE0znFtE6PQ==
X-Gm-Gg: ATEYQzwhPm0lzcNo5dKnOHD9JIj5N7k2feuFw4h/4PKre4nWr4xi3uJlRC9dETFZFKD
	LjnIU+ATAbYBERV4ZwHbfxAYQPhb8L1mW/GWcldZkeP0nnhWa6ovoAJ4+OoKEb27GbRoBtfuCCs
	PfhslN1SeL8DF+Cfni9GhbLuGyZzIel2vIrRJD9wdqIfryxLfCPbsOUjLHeNrp0xI257sMUN+xJ
	lz/5kS6DbMSJTUrsOJKTAoxfaQlkAJkcYft7HD++WeDtSbOvrXTO5zBRupnp7rDKcYQzr/bEFen
	1QVqpg==
X-Received: by 2002:ac8:5747:0:b0:4f1:abb3:7571 with SMTP id
 d75a77b69052e-507528e15bfmr36993111cf.33.1772204956947; Fri, 27 Feb 2026
 07:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 16:09:05 +0100
X-Gm-Features: AaiRm50L5RZBMwEEH-vSG3thwCwN76NeEdvq7x5wbRaGtLJskZY1Zm0_WEzxFc0
Message-ID: <CAJfpegtS+rX37qLVPW+Ciso_+yqjTqGKNnvSacpd7HdniGXjAQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: invalidate the page cache after direct write
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78723-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email,mail.gmail.com:mid,szeredi.hu:dkim,ddn.com:email]
X-Rspamd-Queue-Id: C31231B98AC
X-Rspamd-Action: no action

On Sun, 11 Jan 2026 at 08:37, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>
> This fixes xfstests generic/451 (for both O_DIRECT and FOPEN_DIRECT_IO
> direct write).
>
> Commit b359af8275a9 ("fuse: Invalidate the page cache after
> FOPEN_DIRECT_IO write") tries to fix the similar issue for
> FOPEN_DIRECT_IO write, which can be reproduced by xfstests generic/209.
> It only fixes the issue for synchronous direct write, while omitting
> the case for asynchronous direct write (exactly targeted by
> generic/451).
>
> While for O_DIRECT direct write, it's somewhat more complicated.  For
> synchronous direct write, generic_file_direct_write() will invalidate
> the page cache after the write, and thus it can pass generic/209.  While
> for asynchronous direct write, the invalidation in
> generic_file_direct_write() is bypassed since the invalidation shall be
> done when the asynchronous IO completes.  This is omitted in FUSE and
> generic/451 fails whereby.
>
> Fix this by conveying the invalidation for both synchronous and
> asynchronous write.
>
> - with FOPEN_DIRECT_IO
>   - sync write,  invalidate in fuse_send_write()
>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
>                  fuse_send_write() otherwise
> - without FOPEN_DIRECT_IO
>   - sync write,  invalidate in generic_file_direct_write()
>   - async write, invalidate in fuse_aio_complete() with FUSE_ASYNC_DIO,
>                  generic_file_direct_write() otherwise
>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Applied, thanks.

Miklos

