Return-Path: <linux-fsdevel+bounces-7014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707D881FE2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 09:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4B1F21767
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E43B79EF;
	Fri, 29 Dec 2023 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vrKqCjdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EC7487;
	Fri, 29 Dec 2023 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703838883; x=1704443683; i=markus.elfring@web.de;
	bh=Rd9blyw8YSGBTPzYlKen2IAboPPNyjav2zaAADiVhFk=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=vrKqCjdEGXXAYVio+EPvrIc9l4Eiq33ZRhQfxoqTeBsdtl3LvFQBUEEduKKk+WMN
	 9jTMfqCitFEvet+zeW4uSR2nvbNOWecI5xFldMA46nhlAINtNI6wDwZFNQl/UqjS/
	 XemCXdJs6fAOZDLXNQWaa0YkQgn0FJG1J3Kl59WaPoqDID2wkfThP+zcT1WeF69o/
	 cnZkL0rocAxuZYuA3rklOt65djFY2IEdabHaDqNNF+jab6yKDv2hSREEr+n40b3F3
	 Td5QRDug25y0iGIUT2O2O3qcIo7kyqRNl8Hje19oIdyu+NKGDIMpmi9FtqNG15bKd
	 dtUXtbmn1bar9v1FWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXZf-1rRhAG01fn-009alK; Fri, 29
 Dec 2023 09:34:43 +0100
Message-ID: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
Date: Fri, 29 Dec 2023 09:34:32 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] virtiofs: Adjustments for two function implementations
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YarFuQXl4Lg4zqIhzbNfiS9AhDDsTY/3rsdJpMImfKl/sZf9NNP
 4swOTI3Fx/OksKHKHA4D+uL4yfdgeAjsMEZdKOctlQBDBVcpMaPgEi3vsS1lePZ0fUOaU2z
 hYffU8OEZFqdjUrHLGYint17QxBxIKAw5fkBKte549eb+i+1nu16QLj96rPoBYRWetzYy9j
 Qh7c/1SI2Todq/BDFh1LQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qv+ZKPX4/fw=;QxllQUETTtbPJ5zMHoYOYVlG5J8
 BZn/Jx2Vs89rtI/m6H+ImUxQJLvDrjU/YkHy0ZMKd9AWwS94h25GUekQJmukbgkZoWe2mx42h
 s6G1OE5PzgxGi/MYaBtalA5jLxQ93G/5Xdyrhi86fiKbom0g50n0Kqpk75tqfABEyqg3Dy7yR
 RJ9mwwceU3ZwNOLcXZKuKFxtLVhnYwJm3bt27iCac1Auu8RSyC4TXNiJbNB+iMcY9kC1NEnkl
 JVJS5Es7+Icn1ptBsuGflgzpeZdKfxAy417GU4OK7+f2pC4g+hvR/G+6olkQXEce6aCgHLjDt
 tkW1ka0ZmblN4Ankg8XiCoCejid68TseePx7rNV0w+2f9+senbVmhbwS2UtE9+XPFdIQwzrQW
 tuCRtTKQqE7N6mBd7Kl9dyeTGVLYEePUXMNLkBik8nakiuojMvfZ3kePeA+YjsO5L4LPfg7dF
 E5g8rxl4t5b9OLEq7Uyfkf0emgXGCDIfwX+SpSynsoLOVDFDSPjMiKBb2hws0uZbyFNlOuaET
 rlHXHP/L4ZZGLucQAmWB1W/Vy1cPxQAKE6q8acKaIAp7rbSUPM3YR83pGV/Q244JQCYeUlo9x
 AbWXaYaqNGzEB14BZoydKreOCvnC+/lTTrNPoX0daDsaD1y/1e8thuuV6zsVvlOggS8F2h14W
 zqVK86SgMlp022bNxf+gjEbTyzOS6yYr6z98f8Zfd6SoK4vewBg0Ix8AA0nkgtFv4TsDq3RL5
 mKJyl2bd+w0a3MXRkPGPX0KiTCVrVayAox9LKBnrrLaPBAi1cmyOCdnkhzRAfcNx9q1i7rVjS
 q2hmX/qhVwygnc02kFHu+wuMtGp7IJDtGaRWhzraHZ1EeaG9tH/Kdg68Ku9IPdmrDPyL72mvI
 yFgpxwgaPyUL67+WYQcMg8Ca45Fuk4xGeGV35LWPa6KEdmRl2BLSakpduu9RMapwCTNHpPwR6
 QBJ+3w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 09:28:09 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve three size determinations
  Improve error handling in virtio_fs_get_tree()

 fs/fuse/virtio_fs.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

=2D-
2.43.0


