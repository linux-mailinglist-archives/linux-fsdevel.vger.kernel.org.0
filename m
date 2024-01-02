Return-Path: <linux-fsdevel+bounces-7067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DA821828
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 09:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF6E1F21ECB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669B46B1;
	Tue,  2 Jan 2024 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="f66IHl94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF24429
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso2326731fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 00:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1704182584; x=1704787384; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QplbFcSPvwJFHjt+4B4SnC14Nl0/enLaQpF2jB1y8g=;
        b=f66IHl94areFcglr8O+2oW48fZubRkCvdZpg/yITR9XeLsCL/BH7RrTiqeuYdfvKrj
         18/opUgZMLtuIft+UDSoBREv7s8+5Zh5p+uFacqK77WVGHGoSTSFiRoAmJh/5Sq+whD8
         qvB5sMzByO9E22Fkg8a5DQPL9FNskbWE8ykhFWRbrmMoHDetsYoFFeHKPYuBI4OjVJRm
         iVpqRE746Ntzz09qveqRS84m8d6VNwkJMJGbwX7TCQAQTrbtEM6XEESRoEKxJ5Lt8Lnx
         s7tlslamWVb1mtk7lXfbi6jGy2cwPOb1N7XkbxPnPTOAGOzp43qErjPG3NqSFyyJZYJa
         ezwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704182584; x=1704787384;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QplbFcSPvwJFHjt+4B4SnC14Nl0/enLaQpF2jB1y8g=;
        b=vV/yJAZGfYCLN0nWdqttrKznk7MptM7FNzKxZgflcEn7Z4LMR7kdduZbu++Ftqfi+U
         0AHVmJcnNTGkaVAQghd7ZoDvmyCcnudfy86HJy6GmpTnyxrZSVN4dvorPUZ8mfBWWwZD
         hXh5pRykotHVB+2JALErpL2N7SDeGIDnFO411SQaoR14lbtrPar2uNgNb+w/8mKIbtoE
         +082fjCp/YiAGlBfkjZ+pmRQYF2Td4cN4rEskTy8l9xjD5xYOE17er5+92YR+50hCGsb
         Y9dVCaRj17Xhp97FWo3JxhQIOCcX8vwwx5bm1fI3EbqZYiLgX1K8c4ke106vReaL2acP
         OS+Q==
X-Gm-Message-State: AOJu0YzKeJiyTWurJU2hVCFPPN8KeHq9qDlIJJLpfN3wGwO3M8QkvFef
	Z3biu+1ILyQWOpDiT8WFo+uFSXxTaJ1Qog==
X-Google-Smtp-Source: AGHT+IE4NxMG2ZLQVOnNyoBDNtIcgzfOIKXP662p//dT7ROGNicQbGMVxXFwxHhqd9nyHTbupjL2gQ==
X-Received: by 2002:a05:651c:78f:b0:2cc:8f7d:4e11 with SMTP id g15-20020a05651c078f00b002cc8f7d4e11mr6233123lje.21.1704182583738;
        Tue, 02 Jan 2024 00:03:03 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:758c:4713:723a:7dae])
        by smtp.gmail.com with ESMTPSA id h21-20020a05651c159500b002cd1000cd76sm146364ljq.135.2024.01.02.00.03.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2024 00:03:03 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] bcachefs
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <i6ugxvkuz7fsnfoqlnmtjyy2owfyr4nlkszdxkexxixxbafhqa@mbsiiiw2jwqi>
Date: Tue, 2 Jan 2024 11:02:59 +0300
Cc: lsf-pc@lists.linux-foundation.org,
 linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EB6181B-2BEA-49BE-A290-AFDE21FFD55F@dubeyko.com>
References: <i6ugxvkuz7fsnfoqlnmtjyy2owfyr4nlkszdxkexxixxbafhqa@mbsiiiw2jwqi>
To: Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Jan 2, 2024, at 1:56 AM, Kent Overstreet =
<kent.overstreet@linux.dev> wrote:
>=20
> LSF topic: bcachefs status & roadmap
>=20

<skipped>

>=20
> A delayed allocation for btree nodes mode is coming, which is the main
> piece needed for ZNS support
>=20

I could miss some emails. But have you shared the vision of ZNS support
architecture for the case of bcachefs already? It will be interesting to =
hear
the high-level concept.

Thanks,
Slava.=

