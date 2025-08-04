Return-Path: <linux-fsdevel+bounces-56615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6BEB19B3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0CA3AAD78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 06:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC4B22A4FE;
	Mon,  4 Aug 2025 06:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="fyAfi3kx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8109126BF7;
	Mon,  4 Aug 2025 06:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287359; cv=pass; b=Cz1dPu9hHtpEIYTxEILiwspZaywUBdwimU6TenSAhrYTpegYrjoKTxdsGe+BJWhGx7wdWFywkXOkO1hLHjwHYawhoVZayr6LE9GEHRpRQR3WwvZbfJ5JTL93iR7WW+SLJc9Zn7vT8o1ghcJ9W6QX6wJXSoQ9AlhNezjnCZKj2PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287359; c=relaxed/simple;
	bh=kpSoSjrZhGjs62aE5SmGCHwxIm4QxKCtBqkm1MjN1y4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MTVnNq1TZvglHSaDT2ZDUWvjtyH55qIWvnBgkA9hHB5h+NWYR7K6evR4/JE/F0kqv12VbsqX4xCLRfFk55EmUM5VIteRfun6bFkBI3WSwQR2ZVI0PU5hwHhxlTr0bdnKOctkdSLI1370/AAOSsCeR0feOp5XG7H6uBGWZvXu5e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=fyAfi3kx; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754287334; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IZhBR7ewN7HD2rfDsrRUGTQsNRx2k75bJ/4foTGbz4efSW8YylQkqef6mFjyKD8CuAhm3Dfcq3HBqKtUB6Dbwcr97AmnmIszPlnDyTFI0xL0HvaW7AAYYuxlhg0R+3DkaItM8YSeklNcLkl61iQyKzDCEuPeqfZd08l4Ji49aHU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754287334; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XPq5pU+VAlEycOOoKbZ8lsG8ZhsiHmp6l+8qRsl7/DY=; 
	b=KtlEe3DqMJRG070r+Env4GLEVfE6lv2B2xwP+3muynKImyD6PQzfNyKwKNasytmFyHOv7EN8xGDxFnG5CkgvqoWpW0vizNyXAPEjTEIIDk6j0fdEAVgKajo9CbJSDXvYizSiNgtnsgM7khgYoblRrDQdJWq65UEAbbZxEV3+Ans=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754287334;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=XPq5pU+VAlEycOOoKbZ8lsG8ZhsiHmp6l+8qRsl7/DY=;
	b=fyAfi3kx5jEZq4m2eF9Rgtdaqt2sOWoIu/SUBi8HJ1vHxesX3NQo4SYSEYVprXI6
	XG1spjoD+zK2KrmCQArzy4rCT9uFt+klD0azlHVs0fVmckzvo8r0v4STC2+nRYg6OMG
	Jd536PemW/ufDPzo3Ot2g89U9XNR0h/Y72mlaEX0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754287331599847.7869727877564; Sun, 3 Aug 2025 23:02:11 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Sun, 3 Aug 2025 23:02:11 -0700 (PDT)
Date: Mon, 04 Aug 2025 10:02:11 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: "Jan Kara" <jack@suse.cz>, "brauner" <brauner@kernel.org>,
	"James.Bottomley" <James.Bottomley@hansenpartnership.com>,
	"ardb" <ardb@kernel.org>, "boqun.feng" <boqun.feng@gmail.com>,
	"david" <david@fromorbit.com>, "djwong" <djwong@kernel.org>,
	"hch" <hch@infradead.org>, "linux-efi" <linux-efi@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"mcgrof" <mcgrof@kernel.org>, "mingo" <mingo@redhat.com>,
	"pavel" <pavel@kernel.org>, "peterz" <peterz@infradead.org>,
	"rafael" <rafael@kernel.org>, "will" <will@kernel.org>,
	"Joanne Koong" <joannelkoong@gmail.com>,
	"linux-pm" <linux-pm@vger.kernel.org>,
	"senozhatsky" <senozhatsky@chromium.org>
Message-ID: <19873ac5902.f6db52da11419.248728138565404083@zohomail.com>
In-Reply-To: <CAJfpegsSshtqj2hjYt8+00m-OqXMbwpUiVJr412oqdF=69yLGA@mail.gmail.com>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250720192336.4778-1-safinaskar@zohomail.com> <tm57gt2zkazpyjg3qkcxab7h7df2kyayirjbhbqqw3eknwq37h@vpti4li6xufe> <CAJfpegsSshtqj2hjYt8+00m-OqXMbwpUiVJr412oqdF=69yLGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] power: wire-up filesystem freeze/thaw with
 suspend/resume
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227164012ec9890916f7891973f00000cdbcfcc23e10b9c369189d295a1c67b2c97f63b337c9df022:zu08011227d121e78c426a484858449bf20000b62dcb58d23f93075d67f48e7f264a4ce14dc0c3b8b9df6f62:rf0801122c51297a6504ecd1292eb078cc00005daa1dfc10cf2f148215b573ab0dffb200f198509b479e9a153b34f13caf:ZohoMail

 ---- On Mon, 04 Aug 2025 09:31:00 +0400  Miklos Szeredi <miklos@szeredi.hu> wrote --- 
 > This is a known problem with an unknown solution.
 > 
 > We can fix some of the cases, but changing all filesystem locks to be
 > freezable is likely not workable.

So what to do in case of networked FUSE, such as sshfs?
We should put workaround to other place?
Where? To libfuse or to each networked FUSE daemon, such as sshfs?
I hit this bug in the past, and I'm very angry.
A lot of other people hit this FUSE bug, too: https://github.com/systemd/systemd/issues/37590 .

What about this timeout solution: https://lore.kernel.org/linux-fsdevel/20250122215528.1270478-1-joannelkoong@gmail.com/ ?
Will it work? As well as I understand, currently kernel waits 20 seconds, when it tries to freeze processes when suspending.
So, what if we use this Joanne Koong's timeout patch, and set timeout to 19 seconds?

So, in short, if we cannot properly fix kernel, then where fix belongs? What should we do?
--
Askar Safin
https://types.pl/@safinaskar


