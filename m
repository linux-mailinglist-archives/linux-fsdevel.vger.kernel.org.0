Return-Path: <linux-fsdevel+bounces-57071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96962B1E866
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8343BFB26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C226278E42;
	Fri,  8 Aug 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="XFYuNxhQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E01EA6F;
	Fri,  8 Aug 2025 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656372; cv=pass; b=ph/XuEIo0z+R+Yf0GpOd92J+Nhc9EQbzsH/LnRntPPJNqoBKXVrCxlaHKVeHhALyLUBCpAkZbpbWyoMvRgcXVb+g6IaHv0sn1LQJ/jXPrUYZfX1eFWdkvgS+M5YnfO92Iwmkj2P6TJLDckBCnuQlV0hQE14UjZBfAMhxsfPWyus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656372; c=relaxed/simple;
	bh=5RQ0+KlgYtKgJpnVIo+1qCVbmoXGajzKhpxHfMEn0WY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MvtjYd96ZNENAJdXasb5WMu9wMCalWqEUjSYejotez1u0I1JmLL7R7IduYk9DKzOr6n3KhkKEKA/oirU214NoYgXsiYaFcyT0mrpkp6LRP56qX2h+L/neWq4i8dSbyGkDMPTHcHsULjpjIuecWqi7o6aaf1LhGPZFBW5v2NYGzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=XFYuNxhQ; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754656345; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UrDX7IR2VxvXfwtejFwdGZfS2v1hw8nj+cg5B2l3pDrVo5MTqw/+JmND8V0FIMfCM9CBXcimP1Gc08fXy4yU0o+DVA5un3rMf30OQ43NZztswVW8TJKAxSmuueOzao+Zi/tG3hxHF/vAbmz7ClLWFgKg5rKi/A7JvofgIoTKBnQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754656345; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5RQ0+KlgYtKgJpnVIo+1qCVbmoXGajzKhpxHfMEn0WY=; 
	b=Ye8gHmpoQgBExPR2Nr1sLutPFa7IFeImcLnKkO22YTlQtmvNXupQ+U339MGphPdq4E4t1wc/06uTFopgtnnT6hcNAporfmqx02xwz7gZCZFVqR6rzYdfMz/OoAgir3snTaLKd01bMKodI0g1iFRouI6tiH9ou8LfkNYz/iunJSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754656345;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=5RQ0+KlgYtKgJpnVIo+1qCVbmoXGajzKhpxHfMEn0WY=;
	b=XFYuNxhQ4V3dMbkA5Uv23BNwH7JMq9UrwR9O4Ex78upsvUoVeGi0fYp82IB3lz33
	AP0AaXP1Fk/JV+Z+3IptAHnKBYd02K95LVqXFAvmueqUyqqGNgtlndfUnXfwaGWOvng
	DmJMwIdr+sMcEroCQiPAvlrDZPL/QGzK8EBPc8/g=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754656343428651.8436591123038; Fri, 8 Aug 2025 05:32:23 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Fri, 8 Aug 2025 05:32:23 -0700 (PDT)
Date: Fri, 08 Aug 2025 16:32:23 +0400
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
Message-ID: <19889ab0576.e4d2f37341528.6111844101094013469@zohomail.com>
In-Reply-To: <20250807-new-mount-api-v2-8-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com> <20250807-new-mount-api-v2-8-558a27b8068c@cyphar.com>
Subject: Re: [PATCH v2 08/11] open_tree.2: document 'new' mount api
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
Feedback-ID: rr08011227ec3fb710edb18d71033cf66a0000f0b18623aa033c3fd537ebecad1b88db1fc808a4879d0a0e93:zu0801122783754bada4211323d45ed4b50000f21b461a6265b1713ea60e9de137aa5cde7232862d10e0b658:rf0801122b4eb2dc596efb65b1382cdee1000011cd5c6982eaed6fdedff49ce50371052af85a2b0623aad07268b14c1e:ZohoMail

In "man open_tree":

> As with "*at()" system calls, fspick() uses the dirfd argument in conjunction

You meant "open_tree"

> If flags does not contain OPEN_TREE_CLONE, open_tree() returns
> a file descriptor that is exactly equivalent to one produced by open(2).

Please, change "by open(2)" to "by openat(2) with O_PATH" (and other similar places).

--
Askar Safin
https://types.pl/@safinaskar


