Return-Path: <linux-fsdevel+bounces-55534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B24EB0B7EE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 21:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC1417366D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 19:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D71F463A;
	Sun, 20 Jul 2025 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="Bh3bXIo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0641BD035;
	Sun, 20 Jul 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753039453; cv=pass; b=RdHa8Aa4QiQjnjDoAnzGjUWsGyUDFvMHWt8+5+zJo12S/U/oZjhWeYHbzbSXFNNWZsTiqbA2R/sNtBB9Vpo5wngCLMZyLSc/yNVtJvOdxJnQdCu3iz5cWwVgrn2seJZY4OgqZQLkA7C9EjFU6EFSbemKqRdM/RfXphkFKT1Kpls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753039453; c=relaxed/simple;
	bh=CZGdbasRhJL67LATDHinA/RimvDg9Yh/y9BCU62exf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTzelKtPGWDJl6kViSJVwuusZLRHG3ibDbnQp+5+aJ9P97LKazY1XcNTelgPALkBBMIL3KV889Y/yAxoLRU51vD1/2Hd9nPREeSFwK/nbcBvMlwGKzAr83ECy0/dnf0dJleBqrsIX8KgMVsvULg5x2r85bIgv75uoekI/9rtUfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=Bh3bXIo2; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1753039427; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LRsNXqT2DGwqohe0V3n1Y5vnsbcPuxmL33DXmTm56IvT8IeUo9WLCKwOjdmUNMNrvyQ/EmyXzJzSC12J76YV44bb615E1lhcYpXGc9OsP628ekeFuE2yTggF1eBAhDq1mkU5aZw6tZAFVJVzy/Onmot+BY8MIOf5PbNWnooGlps=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753039427; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CZGdbasRhJL67LATDHinA/RimvDg9Yh/y9BCU62exf4=; 
	b=A+9rJcw18enEU/pd2rsIzZE3I3cwpXklSU46/TecBtXyLNA6YVuxtO+U1+CYQoUScwlZztJNGH7qeu+nQM2cVKYOnYEmUuhzotabBMRr6BMw7Hf/akydV/oVYjlql4Lx0/+sW1pvNU75KmlJ14ZVQtMsiIj/hHnQqPwUJvMLdMI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753039427;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=CZGdbasRhJL67LATDHinA/RimvDg9Yh/y9BCU62exf4=;
	b=Bh3bXIo21jsDoTcdSOPo7xHRNjAd+unVPYmZutBzN2osHtuDOzu6Q4lY4sFB9xzI
	FgS0ffhFppzXqyuCo9D7U+5YBJYyUXgTpduRlIXPw95e+LIO7HD17DUzbtF7U8+vrfO
	CowUU1/+tPsgzToOFgo7N2E9qxPoT/d2/gJaJlSY=
Received: by mx.zohomail.com with SMTPS id 17530394239991010.919391982878;
	Sun, 20 Jul 2025 12:23:43 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: brauner@kernel.org
Cc: James.Bottomley@hansenpartnership.com,
	ardb@kernel.org,
	boqun.feng@gmail.com,
	david@fromorbit.com,
	djwong@kernel.org,
	hch@infradead.org,
	jack@suse.cz,
	linux-efi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	mingo@redhat.com,
	pavel@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	will@kernel.org
Subject: Re: [PATCH v2 0/4] power: wire-up filesystem freeze/thaw with suspend/resume
Date: Sun, 20 Jul 2025 22:23:36 +0300
Message-ID: <20250720192336.4778-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112270d6f3bb5e67c5eccbba77053000079a79adbb197c855785062672b8dce23e5fd72ce979343ebb6:zu08011227851b2ce9d96276e118686f9c000059dcc54766978b253b11fb66b5116824aa7c1fe7b6313b3400:rf0801122c92f547bda1f7f44d931768570000e490db12c233cac804c865502819ef4bf2bdd31e4e53901ce02f4363fa04:ZohoMail
X-ZohoMailClient: External

Hi, Christian Brauner, Jan Kara and other contributors of this patchset.

I did experiments on my laptop, and these experiments show that this patchset does not solve various longstanding problems related to suspend and filesystems. (Even if I enable /sys/power/freeze_filesystems )

Now let me describe problems I had in the past (and still have!) and then experiments I did and their results.

So, I had these 3 problems:

- Suspend doesn't work if fstrim in progress (note that I use btrfs as root file system)

- Suspend doesn't work if scrub in progress

- Suspend doesn't work if we try to read from fuse-sshfs filesystem while network is down

Let me describe third problem in more detail. To reproduce you need to do this:

- Mount remote filesystem using sshfs (it is based on ssh and fuse)

- Disable internet

- Run command "ls" in that sshfs filesystem (this command will, of course, hang, because network is down)

- Then suspend

Suspend will not work.

Does your patchset supposed to fix these problems?

Okay, so just now I was able to reproduce all 3 problems on latest mainline ( f4a40a4282f467ec99745c6ba62cb84346e42139 ), which (as well as I understand) has this patchset applied.

I reproduced them with /sys/power/freeze_filesystems set to both 0 and 1 (thus I did 3 * 2 = 6 experiments).

I'm available for further testing.

--
Askar Safin

