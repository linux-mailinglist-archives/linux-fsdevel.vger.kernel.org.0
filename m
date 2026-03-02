Return-Path: <linux-fsdevel+bounces-79075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKWaM80EpmnvIwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:44:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F01E3E6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 22:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A2D3652B91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B34A1399;
	Mon,  2 Mar 2026 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfCPKsbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B613EB7F3
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484669; cv=pass; b=jdc+EG/3MC7NglfXCh8jczLIJB9nl5+aHhDMqsQKpK9v0h+ZKRzmbjhY47wrc+8DzzlVWRmHjF3eqpQz8qJ/vwpRb3qnzGsslUUXceirmikrQ0sBnsH+ts8vGJJRzjD3Pxearm7+rQ1Z7FDjY9SqGQ6a9o/cBTl1qiwhFW04AXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484669; c=relaxed/simple;
	bh=Grd75yg8mqZzcMhBlNr/lnqnPYxkrEFEkRinmwlM06k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKaPBuMpsMEP3F3XHMBnlUFDiRqNRgfvS7p8KsbSDyNUBzhe5OCAS/Sbmkf8ooi8C4PJtFvHdwSP5nfd780P5UWk1J0lIDMoBadF72jAcDi7Wyi1PweQT+1Md10QNU2Ch1MY526cbZkQQsqfYb5Crl1BlKrke4oDKlV8SBJk7os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfCPKsbB; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-503347e8715so61733971cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 12:51:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772484667; cv=none;
        d=google.com; s=arc-20240605;
        b=PPv7oWYgGHec9dhG9sIBg/gQhCGxwQHk/nE5S2bBmXrGGDsyJ8ruzx4wnEJfdI9KC5
         uUtJZdMbaPnAvYZFGK+VWECk15WKAt6bkBOC/1/V32kBbOicKrab1q8ouHtumUwHdg4Q
         9QNKT+LPuSz+kHrb4k9cSArGUzEJ9cs1RIHjKsVPMkuK9rkBFNg081vrsn3LT8EZs16l
         MAmgPEkKtO625ISQrz1LbuDt7X2FMDtmE6yqHyllhmonvT8ZBd3b9FYVa7HeAsyNYQfk
         jDVXaCQXDp7p521uVu2j+0xB9ybkQxcrAC1ZlF0lgUZaARm0fBEAVcYzBgl6EsjWc8SY
         y7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Grd75yg8mqZzcMhBlNr/lnqnPYxkrEFEkRinmwlM06k=;
        fh=OG6ts8oUtgt498zru9masTrZAUkD+E0H4HGix18t6BY=;
        b=bdZBUS0fZj+5J67QFEb5Q003mJ/y7PEBeK2b7XzYSuVucdgYy9wMHxLjRDvbW45Q9u
         lNy1VPFuYiKn0gu9J4nGW9GeHb8oeXIkp86NUvprloTFs2KznOpONH2Pfg4W2uhTHzzI
         0WUx43miEDsAo6Dd3j/wHxaMeuEu++Q+A5ieQIA6eIYYNA+wbsLCqHH0ep/I6LpvtRaa
         jPoeVBlNGevraa+RuhCoDSlJh2Vat/KPbnkbES3xOaxsVmPNOvY69TAd1+Swo1q56fkW
         Elv0xgUQduvwKWpDa6z6RlLeh/k+VucQ2nbJMnLmc350ZD87sc2leY5f67mXnpod0tMR
         xSWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772484667; x=1773089467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Grd75yg8mqZzcMhBlNr/lnqnPYxkrEFEkRinmwlM06k=;
        b=kfCPKsbBO7D2c4TRbEs1J9d43+veuSBB8tN9W3JOT+3NDEgZGQtQPQnd5ObS9w+CE2
         Idevi8v7bIRfprtXn5ysm2ca8DY+P1kas/Ac5FJLCNF8n9HMXsJ+x1HbY25f9CbRN4c2
         v8D6MXoJF9H81XKzTsTsI0cuNPWu3hc4zU+IHVoYBscCuJUvmLSHneqfpjK5GFOmdZ6O
         YtjKtwrAuGOrr5QCPGjO+vrAq3YhvYBbkioAxsKqk5fo9BPnQMT3Jh/LCRVNZqx6KK0O
         nSwftE4JYesO3a2Um5PILBpGvZnouiaVaobdUSM1Dnkl6OfBSm+Rtnzc8munKpF0hTlc
         EzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772484667; x=1773089467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Grd75yg8mqZzcMhBlNr/lnqnPYxkrEFEkRinmwlM06k=;
        b=F7N35s7FiBtr3uVLrTMDDOmh5JoarSwYPzOnrEFYxsKiYj50kQ3MeB8iooV0BWEMJV
         SV2kdBVPlV9Z4o7h0GHK/OFkCLJKWml5DfR5gfJ4npQ1EOttKV6xBZFda3aw3n+dP07L
         BCQF7dmvfk/jdhHquLKqVjVvaFkvqt6n/Bl3qUOtZBw6RNyv7sItOXf49MtDmy77Twd/
         Y0L/J43imI2mtUhyOze94xOtlP7koLKXiVrxbk5//Ocxq+iAmQJajiylaT+1mBJ4EXkH
         Ztg/8KBCYoUj/x52czN+pPey6IoBhi8QIWUXDnIKwAXXSov1yECWVrwamJ6RELp3BMlK
         d1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXy4CYlY0xtlkzPVbL3QiY100LiJqLBimXRQ4X7SR9qzWvBnE21AYPQzDiJ/6H5L69GKV+xtpGmfalHieo+@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMpUpE9QEn5HyQWuyaewUTSUOpnLFF/rOR4jB3cPe1ZsC0jSl
	sV6p3+vUsnWZQlQx1RG1iVfjk9YWLAw7DissipnpO4aTQcwJanxoWZpQqPcCfCT53FV0tqz+0ok
	LRO6kyZSbGg52JpCYUwqBSvuma7TF4f0=
X-Gm-Gg: ATEYQzwZy2t7lax7vAEV18UPPV8/+HYPLfdTK4YCuYfoNRr2oEcjKRAXQ8Nob0jidoY
	BtRmfHIFHLYml8e+bvG1RLVAqOdA3mkieLoR1dsk1P/BWSItj89Gtmgav6Tnurf9BK+7WngZCOj
	hrszPwOQUxZ3Bnd2bCCS02CAQIrvK0TK82STjFVgRNih5cjXo3ve8eDqmFIt/rjo+X/9fDke7YU
	x5QdgC5slXs2SB+6SOgtbD71ECrbpNvrfXFAplMxqtU/QOXnM8zd4yk7DQSE4NNZGoQFkrvRtYv
	bzsMtw==
X-Received: by 2002:ac8:7dd4:0:b0:4b6:24ba:dc6a with SMTP id
 d75a77b69052e-5075288b53cmr197970821cf.38.1772484666751; Mon, 02 Mar 2026
 12:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com> <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com> <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <CAJnrk1YoaHnCmuwQra0XwOxf0aC_PQGby-DT1y_p=YRzotiE-w@mail.gmail.com> <ae3d2ea3-c835-495b-a033-01a5c9fd82fc@gmail.com>
In-Reply-To: <ae3d2ea3-c835-495b-a033-01a5c9fd82fc@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Mar 2026 12:50:55 -0800
X-Gm-Features: AaiRm526hb7YHQWxnq7o7eJG4e2BQ3x8tecN_hAW1I64CwsrBGNyIeDc1ZJPqls
Message-ID: <CAJnrk1YGaF=5TOgeUo34=iOYRdxz+xBEwg7+A=2QjTBxUp=c4g@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: axboe@kernel.dk, io-uring@vger.kernel.org, csander@purestorage.com, 
	krisman@suse.de, bernd@bsbernd.com, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 332F01E3E6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79075-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:48=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 2/27/26 01:12, Joanne Koong wrote:
> ...
> >>> Regions shouldn't know anything about your buffers, how it's
> >>> subdivided after, etc.
> >
> > I still think the memory for the buffers should be tied to the ring
> > itself and allocated physically contiguously per buffer. Per-buffer
> > contiguity will enable the most efficient DMA path for servers to send
> > read/write data to local storage or the network. If the buffers for
> > the bufring have to be allocated as one single memory region, the
> > io_mem_alloc_compound() call will fail for this large allocation size.
> > Even if io_mem_alloc_compound() did succeed, this is a waste as the
> > buffer pool as an entity doesn't need to be physically contiguous,
> > just the individual buffers themselves. For fuse, the server
> > configures what buffer pool size it wants to use, depending on what
> > queue depth and max request size it needs. So for most use cases, at
> > least for high-performance servers, allocation will have to fall back
> > to alloc_pages_bulk_node(), which doesn't allocate contiguously. You
> > mentioned in an earlier comment that this "only violates abstractions"
> > - which abstractions does this break? The pre-existing behavior
> > already defaults to allocating pages non-contiguously if the mem
> > region can't be allocated fully contiguously.
>
> Regions has uapi (see struct io_uring_region_desc) so that users
> can operate with them in a unified manner. If you want regions to
> be allocated in some special way, just extend it.

You can't say "regions shouldn't know anything about your buffers, how
it's subdivided, etc" and then also say "extend the region uapi for
special allocation to make it buffer-compatible". If we extend the
region uapi to specify contiguous chunks of size X starting at offset
Y for len Z, that is basically encoding buffer layout information into
the region. The buffer ring already knows buffer sizes and count - it
is the natural place to express contiguity requirements.

Pushing this into the region abstraction muddies the uapi and forces
awkward indirection where callers now need to manually synchronize
region chunk specifications with their buffer layout. Memory regions
are generic and will be used for purposes beyond kmbufs. forcing
buffer-specific allocation semantics into the region UAPI pollutues a
general abstraction with domain-specific details.

>
> > Going through registered buffers doesn't help either. Fuse servers can
> > be unprivileged and it's not guaranteed that there are enough huge
> > pages reserved or that another process hasn't taken them or that the
> > server has privileges to pre-reserve pages for the allocation. Also
>
> There is THP these days. And FWIW, we should be vigilant about not

THP is opportunistic and not guaranteed. It depends on external
factors like fragmentation, memory pressure, system settings, etc. For
high-performance FUSE servers where deterministic DMA efficiency is
required, this doesn't suffice.

> using io_uring to work around capabilities and mm policies. If user

This isn't working around capabilities / mm policies. The user isn't
getting contiguous physical memory to use freely, the kernel is
allocating it internally to service I/O efficiently. Providing
infrastructure for efficient DMA isn't a capability / mm bypass, this
is standard kernel behavior. When userspace does i/o through sockets
or block devices, the kernel routinely allocates contiguous memory
with dma_alloc_coherent() or alloc_pages() with order > 0. That's
exactly the point I'm trying to make - users shouldn't have to do this
themselves (eg going through registered buffers with user-allocated
buffers). The kernel should handle it internally.

> can't do it, io_uring shouldn't either. It's also all accounted
> against mlock, if the limit is not high enough, you won't be able
> to use this feature at all.

The mlock point is orthogonal. it restricts how much memory a user can
pin, but contiguous and noncontiguous allocations of the same size
consume the same mlock budget.

Thanks,
Joanne

>
> > the 2 MB granularity is inflexible while 1 GB is too much.
>
> --
> Pavel Begunkov
>

