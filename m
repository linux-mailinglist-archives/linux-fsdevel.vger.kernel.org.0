Return-Path: <linux-fsdevel+bounces-66664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B2FC27E3B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 13:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87775347AF7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 12:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835152C1593;
	Sat,  1 Nov 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JhzwNVNg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CD54763;
	Sat,  1 Nov 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000983; cv=none; b=cbloSbnNqiBG5CDvBpmPt0vrTJB5361cxgt0dIQZC4PFbOLpbxCQK6V6DP/VU0zdPNLmHZeiySStSY2DQT//t41MtqApIFEmabtebifOhN3rFxGR/MIq32z3mSOgTUN6YH8rnBDT7oGfy8lQfCdrT6ra2IWnVH/QJqcRo4nA+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000983; c=relaxed/simple;
	bh=rDtsQXGPyMLri87V0fvSXcf2oqKNzDo7OvfiTltv6ro=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FVeAAGc3UykIQpDT/FXrjj/4u1miDVbXgU003hA58uWwBn2iduSr3K8q29n5By8kxLDeowrJiNsWNdtKztDBrbVFCPq+Xgt5Jl6aeux6wFZ2NrC7EiCCzK1t8SZ2K5ea5d5rFJY1ql7zUH+04jJwr6M3VWWmYgTz2PVcL+6+XgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JhzwNVNg; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762000978; x=1762605778; i=markus.elfring@web.de;
	bh=rDtsQXGPyMLri87V0fvSXcf2oqKNzDo7OvfiTltv6ro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JhzwNVNgzDdKb/1kP/OR1L2PZTA12KYum1+Ovkol3O1zN6RYV9ScvGlNMGIE/ZW1
	 9RfX7y77ZGW9DK0grnAP5flb+MAHMsa3Gf/RcbbOMNYsNFyCr/WNxAP+LAMdxjyBr
	 QwK3SyhdEjjnIw+ga2dGvYVWdCweqDK+mAkHK932qtItR5hJvKkrXBB/DVr+eQq6K
	 I3nB8JvAMIIpaOrGxHd2aIGG8GvIBueEw9+Gg97U+1mNaGqyjS+yptkmJK7vM4QTb
	 u4pwcnsNlDN7+p6qBYTbzmRdGwNOwfeq33lI4UazEFz+MJFZUaUZgBHhIExufux72
	 Sh8WC35W3soAVERriQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.236]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdwNg-1vmrrw17EE-00m324; Sat, 01
 Nov 2025 13:42:58 +0100
Message-ID: <52e58416-d75f-4a47-9555-88a99d664069@web.de>
Date: Sat, 1 Nov 2025 13:42:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [RFC] Detecting missing null pointer checks after memory allocations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:USpDIOU0dB69LNgSEuPV+jqgMgPhiPW/CQZU2wUaho32lyC9gb8
 8BfwJ1stb/PuC4N4H2n7PIXywLp1Udx+r4wmkCc7A7pT9/OK1qMXb0GovaQwO7X8kFpAWs8
 ikf4OkirxDbRVn/84FolhHaIGT113Gq3N+LgzcEklLV5CicQJ76UCxEx1b9ebtZCPKw0aWd
 6DGB/52MgUGBzgmzqzqMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OpkVSMgbTHY=;tXi1eEEwrei+L3SYvaA062S2L9l
 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
 HCKx1/bG8gZHXfTAG3JHNj3OR/BPASWWSqA=

Hello,

I got into the mood to try another simple source code search out which
can be achieved also by the means of the semantic patch language.

@display@
expression size, source, target;
@@
 target =3D
(
*kmalloc
|
*vmalloc
|
*malloc
)(...);
 memcpy(target, source, size);


It can be determined then from the generated diff file that mentioned
implementation details can be found at 11 places (4 source files) of
the software =E2=80=9CLinux next-20251031=E2=80=9D.
Will such analysis information trigger further collateral evolution?

Regards,
Markus

