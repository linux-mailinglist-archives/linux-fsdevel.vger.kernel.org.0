Return-Path: <linux-fsdevel+bounces-25989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC757952446
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B969B24F31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523DB1C68B6;
	Wed, 14 Aug 2024 20:53:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailer.telezon.ru (mailer.telezon.ru [195.238.246.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318D1C3F13
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.238.246.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668814; cv=none; b=dPsMijv6Z3sPdRquwkmumNFtMquP3ZB3/dTk9mWh/M+rgWoVZG5kjWZX4inCfCiJ3T5KrrcnUwyKg21QrSLd3BsTxsruppPupipCtttnQybwy4SwSRUvj4CuhSdCtZrsOaevN57bs+hQFW75UdOAIGx3owORzdRqJzb1jC5mJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668814; c=relaxed/simple;
	bh=QBRtCnf4JKWAgE9s3dGfBq3Wt/MuLKr58A73EVF4dhg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kc3sKri3bny6iq/YI2sd2rA98HFeT3asmuMgVnADNOxMVyUqUGWz1GYupidiE8DItE0tTysf5UygUl3cRosgB/cT6IJiciN26BXEV5WsSgA1//EHcQbKGC4FeXztAwX2BryKo9zDOhDQSsGeCs5c9A9TlNhTMDnxIonuInwdc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=entc.ru; spf=pass smtp.mailfrom=entc.ru; arc=none smtp.client-ip=195.238.246.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=entc.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=entc.ru
Received: from mail.entc.ru (mail.entc.ru [91.195.100.244])
	by mailer.telezon.ru (Postfix) with ESMTP id 5B000153531
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 03:53:22 +0700 (+07)
Received: from [195.208.165.148] (unknown [195.208.165.148])
	by mail.entc.ru (Postfix) with ESMTP id D0CF2167182
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 03:53:21 +0700 (KRAT)
Reply-To: Michelle <transtel_corporation@zohomail.com>
From: Michelle <info@entc.ru>
To: linux-fsdevel@vger.kernel.org
Subject: Enquiry 
Date: 14 Aug 2024 13:53:16 -0700
Message-ID: <20240814135314.8B20F41610FB740F@entc.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello there,

I have been introduced to your company by a partner.

I sent you an email earlier, but I never got a response. Maybe I
entered the wrong address. Kindly put me in contact with your
sales representative.

Best Regards,

Michelle Finn
Supply Chain
SS General Trading

