Return-Path: <linux-fsdevel+bounces-75488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFx0HYedd2n0iwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:59:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5198B2F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D4FC301E3C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D034BA44;
	Mon, 26 Jan 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="eyfm72wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B8A3491F1;
	Mon, 26 Jan 2026 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446086; cv=none; b=geeJkAvbLbwGgbyBGXPWSX6Rdg+8mtWmdsqVpJu+LULZ03pV2v841RDCWIdO8Znhun5FILexzxYv1wjP+ViFg0FXJCHXQX/FJ2sHrHKRq0d3oBBHySqgXR+D8NU0wp4PiSiV4fprHyaI41EvzlKKT3zB+YZZfM0UjezQB50Dy7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446086; c=relaxed/simple;
	bh=nOzNd+ou0+kQkYk8voAaEHRnC3+SIEE5CMRL1QMjvfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCE/5MtXL+T3w9Gha2JQO9TDqGYd1cLjxvsKUVPMzsopx+e1F4XX2JDrpqwZA0Ywi+KmES6qpvuR5eKnj5gijavGm395qPGMNV42V+6YoorDvlylS8TV1sTq66emgVW03O9pQuOmxlMnABnNAMfh/t9s2KdKLA86dHVlPTPZfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=eyfm72wk; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1769446082; x=1800982082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YLi/u5ebqRUc1ICzy4nCfhfttKcqfygi8VMYBxy2oh0=;
  b=eyfm72wkmPiPkDMcWGL2xE/8zTruGB/EpPYIn8/AMH0YgEFFoJfLRU79
   ox41Q3Hlr7CEihuKodmyW3ATk28nrm+bJqacXht0XoCIiLVvLMYZ9LpLV
   Vo5hcf4DPFI+bJHWkhBPNLZZlglFDIpPPT9Zh477Ad+pj+4t5HVe4DyLU
   0XP6kBzpFDEY/SyqnkthmJIJb3gcS42gNPI/fjFReHWeLI22kc4xhQD25
   wibFBkQFftMV0/7BhInxj0kJsYP3jcv9xLYbe4uPMvk9JQwEZQPlOv7lQ
   mxeVRBn4j/BXaKWb/LBuPA5Y5xs8hXRMt0HqMtiVdLWCf36Xg2N1jCejV
   g==;
X-CSE-ConnectionGUID: Yypu5wYxS1iHAL5CgyZSpg==
X-CSE-MsgGUID: YXLvk2c5Q/ikyAczP4JXTQ==
X-IronPort-AV: E=Sophos;i="6.21,255,1763424000"; 
   d="scan'208";a="8451277"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 16:47:40 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:28334]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.27.197:2525] with esmtp (Farcaster)
 id 2d375b96-55fb-45b3-87e1-96d636e6af0c; Mon, 26 Jan 2026 16:47:40 +0000 (UTC)
X-Farcaster-Flow-ID: 2d375b96-55fb-45b3-87e1-96d636e6af0c
Received: from EX19D005EUB001.ant.amazon.com (10.252.51.12) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 26 Jan 2026 16:47:34 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB001.ant.amazon.com (10.252.51.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 26 Jan 2026 16:47:34 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.035; Mon, 26 Jan 2026 16:47:34 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org"
	<willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"riel@surriel.com" <riel@surriel.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>,
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"prsampat@amd.com" <prsampat@amd.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com"
	<jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org"
	<pavel@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v10 04/15] mm/gup: drop local variable in
 gup_fast_folio_allowed
Thread-Topic: [PATCH v10 04/15] mm/gup: drop local variable in
 gup_fast_folio_allowed
Thread-Index: AQHcjuN4fOzeQZ4jRUG7KbJA7KTWHg==
Date: Mon, 26 Jan 2026 16:47:34 +0000
Message-ID: <20260126164445.11867-5-kalyazin@amazon.com>
References: <20260126164445.11867-1-kalyazin@amazon.com>
In-Reply-To: <20260126164445.11867-1-kalyazin@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.co.uk:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.co.uk,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.co.uk:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,amazon.co.uk,amazon.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.co.uk:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75488-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.co.uk:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalyazin@amazon.co.uk,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[104];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CF5198B2F6
X-Rspamd-Action: no action

From: Nikita Kalyazin <kalyazin@amazon.com>=0A=
=0A=
Move the check for pinning closer to where the result is used.=0A=
No functional changes.=0A=
=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 mm/gup.c | 19 ++++++++-----------=0A=
 1 file changed, 8 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/mm/gup.c b/mm/gup.c=0A=
index 9cad53acbc99..e72dacce3e34 100644=0A=
--- a/mm/gup.c=0A=
+++ b/mm/gup.c=0A=
@@ -2737,18 +2737,9 @@ EXPORT_SYMBOL(get_user_pages_unlocked);=0A=
  */=0A=
 static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags=
)=0A=
 {=0A=
-	bool reject_file_backed =3D false;=0A=
 	struct address_space *mapping;=0A=
 	unsigned long mapping_flags;=0A=
 =0A=
-	/*=0A=
-	 * If we aren't pinning then no problematic write can occur. A long term=
=0A=
-	 * pin is the most egregious case so this is the one we disallow.=0A=
-	 */=0A=
-	if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) =3D=3D=0A=
-	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))=0A=
-		reject_file_backed =3D true;=0A=
-=0A=
 	/* We hold a folio reference, so we can safely access folio fields. */=0A=
 	if (WARN_ON_ONCE(folio_test_slab(folio)))=0A=
 		return false;=0A=
@@ -2793,8 +2784,14 @@ static bool gup_fast_folio_allowed(struct folio *fol=
io, unsigned int flags)=0A=
 	 */=0A=
 	if (secretmem_mapping(mapping))=0A=
 		return false;=0A=
-	/* The only remaining allowed file system is shmem. */=0A=
-	return !reject_file_backed || shmem_mapping(mapping);=0A=
+=0A=
+	/*=0A=
+	 * If we aren't pinning then no problematic write can occur. A long term=
=0A=
+	 * pin is the most egregious case so this is the one we disallow.=0A=
+	 * Also check the only remaining allowed file system - shmem.=0A=
+	 */=0A=
+	return (flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) !=3D=0A=
+	    (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE) || shmem_mapping(mapping);=0A=
 }=0A=
 =0A=
 static void __maybe_unused gup_fast_undo_dev_pagemap(int *nr, int nr_start=
,=0A=
-- =0A=
2.50.1=0A=
=0A=

