Return-Path: <linux-fsdevel+bounces-74779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DBpGKZpcGkVXwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:52:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4051BB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 06:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 370366C6891
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD76364E8A;
	Wed, 21 Jan 2026 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCQv/ANJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D82139C9
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768974716; cv=pass; b=Iugcv6qCdWUNIOSk6I3NDdVk01ySMiZ5Slakd41Atlk6lAr9WJ5mMzKV99re6HzoJESRdmu0i8bwBXguCJWmesHdkcYd9ONw0UpbqsdzJbVahhSGRPjO+LU7FoucK8ZQYzPM5YdVYnkq6oqltnvCfQ64ZeWIJKrOy9P2rAXCZ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768974716; c=relaxed/simple;
	bh=r2nxDFuaFWwuKID50LYqaG7OoXYxDBmc6/nwIMD0c6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSugwFNofZoB9zcF/KqrlubIv3mXO9kWSZ8cSnX1jUUWF1i1j96/pG7UqQ5vyKw5Bd3vZNVcp58KbKUaqEQaMivhcU5fbsV1UV92z9nEKgQKmb0jCxvky4bX1krOq5QTAJ1EjpbIu1mbafnPWNF7q9veP1rw7l3wiptNo6jJdj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCQv/ANJ; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88888d80590so91802156d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 21:51:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768974713; cv=none;
        d=google.com; s=arc-20240605;
        b=BCSTY6yEApHA6oRd0ppBXy56jI6ZtGO/h6sGodFv7gP3BgjoG4O3gyrzF8/BYFYLR1
         XlUyg9MxREkD7PdynesJkTlzdtbgRLo7N6SFNxA+8wmPdMFRJGLWCES/mxWPseqWPD+h
         hdNk8FYHNsf/rS5vnP3luyT8nTTX9YpoxaLuAzszj72TYY4Z4TGFAvm3QqvwB1YlPgRS
         7FfeFEHtWRcuCy88t0VEoaS/+7h8p109Qt1HDiGWIgsFEfN2UBsr81mF21OPnAL73JWd
         IJNaIJCZBJfy92QG1ZTzpSaGPKR6xSpl4F8zxFAwT2ySfXsPVybaMHMLO14MaBrEIxz3
         xtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=saJl4uL3MrSVK5nhxdOmwKURYZi0uIqWnl/khLUQqYg=;
        fh=wMkf5V3ptCPmjvCeu8JxIDoY4q3wwyx7YdEAxIQvmtw=;
        b=bqwGaBpFfwE/8KZ97Jyuo2QX8Zk7KqRpSgOTh0Y/688OaAgXTm0qlZq50UFh914clt
         Ftn7tSOUQkFnUCyaNRPrSgX3MV0wB4PEzPRHdYmccc5+JSUPJRfMOLXhcE+ZszI/49gA
         UU+VStylRm0nLtUSKeK39FSHuXhgL48hOjplNKTr7KZTIP+I2ZuFsk4ymFP9xx26TGkI
         ijD/u9maQqkO09oKyldYWp+XwzGgOzwKpCBsgrCUXNzFHYgp6IN9rAQqVs05FI4UZjfh
         dzO18v7/jTwc710PiUYaIBrEGauKN+Iybl0r9Yh8XGVPHzP/uWkEDXBUfPl1XgJVfUaO
         vTcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768974713; x=1769579513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saJl4uL3MrSVK5nhxdOmwKURYZi0uIqWnl/khLUQqYg=;
        b=SCQv/ANJvE0NygVEZTFe3CrtXE5MMDcaS84LiQHEMvsh+En/xl2PwjzeJ9gd2ZVGRS
         Vy/tRzLr7EBkLeFyysPJ7MvsIjb3fffTt7vLPac21TVNi4NKyXhzaUCWav+An7UX9+C5
         Vdf43Ynr1ZF3oPo4ln40Nv/LEoXaajIOgWToXf4pju3GMfCKlHq6BdNLoQXcm2G45B5W
         TrHX5zvuLXuy+n96MmNc1FuD+gST1LUlPqjwTOmDxC3YPgqHkrzc7q57LRs3Yvrb52v2
         gawlrXhuyjnVq8D02sxl+jsCPXwvRyI28JTRXhyK7/2z4HNiR7LzIMZ6IO3nGyqIOizM
         VFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768974713; x=1769579513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=saJl4uL3MrSVK5nhxdOmwKURYZi0uIqWnl/khLUQqYg=;
        b=pEPTn7rOidASmQ3uBLKHYE3XjZXTRIa+gKzRe0i+bm2ALlBlcgBdcsOmbmKnuC/6mK
         Jw/aQxJteOtrwH1Wl4sgVaAYgSxaggET8QM2spg3t5oZYZ9tUEelgesNQDDRxWZuyTXx
         W+chk1Fh6AEJChmrjm7sxNw+wi0dytsNHlMe0nmZny3AhYPejHrHNafOVDMlkyZgcixt
         qq2A0kmd2hEQxRspaDZT8uZumMwjQ5ofwEdQswWmjxNHmzsjuQaEs+VyM5spKlKBO+Cd
         ZMIC6k14joAfzO9pOD14EC4dRedJWJZ+c9ptTa4b2l4BUqeLQf6r1gpkjje72DAq/+6D
         bs9g==
X-Forwarded-Encrypted: i=1; AJvYcCWsCcf2osV5MD0tOChPo+TIxMXs5PuyqzWWGFiCbD0jY+k2QxHQXob98+ECfie0n468LgVpEoHX02sLQu3l@vger.kernel.org
X-Gm-Message-State: AOJu0YwBt9DWKKFlWo3jCJqTsK6se6BVeiK7J+vcGOVX+ugsulCELR7Y
	jq4s7rT/R69lOJEzRzomPkCwZ16s7zio6koRw2rmZ9EGEnRQ94mLlrtJYzi9Mo+HFftWIl+ikn+
	rmBev7QRhQEvqBM/hT7k/6w/UtZohvNqklzy+2to=
X-Gm-Gg: AZuq6aKjS/HliEZNAUGwQKkT7dnO9snt6X1wB4Ub6/g1kUuGZXOevYbsZQaUz4s4hqV
	ZMIfByf4weLKAy6iKG2kNqX/w8DDDZMu7o92pAXYs7gMje+vtsY5XoypvhfxRVl4ENnCCaHFl6d
	6xXR0fEAqgZSRruw0bGjhgN+dm4rpaEEVf/PhbaIHqi9Bvi0FYzeyEbhEmYeoxPFjES/6qTLYaB
	W9mHvV8YRso1HbHkP4LnuDNpfy9QZU0BEAd/n9rOJjfRPHQgYVSG6iMYCY/IB7j2GO3kg==
X-Received: by 2002:a05:6214:5191:b0:882:42e6:171a with SMTP id
 6a1803df08f44-8942e48897bmr257726896d6.29.1768974712843; Tue, 20 Jan 2026
 21:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com> <aWmn2FympQXOMst-@casper.infradead.org>
 <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com>
 <aWqxgAfDHD5mZBO1@casper.infradead.org> <CAJnrk1YJFV5aE2U6bK1PpTBp5tfkRzBK5o24AhidYFUfQnQjNQ@mail.gmail.com>
 <20260117023002.GD15532@frogsfrogsfrogs> <CAJnrk1ZSnrMLQ-g4XCAhb1nXBWE_ueEM_uTreUNxuT-3z_z-DA@mail.gmail.com>
 <aXAmwHNte1TvHbvj@casper.infradead.org> <CAJnrk1Z-eTJGMEJfAcJG0T3gwVcO7C1vayYaK9Rb3POar2=Jcw@mail.gmail.com>
 <aXBZN2tzg5MyrnAb@casper.infradead.org>
In-Reply-To: <aXBZN2tzg5MyrnAb@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Jan 2026 21:51:41 -0800
X-Gm-Features: AZwV_QjMoSZ6mHdAAEuAIytH39nNhswDOWXRfo1erCSabczFrJwJaVIGvn_MOJI
Message-ID: <CAJnrk1bCVJ7JY2ZEn1OO0wJpX6FHqhfX9J3NLVuwjdj0AtYg7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, hch@infradead.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74779-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,infradead.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C4A4051BB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 8:42=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jan 20, 2026 at 08:12:10PM -0800, Joanne Koong wrote:
> > On Tue, Jan 20, 2026 at 5:07=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Tue, Jan 20, 2026 at 04:34:22PM -0800, Joanne Koong wrote:
> > > > But looking at some of the caller implementations, I think my above
> > > > implementation is wrong. At least one caller (zonefs, erofs) relies=
 on
> > > > iterative partial reads for zeroing parts of the folio (eg setting
> > > > next iomap iteration on the folio as IOMAP_HOLE), which is fine sin=
ce
> > > > reads using bios end the read at bio submission time (which happens=
 at
> > > > ->submit_read()). But fuse ends the read at either
> > > > ->read_folio_range() or ->submit_read() time. So I think the caller
> > > > needs to specify whether it ends the read at ->read_folio_range() o=
r
> > > > not, and only then can we invalidate ctx->cur_folio. I'll submit v4
> > > > with this change.
> > >
> > > ... but it can only do that on a block size boundary!  Which means th=
at
> > > if the block size is smaller than the folio size, we'll allocate an i=
fs.
> > > If the block size is equal to the folio size, we won't allocate an IF=
S,
> > > but neither will the length be less than the folio size ... so the re=
turn
> > > of -EIO was dead code, like I said.  Right?
> >
> > Maybe I'm totally misreading this then, but can't the file size be
> > non-block-aligned even if the filesystem is block-based, which means
> > "iomap->length =3D i_size_read(inode) - iomap->offset" (as in
> > zonefs_read_iomap_begin()) isn't guaranteed to always be a
> > block-aligned mapping length (eg leading to the case where plen <
> > folio_size and block_size =3D=3D folio_size)? I see for direct io write=
s
> > that the write size is enforced to be block-aligned (in
> > zonefs_file_dio_write()) and seq files must go through direct io, but
> > I don't see that this applies to buffered writes for non-seq files,
> > which I think means inode->i_size can be non-block-aligned.
>
> I think the important thing is that a block device can only do I/O in
> units of block size!  Let's work an example.
>
> Lets say we're on a 4KiB block device and have a 4KiB folio.  The file in
> question is a mere 700 bytes in size.  Regardless of what the filesystem
> asks iomap for (700 bytes or 4096 bytes), the BIO that goes to the
> device instructs it to read one 4KiB block.  Once the read has completed,
> all bytes in the folio are now uptodate and the completion handler can
> call folio_end_read().
>
> If we were on a 512 byte block device, we'd allocate an IFS, do an I/O
> for 2 * 512 byte blocks and zero the remaining 3KiB with memset().
> Whichever of the memset() or read-completion happened later calls
> folio_end_read().
>
> (some filesystems zero post-EOF bytes after the DMA has completed;
> I believe ntfs3 does, for example.  But I don't think XFS or iomap does
> that; it relies on post-EOF bytes being zeroed in the writeback path)

I see, thanks for your patience. Basically what you are saying is that
it never makes sense for a filesystem to set the iomap->length value
in ->iomap_begin() to something that's less than the block size
because all I/O submissions to the bio layer have block-aligned
lengths. That makes sense to me.

(btw, I realize where I went wrong with the zonefs analysis above -
the zonefs doc [1] says for non-seq (conventional) files "The size of
conventional zone files is fixed to the size of the zone that they
represent. Conventional zone files cannot be truncated". which means
the i_size_read() value for zonefs is always block-aligned).

You were right about the if check being unnecessary, I'll drop it.

Thanks,
Joanne

[1] https://zonedstorage.io/docs/filesystems/zonefs

