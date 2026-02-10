Return-Path: <linux-fsdevel+bounces-76902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JyiDjq0i2m1YwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:42:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 995BD11FC93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 669C630517FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE5A3115B5;
	Tue, 10 Feb 2026 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="Kqh7XcON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAEA3019D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763317; cv=pass; b=YYdMAk2bRt/W9JdlAw4gI6GQhwQ6R0NXNMEdC6pJNpMTbJyJWdfSnoHB6N8tOBEvjIXmwXGhSYK5lAuWz1ZZNjoghdJ3s14xIQQvo0cs3OijzKFpM89c+KNK1jKeGBM/xxh1Y4bgfi/sjxNdP5vbG8oXAPe5ZaJ0OiwOtmn2lyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763317; c=relaxed/simple;
	bh=xBvxvlxYxyWxybPVkTm+eSxC40epnYw+Yr+Yv82IAsw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qdak20dCbKPrLgQfKR300pPcS+WyDGNkm5YwSTOZnsTLwQ1iSr6ZmwDQo09a5NaN/IiMh00RpBc0TS/4GuaCntz7jQhIosFhJ7i4bH3EXW/qzQzd26plixLeVDF43nm3Ku1o/A8MV4ygB6wvCtQk9o6FJxDb2eO6UYcfqCu04y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=Kqh7XcON; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35480b0827bso199540a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 14:41:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770763315; cv=none;
        d=google.com; s=arc-20240605;
        b=B2ylrvZroorBhQNembX1cwZqvnpMJetk4+phWJd0aTjCMcESTumGwsZ+KainXXD8Ta
         xOz6HcsCIEHaQNRe483cr8ppaZPcc4deh5hSsasNsVTC9y2wvU4mMAn/0qlYNVwo9V0D
         m6l49Ee7HeJTE0MZG/i8kM3xw5iyV85oARe3zHqI6buBTCqxTCKEpFmM0VxUwHLPhHOJ
         ouyLgY0UIxqP8achIVdQ29GxZ/Jkzmw0u+KRyRCfjcNANBnpu35/5evq5+rMPA/UHvMN
         MisovAlI9aoypoRkxPpvVJLqKJ8NZFn0AwMZX+Wop7LztnLj5/QmGGNzCsV8ZnapSiqT
         8sYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y1M0JtRvknHJkqw6uR1Ql6nZT8qLIs9yI4KG8m9iLzU=;
        fh=AH7TG+HX6hdqKtbgAPUkSYO0HaLUlKKU/UTQLRuBAx4=;
        b=M9+qz9jk2V4xqRIKflfiilxgy2Kd4nnFq0ybcCl+fMYnx2KryW+lSVKM/iYNXZUTQ2
         iWT7sxQLVapB8AMr/YMIL2Y6woP/uYfSO9efxrEuY7Yhl/E0f5qbNLXiRauHsUfnV6uF
         rqfOp4RQZ3h+6BNzNWql8qHhzB2PA/IGwFsHsvlA1x6BWbmAATspi2RpHUcJKmWwKTWC
         jIkFQ3ovkjwmKTI+NTXaimrrKT7NEN4kdjiJUN6LXJ/jf24QoFj96duThJXpxwxBjXET
         wrlYwgth0D9Xphfn/9/Wf1hARLph59YaLNHerZzvwEvM3KhuBd0RH9I6uWcyy7yeTyoY
         j/sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1770763315; x=1771368115; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y1M0JtRvknHJkqw6uR1Ql6nZT8qLIs9yI4KG8m9iLzU=;
        b=Kqh7XcON+ecsNRCSeq7CJNQ//ZO0olo9xhv9E/I0dkrC3fwz2j/8p9jMNAMyteacj6
         Y040rdk3ebyu527cQMRly7vH3a7U5dZfIgMRGh/6MNK4f7Z43zsLQLXYeAkxlCPlH5Wc
         fVfetufJV2Tia/qgq36ibQY/Ar1nvRrBVucTeIQYnOWuLjPuxB6dMKKdkO862/N2R6Ic
         rNdiyfi1Hv1CYiemSOMqhoLjE8/ErEX/Uo2npYZ5DJf0tBa0yEyYIOEsj+mlty5KvktN
         YiVPef9F6xL8jWj/+OAuaOj+pALZcdZQ8fuZvUcHWuemEYHlwnp5fXkxwZHhi0j/U3Js
         05ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770763315; x=1771368115;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1M0JtRvknHJkqw6uR1Ql6nZT8qLIs9yI4KG8m9iLzU=;
        b=VWCbwVtJ9Sondr4uzOz2IQXJwh8yyPA3SHIzc208L9vu5gBuzp8spSGuV+tJy6NH86
         c/S13O3La4XngCq6ICzeb1rEXtDeX3Cs5FpV1T6irqgA6Tpu/GmUwtfKTtiG0UVMszDB
         WIeEmf6D1GwuraYiMzVFBUxsy40pp+oWPaoKkPPio4puAUBCyh0CQp4Ja/2E3DB3M9AY
         Qy0a1KpoPy+KBx/7uyIpxCFdc1suC/7qIaIQaGsC+PixM5ovQHUKsdmjui6zrxtuaKvp
         7HPijX7N2TBZ/qILdLqAzBzNZm8QaB/dWojd98emucVPY2+W9gDdrniCUA8eD/pITYfB
         uD6g==
X-Forwarded-Encrypted: i=1; AJvYcCWBP5kufvN0N2RB4Ng/E1sstCEZY+em0Gczeww4xIt61vvbxw1E/DglG8q937hkZNad3y7NJzbRKy4I7Blo@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpVqjGmjQeaVMj3ZEpeg3vwsjDOF7hmxt+aR0BdGf0DNRo8Bq
	c1wrleOCWIX8ch54xmWkr6zwQuczCpmghayfRJeaSwp/zP1nO3DfU0RyBlCtA9t+zwzn07JPEiX
	fw4vmeNU7euLG71hE7xSOEg98TadBR5q1PmNa7ZmINZVjzgfC8V3NmZSF
X-Gm-Gg: AZuq6aLbHlrDDpErXHqB0VMTv9eUKIfPvVie2QnK9DnhJ7Ts9IN+x8hhakwrBM+7Icg
	1DoxCRSudKmPRLu77R4bYgf6ymqGz2i5zIvqaMY8+FhhrC/ZJ/6z6KexxZv/aPwn1yqEQc5/0k3
	eZTTTWTRCTOL+A2of1tlRXnA64DDk7fBtUdUP6JQYWAKEjLzZk/Tdd7SDDHOeHSRbtvkPjfP+81
	8gEEDGCsDnZyy2mdZquCaKZRG7WTvy1EnkYmjQ9NuluUWt6jAfyt7m3/gT/s+xucheFmvqWHvZ4
	zdPbvUFRtgKpVjlNi0o=
X-Received: by 2002:a17:90b:5885:b0:353:2972:74a4 with SMTP id
 98e67ed59e1d1-35666245f90mr3298571a91.13.1770763315179; Tue, 10 Feb 2026
 14:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 10 Feb 2026 17:41:43 -0500
X-Gm-Features: AZwV_Qiya4fu68ghzgJJHUK-bB1XvyzL3axaegtRMdA-_1F7T9bgjYuFPgX1tgI
Message-ID: <CAOg9mSS9BFayavpGQ=MWYR1HoUX=SSQ01JPYTRcJDVXbzsGAUw@mail.gmail.com>
Subject: [GIT PULL] orangefs changes for 7.0
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[omnibond-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[omnibond.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,omnibond-com.20230601.gappssmtp.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hubcap@omnibond.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76902-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[omnibond-com.20230601.gappssmtp.com:+]
X-Rspamd-Queue-Id: 995BD11FC93
X-Rspamd-Action: no action

The following changes since commit 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7:

  Linux 6.19-rc6 (2026-01-18 15:42:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-7.0-ofs1

for you to fetch changes up to 9e835108a9ae1c37aef52a6f8d53265f474904a1:

  fs/orangefs: Replace deprecated strcpy with memcpy + strscpy
(2026-01-19 16:00:59 -0500)

----------------------------------------------------------------
orangefs: fixes for string handling in orangefs-debugfs.c and xattr.c,
          both sent in by Thorsten Blum.

debugfs - replace strcpy with memcpy where the string lengths are known,
          and replace other uses of strcpy with strscpy.

xattr - replace strcpy with strscpy.

----------------------------------------------------------------
Thorsten Blum (2):
      orangefs: Replace deprecated strcpy with strscpy
      fs/orangefs: Replace deprecated strcpy with memcpy + strscpy

 fs/orangefs/orangefs-debugfs.c | 36 +++++++++++++++++++-----------------
 fs/orangefs/xattr.c            | 12 ++++++------
 2 files changed, 25 insertions(+), 23 deletions(-)

