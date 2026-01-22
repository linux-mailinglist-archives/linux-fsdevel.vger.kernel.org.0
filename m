Return-Path: <linux-fsdevel+bounces-75167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPP6CF+tcmmAogAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:06:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5946E64F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 00:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 180EA301D333
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 23:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42A3D34AD;
	Thu, 22 Jan 2026 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZLlMLP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC323659E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123157; cv=pass; b=bQaiFwuvqBYUepPyqi/YJXAauIoHe/YUnWffMFGM8/niYzDIYJwOnTwWBofVl5WpbVK9IIfhEMX0+kJI6ZRc3jKOT2vYchxxKhnf2a4+mJZtsd3K0Wi9GRhVpGLwG9kspF3uACbVzExZYn8q+AJ5hcbEdoKwBIVtFVJiQgq5/Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123157; c=relaxed/simple;
	bh=ln9LAuGGOcG0H6UfQVWH0rYYbTgionkpWd5k6/3yhOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EjYl0duDFU8oxiAds1lUDN9vacZDwwvsXJnUit0wSEiBcNm8VkIsrb845veSMGpFKkltouyCpqh+s6SwM/REBKotAbugzwQVlxEexG7MGiaY8+xFM5iZc6sFjYeGHOpIK5191/yemHusL0opMdndQ7V5YhpOOa9fJdIrODnBWOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZLlMLP0; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014f383df6so13603211cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 15:05:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769123148; cv=none;
        d=google.com; s=arc-20240605;
        b=OtGd1mY33wxTKxTR2RVGepf4Z2iK4D9ff3yWMNsPSfcXMajBn3P04IaCw/sw081t/a
         Pl5K9ubTdiIDqGlbzD51oTfDa3D09+1bMqtmhvfQ9MqBKRH1xBmh7ts/oC0pUr894Xc1
         jtiZ7lb4bJUQwUOjZGnxvZ2KzZbSq/j0gRuLscB4yApQIRU3pDN/XQ/0FpZp+AJYj+2z
         LcMwUb8oF2eJS+x3sCeCs1PxfexcWPo5vg9oZ7BDtnoUBSEKiTGOcHllddnyyCS7NuPA
         iz19eecyQHIfhfBA5d8Yo8pVBq/AWB2p7H3hdofCbl0gOdjh8BTYD48ySqUdR1Ugn1+j
         ubUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Evi6beMlg/1h8M+Z6i7lOwAnGZTdE414xf9yw4zACXA=;
        fh=114rI0ezvSqS5yqqqkIWQwaPKeey6vApdbmeqXL+iLw=;
        b=PKY1itgQzCVKLuHj9jEKnGnBqRQuERyoZgLLDfKaMY5g+jCGm1R6UYJdmczx73MHQg
         0a5Q82S52pkylCXdHxx+0oI/S1k3Kkm2OLBWUL3fgmYO11c/ICSRS8DT4InGqiBjrUjy
         PPNUl1PHB/f96jycBEQqbB6o49bt3Os7UeqRjXgubr5CQB1QeTbgW80q+WoEW1ZRPJNt
         xLfyI6vUYgSwpVLke3k2W92Bkbqg4XTJtiLW6JQeg/YehLvahmUA6pn4oY0f29oVWr2Q
         PCvfWO0glFCPBF66c4w//PahjSBrCj6CWDg3ff8vLBjaIv56RPIcuMc3k9m7q2YdXBgs
         8kUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769123148; x=1769727948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evi6beMlg/1h8M+Z6i7lOwAnGZTdE414xf9yw4zACXA=;
        b=iZLlMLP0VYOXNyeJ9mLe6u6HqOdwhV9QMf0WbZP59vkOLM7HaZMOPbRik8r6jl1nb3
         53JXP8gbDsYEP+TU6wVo5EBJsKtJl5QHWm6gQ9+s2zPIUDurUnHlTN67P6q6NvaZMRUC
         NFLlZQF3iSQvbB73656T4jNMWclXN7JDdIkiQ+E9waHz0a4/31I8bOzCBRDr4DN/PrVh
         QdLdqJnyPWVNeitubAxTBalgdHy0WotN2bXcykNXKIYoFU+LZzPfawCVHd2wJgze8PAi
         b86XKTUHzUe1zB7FIFogp2s8EjSD3ZR7vbV0W8PVjvb+0l34lFXXCAmjx0jKyg0nyXx6
         gtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769123148; x=1769727948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Evi6beMlg/1h8M+Z6i7lOwAnGZTdE414xf9yw4zACXA=;
        b=j4rghaOWpDe6Xq44fiUcGrteyf0l76VzOo4luQcAd6/tMdohv3yjcI6Kz22lMtqEwP
         thAlmcqW7ElrX4urWP15Y0DP0afYR9b2QT0odfgGbV+o6TrznthAbMTRxmTN5Cf4HDGt
         RVayLfyuggFFyTVvuOI5l0l9Dlitfo+PPh6IcSLZH9ifZzo7zdpXYkV306K02hZg3ZJ7
         xqMgaqEN/G9s5SlKQdhOeSgZie6rLsnPu8tZkxHK9LLD0ztuKyOWFf6J1okEf2u7fo3N
         SGCcJn0eu5fv0GuEmAD259bw2AKuNREDHQp+G2/EiiyjlaPw5WsxUhjuKCan/q3N93An
         YtfA==
X-Forwarded-Encrypted: i=1; AJvYcCVIggqwFYJDAhz4+qTkqdSsWhkqoAKrz4lhBGhelDGylpUqiJ9/1I6lJx8xwPXDqoZwO9GUSqI3ltngRYBt@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlkkTnvCoeOArKmUBsIeOffKocu+0xlFzOlmBeTdwIpWTOct6
	bsQ5EuYMtEJVC4efElyL1deCdDFJjINFtOYd/ntWE6UBQfmmCnNVbSQgLDeTgJ6mE3LzTKAvQjL
	F/izAueWNniXiJ4Iqp341X77a62LKmJw=
X-Gm-Gg: AZuq6aL9XwzH8KR3nkbLRNtmvBnCCym84z8no7Won197U4Yj2EYH3+vhSLoZuOTyhrd
	UAixXvrDOWuCRvmTn7IKPD5EJ7MdyPIMtjMrQkkKcwIIK2VuJ5H4dMPJ5AMRqVxE05Ff04WCEox
	KL0djrBOIQWyA9EOym4N7AovLaxGXF6wS4atQ+cv+PKJBKZjn1FYt+cGIt1fKsb2AMbKER7S8vu
	zWeJcYAkCbWseBjFgEAB2YwUpfFqE06jJizlZtkgiqtGuDQXl7GVZAZCY5lw6jKz0Au/A==
X-Received: by 2002:ac8:59d2:0:b0:502:e3c8:2e25 with SMTP id
 d75a77b69052e-502f77db1ebmr18920981cf.76.1769123148031; Thu, 22 Jan 2026
 15:05:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116200427.1016177-1-joannelkoong@gmail.com>
 <20260116200427.1016177-2-joannelkoong@gmail.com> <aXCE7jZ5HdhOktEs@infradead.org>
 <CAJnrk1Zp1gkwP=paJLtHN5S41JNBJar-_W0q7K_1zTULh4TqUw@mail.gmail.com>
 <aXJVlYkGKaHFFH9T@casper.infradead.org> <CAJnrk1Z083d_SXB8uk5oerrdyezDY7LqcqKcir9r02GUmRAU6g@mail.gmail.com>
 <aXKA0gD0J5r4w925@casper.infradead.org>
In-Reply-To: <aXKA0gD0J5r4w925@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 22 Jan 2026 15:05:36 -0800
X-Gm-Features: AZwV_QhE-LAfgkaOWdhkW6Oz3HTKeSTaRLruif-nXTxEJh_8JlHVfJCLpZRiH_8
Message-ID: <CAJnrk1aW1cgN_rQTajyjt1Dq+zOYiprzXeLXOgFEpWT0rpBv2g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75167-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 5D5946E64F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:56=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Jan 22, 2026 at 11:50:18AM -0800, Joanne Koong wrote:
> > On Thu, Jan 22, 2026 at 8:51=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > This is so complicated.  I think you made your life harder by adding =
the
> > > bias to read_bytes_pending.  What if we just rip most of this out ...
> >
> > I don't think we can rip this out because when the read starts,
> > ifs->read_bytes_pending gets set to the folio size, but if there are
> > already some uptodate ranges in the folio, the filesystem IO helper
> > will not be reading in the entire folio size, which means we still
> > need all this logic to decrement ifs->read_bytes_pending by the bytes
> > not read in by the IO helper and to end the folio read.
>
> Well, the patch as-is doesn't work (squinting at it now to see
> what I missed ...), but that's not an insurmountable problem.
> If we find already-uptodate blocks in the folio, we can just call
> iomap_finish_folio_read() for them without starting I/O.  That's very
> much a corner case, so we need not try hard for efficiency (eg skipping
> the ifs_set_range_uptodate() call).

I tried coding this out but I think it ends up looking just as
unappealing. To cover all the edge cases, I think it'd have to look
something like this:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6beb876658c0..d01b760ee3fe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -409,8 +409,6 @@ static void iomap_read_init(struct folio *folio)
        struct iomap_folio_state *ifs =3D folio->private;

        if (ifs) {
-               size_t len =3D folio_size(folio);
-
                /*
                 * ifs->read_bytes_pending is used to track how many bytes =
are
                 * read in asynchronously by the IO helper. We need to trac=
k
@@ -418,80 +416,20 @@ static void iomap_read_init(struct folio *folio)
                 * reading in all the necessary ranges of the folio and can=
 end
                 * the read.
                 *
-                * Increase ->read_bytes_pending by the folio size to start=
, and
-                * add a +1 bias. We'll subtract the bias and any uptodate =
/
-                * zeroed ranges that did not require IO in iomap_read_end(=
)
-                * after we're done processing the folio.
+                * Increase ->read_bytes_pending by the folio size to start=
.
+                * We'll subtract any uptodate / zeroed ranges that did not
+                * require IO in iomap_finish_folio_read() after we're done
+                * processing the folio.
                 *
                 * We do this because otherwise, we would have to increment
                 * ifs->read_bytes_pending every time a range in the folio =
needs
                 * to be read in, which can get expensive since the spinloc=
k
                 * needs to be held whenever modifying ifs->read_bytes_pend=
ing.
-                *
-                * We add the bias to ensure the read has not been ended on=
 the
-                * folio when iomap_read_end() is called, even if the IO he=
lper
-                * has already finished reading in the entire folio.
                 */
                spin_lock_irq(&ifs->state_lock);
                WARN_ON_ONCE(ifs->read_bytes_pending !=3D 0);
-               ifs->read_bytes_pending =3D len + 1;
-               spin_unlock_irq(&ifs->state_lock);
-       }
-}
-
-/*
- * This ends IO if no bytes were submitted to an IO helper.
- *
- * Otherwise, this calibrates ifs->read_bytes_pending to represent only th=
e
- * submitted bytes (see comment in iomap_read_init()). If all bytes submit=
ted
- * have already been completed by the IO helper, then this will end the re=
ad.
- * Else the IO helper will end the read after all submitted ranges have be=
en
- * read.
- */
-static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
-{
-       struct iomap_folio_state *ifs =3D folio->private;
-
-       if (ifs) {
-               bool end_read, uptodate;
-
-               spin_lock_irq(&ifs->state_lock);
-               if (!ifs->read_bytes_pending) {
-                       WARN_ON_ONCE(bytes_submitted);
-                       spin_unlock_irq(&ifs->state_lock);
-                       folio_unlock(folio);
-                       return;
-               }
-
-               /*
-                * Subtract any bytes that were initially accounted to
-                * read_bytes_pending but skipped for IO. The +1 accounts f=
or
-                * the bias we added in iomap_read_init().
-                */
-               ifs->read_bytes_pending -=3D
-                       (folio_size(folio) + 1 - bytes_submitted);
-
-               /*
-                * If !ifs->read_bytes_pending, this means all pending read=
s by
-                * the IO helper have already completed, which means we nee=
d to
-                * end the folio read here. If ifs->read_bytes_pending !=3D=
 0,
-                * the IO helper will end the folio read.
-                */
-               end_read =3D !ifs->read_bytes_pending;
-               if (end_read)
-                       uptodate =3D ifs_is_fully_uptodate(folio, ifs);
+               ifs->read_bytes_pending =3D folio_size(folio);
                spin_unlock_irq(&ifs->state_lock);
-               if (end_read)
-                       folio_end_read(folio, uptodate);
-       } else if (!bytes_submitted) {
-               /*
-                * If there were no bytes submitted, this means we are
-                * responsible for unlocking the folio here, since no IO he=
lper
-                * has taken ownership of it. If there were bytes submitted=
,
-                * then the IO helper will end the read via
-                * iomap_finish_folio_read().
-                */
-               folio_unlock(folio);
        }
 }

@@ -502,10 +440,16 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
        loff_t pos =3D iter->pos;
        loff_t length =3D iomap_length(iter);
        struct folio *folio =3D ctx->cur_folio;
+       size_t folio_len =3D folio_size(folio);
        size_t poff, plen;
        loff_t pos_diff;
        int ret;

+       ifs_alloc(iter->inode, folio, iter->flags);
+
+       if (!*bytes_submitted)
+               iomap_read_init(folio);
+
        if (iomap->type =3D=3D IOMAP_INLINE) {
                ret =3D iomap_read_inline_data(iter, folio);
                if (ret)
@@ -513,8 +457,6 @@ static int iomap_read_folio_iter(struct iomap_iter *ite=
r,
                return iomap_iter_advance(iter, length);
        }

-       ifs_alloc(iter->inode, folio, iter->flags);
-
        length =3D min_t(loff_t, length,
                        folio_size(folio) - offset_in_folio(folio, pos));
        while (length) {
@@ -537,12 +479,12 @@ static int iomap_read_folio_iter(struct iomap_iter *i=
ter,
                        folio_zero_range(folio, poff, plen);
                        iomap_set_range_uptodate(folio, poff, plen);
                } else {
-                       if (!*bytes_submitted)
-                               iomap_read_init(folio);
                        ret =3D ctx->ops->read_folio_range(iter, ctx, plen)=
;
                        if (ret)
                                return ret;
                        *bytes_submitted +=3D plen;
+                       if (*bytes_submitted =3D=3D folio_len)
+                               ctx->cur_folio =3D false;
                }

                ret =3D iomap_iter_advance(iter, plen);
@@ -558,36 +500,51 @@ void iomap_read_folio(const struct iomap_ops *ops,
                struct iomap_read_folio_ctx *ctx)
 {
        struct folio *folio =3D ctx->cur_folio;
+       size_t folio_len =3D folio_size(folio);
        struct iomap_iter iter =3D {
                .inode          =3D folio->mapping->host,
                .pos            =3D folio_pos(folio),
-               .len            =3D folio_size(folio),
+               .len            =3D folio_len,
        };
        size_t bytes_submitted =3D 0;
+       bool read_initialized =3D false;
        int ret;

        trace_iomap_readpage(iter.inode, 1);

-       while ((ret =3D iomap_iter(&iter, ops)) > 0)
+       while ((ret =3D iomap_iter(&iter, ops)) > 0) {
                iter.status =3D iomap_read_folio_iter(&iter, ctx,
                                &bytes_submitted);
+               read_initialized =3D true;
+       }

        if (ctx->ops->submit_read)
                ctx->ops->submit_read(ctx);

-       iomap_read_end(folio, bytes_submitted);
+       if (ctx->cur_folio) {
+               if (read_initialized)
+                       iomap_finish_folio_read(folio, 0,
+                                       folio_len - bytes_submitted,
+                                       iter.status);
+               else
+                       folio_unlock(folio);
+       }
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);

 static int iomap_readahead_iter(struct iomap_iter *iter,
-               struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_submitt=
ed)
+               struct iomap_read_folio_ctx *ctx, size_t *cur_bytes_submitt=
ed,
+               bool *cur_read_initialized)
 {
        int ret;

        while (iomap_length(iter)) {
                if (ctx->cur_folio &&
                    offset_in_folio(ctx->cur_folio, iter->pos) =3D=3D 0) {
-                       iomap_read_end(ctx->cur_folio, *cur_bytes_submitted=
);
+                       if (*cur_read_initialized)
+                               iomap_finish_folio_read(ctx->cur_folio, 0,
+
folio_size(ctx->cur_folio) - *cur_bytes_submitted,
+                                               0);
                        ctx->cur_folio =3D NULL;
                }
                if (!ctx->cur_folio) {
@@ -595,8 +552,10 @@ static int iomap_readahead_iter(struct iomap_iter *ite=
r,
                        if (WARN_ON_ONCE(!ctx->cur_folio))
                                return -EINVAL;
                        *cur_bytes_submitted =3D 0;
+                       *cur_read_initialized =3D false;
                }
                ret =3D iomap_read_folio_iter(iter, ctx, cur_bytes_submitte=
d);
+               *cur_read_initialized =3D true;
                if (ret)
                        return ret;
        }
@@ -629,18 +588,26 @@ void iomap_readahead(const struct iomap_ops *ops,
                .len    =3D readahead_length(rac),
        };
        size_t cur_bytes_submitted;
+       bool cur_read_initialized;

        trace_iomap_readahead(rac->mapping->host, readahead_count(rac));

        while (iomap_iter(&iter, ops) > 0)
                iter.status =3D iomap_readahead_iter(&iter, ctx,
-                                       &cur_bytes_submitted);
+                                       &cur_bytes_submitted,
&cur_read_initialized);

        if (ctx->ops->submit_read)
                ctx->ops->submit_read(ctx);

-       if (ctx->cur_folio)
-               iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
+       if (ctx->cur_folio) {
+               if (cur_read_initialized) {
+                       iomap_finish_folio_read(ctx->cur_folio, 0,
+                                       folio_size(ctx->cur_folio) -
cur_bytes_submitted,
+                                       iter.status);
+               } else {
+                       folio_unlock(ctx->cur_folio);
+               }
+       }
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);

In particular, we need to move the ifs_alloc() and iomap_read_init()
calls to before the "iomap_read_inline_data()" call and keep track of
read_initialized as a separate variable that is passed through
iomap_read_folio() and iomap_readahead(), to account for the case
where there's an ifs allocated but no call to iomap_read_init() has
been made (which can happen if the ifs was allocated from a prior
write to a block in the folio).

iomap_read_end() guarded against this with:
    if (ifs) {
               ...
                spin_lock_irq(&ifs->state_lock);
                if (!ifs->read_bytes_pending) {
                        WARN_ON_ONCE(bytes_submitted);
                        spin_unlock_irq(&ifs->state_lock);
                        folio_unlock(folio);
                        return;
                }
    }

In the existing implementation, if we invalidate ctx->cur_folio when
the entire folio is read in, then we could remove the "+1"
addition/subtraction, but I think the part you're objecting to in
general is having a separate iomap_read_end() instead of just
repurposing the logic in iomap_finish_folio_read().

Thanks,
Joanne

