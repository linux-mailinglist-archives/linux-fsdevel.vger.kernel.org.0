Return-Path: <linux-fsdevel+bounces-75145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBUBM5l/cmlElgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:50:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C61526D448
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 20:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BEB33002F67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95E385EF4;
	Thu, 22 Jan 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKFKDnRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884237D100
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111441; cv=pass; b=XH6yt5byjx1eZ3Wy7dV1c49hhYJjyAMNIPz3djEj0agNGAd7yS5Mx9Ej+yVVnhHkrIKojmMl9wDhuTxo/AJrj1AGJsy7Say0IxxbhWO+iPb+ydz8o3+/uKJcwe/faerYBVaWUgM0EPsOUA6ICMJpfiGczUhd7VNeVM5GlPp/g1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111441; c=relaxed/simple;
	bh=KtjOwdzIV06syq133xx6qvxfCcYMr7Qj1Ozend8nKUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QumOtm1lylABz9o9xLXMyMXL2wO6xRI9TR2yA5LNk2IDuunWu/o58RC0FTuPQ0hLEAKt8L/Nmm33bM9TZCts4v2CIRItGx8UqwHvTy7ZzSY8LxCGwZrrPXzg7pEH7PnWRq6h0xI+FUKIkOfu4eDjNl31NlqPdYs0WsgHunA9FTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKFKDnRl; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014b671367so14615481cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 11:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769111430; cv=none;
        d=google.com; s=arc-20240605;
        b=P6XHIuy4PTDStZW3Sc6faUEEa4rjBdxKFDzIRFZPXFLz12dVWhYPidcoYmePQ/jjzF
         RpfTrqsGMCQNe9ZuD/3t7MfBF/DdlXALX55Bt32g97fOMKdEYU5U77fLBq3rvZzCEZyx
         qNUmzF1nh0KKEUaG8uUHjlVlPhlEEJzQQj2aSIraqaSPjJ3YwpTg/QmibDsA9gMfhK23
         QTpCll5y7t1i8dqxRjrh3cJi2sRLodj/6UDv13Ytn5kZKFVgd2LBhdEZqedB7fFWuEE/
         zgO/IUp8QC93nVV76vly1rTTqDcmZ2RfGFxpack8xPYIIQU25imwqRFtC++sB44T8R2b
         gy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gk6DDU3i0zot/n0cGaRTGGyOl+oQqEmAy5/8brffz3c=;
        fh=J9Gv9BHB2UUI9I38xJ8+FDC2ULLHST2r3NMArsg923A=;
        b=gL6WUi7dItD0f2RC7S4GIoRq+7/51EUFM5SKRxNtHD1IBlUIQQT3txI+aJK6N/mTNt
         HMZttqQv9YI6ZqMgVjCTBytq/OVekuPVomilCkMheH/iXDyDmHnyKLmOXCsmWgHheox+
         D5jL9AexWhGWyG0HhaEj3Hpwhriy6FYv7oAfhok7R83i1qgeA7VYyUN9zZTIUWZvIg/t
         RN7vBYGXDKNWxiU/yz6hoFWMt05p412rNB2HTVqcEPyFRCgvAB0xG7hwr/umj7zLQl4x
         /CLLBUIuT9hZeimeffOubQPfSZXmYk8xZZHpYsPTy+S/mCe9Xx5YLJ/Laa6B9N3loAKP
         3QLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769111430; x=1769716230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk6DDU3i0zot/n0cGaRTGGyOl+oQqEmAy5/8brffz3c=;
        b=UKFKDnRlGHuCOu4Hth8zAtyBVGla5POfK/9yZ854P0oN/bXeCsZpsEg9MrgLwjTlLD
         4Q7dBBLu5++ci+vKpPs0CLP+GPGodYjvUj9fRofbZFUzapkCrEeE4E5PVpkVbtl5Fg45
         70ZRSQPLa8v46riMYq7TQBPY1J/0cDctl8QtX7udswtQ0NGaoVG82FW5Z4d14pG/hIH6
         n11TxCSqoc0LNOmoPQSxKNBRH3KffULMBtBfBiGmYMJw9mNtP+LDg5cvkvyHCTyFMIrh
         9lXDMxCyd5BSwTWyzhQ2DhrBJd0UoGI2p9OVI7s1ieMQ9TYBQQE71mEqcRUqpC2Hulz6
         QNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111430; x=1769716230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gk6DDU3i0zot/n0cGaRTGGyOl+oQqEmAy5/8brffz3c=;
        b=CezCqehV0n0iRoXWaV/G6Oy4xgmM0ww47aXjnjY/Rr9hjATkIThFR5wOeIiMKbxMRg
         ++evORQluxGM5CNocxd2OGSvZZJJ3UGGKOVL75osCO38JBepofhypJvXzIjjj4mIkt9a
         40kmpoLOGI2v3jALxpSAqNnYElT3eIQBzN/nfGLLJYFwbNsIitsZShYXuvil3ccgILcd
         AXIYRud6WOpAnR1tw9R7Hx4cVRtc6Zuyf9G5C3ZDzZ8peECte2GBMpbD6yXyfVg50/e4
         GiBWwkWO2AP0OjSeVDtD2awLvUqNdXWUV9XV9FB90KDoFmqMwdAstgUQBk0tz3T9WXqF
         S2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXbGrnghOM0ADydmeTffOe7n8hD/PRiRoudpYwrD1YimSDZANvQ55OSEFBYPdzbKnJen+ytGlLRK63k3+b@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34ZevLbh6pftfD5lLhdwqkfhOHpl9Q8jONj2fB8ZURIXBRte+
	IU5nWPGfnkVmjeXUdH9W+KI0H1eAh15fDITF8hHR0nhsrUY12+CJP10Opse0JOY279xFS6qJJFj
	B2y9pZIGV/oNWid+O9S1NdKfguAZzu30=
X-Gm-Gg: AZuq6aJH0ApuZz8oxgK0hpZYiiINXYMiGD+7xHP/wL0XXLN+8KmkR1IBJzExzj+ntio
	gCaH7nbcGGXgbGxHqLvckI+ajEX45dlQJoCM0BlkTZmIoQW0FZz8TZpDkXbXUqdH4kGKsSd6KEu
	66wQ5lzLQGouDLelFPxCAwwkv9ILFF3KJOTi/fWJk8+ju79p8p0bUlL1lkf78uIukALADlpxWEB
	WhkeiJy9FDQ2tk02u7BCShWiokJN6JGuxjkMk24hSYo68gwiyglj9+vkdr5tWR7klLFto7Zi/bR
	r+0F
X-Received: by 2002:a05:622a:9:b0:4ee:24e8:c9ae with SMTP id
 d75a77b69052e-502f77b8abdmr12322581cf.53.1769111430137; Thu, 22 Jan 2026
 11:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116200427.1016177-1-joannelkoong@gmail.com>
 <20260116200427.1016177-2-joannelkoong@gmail.com> <aXCE7jZ5HdhOktEs@infradead.org>
 <CAJnrk1Zp1gkwP=paJLtHN5S41JNBJar-_W0q7K_1zTULh4TqUw@mail.gmail.com> <aXJVlYkGKaHFFH9T@casper.infradead.org>
In-Reply-To: <aXJVlYkGKaHFFH9T@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 22 Jan 2026 11:50:18 -0800
X-Gm-Features: AZwV_Qhmpf5R2yJHj1eXyXCx0qvmrfkdiPyc64ZRdSW7upQdPIVLBuemRunfxm8
Message-ID: <CAJnrk1Z083d_SXB8uk5oerrdyezDY7LqcqKcir9r02GUmRAU6g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] iomap: fix readahead folio access after folio_end_read()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75145-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C61526D448
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 8:51=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 21, 2026 at 03:13:35PM -0800, Joanne Koong wrote:
> > Thanks for taking a look at this. The problem I'm trying to fix is
> > this readahead scenario:
> > * folio with no ifs gets read in by the filesystem through the
> > ->read_folio_range() call
> > * the filesystem reads in the folio and calls
> > iomap_finish_folio_read() which calls folio_end_read(), which unlocks
> > the folio
> > * then the page cache evicts the folio and drops the last refcount on
> > the folio which frees the folio and the folio gets repurposed by
> > another filesystem (eg btrfs) which uses folio->private
> > * the iomap logic accesses ctx->cur_folio still, and in the call to
> > iomap_read_end(), it'll detect a non-null folio->private and it'll
> > assume that's the ifs and it'll try to do stuff like
> > spin_lock_irq(&ifs->state_lock) which will crash the system.
> >
> > This is not a problem for folios with an ifs because the +1 bias we
> > add to ifs->read_bytes_pending makes it so that iomap is the one who
> > invokes folio_end_read() when it's all done with the folio.
>
> This is so complicated.  I think you made your life harder by adding the
> bias to read_bytes_pending.  What if we just rip most of this out ...

I don't think we can rip this out because when the read starts,
ifs->read_bytes_pending gets set to the folio size, but if there are
already some uptodate ranges in the folio, the filesystem IO helper
will not be reading in the entire folio size, which means we still
need all this logic to decrement ifs->read_bytes_pending by the bytes
not read in by the IO helper and to end the folio read.

Thanks,
Joanne

>
> (the key here is to call iomap_finish_folio_read() instead of
> iomap_set_range_uptodate() when we zero parts of the folio)
>
> I've thrown this at my test VM.  See how it ends up doing.
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 154456e39fe5..c2ff4f561617 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -381,7 +381,7 @@ static int iomap_read_inline_data(const struct iomap_=
iter *iter,
>                 ifs_alloc(iter->inode, folio, iter->flags);
>
>         folio_fill_tail(folio, offset, iomap->inline_data, size);
> -       iomap_set_range_uptodate(folio, offset, folio_size(folio) - offse=
t);
> +       iomap_finish_folio_read(folio, offset, folio_size(folio) - offset=
, 0);
>         return 0;
>  }
>
> @@ -418,92 +418,19 @@ static void iomap_read_init(struct folio *folio)
>         struct iomap_folio_state *ifs =3D folio->private;
>
>         if (ifs) {
> -               size_t len =3D folio_size(folio);
> -
>                 /*
> -                * ifs->read_bytes_pending is used to track how many byte=
s are
> -                * read in asynchronously by the IO helper. We need to tr=
ack
> -                * this so that we can know when the IO helper has finish=
ed
> -                * reading in all the necessary ranges of the folio and c=
an end
> -                * the read.
> -                *
> -                * Increase ->read_bytes_pending by the folio size to sta=
rt, and
> -                * add a +1 bias. We'll subtract the bias and any uptodat=
e /
> -                * zeroed ranges that did not require IO in iomap_read_en=
d()
> -                * after we're done processing the folio.
> -                *
> -                * We do this because otherwise, we would have to increme=
nt
> -                * ifs->read_bytes_pending every time a range in the foli=
o needs
> -                * to be read in, which can get expensive since the spinl=
ock
> -                * needs to be held whenever modifying ifs->read_bytes_pe=
nding.
> -                *
> -                * We add the bias to ensure the read has not been ended =
on the
> -                * folio when iomap_read_end() is called, even if the IO =
helper
> -                * has already finished reading in the entire folio.
> +                * Initially all bytes in the folio are pending.
> +                * We subtract as either reads complete or we decide
> +                * to memset().  Once the count reaches zero, the read
> +                * is complete.
>                  */
>                 spin_lock_irq(&ifs->state_lock);
>                 WARN_ON_ONCE(ifs->read_bytes_pending !=3D 0);
> -               ifs->read_bytes_pending =3D len + 1;
> +               ifs->read_bytes_pending =3D folio_size(folio);
>                 spin_unlock_irq(&ifs->state_lock);
>         }
>  }
>
> -/*
> - * This ends IO if no bytes were submitted to an IO helper.
> - *
> - * Otherwise, this calibrates ifs->read_bytes_pending to represent only =
the
> - * submitted bytes (see comment in iomap_read_init()). If all bytes subm=
itted
> - * have already been completed by the IO helper, then this will end the =
read.
> - * Else the IO helper will end the read after all submitted ranges have =
been
> - * read.
> - */
> -static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
> -{
> -       struct iomap_folio_state *ifs =3D folio->private;
> -
> -       if (ifs) {
> -               bool end_read, uptodate;
> -
> -               spin_lock_irq(&ifs->state_lock);
> -               if (!ifs->read_bytes_pending) {
> -                       WARN_ON_ONCE(bytes_submitted);
> -                       spin_unlock_irq(&ifs->state_lock);
> -                       folio_unlock(folio);
> -                       return;
> -               }
> -
> -               /*
> -                * Subtract any bytes that were initially accounted to
> -                * read_bytes_pending but skipped for IO. The +1 accounts=
 for
> -                * the bias we added in iomap_read_init().
> -                */
> -               ifs->read_bytes_pending -=3D
> -                       (folio_size(folio) + 1 - bytes_submitted);
> -
> -               /*
> -                * If !ifs->read_bytes_pending, this means all pending re=
ads by
> -                * the IO helper have already completed, which means we n=
eed to
> -                * end the folio read here. If ifs->read_bytes_pending !=
=3D 0,
> -                * the IO helper will end the folio read.
> -                */
> -               end_read =3D !ifs->read_bytes_pending;
> -               if (end_read)
> -                       uptodate =3D ifs_is_fully_uptodate(folio, ifs);
> -               spin_unlock_irq(&ifs->state_lock);
> -               if (end_read)
> -                       folio_end_read(folio, uptodate);
> -       } else if (!bytes_submitted) {
> -               /*
> -                * If there were no bytes submitted, this means we are
> -                * responsible for unlocking the folio here, since no IO =
helper
> -                * has taken ownership of it. If there were bytes submitt=
ed,
> -                * then the IO helper will end the read via
> -                * iomap_finish_folio_read().
> -                */
> -               folio_unlock(folio);
> -       }
> -}
> -
>  static int iomap_read_folio_iter(struct iomap_iter *iter,
>                 struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted=
)
>  {
> @@ -544,7 +471,7 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
>                 /* zero post-eof blocks as the page may be mapped */
>                 if (iomap_block_needs_zeroing(iter, pos)) {
>                         folio_zero_range(folio, poff, plen);
> -                       iomap_set_range_uptodate(folio, poff, plen);
> +                       iomap_finish_folio_read(folio, poff, plen, 0);
>                 } else {
>                         if (!*bytes_submitted)
>                                 iomap_read_init(folio);
> @@ -588,8 +515,6 @@ void iomap_read_folio(const struct iomap_ops *ops,
>
>         if (ctx->ops->submit_read)
>                 ctx->ops->submit_read(ctx);
> -
> -       iomap_read_end(folio, bytes_submitted);
>  }
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>
> @@ -601,7 +526,6 @@ static int iomap_readahead_iter(struct iomap_iter *it=
er,
>         while (iomap_length(iter)) {
>                 if (ctx->cur_folio &&
>                     offset_in_folio(ctx->cur_folio, iter->pos) =3D=3D 0) =
{
> -                       iomap_read_end(ctx->cur_folio, *cur_bytes_submitt=
ed);
>                         ctx->cur_folio =3D NULL;
>                 }
>                 if (!ctx->cur_folio) {
> @@ -653,9 +577,6 @@ void iomap_readahead(const struct iomap_ops *ops,
>
>         if (ctx->ops->submit_read)
>                 ctx->ops->submit_read(ctx);
> -
> -       if (ctx->cur_folio)
> -               iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>

