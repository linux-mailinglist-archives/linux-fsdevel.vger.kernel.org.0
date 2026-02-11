Return-Path: <linux-fsdevel+bounces-76968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hnP8OIPZjGlIuAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:33:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3B1272CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5300F3014C19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843C8350A21;
	Wed, 11 Feb 2026 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcFcUBio"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0EA1FE47C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838399; cv=pass; b=uQN46eR6go0lgHpCvksflAsDuG9xfTNT18Bqpw4w0MGaNASTnI+9r1V89e4WUnaksx52w5nwdRE1Rj3jPsyM+qR/zU79XpiiSE1FVmxbJV32lFYVXvbz5J0JLv+9w9oWX/QGua7QO3Cu1DpBCC1qG1Lwd1ID5o3L0BOVeOoijOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838399; c=relaxed/simple;
	bh=o1oArdx/HIluGTQrcrwhYuhnX+fF9TkiKy2MQhq5sx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=se0DS2cSi1WITMVbsRx/fOGyX3x9shYDaQArHuZu1Df9pWjlo+Hj++LebKcnT0Q7Y/iOW4mVSkM8+72wJQ52NGRouPgeZwEyuKypmJHDlR0WJVlcW3zP7B9LygVKxQgrUd2Iiwb3fXeFMwPfAi0cmZp+QS15ojajrldN90bSJj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcFcUBio; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89473f15ed8so20998646d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 11:33:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770838397; cv=none;
        d=google.com; s=arc-20240605;
        b=DhkpOKNzPAuYFQ8LuLy50+ul0UxaLiBlVVHcMq9eRj4ASq0T28dYQG83ULANTzTZIe
         DINYV5gsLcPYI23P/BgaDFiq9XxsItDjzST5nQIITKYmbcfDEfhfj0eEBf0xIpgmsahD
         bVYBLE0ur/jRhig2Y6iIDP/G3wFkR1WQtvNoQZfc5qKjSVj8xh3hLVbQ324mvxZMfkey
         4m9c6Ye6CZ7BdKan8VGWdoYRYKjPHMQceldRZ3FL+EBeEY9TBQfzeag6G4Qe0L7hzK94
         PgBWqFcy826fEPkvm4FcVsHxhoBjFCj+uBdqScGpFxeEfPz+2nkWbQ71V19QkC4C8bwC
         7PVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y33bx3hdCnJJ1e938j2kVmQAaaJitmCpkVbJT3zGocw=;
        fh=iGdZARzEWYYElGBsjCGOTdI0EsrVusiFA6nBcL4yutA=;
        b=FnGzvW+NYJMmyEh5AiK1YPyveLLkYt76iV3nbzbp88Mzo0FLN+LdmrbZdXmmplPFFU
         ndhetCRriwB30icTCg8snrlc3WNqFQKEbrZzvEnoZA72OzwZDFQ7WYbHWw1WggCdk2sD
         C/jHz/X7MUoxtlUmmvX9r8E0YVPs3FEV2qkJQfnIxQoCnptS7AiJ0LphLlYYH60PS0uP
         RlPrhP+mUVjRhdUtZTgu7QBHcWstGMihaar4C+6l5RGHdi9vbWW4RRj2Hq0ezO8fASoO
         V0f8CH2sqyiayNlr8YvtLTrzJhit4wY4KB1p/xVbnnoIFzh7eGUq5W20g5wyFyPPtnhf
         htKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770838397; x=1771443197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y33bx3hdCnJJ1e938j2kVmQAaaJitmCpkVbJT3zGocw=;
        b=OcFcUBioAcFgU2RmMwh75I0EpBrB/y6uRGbhAwp8feneSLb9Mw2Bn0v2E2UkdkQHrO
         5CZwYEOxeTxn1dNYR/GfOQ4o7gV8uLysH6/u92TtuQjphO3epFaiGdKuNIr5lHHbcGsr
         hN3kSaAeFnOyfdr5s3RGFiYd1qi2VS7EPE+ChqF3S8YrmB8IPIceCpC8VWPjob9P+9w4
         dLdjeUHZ7+0w5EF8EZLkyS6tkDyM/Ed2MmvVPOeidDSxNBFYuaHmKKj+JHnpYciSHagU
         Y3Ql45PZBfJa57NwrPq9WhK33lZ+M8PEuI35Svuo8DlgjISo7hT9niMrd9sXJYCHHhZa
         i3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770838397; x=1771443197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y33bx3hdCnJJ1e938j2kVmQAaaJitmCpkVbJT3zGocw=;
        b=O56RgeG7iLqHcGps2LYX1hmzPX2LFOz+LmperMl2BPmanXBcqXoy6ZiY0NgnyjZ7kg
         h+50WzgXFUf8ui+zrN91WiDs1jhTQO6l2mj7wtF96lrpq6v2mEjursG2BceurAAGBD2F
         lDhRqjTKSNPoMEOC+UjjKD6yfb1AbsAH7AzkqBMlh6jomN2xRm8/tqsXzFj3MYftOdPn
         GSNB+Hfef2KBS26zHHvySUL4gXODkd1Nx7r1fwomDJdceWrok4c1LW5DQTl5hjM26pW2
         19eAWYi9FXForPQyf2YorxLe40r31UJ5i+UfGYUZ7E8iuXK+VkYclc8+9Wwnimse5BXK
         /waQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGVG3/Soh66CRF/oop6v9p0Y8MIEgB1wT+Rgnlq+mkEQHQRFgPKno72hG7x3e83H5jUd/GHLQqV/itDq5/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mEGCSuGzP5PZrRpkxTqkNBwpCnB5DKgkTQzT+jM/tVMHWtlQ
	9kiTBU2RIs5pZ/37AF2S46NwJF1PG50xRQhaAI9BIwudXo5SiLiD3oBYCafhnewt/n1RPa1tAif
	mWijCLZ/p2tAVZK29bxp/0d24quMMRAQ=
X-Gm-Gg: AZuq6aL7KbxtL76SVsGk57AINJFlcDdZ5+yc5TQUbkDfeHbVi6M4RXkQhv+dVFVVw7P
	hWaX/Z7I7Z2UcPMBYLAJuKJ5RlOAfKAhQ85DmHfD+dIG9230QwRPnLstiM/f5SMKRgLYe5NKYXO
	ICxJ3OBh1+E2Y1zGI7ABtAXi1i2pcQrmVWZKCsKl7JppcIOmFdR3EDwwCUYI0wmSmgSm0q1Ttmp
	YOc5TvxCJiFWPI2Xy1x1w8B8LKL7Bg1+yHwU7vK1RrD2CQLontvzqfg7/HwIMLrogwZrfALcao7
	OSzrX9OsMmOP1j6a
X-Received: by 2002:a05:6214:ca7:b0:897:277:d03e with SMTP id
 6a1803df08f44-8972797884dmr9709136d6.58.1770838396649; Wed, 11 Feb 2026
 11:33:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223223018.3295372-1-sashal@kernel.org> <20251223223018.3295372-2-sashal@kernel.org>
 <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtCjXbraDrq-Sxe@laps> <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org> <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
 <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org> <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
 <aYvzUihKhMfM6agz@casper.infradead.org>
In-Reply-To: <aYvzUihKhMfM6agz@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 11 Feb 2026 11:33:05 -0800
X-Gm-Features: AZwV_QhC1DYMtCZhEAoc9M6agKyga6UVSYSGFeleEjyqcjOsLktxvssi0NPYdgQ
Message-ID: <CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76968-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 43B3B1272CC
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 7:11=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Feb 10, 2026 at 02:18:06PM -0800, Joanne Koong wrote:
> >                 spin_lock_irqsave(&ifs->state_lock, flags);
> > -               uptodate =3D ifs_set_range_uptodate(folio, ifs, off, le=
n);
> > +               /*
> > +                * If a read is in progress, we must NOT call
> > folio_mark_uptodate.
> > +                * The read completion path (iomap_finish_folio_read or
> > +                * iomap_read_end) will call folio_end_read() which use=
s XOR
> > +                * semantics to set the uptodate bit. If we set it here=
, the XOR
> > +                * in folio_end_read() will clear it, leaving the folio=
 not
> > +                * uptodate.
> > +                */
> > +               uptodate =3D ifs_set_range_uptodate(folio, ifs, off, le=
n) &&
> > +                       !ifs->read_bytes_pending;
> >                 spin_unlock_irqrestore(&ifs->state_lock, flags);
>
> This can't possibly be the right fix.  There's some horrible confusion
> here.  It should not be possible to have read bytes pending _and_ the
> entire folio be uptodate.  That's an invariant that should always be
> maintained.

ifs->read_bytes_pending gets initialized to the folio size, but if the
file being read in is smaller than the size of the folio, then we
reach this scenario because the file has been read in but
ifs->read_bytes_pending is still a positive value because it
represents the bytes between the end of the file and the end of the
folio. If the folio size is 16k and the file size is 4k:
  a) ifs->read_bytes_pending gets initialized to 16k
  b) ->read_folio_range() is called for the 4k read
  c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and the
0 to 4k range is marked uptodate
  d) the post-eof blocks are zeroed and marked uptodate in the call to
iomap_set_range_uptodate()
  e) iomap_set_range_uptodate() sees all the ranges are marked
uptodate and it marks the folio uptodate
  f) iomap_read_end() gets called to subtract the 12k from
ifs->read_bytes_pending. it too sees all the ranges are marked
uptodate and marks the folio uptodate

The same scenario could happen for IOMAP_INLINE mappings if part of
the folio is read in through ->read_folio_range() and then the rest is
read in as inline data.

An alternative solution is to not have zeroed-out / inlined mappings
call iomap_read_end(), eg something like this [1], but this adds
additional complexity and doesn't work if there's additional mappings
for the folio after a non-IOMAP_MAPPED mapping.

Is there a better approach that I'm missing?

Thanks,
Joanne

[1] https://github.com/joannekoong/linux/commit/de48d3c29db8ae654300341e3ee=
c12497df54673

