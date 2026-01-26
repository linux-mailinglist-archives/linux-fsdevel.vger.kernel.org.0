Return-Path: <linux-fsdevel+bounces-75493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAtFCg6dd2n0iwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:57:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7068E8B223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58A63319434C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D2349AE3;
	Mon, 26 Jan 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="dQpj0CBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F82FE595;
	Mon, 26 Jan 2026 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446260; cv=none; b=HaCS427Pqx0sEbwt6+Oajw3+VIkuo+kRhziVdgYL1bF4HF5x31EI0k8ArRlCGzoCMBoQv1yiTqc6R786WUOon03YG3ijSRr0+9a1+MllbOO5GkKphr/uHIS580UBwB9CSHVRYFiL98e2HA9yWntEbJkRAEgeVaQ58riu4Mlm97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446260; c=relaxed/simple;
	bh=AqPWg1yl6fKuwh/0GgtzzyL5mH5AqPD+lRelnnc1+34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJUr5WS4X1KMkTqrXNBjj8cRl+CZnZpB5zYtgmpCyTDgW7kYghS68SEtjIpP3/Z7vsH/HuyPBYe+99J8/XL79HztKTIqbDzKoSMBGaH22qMeSmlb3vBjMHpwwRvZCak2K8lPUSO2pt+Xzb8SA9ml1DcS8jSO7cdwssJsPJLc/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=dQpj0CBp; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1769446257; x=1800982257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9a6RXrMzpCzxek9CSTM08UtDf5Ra4XlNp32KqLM5w2E=;
  b=dQpj0CBpzMafrrpXfh3rxd55sUM2jlZhq41jQjg8NpBRFFacMk8ai12V
   gGt1YnJ+qsfpVqseAuo+eLg5e0DCTQw8GynOSQuBwK6lx5zf+CtGczKsw
   S2EOqxN5DDrGDaIA7Thda+OFZ4wwMXKW/7RnjeFVI6bTzQvVbu+WmkfVx
   wEy9KDrPKyVb3JdaOUisbZuoFDXG3/AI6uiRbz7ga1+CzepCLpZ2RrPnz
   iR4tE3vXhKuq72XNHP9CqFDATzAGlJ4m36EV1V9jARdY1QqxXF712FzBF
   +0GdWr4f8theWE/m0qxuBpu6NNHaSaoshq0KUx9BIO6vg5kPRLYC8Xkj9
   A==;
X-CSE-ConnectionGUID: IvvwnfIaQ5KEEhbZrctTpQ==
X-CSE-MsgGUID: U6KUDHzFSE+7DDhbDNzXlQ==
X-IronPort-AV: E=Sophos;i="6.21,255,1763424000"; 
   d="scan'208";a="8333976"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 16:50:38 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.236:23530]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.12.85:2525] with esmtp (Farcaster)
 id b854d7ff-d99c-47ae-a4c7-1097de342aa5; Mon, 26 Jan 2026 16:50:37 +0000 (UTC)
X-Farcaster-Flow-ID: b854d7ff-d99c-47ae-a4c7-1097de342aa5
Received: from EX19D005EUB001.ant.amazon.com (10.252.51.12) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 26 Jan 2026 16:50:33 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB001.ant.amazon.com (10.252.51.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Mon, 26 Jan 2026 16:50:32 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.035; Mon, 26 Jan 2026 16:50:32 +0000
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
Subject: [PATCH v10 09/15] KVM: guest_memfd: Add flag to remove from direct
 map
Thread-Topic: [PATCH v10 09/15] KVM: guest_memfd: Add flag to remove from
 direct map
Thread-Index: AQHcjuPiYN714BESrke/GtjGZ2rB2A==
Date: Mon, 26 Jan 2026 16:50:32 +0000
Message-ID: <20260126164445.11867-10-kalyazin@amazon.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.co.uk:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.cz,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,ghiti.fr,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,amazon.co.uk,amazon.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,amazon.co.uk:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75493-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.co.uk:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 7068E8B223
X-Rspamd-Action: no action

From: Patrick Roy <patrick.roy@linux.dev>=0A=
=0A=
Add GUEST_MEMFD_FLAG_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD()=0A=
ioctl. When set, guest_memfd folios will be removed from the direct map=0A=
after preparation, with direct map entries only restored when the folios=0A=
are freed.=0A=
=0A=
To ensure these folios do not end up in places where the kernel cannot=0A=
deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct=0A=
address_space if GUEST_MEMFD_FLAG_NO_DIRECT_MAP is requested.=0A=
=0A=
Note that this flag causes removal of direct map entries for all=0A=
guest_memfd folios independent of whether they are "shared" or "private"=0A=
(although current guest_memfd only supports either all folios in the=0A=
"shared" state, or all folios in the "private" state if=0A=
GUEST_MEMFD_FLAG_MMAP is not set). The usecase for removing direct map=0A=
entries of also the shared parts of guest_memfd are a special type of=0A=
non-CoCo VM where, host userspace is trusted to have access to all of=0A=
guest memory, but where Spectre-style transient execution attacks=0A=
through the host kernel's direct map should still be mitigated.  In this=0A=
setup, KVM retains access to guest memory via userspace mappings of=0A=
guest_memfd, which are reflected back into KVM's memslots via=0A=
userspace_addr. This is needed for things like MMIO emulation on x86_64=0A=
to work.=0A=
=0A=
Direct map entries are zapped right before guest or userspace mappings=0A=
of gmem folios are set up, e.g. in kvm_gmem_fault_user_mapping() or=0A=
kvm_gmem_get_pfn() [called from the KVM MMU code]. The only place where=0A=
a gmem folio can be allocated without being mapped anywhere is=0A=
kvm_gmem_populate(), where handling potential failures of direct map=0A=
removal is not possible (by the time direct map removal is attempted,=0A=
the folio is already marked as prepared, meaning attempting to re-try=0A=
kvm_gmem_populate() would just result in -EEXIST without fixing up the=0A=
direct map state). These folios are then removed form the direct map=0A=
upon kvm_gmem_get_pfn(), e.g. when they are mapped into the guest later.=0A=
=0A=
Signed-off-by: Patrick Roy <patrick.roy@linux.dev>=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 Documentation/virt/kvm/api.rst  | 21 +++++----=0A=
 arch/x86/include/asm/kvm_host.h |  5 +--=0A=
 arch/x86/kvm/x86.c              |  5 +++=0A=
 include/linux/kvm_host.h        | 12 +++++=0A=
 include/uapi/linux/kvm.h        |  1 +=0A=
 virt/kvm/guest_memfd.c          | 80 ++++++++++++++++++++++++++++++---=0A=
 6 files changed, 106 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rs=
t=0A=
index 01a3abef8abb..c5ee43904bca 100644=0A=
--- a/Documentation/virt/kvm/api.rst=0A=
+++ b/Documentation/virt/kvm/api.rst=0A=
@@ -6440,15 +6440,18 @@ a single guest_memfd file, but the bound ranges mus=
t not overlap).=0A=
 The capability KVM_CAP_GUEST_MEMFD_FLAGS enumerates the `flags` that can b=
e=0A=
 specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:=0A=
 =0A=
-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
-  GUEST_MEMFD_FLAG_MMAP        Enable using mmap() on the guest_memfd file=
=0A=
-                               descriptor.=0A=
-  GUEST_MEMFD_FLAG_INIT_SHARED Make all memory in the file shared during=
=0A=
-                               KVM_CREATE_GUEST_MEMFD (memory files create=
d=0A=
-                               without INIT_SHARED will be marked private)=
.=0A=
-                               Shared memory can be faulted into host user=
space=0A=
-                               page tables. Private memory cannot.=0A=
-  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=0A=
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
+  GUEST_MEMFD_FLAG_MMAP          Enable using mmap() on the guest_memfd fi=
le=0A=
+                                 descriptor.=0A=
+  GUEST_MEMFD_FLAG_INIT_SHARED   Make all memory in the file shared during=
=0A=
+                                 KVM_CREATE_GUEST_MEMFD (memory files crea=
ted=0A=
+                                 without INIT_SHARED will be marked privat=
e).=0A=
+                                 Shared memory can be faulted into host us=
erspace=0A=
+                                 page tables. Private memory cannot.=0A=
+  GUEST_MEMFD_FLAG_NO_DIRECT_MAP The guest_memfd instance will unmap the m=
emory=0A=
+                                 backing it from the kernel's address spac=
e=0A=
+                                 before passing it off to userspace or the=
 guest.=0A=
+  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0A=
 =0A=
 When the KVM MMU performs a PFN lookup to service a guest fault and the ba=
cking=0A=
 guest_memfd has the GUEST_MEMFD_FLAG_MMAP set, then the fault will always =
be=0A=
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h=0A=
index 68bd29a52f24..6de1c3a6344f 100644=0A=
--- a/arch/x86/include/asm/kvm_host.h=0A=
+++ b/arch/x86/include/asm/kvm_host.h=0A=
@@ -2483,10 +2483,7 @@ static inline bool kvm_arch_has_irq_bypass(void)=0A=
 }=0A=
 =0A=
 #ifdef CONFIG_KVM_GUEST_MEMFD=0A=
-static inline bool kvm_arch_gmem_supports_no_direct_map(void)=0A=
-{=0A=
-	return can_set_direct_map();=0A=
-}=0A=
+bool kvm_arch_gmem_supports_no_direct_map(struct kvm *kvm);=0A=
 #define kvm_arch_gmem_supports_no_direct_map kvm_arch_gmem_supports_no_dir=
ect_map=0A=
 #endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
 =0A=
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c=0A=
index ff8812f3a129..13b3576ffb9a 100644=0A=
--- a/arch/x86/kvm/x86.c=0A=
+++ b/arch/x86/kvm/x86.c=0A=
@@ -14007,6 +14007,11 @@ void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm=
_pfn_t end)=0A=
 	kvm_x86_call(gmem_invalidate)(start, end);=0A=
 }=0A=
 #endif=0A=
+=0A=
+bool kvm_arch_gmem_supports_no_direct_map(struct kvm *kvm)=0A=
+{=0A=
+	return can_set_direct_map() && kvm->arch.vm_type !=3D KVM_X86_TDX_VM;=0A=
+}=0A=
 #endif=0A=
 =0A=
 int kvm_spec_ctrl_test_value(u64 value)=0A=
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h=0A=
index 27796a09d29b..febc6b9ea714 100644=0A=
--- a/include/linux/kvm_host.h=0A=
+++ b/include/linux/kvm_host.h=0A=
@@ -738,10 +738,22 @@ static inline u64 kvm_gmem_get_supported_flags(struct=
 kvm *kvm)=0A=
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))=0A=
 		flags |=3D GUEST_MEMFD_FLAG_INIT_SHARED;=0A=
 =0A=
+	if (!kvm || kvm_arch_gmem_supports_no_direct_map(kvm))=0A=
+		flags |=3D GUEST_MEMFD_FLAG_NO_DIRECT_MAP;=0A=
+=0A=
 	return flags;=0A=
 }=0A=
 #endif=0A=
 =0A=
+#ifdef CONFIG_KVM_GUEST_MEMFD=0A=
+#ifndef kvm_arch_gmem_supports_no_direct_map=0A=
+static inline bool kvm_arch_gmem_supports_no_direct_map(struct kvm *kvm)=
=0A=
+{=0A=
+	return false;=0A=
+}=0A=
+#endif=0A=
+#endif /* CONFIG_KVM_GUEST_MEMFD */=0A=
+=0A=
 #ifndef kvm_arch_has_readonly_mem=0A=
 static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)=0A=
 {=0A=
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h=0A=
index dddb781b0507..60341e1ba1be 100644=0A=
--- a/include/uapi/linux/kvm.h=0A=
+++ b/include/uapi/linux/kvm.h=0A=
@@ -1612,6 +1612,7 @@ struct kvm_memory_attributes {=0A=
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest=
_memfd)=0A=
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)=0A=
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)=0A=
+#define GUEST_MEMFD_FLAG_NO_DIRECT_MAP	(1ULL << 2)=0A=
 =0A=
 struct kvm_create_guest_memfd {=0A=
 	__u64 size;=0A=
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c=0A=
index 92e7f8c1f303..168338287db6 100644=0A=
--- a/virt/kvm/guest_memfd.c=0A=
+++ b/virt/kvm/guest_memfd.c=0A=
@@ -7,6 +7,9 @@=0A=
 #include <linux/mempolicy.h>=0A=
 #include <linux/pseudo_fs.h>=0A=
 #include <linux/pagemap.h>=0A=
+#include <linux/set_memory.h>=0A=
+=0A=
+#include <asm/tlbflush.h>=0A=
 =0A=
 #include "kvm_mm.h"=0A=
 =0A=
@@ -76,6 +79,43 @@ static int __kvm_gmem_prepare_folio(struct kvm *kvm, str=
uct kvm_memory_slot *slo=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+#define KVM_GMEM_FOLIO_NO_DIRECT_MAP BIT(0)=0A=
+=0A=
+static bool kvm_gmem_folio_no_direct_map(struct folio *folio)=0A=
+{=0A=
+	return ((u64)folio->private) & KVM_GMEM_FOLIO_NO_DIRECT_MAP;=0A=
+}=0A=
+=0A=
+static int kvm_gmem_folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	u64 gmem_flags =3D GMEM_I(folio_inode(folio))->flags;=0A=
+	int r =3D 0;=0A=
+=0A=
+	if (kvm_gmem_folio_no_direct_map(folio) || !(gmem_flags & GUEST_MEMFD_FLA=
G_NO_DIRECT_MAP))=0A=
+		goto out;=0A=
+=0A=
+	folio->private =3D (void *)((u64)folio->private | KVM_GMEM_FOLIO_NO_DIREC=
T_MAP);=0A=
+	r =3D folio_zap_direct_map(folio);=0A=
+=0A=
+out:=0A=
+	return r;=0A=
+}=0A=
+=0A=
+static void kvm_gmem_folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	/*=0A=
+	 * Direct map restoration cannot fail, as the only error condition=0A=
+	 * for direct map manipulation is failure to allocate page tables=0A=
+	 * when splitting huge pages, but this split would have already=0A=
+	 * happened in folio_zap_direct_map() in kvm_gmem_folio_zap_direct_map().=
=0A=
+	 * Note that the splitting occurs always because guest_memfd=0A=
+	 * currently supports only base pages.=0A=
+	 * Thus folio_restore_direct_map() here only updates prot bits.=0A=
+	 */=0A=
+	WARN_ON_ONCE(folio_restore_direct_map(folio));=0A=
+	folio->private =3D (void *)((u64)folio->private & ~KVM_GMEM_FOLIO_NO_DIRE=
CT_MAP);=0A=
+}=0A=
+=0A=
 static inline void kvm_gmem_mark_prepared(struct folio *folio)=0A=
 {=0A=
 	folio_mark_uptodate(folio);=0A=
@@ -393,11 +433,17 @@ static bool kvm_gmem_supports_mmap(struct inode *inod=
e)=0A=
 	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;=0A=
 }=0A=
 =0A=
+static bool kvm_gmem_no_direct_map(struct inode *inode)=0A=
+{=0A=
+	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP;=0A=
+}=0A=
+=0A=
 static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)=0A=
 {=0A=
 	struct inode *inode =3D file_inode(vmf->vma->vm_file);=0A=
 	struct folio *folio;=0A=
 	vm_fault_t ret =3D VM_FAULT_LOCKED;=0A=
+	int err;=0A=
 =0A=
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >=3D i_size_read(inode))=0A=
 		return VM_FAULT_SIGBUS;=0A=
@@ -423,6 +469,14 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct v=
m_fault *vmf)=0A=
 		kvm_gmem_mark_prepared(folio);=0A=
 	}=0A=
 =0A=
+	if (kvm_gmem_no_direct_map(folio_inode(folio))) {=0A=
+		err =3D kvm_gmem_folio_zap_direct_map(folio);=0A=
+		if (err) {=0A=
+			ret =3D vmf_error(err);=0A=
+			goto out_folio;=0A=
+		}=0A=
+	}=0A=
+=0A=
 	vmf->page =3D folio_file_page(folio, vmf->pgoff);=0A=
 =0A=
 out_folio:=0A=
@@ -533,6 +587,9 @@ static void kvm_gmem_free_folio(struct folio *folio)=0A=
 	kvm_pfn_t pfn =3D page_to_pfn(page);=0A=
 	int order =3D folio_order(folio);=0A=
 =0A=
+	if (kvm_gmem_folio_no_direct_map(folio))=0A=
+		kvm_gmem_folio_restore_direct_map(folio);=0A=
+=0A=
 	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));=0A=
 }=0A=
 =0A=
@@ -596,6 +653,9 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t si=
ze, u64 flags)=0A=
 	/* Unmovable mappings are supposed to be marked unevictable as well. */=
=0A=
 	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));=0A=
 =0A=
+	if (flags & GUEST_MEMFD_FLAG_NO_DIRECT_MAP)=0A=
+		mapping_set_no_direct_map(inode->i_mapping);=0A=
+=0A=
 	GMEM_I(inode)->flags =3D flags;=0A=
 =0A=
 	file =3D alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR, &kvm_gmem_f=
ops);=0A=
@@ -804,15 +864,25 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memo=
ry_slot *slot,=0A=
 	if (IS_ERR(folio))=0A=
 		return PTR_ERR(folio);=0A=
 =0A=
-	if (!is_prepared)=0A=
+	if (!is_prepared) {=0A=
 		r =3D kvm_gmem_prepare_folio(kvm, slot, gfn, folio);=0A=
+		if (r)=0A=
+			goto out_unlock;=0A=
+	}=0A=
+=0A=
+	if (kvm_gmem_no_direct_map(folio_inode(folio))) {=0A=
+		r =3D kvm_gmem_folio_zap_direct_map(folio);=0A=
+		if (r)=0A=
+			goto out_unlock;=0A=
+	}=0A=
 =0A=
+	*page =3D folio_file_page(folio, index);=0A=
 	folio_unlock(folio);=0A=
+	return 0;=0A=
 =0A=
-	if (!r)=0A=
-		*page =3D folio_file_page(folio, index);=0A=
-	else=0A=
-		folio_put(folio);=0A=
+out_unlock:=0A=
+	folio_unlock(folio);=0A=
+	folio_put(folio);=0A=
 =0A=
 	return r;=0A=
 }=0A=
-- =0A=
2.50.1=0A=
=0A=

