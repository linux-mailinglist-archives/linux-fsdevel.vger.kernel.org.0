Return-Path: <linux-fsdevel+bounces-21389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9B39035B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 10:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D79288DD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE517623E;
	Tue, 11 Jun 2024 08:19:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CB17334F;
	Tue, 11 Jun 2024 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093974; cv=none; b=B4dkQUDMbAwz5aCmau1V/WyCazr6JUG0HAmV6m+F0vFavn+KXqpgzET34Rr3QXmTIVky8EQJce5a7chWoMggZWxhwnvk0dA3OVdZtqDpgXRRwJCkk5NN1mB0yRrIa/qiQN2rU6Yr1tiN//h/EDKjxvI57gGVDnrt3c3ACa8KgIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093974; c=relaxed/simple;
	bh=WiwQcKXWFLbA5+y/XTxdB5b4DaXzfBJ3bVCq5x25wp4=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=fdCPRa4ERBCblAfBgsYsPjVnlLv5unc70hcQT+yr+GQoc5I989Cdxr3++ra5djVRCa6vFfeNuEKhNSPPuWAKa0NXsu9oLMnEb7YKVbZkllxLueraQ79HibDlqLQOhR73AGnxzDvpnkvILdN45IWRloAqPkzW5t6EmpP8io/6HJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9E2B561966AC;
	Tue, 11 Jun 2024 10:10:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id dq3ga0-vBU1s; Tue, 11 Jun 2024 10:10:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id CCB0B61966DF;
	Tue, 11 Jun 2024 10:10:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tf6HmT0i1hfW; Tue, 11 Jun 2024 10:10:05 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id A4C2761966AE;
	Tue, 11 Jun 2024 10:10:05 +0200 (CEST)
Date: Tue, 11 Jun 2024 10:10:05 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Message-ID: <259826832.217854.1718093405190.JavaMail.zimbra@nod.at>
Subject: [ANNOUNCE] Alpine Linux Persistence and Storage Summit 2024
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: uTc1ISVhQXOptDvYOEYQnAc9FxHE/A==
Thread-Topic: Alpine Linux Persistence and Storage Summit 2024

We proudly announce the 7th Alpine Linux Persistence and Storage Summit
(ALPSS), which will be held September 24th to 27th at the Lizumerhuette
(https://www.lizumer-huette.at/) in Austria.

The goal of this conference is to discuss the hot topics in Linux storage
and file systems, such as persistent memory, NVMe, zoned storage, and I/O
scheduling in a cool and relaxed setting with spectacular views in the
Austrian alps.

We plan to have a small selection of short and to the point talks with
lots of room for discussion in small groups, as well as ample downtime
to enjoy the surrounding.

Attendance is free except for the accommodation and food at the lodge
but the number of seats is strictly limited.  Cost for accommodation and
half pension is between 54 and 84 EUR depending on the room category
and membership in an alpine society.

If you are interested in attending please reserve a seat by mailing your
favorite topic(s) to:

        alpss-pc@penguingang.at

If you are interested in giving a short and crisp talk please also send
an abstract to the same address.

The Lizumerhuette is an Alpine Society lodge in a high alpine environment.
A hike of approximately 2 hours is required to the lodge, and no other
accommodations are available within walking distance.

Note that unlike the previous years reservations for the lodge are not
handled through the reservation system.

Check our website at https://www.alpss.at/ for more details.

Thank you on behalf of the program committee:

    Christoph Hellwig
    Johannes Thumshirn
    Richard Weinberger

