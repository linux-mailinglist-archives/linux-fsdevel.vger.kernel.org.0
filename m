Return-Path: <linux-fsdevel+bounces-57501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C3B223F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E9C3A1891
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF72E2DC0;
	Tue, 12 Aug 2025 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="PSCo6pIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660982C21C2;
	Tue, 12 Aug 2025 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992873; cv=pass; b=pAyXVo7v6Xkv/ZvVfFy0p+B88RQTa3mLT2FlKhHbxi1Qv6C1bml2ou8v0cxGr2ZaJR/L23JZc8FY9TKZbDTGtcf3VpNTCrNBYeLzEh747OVfjc5cLxX0pJEs+CyveDbLuLJSkLOvUXuyNFgsGfL/2RHrC4X7IlkyTrkLS7ZTiSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992873; c=relaxed/simple;
	bh=kgUCJfV7mImVOY3bZxCjYihaXOk239LAIdBgB7iaNyk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aS2i7JB/7TvKnxohdcsaffW0kZHHTCppNEx+3QXzCLd0W+QktaiZNfSG73hVHkjLDC/MXHEyO0H4lfqNl2B7TitztYWZ7rCEmQv+SobPLThgJcxn3ObYD8fFudzE4E2N5gwvyzOkmE4taV8WMOXvw4eYbG/GLachkxMYfIlMCNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=PSCo6pIQ; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1754992837; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VYcg4G2Kml1oa8Mltt7CdMobYjn0EO8HcTy6rAH0r0If0uZJMj+dJWbc7PNo8w+hitmWAldVaOvIStOycPc82Qa45A7h1z0CNgWyBPwUkHJZY4yeac0oXZOA3cmg3ZyZko6tM4Jzc2Tp3I7Dn3M2TauKA5reT5gq8nSQZGxtMUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754992837; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kgUCJfV7mImVOY3bZxCjYihaXOk239LAIdBgB7iaNyk=; 
	b=STvXLn6Vc4PZ5CTWld0ZnI8FXmjv+DXS/9bgHM2cxYjGftKPGyHUcm59MsC0ZoUJtS7daPCgePyqXLCcHhx3A8JCkYvyX6DGyHUazu1feE7Cyu73AFpcD+umJsUArcPKz2kHPYAexZ63lJfUaiOAnOicffAhnSrpsD1pXKKjfKU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754992837;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=kgUCJfV7mImVOY3bZxCjYihaXOk239LAIdBgB7iaNyk=;
	b=PSCo6pIQNtojLLY6ohwqEZ+wrnzUOJlJyRdHwDEmj2RbUEIhg4Gn39odWIUUaNFy
	Bj9lhT2fx4IwPZ2gqVWV5OSzsGanshpf53wmDFd9Tq1fJAn7dmy4+hA2HVSyIld6XYd
	BIdHJz71rYQnTuEXsLNIvV1mdLfHTijhNBVie1aM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754992836162658.3034625938293; Tue, 12 Aug 2025 03:00:36 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 12 Aug 2025 03:00:36 -0700 (PDT)
Date: Tue, 12 Aug 2025 14:00:36 +0400
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
Message-ID: <1989db97e30.b71849c573511.8013418925525314426@zohomail.com>
In-Reply-To: <20250809-new-mount-api-v3-8-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com> <20250809-new-mount-api-v3-8-f61405c80f34@cyphar.com>
Subject: Re: [PATCH v3 08/12] man/man2/move_mount.2: document "new" mount
 API
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
Feedback-ID: rr08011227ed681f0984f64caead3fd76800002f86793465c345950cc70426c6652bd2118811869f33088e1c:zu08011227b621c5e6b8fdd93ff561a4260000d3d2e17d9d1eacbfc9f32d9a32cc0774b9e31c3e7da1d76e2f:rf0801122b4f0437dd9979b87848767c50000055ac18e9c8826b37c00d434adce3a050315069caf7161966f1b2fd0de1:ZohoMail

move_mount for v2 contained this:
> Mounts cannot be moved beneath the rootfs

In v3 you changed this to this:
> Mount objects cannot be attached beneath the filesystem root

You made this phrase worse.

"Filesystem root" can be understood as "root of superblock".
So, please, change this to "root directory" or something.

> This would create a new bind-mount of /home/cyphar as attached mount object, and then attach
You meant "as detached mount object"

Also: I see that you addressed all my v2 comments. Thank you!

--
Askar Safin
https://types.pl/@safinaskar


