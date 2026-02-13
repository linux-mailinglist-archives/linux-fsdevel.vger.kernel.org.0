Return-Path: <linux-fsdevel+bounces-77069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN1rLjV2jmk3CgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 01:54:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE151322B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 01:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 684DE303F473
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0399E219301;
	Fri, 13 Feb 2026 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS85fiwo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3669A1A8F97
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770944049; cv=pass; b=rrP65dQOhCulHd1RgA9XX25Hs9rLG2zRHizQ2OjAxlPCKtfOVQxsPqptVX3fkQh7Np3E/VDRgJb/EtNdYcpw95z2U7OaPIjAxfOdW7UuzdL3uf7PMbvhU+MJR90f0PMA8RURUbnWt4EvLaliUQ8Wzc9ZKNeRSaM8Egbx4Riyrbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770944049; c=relaxed/simple;
	bh=M05tyhhl5ip1zOPRhTr6ZZSzqgmBSKHDYVtqo4qhPvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5heO/04fXvbfR166B73OaUH/bCmT5/Fr4YgLn/r3ij/32LXMY09exaK9omjepDHDVCuuYfjThUk9TngNCOeOeZaOzDTgUayWa3ABoV9IQmwsJf8ZONfZvnR1KwgdV+3ViBWO37qccR1RjLv2oik5kj9RrmrXsmHlgibn1Cxhzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JS85fiwo; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c59bce68a1so35652185a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 16:54:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770944046; cv=none;
        d=google.com; s=arc-20240605;
        b=kfZ00Mhc2zoKD4KA1wMf0pC+x6RT0tD9nY/fO1IvpSVHNNBXS1avmS352QdQjtzzps
         vIsFuIgUMIH+sX6e+/ul237qHE4y37t3MYhuns62v7SEkU1kFaN8Jf4bfmTszI2AGoTb
         zMMPPWezcWcw9+mKe1uC1FQWGWgqBWfx8p+IITvnBYczoMR8kbEM55bK09tCVBza4OS4
         s2grQgxxDT3eSSiXFg06Ns7SCFheUvvhqb/gEhe4kCJ3Kk/7KU4tMkBqH+5UtpI+xa9O
         BzOVFQ+NVwRibb04ujjgcfOUOCi6Et65izgu5T6y/SN1Cub5fpIdYAwzblOJ13198R5y
         LaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t9uRVEdpUkTj5ll92nBzIihRZBQJemV1SH9BfGhr7fs=;
        fh=0cT3ixVaSNOHBh8rHCI4axa8/HQadEVyymNVwswjkmw=;
        b=KuvZal7LtJNZ9K4tnid+01iF7jtEs+5Bxc0f9psCvkg46gyUz5VmHgQLehRyGuO8hL
         FTi55P5ww+o1f8+xKx0/tZUcm/V9EP+RWqLHz0I+No54Hz0INkeI6u/gKvqeSVxqmGa7
         +RP5s2bb9NJ41W5C9Yb4xXG3QuCIZlFMJFBckKVmqSHDFYPsEWGNeUUnNaCDVwYb3vj8
         Nk1GlW1TdIATx4wULJfbiEaDt+oS5llarbqyPybeS9At2jTHiA/MDnV2Bw+NLXviKuZM
         h/71sjzJ6yhq8tJSfNwQyG7wVRt0mY+3T4KiF/bUDU+OMAfmmJA++Jbz//rp39vpfYh+
         wPVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770944046; x=1771548846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9uRVEdpUkTj5ll92nBzIihRZBQJemV1SH9BfGhr7fs=;
        b=JS85fiwoKZtvOADZResdupLuy/9a2jAXdJwhuqCe6FtvxW6Imf0EHEmKr9DuDLrcIi
         +m+lkUJsBchuaTAyHieKvePi1VAEwWuqPF8oV2aLXg9NeeusHVqf1uGWoy88ZuukfHok
         3vf5aUL8I60IaKmZi0JgQSpE94kZZWZFqHOnG7dj0RT39fI6sI3bwtfGcqN923lb3CXp
         9ZYVBZs4X7w+noXdZKWH28p2X0VWV6dhyc1TDXKE+Ca8cCACMKuYvOijqSYKE9qtejDK
         k5dExrJ35Ut+nsHF8qRZGef7madMAuxJQuodOml063gH7PBbNw8p5EKpIT4jM5ZrbfDj
         xSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770944046; x=1771548846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t9uRVEdpUkTj5ll92nBzIihRZBQJemV1SH9BfGhr7fs=;
        b=bJrKSS+QeRQ8uTvJWKsFR93rmc2VeauM+I6pd2SxpFTfFI2W1rLBgO/f6S0PNThLsa
         DSE69ty4xHC3gsHeFnjjYvBzmZfxJbvjZrxQkzPtaRXbwTM7IAngWNzFlHI+mmbruFys
         eiSGwV+UgoVHDXdpJrl8WgCCaKEzfgavm37kwl7bB4TkSy8xQUDOZBOSrgoIxBhPDJ9D
         pMTiPllHPYEOoWjQkaluShZ3X8HivmXMJV/Xuu5GVqvsRnwP7xOEsLHG02JOpxT+e7Ee
         vlKvMcFR9GXClB32MJwh3MXPbel1OUuBp6Tx+ph32W7ulzgBscR8dUdlpzhtroE/YLfQ
         x9kw==
X-Forwarded-Encrypted: i=1; AJvYcCXKKjSuW9VwqyXYx6ZvNaB+MxU7svCFLJ42St0hSnGGuYRrKJx1zFIcdd1tyQ3jSQizXDNKciRd5E++3Cve@vger.kernel.org
X-Gm-Message-State: AOJu0YzHEc0LBJlw5f0GYMQABxrdqWNa/9CvhcQCGVJRRzfOlMFJ0I89
	+zGOm36xS2CfoxCySYjxjANIguJuQP6i5SPuskAlJa5lh6rxHC/3LpxbraLT+kWsh4m0d//jNqJ
	nhOmqIrSFZkFkJzSUpmoEbbjOXmQOLW8=
X-Gm-Gg: AZuq6aI4wSAd+Ccp3HE8nYjnJv2lh1fMQaAs7uvL0w4a/AwKfnA7F+0breGr0RHn8bp
	0UFLW1dSFyhbD8dZDZQWtAFrYV6CqiwYayCK56XwDXPNOOl751h1nhhFLRnOjpyWgIWLN0XZWl/
	JGnVJWS11uwpyB4WSg/oiEFp4TI+DBWjqehIq/7v3GXJOgiKet1ezBh68nB3LoVH3UYD8VUWBTL
	EZ05KYA5fLkSEr0nqYAYtZ16gj9TGZpqSXIs9su3wHmcI+TA3LX6QGKaCu986HQvDvMNDTJpkje
	Ws5pjQ==
X-Received: by 2002:ac8:588a:0:b0:503:29df:3919 with SMTP id
 d75a77b69052e-506a836fed4mr3778751cf.81.1770944046025; Thu, 12 Feb 2026
 16:54:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org> <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
 <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org> <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
 <aYvzUihKhMfM6agz@casper.infradead.org> <CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com>
 <aYzulh4XWO-TBof8@casper.infradead.org> <CAJnrk1YcuhKwbZLo-11=umcTzH_OJ+bdwZq5=XjeJo8gb9e5ig@mail.gmail.com>
 <aY4qmjRMganhoqxk@casper.infradead.org>
In-Reply-To: <aY4qmjRMganhoqxk@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Feb 2026 16:53:55 -0800
X-Gm-Features: AZwV_Qj9HGYlNxX6ZjNGzhEnrkItGt5O0ghgmEnJyBbw3Kx40GrI2EBJsGpKkuM
Message-ID: <CAJnrk1a8E-vf_7ZQKhfTGhE5ENYcAQwtAfS0kcVjCvSq=PhX9g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Gao <wegao@suse.com>, Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77069-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CE151322B5
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:31=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Feb 11, 2026 at 03:13:48PM -0800, Joanne Koong wrote:
> > On Wed, Feb 11, 2026 at 1:03=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Wed, Feb 11, 2026 at 11:33:05AM -0800, Joanne Koong wrote:
> > > > ifs->read_bytes_pending gets initialized to the folio size, but if =
the
> > > > file being read in is smaller than the size of the folio, then we
> > > > reach this scenario because the file has been read in but
> > > > ifs->read_bytes_pending is still a positive value because it
> > > > represents the bytes between the end of the file and the end of the
> > > > folio. If the folio size is 16k and the file size is 4k:
> > > >   a) ifs->read_bytes_pending gets initialized to 16k
> > > >   b) ->read_folio_range() is called for the 4k read
> > > >   c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and t=
he
> > > > 0 to 4k range is marked uptodate
> > > >   d) the post-eof blocks are zeroed and marked uptodate in the call=
 to
> > > > iomap_set_range_uptodate()
> > >
> > > This is the bug then.  If they're marked uptodate, read_bytes_pending
> > > should be decremented at the same time.  Now, I appreciate that
> > > iomap_set_range_uptodate() is called both from iomap_read_folio_iter(=
)
> > > and __iomap_write_begin(), and it can't decrement read_bytes_pending
> > > in the latter case.  Perhaps a flag or a second length parameter is
> > > the solution?
> >
> > I don't think it's enough to decrement read_bytes_pending by the
> > zeroed/read-inline length because there's these two edge cases:
> > a) some blocks in the folio were already uptodate from the very
> > beginning and skipped for IO but not decremented yet from
> > ifs->read_bytes_pending, which means in iomap_read_end(),
> > ifs->read_bytes_pending would be > 0 and the uptodate flag could get
> > XORed again. This means we need to also decrement read_bytes_pending
> > by bytes_submitted as well for this case
>
> Hm, that's a good one.  It can't happen for readahead, but it can happen
> if we start out by writing to some blocks of a folio, then call
> read_folio to get the remaining blocks uptodate.  We could avoid it
> happening by initialising read_bytes_pending to folio_size() -
> bitmap_weight(ifs->uptodate) * block_size.

This is an interesting idea but if we do this then I think this adds
some more edge cases. For example, the range being inlined or zeroed
may have some already uptodate blocks (eg from a prior buffered write)
so we'll need to calculate how many already-existing uptodate bytes
there are in that range to avoid over-decrementing
ifs->read_bytes_pending. I think we would also have to move the
ifs_alloc() and iomap_read_init() calls to the very beginning of
iomap_read_folio_iter() before any iomap_read_inline_data() call
because there could be the case where a folio has an ifs that was
allocated from a prior write, so if we call iomap_finish_folio_read()
after iomap_read_inline_data(), the folio's ifs->read_bytes_pending
now must be initialized before the inline read. Whereas before, we had
some more optimal behavior with being able to entirely skip the ifs
allocation and read initialization if the entire folio gets read
inline.

>
> > b) the async ->read_folio_range() callback finishes after the
> > zeroing's read_bytes_pending decrement and calls folio_end_read(), so
> > we need to assign ctx->cur_folio to NULL
>
> If we return 'finished' from iomap_finish_folio_read(), we can handle
> this?

I think there is still this scenario:
- ->read_folio gets called on an 8k-size folio for a 4k-size file
- iomap_read_init() is called, ifs->read_bytes_pending is now 8k
- make async ->read_folio_range() call to read in 4k
- iomap zeroes out folio from 4k to 8k, then calls
iomap_finish_folio_read() with off =3D 4k and len =3D 4k
- in iomap_finish_folio_read(), decrement ifs->read_bytes_pending by
len. ifs->read_bytes_pending is now 4k
- async ->read_folio_range() completes read, calls
iomap_finish_folio_read() with off=3D0 and len =3D 4k, which now
decrements ifs->read_bytes_pending by 4k. read_bytes_pending is now 0,
so folio_end_read() gets called. folio should now not be touched by
iomap
- iomap still has valid ctx->cur_folio, and calls iomap_read_end on
ctx->cur_folio

This is the same issue as the one in
https://lore.kernel.org/linux-fsdevel/20260126224107.2182262-2-joannelkoong=
@gmail.com/

We could always set ctx->cur_folio to NULL after inline/zeroing calls
iomap_finish_folio_read() regardless of whether it actually ended the
read or not, but then this runs into issues for zeroing. The zeroing
can be triggered by non-EOF cases, eg if the first mapping is an
IOMAP_HOLE and then the rest of hte folio is mapped. We may still need
to read in the rest of the folio, so we can't just set ctx->cur_folio
to NULL. i guess one workaround is to explicitly check if the zeroing
is for IOMAP_MAPPED types and if so then always set ctx->cur_folio to
NULL, but I think this just gets uglier / more complex to understand
and I'm not sure if there's other edge cases I'm missing that we'd
need to account for. One other idea is to try avoiding the
iomap_end_read() call for non-error cases if we use your
bitmap_weight() idea above, then it wouldn't matter in that scenario
above if ctx->cur_folio points to a folio that already had read ended
on it. But I think that also just makes the code harder to
read/understand.

The original patch seemed cleanest to me, maybe if we renamed uptodate
to mark_uptodate, it'd be more appetible?  eg

@@ -80,18 +80,19 @@ static void iomap_set_range_uptodate(struct folio
*folio, size_t off,
 {
        struct iomap_folio_state *ifs =3D folio->private;
        unsigned long flags;
-       bool uptodate =3D true;
+       bool mark_uptodate =3D true;

        if (folio_test_uptodate(folio))
                return;

        if (ifs) {
                spin_lock_irqsave(&ifs->state_lock, flags);
-               uptodate =3D ifs_set_range_uptodate(folio, ifs, off, len);
+               mark_uptodate =3D ifs_set_range_uptodate(folio, ifs, off, l=
en) &&
+                       !ifs->read_bytes_pending;
                spin_unlock_irqrestore(&ifs->state_lock, flags);
        }

-       if (uptodate)
+       if (mark_uptodate)
                folio_mark_uptodate(folio);
 }


Thanks,
Joanne

>
> > I think the code would have to look something like [1] (this is
> > similar to the alternative approach I mentioned in my previous reply
> > but fixed up to cover some more edge cases).
> >
> > Thanks,
> > Joanne
> >
> > [1] https://github.com/joannekoong/linux/commit/b42f47726433a8130e8c27d=
1b43b16e27dfd6960
>
> I think we can do everything we need with a suitably modified
> iomap_finish_folio_read() rather than the new iomap_finish_read_range().

