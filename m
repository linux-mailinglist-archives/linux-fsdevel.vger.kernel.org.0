Return-Path: <linux-fsdevel+bounces-75449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A0FO0lJd2l9dwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:00:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38E876F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 12:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4516F3031CE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8A331237;
	Mon, 26 Jan 2026 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvLUkCn+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6D30DEC7
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425186; cv=pass; b=lelCbVxF4XRNfMose+ZEKlFvYc0MYXrPc4w7iCphdfcJr/MPZWu4GC8MFA+1BZgFqbKWR4KiI7HX35wGCMD3NlahoY9xnFgmD1S3PeF+6NdYfS3qyyI2y6zF22A4Ng2BFY1KIAFgbMc/M0l61FYEyVTevqYgC5ttKguNlDG0es4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425186; c=relaxed/simple;
	bh=2XstvkdlueVaAOIoVw3LWY83uMKUvGOF/yUUwA5uchQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYqyBbFfIRlnm4fnEb85WvbBf8hCV3eIM2zVfhMQCk1frVyLFKR1pGdYecUMb14yYQ24nV+EUC0H9D+aVUvo/MkCpc9rBIKwMLhRn/KgbTLWuD9gXQk7ldXz39UQzBeK/A+i+FKA+8v7NyQgqSZ11A9d2kWUbDQKu5UO1UPNZSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvLUkCn+; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso8546142a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 02:59:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769425183; cv=none;
        d=google.com; s=arc-20240605;
        b=FpGdIab8Ch+6L2/wcLFfYjHkMwvgue11FSXBYKTgOCyiAOkecTs16nCCE17dlzty3y
         dIhvRpjywWzzF/r9uZOswEUZh6naIByZaHVsOwh9janET957qEqg6+Wf10/cy2P6JJWs
         fifpptGX92MY20K2tnkLOs38CTl39nRLbT0KaoCwzIIU6LdTDT0q+kbRu9vuVRVt2dke
         b+Q/NKxF8ivRQ9Qx/APzjFnnxix/NpMqGLBn6JFqoQX+FOo7abr1PCTuVfgUwy0M34Jy
         E7bReNtTR58rIJCGckA63DPfyRbzJ0i36BviEoXeXkuDu1gpUiu42lFnIhDHnlEUA4mp
         EPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2XstvkdlueVaAOIoVw3LWY83uMKUvGOF/yUUwA5uchQ=;
        fh=E+2qEQxC/QN1DptZ9sgVpOisIbWWSfCJKD7HVsf7y8o=;
        b=R5Gf9y4uJZT5wqJj8LMUlnUnEbCiEDav1aUd1+2pJRkkgam83vmgEakS9aWXXTUTeV
         qiWcdy2krCIxlQlsuvXZ3cPAvss4fQ5c6P9NFBlmV9dAsxz8ucMzKm6o3yMmYFXJKW6o
         ftA47ASvCHAIYBTI3sxUfv8JGX+Ii3oYMb0iHNC58nsiRM0+lvdNXksU1fnfRwcHf/YA
         LVnOKYqU9pSI6rRgmUpqtucGrGYp0WIp0EN1GoNzq65gL6RJMIetj3a9RvfuhEuhQ7hJ
         mXM3+yI9rgJVAczACOqcIoIPn2G6gPO2f8bsi3K2UlyFMRgX1T+TFpJ1ijn5TJZagk9M
         OKmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769425183; x=1770029983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2XstvkdlueVaAOIoVw3LWY83uMKUvGOF/yUUwA5uchQ=;
        b=UvLUkCn+h2NnvsEy0eDGcNyPBej95rmaEmrsJr53oY+ZfBVQiN7XREwoA9lZxCDveE
         g/K4Y51QQq8hD1fkFvRHAjCTbTw81EvzbtGuF/lbdGOaALWPu0sT5g8yG+aLQk3XqYSW
         vNJsxnGS46f+VvoLSokq+IELkEC/mIvjgC0ZKM2Gr0GR2De89gW7HaFyYobZvdCuKP2x
         CjoqVVK6y1Rzmk79ME6vEbt0ZV0NXJvX4zp8RXJPVM7cEpDGCPcE4nwa8LyL5f6r8YwG
         C4fMaxg9xAcRDLJ53HDJLDAU6i8L72NPTR0xhoKFV6koPs3g+ZJVnn5p7zCvXLmZnhfO
         M/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769425183; x=1770029983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XstvkdlueVaAOIoVw3LWY83uMKUvGOF/yUUwA5uchQ=;
        b=hmlqNvPPxOvKbe5L1h/UoSbtm1ROM1yoMi2LQAWIUcCRa4CB/nURA0Oj5TM9X3WrQz
         jUNCfUoYmMArFtm+tJ6+kgxQvGF3znC7bjhZFDT3KBKbvbunn9vpYOTDmEdUi+kSwKEi
         EjjJ6McW87aF5P86rePWvNsNeeVyskkkaIRAyqbA1PxQtwslSuJtZUeVeyiGpnxhLEbx
         xFmvJb+sDPmiQdl1Ur9wRTJuy34n0wYMZJ32RGUWa8xhBjPhJDQzd8abTulE3aO85DHb
         0RHf7Za/J4RB0cwxvzRNuf8OM29L7+sCUbquDn5uPLrXfUpnnT7CLxA0feZwPz7Zyu3W
         nyQg==
X-Forwarded-Encrypted: i=1; AJvYcCUoGy0hpDZ7sI5mb2wM0ZjR0nkerqU9f4Ct4bZJieV4GZV1Grwi8XGvPlavZTkTQ0r3DFKePVV3MRGA9BSD@vger.kernel.org
X-Gm-Message-State: AOJu0YyWYgkwBDVomtRPquZ3i+BpanxoJw/cNrRpgD0B5FhIHoFV2f9G
	K3cFB1CX2dG0QOZJYU5u3LH+rupGOvlZ2r9czIP+tiSuNj5dooHGM7KcJV3npPvkwaytFbA8+zU
	XKW61RoKeKnGD4tCIiXHUydVxiyWMbQ==
X-Gm-Gg: AZuq6aLryfAgsze6D3HoVc44Y87C3Yx/LMln7S4yy0uMLFTat4fD7loNAA8xWZYfoYI
	fF1qRyCMGksMdEFBL+v+DwUs97K0n48q/C49L0tgvCbJpQEzkLHiV8N0Ap41WKinXIGb9fsRfrJ
	WRFwtuuZdO1z1IhjzN0DNe/2ZLvZc5lQQO0c5pFZB5cJuX28zRPlM16H9DCGqc/0qufzQZwdKuG
	3RiNq+fAT8DQyhn5IMw/pjES2tKx4UJn+DPHPDx1Ox8R5KahIUtgY3s/3Am3L1osKOOo8qwWNds
	wnWj5C7yzcUDmpK4g5TbDaVp6/Os+Va0fhn2lKx5hnP0oxeo/IFlDN1hAUKP/rKdgFH7
X-Received: by 2002:a05:6402:4415:b0:64d:1fcf:3eda with SMTP id
 4fb4d7f45d1cf-658706c6cb7mr2343964a12.22.1769425182768; Mon, 26 Jan 2026
 02:59:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126055406.1421026-1-hch@lst.de> <20260126055406.1421026-3-hch@lst.de>
In-Reply-To: <20260126055406.1421026-3-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 26 Jan 2026 16:29:04 +0530
X-Gm-Features: AZwV_QiJFF4lmS5bLHeIfBkzmZWxYPcftNw7YhZNZGQ56W_tH3yW56RnEjWskS0
Message-ID: <CACzX3Au+grRcDxYp1Kwd418+OgJdN8=mdB_DrSRvphP9KqW3LQ@mail.gmail.com>
Subject: Re: [PATCH 02/15] block: refactor get_contig_folio_len
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75449-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj1072538@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A38E876F4
X-Rspamd-Action: no action

I sent this on the previous version, but FWIW
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

