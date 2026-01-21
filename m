Return-Path: <linux-fsdevel+bounces-74762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGojMyQfcGlRVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:34:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8130E4E8DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5850446F519
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B71295DAC;
	Wed, 21 Jan 2026 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6BLBzGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE31F1315
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955677; cv=pass; b=UpLjt36L7OXB73eJN82AFqUHHZ9Sfz7/cwgVlvOMXEKBSRoQmIdxWe1b3cOx2+8aN9n9IuNm2s7hsrY3FshSOWrLewTIYQW/kJrNaShFTJNmQM1I7KCwU1xhw0kC4RtstGEToHj3ANZjx0hHzctY9dcn1z5KtzcRXIyM+icFSpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955677; c=relaxed/simple;
	bh=3CzPQtdW256f8hxTQvnVJA9/1PJ2nCHhcrodK/xt38c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjSNecEHfHfP4OR6HfqHaL2VYddg1bP/jB5ctkEwwXtAPvcwrO/wiig329KdPmdsObuI39JykgES7xh3dc7XzDncUpKSIv4v0J8uHhBLqM9hBQzssFvFdyMX4M2l254EhimLWqnqEx+DDLmcfhErF0qdRh6kn5WJEd737PQ7PVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6BLBzGz; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8888a1c50e8so72265216d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 16:34:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768955674; cv=none;
        d=google.com; s=arc-20240605;
        b=dTRLauu0MEd32OO9zh1OGBTkPcQ+c6vZK1k4G31UUesbQa3bw0c2KJEJYdPlPpwDsa
         cn4YJdqfkKydtpktJupSJcD7Q/2FYhyIAO8BX+JJaf+ItG3B3UrcR3eXcyJ+Xj1N6sGH
         1D6hF9THdHVBGdHowOKx3vqkUK+WzQAiebHxk6B9tdnLrNIMMK49WulJMUgII+hfMwnO
         qRE0W8oXUGhJAhKdiArWiM4RuUd7Bq4RBW/aKMR375fGAlm6raed7pcWZSM4iMt5H9dE
         6HvuEo0goT96hOBHdoXkmAYxcB50nGbBMVQ2hIUjipZ0pXDz+1vfDY1d3GOa9d1QqA6G
         CAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=quDTzUFqKEGFx9hVAt/ijTXktYC+JndpD7xKzFhDY/I=;
        fh=G3AK3WOBC4+YxCjBNLsgT9ndQ+xil0ADD7XM0kaoaHM=;
        b=DG5aa1FS1Uv08qZw+kSVqZ/Alg5+lbcsPbfhFzVHkQKcDn+7YM4D57Io/4eslHbWVR
         ahTVf+lKPGNApEiaUyZMGYNDG1Pw4foAWwaG0+pRbM7VW0SpZgTcF+TIWVGlDGzUm1Ze
         TgW6bKTLPbiPbGpzwhxATjnutwx+Qe9s1CXOAyN179TvVHqsNaPZT97DVV6ZoDbNDdC1
         50Dik6zwEVkcz+mOj9sM3U7fpD6x2CxJeMerdSyScE84L/DS1uTVhDlOpSJZnrsV5SvD
         kTZLAl3JLYEqIrFz//qGRmQFoPU2cLDuoO+O8my6Ij2qRiO0A2itGfeBruplxhu1HVpA
         k9Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768955674; x=1769560474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quDTzUFqKEGFx9hVAt/ijTXktYC+JndpD7xKzFhDY/I=;
        b=I6BLBzGzngbEy9sGhz+2LbfkZNbv/zyjkF4yL3R+cnTiI07R+v2IzV3m6oEKIehWYK
         l/htBMEhOk6fmRhzUuyWP9JJQVT5yuyDVAdtdEUeq0dF4OdueviReSSCTnxPXSJpspAB
         MkU3rjqsegKypDBbbY60IINjcs/sqvfweXXqZ8uQkmRsvUAdE/U/6SlCQf4cfIv547Zo
         h8Mnr08DJPduhDa3whToD8oIwtUmyrg4W9cvbac7O+onZKUu4vXA6TWucmWsVN9DACfl
         +KqTSr3aMwUHYVqR/hVVaQG5zzIVrZlXcbfzFDSQ+YCRCeN6mnAV9S5KMG5eune1Lsqg
         Atog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768955674; x=1769560474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=quDTzUFqKEGFx9hVAt/ijTXktYC+JndpD7xKzFhDY/I=;
        b=ZtlYDBaNi1AqoCpP4ggONYoY4yGW2Ti7UQgeMBadOlKpGCu9QmHClxtLsDJGzcImjN
         6HEJmPzvHCZAwqbUMoCJ2W7CZmtpB5reIxq6zCGKICGHSIj12aKNF6q+TBZFYXCNOXM4
         7/UbQ3GidOlq/NhsC5bOzesFl8FbHnoYAPGgF5yAnjhVwC1+hzIlUN/O9BCg4HDyuor8
         OWjIAQDMXeC/kDhNKOsFgkcDlA3+sHB1I8v1f7OJXViDJJDhFrvdoUhGTxh7O29WNJ70
         QGSoDVOtgQNUlh76F3KXBqLpVJjANfmHuTfrSGOcEetikrFHHL72zfrLoEx5OWjRRJfR
         jpaw==
X-Forwarded-Encrypted: i=1; AJvYcCUYPibEoo3tofw5esNPM7KFk5ZykS7hgbiCt2n4J4BsiwMCVon29h47W7luZraRQpHXvGgSbGQmDQzLoonp@vger.kernel.org
X-Gm-Message-State: AOJu0YyNDw961P4ua7tun4MIJlu2ydu+g58JXkzmfAVhRIo05dIhuuky
	+7Sl3QF0+9zyQGLzMbOp+a/+fKQSvagKSqoFbraSI1sHEK5BENpVLhSpcEcNljz71KWx6m/IwEA
	cfyEbD3ymemTDPoAolJoIzaE6J2Jc5lA=
X-Gm-Gg: AZuq6aJgAXC9xz1JxtjshIB1mLeWdagHGWXHRTyGaHAqHAXIf1djVpS5Sc4euSi+021
	wSxYf8IeGrnpBBNu7AF0z1X9TFOcY8QZeGo18zVjXO8iUCeB1P95sWECkrm8oeVfo9AXKlR9zSZ
	Cfuta1fYriYQr68Yi7IGoyHHCEGTQfjJjL+xVHly/y1+aE9wZUNNDCEy32FkHB2QXvSPGdYcr6J
	cb1sx93DrJplqIqfPEXvw3CBtaBwV3aF+YL6UCXEQ/JARUjlpPlW2GtEhXcss793u+5ZLRCr7rC
	/LJl
X-Received: by 2002:a05:622a:8b:b0:4f1:bacc:151 with SMTP id
 d75a77b69052e-502d85802f7mr48176501cf.60.1768955674551; Tue, 20 Jan 2026
 16:34:34 -0800 (PST)
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
 <20260117023002.GD15532@frogsfrogsfrogs>
In-Reply-To: <20260117023002.GD15532@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Jan 2026 16:34:22 -0800
X-Gm-Features: AZwV_QiMrv7MWxkX7ly4586N0kpsI_srQExQPdQn49V5qRBTss_rcXXoiD69ClU
Message-ID: <CAJnrk1ZSnrMLQ-g4XCAhb1nXBWE_ueEM_uTreUNxuT-3z_z-DA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org, hch@infradead.org, 
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
	TAGGED_FROM(0.00)[bounces-74762-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 8130E4E8DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Jan 16, 2026 at 6:30=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jan 16, 2026 at 02:02:20PM -0800, Joanne Koong wrote:
> > On Fri, Jan 16, 2026 at 1:45=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, Jan 16, 2026 at 10:36:25AM -0800, Joanne Koong wrote:
> > > > On Thu, Jan 15, 2026 at 6:52=E2=80=AFPM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > >
> > > > > > +                     if (!ifs) {
> > > > > > +                             ctx->cur_folio =3D NULL;
> > > > > > +                             if (unlikely(plen !=3D folio_len)=
)
> > > > > > +                                 return -EIO;
> > > > >
> > > > > This should be indented with a tab, not four spaces.  Can it even
> > > > > happen?  If we didn't attach an ifs, can we do a short read?
> > > >
> > > > The short read can happen if the filesystem sets the iomap length t=
o a
> > > > size that's less than the folio size. plen is determined by
> > > > iomap_length() (which returns the minimum of the iter->len and the
> > > > iomap length value the filesystem set).
> > >
> > > Understood, but if plen is less than folio_size(), don't we allocate
> > > an ifs?  So !ifs && plen < folio_size() shouldn't be possible?  Or ha=
ve
> > > I misunderstood this part?
> >
> > Maybe I'm misunderstanding this, but I'm pretty sure the ifs is only
> > allocated if the inode's block size is less than the folio size, and
> > is not based on plen. The logic I'm looking at is the code inside
> > ifs_alloc().
>
> Hrmm.  If there's no ifs then blocksize =3D=3D foliosize, so if
> plen < foliosize then that means we're not fully reading in the folio
> contents?  That doesn't sound good, especially if the folio can be
> mmapped into someone's address space.

I think the caller is the one who sets the lower bound on how much of
the folio gets read in (since plen is min-bounded by
iter->iomap.length). The calling filesystem shouldn't be setting the
iomap.length to less than the folio size to do iterative partial reads
if there's no ifs, so I added this "!ifs && plen < folio_size()" check
as a guard against this, as I think the bug is subtle to detect
otherwise.

But looking at some of the caller implementations, I think my above
implementation is wrong. At least one caller (zonefs, erofs) relies on
iterative partial reads for zeroing parts of the folio (eg setting
next iomap iteration on the folio as IOMAP_HOLE), which is fine since
reads using bios end the read at bio submission time (which happens at
->submit_read()). But fuse ends the read at either
->read_folio_range() or ->submit_read() time. So I think the caller
needs to specify whether it ends the read at ->read_folio_range() or
not, and only then can we invalidate ctx->cur_folio. I'll submit v4
with this change.

Thanks,
Joanne

>
> --D
>
> > Thanks,
> > Joanne
> >

