Return-Path: <linux-fsdevel+bounces-59349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CEB37EB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A32B1BA0CC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23423451A3;
	Wed, 27 Aug 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="dqeqCziO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D4306D2A;
	Wed, 27 Aug 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286607; cv=pass; b=i2Unj4n3Ps5ARHl5obYUfuk0emPcLfyMNUVg92xMez0ocJMjAPlrlaZ+FQZ97Lxt09LX3Vz5BPZKNeLhiKZnrEqc5aTFUU40do8pnEF4wqwwAY2IlOcptVt/P0Dli/YEMx/BdPhbCXGuCIbrA1DEGaYiwAD3zVrJPdb1J6vqIRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286607; c=relaxed/simple;
	bh=RA4P+oQcj3vYUX71f7TDM9B8UHfY4GWfTDJxXDKPjeQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JuzkpTNrM7E4521SWyx4mGWgrihSATVnYvI0O62CcF+LF0+eo5Ren2d/32sa8WQl2sylBMWRJyiU1QtpVMXpUMUuUnsz8QiztStT2AtrnnJAoI4SsuHGuXQ9h3mH8PkUWURDUupX/em0me4B3vDYiZfqwrxp3UaL9F6jmN8rf7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=dqeqCziO; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756286564; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nvYYq+1uUMzNsugcosQytW7TefWCuoA6nJDCpz8Nwk26CX5SMmvRaxBGdXaMj7p2wTRkaaMd3B6aSisXbdP06djXE61RPwfhbuky+7WhjeNx7RHZhKKVroeZfcphE5tucM6yQGHcw9gnHCS8NjnLHrOCaKlo+/vCfO7jdat5WnY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756286564; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cepMxqe31sYhS3zxRITCN1TUDCwTfxDmEl9J9e/eKlY=; 
	b=YP0kyzZ+R5d3ijRIpjdG7px+7RCzNjINzlRvLHWD0yAkSvxh1/IXa1U1y8+lDjtJ7VX+c6QTAp3eD4DSUi6t8hTVgbpO24coxzsDuqjcw9gStiRo6q6CYjFpIrVIEtv6BW1eSrsIuNZn2c6zMVCYYHzxCFUpnj0uMYrIOkbD2IE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756286564;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=cepMxqe31sYhS3zxRITCN1TUDCwTfxDmEl9J9e/eKlY=;
	b=dqeqCziOQa+0ARnlNcf2Md3m2fX869bAqXZqfyTmvp/XuoPu5JtFb7eFHBax8Cyx
	eNSdkIaqvbZV0hn8BYNP0XzDy/r5P1M4KPCNMggSPHr4BAzhSxGgsGyiej8OGcsHzs5
	W52rujEkRPFVlxtl1QJmwdfSC7nrbVAhKWjowWqQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1756286562319324.87485774257095; Wed, 27 Aug 2025 02:22:42 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Wed, 27 Aug 2025 02:22:42 -0700 (PDT)
Date: Wed, 27 Aug 2025 13:22:42 +0400
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
	"Christian Brauner" <brauner@kernel.org>
Message-ID: <198ead62fff.fc7d206346787.2754614060206901867@zohomail.com>
In-Reply-To: <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
References: <20250321050114.GC1831@lst.de>
 <20250825182713.2469206-1-safinaskar@zohomail.com>
 <20250826075910.GA22903@lst.de>
 <a54ced51-280e-cc9d-38e4-5b592dd9e77b@winds.org> <6b77eda9-142e-44fa-9986-77ac0ed5382f@linux.alibaba.com>
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
Feedback-ID: rr08011227ec7073a703ffadd1c058ccf40000f7a76c4460ed5e02c74afc22b15c40a9cfbfca769482fcdf44:zu0801122795554f161c923eaa9e2c3bf30000a9843515b0da5356519e4e0028ac833545ef8695ba26975809:rf0801122b5a48a337bd55376ac829bbb10000f008c53306315767454786e22901052dbe60583c0d9e7b83b19dcefddd:ZohoMail

 ---- On Tue, 26 Aug 2025 19:32:34 +0400  Gao Xiang <hsiangkao@linux.alibaba.com> wrote --- 
 > I completely agree with that point. However, since EROFS is a
 > block-based filesystem (Thanks to strictly block alignment, meta(data)
 > can work efficiently on both block-addressed storage
 > devices and byte-addressed memory devices. Also if the fsblock size

As I said previously, just put your erofs image to initramfs
(or to disk) and then (in your initramfs init) create ramdisk out of it
or loop mount it (both ramdisks and loop devices are block devices).

This way you will have erofs on top of block device.

And you will not depend on initrd. (Again: I plan to remove initial ramdisk
support, not ramdisk support per se.)

-- 
Askar Safin
https://types.pl/@safinaskar


