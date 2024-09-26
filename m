Return-Path: <linux-fsdevel+bounces-30141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15361986EAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 10:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45D361C20D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280A1A76BE;
	Thu, 26 Sep 2024 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qMNIH1KY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7821A704B;
	Thu, 26 Sep 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338857; cv=none; b=nJdHB4Y103F+7XUf2EpiOGnpxNeZ1s0gXYQzoKsnCchg2q1hibW3CJFgxOPTo1/hvrNqv3c+5yginmfs4cTzaDe2M6jDOdAFyjRVm8LMJV6OPXyzJINHPUZyjCrGbIWILcj+2F+VGKK2E4A40BKa30FxQvsBGW7Q4a3kZ2rhaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338857; c=relaxed/simple;
	bh=DDb8C4BtA74QmAAeFYR18zjm0Ie12PG4cmEwax1hWiU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jPwo8MrNcXTePa//P3azonKN2EPgSwnUt4gV+tnO63QkBETRTo8D5/OP91OmaaJHjXU0N9oL20oRqrt/J45gr8faCS9MI1BKNmw6BNTqenum3BCXxvL53v4IRTkYSVogEjRs5CrfpzvSU4ML3KQbt+K2ESwX0nN6Vww7v94OvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qMNIH1KY; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727338835; x=1727943635; i=markus.elfring@web.de;
	bh=sB6yRJmW44vEhF2xRcb8ZnnullLqQ80g/LRUvvWZUBI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qMNIH1KYHG4V1vMq2T5N5iZJZ5T9lVw3VZiGEFENegvVz2QjRlad1CbDtqDsP4Uj
	 rcAZ0SOUnPPvv8/K20XlA+GfR4gelgcPsvwqUTy06Iwl9yqrPI+LiNmCq1Aaq8HVB
	 +XWNMOIzah7rFcLkEu8bdBE38b5DeDS44ixHmPGYDekbw41gfof7yZnutyMoPKSr6
	 u0IcKspa10DAtNP6xoVqYzOJjcJsKstAcNiHIf7IEOKMxC8sEk4TL5KICNZbngLPa
	 yDFJpA37wqS31XwgIhr2OuJEhMGw6H35aYJZlQu6T+Lc/hl+NxfjcytF44ZkX6eHq
	 /UfUlxGqo0cK9+PSQQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBRn-1sEt8g3Lt7-00hh4G; Thu, 26
 Sep 2024 10:20:35 +0200
Message-ID: <7be4c6d7-4da1-43bb-b081-522a8339fd99@web.de>
Date: Thu, 26 Sep 2024 10:20:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Joel Granados <j.granados@samsung.com>, Kees Cook <kees@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] sysctl: Reduce dput(child) calls in proc_sys_fill_cache()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O2kMMIfoFcVsourDbG7GiTIPrn1lHkbfbdxpYI2Z95rvexXu6jo
 A5EfaFwEeN13eC+KfCcuhXKPGkvyJH7xHixhBFHoE0aXTE+Rx9HaO6vj5+HS/w/QqhaDeaP
 5eTmV/90y8PQgKPXTMNi86Kssr5cr4e9NeqslS3UQbla8EjduvGMfXMRWYzjD6E/kemsdqG
 pj2iki9WUimK8CXzzB0+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9YxArM8zdCI=;hfdzJK4Klm1i6lAuyUUQoOXp45f
 nLrhDEPkFOPR4RWLTV6hruoiE81rOLem0Z1vfYOzcmPyK71ncngCxHj//tU4Akn6y6s6/E9I5
 RiQMaSNJTiNEwgwwVmdyyPJfZJlwCv9lWOMvRUEz0G3E9LWaiZD6BrNnYnJADSTDZzuvlTySH
 FYkHaVGSe7e1Evy+HN6JBYIleh/rTQX4fAY9LAXGRKZoYTt3zjnAjeOVXFuP5krI7oGFnRMrC
 yJVhJR7XB2FoUwo/FXFKjQx/WNuIG4NtArDqG4LD6X8qAOVfZGrxf+x8U43sYFtFh1ZBzbVt7
 4D+OmWot0c4Od60kIRDCwSx3dTv4uZKHnX/2+g1gpwVkxk1PdaCelViCEe6S772GBKbkRA7Z7
 +T856hSX2aXM/mS+kT6PZzcgl35swtmK9LiFnjDItlvhGZgWbB39dymT880x2L2yvMXn2TMrK
 I0YbwoOiqat583O2f4vVrVoFU0wxjmrkVoK5a/vC2RxdMtVEicN87WPu5hBjxbDm6uDWGthdx
 P3VUtgnmsdQhrUmXXqMHqeBQpugoh6d48EzSHt17Si9BX9e3HaX2y10/hg0Z+DlZkuOymbe8N
 f0aCEV0EWjnCQ6L3etwetN3MzRv9gB0jlIO5BtgujrXIaN9qSQI9d0cMTvEZox0chGcLAs9yh
 cfhzNB+0XsQBxxTu+bt55zyPmiqOuQzc4x/nJv3mdBlVBedTDboeI3cJIC/cdUzX9Up3uMkoS
 cHa0BHiINvtCVXimk9Dv3Xb2czJ4iR64iElqwfJFjtyYZg9VDN857dgf95nwDzMy7BBR1zm9l
 Hr06K9n8pwuIJfpHwURNChbQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2024 10:10:33 +0200

A dput(child) call was immediately used after an error pointer check
for a d_splice_alias() call in this function implementation.
Thus call such a function instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/proc/proc_sysctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d11ebc055ce0..97547de58218 100644
=2D-- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -698,11 +698,11 @@ static bool proc_sys_fill_cache(struct file *file,
 			res =3D d_splice_alias(inode, child);
 			d_lookup_done(child);
 			if (unlikely(res)) {
-				if (IS_ERR(res)) {
-					dput(child);
-					return false;
-				}
 				dput(child);
+
+				if (IS_ERR(res))
+					return false;
+
 				child =3D res;
 			}
 		}
=2D-
2.46.1


