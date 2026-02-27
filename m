Return-Path: <linux-fsdevel+bounces-78703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMKlKbJ1oWmItQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:45:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8987B1B623A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B940B304F563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3BA3DA7F6;
	Fri, 27 Feb 2026 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2haRLkx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581CF3C198F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189102; cv=none; b=OLwfkEOmXz4GVSF16nkUp1dLPMZxThqC9pIQiA5y4lLbNL+UBnFhPnchClNZduooTsHgKLL28rvdjU3Pubp7vZ/2ycUxvp5H8oZFQAyqwnvErgAjXdlFaf0Frk/hTbblrBWaSyJshG60berQS8fqVA5JkUA+8m3p3gM47dsh3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189102; c=relaxed/simple;
	bh=VG1u1tKzr6sjrT5rSGU1ABzEzxey1xBjG4v00a1QNmY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=FJm/ljN2iaNS1Rs+Sfjyw+JDAIVqPmwLNYOk2pgbh6hxbjiROWA+7QAcm/kk8AdEXumxGtEvke5eRLOhjS9VUE/qlmgX6FVA14gnJJqqZOZ2FAUzlp7ySakINpwEhYmt7N5QyFweO89iDRxryp3XW/vltNesRhVgd60TO/eOs/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2haRLkx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aaed195901so9634555ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772189101; x=1772793901; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NXKkuoClgu8LyDrSxmF4sWiob/0b5LO5w97pa2VenZs=;
        b=A2haRLkximGY/11YV0wNisPEf/FIqqaaP22tHSYqHV7i99GVOrAioyLwnK+ekFTkVj
         APlFczUAY6LvGDImM64DbY+GfsV/O0B69xbDkbDjz5MpQp+0HKYb4A3ZpjDd5GAkqjAU
         4JDmZPLpWPUQovHFGp974BUBb38S6DODpj5jWGlpDuoEfr9umGwNv5g6boNAxppJzVcb
         PITA+OREu6lGECFTdid1BSgjE4gcdk2eoPHYtw6jZHCrFV6X140jbUHX0b6a2ljnmGED
         L4n5gLnRZhkmHaMt6imBTKaz7/6qLFqXOKuZQC9GK9hcvo5h0ncUecabaFNEbWc46MpB
         LUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772189101; x=1772793901;
        h=message-id:date:content-id:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXKkuoClgu8LyDrSxmF4sWiob/0b5LO5w97pa2VenZs=;
        b=R7HlFWFINqKm1I8M4qmOXHjDLccjFRvTryC8VeTj/HjndRs2zYaYjJw7LNPA+oXYn2
         8f+9ZJMMCfWDXz0iMe1ZSY4xH+RXlJPkJhtmTdr8x4ReGW/kst/blTkkR+i/AbO3eeie
         6FNgztc7CZEDwfxnr53+hgMdfrfoFr1sdidXyLS24ZD+GcpxL7MZIgFeRvQ7d+u2eCNU
         vITaPAlkZyKH4ywr0iLtHavP+zRCrzUhOQyfNavvtt8DFJkKSQ0DPSF873VoeQG38/R5
         /+ruGTllzb6vRr0uZz97H+pggIhqGotTapkAUp0vZih3WCixMuR+qMd/Orc2zoqPc7EO
         vyVA==
X-Gm-Message-State: AOJu0Yz4B2MXwZtTfP+a4bgwhzgAt5bi0Rp8aanyShPJ0SRVsclrvd3t
	5m/D3o0Ccq46FcCrIymM8duVdNdZzxeSUWnPSzNCLoVI7l6WEs90RkVJ
X-Gm-Gg: ATEYQzw1i+8KReLEAbRTScTVcBszp2cb975iEWiEp8/2NQtZ7COHmJfAtCoRr8lduGX
	lZFwNb9o1zYZrHC35qCYgXYu6kFERNVCfaXVHOAYOAqPT36aqH8y5ZpTPx9ewgfP4iLHtGRwYal
	Iv9jf93fg+VzPCSd9Dh3YQYoriUFne4dFntbyP982uQdQePAdPpFqh7ODOJV8ZBSwqfD98NrPxK
	4QUBRpGJZb28rzI8Zksig1HdADVVf7bu6x/6R6COdQUmxROi19u7W+VtwlsNdYSQ5k7OmNfa1ai
	3qhwW0FP2o36wP5CJB8NqW99u3XJdGzyTZM18QX6HffCEecnGEpfYZYZ5lWTxInI51g3OtwynLw
	lEQuzQQXSvhxD0GbuQXnQ33bFE+BZSwjq9Kte1bGk6ZfdVyzPznVQNIwvlY2kv7YJbFPyDrC5Yp
	4Hl/DJWKr8Mn987DWjP7EJUyChzkFaSc0yOsgd9SiR6Kjs4zZ0/WB+1ojdgtBjKcII
X-Received: by 2002:a17:903:40ce:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2ae2e4f8c11mr22128875ad.50.1772189100567;
        Fri, 27 Feb 2026 02:45:00 -0800 (PST)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d1ba9sm58411465ad.76.2026.02.27.02.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 02:45:00 -0800 (PST)
Received: from jro by jrotkm2 id 1vvvL8-0003mb-39 ;
	Fri, 27 Feb 2026 19:44:59 +0900
From: "J. R. Okajima" <hooanon05g@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org
Subject: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14543.1772189098.1@jrotkm2>
Date: Fri, 27 Feb 2026 19:44:58 +0900
Message-ID: <14544.1772189098@jrotkm2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78703-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hooanon05g@gmail.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8987B1B623A
X-Rspamd-Action: no action

Hello Al Viro,

By the commit in v7.0-rc1,
	154ef7dce6a4d 2026-01-16 name_to_handle_at(): use CLASS(filename_uflags)
name_to_handle_at(2) stopped handling AT_EMPTY_PATH, and an application
which issues
	name_to_handle_at(fd, "", handle, &mnt_id, AT_EMPTY_PATH);
started failing.

It is due to the commit dropped setting LOOKUP_EMPTY to lookup_flags in
name_to_handle_at(2).
The commit log is empty and I'd ask you "Is it intentional or an
accident?"


J. R. Okajima

