Return-Path: <linux-fsdevel+bounces-58382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B362DB2DBD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FE91887ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F5B2E7F1E;
	Wed, 20 Aug 2025 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="F3r7A2l8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72C1ACED7;
	Wed, 20 Aug 2025 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690852; cv=pass; b=W5Zn+V4qqQ4PPaoLy67WuROcl9npCyML+qq4zBy40WQ/i4pC+90jhsaOe/L4bpt1Pf7aIFFYTn4Vh9kxT8cw+525lw2uQE4+cg0OWTCq6OeW24UfaAfPMo9dYM2LW85VnFxZ/WxJaL0ewtHsTiLsHzj1n29Xyxngu+ERsyYUOiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690852; c=relaxed/simple;
	bh=QE3RL+5Xhpp9wP3bUWghKuI9Z1KJ+Taaxn+LmcWtcXU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eyOuct90WPTf+kUs6dOTj7LAZO58fJjwmSqAM8z4WuD2BBYp+D/adM0C8Hpgi9zCRvEXpEb69dHU8BJZY8f03zudxQ5VScxxi6ZfjVkhbjftIIXskxTiG/LNmoqJkA5ZqrdP+//IyNaV7XeoHtJUQM0Z3dYFHIeuIEfe4Ebov4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=F3r7A2l8; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755690824; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d1wsPUhTDxNDGmMqav7AGfIeLP3DO96Ui0RCHMOcky8/JRxu9UB9xyM7raHE2qxc9u0pzV51FpAV5gNyJ36lAFVvtFh4rolqFmFMlmcu/i1duIscuDcV01yMn6iy4A4UefTU8jfWkYdCRc38FTmSBPZeoxSVb7DZEcytXyQLmic=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755690824; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QI1kAdmfGcNT+wdNrzq4R6c3p8F9w78AD4YJwFXjfL4=; 
	b=W1uQiJ+F927AQfFCeVF3dxkXJSyiJ9LsySXbHsrRkv7K+mhHb1L5A8JGoSRK6zjdWh9/2vMcRa0dS5+uZNE2ENd6u7gWZdWs+/gVTwbWxQAgIAgGe+D3YWoDbGzoiq1D8ErmSTrxX3jcqKoTzgW10+kePpsTdCG2FJ3RJHHE5qA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755690824;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=QI1kAdmfGcNT+wdNrzq4R6c3p8F9w78AD4YJwFXjfL4=;
	b=F3r7A2l8jhBHn6BvOyWElJ6fi7AyfbsZ/KOjb4jsKzfp7lXZn3DfuQRusS4hH69H
	V7vgVeJVEQCWJvzgJWo2mSg14xxnfeYM1VhIqKGamuacoAQeOT8F9g2EjVW6e+PBufC
	SEzK4bTxM6JGLyvLqNj28ZKKjLAXgc9RjtsAYgB8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755690822547169.44702397528795; Wed, 20 Aug 2025 04:53:42 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Wed, 20 Aug 2025 04:53:42 -0700 (PDT)
Date: Wed, 20 Aug 2025 15:53:42 +0400
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
Message-ID: <198c753eb85.10c26821075264.8127819840821026944@zohomail.com>
In-Reply-To: <2025-08-20.1755686261-lurid-sleepy-lime-quarry-j42HLU@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-7-f61405c80f34@cyphar.com>
 <1989d90de76.d3b8b3cc73065.2447955224950374755@zohomail.com>
 <2025-08-12.1755007445-rural-feudal-spacebar-forehead-28QkCN@cyphar.com>
 <198c6e76d3e.113f774e874302.5490092759974557634@zohomail.com> <2025-08-20.1755686261-lurid-sleepy-lime-quarry-j42HLU@cyphar.com>
Subject: Re: [PATCH v3 07/12] man/man2/fsmount.2: document "new" mount API
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
Feedback-ID: rr0801122723c7726d214c058bb706d0670000b4acc5212ff9e3d42d907a53aceef1bc2f847c914a98d5e146:zu0801122768410bec87a26549bb2b37970000b04b3e7f072a62d0a61e94999743faf58684bd37cf2236fbfd:rf0801122c37d12711bae2ca8e4f7f84210000fe188faa4866b06a0272b0623bab8f3b46040c29b92d259e00a7af51d553:ZohoMail

 ---- On Wed, 20 Aug 2025 14:38:48 +0400  Aleksa Sarai <cyphar@cyphar.com> wrote --- 
 > The reason I wanted to include the comparison is that you can create
 > multiple mount objects from the same underlying object using
 > open_tree(2) but that's not possible with fsmount(2) (at least, not
 > without creating a new filesystem context each time).

Okay, you may write that.

--
Askar Safin
https://types.pl/@safinaskar


