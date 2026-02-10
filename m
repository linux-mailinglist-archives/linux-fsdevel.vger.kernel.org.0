Return-Path: <linux-fsdevel+bounces-76871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGmRBmSBi2m+UwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:05:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A211E7DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D3F303FF24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D332DFA2D;
	Tue, 10 Feb 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFAfxdwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED72836A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750297; cv=pass; b=Tpjscf8OHrwWvxR+S7IxBd1W5YvqemK16wjXzb2sFBvc1LUwy0EoJLI4hfVkc4ta/Dn/Wzip2SHs/0UIlWvZJz6diyNw2IPRUhRFs6XdWWDoUmaBNPO4rsRIeS66scbd9+Jp9FIsEpjLFGBLaWJY1+IDcQd0yoQ/VutXp6d+Sv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750297; c=relaxed/simple;
	bh=waSjE+rNF9IPR01Ke+2jjzhLW5be7EOFjC/vRgwA+j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaUcjefwSV1z/4e4dCTBt6l9YbW4u4BDde8DdDMTvF/2O8R+Zsd1752CrnDah9ExH0StCBn5lscu3Te9HyzqSffDyyvrqwTvFBVzXKmwYE7DnS1ud1K+k2C+542xdWj1wch9HDlxRcZZafxQjMqy0qRePoYo7jgCNvuAeanW7rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFAfxdwG; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35480b0827bso96490a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 11:04:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770750295; cv=none;
        d=google.com; s=arc-20240605;
        b=b/ruAHTjE2Pd7qwvciJUxcvdc525Dh1fObfpidL3/P7dQ7Hde0Rmlhxus3DoBD4mLs
         pXH2tngVoDL1hSgzg4GdIpL4TayVzoC2apw+2Mfke4w4qu5WjjI/XUQNE3Xwjnr5kiEN
         9s6UQgIqRd5mQo5rBlZpa/cUDg+e5FMMjYe6y7KYiGJO4t3X2+MBnILNWwTYOoCZnP/e
         4XpRgDqw1YcSOTT4xteDLNVaFdZQyYFAX8g9MA5oEHy5i6se1OaeVFHug2sDX9crbQjp
         0M+M6SeYCMubdnpffo6mT3M0Q8bao8eKmSHkMPpcXMohb/aKRNwvu1XV4PsXdNwSGgzj
         Q9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zA1TNrRJqKyG8q/TmmtSKmp3ptZDT+TpaazJ5Y0UgEs=;
        fh=ZYhQ7loVXEMnCg+jy4AVCLxP0wcR+IVkaBENjp10mf8=;
        b=G8Itnz5ouwl4UwUXHHTROntXyj00TW5ya7RyMxsue1UphRrBBFRPQd3YvrCsxLJGLn
         OeKaRILaWIAbZ6CSoirNP27EbDZ1Tz71QInhUaF9gygEhjU48b655uYjwajmtcUbkEfX
         95QyAZGyLJ8AeHLk6pWSHpKjUf4BubT/EAkaBRfoxkCtNdzVnq5imZKi64BCxY2i8Z4t
         dHb/dGnZlNtpnbW0ExU+yA9FJ9AGF58fSSeaCskXlMe7dPtKFHENunt1Y395JwaqgmKB
         tkAAos2w0/tipqjHzytFPeynYwBR5bO+SdOoOAS61cLU1xG+CEoqpWKaWIvtJ+GU7Qwy
         rJxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770750295; x=1771355095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zA1TNrRJqKyG8q/TmmtSKmp3ptZDT+TpaazJ5Y0UgEs=;
        b=DFAfxdwGaB/wDB1InxJLX5WJqq2HrYmL0QfsT4n9vuwW8J0eqFk3d85OM4+OC1HDXo
         WMPHzHwLIL8zlR7fW10CD+uKJ0zEVxRLnxtjmgDx2L6ZBetM9rNwnwvHVmOzb0ciBrRo
         t28EHo80Q9AYksrE9SPVClzF9o01CVVLjFVC59LCVkXIpdNxHUeVwKeYp5cCjjGVOGob
         fDd3zZHa4jrQ6X3J4fQ8/CiOdEVFZUPhVlX95z6topjTQhdBtmFYj9W/hL4znFioBmVC
         A9ZL3Te5YvpCu2760eBRBu8oNO2RWRrAh3/3XFTQlSQARZkp0G3kRtPq2ZzvArN9nDwg
         3wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770750295; x=1771355095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zA1TNrRJqKyG8q/TmmtSKmp3ptZDT+TpaazJ5Y0UgEs=;
        b=ZJd39GggVdNdBtfSqk1XlOlFq30NhUw0Oe5Amg2FtbyQJie+y02pMLDM+8WWBC++bM
         VCUYmU77BYWihFHr8qr5pWAbUH1HYYonxxO0hffdbsRljZq5pHHC1q2xOS+3FY5SIEaz
         KIuXOblZfaor21kA0UJENGDvyP75oCD3wRDz6p2RCInkgalr8z0RZyR/VKAo6yjmLKRU
         vuDe9iWlu0+yjSrRh6HeOBVTiz9xItDJlHr/f1tAh8L1k1n0wu0a88DKLiGhJhiUbqk9
         MZu1mANXTKySMxrS5NIffoOFz0YyMTlOXnWtYK+irsG4k7uyKaEOBk5ZlFipvYO7Wh5x
         ItcA==
X-Forwarded-Encrypted: i=1; AJvYcCXIW7gqYfM3zrJjM3ZW0lsNkLogGxSugwc3C1FLMagZxfERgaESgRD2qhR8vjJeEyBcE4Og5DayeF114wah@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzny9Han84pcNtSrk0wk333/AoWb5tk7skOqKJPZD9hwJXDLCz
	8lGzxzqD18BeoSg+pFakfJJlfkQTYbEo2dhdCaQclc4Wlww3+PcA6FA7B+PmGTb1xLvQByXjxDY
	JwgTAZq7d8TmKmIn5q4GdsFjR/osMd2M=
X-Gm-Gg: AZuq6aIpVtAl4YLrQHVzsvKiYbZiACpdCbi45S+nEJa8LTJ+nR8mGm37DZtMYwsKSYm
	byZhD74oBt8QM4e0Ne3saLwYa4JNHgNs4meezyJ4g9UQt1MQlr+XsB/VlQL26m5EZFsX365yfyT
	xIyR06ChvKjlOLBsERYayELUpIVnetWA7TNsF4Rj2xPmQh4bKqtew2Uw2b1jQatlHkNP6otLV6t
	+oCvTw2dE3JFmSYOL2Hqcwu8oT+l3B+MxkJEejuQZYzantqYIYeVrbx6E6tSgY4bPkIBgGamMbw
	KUVFP96Kg6Gg+QO4Hjg3eqQ=
X-Received: by 2002:a17:90a:c2c8:b0:356:26c5:aaa9 with SMTP id
 98e67ed59e1d1-3566615404amr2614078a91.2.1770750295328; Tue, 10 Feb 2026
 11:04:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129215340.3742283-1-andrii@kernel.org> <87qzqsa1br.ffs@tglx>
In-Reply-To: <87qzqsa1br.ffs@tglx>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Feb 2026 11:04:42 -0800
X-Gm-Features: AZwV_QioTD-2tB90VI5wBvuDYhjyIi8I9OHw4H2v3xPsXfvoZ1RNWowMJzaHBTc
Message-ID: <CAEf4BzZHktcrxO0_PnMer-oEsAm++R4VZKj-gCmft-mVi58P8g@mail.gmail.com>
Subject: Re: [BUG] [PATCH v2 mm-stable] procfs: avoid fetching build ID while
 holding VMA lock
To: Thomas Gleixner <tglx@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, surenb@google.com, 
	shakeel.butt@linux.dev, syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com, 
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-76871-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a,237b5b985b78c1da9600];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A59A211E7DE
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:41=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
>
> On Thu, Jan 29 2026 at 13:53, Andrii Nakryiko wrote:
> >       /* unlock vma or mmap_lock, and put mm_struct before copying data=
 to user */
> >       query_vma_teardown(&lock_ctx);
> >       mmput(mm);
> >
> > +     if (karg.build_id_size) {
> > +             __u32 build_id_sz;
> > +
> > +             if (vm_file)
> > +                     err =3D build_id_parse_file(vm_file, build_id_buf=
, &build_id_sz);
> > +             else
> > +                     err =3D -ENOENT;
> > +             if (err) {
> > +                     karg.build_id_size =3D 0;
> > +             } else {
> > +                     if (karg.build_id_size < build_id_sz) {
> > +                             err =3D -ENAMETOOLONG;
> > +                             goto out;
>
> Introduces a double mmput() here.
>
> > +                     }
> > +                     karg.build_id_size =3D build_id_sz;
> > +             }
> > +     }
> > +
> > +     if (vm_file)
> > +             fput(vm_file);
> > +
> >       if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_n=
ame_addr),
> >                                              name, karg.vma_name_size))=
 {
> >               kfree(name_buf);
> > @@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, v=
oid __user *uarg)
> >  out:
> >       query_vma_teardown(&lock_ctx);
> >       mmput(mm);
> > +     if (vm_file)
> > +             fput(vm_file);
> >       kfree(name_buf);
> >       return err;
>
> See:
>
>         https://lore.kernel.org/all/698aaf3c.050a0220.3b3015.0088.GAE@goo=
gle.com/T/#u
>

Ah, silly mistake on my part, thanks for the heads up, I'll send a fix shor=
tly

> Thanks
>
>         tglx

