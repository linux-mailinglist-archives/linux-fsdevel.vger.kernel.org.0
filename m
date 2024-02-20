Return-Path: <linux-fsdevel+bounces-12110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C297885B593
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EF21C22732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725375DF3B;
	Tue, 20 Feb 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vexlyvector.com header.i=@vexlyvector.com header.b="jvN6w1AQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.vexlyvector.com (mail.vexlyvector.com [141.95.160.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9F5DF14
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.160.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418454; cv=none; b=oG3MOTh+APoJrxEEz21GJHSZuiFyd9lKsZlqujkOoPogmoEG+AJdgu6xhuxuhWZdwZvvXSdbUGqNxBhAFvXVEDpx0FTOIBcxnVDXC/SKr/bGS9kjosb/u6qp12Oa5SdBEzH6cy1OUTI9bU9er/QNuBd8gLiTCfSTnZlUGlTX66c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418454; c=relaxed/simple;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=OaTqc19uu/zDzbI2qZ8FVNGxl53uG+GMO4Ha/QUYaca2kxSB/WTH0YJW0kaS4TasUAu2AFzBVk4x5eFfJCjY4G24zktWNxKQHNxR6/yEX0q2ClD+qN/JzwndWtNlWWsDtVZBJNDkt1uBu+eGpOWD7HRrd/wrXBfPtwyojNRQU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vexlyvector.com; spf=pass smtp.mailfrom=vexlyvector.com; dkim=pass (2048-bit key) header.d=vexlyvector.com header.i=@vexlyvector.com header.b=jvN6w1AQ; arc=none smtp.client-ip=141.95.160.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vexlyvector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vexlyvector.com
Received: by mail.vexlyvector.com (Postfix, from userid 1002)
	id 0FB0BA2CE4; Tue, 20 Feb 2024 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexlyvector.com;
	s=mail; t=1708418450;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Date:From:To:Subject:From;
	b=jvN6w1AQeTRW2bbxa6I+GcaWW1BL8lfhATwDcSFWHL9iF/9djPUFy7Aw/6Lrz5Mcc
	 14qCfXiz38mmDiCtcjUFEmDK8PFh1Q5mRGvFSxFVaTbxtrgD/sJOE2f8XkQUm1wkkI
	 DWEbVY/SjI1cppI05jKtDS5wOmKdqIdB7NXf+q5dNOdbLpC2g5A159v0a6Yc0p4oo9
	 GDpcbWX8xoWcq13VpP1iiru+Ehn97bjQpWTUtTwH2hCrEEByPzsMlE7YNJ6RCU11nJ
	 eXK05WeZTTqnDSa/RmhHY+w32zvLTr/fT247tYQtl6Cy7eGjCNpx1z2Fmsh36waD7U
	 C0soPDRCzcObw==
Received: by mail.vexlyvector.com for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 08:40:41 GMT
Message-ID: <20240220074500-0.1.c4.qcle.0.ahaj24zrp8@vexlyvector.com>
Date: Tue, 20 Feb 2024 08:40:41 GMT
From: "Ray Galt" <ray.galt@vexlyvector.com>
To: <linux-fsdevel@vger.kernel.org>
Subject: Meeting with the Development Team
X-Mailer: mail.vexlyvector.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to reach out to the decision-maker in the IT environment wit=
hin your company.

We are a well-established digital agency in the European market. Our solu=
tions eliminate the need to build and maintain in-house IT and programmin=
g departments, hire interface designers, or employ user experience specia=
lists.

We take responsibility for IT functions while simultaneously reducing the=
 costs of maintenance. We provide support that ensures access to high-qua=
lity specialists and continuous maintenance of efficient hardware and sof=
tware infrastructure.

Companies that thrive are those that leverage market opportunities faster=
 than their competitors. Guided by this principle, we support gaining a c=
ompetitive advantage by providing comprehensive IT support.

May I present what we can do for you?


Best regards
Ray Galt

