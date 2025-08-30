Return-Path: <linux-fsdevel+bounces-59708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C035DB3CAA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243FE1BA24D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDEE2773F3;
	Sat, 30 Aug 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="JAvGPJGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683982CCDB;
	Sat, 30 Aug 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756554637; cv=pass; b=pC0cat7ko+Ap5amhhKG1EieeZ7rgofaclsBWm/JMZuepxuTy0WKXYUS/agQVYBpZ4tXbFBVjB7CvrPTowYTF6C/eWuj5dDg05C0PpT70VSKn40yc2XeCxToczlFFuM7jGIs9exZKeRS0C5HbF/gh5AuWy/tPSbb6WqWrzuIJ88A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756554637; c=relaxed/simple;
	bh=hkHJTi7BnpyGnfwJf15txlxPT5t9SRGJp6Au/ITVSOo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RbdAN/Y7WSXaFhgWwIr3OJt+FIduqTGpMXmV9diSrCpz4on4xzZ0XMOI9+YHTDVRPoDSOUFavjPtd0VCv3Hz/vJzQz/8G6BiBVXGNOzqtSWjkOfMbbjfaE498lq+a8tUxrrdXj3d1oBMuX/kPWcnCxEbqHpgR9zc4pKKiZnOpIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=JAvGPJGg; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756554590; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WfUv/9IYoLUwoCLl31xzGsNNfz3SQ9dPPF6ay3tnxtRaLkYlgrTFxmQsM3Q29JorU45WdsQwGWrjqB+eUP3Ml5Ulv72rsUDAIc1N7CuxCRGfCAAFC9IK44VhIfPlmGquTJNLdnqPK2NZ2S1E5rX0DwvoF+1jBLyqoFoGnttueHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756554590; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZvkzI4mjzY4TGWd9DS9EgJJGePkSTfHVh26gxLKd+Q8=; 
	b=Ey8TqD5XBij7QVzk6WaydeTyAWxbPywPp5s1cwcepduklmaR3Uv/vU/7ZcZXI9hIsBZx1AqMa1X+W2eV+dmJtBablV3sId3Yj/pu51CuxiN3/o/CPyH8WkGVtajwLojCtiD35/yHwVZNyL1LpETy2WbVNe4noXkf1CrtpM3eyDE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756554590;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=ZvkzI4mjzY4TGWd9DS9EgJJGePkSTfHVh26gxLKd+Q8=;
	b=JAvGPJGg6q+Jk9UWATkWyx2nUpdF1rRP+ncFDCmml0fEWkHo4ON63lI4JWvqRZBG
	xSLsnAr0yY4E4p3vUyh62gaeGsEzrvcH3U0/G/9m7UwmWNVnxg1xwWyMqwPo+yEAVnk
	kFoGc8w1KBjnleW79jU31oYWrU0I/i11o3cU+PQc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756554588150332.09403294804895; Sat, 30 Aug 2025 04:49:48 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Sat, 30 Aug 2025 04:49:48 -0700 (PDT)
Date: Sat, 30 Aug 2025 15:49:48 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>
Cc: "Byron Stanoszek" <gandalf@winds.org>, "Christoph Hellwig" <hch@lst.de>,
	"gregkh" <gregkh@linuxfoundation.org>,
	"julian.stecklina" <julian.stecklina@cyberus-technology.de>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"rafael" <rafael@kernel.org>,
	"torvalds" <torvalds@linux-foundation.org>,
	"viro" <viro@zeniv.linux.org.uk>,
	=?UTF-8?Q?=22Thomas_Wei=C3=9Fschuh=22?= <thomas.weissschuh@linutronix.de>,
	"Christian Brauner" <brauner@kernel.org>,
	"systemd-devel" <systemd-devel@lists.freedesktop.org>,
	"Lennart Poettering" <mzxreary@0pointer.de>
Message-ID: <198facfefe8.11982931078232.326054837204882979@zohomail.com>
In-Reply-To: <79315382-5ba8-42c1-ad03-5cb448b23b72@linux.alibaba.com>
References: <20250321050114.GC1831@lst.de>
 <20250825182713.2469206-1-safinaskar@zohomail.com>
 <20250826075910.GA22903@lst.de>
 <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org>
 <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
 <198ead62fff.fc7d206346787.2754614060206901867@zohomail.com>
 <d820951e-f5df-4ddb-a657-5f0cc7c3493a@linux.alibaba.com>
 <81788d65-968a-4225-ba1b-8ede4deb0f61@linux.alibaba.com>
 <198f1915a27.10415eef562419.6441525173245870022@zohomail.com>
 <18d15255-2a6f-4fe8-bbf7-c4e5cc51692c@linux.alibaba.com> <79315382-5ba8-42c1-ad03-5cb448b23b72@linux.alibaba.com>
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
Feedback-ID: rr08011227b1680bc8dfa7516761e11a58000037d22aa2c4bf6443f88b89fca418cb69e901b393ecac839940:zu0801122713c6f3fa07929c198cea8c54000001b7ef109b69da37ee11b3219213d70ab659eef1baeefa4b35:rf0801122bd8de29ae7d823f39305d05110000e13d9f3e9222b5807b8cff5406983aac6e47ac535363058d329ca9ce4c:ZohoMail

 ---- On Thu, 28 Aug 2025 21:14:34 +0400  Gao Xiang <hsiangkao@linux.alibaba.com> wrote --- 
 > Which part of the running system check the cpio signature.

You mean who checks cpio signature at boot?
Ideally, bootloader should do this.

For example, as well as I understand, UKI's EFI stub checks
initramfs signature. (See
https://github.com/systemd/systemd/blob/main/docs/ROOTFS_DISCOVERY.md
).

It seems that this document (ROOTFS_DISCOVERY) covers
zillions of use cases, so I hope you will find something for you.

I also added to CC Poettering and systemd, hopefully they have some
ideas.

 > Why users need to extract the whole cpio to tmpfs just for some data
 > part in the erofs? even some data is never used?

Initramfs should be small. Time for extracting should not matter.
If initramfs is too big, and time becomes issue, you are doing it
wrong.

Point of initramfs is to be transition stage and then get to real root.
Initramfs should not be feature-rich and should not be big.

 > Personally I just don't understand why cpio stands out considering it
 > even the format itself doesn't support xattrs and more.

As I said above, initramfs should not be feature-rich.

(But xattrs can be added to it, if needed.)

-- 
Askar Safin
https://types.pl/@safinaskar


