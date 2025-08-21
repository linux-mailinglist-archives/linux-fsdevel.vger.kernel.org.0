Return-Path: <linux-fsdevel+bounces-58607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCFBB2F752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9EA188EF37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B2E30BF6E;
	Thu, 21 Aug 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="dIJADVj0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CF2E040A;
	Thu, 21 Aug 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777486; cv=pass; b=FzS+RWydQ30RJUSl79FfqqQdZJtSo8zgqyZDusREp22zyupQE5BzK/mZpcg9JMGtbCo8qrT/hAb0kgF+Epnq0q/bNWgb1OfG/BMELR+GFLbxH4pLrXzYyquUzdmm4YCrV5s3dnZrT1BaNLUV4BuKogypxGh3xdP9brpo1ufNkiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777486; c=relaxed/simple;
	bh=EBBedWvK1u+H3C95rP1DT0PFj20hcb9dPK9pik6fmpA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Hh8h4WIjmjJoXVVQUF4OeZuEV7+R7YRRynDNmSEi4DGcQMb0E8GnozvarYJ4Lwn62zFTinWohes/NGCKmPEB/2shTRdapLJesKpccTJL57nXl8ZmfDZxpzetx6fl4c5kWdTwQzGbv08gcyOqePWkk8/WH9Ed9Y6ODFJoiQ0U9O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=dIJADVj0; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755777460; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kvm2H7hUW3/qWU37dwBIRAqRrMl7DRnognIk1HF5jZFYrY4CFmQLUbj7zHc9Slc6s9noQLNx4BpYccJKztJn1DMdMghR6kHyXuF8CUvt87WQ+ACFXAhrvKvBQ8CVyxRBxUW1Nk4jdSoKyGbHhyMK2GgNx7Vxu/HaaRt1UwBJvJ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755777460; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ld4HBgc72ZPV+idYQ8STWRZ6UTdUhQB7h0WsUoXkOEM=; 
	b=KUoXIOyK58qNy72EKgqkqb0qC9ujeF9tsWDMp8pFCfMNPwH2R1ZGDULWUp0BdICJq/dYB0j5CUUOq6iX6AsEBgbYFie+hVqvnwtzzvCZdzCRZf9t5Wq/qPvIKseC9U3s8OLiM8LftRdvdyyfo2Nbq8Yok4e5om72TRCSHptPFvY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755777460;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Ld4HBgc72ZPV+idYQ8STWRZ6UTdUhQB7h0WsUoXkOEM=;
	b=dIJADVj01Vz6FuTnQRkWdPumeRjyLqSc62VvxYA/HHELEc7tUe5Si5x63OeWqjOL
	O390Hn2IIsQ4/BE6tP43ZtSvXg2juecJvtnhsLJ9ZsEQvZhgG4CJz5eX3VXlntoRJrN
	VLojLtnJyCZGVDIHMBxqvG8JMGS5Eo5X446RS0mo=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755777459873751.6966116751717; Thu, 21 Aug 2025 04:57:39 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 21 Aug 2025 04:57:39 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:57:39 +0400
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
Message-ID: <198cc7de694.10b8d291e86721.7259290895236048760@zohomail.com>
In-Reply-To: <2025-08-21.1755776485-stony-another-giggle-rodent-9HLjPO@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-6-f61405c80f34@cyphar.com>
 <2025-08-12.1755022847-yummy-native-bandage-dorm-8U46ME@cyphar.com>
 <198cc025823.ea44e3f585444.6907980660506284461@zohomail.com> <2025-08-21.1755776485-stony-another-giggle-rodent-9HLjPO@cyphar.com>
Subject: Re: [PATCH v3 06/12] man/man2/fsconfig.2: document "new" mount API
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
Feedback-ID: rr0801122736d346ab1c41d9037a2f10720000b1314a9feea7ec523d096449994f77260239577f733423657a:zu08011227929deb0a72252e3508dc6dd500002f0b71dee2e015adc648c259483e9ec020701ea2b76ad960d9:rf0801122cfcbc68b48c763bd8bff4d3c0000050eeed29cb8095bc43a3c5c7bb23f93e5c7db8d21663940272ec90d58a05:ZohoMail

 ---- On Thu, 21 Aug 2025 15:44:42 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > I'm of two minds whether I should fix the behaviour and then re-send
 > man-pages with updated text (delaying the next round of man-page reviews
 > by a month) or just reduce the specificity of this text and then add
 > more details after it has been fixed.

Do what you want.
I'm not in hurry.

CC me if you write any patches, please.
--
Askar Safin
https://types.pl/@safinaskar


