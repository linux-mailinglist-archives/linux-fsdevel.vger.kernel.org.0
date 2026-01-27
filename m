Return-Path: <linux-fsdevel+bounces-75555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPYXKL8AeGnHnAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:03:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A378E611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 01:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92E51301DE33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 00:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F041862A;
	Tue, 27 Jan 2026 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b="mIH/ViSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E43C2F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769472183; cv=pass; b=MXKW4Eif8iYf/snX8UgJF84DLc0DPQALJQjAWOF80ZqcPblaajlcPAzFMO7nr3pKWre0LyeCIAaYPYqS21u2zCu0Z+uz61Cxj84nQMZpchWERtHQdzhIjwLwBWoB/9ypeVKKZ2A7zzBpzOauuRw3D0im2oOSXLgoZDapjaWaJ2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769472183; c=relaxed/simple;
	bh=B7FILprzdIVa5cNTWasw+0btZERZW9imHJueiJLeXUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPocZJ6lAXyW/qTq0bGPa82fdu/s66rfzchfC3tY6GeDqieALG5g3+bR2IZXTAtnfd3cyQavoE6/cL191eOYnE1AbPyRrTo+W8OYkgR1ZNmXrnj+0At09G9fxofMuOn1XCDv7W/gGIZhYfqrMRgeXfcSLvwTuhOx5ogsU/nV1N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20230601.gappssmtp.com header.i=@multikernel-io.20230601.gappssmtp.com header.b=mIH/ViSz; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so6964290a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 16:03:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769472180; cv=none;
        d=google.com; s=arc-20240605;
        b=QodRWogTppN7525eviaIvZZdrwuoDKhEqQn97rXpHYnCqWfDARNMFpOuyvwg4T7Q7O
         wTT5/HOsrGzsazHpuxqdF1TcDTvELgqOIyQ5GKhjKV4fFDBbL3YSgBeoKRkgQzqgRebr
         /+Pd9nLJhTXtqX2hz5eDLdtYooOsjmB5gAdLsn1/ezpJOdhaNiwJUcrjvTg5BS8nNdnC
         8Mh4n6SUwVBvim8Zd1O3/0Yx1189pm6LtsrUC9sQR08fQdAbUbI8loR/VfsPXHw5Gnof
         KrCKpC3NGgD+es0EVgLkALOgEaka2XnzLSGQFjoghkbjqDCffOoBAw8RbGGXKLl8kXKu
         wiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p8XNhWr+8q+8rN33Bt0joMF058uip+nBi0GOrAnxuPc=;
        fh=mzCDLKaoWZ6/v1COOXa9PM1965yfQJIctol8EMIpO58=;
        b=OgQZvFqecQT7IRMAJP5Yr9u7npvefddRKnLHgvbEDnQJp49L2z51QIo0NSN1RR2TMc
         amuzxhVyYago/A2D2SZ9bRgn1gAOq2v0tKH37vNOaHIL27KGoKK4WHm4J24vv7cqf63Q
         mpR/TfD/dp7kZPaJzncvBuNI0v89PXwo0fXU/vUbtovpbXMMkfG3fLhEfwP6dSL+wkT1
         0EvhlzHybj7WoFxSZw0ZL7Kc7m8Sy6jpKAJGa31zxKA0hRrq8y7l/lGGnu0udLW6ZSWp
         txQv+8X1MhJeLElvYJFLo+gwyBzc+/UfR0WgHtVnybCbxckntrL6Kbk/db2P89e7H64s
         tt+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20230601.gappssmtp.com; s=20230601; t=1769472180; x=1770076980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8XNhWr+8q+8rN33Bt0joMF058uip+nBi0GOrAnxuPc=;
        b=mIH/ViSz4+OxPgOaGRYh6oZsvL4F4OwGpPQI+b/qxMtKfub84KChP9CWoLwhzd4qE0
         TKInmLNOqdtICBf32o7GT072vdwc1PJalB5kPLELTvzLujwjB1PP8Bgr07hIjyGz1Wph
         0cJ9qn58UIwCa0v51TlyN1HkD1b3X3cuV5dE87mIOTM8gX4vV2vy76fUYtUxWwGrWynR
         jb9Uvt7l5vr/LvjoFc6fkoTxafc2lIcatNnt3AH4wXNq0i9mUpgoylPoxlqZgQiTdvok
         VfUJMpcZseUXktYWccgXUpxR2BfsflCmpHUS6ocpfPuCd31LOO22/zs+Wl+pO5bZZrFT
         7wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769472180; x=1770076980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8XNhWr+8q+8rN33Bt0joMF058uip+nBi0GOrAnxuPc=;
        b=sd1slOBbLjk3ux8CVK2nxfKGzrFGs0QMcZcMqQUxsXqE2KWEuvKHkl5YdPW75j74We
         NaYutCEsEPwXdldRuupQguS3Y9SR2YZ80DMtw81K8rzZALTe65al7SdtrOeFjRkaxrVh
         5GlPBegytKGqVoGw6CyQxP4uvsV8QN9Hkjtjeep9ZDqjj5CHitD0n0lcne7zDuvLPhMo
         H13BkOkpsK3kgCm5ODjLyvnEAEHvnLR6vr4TuO6JoW3zaTTo6Iucu8cPzMIXvsppmZml
         Kktz8ulzpGeuxxDagaO2M7XV7q/wF+mNZ60mOioKUaKDCHZtwYw17I1usmHEDtycPFAb
         eqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVySD9z3eQbt8/teAKQfPNTPAU/V+Xthf/+qoSuNfYxn4TKSi7yXEf6caouacR3gBnv2p3+AShoC+IZnd+O@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEkIGWb1Xtn93Qz1qwdW4MntGjLafQyj8QyydkIlDdPfQhKQl
	HO7deFLySYurU1pPKAxI0UCVFBam1FTY6cikqZlC3/+HD6xWWAnOt16Rd6x/pnL4CEXDjsD30C8
	RbMsTw/qVhTjdAJ0Ke555kfeBEEEG5BH6dbkxp7TfIA==
X-Gm-Gg: AZuq6aLqvo0nSQfNJwd+JTQ5rcgwc4N9QiGghMR6l72zoYkHxBrfxlStpYSNSJ0KeFL
	2EJ/kyCI7P859qGO/3jGvTkxmt45xMiqhwTLXT/JXmRiusYYJn3adhqgZ1fpJefLhxpUTmlCl1n
	XNF//yIwEwvh64BKBHbGdCmG1HSLe/PQvHLxydaUbgIGPTE/fUz5wt174F/8aoaG4Jrcvxiyt70
	ZwbumQ3ZlkZIvutRRK6yT2B9bMA50zIljUT7FNe8U7PxtdBTNGQr9/+AQJXSy4Ta2T9Z484ETUA
	HgLa3j3JsKQb5w/qXjaXvznsViAiodevekirgKrpIxUV69qCJswlXxgn2YW+XME5RVrYL90=
X-Received: by 2002:a05:6402:1474:b0:658:11c3:421e with SMTP id
 4fb4d7f45d1cf-6587068c482mr3951394a12.12.1769472179696; Mon, 26 Jan 2026
 16:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGHCLaREA4xzP7CkJrpqu4C=PKw_3GppOUPWZKn0Fxom_3Z9Qw@mail.gmail.com>
 <55e3d9f6-50d2-48c0-b7e3-fb1c144cf3e8@linux.alibaba.com> <CAGHCLaQbr2Q1KwEJhsZGuaFV=m6WEkxsgurg30+pjSQ4dHQ_1Q@mail.gmail.com>
 <aXe9nhAsK2lzOoxY@casper.infradead.org> <CAGHCLaSe8g+BQ5OtRv0_Ft3o-G0gR4oVSOW0DtdsQJdwuJsDCA@mail.gmail.com>
 <aXfRUlu61nrIqCZS@casper.infradead.org>
In-Reply-To: <aXfRUlu61nrIqCZS@casper.infradead.org>
From: Cong Wang <cwang@multikernel.io>
Date: Mon, 26 Jan 2026 16:02:48 -0800
X-Gm-Features: AZwV_QgTGkVlFwt14eO-hIDhuWs096CQL1Rqh16YT-ktWjQKBhx-RkrjRU6Xp5s
Message-ID: <CAGHCLaSA9SnM+rtURV=U=hJ4kxpqUim6t7SgvxMNnAed0XaHMg@mail.gmail.com>
Subject: Re: [ANNOUNCE] DAXFS: A zero-copy, dmabuf-friendly filesystem for
 shared memory
To: Matthew Wilcox <willy@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75555-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[multikernel-io.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.alibaba.com,vger.kernel.org,gmail.com,lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 00A378E611
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:40=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jan 26, 2026 at 11:48:20AM -0800, Cong Wang wrote:
> > Specifically for this scenario, struct inode is not compatible. This
> > could rule out a lot of existing filesystems, except read-only ones.
>
> I don't think you understand that there's a difference between *on disk*
> inode and *in core* inode.  Compare and contrast struct ext2_inode and
> struct inode.
>
> > Now back to EROFS, it is still based on a block device, which
> > itself can't be shared among different kernels. ramdax is actually
> > a perfect example here, its label_area can't be shared among
> > different kernels.
> >
> > Let's take one step back: even if we really could share a device
> > with multiple kernels, it still could not share the memory footprint,
> > with DAX + EROFS, we would still get:
> > 1) Each kernel creates its own DAX mappings
> > 2) And faults pages independently
> >
> > There is no cross-kernel page sharing accounting.
> >
> > I hope this makes sense.
>
> No, it doesn't.  I'm not suggesting that you use erofs unchanged, I'm
> suggesting that you modify erofs to support your needs.

I just tried:
https://github.com/multikernel/linux/commit/a6dc3351e78fc2028e4ca0ea02e781c=
a0bfefea3

Unfortunately, the multi-kernel derivation is still there and probably
hard to eliminate without re-architecturing EROFS, here is why:

  DAXFS Inode (line 202-216):

  struct daxfs_base_inode {
      __le32 ino;
      __le32 mode;
      ...
      __le64 size;
      __le64 data_offset;    /* =E2=86=90 INTRINSIC: stored directly in ino=
de
*/
      ...
  };

 DAXFS Read Path:
  // Pseudocode - what DAXFS does
  void *data =3D base + inode->data_offset + file_offset;
  copy_to_iter(data, len, to);
  // DONE. No metadata parsing, no derivation.

 EROFS Read Path:
  // What EROFS does (even in memory mode)
  struct erofs_map_blocks map =3D { .m_la =3D pos };
  erofs_map_blocks(inode, &map);  // =E2=86=90 DERIVES physical address
      // Inside erofs_map_blocks():
      //   - Check inode layout type (compact? extended?
chunk-indexed?)
      //   - For chunk-indexed: walk chunk table
      //   - For plain: compute from inode
      //   - Handle inline data, holes, compression...
  src =3D base + map.m_pa;

Please let me know if I miss anything here.

Also, the speculative branching support is also harder for EROFS,
please see my updated README here:
https://github.com/multikernel/daxfs/blob/main/README.md
(Skip to the Branching section.)

Thanks.
Cong Wang

