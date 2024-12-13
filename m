Return-Path: <linux-fsdevel+bounces-37282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBED9F0AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 12:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5416B2832DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1931C3C10;
	Fri, 13 Dec 2024 11:18:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from arara2.ipen.br (arara2.ipen.br [200.136.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C1F1B414B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=200.136.52.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088683; cv=none; b=UmqB80UE9fSu232a+hPlZne/P+4NuCkO9fTJeYeQFqIu+mZBv4mfmGdqo2C4u9p5JTGxOYzfDpV7feNr8d/wrr9PlSAhlOaD7mGEGK8qxRCDTlXgJFzlYlXvKoXjfkrqCt+T9ldSjuJRaII3t3PNyDyaAnFEw7PNuxlwvVjQfOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088683; c=relaxed/simple;
	bh=Cgr97JBiSX1QIcd2ZZZsKVChGTY1ZlWJ/4AhaVFA7Wc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4CHekw0Wm+vlkAlSO4ghGRgK4DHVAq9xvuxJoVbn6k8H3LJn2YzXkNBVehmWS0586XRMOx6EEM/dK5lO48IiyHaFtC1LZrhMSJaJ2Hg7hwXIGbmtOTMgGxhyxz4FNImh2nfgJZTcBog7w7gFYxfPn9Xj4tPLm0oZYij1lxpIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipen.br; spf=pass smtp.mailfrom=ipen.br; arc=none smtp.client-ip=200.136.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ipen.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipen.br
X-ASG-Debug-ID: 1734088659-055fc729ec14b2cc0009-kl68QG
Received: from arara.ipen.br (webmail.ip.ipen.br [10.0.10.11]) by arara2.ipen.br with ESMTP id Z2S4BrApYzcN7cpm for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 08:17:57 -0300 (BRT)
X-Barracuda-Envelope-From: TCWM178585@ipen.br
X-Barracuda-RBL-Trusted-Forwarder: 10.0.10.11
Received: from ipen.br (unknown [102.129.145.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by arara.ipen.br (Postfix) with ESMTPSA id 396C9FBE3B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 01:24:32 -0300 (-03)
Reply-To: t.mazowieckie@mazowieckie.org
X-Barracuda-Effective-Source-IP: UNKNOWN[102.129.145.191]
X-Barracuda-Apparent-Source-IP: 102.129.145.191
X-Barracuda-RBL-IP: 102.129.145.191
From: <TCWM178585@ipen.br>
To: linux-fsdevel@vger.kernel.org
Subject:  I urge you to understand my viewpoint accurately.
Date: 13 Dec 2024 12:24:32 +0800
X-ASG-Orig-Subj: I urge you to understand my viewpoint accurately.
Message-ID: <20241213122432.20EC3D5A4A2E6568@ipen.br>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Barracuda-Connect: webmail.ip.ipen.br[10.0.10.11]
X-Barracuda-Start-Time: 1734088677
X-Barracuda-URL: https://10.40.40.18:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 512
X-Virus-Scanned: by bsmtpd at ipen.br
X-Barracuda-BRTS-Status: 1
X-Barracuda-BRTS-Evidence: 34fbb5788938ad5710ad28835fd12206-499-txt
X-Barracuda-Spam-Score: 1.11
X-Barracuda-Spam-Status: No, SCORE=1.11 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=DATE_IN_PAST_06_12, DATE_IN_PAST_06_12_2, NO_REAL_NAME
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.45577
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.00 NO_REAL_NAME           From: does not include a real name
	0.01 DATE_IN_PAST_06_12     Date: is 6 to 12 hours before Received: date
	1.10 DATE_IN_PAST_06_12_2   DATE_IN_PAST_06_12_2

I am Tomasz Chmielewski, a Portfolio Manager and Chartered=20
Financial Analyst affiliated with Iwoca Poland Sp. Z OO in=20
Poland. I have the privilege of working with distinguished=20
investors who are eager to support your company's current=20
initiatives, thereby broadening their investment portfolios. If=20
this proposal aligns with your interests, I invite you to=20
respond, and I will gladly share more information to assist you.

=20
Yours sincerely,=20
Tomasz Chmielewski Warsaw, Mazowieckie,
=20
Poland.

