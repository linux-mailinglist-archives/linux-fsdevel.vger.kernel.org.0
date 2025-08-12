Return-Path: <linux-fsdevel+bounces-57497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F2B222B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38A7E4E1955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5A2EAB8E;
	Tue, 12 Aug 2025 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="FtoVLQwr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05C2E9EAC;
	Tue, 12 Aug 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990212; cv=pass; b=NhPAvFAK3CYgWKXCqbUX/DdiLQSNKUaadnfDTbW8X3/JWu2LBy3v+iGHpG35G+PvhiJTvLBcFBv490h0T0P+8m1l0ncW6KTkGuILtAztmCEJmgIXahkqLgl2Jmq0TuhZHkv1pFFsUh56FH9rNVrHoz3oq8Ifg0Y5KiA5fsDIvlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990212; c=relaxed/simple;
	bh=WCHrfZ3FqSSAm8m6z10Yl9zXQWOEanY1aJ7VPxiQmRo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DzsTrNYkA52Jqo0R3dq/tnUVKxNa03tSHy3DNJdy6obpb5fDEWmb07rDWNSH4BC1HbJYMdM4zrYRK5LuLMwNVjf7N42wcUWMdd/aubtAs1BF1qS3VCmlhiN3AK6glQnKZ6eEZlM9jZ5FNMSTVbUFsfFsd3+CaW8eIdZxp7kAl6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=FtoVLQwr; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754990175; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gCN4ceDMwS2sO8ua0KycD8kDVZEMv3eixn09ZfzQz/Ztr5XZoAdEy3KA31g9ocIkodVnnqsAoX55b9adHoCtAq5zDxMDRQtcc5EJFSj9XIxjgP25KziXfW/lUbL7FR068ElM+NPvW4WbuJENoDOSxuVHXkMPSeuUYvzkzA06soY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754990175; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WCHrfZ3FqSSAm8m6z10Yl9zXQWOEanY1aJ7VPxiQmRo=; 
	b=iMcPuzCl04jSwqNlE2sAPeShzAXgzKwA7qiSvmb9ypCEiflOXulFl5I+N+h8lwXz18CmrRWvgBumRahUcbFf1YjH/6lBNAw8WEk3m3uEIvIjDlchcH9+DewZGu1uQ/Gybl8snwGg3fr0YtnQg9dT6sTJ4+44Eu4NpmsTQ8Tjr6o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754990175;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=WCHrfZ3FqSSAm8m6z10Yl9zXQWOEanY1aJ7VPxiQmRo=;
	b=FtoVLQwraAG7EAXtulrfuXSaw2gwbluX74+xju36oKIsCrXiw7ooeNSRckv/LTqq
	g0FHB4adlSNa3RANqC/8J0cH/4MPWivdRkfzU5UUQ3wbweDmgQ/cNa+E/iqddZtg3uk
	46YzxgyrYzt0v/FLH7dZFBPwgf5wB9CRrsMzx1g0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754990173829768.6252306582485; Tue, 12 Aug 2025 02:16:13 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 12 Aug 2025 02:16:13 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:16:13 +0400
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
Message-ID: <1989d90de76.d3b8b3cc73065.2447955224950374755@zohomail.com>
In-Reply-To: <20250809-new-mount-api-v3-7-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com> <20250809-new-mount-api-v3-7-f61405c80f34@cyphar.com>
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
Feedback-ID: rr08011227a2c34c5ab8c14803b4abf6dc00009210938a959c1bb3689b6ef1246a757dba4e101626c5a0942f:zu08011227dfb0fdd931ee86c1cd2f0e420000ba6a0a3185b7859d536a7a7d18ccd2a9382d444f4696fadf65:rf0801122bb274c5e08bb304d06800b10a0000bcecb4cdcc742b10fb5c526e9134a2da206c85f7656772d281405081c4:ZohoMail

fsmount:
> Unlike open_tree(2) with OPEN_TREE_CLONE, fsmount() can only be called once in the lifetime of a filesystem instance to produce a mount object.

I don't understand what you meant here. This phrase in its current form is wrong.
Consider this scenario: we did this:
fsopen(...)
fsconfig(..., FSCONFIG_SET_STRING, "source", ...)
fsconfig(..., FSCONFIG_CMD_CREATE, ...)
fsmount(...)
fsopen(...)
fsconfig(..., FSCONFIG_SET_STRING, "source", ...)
fsconfig(..., FSCONFIG_CMD_CREATE, ...)
fsmount(...)

We used FSCONFIG_CMD_CREATE here as opposed to FSCONFIG_CMD_CREATE_EXCL, thus
it is possible that second fsmount will return mount for the same superblock.
Thus that statement "fsmount() can only be called once in the lifetime of a filesystem instance to produce a mount object"
is not true.

--
Askar Safin
https://types.pl/@safinaskar


