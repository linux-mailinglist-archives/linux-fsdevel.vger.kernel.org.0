Return-Path: <linux-fsdevel+bounces-59299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D2BB370D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D27AC2EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39852E1723;
	Tue, 26 Aug 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="GstRLxvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4127431A571;
	Tue, 26 Aug 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227690; cv=pass; b=rwOOjG5/Nv2DMvyuq/mKPVpfeUBVrH34eXUKij4eiAlWZURRuP4pdX3DKfM8R4RQsi5OH03EMx44s/bdDlXjOH27A/+jmv9RH7l7rBWRdfsfBeFrOJ0EgqVb8opI9XC5WlP+VKxZQh3QBbJ9aU11mrHhe1YCdkyk9YK6zMTM2Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227690; c=relaxed/simple;
	bh=qH5jOpgeZOJzHJ5EzIlKig8EB3gQxdUMoHTfIV696J4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GT/Pt4Aqvc5lPRLGOs4zIeUpVELiwTheqkEXVzxsr2oV0A3vRiWx/2hCm+wkElzY5aE0VFJ0UuvDLb4rfUE7R1pvT9nijL+brVqzQ0IEuzycLupfpwkh5d9NBedO7yyZflL9qQAqW2KJbtz+ZAWcmxvyw1/TQyiucFuINt1Rn8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=GstRLxvS; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756227657; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=daJchgAZ1QUXGPzDpUdL3YCjgAfa9irW8dfqDDT83Th96HETmTx96K5TNI61Wy1q76b1oI03/v7kCBB44QeQ/GNjgOZ8LDne26DuoqBmDuKK4GY+olKKgrnp5lL+eDbcw9/QFElHtNwFjG3HcEkcAh66Dbi9r3fRC4ceS8t+aeQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756227657; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KDeMMywmvB9WAI4x+qiH6MX7k6fDsjpvKR+qsOi22yI=; 
	b=kfOv0Pl7VS8LnQTC/X7j1RHPY2PNoo43WTbNeyclknn6klZQH+LbxaHbmwkqV4+di1v6J5z89DlhJ5GbbcxF9SYEcvH6OLyAEoH5PwnucZ9M8zzk3rNr4pmU5mFYwXCQh52aV8hTW3LWw36hT9vu8CxPiOBOofA49/vk1WPV8/E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756227657;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=KDeMMywmvB9WAI4x+qiH6MX7k6fDsjpvKR+qsOi22yI=;
	b=GstRLxvSxSRbHzmo1YjZI+tGHJw7RfL/H1G2eJwem6HdlsJRVPTHlNZEhfK4y0Sg
	yxSLh61SStKb+jf4BGJTuCrpleVhFZq3bqDCOuHSjmfhwg5lQNi0wqZKOio/t93pBa8
	QMLVbVwV0Kh6OaZcIRMHW0RV8/J4Hur+T+hSVuwE=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756227655220931.7736108771608; Tue, 26 Aug 2025 10:00:55 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 26 Aug 2025 10:00:55 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:00:55 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Byron Stanoszek" <gandalf@winds.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "gregkh" <gregkh@linuxfoundation.org>,
	"julian.stecklina" <julian.stecklina@cyberus-technology.de>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"rafael" <rafael@kernel.org>,
	"torvalds" <torvalds@linux-foundation.org>,
	"viro" <viro@zeniv.linux.org.uk>,
	"Gao Xiang" <hsiangkao@linux.alibaba.com>,
	=?UTF-8?Q?=22Thomas_Wei=C3=9Fschuh=22?= <thomas.weissschuh@linutronix.de>
Message-ID: <198e7535627.e16dd6a239997.462747272790524454@zohomail.com>
In-Reply-To: <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
References: <20250321050114.GC1831@lst.de> <20250825182713.2469206-1-safinaskar@zohomail.com> <20250826075910.GA22903@lst.de> <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
Subject: Re: [PATCH] initrd: support erofs as initrd
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
Feedback-ID: rr08011227420bae0256fdc2a2a92c7337000045cdf6963ab4ff403b055f75489c212f73dd8555d07c3fb39b:zu08011227bd7a5257bc4c91043db4a6ed00002d21e7e806c2decb5ddaad591e26ef4b9cf508a25cc78c8bb6:rf0801122b7104d5b895dd2615aca0c9660000c7bb3e850ea71c4923fe08f1ffb35d14aa7fbe385563e40f02f37d091a:ZohoMail

 ---- On Tue, 26 Aug 2025 18:21:50 +0400  Byron Stanoszek <gandalf@winds.org> wrote --- 
 > Well, this makes me a little sad. I run several hundred embedded systems out in
 > the world, and I use a combination of initrd and initramfs for booting. These
 > systems operate entirely in ramdisk form.

Put your squashfs to initramfs. Then do everything as you did before.
I. e. in your /sbin/init copy that squashfs to ramdisk (or, better, loop-mount it), etc.

If I understand you correctly, this will work after removing of initrd.

I will not remove ramdisks. I will remove initramdisks, i. e.
special mounting logic in kernel, which automatically loads and mounts
ramdisk at boot.

-- 
Askar Safin
https://types.pl/@safinaskar


