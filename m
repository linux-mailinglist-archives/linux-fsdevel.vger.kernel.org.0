Return-Path: <linux-fsdevel+bounces-78220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAqqGKMgnWniMwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 04:53:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC901817B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 04:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B54A302926C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 03:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C561A38F9;
	Tue, 24 Feb 2026 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teyf8iQ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E61C01
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771905185; cv=pass; b=eyVcBPvsO9tMuA0Kz38SRIDYRwMNWPvrj7UVtDplpcLrVa8HCV4l3JWTnRmbXlhrl37/r/W8TT9JdxntccGJj48S3EntnWZ774h5qOACrUozwcr9dvrq9Vn0aKySInO5pXcmfuauOU/QFSlVUBx86FWq3nerQOIvUrgMEn99+zE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771905185; c=relaxed/simple;
	bh=mxHe/wBeje0IHM84/OUx1nFmAzSuOXwCPR3VB4IUhrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/GnUO9JtFV/P2sz6UlYHQkHXjnB2Ok1c3YZkmn2Os/LzGQ7h/iO/hzpa7trgjJV19Fl5fnUbIAUhIg6ATGYCyKmzzzjvUZFs1II051vwftgVrZauD3BwqOPASkshPt1M6b8C9i8RW5csUR7ayqRfDsb9FuGtsH1DscqPf3W4Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Teyf8iQ5; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad9fabd08so4723108d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 19:53:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771905183; cv=none;
        d=google.com; s=arc-20240605;
        b=jM5s021hJLLjFpW65LYrn9fTZ4Y2To7gz18uXSZhSnrfLsOo7qAKw7WYH8Jpvf8aGh
         VzTfqfi6TrajjjaH0RmiSwtopL8VgopuEcDdPeVcV/6V8Jzan3QVl8/wM5ovlzE1EXJj
         3hduPLa0fvmcKcWMPrxrIcYlGUgKGtZ1yLhhyWYiWTlno1mXZlJF55XxWQzwamzyeUR1
         Y3kMWNq49sBejuYJlBZEjRjqqWY9NkjFJoTkfwLolaItQuuypJ+XRatB2HsFosvcjFzG
         t5lGtkiATR6c+x6fumNDOrZL7FhMNEY5IgnI/5Tr4010H/hsui5FJrQaV0A3gY70RoAh
         l8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=idVJIGjiU1QJV7DJ13fE6/94mIRjjSU5wnNEa/aUN70=;
        fh=FgJJadUkqlNV1oAPa53la2bfxlwV7vIglPh9tNMWKr4=;
        b=ToIR1vw08FWyxoSsKjkXXkKpxCa0gQaPgnPB6McOaw+sSsDGjM4+dBBjuarY09/yUY
         lhd7+yjSFS1IfIM0D/LEaTHI6QxYgWTczGs0Btn1pamN5J2IJWE9PVSsE5q0sGnI9fj0
         1E+RV+Pcg2HMln0EoCjyPbck/igs9B9ATnwjCv3cHSQ4PgvHdVSFTrxCyLJy//oOqVIg
         oB4nGK9Dhvd6f5SwFTdNmY9/BPCXk2DWbbqVLDLkUIP6jgUR6aIb0gP3GOViLX5MLEJ5
         UzHbj8FFLQpf5nu+CWymOt2BmVc5qr4BRm1AioKqYGiWz8YyCtIQGQvKG8GpNjB+1V5F
         Wzpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771905183; x=1772509983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idVJIGjiU1QJV7DJ13fE6/94mIRjjSU5wnNEa/aUN70=;
        b=Teyf8iQ5Qb9l16J6rRAA4Bv3o2xgKEk71cz/U64jFZ0lmKUfS64sQ7CwBD/LpgLpxq
         12f/bIZHhPorR5/zpXGr48YdPjEydxsGEeOnIMJHDQbh8MoOQbSz7J8qRiZX2yrpo2/6
         cRUlqS9JjOzxXtYfnoSs3V5bQmvJh+3fyoDmk9Ab7kc4NLTxBRpLwfbf5/Qp15hWojbv
         VnSz3CuEqOhdahJIDeGBlHbbDWL93WHN/ntLqOWi0JACTA5aPczuFR+8rnCIKTrfcfLD
         G1VD/mMfNB9hlYI7Xn+PfIKmgVphhGBM4FnHJCz8hc1FBgCvZ3ru7N6Hl4Zf+R+3OxHT
         FpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771905183; x=1772509983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=idVJIGjiU1QJV7DJ13fE6/94mIRjjSU5wnNEa/aUN70=;
        b=NKg0AwnUvy0aXX+fT8RKNNw4imZwqUGWYBpl+cjuorhB+Vp4Cbd9mo2T5JeyY0taa6
         3M4tZc/f3WwQgbwm8iUgjPfAzNn0uWQ+hC2RMn1Kbr4Mdd2anWVOYsoHtdxYISLD+FjB
         CHhelXD+lN8YLZ5EOq/Z8sw0RgSUuFIv/yi/PHzqPV+FapSqNKm7/V0shhOjZiFxhXLM
         BwrZ1g/tsD80b6aT0M5eXKxnb4lFQNRQ/f9XAbHMb9oG8KDIklbZXtJ+D1Jxmf1h8P/h
         Wc3lW2jNvv9zKerI0s2vvPLloBBvLYN3CwP/4XJJD0dhcurl5p1iEfdEn4ej5VveuY/Z
         2KPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV13cvQOrLACP0eDJxBoMdSOXCjX75WLKM3xr+FBEety2NWu1rUS5cXqeSPmuPQM/FBDvPDLBPEfHKWkyld@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQJNDKtfGcqi8f0WGhV875Fpb4kXfDufX1/eM7AHFM70QfKKg
	jRQTu2Nbqxx2gEEuQkcXx4T2w7QZ0UeqTDDDf0NEAK5B+9JI266TQUYXtsGCUVXsywY6U9F3RXM
	dgN+TuaBg7Mlpo8SNJTY4Fd8uhBT7f1E=
X-Gm-Gg: ATEYQzyvM77XanI6Q6H3nR5Pyy3voEHKhiN+RhbtGYyFlXtNJZ1vDpmv/sX6O2E1LhZ
	zqY04NCBsLc0VBB/+Q4ZKq6wfvKCUWUU5KMFv4EIcLcU6RedFu/6dvxFehNGfM+1ECP6Tk+Kgr+
	aMQ1I4dIuMwh1BdC1AGBVUe1X2iJdozTYMwSPTz0mT3S7zGvWunwFz5aVN9vFYScRQGdaQLDc4l
	0H4GEbftNGT016l7WpsJ/ccsdzOxho7MvwBKca1Oy7h1gGvx1iP4ejWsUPm0cVYMz+Ya5rBMjUY
	7uYdpt9Vr1yfBBpr9OSCILCJ32X+gglXp8cG2q2+YgzDwvSRTFsi7bjjk+ujzQuKyALJCbBPYAk
	vP0gs9Q==
X-Received: by 2002:a05:690e:1488:b0:649:97a4:d5d4 with SMTP id
 956f58d0204a3-64c790725e7mr8489842d50.78.1771905183308; Mon, 23 Feb 2026
 19:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221061626.15853-1-kartikey406@gmail.com> <9f5701d8b45cba21a01baf5d2ce758e3a5a4a8b9.camel@ibm.com>
In-Reply-To: <9f5701d8b45cba21a01baf5d2ce758e3a5a4a8b9.camel@ibm.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 24 Feb 2026 09:22:48 +0530
X-Gm-Features: AaiRm50GW1szmcU6LQm9GG8s5HQl05mPW4eM0gSV7YBOg1UsKyBk9VJ5ShVt3LU
Message-ID: <CADhLXY4Of=3ekg86ggi68_VEtYh6qDr-OtfP-D3=4mc9xm0i+Q@mail.gmail.com>
Subject: Re: [PATCH v5] hfsplus: fix uninit-value by validating catalog record size
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, "charmitro@posteo.net" <charmitro@posteo.net>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com" <syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78220-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4AC901817B1
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:28=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>

> > +     case HFSPLUS_FILE_THREAD:
> > +             /* Ensure we have at least the fixed fields before readin=
g nodeName.length */
> > +             if (fd->entrylength < offsetof(struct hfsplus_cat_thread,=
 nodeName) +
> > +                 offsetof(struct hfsplus_unistr, unicode)) {
> > +                     pr_err("thread record too short (got %u)\n", fd->=
entrylength);
> > +                     return -EIO;
> > +             }

The check is in the HFSPLUS_FOLDER_THREAD/HFSPLUS_FILE_THREAD case in
hfsplus_brec_read_cat() function (fs/hfsplus/bfind.c):

This validates that we have at least the minimum bytes needed before
calling hfsplus_cat_thread_size() which reads nodeName.length.

