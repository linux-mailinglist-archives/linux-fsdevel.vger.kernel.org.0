Return-Path: <linux-fsdevel+bounces-58608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F2B2F7A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD22581ABF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ADE3112DA;
	Thu, 21 Aug 2025 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="CF/ZhMEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249220D50B;
	Thu, 21 Aug 2025 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778498; cv=pass; b=ERJ4YEQpjs9AlvRjDy7AfI4KeM4bf3F+yiAtSm2aRltlVYqhWrrkkTSqobKDEarVgpvUA7CVoSiwMeW3+Bh42mL6MFHj2IYBAVWWNINz/4TE7uYLMXLhPoilU/H+nPucTaFUtQ/eEmncLDH3U67Ow/97eL/NvMsvPAg4yNsUkQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778498; c=relaxed/simple;
	bh=kHybyxNZkbiQTonEu/TLfGOSnHRZWrgvUByXudVbzNo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DCe4s5gqSR4ePPmG/W8ewENn8G+Fc9pg/C1nKDqj0tYnlwOGtBdXPA6UJGqHYfTECPBDGSAmorV7Rc98wZ1WlA3CTleczSMch9nTsEUTDw21Owl1tqAXCDt2MPjIHshW/nCzWagtochKyoO+3H8kOa6eNdOOQi6G3tR62yoX9GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=CF/ZhMEH; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755778467; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iFrss2Ohl51C5K0aSbCZoXzGPn/Pn75cjx99HrUPaFhEpKIMR2PXMq3zKzJZnygYcTwpr2sFAQpBNpRXCZmTWKUCi+smN3KMrSD1Yx2R2cmUOhH2brBiic7TwAlaJTHLnD7ZrMFOkvcS2p87qQidBM9kQQXNtbfVy5ld0lzlb/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755778467; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3NhJINe3GjDBVbK+ACQGsLyqt0EqmC30B2wu+Zak6nM=; 
	b=lVpeLE0x/ZYCMJLDgQ4IF5IvYaLw6dxP/KdsN5nqyKpQhKHTDMlZAPFUbqa810j9LikhCXuCKhz0eZAzHChLUyKJBYVbF3U7GRBRd6CIlCkSYXLDFXOwlOQGkab27DDLCuZLTCKxxYALjl37FGeXR3uDfCrWSOSi9anNfAljSIg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755778467;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=3NhJINe3GjDBVbK+ACQGsLyqt0EqmC30B2wu+Zak6nM=;
	b=CF/ZhMEHFpGSN7j2edx1K619OWkzpQOHtIlDM1Uf6RbaztlqqT0G4M2oju5Bo8Tg
	yPB3zkC22ThyDAilxgKQR952237hvUObNFLGcr7uba7AH9vpGnHz9zwKCqnD5fZrGHw
	UNxhEdef1DGnjt1CiSxkiua+M1cOTnUUJkirSRmg=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755778465218187.95504831341532; Thu, 21 Aug 2025 05:14:25 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 21 Aug 2025 05:14:25 -0700 (PDT)
Date: Thu, 21 Aug 2025 16:14:25 +0400
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
Message-ID: <198cc8d3da6.124bd761f86893.6196757670555212232@zohomail.com>
In-Reply-To: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
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
Feedback-ID: rr08011227d8a52e84b9d4f5d6457a47430000c55b1df7c9791dcd8fb1d961543b84f182020cb0311fac2667:zu0801122776295923f0e7e878d8c4726400005dad8a98a54d1aa1e89af53ccdf228c40e2eb9b9f0644b0ac5:rf0801122c8869734d8179b88d74b007220000786ec288664c1e54257598b81ecff4662a71918d7713431c81ba5e3ebf04:ZohoMail

There is one particular case when open_tree is more powerful than openat with O_PATH. open_tree supports AT_EMPTY_PATH, and openat supports nothing similar.
This means that we can convert normal O_RDONLY file descriptor to O_PATH descriptor using open_tree! I. e.:
  rd = openat(AT_FDCWD, "/tmp/a", O_RDONLY, 0); // Regular file
  open_tree(rd, "", AT_EMPTY_PATH);
You can achieve same effect using /proc:
  rd = openat(AT_FDCWD, "/tmp/a", O_RDONLY, 0); // Regular file
  snprintf(buf, sizeof(buf), "/proc/self/fd/%d", rd);
  openat(AT_FDCWD, buf, O_PATH, 0);
But still I think this has security implications. This means that even if we deny access to /proc for container, it still is able to convert O_RDONLY
descriptors to O_PATH descriptors using open_tree. I. e. this is yet another thing to think about when creating sandboxes.
I know you delivered a talk about similar things a lot of time ago: https://lwn.net/Articles/934460/ . (I tested this.)

--
Askar Safin
https://types.pl/@safinaskar


