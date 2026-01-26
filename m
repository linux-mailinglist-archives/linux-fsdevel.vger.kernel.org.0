Return-Path: <linux-fsdevel+bounces-75447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN96LBtId2ledwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 11:55:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9D8758D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 11:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 387B03029784
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDAC331238;
	Mon, 26 Jan 2026 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDwcCI1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB632E6B1
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424884; cv=pass; b=eGbXn5XgS8lfcWTEz95e0e73wIxUSENoPxlXRLn0PKhoLmkpQUzXDq2stfRa0rm87iKz+gvj6JxfUitrsK8dalFHSx2tGXRp5y6GwAbiOVE3nogt++B7Blyj6O1MJLpc2qyQefC8AXfYW93vmBkYxuR3mtilupHMEykWH+11mWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424884; c=relaxed/simple;
	bh=3omMcSnzzBOB/jU4R6Db7fut+Zs1dL68KtxqM98Cvg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpg/F/XvKL8ztwK40H+MbtKOyWZHitHgxtPNfHmKVnGeOzcmzW6BF3KNjWMKL8j8lvnL1YqeYjI7IDwAQzSOZLcmVDhXJSvbn8UdOVBe5ZgutrLBztrn6oROJnUYdnBVgtpnfykeB3o+rlVk0Tj1OXKG8ZMZRfUm8ees5WT0VcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDwcCI1z; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65813e3bdaaso7523313a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 02:54:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769424882; cv=none;
        d=google.com; s=arc-20240605;
        b=AX0ptcPUN5HpV3STVOcChnMsBLH7qxDZbIQbpfPqdb3SrMrOeRp2D+v6H90DVi2Tr2
         RIydUAgl3KD9heOFqqBnLca7E1LqhDJ70s7Dt50LTSdsY4UIMpwC3GX//gUH0BOqyahI
         Zw7IL5NP8J/Isk2Qat+T9FwGDPm6wAqI3lGg562SGUKn6zNUUMWfgnTrmllBHTDJmCwf
         le+deTPuW3GWXAZCAm4b5EMZvqpi002tttuD5Fecn8kTmrY5+t3yDsBJP2eAVEmVgAHI
         htYZSc1tst+thJzk7dJFLSm6n31IKjR5izBH2SoWGsDoO0vw4ucwifjxTomHYHiDbWlM
         WJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yNBCh+MzIZqXXtP5FXW5pr/v9SaMB3DIQFyJVa5+MmY=;
        fh=sv7rLRFfi2F9YNguYf+fKVvUilfYY1KoHogSYWZwGzQ=;
        b=JrGk0+DJOZIxRPZy48zGupRMFbdjLojQr7Wj7hSntWnUaO92ZliQJnzDosedt2GnsS
         bWagmKC4cu0J5je+pa46UXL/zHEAtVbW8Z/iN++taXB0kbKh394HUphgKjG1Pws5w3NI
         gzv7+afXoIX71R5Vwp4nDvRSE60Vd/0KjQidTDb6RVTU33cPfxsDvU3pMsaTS8bl/oBS
         Wl4o3/y67PkxXd84LEFgtFycipczBTKgut3Acm+kS0SwN6oUxAtzc3GIMlBbfoz2ID/F
         OOAWTsLZ9phDLz/QUkDVMp3KastA0eqrbGni+fwnDh/c2mWsELwMdDVzBvYN+tR49irS
         I4xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424882; x=1770029682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNBCh+MzIZqXXtP5FXW5pr/v9SaMB3DIQFyJVa5+MmY=;
        b=BDwcCI1zcwMS1r+JBTzVcAgOhhCyKy0iK3KjR7cl4JIukj3SmH85AXv9o9B8g1qctg
         k7izeFCcTtPCcQtECVeXoH+n24rzuwNk8c9uqRbQNFhOjscE+kr1BAy4gEqD7omZkb2y
         dactuQd5KyDLfPA1OEwNuUMSZ9eRk39Jh+Q/gCPk2LrC9aAEAoMY562w82OB/4q4YB6g
         ol38PUksbxt0njqtUvypKopW88GmE/q9XXJ3pWhOzN3l8DKqd0UCXlHY/CMu2WImU2ul
         E5MDdkm1+mUS25rqM+9YDj3y0VXgB+ZMpT8mE23DvKrUub13/KaHHX6oli1RGkl0eUl7
         qyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424882; x=1770029682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNBCh+MzIZqXXtP5FXW5pr/v9SaMB3DIQFyJVa5+MmY=;
        b=PeW/17Im7ymwIiJ2H5xZW1SzSvX3yKOYLO6Yr6wI465d9EwVXZxj6vOi6WW3zXc+ZC
         WHh9eUrwqPdb7PUnKiZrM6o7DaDEtHYo//R25qTHP+PZZbvTa0ZmQqSicJyug3OAU593
         zuq58keXBNrk8++nQpSGmiriisBRHwhSmnGMzZmALtjUQo4WYW1leLt2T86fztQyEgWZ
         QoKs9VNqxdW22b26n0hLOBpyYRaB0umGtWHiWviBXeOCXsYi68klEowZqwS2eZdqsy/v
         6OlFY9T+RSZJc1ASxYgbPE+/s9OJN7a/OiAiGlHTWYIUCZz5YjGmH88EpbWdRoHo34m7
         Hmvg==
X-Forwarded-Encrypted: i=1; AJvYcCVYQ5a7/yg6WmaaIIVr3uhZTcHeTsxhTP33wlQGndm900o6ysR+OaLCjWEsDr7UejHiop3E+GnsFmkxG+e5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0Ok+dWpgZaXnDdYkbjME4jKp3DCi19mCWdJIcDuBeHd1EBQP
	/h2T3cBlFgi+PAEgAkDK82696X6p05LflETb0YO9I7EGitFjGPE4vKQ3x64/HpJMD5M/qyjm3bz
	qTTPa1K4vAmOJ41vaGJaSPQd2JLrXeA==
X-Gm-Gg: AZuq6aIIqlCY4QsKjJAu+H4gKijttx+K2AMVZwghtwrF5Y5C/H3NURFb9SHkwZ4Btyc
	fSDLXjgnVLDnQ2ZuuH2iOrbw7RMYrOHGoSMsEiAMFq8hE6ektWg9X53YZvVxa/tVlb9AipdxXZz
	h/0h3JRDzxsdY/0pP0Wzu5PNHQlQIvrj8OzUvSGZj3a7WnHLm76BII1+rpXf/LK2UMDmXMa5G6J
	2xdBVY8Qo9afjBwT+nWZnhPgbM5EHHi0EBkKNVmmB1k5J1FEv/qafsV+iHiR3+VZbWdeViAbLQg
	d62QDLiPyS+L2ORTATKo8/hwMYp/7Bsg2WWsb4e3EjbZVR0as6Mo6ss7rg==
X-Received: by 2002:a05:6402:4306:b0:658:1224:3d5b with SMTP id
 4fb4d7f45d1cf-658709c0267mr3007632a12.1.1769424881479; Mon, 26 Jan 2026
 02:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126055406.1421026-1-hch@lst.de>
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 26 Jan 2026 16:24:03 +0530
X-Gm-Features: AZwV_QgJvnXLJlNIFnJC-x5vJYhiyLLjRUKN4n8q42zV9yyRDXraubp27mNNc8w
Message-ID: <CACzX3At3fS19fmp8wOq29rHK-yw0KFp1bAvTdo9NC9eQj4E=pw@mail.gmail.com>
Subject: Re: bounce buffer direct I/O when stable pages are required v3
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75447-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 10F9D8758D
X-Rspamd-Action: no action

As Keith suggested, here are the QD1 latency numbers (in usec)

Intel Optane:

Sequential write
  | size | zero copy  |  bounce   |
  +------+------------+-----------+
  |   4k |    8.91    |    9.09   |
  |  64K |    35.98   |    39.9   |
  |   1M |    341.96  |    531.51 |
  +------+-------------------------+

Sequential read
  | size | zero copy  |  bounce   |
  +------+------------+-----------+
  |   4k |    7.18    |    14.28  |
  |  64K |    36.4    |    95.61  |
  |   1M |    206.38  |    258.66 |
  +------+-------------------------+

