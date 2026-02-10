Return-Path: <linux-fsdevel+bounces-76896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INkVCuqui2nmYQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:19:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA85211FB6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A533047E59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B9B33A014;
	Tue, 10 Feb 2026 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmchzNMf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A83385A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770761900; cv=pass; b=Zw2EicayRyWs/o9iW2zBwodWbAVkpLRloNy7ipphudWNid9ITqnPAPA0HSvGZYYJYkqjIbeybpZTBbk7UHUBbKAM6FvRxLCXQU6xB3DYOT4C2wloGYc5RnyIqJ9JdjmEP7lPiYJXs/5EyUKOeWTnkMxR0AnYaP/xQb0IcFNPfig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770761900; c=relaxed/simple;
	bh=hRHosn86JcATA88VvtRkH/s0SkIyzHSqYoW9bGN+vuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRhVhpyxBsOix/gJ8qP5TWqjSQkZwgNNgUPLxckwHpej6zfrc50cI3AoLlWTqxkXGdG0qBt9MWzWunU92dUCMacfAIQ4+wvAInS/sYW6Ug5i35gqxXUq1bedAmZWR79wdfgqa2v1utzwFC7KBF/F2sCJQSSGcJAuIsyd9va3wcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmchzNMf; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8951c720496so9725846d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 14:18:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770761897; cv=none;
        d=google.com; s=arc-20240605;
        b=Cr70wmtTpa+hNG69bke2u9sf+KmxnIN0tpJUpczOs0w+3FwdWqTZaoXZzcc1Xy9Fru
         HGGHAptQmclNPazo+I6Tc4/f/eXd8ZIgofDOJ1ljq8+vUUUEhX8g0yrbX87fcu5VAiWC
         bfedK00AgiyAVzC5xUVYV5ALSX8wVg1arFSC+SP8bScp7ubWh5CgQcifzPqF4kDuURfv
         a8Cjt7Uk3Kr0sJ9NQfRLrRC80KFsWRtQWMCAMosI3r2OqEhzPriTFLvKQ+vo8fBG0SVQ
         bDkrUOtjkROzEuM7E+Tk6wOsDdKUBcTkcvmBXtE7IPVIwjimy72MAi82UCRHQWl3i+cQ
         plAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vNomemunjMrtUzmRAId6Y6DAwkM/ynwARkFTayHGiVg=;
        fh=oQ8OzDdueF2+zKwBRkUokq5V3FUPEqdX4TI3WvUj6Ak=;
        b=P/BameMXtoUekESuq5u4yFo6eon7atZuUpuZtLGdY+/wrEM90uSl+NppqBvxa5Hldr
         u1SB+pvMN9oV8pHP4pngbvPbzs21pKAvBqS75xEQCyzqtkSps5PpLgYLFXZViqrR5Kpt
         82Ekj4BQri2+XzsMR1L0CGGIFZ83B9Kw7FV53ha5F9tW+ehWoU2r1oquWqrLlNiJ6f+m
         mq/N3nze6J/7Nyf8uvN1Yvc0Q0x0UhOvp9iktPDq4iyZnbaejzN5Aq85moYdeI4GA/6x
         XGfhYN4hjkZMn2djqqGJ/raMCDeBHXP5QIUyv8i6zhX+kJ0tprCoonLx2OJkGl29Qu3A
         2Pdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770761897; x=1771366697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNomemunjMrtUzmRAId6Y6DAwkM/ynwARkFTayHGiVg=;
        b=VmchzNMf/myVjtzeD8coa7FHM0tGa6Df9w/ppYD4z47pVKSB6GuWR4T3A33juCeZ2V
         mKxAzxDLtGm1pA4urAOQmqRdbbqedlfPneaDX6ZenEDjO73Av0IJiJDs7N/zy8ewlF/D
         57vlDxueW+2qpp6ovL1TlO3WCy/jns3bandEKevs7qgPSRE55wNY9cSDpqPLimzp7stO
         4DydpZdDSv6C8BFbgPJrespwxAIjh8PWXZRLuPDE+CCRgujmv5kxK3EWA3wsHp2QyVwp
         eN1NvRwVg04iQ3n1KVsBtltEgeAiuCwxPF9pZTq6WMmdkBApBpVZnJ0SwzZCr96U75IJ
         U55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770761897; x=1771366697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vNomemunjMrtUzmRAId6Y6DAwkM/ynwARkFTayHGiVg=;
        b=tg1OWc9e/D0s/rvEWxioFnaM/aagsDjrJml+pZnlnWop2CqVoPl46f5IQnMCc7OHkn
         J0TpG7A9NflikfvMgCOvEYkkoH/OlHlg5kxUZk0H8Z+13x+s69zwaGGeLDrTvyiWGEYQ
         8o/UeA1TFuO5SFy6AGEE+QypKgXjiZlvoo/yI4K/S+Y1dLArn4DHfo/2a5rLNTQ8iH8E
         uyyN66BF7hVvTXrIKTjWJCDehn+sNi7Kur5LXw1MWmfd+/KWg9gqXyDt7QqBQeRN/1Tk
         yT6xb+fVYruQONC8rPBl2JRyaegUwxbC8cK03D3W2+9FtomY7C8wv/ChDbbRbPy0C7q5
         Wh8A==
X-Forwarded-Encrypted: i=1; AJvYcCX2gKfy3jhKnR2GTjZjmYa2UC4+lIenNMm/fvUzhAFZpC4CkIUuo/tTCYzq6dgqPCPm6UIxtlRoMz51i5HK@vger.kernel.org
X-Gm-Message-State: AOJu0YwKP5dKfmA6UWpz8Hltbl1MMC/PkIbHBx4nkqtzt3906ToZQ8WH
	B6ubHO+XcqNsqgnmEhiVrgZY9bNYR4ApzG/toUq6xgenZn7K29Ur3PRzLHUfUT4jmKQbXEjmB8f
	JOOX1+ZIdHcp+qXIgOJfxeNVmZ9J0H9rna6iiS4I=
X-Gm-Gg: AZuq6aKDD//MVfWsir7/F9nIvRg/vF3ALymawK33Zc3yWlAPR4cygXL5zbVHghTmlEe
	pAafK304N3dqR8iPec+cLaEZMFXAaovgR71ZjCVbmoKJNfy8rW8cCekbvM/OOrZkoRmrdUKoN3m
	VM1jvzX/+gOWYnKweCAn3Ulh29bb8gfa0Yx1emJ8mMWCk3+qOdVdq05KwtOPJFJ3ahBsTPJGwSB
	7Jj1kGFC9AbtWVsWEZ8AwVeHOM+gcqiO5WafJdHmYQ+Zvnmzas5j6EBoqAgtv3TeQ27ta/UEVuj
	wN46LQ==
X-Received: by 2002:ad4:4ea1:0:b0:88f:d4b1:4c32 with SMTP id
 6a1803df08f44-8953d0dcf34mr234078736d6.63.1770761897169; Tue, 10 Feb 2026
 14:18:17 -0800 (PST)
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
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org> <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
 <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Feb 2026 14:18:06 -0800
X-Gm-Features: AZwV_Qj3l3c8KkKti6eJRZ4tbSMXk6nsIBYMUVhCebQQhtOHxBIJcyTAZ8AkqgI
Message-ID: <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-76896-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BA85211FB6E
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 4:40=E2=80=AFPM Wei Gao <wegao@suse.com> wrote:
>
> On Mon, Feb 09, 2026 at 04:20:01PM -0800, Joanne Koong wrote:
> > On Mon, Feb 9, 2026 at 4:12=E2=80=AFPM Wei Gao <wegao@suse.com> wrote:
> > >
> > > On Mon, Feb 09, 2026 at 11:08:50AM -0800, Joanne Koong wrote:
> > > > On Fri, Feb 6, 2026 at 11:16=E2=80=AFPM Wei Gao <wegao@suse.com> wr=
ote:
> > > > >
> > > > > On Tue, Dec 23, 2025 at 08:31:57PM -0500, Sasha Levin wrote:
> > > > > > On Tue, Dec 23, 2025 at 05:12:09PM -0800, Joanne Koong wrote:
> > > > > > > On Tue, Dec 23, 2025 at 2:30=E2=80=AFPM Sasha Levin <sashal@k=
ernel.org> wrote:
> > > > > > > >
> > > > > > >
> > > > > > > Hi Sasha,
> > > > > > >
> > > > > > > Thanks for your patch and for the detailed writeup.
> > > > > >
> > > > > > Thanks for looking into this!
> > > > > >
> > > > > > > > When iomap uses large folios, per-block uptodate tracking i=
s managed via
> > > > > > > > iomap_folio_state (ifs). A race condition can cause the ifs=
 uptodate bits
> > > > > > > > to become inconsistent with the folio's uptodate flag.
> > > > > > > >
> > > > > > > > The race occurs because folio_end_read() uses XOR semantics=
 to atomically
> > > > > > > > set the uptodate bit and clear the locked bit:
> > > > > > > >
> > > > > > > >   Thread A (read completion):          Thread B (concurrent=
 write):
> > > > > > > >   --------------------------------     --------------------=
------------
> > > > > > > >   iomap_finish_folio_read()
> > > > > > > >     spin_lock(state_lock)
> > > > > > > >     ifs_set_range_uptodate() -> true
> > > > > > > >     spin_unlock(state_lock)
> > > > > > > >                                        iomap_set_range_upto=
date()
> > > > > > > >                                          spin_lock(state_lo=
ck)
> > > > > > > >                                          ifs_set_range_upto=
date() -> true
> > > > > > > >                                          spin_unlock(state_=
lock)
> > > > > > > >                                          folio_mark_uptodat=
e(folio)
> > > > > > > >     folio_end_read(folio, true)
> > > > > > > >       folio_xor_flags()  // XOR CLEARS uptodate!
> > > > > > >
> > > > > > > The part I'm confused about here is how this can happen betwe=
en a
> > > > > > > concurrent read and write. My understanding is that the folio=
 is
> > > > > > > locked when the read occurs and locked when the write occurs =
and both
> > > > > > > locks get dropped only when the read or write finishes. Looki=
ng at
> > > > > > > iomap code, I see iomap_set_range_uptodate() getting called i=
n
> > > > > > > __iomap_write_begin() and __iomap_write_end() for the writes,=
 but in
> > > > > > > both those places the folio lock is held while this is called=
. I'm not
> > > > > > > seeing how the read and write race in the diagram can happen,=
 but
> > > > > > > maybe I'm missing something here?
> > > > > >
> > > > > > Hmm, you're right... The folio lock should prevent concurrent r=
ead/write
> > > > > > access. Looking at this again, I suspect that FUSE was calling
> > > > > > folio_clear_uptodate() and folio_mark_uptodate() directly witho=
ut updating the
> > > > > > ifs bits. For example, in fuse_send_write_pages() on write erro=
r, it calls
> > > > > > folio_clear_uptodate(folio) which clears the folio flag but lea=
ves ifs still
> > > > > > showing all blocks uptodate?
> > > > >
> > > > > Hi Sasha
> > > > > On PowerPC with 64KB page size, msync04 fails with SIGBUS on NTFS=
-FUSE. The issue stems from a state inconsistency between
> > > > > the iomap_folio_state (ifs) bitmap and the folio's Uptodate flag.
> > > > > tst_test.c:1985: TINFO: =3D=3D=3D Testing on ntfs =3D=3D=3D
> > > > > tst_test.c:1290: TINFO: Formatting /dev/loop0 with ntfs opts=3D''=
 extra opts=3D''
> > > > > Failed to set locale, using default 'C'.
> > > > > The partition start sector was not specified for /dev/loop0 and i=
t could not be obtained automatically.  It has been set to 0.
> > > > > The number of sectors per track was not specified for /dev/loop0 =
and it could not be obtained automatically.  It has been set to 0.
> > > > > The number of heads was not specified for /dev/loop0 and it could=
 not be obtained automatically.  It has been set to 0.
> > > > > To boot from a device, Windows needs the 'partition start sector'=
, the 'sectors per track' and the 'number of heads' to be set.
> > > > > Windows will not be able to boot from this device.
> > > > > tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_msy3ljVxi=
/msync04 fstyp=3Dntfs flags=3D0
> > > > > tst_test.c:1302: TINFO: Trying FUSE...
> > > > > tst_test.c:1953: TBROK: Test killed by SIGBUS!
> > > > >
> > > > > Root Cause Analysis: When a page fault triggers fuse_read_folio, =
the iomap_read_folio_iter handles the request. For a 64KB page,
> > > > > after fetching 4KB via fuse_iomap_read_folio_range_async, the rem=
aining 60KB (61440 bytes) is zero-filled via iomap_block_needs_zeroing,
> > > > > then iomap_set_range_uptodate marks the folio as Uptodate globall=
y, after folio_xor_flags folio's uptodate become 0 again, finally trigger
> > > > > an SIGBUS issue in filemap_fault.
> > > >
> > > > Hi Wei,
> > > >
> > > > Thanks for your report. afaict, this scenario occurs only if the
> > > > server is a fuseblk server with a block size different from the mem=
ory
> > > > page size and if the file size is less than the size of the folio
> > > > being read in.
> > > Thanks for checking this and give quick feedback :)
> > > >
> > > > Could you verify that this snippet from Sasha's patch fixes the iss=
ue?:
> > > Yes, Sasha's patch can fixes the issue.
> >
> > I think just those lines I pasted from Sasha's patch is the relevant
> > fix. Could you verify that just those lines (without the changes
> > from the rest of his patch) fixes the issue?
> Yes, i just add two lines change in iomap_set_range_uptodate can fixes
> the issue.

Great, thank you for confirming.

Sasha, would you mind submitting this snippet of your patch as the fix
for the EOF zeroing issue? I think it could be restructured to

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1fe19b4ee2f4..412e661871f8 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -87,7 +87,16 @@ static void iomap_set_range_uptodate(struct folio
*folio, size_t off,

        if (ifs) {
                spin_lock_irqsave(&ifs->state_lock, flags);
-               uptodate =3D ifs_set_range_uptodate(folio, ifs, off, len);
+               /*
+                * If a read is in progress, we must NOT call
folio_mark_uptodate.
+                * The read completion path (iomap_finish_folio_read or
+                * iomap_read_end) will call folio_end_read() which uses XO=
R
+                * semantics to set the uptodate bit. If we set it here, th=
e XOR
+                * in folio_end_read() will clear it, leaving the folio not
+                * uptodate.
+                */
+               uptodate =3D ifs_set_range_uptodate(folio, ifs, off, len) &=
&
+                       !ifs->read_bytes_pending;
                spin_unlock_irqrestore(&ifs->state_lock, flags);
        }

to be a bit more concise.

If you're busy and don't have the bandwidth, I'm happy to forward the
patch on your behalf with your Signed-off-by / authorship.

Thanks,
Joanne
> +               if (uptodate && ifs->read_bytes_pending)
> +                       uptodate =3D false;
> >
> > Thanks,
> > Joanne
> >
> >
> > > >
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index e5c1ca440d93..7ceda24cf6a7 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -87,12 +86,50 @@ static void iomap_set_range_uptodate(struct fol=
io
> > > > *folio, size_t off,
> > > >   if (ifs) {
> > > >           spin_lock_irqsave(&ifs->state_lock, flags);
> > > >           uptodate =3D ifs_set_range_uptodate(folio, ifs, off, len)=
;
> > > >           + /*
> > > >           + * If a read is in progress, we must NOT call folio_mark=
_uptodate
> > > >           + * here. The read completion path (iomap_finish_folio_re=
ad or
> > > >           + * iomap_read_end) will call folio_end_read() which uses=
 XOR
> > > >           + * semantics to set the uptodate bit. If we set it here,=
 the XOR
> > > >           + * in folio_end_read() will clear it, leaving the folio =
not
> > > >           + * uptodate while the ifs says all blocks are uptodate.
> > > >           + */
> > > >          + if (uptodate && ifs->read_bytes_pending)
> > > >                    + uptodate =3D false;
> > > >         spin_unlock_irqrestore(&ifs->state_lock, flags);
> > > >   }
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > >
> > > > > So your iomap_set_range_uptodate patch can fix above failed case =
since it block mark folio's uptodate to 1.
> > > > > Hope my findings are helpful.
> > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > > Sasha
> > > > > >

