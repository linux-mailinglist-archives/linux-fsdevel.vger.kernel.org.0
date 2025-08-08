Return-Path: <linux-fsdevel+bounces-57050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6843B1E594
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 11:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E1B175661
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7EF26E71E;
	Fri,  8 Aug 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="XZQx7x//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899A25A353;
	Fri,  8 Aug 2025 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645034; cv=pass; b=IhQJ1FaB3CGB+52qlcxVFxdpiDsNfCEE7OmIUw1Jrb8kZgGyb6x60MBpq314vYS3Ry0fdopA7WoFItiIWtroxRfoxzHYw/9hrBmAogF5dgX6TxSDY/UQEkh7Wi/WDeulETHYJzLzIsd6dOTRVgDvmtM8FfeaI3E0OqoECG71ZVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645034; c=relaxed/simple;
	bh=SO2SWS87wrmr90aXp8MV7nXkIBbDNlFBsr2YdgnkMVA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=igrhD6wVdUZ4Wljkznp6hW78eJhh7NIyNsTNkW7xn4a//0e3QhliD+aHjc13sXBtNe3Tkc0aDOJVOSNvMyyIvxzQpMr1FTCPZQ50xUO/7Xbt6TgqLjytLTRT9dV+kdW98BPPJTmM4QC00OmgIRGIIFiOxQ6OrNpa9B0t5ok6wuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=XZQx7x//; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754645009; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FYyq1fZz1IS22/RUCDhON+v9w6YMPgNkHfv610WORwmWPcasx3s99gRxbTOgWLftv8uwd+Kc2cVK/xJEfwYJ3RbBGlak+HoSz/K9rQ/LsVZ24XRUAry5TrLtFP9SyFgGiWplWRrcS/MG6K/DDUaM3P09zMdmApI2nR1sK/xlQk0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754645009; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hLRD0ttrjJcn9aSzGG4A6G4GZMfaAZS1OWrgULlUiZk=; 
	b=mMQ0ljG0MVocbthBsArMfm+35uhG1a2FJNKJeAUMkp5HhYvagCxy9GhkniAs4P1UzU1riVcxe9iI3b9Hk8BcOgSapBMfxk/74pMks9LavQj8/6J6hSib6CHhfdY28+Ns9AR2hPw0C0TFRU/k6yTAjwn6Qa102HOsP8Rm+J23dNo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754645009;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=hLRD0ttrjJcn9aSzGG4A6G4GZMfaAZS1OWrgULlUiZk=;
	b=XZQx7x//DmJwAXklbU3MaAI9HSAfsD0EL54z1Nc6L1TFNZ2HjXaa5pNudDyWTm0o
	c1sWvIO/k75aI+m5tJIYoUGvuGk30U5F2D/yY3tLs+QUSwDMwEQcdz889WX76zJKLYb
	/3Jdm4/kQsXlsDGLMaUByUm1K152Ipi22ryCJqdQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754645008500552.794219999255; Fri, 8 Aug 2025 02:23:28 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Fri, 8 Aug 2025 02:23:28 -0700 (PDT)
Date: Fri, 08 Aug 2025 13:23:28 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "Alejandro Colomar" <alx@kernel.org>,
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Jan Kara" <jack@suse.cz>,
	"G. Branden Robinson" <g.branden.robinson@gmail.com>,
	"linux-man" <linux-man@vger.kernel.org>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>
Message-ID: <19888fe1066.fcb132d640137.7051727418921685299@zohomail.com>
In-Reply-To: <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com> <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
Subject: Re: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36
 syscall wrappers
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
Feedback-ID: rr0801122775f2f5b5d0340d94914587a70000844159bbf145211ba84f98e1226d87d858c029117558446855:zu08011227a1f057b002366232480c184100006cd47b3729268c142f6942b709ac7ce2d1f28b58774225b1bc:rf0801122bfa074accb980a2a2bb8578f500007a33d37bd93e79db2d35754a4271d7b933c92a7bd5492a2070e26039a3:ZohoMail

When I render "mount_setattr" from this (v2) pathset, I see weird quote mark. I. e.:

$ MANWIDTH=10000 man /path/to/mount_setattr.2
...
SYNOPSIS
       #include <fcntl.h>       /* Definition of AT_* constants */
       #include <sys/mount.h>

       int mount_setattr(int dirfd, const char *path, unsigned int flags,
                         struct mount_attr *attr, size_t size);"
...

--
Askar Safin
https://types.pl/@safinaskar


