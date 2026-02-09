Return-Path: <linux-fsdevel+bounces-76740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LFACvUwimm3IAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:09:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE4E113F76
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF3A23027977
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0E410D0B;
	Mon,  9 Feb 2026 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHG6lHLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5F3F23D7
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770664142; cv=pass; b=fZx7l0w0VtlhsTwZudyUgEUp5V+agTz5+oQKDxmYVYamRM6+8j2YAXnZXSxmNpfOkzsSKkvjGR6Pm375dMkxBAVPIR6Vzw9mt8U9rTgAE6eMfbpuDFZWAan5Tt3FdGN7RIXqaAbuUa4ax49lKN7FLg3q/8FONvVpo4gCkj9EPfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770664142; c=relaxed/simple;
	bh=AjQ2gwV2wUXFae+8tchmKALZAjmzR22BWz9uA2GrjZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lH3/31QGYU13d03HGnyMzbiFnauEJPg9VaIiEL36Xwemq+/kKnXhAC1lStRX+iEkMMkDENywL55z8k1PNipoa6TI6Abx/87cqw6T+asNpfgoNyIA5NuuSoFT3OuLzRiwmoYhn+xWlAb+5+E5m8eWYPSk56GX1Io2ZJyJv+M8DbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHG6lHLJ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-505a1789a27so29420901cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 11:09:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770664141; cv=none;
        d=google.com; s=arc-20240605;
        b=kXifE2wDNiMww8TvC7zIzL8QlyKDXIbpqDDH9rUYspeOs+7U2fut09+jy0djw8OTfx
         u3v6FwL5b0kLFvhpVICdLGAjE80oiOYgct7S1SG+dSgA3XMVsFspffsBHhjOn0hLW9+A
         GIQda8Z+E1eiIkmlf9krxCVQaVGHrfCNNZXDcUrmccc7E2WhTverND9eYOQAG/Udny9Y
         yBac3vnEmRrF84C/VbYQZ0u87NIOkCr9jpqRNTXzM9e2TPrWSVIVNgU1dr3O09tsOG4R
         rlYb3sEH8yrq80oCvSD0Hy8CwMHDWZkhDw4MULTXET9HCikrsm+/cxy0Ye2vhMfJ9Jtc
         qIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aUx/ZPt+BdWyLKXPYfN8oN7mxrwG1C9O3qpfLEYtMq0=;
        fh=TNh5+IA2MZJayGf16bsiUwYwV6BlUkrH5dmJRYVphuU=;
        b=NJVMaAvsyb0MVLpnueZhQvUev52UuTglr2wR95Qyx3UcUTUTCfds1y5oX5c4bWfDID
         sI1zYv9wflSv8c9YaxshWlSmrEXTBAEg6hZLnUQEfKiOjGkrTr8/TVPZdhlQqzpfnqYZ
         5GIAOXJvEe1TFu1yDP9GCDC5JTj5ShGj8IBcUTjhRTwnlcJf8swbfmxIEMNxm4Uh0i98
         mSTPhRUL8vUIpObUKinm0l887vPrxwh9lCe5arxn2+K8dTlGVu+Qlxu7JJ0yCe1/mjMn
         7+tHrHCoW83VhzjRGAA2vb8XhRcp7Rl++XEiZhaAvmSuMxGCeUIq3nLoEu1HpEEVIbim
         Zpzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770664141; x=1771268941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUx/ZPt+BdWyLKXPYfN8oN7mxrwG1C9O3qpfLEYtMq0=;
        b=hHG6lHLJQIOopQixFrq01q6PE4GhhiSU/VPVdu2wLPMh787E4be/1YNAhA88oDcHYu
         tigZ5f3VTwo8S8jAgY6O6rGOF9f0nb1bN0gmBpPs6xH6tJ0me+YOZ/qk/WJ17TkiyYSN
         Zwut7MdaGCqXQkyEpp6bI7aG8HcRaDUp/Wy1efdGDLberNBRTDoJizZak1wo9lgw6TpL
         WFYUj1z/IzYw4AZ2uyp025+hCM+MDKdScj0G7/gM0mn8T4Vl/LE5UjSGzIHfaGZZaZ6g
         G5ySwbmXkLko13TNfMvTd5Dk1VmREBEUl3goJLZnvOQoerzP7QwLuCgbV5g3+VMkFaNt
         8SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770664141; x=1771268941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aUx/ZPt+BdWyLKXPYfN8oN7mxrwG1C9O3qpfLEYtMq0=;
        b=gOV1OFKf8XQY8Q9hkAgxGDhs56w5sZyELF3v7x6P/qjfyJe2slOxsocCM+EB3YgXT4
         bsIFHHUEH8wTmr/rqwQC6C4hFWZxUkVHsgF0f2GDP3a8dmRU0dgeUp6dSf0r6EMU7IIT
         lVtn9h8PBy5bNLnu5DtAnsCYiQTXRO610ggGF/vEabXjaiDbMZ8SidypcT+xHT6kCheV
         T6UEBgllMSRAw7IOq/Uhz+DnVcR09Bq4ZsNVceOFh3dkqbkH7FVBzGG4eN5i8Vk//+aq
         6acAWv+KbzbmrR1CXPBZwD9QW38UqExXfcPlfvlAEYYKQmFa9yHkhlghtZMSIVhPXvCz
         ftGg==
X-Forwarded-Encrypted: i=1; AJvYcCXsQSo3VK38CZFSafjDgnKGypPB13fs4v7d/ZnLmqQBtxht0MLq02kfczOQPXUWYG0tN5IHjmMXoMmJlATn@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJnKOCYV3rSVMnI1jqIsEtsrQAD/dqAyMW8mApLF0RltJh/9A
	oIje8SPoZZP6jJ8R2c84b4h29IG23WL3b1N6J4rNBYEkSHSduavIGheMTFMwtwzWzul9t4LoVqQ
	kKJgKlsqnIU5snp0qg06RaTEEvCrE8tI=
X-Gm-Gg: AZuq6aLY+etc1qDJBNwz2o5uiOLlDQraa9Ts//Hh7IbDN8j1jlm7BAURIjjeW+ErgN0
	9QqGJ+DP51yHyrKYytz3LooSpdM6C5NFqqxFkdC8UCEccqnbU99KSftIVOK9Cs5wJqks+td1DYj
	EkhO7VTl/Y+Fxzn3TU8BpHYWpzv59FhLROlSLf1MQ1QrC4mGLDYe9tPvdhaOvDF4F/+WNJ9IB+X
	H5MONDWuzRCSS7KnBYYUYOSa5knjfMitXngNvjnyckcO4GPFDDwS5milZk46gSjuAwxyg==
X-Received: by 2002:ac8:5f87:0:b0:506:20bf:44a3 with SMTP id
 d75a77b69052e-506399b1dc7mr174762981cf.43.1770664141110; Mon, 09 Feb 2026
 11:09:01 -0800 (PST)
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
In-Reply-To: <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Feb 2026 11:08:50 -0800
X-Gm-Features: AZwV_QiKtYni1-qc8FUQp7yClRfRztyAaMm5n7lTJ9_CXFKsHzxZUBJandkjy-c
Message-ID: <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76740-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8AE4E113F76
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 11:16=E2=80=AFPM Wei Gao <wegao@suse.com> wrote:
>
> On Tue, Dec 23, 2025 at 08:31:57PM -0500, Sasha Levin wrote:
> > On Tue, Dec 23, 2025 at 05:12:09PM -0800, Joanne Koong wrote:
> > > On Tue, Dec 23, 2025 at 2:30=E2=80=AFPM Sasha Levin <sashal@kernel.or=
g> wrote:
> > > >
> > >
> > > Hi Sasha,
> > >
> > > Thanks for your patch and for the detailed writeup.
> >
> > Thanks for looking into this!
> >
> > > > When iomap uses large folios, per-block uptodate tracking is manage=
d via
> > > > iomap_folio_state (ifs). A race condition can cause the ifs uptodat=
e bits
> > > > to become inconsistent with the folio's uptodate flag.
> > > >
> > > > The race occurs because folio_end_read() uses XOR semantics to atom=
ically
> > > > set the uptodate bit and clear the locked bit:
> > > >
> > > >   Thread A (read completion):          Thread B (concurrent write):
> > > >   --------------------------------     ----------------------------=
----
> > > >   iomap_finish_folio_read()
> > > >     spin_lock(state_lock)
> > > >     ifs_set_range_uptodate() -> true
> > > >     spin_unlock(state_lock)
> > > >                                        iomap_set_range_uptodate()
> > > >                                          spin_lock(state_lock)
> > > >                                          ifs_set_range_uptodate() -=
> true
> > > >                                          spin_unlock(state_lock)
> > > >                                          folio_mark_uptodate(folio)
> > > >     folio_end_read(folio, true)
> > > >       folio_xor_flags()  // XOR CLEARS uptodate!
> > >
> > > The part I'm confused about here is how this can happen between a
> > > concurrent read and write. My understanding is that the folio is
> > > locked when the read occurs and locked when the write occurs and both
> > > locks get dropped only when the read or write finishes. Looking at
> > > iomap code, I see iomap_set_range_uptodate() getting called in
> > > __iomap_write_begin() and __iomap_write_end() for the writes, but in
> > > both those places the folio lock is held while this is called. I'm no=
t
> > > seeing how the read and write race in the diagram can happen, but
> > > maybe I'm missing something here?
> >
> > Hmm, you're right... The folio lock should prevent concurrent read/writ=
e
> > access. Looking at this again, I suspect that FUSE was calling
> > folio_clear_uptodate() and folio_mark_uptodate() directly without updat=
ing the
> > ifs bits. For example, in fuse_send_write_pages() on write error, it ca=
lls
> > folio_clear_uptodate(folio) which clears the folio flag but leaves ifs =
still
> > showing all blocks uptodate?
>
> Hi Sasha
> On PowerPC with 64KB page size, msync04 fails with SIGBUS on NTFS-FUSE. T=
he issue stems from a state inconsistency between
> the iomap_folio_state (ifs) bitmap and the folio's Uptodate flag.
> tst_test.c:1985: TINFO: =3D=3D=3D Testing on ntfs =3D=3D=3D
> tst_test.c:1290: TINFO: Formatting /dev/loop0 with ntfs opts=3D'' extra o=
pts=3D''
> Failed to set locale, using default 'C'.
> The partition start sector was not specified for /dev/loop0 and it could =
not be obtained automatically.  It has been set to 0.
> The number of sectors per track was not specified for /dev/loop0 and it c=
ould not be obtained automatically.  It has been set to 0.
> The number of heads was not specified for /dev/loop0 and it could not be =
obtained automatically.  It has been set to 0.
> To boot from a device, Windows needs the 'partition start sector', the 's=
ectors per track' and the 'number of heads' to be set.
> Windows will not be able to boot from this device.
> tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_msy3ljVxi/msync04=
 fstyp=3Dntfs flags=3D0
> tst_test.c:1302: TINFO: Trying FUSE...
> tst_test.c:1953: TBROK: Test killed by SIGBUS!
>
> Root Cause Analysis: When a page fault triggers fuse_read_folio, the ioma=
p_read_folio_iter handles the request. For a 64KB page,
> after fetching 4KB via fuse_iomap_read_folio_range_async, the remaining 6=
0KB (61440 bytes) is zero-filled via iomap_block_needs_zeroing,
> then iomap_set_range_uptodate marks the folio as Uptodate globally, after=
 folio_xor_flags folio's uptodate become 0 again, finally trigger
> an SIGBUS issue in filemap_fault.

Hi Wei,

Thanks for your report. afaict, this scenario occurs only if the
server is a fuseblk server with a block size different from the memory
page size and if the file size is less than the size of the folio
being read in.

Could you verify that this snippet from Sasha's patch fixes the issue?:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e5c1ca440d93..7ceda24cf6a7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -87,12 +86,50 @@ static void iomap_set_range_uptodate(struct folio
*folio, size_t off,
  if (ifs) {
          spin_lock_irqsave(&ifs->state_lock, flags);
          uptodate =3D ifs_set_range_uptodate(folio, ifs, off, len);
          + /*
          + * If a read is in progress, we must NOT call folio_mark_uptodat=
e
          + * here. The read completion path (iomap_finish_folio_read or
          + * iomap_read_end) will call folio_end_read() which uses XOR
          + * semantics to set the uptodate bit. If we set it here, the XOR
          + * in folio_end_read() will clear it, leaving the folio not
          + * uptodate while the ifs says all blocks are uptodate.
          + */
         + if (uptodate && ifs->read_bytes_pending)
                   + uptodate =3D false;
        spin_unlock_irqrestore(&ifs->state_lock, flags);
  }

Thanks,
Joanne

>
> So your iomap_set_range_uptodate patch can fix above failed case since it=
 block mark folio's uptodate to 1.
> Hope my findings are helpful.
>
> >
> > --
> > Thanks,
> > Sasha
> >

