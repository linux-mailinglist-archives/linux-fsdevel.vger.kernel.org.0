Return-Path: <linux-fsdevel+bounces-52277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C46AE10AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 03:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EE84A09BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18DD7404E;
	Fri, 20 Jun 2025 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="YPSmg/uw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640542A8B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382701; cv=none; b=n+nDCu434cHbwYuQqAg+A0NuIrcV/BYpafu0EdY9Rm2k9O8iPx2hw7VHLeyNRO78tic4OmEPNAE7Px76p8BWJkPZKbV+DgeOr7eB35hnKrepKTH8FHmik5MeTfWogssDA7KNY25OBTpoKb9KhR1vqENTo5cbQtuj4w0ZLR5BLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382701; c=relaxed/simple;
	bh=xXMlI7rpm3z9JLZGXMznkVZ0H27f9pBGFKN/B0zsoEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgKhy+YlZphLcjBzBkp0smTzOVbe7S4BGir6Dfyeyt5pRxWdyeFzDy16td0+heS187kg5XpGP6yp9NzqS9fGjLNjQIHIv4TKRnoXI4+ZGwpAKs4rzk9kftAaaHXEOqRDZvAQ6lVBJmsJpn/AAExUsxaZwcaglJiSAt07wgxd9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=YPSmg/uw; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JM0HAT021906
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=X46fh0ZZ1WeD/NYr5w40mQYpquA1g2f04LeJ0ONcmxE=;
 b=YPSmg/uwWqWtGNit0/X0eSqqIz7cpKxTTVyU2f1VKwLviwJL48VFuOSlEL6sul26oyw5
 Fx0oLE+3puaartKeVOcQ7NLQ92vPaDkREj/IhWjsyqYFFHGC/izDuMi9Qtq19vY5cSxq
 UHPqXFxY6HmjzoR8Lbg1YoQIwO48jZT7VRjHPq/ST6Y7kXuyONT75+rHfiufO/vJyEsn
 hxWHuvW6WcImCSfaeUHUFHiJTrt9Jnq8i/LG5e3szuYn0jPc0ntLyo1GPSXlMWP1bBBq
 mJaRKc23NmSEt3TjA610x5l2/tr3X3qi1qE9R7WGUDKw1EC/+sAnhsUxd4azXdbzfjhY vQ== 
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 479555ux8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:24:53 -0400
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d3eeab1223so166774085a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 18:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750382692; x=1750987492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X46fh0ZZ1WeD/NYr5w40mQYpquA1g2f04LeJ0ONcmxE=;
        b=CKDbkCv9327kjjOoNrjxmY7LbBibuTaoaLSxCpOYgr5BtDPkOOOsBkfZPp8REMgPag
         6eOguKDoY+TiHzZ/NFmjDoS9kT5Byvn9Afj1VUnStbh9chpfokqe9LEg97s33rx2kFOY
         46O/uPR0Qf4z2BYJqiQg8bZO83WI+yob5oCW9A1d72rELbwY92wzCJr3OYQLqVkz8Kru
         HRc61s7RknLM2eew7BKvu/exN4RKEa09ppeZm0srXgAVTA6DsUZ8CCkEsOZVxMH1iBlE
         s8gKUgCLiNb/09xPADyjoZ4R6IRWlOBQ6KS2QaxEYcrsCZCJAT4jikHaDv9sTaQGzlAn
         olOA==
X-Forwarded-Encrypted: i=1; AJvYcCW8zNLavR0RlGmCJbPvP/ss1Lmj5A/5Ss3nh4Bq0m9h0ZSOSt9/SrPbHUqVBlJIqlvwf8EscfCXdHsdCfad@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Nj4Ht3RsL/qYMW9BGWnWy8SpPzwKvc8titDREClLZJS/k47A
	Qt2ZLaqrQUs40uA8//lwhJp+SolxGMnyttKXEguj1QrV6qpEZOIirAfQ7JLk9mgqBVW6G2SEj6c
	TQmypoS7sADT/p/y82hggTCgKoy2HSbuOz5xIk2VgLplc/o+bUYd720XzrKAPWmE=
X-Gm-Gg: ASbGnctunnlx0iaLGQ8EIwmUdvGbu7NKCrfp/UAvsR+U1FOUpyVytU0VS4gAu8cm8pY
	ct3NWWdL6nLutsVSFMSMWQPE+bptKwTihluqyczH3KsG8lasPb9Mo+V4jD8iSAlvNlf9YaZ67qh
	I4cz3lysEEjvlvVV2cYJfaWqhu9Pkq5XQAlzFmhK1Af/M8KA9TqB/2XFRIz2QQfZYcNCzqKRqK2
	aiXIFh/8cSdr9ERLIPb2IpFM//yZUlZT8MRlzRyctiTWZEQX0y9OYsviTJWCwjevwjpjZTNZ54+
	wQlwi0TZQUHxp5p0oP4F3lABfPn9FQ4a5nntz0dAMz33eyDI99q/HPqQ5w3ott2QyRuC
X-Received: by 2002:a05:620a:198e:b0:7d3:a7d9:1120 with SMTP id af79cd13be357-7d3fc06b8d5mr63537885a.24.1750382691966;
        Thu, 19 Jun 2025 18:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJKSrSBgQ4uBVzQlMagjxckiiQ/tQxOZmwuAqKpCEwLsdmkXuPSybt+Cb06ko5l86V7nuVZQ==
X-Received: by 2002:a05:620a:198e:b0:7d3:a7d9:1120 with SMTP id af79cd13be357-7d3fc06b8d5mr63533785a.24.1750382690971;
        Thu, 19 Jun 2025 18:24:50 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e79c12sm3794321cf.53.2025.06.19.18.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 18:24:50 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 19 Jun 2025 21:24:24 -0400
Subject: [PATCH v3 2/4] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-uffd-fixes-v3-2-a7274d3bd5e4@columbia.edu>
References: <20250619-uffd-fixes-v3-0-a7274d3bd5e4@columbia.edu>
In-Reply-To: <20250619-uffd-fixes-v3-0-a7274d3bd5e4@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750382688; l=2822;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=xXMlI7rpm3z9JLZGXMznkVZ0H27f9pBGFKN/B0zsoEE=;
 b=WzhBLDQrXcUIUlBCP8qTicibv+pXurkXgBplDu92U7x22Aj1+3bJyvMaG1h7d35DYp/eDYzJj
 iqoX7qrPiMQAmBmnvAIOMBdt+sMK+Un6Ig5Keny2IykvItTmx9ZCkVg
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAwOCBTYWx0ZWRfX6uHjb04R8SgM Wte17hN/Y8pPsg7vZZgr9CNWDxoRYv81N9/9GTY+OvvYmpDIIDp1hwN+wAYdTeMwLqtcQJ5JG0q G4FrwQrSeVJFvik6rQ7RRerUZy2BpVi4RPMeLUnxaYlBY7A6+Viu85LM+TBcbRqmVKLTp/VD6kK
 KKYxp5TuKCCXsb0MDEAk9L5O0lcxeav4jIt04jdjiKt5DICEqLpVNkL1RI9Y7676PTcUqeJh5Mp vcKOKzUUhp3tk4L4ykikV7t0RG5466MiJMTLIZYIZekGlFuoJGJNv3bq7viTuMsei93HMJ9dJsz 4i0lesg4jR4EilYaly9hpQdHUCb8LIkkjVwZHQimiOkUUyzBOVJ0fWPY+zvaZHUPnR2W3KDCg4j /jz+81ZB
X-Proofpoint-GUID: 7J6b5KX3gqCiON9x7Evr1SuNmbU85zEb
X-Proofpoint-ORIG-GUID: 7J6b5KX3gqCiON9x7Evr1SuNmbU85zEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_08,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=10 phishscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=10 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506200008

Currently, a VMA registered with a uffd can be unregistered through a
different uffd associated with the same mm_struct.

The existing behavior is slightly broken and may incorrectly reject
unregistering some VMAs due to the following check:

	if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
		goto out_unlock;

where wp_async is derived from ctx, not from cur. For example, a
file-backed VMA registered with wp_async enabled and UFFD_WP mode cannot
be unregistered through a uffd that does not have wp_async enabled.

Rather than fix this and maintain this odd behavior, make unregistration
stricter by requiring VMAs to be unregistered through the same uffd they
were registered with. Additionally, reorder the BUG() checks to avoid
the aforementioned wp_async issue in them. Convert the existing check to
VM_WARN_ON_ONCE() as BUG_ON() is deprecated.

This change slightly modifies the ABI. It should not be backported to
-stable. It is expected that no one depends on this behavior, and no
such cases are known.

While at it, correct the comment for the no userfaultfd case. This seems to
be a copy-paste artifact from the analogous userfaultfd_register() check.

Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/userfaultfd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 22f4bf956ba1..8e7fb2a7a6aa 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1467,6 +1467,14 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
 		       !!(cur->vm_flags & __VM_UFFD_FLAGS));
 
+		/*
+		 * Prevent unregistering through a different userfaultfd than
+		 * the one used for registration.
+		 */
+		if (cur->vm_userfaultfd_ctx.ctx &&
+		    cur->vm_userfaultfd_ctx.ctx != ctx)
+			goto out_unlock;
+
 		/*
 		 * Check not compatible vmas, not strictly required
 		 * here as not compatible vmas cannot have an
@@ -1490,15 +1498,12 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
-
-		/*
-		 * Nothing to do: this vma is already registered into this
-		 * userfaultfd and with the right tracking mode too.
-		 */
+		/* VMA not registered with userfaultfd. */
 		if (!vma->vm_userfaultfd_ctx.ctx)
 			goto skip;
 
+		VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx != ctx);
+		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vma->vm_flags, wp_async));
 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		if (vma->vm_start > start)

-- 
2.39.5


