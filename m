Return-Path: <linux-fsdevel+bounces-76768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KUfIM15immKKwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:20:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22193115936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 01:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFC893023366
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBCA207A38;
	Tue, 10 Feb 2026 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKBkiz3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEB1F4611
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770682816; cv=pass; b=c13ovI8XW4Tw2bq/3CIMFaApm+0j8ixN0lKhwa05eQAa5g0/6UTUhPON50cZ9hRYLnMutgtRpNDyxi9nTcjtux1mJ4VVI83wz0LZG2WCytVYe3/d10OgO2PTtqUIED5tVuCOxs6zXJD5707BK60JD7eKMJke1QRDax6M+G7/IS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770682816; c=relaxed/simple;
	bh=UL8JdNAHpXUJQ6jRPVIx9ZhYxy31//qgEWRPZPyEhOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVEPl9z7B18wgeJssg5IqNigkRE2pkigw5sKr0LRwIRqh/XNwSgaYEMQ7XEr+rv7aqs3AKv9dmm0jAJw71dTlsOxgTGSF5YyJoXzxdooJAYU7FxAogMr6oBIVx4Q4HLeA042TD2aOWrRn5d4nLNMnFm/+Uimyv7zNHqhTI9NZbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKBkiz3V; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-897023602b1so3729376d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770682813; cv=none;
        d=google.com; s=arc-20240605;
        b=Y2IUdcpjruS16Pns2QjRBXpcJdWKtZjhM6ApYa+qLy76M3pQVFIytIm83Zmj6X8Ja1
         gtW4hFPtRj5oNjnW4XWo3/HiGzY2tgdFjj4erXC9YnNU/0IQH+9DuoClycgueDuXn1v5
         N/tMs79d5xdU9+/y7t0zL7e0dj2XNvElkeid0bEYaV1PH7PP26g2G9HWko3pc8AKTDhR
         TKMW5xEK1dPTHc8FUDpiMRJiEjO/FREMIeaKfV7lr/A35JoplSLEELBJN8SmBFGupeTC
         GT+QIJ3NEoO6VcwFCEQyYf5F8PcG23zPNATIw0u0mcWfcWgQVAzP7ZZ5+bv4C8ycEMZI
         sOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7B+5rtgb9O+HN9fMoegUsYP4PL42JLNL9HkikpPBkW0=;
        fh=N1jOddHfZW8wvwVs2gHuo2DwhOaYKhAvBdbK9b1G4Ak=;
        b=Q9xkmhjqdWrfd4K0KxrdefL1/GknDf6sx5kwqoOazr8+kSNUbRgCO0CZz7i8jcpiZT
         5OsPINEeLHneVUeIkEd+Cp2wgbVLa7Q8642wwHyDP559LVRJEW2+qlfWdbRXuCIw3sC2
         T9Lp4bAsmyypIO3r2OO4va21tAe3Kt9ho/qGZp34QTkly7d2Jd8zfxMfkQVbDOSonoeZ
         y9G8RiUXyYf24RXYaESoqIN0aQ11FbB8bwd9eOWjvH12lBSNwFwtKC+Miw9N3QoXNJdI
         EtgenkhNxggQzYppxKni86Q+ZH2KNxDwMVa8MgqJJN82MdIEzepFozF3aE9ew1ohl0IS
         hjkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770682813; x=1771287613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B+5rtgb9O+HN9fMoegUsYP4PL42JLNL9HkikpPBkW0=;
        b=dKBkiz3V49UZRvXs2jfReziJ0e6f5+J75TrostKb0psCZ15hhI6BELkQHil9wk/A4g
         F/HiDUIk+F7WdqsWgXmiRw5lN1yRCLvRTUWbzCYDtL0LWq0oZ1Q8DS70oMgIs1w5QaWl
         d5JYmxlmmki0a8aWtIDGEGsWjz9GYs4C05p9nsse4Y5y7lOwxdNiLLbvvz25Qd25aGeA
         lCjLQ9K74B7ldqduNcu36lU/PSAykgzZNIKKRIG2fbZu8v6Fhq20H5j7FpDSOy+yCU5o
         Q1s+Gjvb+vWVxT/3Abd3f/lMf+73OJxrRa/Z+PlCFD4caAZJ9m+i5yVrM56yvnueqQ8U
         ZdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770682813; x=1771287613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7B+5rtgb9O+HN9fMoegUsYP4PL42JLNL9HkikpPBkW0=;
        b=jjqs71SmXhJr2Cr+H5IABJvStXp2stwpk7H9hHrEKerBiv/wxbbzFAliAEOMXWHiqK
         LvtKDKc1He20PxHt4VbVfiNcFKlBDDkjXKJonnUqLPuZNnOBIoDB0ss7/JnowsPUf4gj
         eobo8ixkskU5popksFOPM7IQ2CqtBsISnI5r0jgKpf8BxrCCNcJFXcUgOu2AtCGtjVCA
         cX/+7MPwythLeY+h1st31TweXIXBa0CMv3a/y40EPoB4LM9JCmUFoGe+SqQbf7K8vfEZ
         qgyn1JytNWxoIAQCIxw8pd2gF3BDtU65cJbzjhkXf1mWBdPunlDWhJCuKybNS8vbLouk
         er7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVel+a3Icb1RFxgraBrCTdVoPpaxsl4yD8BY296vcVOyg5jBj2B+8pygNU6lHB+Lev9QcKHytalASWjWkRx@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOTNlbZOerx3SSQ7kAy9HCOWXvUF7CegCI415JIb3pgEXedEk
	9A87YKXxWSmbqLrCjMSwKHJJnyj9fl2+2HJKq0DyXTZ6EzCWOKrTUILWO/G7GvwECuIflbjw1a2
	6oYiUc4rSBY8R5NGqmFd9HL9VPF2angc=
X-Gm-Gg: AZuq6aJDvyEvJ3UtuOwc31IY2K5BOUOAqpuAg5+zU2GB9Gjv+31l739ZJE/VOGVV4eH
	yo1ZKm2GQKoM3TO5uxBknw8z1gOuDJ91nu15ujq+GEweDir1ENpJ5zrJHwNYaqqcQXnHFI4a48V
	So4FN17XiBsapVZb6DEZ/5dYmnbJWQUMP6goAkGFJAIpFL29ezsMxzU4KgK6TYEKA5Bga4ZT56E
	RK8JlHoK/movcStzoSz9/1LSbnR30vQVKrylElOHS3N6pu7dR/EfVceL5+2keb0P2TU/DquMoCY
	pzwfNw==
X-Received: by 2002:a05:6214:411a:b0:896:6c2b:2935 with SMTP id
 6a1803df08f44-8966c2b2c76mr104209006d6.63.1770682812618; Mon, 09 Feb 2026
 16:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926002609.1302233-13-joannelkoong@gmail.com>
 <20251223223018.3295372-1-sashal@kernel.org> <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtCjXbraDrq-Sxe@laps> <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com> <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Feb 2026 16:20:01 -0800
X-Gm-Features: AZwV_Qi3WtuxNiI7Qipq1hezYMuoJegEtccUTANZV7BzDfSJA9EpcPUKSnIPvJk
Message-ID: <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] iomap: fix race between iomap_set_range_uptodate
 and folio_end_read
To: Wei Gao <wegao@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, willy@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76768-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 22193115936
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 4:12=E2=80=AFPM Wei Gao <wegao@suse.com> wrote:
>
> On Mon, Feb 09, 2026 at 11:08:50AM -0800, Joanne Koong wrote:
> > On Fri, Feb 6, 2026 at 11:16=E2=80=AFPM Wei Gao <wegao@suse.com> wrote:
> > >
> > > On Tue, Dec 23, 2025 at 08:31:57PM -0500, Sasha Levin wrote:
> > > > On Tue, Dec 23, 2025 at 05:12:09PM -0800, Joanne Koong wrote:
> > > > > On Tue, Dec 23, 2025 at 2:30=E2=80=AFPM Sasha Levin <sashal@kerne=
l.org> wrote:
> > > > > >
> > > > >
> > > > > Hi Sasha,
> > > > >
> > > > > Thanks for your patch and for the detailed writeup.
> > > >
> > > > Thanks for looking into this!
> > > >
> > > > > > When iomap uses large folios, per-block uptodate tracking is ma=
naged via
> > > > > > iomap_folio_state (ifs). A race condition can cause the ifs upt=
odate bits
> > > > > > to become inconsistent with the folio's uptodate flag.
> > > > > >
> > > > > > The race occurs because folio_end_read() uses XOR semantics to =
atomically
> > > > > > set the uptodate bit and clear the locked bit:
> > > > > >
> > > > > >   Thread A (read completion):          Thread B (concurrent wri=
te):
> > > > > >   --------------------------------     ------------------------=
--------
> > > > > >   iomap_finish_folio_read()
> > > > > >     spin_lock(state_lock)
> > > > > >     ifs_set_range_uptodate() -> true
> > > > > >     spin_unlock(state_lock)
> > > > > >                                        iomap_set_range_uptodate=
()
> > > > > >                                          spin_lock(state_lock)
> > > > > >                                          ifs_set_range_uptodate=
() -> true
> > > > > >                                          spin_unlock(state_lock=
)
> > > > > >                                          folio_mark_uptodate(fo=
lio)
> > > > > >     folio_end_read(folio, true)
> > > > > >       folio_xor_flags()  // XOR CLEARS uptodate!
> > > > >
> > > > > The part I'm confused about here is how this can happen between a
> > > > > concurrent read and write. My understanding is that the folio is
> > > > > locked when the read occurs and locked when the write occurs and =
both
> > > > > locks get dropped only when the read or write finishes. Looking a=
t
> > > > > iomap code, I see iomap_set_range_uptodate() getting called in
> > > > > __iomap_write_begin() and __iomap_write_end() for the writes, but=
 in
> > > > > both those places the folio lock is held while this is called. I'=
m not
> > > > > seeing how the read and write race in the diagram can happen, but
> > > > > maybe I'm missing something here?
> > > >
> > > > Hmm, you're right... The folio lock should prevent concurrent read/=
write
> > > > access. Looking at this again, I suspect that FUSE was calling
> > > > folio_clear_uptodate() and folio_mark_uptodate() directly without u=
pdating the
> > > > ifs bits. For example, in fuse_send_write_pages() on write error, i=
t calls
> > > > folio_clear_uptodate(folio) which clears the folio flag but leaves =
ifs still
> > > > showing all blocks uptodate?
> > >
> > > Hi Sasha
> > > On PowerPC with 64KB page size, msync04 fails with SIGBUS on NTFS-FUS=
E. The issue stems from a state inconsistency between
> > > the iomap_folio_state (ifs) bitmap and the folio's Uptodate flag.
> > > tst_test.c:1985: TINFO: =3D=3D=3D Testing on ntfs =3D=3D=3D
> > > tst_test.c:1290: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' ext=
ra opts=3D''
> > > Failed to set locale, using default 'C'.
> > > The partition start sector was not specified for /dev/loop0 and it co=
uld not be obtained automatically.  It has been set to 0.
> > > The number of sectors per track was not specified for /dev/loop0 and =
it could not be obtained automatically.  It has been set to 0.
> > > The number of heads was not specified for /dev/loop0 and it could not=
 be obtained automatically.  It has been set to 0.
> > > To boot from a device, Windows needs the 'partition start sector', th=
e 'sectors per track' and the 'number of heads' to be set.
> > > Windows will not be able to boot from this device.
> > > tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_msy3ljVxi/msy=
nc04 fstyp=3Dntfs flags=3D0
> > > tst_test.c:1302: TINFO: Trying FUSE...
> > > tst_test.c:1953: TBROK: Test killed by SIGBUS!
> > >
> > > Root Cause Analysis: When a page fault triggers fuse_read_folio, the =
iomap_read_folio_iter handles the request. For a 64KB page,
> > > after fetching 4KB via fuse_iomap_read_folio_range_async, the remaini=
ng 60KB (61440 bytes) is zero-filled via iomap_block_needs_zeroing,
> > > then iomap_set_range_uptodate marks the folio as Uptodate globally, a=
fter folio_xor_flags folio's uptodate become 0 again, finally trigger
> > > an SIGBUS issue in filemap_fault.
> >
> > Hi Wei,
> >
> > Thanks for your report. afaict, this scenario occurs only if the
> > server is a fuseblk server with a block size different from the memory
> > page size and if the file size is less than the size of the folio
> > being read in.
> Thanks for checking this and give quick feedback :)
> >
> > Could you verify that this snippet from Sasha's patch fixes the issue?:
> Yes, Sasha's patch can fixes the issue.

I think just those lines I pasted from Sasha's patch is the relevant
fix. Could you verify that just those lines (without the changes
from the rest of his patch) fixes the issue?

Thanks,
Joanne


> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index e5c1ca440d93..7ceda24cf6a7 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -87,12 +86,50 @@ static void iomap_set_range_uptodate(struct folio
> > *folio, size_t off,
> >   if (ifs) {
> >           spin_lock_irqsave(&ifs->state_lock, flags);
> >           uptodate =3D ifs_set_range_uptodate(folio, ifs, off, len);
> >           + /*
> >           + * If a read is in progress, we must NOT call folio_mark_upt=
odate
> >           + * here. The read completion path (iomap_finish_folio_read o=
r
> >           + * iomap_read_end) will call folio_end_read() which uses XOR
> >           + * semantics to set the uptodate bit. If we set it here, the=
 XOR
> >           + * in folio_end_read() will clear it, leaving the folio not
> >           + * uptodate while the ifs says all blocks are uptodate.
> >           + */
> >          + if (uptodate && ifs->read_bytes_pending)
> >                    + uptodate =3D false;
> >         spin_unlock_irqrestore(&ifs->state_lock, flags);
> >   }
> >
> > Thanks,
> > Joanne
> >
> > >
> > > So your iomap_set_range_uptodate patch can fix above failed case sinc=
e it block mark folio's uptodate to 1.
> > > Hope my findings are helpful.
> > >
> > > >
> > > > --
> > > > Thanks,
> > > > Sasha
> > > >

