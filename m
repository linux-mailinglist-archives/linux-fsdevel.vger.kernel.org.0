Return-Path: <linux-fsdevel+bounces-59114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68802B3494C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394E517AF4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468EA303C80;
	Mon, 25 Aug 2025 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="On0ohUOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217852D7D3A;
	Mon, 25 Aug 2025 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144131; cv=pass; b=FU6PV2DJnBxLniETPgpue7x+bY1vtkSmEaeMcMEpPBw5ABHW3vyCKnGeUaxMlo7sSSZMY1tbSfWwVW/njOlNKD+X5792DZuVYvA2nZVBA3e2tZCi/9MrlhsbwUM7gyoIk5weXoA3mTf+Ucc+KdbJv7xr7yKqCoB9aKcyXnpDaJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144131; c=relaxed/simple;
	bh=pFpAZ6/+tuhgVQ/tVmNw2+7Gi5jfRwf1ydAsfOOZ1c0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dY6cWkAU7u5aswZoNKS1TedSEPUlr0x2UIeG9Y+NFPcL+0yWF98b9E5+I0qtRGBTICXVlGJxWw74hTo/5cpATjYidHiD7qvWonJ7le4yPRQRcV0hpTyGMb1MMezDTPFx6XuNEm9gZdxg/1AlIv3N+PvRXK8R29Ni4wc2EBceePc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=On0ohUOB; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756144099; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WwgA4eCtepSTJxg7SRbWXEBp2Sej5QS6Vp0rQ11jy6WT7XUJddtEEsgypBFWHwgxJdJ3YAiZr7tHhg1rfiRW2x5Gg1yb9N0wSA0GWrRZ/OFgp1j+kAeLKoZIzEnHLCki3uQu9fQ5GNbMYit5AZRv4Zp1/uok1YUKEO3JRzxWm4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756144099; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w9O1yPvqufsvxRA4exPaj+gPXTjYubFjFbod212n8qs=; 
	b=j5zIUT3bapMR9PnovbGhztfDMlofmtw4X06YyZf2zyJCWK2lZJOWbr0j2qCJj2lfPUsZE+ba9YT/KjR47QT8EVcw+vhBpGvpxsWWA3VNHQp6jIKLUACX9BposGCcKrKniYCfTPoV51CD7KPxX+f9pcV3gZnSrQUpAHbEA/eXmlM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756144099;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=w9O1yPvqufsvxRA4exPaj+gPXTjYubFjFbod212n8qs=;
	b=On0ohUOBInVRvYafJmttDqHaLOKC30vgto0XmCqeRlITDU0p5LIhdBoA7MOE/usq
	qFl2inWMG4JvgdekN+Km7NWq8qrZAGD2X5Xo+3yINF0GyUtgY2l7v+BkqAO8lH/emcQ
	qXZ+eMRr2osgWRK2BP7T+7vmz7t0hYFTUwCe4wMM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756144097840227.0333466039475; Mon, 25 Aug 2025 10:48:17 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 25 Aug 2025 10:48:17 -0700 (PDT)
Date: Mon, 25 Aug 2025 21:48:17 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
	"Ian Kent" <raven@themaw.net>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"autofs mailing list" <autofs@vger.kernel.org>,
	"patches" <patches@lists.linux.dev>
Message-ID: <198e2585a21.11b3f90ad28165.4887709828549472380@zohomail.com>
In-Reply-To: <2025-08-18.1755500319-dumb-naughty-errors-dash-YpWnja@cyphar.com>
References: <20250817171513.259291-1-safinaskar@zohomail.com>
 <20250817171513.259291-5-safinaskar@zohomail.com>
 <2025-08-18.1755493390-violent-felt-issues-dares-AIMnxT@cyphar.com> <2025-08-18.1755500319-dumb-naughty-errors-dash-YpWnja@cyphar.com>
Subject: Re: [PATCH 4/4] vfs: fs/namei.c: if RESOLVE_NO_XDEV passed to
 openat2, don't *trigger* automounts
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
Feedback-ID: rr08011227bedd04d36cc79f327257c44f00002555878cfb6e35e4dbc59498dd44f339c34d491f1475af421e:zu08011227bbe600540125c4bba0a24583000023832f6ab693eb8da42f7bb18e6565add98338dc8dc2df0ccc:rf0801122cd8c46131bd8860e3f4d9692f0000908284c610cec6fca7169d07dc3782783c330ed91bd7eea7f39c7104c386:ZohoMail

 ---- On Mon, 18 Aug 2025 11:15:16 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > but we should have O_PATH|O_DIRECTORY produce
 > identical behaviour to O_PATH in this case IMHO.

I agree.

Original intention of autofs was so: stat should not trigger automounts
in final component, and everything else - should trigger (by default).
See
https://elixir.bootlin.com/linux/v6.17-rc2/source/Documentation/filesystems/autofs.rst#L93
.

So, yes, theoretically both O_PATH and O_PATH | O_DIRECTORY
should follow automounts (and nearly all other syscalls should, too).

--
Askar Safin
https://types.pl/@safinaskar


