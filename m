Return-Path: <linux-fsdevel+bounces-58597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEFAB2F548
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037F67BE361
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A99A2F83CF;
	Thu, 21 Aug 2025 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="Y5gMUZce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119B1FE47B;
	Thu, 21 Aug 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771967; cv=pass; b=r6a5xxU5mYoV2xuJ7UOyRSgZW8jzcW17XNpqZ2MNBYhRhVWDR6CtzolYcEqVPCfVLUMgul4SeAM60AJVquNLr8OgUlZjSIOrc893c6cEUvIrw6m5Tao3ccgt00ikK9Zwshjvn3HYzbqX4+4av0XqkI1CPGip2Z0/HYiQqQZtQyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771967; c=relaxed/simple;
	bh=W7nRQTwlK5iFYOf7ruzsnyR1XO+giS3VVJzYJMKaeE4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SMfPTp6J7eb2imj5dIcvaVhwSl9MKhiFgez7MLi82AJ50HWKkn1yMxK76c8GF+nMO8sChT5qyrPWncF5j9DTYLLVNOUue4R1MxDdMVL+oGL+MGcrX4fks4vh6eIbu6p/NiyZqBTiKISgRpEQcAX1YsPR+POa8RzG4RXjy9x7264=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=Y5gMUZce; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755771938; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FtyanEjCEVdCOJwYmzkCu3s2ClkEg6HUspuwVV/fL5juf6VbS1J6iwOP5IhAyyPpimbx/Qji2tUgd4PpIZtI8UotveXUDvfj8UVMrYd84bYxW1LNui7Z2s26WVwUniFek2bLCCaBmZXViY+whSnd5PyVkEnmE3dAPGK5I9gRCzQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755771938; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=W7nRQTwlK5iFYOf7ruzsnyR1XO+giS3VVJzYJMKaeE4=; 
	b=bR1fncYLM/M3PjdS+BS3tCdBw3P17myuxC/zApkykw912yRJQXbv/lIFPXA/J5SoGrh9/9DbAk+XHy7Kncjgx00kRC3EBdQX+m5y67LgLxKKU3ko+H5a8leK4xB6Tcq7tYyX1PJDKII0v9XA741XFharE3xP8x3J3AG8fGb8qjc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755771938;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=W7nRQTwlK5iFYOf7ruzsnyR1XO+giS3VVJzYJMKaeE4=;
	b=Y5gMUZceqTVcB/+feY2KjY41TIzXK6VkQCtx6t9jBC8mVL8C+lMDoprv5OCIpEGt
	rnInLUCHZ7bTwvWl1XJvPClQpInixXqMuUxQ61BinyJC0io7dXCPufzfz7rFzrZ93zB
	QE3Dnaubdh2viys9U4iILo+cbXp4FPTzLKhpK/U0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755771935979736.7022252257623; Thu, 21 Aug 2025 03:25:35 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Thu, 21 Aug 2025 03:25:35 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:25:35 +0400
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
Message-ID: <198cc299cd9.eec1817f85794.4679093070969175955@zohomail.com>
In-Reply-To: <20250809-new-mount-api-v3-6-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com> <20250809-new-mount-api-v3-6-f61405c80f34@cyphar.com>
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
Feedback-ID: rr08011227db3c8f31e337e49c01f78bf10000b7d239f5922a924b97b0ab90cdf9b3ce2aa3ff99e670b1eef7:zu08011227bf53eaae3a190cdb345976ed000034bff602aad29ec6bb4ecddc7a74b8c664ee10dd659a879c9f:rf0801122cee3861b98fd703c79cb13a390000af1c99c384db64b8ce3b3f1f2d3f6afb573266bdf1d4831d4d6a4a0e33ce:ZohoMail

There is a convention: you can pass invalid fd (such as -1) as dfd to *at-syscalls to enforce that the path is absolute.
This is documented. "man openat" says: "Specifying an invalid file descriptor number in dirfd can be used as a means to ensure that pathname is absolute".
But fsconfig with FSCONFIG_SET_PATH breaks this convention due to this line: https://elixir.bootlin.com/linux/v6.16/source/fs/fsopen.c#L377 .
I think this is a bug, and it should be fixed in kernel. Also, it is possible there are a lot of similarly buggy syscalls. All of them should be fixed,
and moreover a warning should be added to https://docs.kernel.org/process/adding-syscalls.html . And then new fsconfig behavior should be documented.
(Of course, I'm not saying that *you* should do all these. I'm just saying that this bug exists.) (I tested this.)

--
Askar Safin
https://types.pl/@safinaskar


