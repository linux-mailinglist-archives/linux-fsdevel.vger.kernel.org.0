Return-Path: <linux-fsdevel+bounces-62536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3AB97E97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 02:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7036F19C52BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 00:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20C41A83FB;
	Wed, 24 Sep 2025 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="K2ro7B0V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635F13BC0C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674104; cv=pass; b=KwqEHpWkGbla+DBHbXNFf9PPSGARJ01lCUSbIwWUOM7TTXxCq6KWXdaX2fDM8hPd5kMej33V4/jx7IoT8SP/fSiWept2DEHvGM8ZHocxGx5rR7qmi+egnKq1vnfV9DWCYvcuM9DiOU5IPI8uaB5OG0LY3Ppt7hsn0VDdgS4Kvs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674104; c=relaxed/simple;
	bh=VI8xTAYOnzo/6htpGf8llCPrWRw4nq7KBCDg/XvfxeE=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=GylxI4kLBunsAg3jTUEgfuwOJmk32Lf1+5LP4oac+IqmUt8GtiSer99r8P3TWmiPr2ueidQ38iHQv4uAqhjDf4xjswTGdvDNsHaDaZoMTtDADF0KnzIl8Yh9esCtTR+kJGIK1IRgQIitXMBWAsOiGB0xVQ1swh4KQGF+HzIPVN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=K2ro7B0V; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674101; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=tLnLmW4Nz8sDw5T/06DQxbQ5a5IgkHyj4SmI2fdA6pv5NVymvhWa5emsIYyupXIQ6o8h+kcSSETnL7501J+Mnwc9YxVu3h9HPgtE4iWZkZF0XdLh8DOYBq1+tt5armE03g0pT2LFXVpxem9rw0WV2mNT84nobYDiTXIdsQcuKR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674101; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=VI8xTAYOnzo/6htpGf8llCPrWRw4nq7KBCDg/XvfxeE=; 
	b=VMQuW2GkA1fJ+LOQnVZ/jH3c1qusv5Kb0jFSfznfI2wZ1zBfqx8vFrdzGylktjtBE/ShFKlbfzFks9U6+sXpjmelAxd9PU1a/cDMDd1mWU7eoOiD19EIjNi4DSFZ5qaM56RdckjARP4+sV9jmYiFw/qX2KYyz/2HD7lrQzRB+cY=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a706360-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653656606.061254046197;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=K2ro7B0VObubelLIJtlXqTDJtkLpPMNlAZZL4Pe8QAYKfScq8Mi22WXt7IUC49XTE89HuhOQahgm4ZuaxOTB4oYWyHK5hKpO4Q+GZoBZtjYNt/7mxx5u16lLPle5PUdorUrDgRxpk/eCGf7938RC1Bxez12cK+e6FgQlxybFoHU=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=VI8xTAYOnzo/6htpGf8llCPrWRw4nq7KBCDg/XvfxeE=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-fsdevel@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a706360-98d8-11f0-ace3-525400721611.19978ffc496@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a706360-98d8-11f0-ace3-525400721611.19978ffc496
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a706360-98d8-11f0-ace3-525400721611.19978ffc496
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a706360-98d8-11f0-ace3-525400721611.19978ffc496
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a706360-98d8-11f0-ace3-525400721611.19978ffc496
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a706360-98d8-11f0-ace3-525400721611.19978ffc496@zeptomail.com>
X-ZohoMailClient: External

To: linux-fsdevel@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

