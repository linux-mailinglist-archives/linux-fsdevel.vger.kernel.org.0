Return-Path: <linux-fsdevel+bounces-76980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KWIA4ENjWlQyQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:15:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB812843E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 00:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED4830EEF9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 23:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E01357737;
	Wed, 11 Feb 2026 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfAtNHzH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54468357714
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851641; cv=pass; b=eFHS+gAj0RF6kU+44vxf7IdTDc4Lp12ZMqrwEbDtkGETSRL0iuHu2VkQuWPkIXh2KFy7yOOIOQwiD09oxvaqDegVDThFtcIVMnsF+ZbjQJUGcydCPA2wR6LgtQelm2K1hemojsfv8q0BoZVDz4Pp2y8Yan87nBPMpVB7wVTyVlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851641; c=relaxed/simple;
	bh=kf1WUuolTs55OkpVz1rJMBnvgP99jhU2nMycoQznB7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ey6pA4vesIYqdou3Z02WwACDE1hOhxlSw+TfpDegCLkDSvwmYZYsjhe/Yp9Cnkq68rF8aktgPJLJwY90Qfwseic5nFbvyViOfSfWqzXnYGk3dJtpnWJIy2R2vh0M75kngRkFHCQKAvunS0wiGTEoWBt2irB1omDX4yPwrJBXnnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfAtNHzH; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5014e1312c6so16767561cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 15:14:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770851639; cv=none;
        d=google.com; s=arc-20240605;
        b=WEPs+KycITdvx1vKEn9jgT5L/sB4a57EnYJjoWBk7jPNTQCxP3zbCEJQl/judqZv73
         PBm5JUc8IbzBWH2Y7PJJJJEX6rFl4S5efLG/cfiIjS0vgcWgSy49htkjYpU0h5ZguiWE
         CIbyS2tbhcoIa+dWHJNOc4vK8kbNQR20Zc0mL7iFYgZoHONxU5znEzquZjUbOsMXIXUa
         iKOEjLpJZyJaNOQrc08v94jbmnTFp9/DArmzspMFB2g3Ul1qH7EU/wnz+y0R2ylZDgXz
         b8ILmOv/bKhRx28zAPbIKtPaHuPgC5HMMZCFk7ClvIzMzSLD7EWS+04sxISD0iO9jz6p
         qBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+m96IzS6L05tHZnyh4pZu0X1rlcuiS6Wf/aXAltvR0I=;
        fh=lFIXp9q4TQLB48Il2YKbF1FcmC/sSqbkrHfckmsqbvQ=;
        b=ihbXy9kODuFIkDtgPtGtyj4X+G4eVS9GuG04w95yGkPjQTUutOOeDOTb3FDD/1pakQ
         stXbSNFRX+PqlJ5AckWmmfdOY0JjNFonnrBiOCAs5IqX7bRUOajm7J5624+08ZpCnPha
         25FYcWVaAPkwq0oiRml68k6ofW7jMsWFObfaQQWwGI14wBq/v7iCcXVskG2ivjg5Yil2
         s01TgUFf+5aAm7fTnEuNa/hOXoVzJ9nnO+1JZjVV7KVBwYpP1hG0tnGl2auu6QC/ZOdU
         J1NxJzDZIyeBJcVjYwWlpSCPrTpjfSh8xmGgQ6NgO6jLh52IU969WHPTydbDcx9+RCtV
         Gjrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770851639; x=1771456439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+m96IzS6L05tHZnyh4pZu0X1rlcuiS6Wf/aXAltvR0I=;
        b=QfAtNHzHkeg4I5/+ru96nVnpqn3F1pJ7kUYo5ufzKbiiNddn+H9FZXllB1IzbvGzkp
         tUd+cXwRLBnheD9/uKDJrFEEm7SLV90crOK5LW3zJtw+KmEaPWZOBRDEwuBQY2bJttIS
         k6LqggjQkdRxGaqtxQjsoN1Le1XqGmfvuCTRCEwRoJr9fD9woxYkt409HNDNrk2y4qwY
         tUilxBGen7rq1Xdn++WDEt3i++lwE/q9dlGoWHg5q8kXu0i0uCNBOShqcljXT+vKV1qW
         YnQU3Pq2J+Eu9Teg3bTGlDiLQA9USs6VLvt+o9gFn5J8K6wzKMJXDsl9cpBp5dxla0kM
         MVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770851639; x=1771456439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+m96IzS6L05tHZnyh4pZu0X1rlcuiS6Wf/aXAltvR0I=;
        b=t74aqfwco/B6R9ttFklWci1yfTeZhJa9UaFQeQ9futBE6OsdsdciwoHURM5+C4zFdP
         Xgudl4mBsLG0O46S7Vj5en7XDY2AjaHjpIZeTzAtMfNcrnuKe1jXZZUqPh6/8V9F/Wpr
         /x1iSERfd5l5eiTpYqNgDy+EKuUdaHKJUd++tASxwvd7HRbNTprER+RArDMb+rbKtJjY
         30H367CaXpgqBLCK+2SByKT/hVieAU5Ukx2MjDcX9fLX46qq1N6xLpUZWh7WEUW3KdsK
         dg66d8mNWjavUN2MiEe0JYU6TLdQIIDbMrhNsTggKEKlQCw/jQhMsR4xhNpUREHQ8qhj
         Upcg==
X-Forwarded-Encrypted: i=1; AJvYcCVHMUkUXbNSNo6zs8NH6FcUjA9wfb1GNNOZh9Hrk09TUEaLR3J0E6s3nBi/T1B9xpMPpXcAqlHPAARFixB/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvx3wEDmNqC5TcDutOVyy3Nx1y7P6R87gM8b+MEXphJoAU2tse
	BdQAsz6CCh8PFJmglH0ObnktC4dQSwwffTmdO+8VvmN+7SyXfMQJSSxM2y6NmvXoGcCAwZVHdgS
	Rrvx5bLWN8lYB0u2yfNhVGIpKZH93vVM=
X-Gm-Gg: AZuq6aKEt0YUHPSW/Snj7bEgNBvt4TKUN13+D21Z3J1hg3+dbN7GjAIStgF01+OJ0Fr
	nEcjevxXqPNkFdoS0TFJwPs604YGH03A095cE3s7xoNp46Fexg1lcGwFD2DWqLGVVhtRMIatHbU
	gr+N7de08j/RbShJ96g6Y+cVOiqzVXQn+QtiqQZOZVp5h2Nm9WinnvL0OJJOkYZzMp0Fl0yFr7g
	qjXke45+Dre3XfjSXzevovOC1ODWG3Sbhoc1WRzeTy3HacvU7XtiPXg7RRvGXTwwJoAH+ZnVxDi
	/XhwGWt21sttyOEF
X-Received: by 2002:ac8:5988:0:b0:501:4703:3b6a with SMTP id
 d75a77b69052e-50694aa2207mr2907091cf.9.1770851639184; Wed, 11 Feb 2026
 15:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1ZiJVNg-k+CSY_VqJ3sQOW1mo6C-9QT0bzgLT4sKGGCyg@mail.gmail.com>
 <aUtCjXbraDrq-Sxe@laps> <aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org>
 <CAJnrk1anodUxD5GR18N8w8239S_kbgijQyZC48Nsa4isb-e5JA@mail.gmail.com>
 <aYp33Ddm7wYFrr_Q@autotest-wegao.qe.prg2.suse.org> <CAJnrk1YARhOOKb=OuDLR-X8_que34Q93WagNMOiTjYVohHLdWA@mail.gmail.com>
 <aYp-aTJPzSnwRd6O@autotest-wegao.qe.prg2.suse.org> <CAJnrk1aPs2J_EerLROxtiHAKTyU2NHBkRXpS=-yunEsC9epAWw@mail.gmail.com>
 <aYvzUihKhMfM6agz@casper.infradead.org> <CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com>
 <aYzulh4XWO-TBof8@casper.infradead.org>
In-Reply-To: <aYzulh4XWO-TBof8@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 11 Feb 2026 15:13:48 -0800
X-Gm-Features: AZwV_QjwRv_jr3ENYEMznicEnms97QtHTWhNRiTpHV_PZVwa6pv4ckPZaSaQr8I
Message-ID: <CAJnrk1YcuhKwbZLo-11=umcTzH_OJ+bdwZq5=XjeJo8gb9e5ig@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76980-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,infradead.org:email]
X-Rspamd-Queue-Id: 29BB812843E
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 1:03=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Feb 11, 2026 at 11:33:05AM -0800, Joanne Koong wrote:
> > ifs->read_bytes_pending gets initialized to the folio size, but if the
> > file being read in is smaller than the size of the folio, then we
> > reach this scenario because the file has been read in but
> > ifs->read_bytes_pending is still a positive value because it
> > represents the bytes between the end of the file and the end of the
> > folio. If the folio size is 16k and the file size is 4k:
> >   a) ifs->read_bytes_pending gets initialized to 16k
> >   b) ->read_folio_range() is called for the 4k read
> >   c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and the
> > 0 to 4k range is marked uptodate
> >   d) the post-eof blocks are zeroed and marked uptodate in the call to
> > iomap_set_range_uptodate()
>
> This is the bug then.  If they're marked uptodate, read_bytes_pending
> should be decremented at the same time.  Now, I appreciate that
> iomap_set_range_uptodate() is called both from iomap_read_folio_iter()
> and __iomap_write_begin(), and it can't decrement read_bytes_pending
> in the latter case.  Perhaps a flag or a second length parameter is
> the solution?

I don't think it's enough to decrement read_bytes_pending by the
zeroed/read-inline length because there's these two edge cases:
a) some blocks in the folio were already uptodate from the very
beginning and skipped for IO but not decremented yet from
ifs->read_bytes_pending, which means in iomap_read_end(),
ifs->read_bytes_pending would be > 0 and the uptodate flag could get
XORed again. This means we need to also decrement read_bytes_pending
by bytes_submitted as well for this case
b) the async ->read_folio_range() callback finishes after the
zeroing's read_bytes_pending decrement and calls folio_end_read(), so
we need to assign ctx->cur_folio to NULL

I think the code would have to look something like [1] (this is
similar to the alternative approach I mentioned in my previous reply
but fixed up to cover some more edge cases).

Thanks,
Joanne

[1] https://github.com/joannekoong/linux/commit/b42f47726433a8130e8c27d1b43=
b16e27dfd6960

>
> >   e) iomap_set_range_uptodate() sees all the ranges are marked
> > uptodate and it marks the folio uptodate
> >   f) iomap_read_end() gets called to subtract the 12k from
> > ifs->read_bytes_pending. it too sees all the ranges are marked
> > uptodate and marks the folio uptodate
> >
> > The same scenario could happen for IOMAP_INLINE mappings if part of
> > the folio is read in through ->read_folio_range() and then the rest is
> > read in as inline data.
>
> This is basically the same case as post-eof.
>
> > An alternative solution is to not have zeroed-out / inlined mappings
> > call iomap_read_end(), eg something like this [1], but this adds
> > additional complexity and doesn't work if there's additional mappings
> > for the folio after a non-IOMAP_MAPPED mapping.

(I was wrong about it not working for cases where's additional
mappings after a non-IOMAP_MAPPED mapping, since both
inline-read/zeroing are no-ops if the entire folio is already
uptodate)

 > >
> > Is there a better approach that I'm missing?
> >
> > Thanks,
> > Joanne
> >
> > [1] https://github.com/joannekoong/linux/commit/de48d3c29db8ae654300341=
e3eec12497df54673

