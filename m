Return-Path: <linux-fsdevel+bounces-59101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CFCB34719
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3CA2A5536
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B76307ACB;
	Mon, 25 Aug 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="KBQvFHtz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D13074A9;
	Mon, 25 Aug 2025 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138355; cv=pass; b=gVI89Dq4VnI0ztbiYZVIHodL53C3IbG+ep+qnusGlvVdo3aGzvMkgxxNw8uewnp5arDc2gMdDIMb9hvEnwliqw9+j+HqkdH+PFnJ9u1MaU3K6Z8zRmIzj8b8tffU/J3GjaNxpFTgqSxlp0tEqS2qR7qC/0+f0hCB0jpFEM3KWwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138355; c=relaxed/simple;
	bh=ahgWXOaXa4uVTCDQXgfnV/isDsLaeGqPhdySagHIqZ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SBtVKeDYU3dtTInTdnV7VrYcJ/V7EuVfP6FKPYmNWVseYKxzsSDdTuhQ9KO/OQPkJp43n8KaHEFaemHRYzoce8DicbYE283ZUPhqBkm6DXL4jkHR1WpMlOrcGC7mGFV7G4JAXDYoTcifTTNHAdJGx+fco7jdjlfULAXh7VMwBn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=KBQvFHtz; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756138327; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TS0/XUFQb4TCtdtN/gbPv6tqj1DXYJElZoY5wG/c4nht1/KidSVLSKgWpYECUiiBUfQo9vCU9ap3PMZachfrdSTJFaE93Af2TEBHS6/EfCZ+5BspGHTedOHJam0pvDxwd9z5cxFcrIYjUjWHc4AYcSlGYwBhLe3HBm/QaDZGBws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756138327; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D6Foai3zPrEF1H2TT+1yRCZUGwFLLOSEWSlqO7KlDpY=; 
	b=eLfI/HyO5RQXHEu3NcplMO+w3WCP0dQg6VLbazShSJn6kQfpeI9L60a70Z0AEeEaNQcB0o3w+YFuGyAZNrOv4mQUr5LzYwnbbCVlq+MiYl7eWmWFMoU23onLZjPZBMfPVqmaTLV1FIbZB9dNegCvF3M9BBFm8ODLLKFemNKIeTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756138327;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=D6Foai3zPrEF1H2TT+1yRCZUGwFLLOSEWSlqO7KlDpY=;
	b=KBQvFHtzSb5RlCGgEOl27CGHhEf1+scm2wCTRTd1CC1YM5VErlsj2glgYecHFGqF
	RUWc1gF3oDc/+/Pt+40STUs2T31mgBYodFP4ISpRGU6aPIjwVrDEIaWT92ivN+JzBja
	kyUBWOlSZlfdBzrXIPoWIsq+ge8qWYMw0h1p81b8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756138326138990.1482256884956; Mon, 25 Aug 2025 09:12:06 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 25 Aug 2025 09:12:06 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:12:06 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Aleksa Sarai" <cyphar@cyphar.com>
Cc: "Alejandro Colomar" <alx@kernel.org>,
	"Alexander Viro" <viro@zeniv.linux.org.uk>,
	"linux-api" <linux-api@vger.kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"David Howells" <dhowells@redhat.com>,
	"Christian Brauner" <brauner@kernel.org>,
	"linux-man" <linux-man@vger.kernel.org>
Message-ID: <198e2004845.dc2f83ee27312.7051781748806696781@zohomail.com>
In-Reply-To: <2025-08-22.1755866245-crummy-slate-scale-borough-gEcqKg@cyphar.com>
References: <20250822114315.1571537-1-safinaskar@zohomail.com>
 <20250822114315.1571537-2-safinaskar@zohomail.com> <2025-08-22.1755866245-crummy-slate-scale-borough-gEcqKg@cyphar.com>
Subject: Re: [PATCH 1/1] man2/mount.2: expand and clarify docs for
 MS_REMOUNT | MS_BIND
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
Feedback-ID: rr080112276fa0b58be1e7951bf09fde5a0000c36c1c621c2ab920435c309c01e36b6abed956ed6f03869c00:zu0801122792c31794c68d63307a2d737600003fd59226218ecae798aac2a082091f7c033a2ee534f1a3099a:rf0801122c02a31f71baa7856bd463c6300000d7b232bdb792778d88d652145707117b15a99b9067989c7791af9f95b29f:ZohoMail

 ---- On Fri, 22 Aug 2025 17:06:00 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > > +The
 > > +.I mountflags
 > > +should specify existing per-mount-point flags,
 > > +except for those parameters
 > > +that are deliberately changed.
 > 
 > I would phrase this more like a note to make the advice a bit clearer:

I merely copied here text used for normal remounting (i. e. MS_REMOUNT without MS_BIND).
But okay, I changed anyway.

 >   (which can be retrieved using
 >   .BR statfs (2)),

I don't like reference to statfs here.

statfs returns both superblock and per-mount
flags. And you cannot know which is which. See
https://elixir.bootlin.com/linux/v6.17-rc2/source/fs/statfs.c#L51
.

So, I removed statfs reference and kept everything else.

 > The current docs only mention locked mounts once and the description is
 > kind of insufficient (it implies that only MS_REMOUNT affects this, and

I don't know how locked mounts work. So, if you have something to
add, then you can send separate patch.

I addressed all your points except for mentioned above.
--
Askar Safin
https://types.pl/@safinaskar


