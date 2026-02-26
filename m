Return-Path: <linux-fsdevel+bounces-78644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDUkFyS5oGnClwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:20:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E4A1AFA6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 22:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E823D30B776F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1E38BF9E;
	Thu, 26 Feb 2026 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfinity.org header.i=@dfinity.org header.b="jsHJxrV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC842DFFE
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140603; cv=pass; b=uVCxgLyidBI4tERFQw5ihydJx4B4Iu1JDydHyLwsNm4AuEAeHjzPLuiP6+ackNHdvsTf4QPirKIpOCfx9z4tuDprSrt6MywpBHWDyypEn9XDm991CbmHdyFs/B4BmixdSZsRiWVvTD/iAUoJwTICY+WI6yEIyq1e2SCH2KtRECI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140603; c=relaxed/simple;
	bh=aQDpDBOvpi76pzP801oVxviwM5NAy4d4k0HoUewE8RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQfhbxWN5YEicBuDWQq+tfxKcDf8FBBSibJ0BjaSYAU6O/By6pO4m0OSJ3DD+FTOSF4eH97a5U0tvXg8tQ97lJLHwZbeBC7u8QV56X7uPbRB/khxN2Wd0T5qOhTERGHBCZgAm79B3gQL3pYZxR8NQK3THDc5FjMG2P388UEBzs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dfinity.org; spf=pass smtp.mailfrom=dfinity.org; dkim=pass (2048-bit key) header.d=dfinity.org header.i=@dfinity.org header.b=jsHJxrV9; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dfinity.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfinity.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65f73d68faeso2325790a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:16:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772140596; cv=none;
        d=google.com; s=arc-20240605;
        b=eQnskyyt8dW0C3ZEcn/MSrT0i47hohAKsxkvJvlZwqFiXIsB6SvaM2gNAxpPf3dU/6
         vIDTl+cZJzUexbY+fn4lT8zzRdYoQQL1HRQTvtRzvyY8FJ2ZjbxjAPzl/ufMezPBYqsV
         VYTsX4qbscrGLYvKYedHPx2QmC5Hfqp4PkOW7E/kijJcONqplkEP7Yriks4ffe5v1kPu
         2eAgZVF91nNiCuPyEKbX56ov7liXV1R4iPFT1ZQCq8yYPU5oBcUwF0rlewErAQYvrc0u
         areJJjG6bkHLZMV8C3sFMHibsfELKukWMm2giFs75/Hb279aWcIIVv0gfWxeFk+rFPUu
         5/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ycYPYyZx7AmOLkJ5x4ffI/sFVR72W8M1sWNLx9umW4=;
        fh=5TNxBL2t8ZVknFSbYR13VQY4lpBRYkRNXG43wtV3FAo=;
        b=ifRYMX+oJ0AJIYHvKfcieffz26xf7zGhDRe2s8BPGAYrL1XTEOe0BkYI1woH3eXFHG
         pIsAtU+KP4GVOv85mVT8TvN5wXdHYFM+wVgCXP7EoSf28Lv/Wzf2J5V8FDh1kji1uQJs
         nNYzfzcqYf5f5GKMQUGfIIINBPPU9abOBuSJEtOUZuhNbSZmoTU7U4oRs9pyueeWidMh
         ax91BrFRFTjn5BqorxpQ/6NBTV3EZfamDE1Ns4Ybc83LqZIaHI5lfilCSaxxmKpZszlx
         zjHZLtN2+ljWtJG57t2nyaS3s9P1QpyvrDi0Anw0gPAOL0lQutncliVyOxOBSjF7VVyY
         krfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dfinity.org; s=google; t=1772140596; x=1772745396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ycYPYyZx7AmOLkJ5x4ffI/sFVR72W8M1sWNLx9umW4=;
        b=jsHJxrV9rwrpojxEGh4Jf7bobd7+6POZLVASMjnPoTvdSP9PJ0b7RfNeMKXuggq78d
         eB9nx8TGefjV8VoEKSS0lpOssjDUdLf6cuQ08SFt6GS7QXzM/iqyf0gkyi643v07ZOJe
         GSOXUmANNLiXvUY4uX2r83pIVqF2/uJETO6RZu7NSFqkdaHkzQXs3i/cskh0zxo6nFDl
         xID/M5NFDIVsrDJ8+G6JhFCzI+V3wprMyV5nqX6C2zmYqBgfjc9mtv3sEp2cJ5sk/b1U
         ZwqVgJ/4wjWkAlUXEUjYn+I/RZu54LL5QtsU4H1hlxJJCBhbo8ghRIOMubiz3eozU7WZ
         ht6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140596; x=1772745396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ycYPYyZx7AmOLkJ5x4ffI/sFVR72W8M1sWNLx9umW4=;
        b=Uw5LY6ESezV04IW54Pepz4BbsvamvB0OHnp2KxOXrsvuSXLkplvsCjq3+kmSTVrOGB
         XV/SpD8HcuxddGI9j6af3raofbcN0rgSlt1IyyfaYkxYiVhdL9/EwahMciwQViNs3zDP
         XVC9ZUI0hcUT27nPpJSyfP/rp4fCAE/NncHAVR2YXF6zLgvTTQDxLhZHjNbW9SXBY0dL
         utXjdQyI52/Ai2IzlMFGy6+4n1d9de3DABUXYOMyrn83OzFjIu3A1mdQXrSaeq0mrqfa
         HV0dIAijuYUYCPmJSVQO18ThmKXaSqLQwQ/c3o93pj2UIDCLMApJAB3xW2g7by2skWPx
         b2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWxMl8u9ywrC69ObteenNMaao4r/3U16g9m435zQeXiqtJaCr2dR2p8nFANdnyUXnipVHuLA5ET0apGWREK@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMiku9kfT7DNgi9cND6+6nDfRp1fIMrrlWxy5NgKiiug8qsA+
	b8EAYyX5zkQQN034HtR8VEubXxXASEltwXFUofU+5FbxG94BaKJyv/qOfn/zQEmPCyddQf98woz
	xOBPhcGdprCF3gDkfqn03L4sn7HJhsFVq/wyL4N1iSj8S3LB1O8kA3p/WeA==
X-Gm-Gg: ATEYQzxCYDut0+wGXe5S0OoA6bbJBMBMwuWeov3mShoHgzMWvpxf0DlXipKwnthvJzK
	NNwE93GC/LsnTb4zrRY4Zige1GjgyCAHjJPNE7me52OQXTxzGoiUDa45c0ktkLMv8cfg2LcVaKK
	5hIeQ2w+fMnoEMV66W74y9ndrc52Z4MlSGM+mbPwKrx66LOKsMSPumQO62N41Hqh4Dcp7JKVgr5
	tz+YM3CvoAOr0qDK/2Te+DsR5p9XuUQlqAnFpFVMBsNAZgqnYjB7qM1Ry/y2K0/KD9aeLlgGkwB
	bs5jRkk=
X-Received: by 2002:a05:6402:3889:b0:65c:209e:32c4 with SMTP id
 4fb4d7f45d1cf-65fdddeecfamr459737a12.20.1772140596428; Thu, 26 Feb 2026
 13:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com>
 <CB5EF1C4-6285-4EEC-ABD0-A8870E7241E8@nvidia.com> <D4BD80F5-6CA2-42E1-B826-92EACD77A3F3@nvidia.com>
In-Reply-To: <D4BD80F5-6CA2-42E1-B826-92EACD77A3F3@nvidia.com>
From: Bas van Dijk <bas@dfinity.org>
Date: Thu, 26 Feb 2026 22:16:25 +0100
X-Gm-Features: AaiRm503vB6PlOzpF1Ah8vvKRhyYi5KSR9A57eyUrg2LZOnrpgEX8RHLQIcMuBg
Message-ID: <CAKNNEtwZzt3xWh_b1pn4X4FG+cq6FLOP5rR4+G=WUsjHsJRjaA@mail.gmail.com>
Subject: Re: [External Sender] Re: [REGRESSION] madvise(MADV_REMOVE) corrupts
 pages in THP-backed MAP_SHARED memfd (bisected to 7460b470a131)
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, regressions@lists.linux.dev, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Eero Kelly <eero.kelly@dfinity.org>, 
	Andrew Battat <andrew.battat@dfinity.org>, 
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[dfinity.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dfinity.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78644-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dfinity.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bas@dfinity.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9E4A1AFA6F
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:06=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 26 Feb 2026, at 15:49, Zi Yan wrote:
>
> > On 26 Feb 2026, at 15:34, Bas van Dijk wrote:
> >
> >> #regzbot introduced: 7460b470a131f985a70302a322617121efdd7caa
> >>
> >> Hey folks,
> >>
> >> We discovered madvise(MADV_REMOVE) on a 4KiB range within a
> >> huge-page-backed MAP_SHARED memfd region corrupts nearby pages.
> >>
> >> Using the reproducible test in
> >> https://github.com/dfinity/thp-madv-remove-test this was bisected to t=
he
> >> first bad commit:
> >>
> >> commit 7460b470a131f985a70302a322617121efdd7caa
> >> Author: Zi Yan <ziy@nvidia.com>
> >> Date:   Fri Mar 7 12:40:00 2025 -0500
> >>
> >>     mm/truncate: use folio_split() in truncate operation
> >>
> >> v7.0-rc1 still has the regression.
> >>
> >> The repo mentioned above explains how to reproduce the regression and
> >> contains the necessary logs of failed runs on 7460b470a131 and v7.0-rc=
1, as
> >> well as a successful run on its parent 4b94c18d1519.
> >
> > Thanks for the report. I will look into it.
>
> Can you also share your kernel config file? I just ran the reproducer and
> could not trigger the corruption.

Sure, I just ran `nix build
.#linux_6_14_first_bad_7460b470a131.configfile -o kernel.config` which
produced:

https://github.com/dfinity/thp-madv-remove-test/blob/master/kernel.config

