Return-Path: <linux-fsdevel+bounces-75487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF3DEVacd2n0iwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:54:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981CB8B08F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC06F3083308
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273DB348452;
	Mon, 26 Jan 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="mI321WdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36965349B0F;
	Mon, 26 Jan 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446057; cv=none; b=SFBg2jmnFb5HSI7rPmwAexzD8lQiaJhJvfc0t8gRg7MoebvwFhwDscSdNsBhB4VUrcs9WC/gTxDZZFyhlv19u4dipvT1D932RzunIFBkdRKOGu609b/MDU2fMSnu9s/cCP33UXNYoTR3IuWYI7eaPl6TkYatGaOIDR8V/XMCQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446057; c=relaxed/simple;
	bh=ZXlEDo/g6nxMcchNZQF+SNFo2CnMNwUgdNVKQQ5GxEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EBczFyNnRmRcPT299cqZbGIN35qY0pif8pPssJJ3/bVyiFmBCPZIurPK2mWQQuI0Yc1b0a2srhBdGW/DJaCWtlV/o1KW2FKQrFFH7hbTYFCV6tbAibQt8dUi52Riv7XfjmXp250657Huv4rbTpkExTsHll6fMqgBa8Z5BnQM+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=mI321WdA; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1769446053; x=1800982053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=itJUHovmx8ThQnuXFjcLy1G60dRyIFRRQr44NmgQ9VQ=;
  b=mI321WdAFo+KMRXPJtUnPVSbqTxfMiU9hexlA+6c22cLS8I0EZ5xZkj+
   TpKC9gTvy1FpfZYfwx6OXYknverV2A4U+dq7ctwG3re+9v7/MQzPfSjeB
   IpqRxmsYLEoEsDh1hx7cQ2pSwfMN2QrtqwLLl3oPg8WgNrGhNlP7VAuGY
   nD5sq2rjCgAcLJefOSAp/zGzSZBuqU1yxIuWQSZBm9MVsZ2pxVfbz2QHB
   KHwLygYwmUDbFUUjKO8WUk2OsVewy4oElZuFg49ITlg3IQCq4S2L0HWXE
   ATRHU4GEC8P/5Mx/OS3i6GFj8rfXEXb+2d1jRRWPH6g9ys7uksDFCBj6D
   g==;
X-CSE-ConnectionGUID: mAl7W5q2Q9qKqPQn17E9NQ==
X-CSE-MsgGUID: vLAaNxp6S+iNE/SUHLTamA==
X-IronPort-AV: E=Sophos;i="6.21,255,1763424000"; 
   d="scan'208";a="8460917"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 16:47:12 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.233:20657]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.13.191:2525] with esmtp (Farcaster)
 id 7aedb640-8db8-4ae8-804d-436f487cb697; Mon, 26 Jan 2026 16:47:12 +0000 (UTC)
X-Farcaster-Flow-ID: 7aedb640-8db8-4ae8-804d-436f487cb697
Received: from EX19D005EUB002.ant.amazon.com (10.252.51.103) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 26 Jan 2026 16:47:12 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB002.ant.amazon.com (10.252.51.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 26 Jan 2026 16:47:11 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.035; Mon, 26 Jan 2026 16:47:11 +0000
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
Subject: [PATCH v10 02/15] set_memory: add folio_{zap,restore}_direct_map
 helpers
Thread-Topic: [PATCH v10 02/15] set_memory: add folio_{zap,restore}_direct_map
 helpers
Thread-Index: AQHcjuNqThDEVtMYx0OshrAVDnsQEg==
Date: Mon, 26 Jan 2026 16:47:11 +0000
Message-ID: <20260126164445.11867-3-kalyazin@amazon.com>
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
	TAGGED_FROM(0.00)[bounces-75487-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 981CB8B08F
X-Rspamd-Action: no action

From: Nikita Kalyazin <kalyazin@amazon.com>=0A=
=0A=
These allow guest_memfd to remove its memory from the direct map.=0A=
Only implement them for architectures that have direct map.=0A=
In folio_zap_direct_map(), flush TLB on architectures where=0A=
set_direct_map_valid_noflush() does not flush it internally.=0A=
=0A=
The new helpers need to be accessible to KVM on architectures that=0A=
support guest_memfd (x86 and arm64).  Since arm64 does not support=0A=
building KVM as a module, only export them on x86.=0A=
=0A=
Direct map removal gives guest_memfd the same protection that=0A=
memfd_secret does, such as hardening against Spectre-like attacks=0A=
through in-kernel gadgets.=0A=
=0A=
Reviewed-by: Ackerley Tng <ackerleytng@google.com>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 arch/arm64/include/asm/set_memory.h     |  2 ++=0A=
 arch/arm64/mm/pageattr.c                | 12 ++++++++++++=0A=
 arch/loongarch/include/asm/set_memory.h |  2 ++=0A=
 arch/loongarch/mm/pageattr.c            | 12 ++++++++++++=0A=
 arch/riscv/include/asm/set_memory.h     |  2 ++=0A=
 arch/riscv/mm/pageattr.c                | 12 ++++++++++++=0A=
 arch/s390/include/asm/set_memory.h      |  2 ++=0A=
 arch/s390/mm/pageattr.c                 | 12 ++++++++++++=0A=
 arch/x86/include/asm/set_memory.h       |  2 ++=0A=
 arch/x86/mm/pat/set_memory.c            | 20 ++++++++++++++++++++=0A=
 include/linux/set_memory.h              | 10 ++++++++++=0A=
 11 files changed, 88 insertions(+)=0A=
=0A=
diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/s=
et_memory.h=0A=
index c71a2a6812c4..49fd54f3c265 100644=0A=
--- a/arch/arm64/include/asm/set_memory.h=0A=
+++ b/arch/arm64/include/asm/set_memory.h=0A=
@@ -15,6 +15,8 @@ int set_direct_map_invalid_noflush(const void *addr);=0A=
 int set_direct_map_default_noflush(const void *addr);=0A=
 int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,=
=0A=
 				 bool valid);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 bool kernel_page_present(struct page *page);=0A=
 =0A=
 int set_memory_encrypted(unsigned long addr, int numpages);=0A=
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c=0A=
index e2bdc3c1f992..0b88b0344499 100644=0A=
--- a/arch/arm64/mm/pageattr.c=0A=
+++ b/arch/arm64/mm/pageattr.c=0A=
@@ -356,6 +356,18 @@ int set_direct_map_valid_noflush(const void *addr, uns=
igned long numpages,=0A=
 	return set_memory_valid((unsigned long)addr, numpages, valid);=0A=
 }=0A=
 =0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), false);=0A=
+}=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_DEBUG_PAGEALLOC=0A=
 /*=0A=
  * This is - apart from the return value - doing the same=0A=
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/inclu=
de/asm/set_memory.h=0A=
index 5e9b67b2fea1..1cdec6afe209 100644=0A=
--- a/arch/loongarch/include/asm/set_memory.h=0A=
+++ b/arch/loongarch/include/asm/set_memory.h=0A=
@@ -19,5 +19,7 @@ int set_direct_map_invalid_noflush(const void *addr);=0A=
 int set_direct_map_default_noflush(const void *addr);=0A=
 int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,=
=0A=
 				 bool valid);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 =0A=
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */=0A=
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c=0A=
index c1b2be915038..be397fddc991 100644=0A=
--- a/arch/loongarch/mm/pageattr.c=0A=
+++ b/arch/loongarch/mm/pageattr.c=0A=
@@ -235,3 +235,15 @@ int set_direct_map_valid_noflush(const void *addr, uns=
igned long numpages,=0A=
 =0A=
 	return __set_memory((unsigned long)addr, 1, set, clear);=0A=
 }=0A=
+=0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), false);=0A=
+}=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/s=
et_memory.h=0A=
index a87eabd7fc78..208755d9d45e 100644=0A=
--- a/arch/riscv/include/asm/set_memory.h=0A=
+++ b/arch/riscv/include/asm/set_memory.h=0A=
@@ -44,6 +44,8 @@ int set_direct_map_invalid_noflush(const void *addr);=0A=
 int set_direct_map_default_noflush(const void *addr);=0A=
 int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,=
=0A=
 				 bool valid);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 bool kernel_page_present(struct page *page);=0A=
 =0A=
 #endif /* __ASSEMBLER__ */=0A=
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c=0A=
index 0a457177a88c..9a8237658c48 100644=0A=
--- a/arch/riscv/mm/pageattr.c=0A=
+++ b/arch/riscv/mm/pageattr.c=0A=
@@ -402,6 +402,18 @@ int set_direct_map_valid_noflush(const void *addr, uns=
igned long numpages,=0A=
 	return __set_memory((unsigned long)addr, numpages, set, clear);=0A=
 }=0A=
 =0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), false);=0A=
+}=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_DEBUG_PAGEALLOC=0A=
 static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *=
data)=0A=
 {=0A=
diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set=
_memory.h=0A=
index 3e43c3c96e67..a51ff50df3ca 100644=0A=
--- a/arch/s390/include/asm/set_memory.h=0A=
+++ b/arch/s390/include/asm/set_memory.h=0A=
@@ -64,6 +64,8 @@ int set_direct_map_invalid_noflush(const void *addr);=0A=
 int set_direct_map_default_noflush(const void *addr);=0A=
 int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,=
=0A=
 				 bool valid);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 bool kernel_page_present(struct page *page);=0A=
 =0A=
 #endif=0A=
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c=0A=
index e231757bb0e0..f739fee0e110 100644=0A=
--- a/arch/s390/mm/pageattr.c=0A=
+++ b/arch/s390/mm/pageattr.c=0A=
@@ -413,6 +413,18 @@ int set_direct_map_valid_noflush(const void *addr, uns=
igned long numpages,=0A=
 	return __set_memory((unsigned long)addr, numpages, flags);=0A=
 }=0A=
 =0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), false);=0A=
+}=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
+=0A=
 bool kernel_page_present(struct page *page)=0A=
 {=0A=
 	unsigned long addr;=0A=
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_m=
emory.h=0A=
index f912191f0853..febbfbdc39df 100644=0A=
--- a/arch/x86/include/asm/set_memory.h=0A=
+++ b/arch/x86/include/asm/set_memory.h=0A=
@@ -91,6 +91,8 @@ int set_direct_map_invalid_noflush(const void *addr);=0A=
 int set_direct_map_default_noflush(const void *addr);=0A=
 int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,=
=0A=
 				 bool valid);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 bool kernel_page_present(struct page *page);=0A=
 =0A=
 extern int kernel_set_to_readonly;=0A=
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c=0A=
index bc8e1c23175b..4a5a3124a92d 100644=0A=
--- a/arch/x86/mm/pat/set_memory.c=0A=
+++ b/arch/x86/mm/pat/set_memory.c=0A=
@@ -2657,6 +2657,26 @@ int set_direct_map_valid_noflush(const void *addr, u=
nsigned long numpages,=0A=
 	return __set_pages_np(addr, numpages);=0A=
 }=0A=
 =0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	const void *addr =3D folio_address(folio);=0A=
+	int ret;=0A=
+=0A=
+	ret =3D set_direct_map_valid_noflush(addr, folio_nr_pages(folio), false);=
=0A=
+	flush_tlb_kernel_range((unsigned long)addr,=0A=
+			       (unsigned long)addr + folio_size(folio));=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+EXPORT_SYMBOL_FOR_MODULES(folio_zap_direct_map, "kvm");=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_address(folio),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
+EXPORT_SYMBOL_FOR_MODULES(folio_restore_direct_map, "kvm");=0A=
+=0A=
 #ifdef CONFIG_DEBUG_PAGEALLOC=0A=
 void __kernel_map_pages(struct page *page, int numpages, int enable)=0A=
 {=0A=
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h=0A=
index 1a2563f525fc..e2e6485f88db 100644=0A=
--- a/include/linux/set_memory.h=0A=
+++ b/include/linux/set_memory.h=0A=
@@ -41,6 +41,16 @@ static inline int set_direct_map_valid_noflush(const voi=
d *addr,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static inline int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static inline int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static inline bool kernel_page_present(struct page *page)=0A=
 {=0A=
 	return true;=0A=
-- =0A=
2.50.1=0A=
=0A=

