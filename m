Return-Path: <linux-fsdevel+bounces-41314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EABA2DE32
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 14:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C723A5AF0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C831DE889;
	Sun,  9 Feb 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="Xui8yHEN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8A1DE3BE
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739109384; cv=none; b=OPWEPr6K/w/uG6D502Fthyb/Rx0C1Kn+216AxjSW2crBRYYIzvANLxz/6jY7kLF+jFetEURSy9ZMUvsqUXYyHCMHckzzeoU35XAeaSn5oRYow0NgyPfJYZcAaal/HLd56zzQYM9Lu/EH9SuONJYe1SDCzFE1G7DmB/D6XatDx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739109384; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+5UkYPfh3QtfJuuDSKPfT84/j6+sF1hGDfu3sXwbCvStNolz2d50yoppJHn5r5XzUSpf01PEPw/VMrAZJWiPiBN2iX8lvC1pQGx7IWNVS/ULe4OMqK2FRdcxH946CTN1GFhFmO2uMM7mh0OMFK+97oWQx1QgIAJoZor9bWohWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=Xui8yHEN; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=Xui8yHEN72jWXNNpUKaPNi8ntD
	grsZ6aC9BM02uU0GEmnDEqduqdshwWniwKlwg8c1O7EP+CSJ9pAo+4+jjEtiYt8KUZbReoLQlPDb/
	GJvjWZ4TWN7cDMKFN/dwEdYAmyBzx+HxvgmSQpx0h6FLoQN/IAMgpytShGbs+hauP1aezeiP8YEwy
	/o/QSxyIQ5eJyEjU9kEIw8vUhMkb5PF9P9UO8SBlvBj+dGzm7uTjQuSkKzApqZGIwRSPUNjhQZip4
	X2UQk5ePU7HXkOxLc61MqpRQouI6Vb8r3s9opovdY4+FKPImVxp9p2Q6sKzNw7i6SNwYVT2BQtPWO
	dB+JyenA==;
Received: from [74.208.124.33] (port=53269 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1th7nI-0008Ay-15
	for linux-fsdevel@vger.kernel.org;
	Sun, 09 Feb 2025 07:56:20 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-fsdevel@vger.kernel.org
Subject: Re: The business loan- 
Date: 09 Feb 2025 13:56:21 +0000
Message-ID: <20250209095302.E452C1917A2F0CBF@truemaisha.co.tz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server-598995.kolorio.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - truemaisha.co.tz
X-Get-Message-Sender-Via: server-598995.kolorio.com: authenticated_id: chrispinerick@truemaisha.co.tz
X-Authenticated-Sender: server-598995.kolorio.com: chrispinerick@truemaisha.co.tz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

My name is David Song, at AA4 FS, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
David Song
Senior Broker

AA4 Financial Services
13 Wonersh Way, Cheam,
Sutton, Surrey, SM2 7LX
Email: dsong@aa4financialservice.com


