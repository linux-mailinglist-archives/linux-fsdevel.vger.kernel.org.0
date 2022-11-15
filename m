Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E1629C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 15:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiKOOhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 09:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKOOhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:37:07 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864511401B;
        Tue, 15 Nov 2022 06:37:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id CBBF72B066D4;
        Tue, 15 Nov 2022 09:37:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 15 Nov 2022 09:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1668523020; x=1668530220; bh=Ad
        wHQwvOiKtA9P6Y0u9jZFsfpkfO0GgABx1clW0axSM=; b=b1yM/7FEcClWE/shk7
        Ikib6jlxMdJrJr/Np4NeX2vDsT0AQEo7W07O2V0AaFy5qOOmVENeqdMC1eOTss/x
        gRTEG1I0SEPeGT2VXeUG6zIbnD6dHdscBUIuGCJQevQzFC+UUbeDEQzmVWYglSbN
        V6l8IX93vkcm6THTPmR2V23AmrGLkx3Uw0BSgusDSjHt07Pe6LYtFORGK17dDOyJ
        mUAC7eH0TebAPnCXT78QyJejukQ4RmIG9X+xYUcryppXfcRiROQsTbMI4sAO7EDC
        CudXWZVJtpcFPN0el9OFhJUGGjVAjTjCWR1BAxqgAUQSMDvc16NjQvgP8x4GEFW+
        vcqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668523020; x=1668530220; bh=AdwHQwvOiKtA9P6Y0u9jZFsfpkfO
        0GgABx1clW0axSM=; b=TDFbZVnuyahpqh8vT886YvKR1Ol2nKo8U+/J2ZElxrSQ
        n2E5oSia7W6dD5yqxCZIxtzirSEFghTFlB7mAZp87wZnlFZbGO46OQUsMT2osyl9
        yPocZOwpYwDL035DaZVzu2fC+ZQ9iYm406ihwqwdqNIfGftbDX8htxDt5TxRGBCF
        +t23+33E4F1FO6nCpO9HhFlan0REtgnmZubj2wzg+HGVJNuF0NRuofZSdV1AscI9
        wZM2jrp9pfXmJMsJLubXwhmDN9eZtg4PyMSFlT3Df9EGLoL+1pB420R3iPOlGcpK
        lO65lG2pvjcQkovGbuVTllzqbhbtgdDPLNEsVzpDog==
X-ME-Sender: <xms:CqRzY68BT2_MOQCpJaG-rHi3ZvX2DPUi1AORdEmnduWa6W-16sqpUQ>
    <xme:CqRzY6sNcfcHf50KqgQ8kjcZzIU9uf7mU-dKtVHD2JzEBS25E00gx7lMBqWe_yZZn
    CIXpJ3thavR8r76dE4>
X-ME-Received: <xmr:CqRzYwDMbsjb5gxiP2OVgmcfVzPPyfJPLm1H0JkcrIAuZCoD9aYl6xTxWo_PDgIpjBv9KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeggdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:CqRzYydIWDcubtT3THtqv8FWKHCS--BtaBzbgq3OhwTX20vuyo-laQ>
    <xmx:CqRzY_OGoXMgKcwLte8bRp93aLlKDKHNuTTJfy3wCFsePEWbCpapGw>
    <xmx:CqRzY8lj7_1L0OWPwtgl65FvZmhL0RNn1SNgP5_j7hMUObZk6dJuAg>
    <xmx:DKRzYycI2DAmg3G1dRRamPnUVJyM4m05tNWQKBXs1AUq7Ug2T3ZwfJ76r9Y>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 09:36:57 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CAA2F10997B; Tue, 15 Nov 2022 17:36:54 +0300 (+03)
Date:   Tue, 15 Nov 2022 17:36:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Vishal Annapurve <vannapurve@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 0/8] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20221115143654.rqpf72hzdtrd3xyw@box.shutemov.name>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <CAGtprH-av3K6YxUbz1cAsQp4w2ce35UrfBF-u7Q_qCuTNMdvzQ@mail.gmail.com>
 <20221108004141.GF1063309@ls.amr.corp.intel.com>
 <20221109155404.istawiyvwr3yffag@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109155404.istawiyvwr3yffag@box.shutemov.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 06:54:04PM +0300, Kirill A. Shutemov wrote:
> On Mon, Nov 07, 2022 at 04:41:41PM -0800, Isaku Yamahata wrote:
> > On Thu, Nov 03, 2022 at 05:43:52PM +0530,
> > Vishal Annapurve <vannapurve@google.com> wrote:
> > 
> > > On Tue, Oct 25, 2022 at 8:48 PM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> > > >
> > > > This patch series implements KVM guest private memory for confidential
> > > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > > TDX-protected guest memory, machine check can happen which can further
> > > > crash the running host system, this is terrible for multi-tenant
> > > > configurations. The host accesses include those from KVM userspace like
> > > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > > via a fd-based approach, but it can never access the guest memory
> > > > content.
> > > >
> > > > The patch series touches both core mm and KVM code. I appreciate
> > > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > > reviews are always welcome.
> > > >   - 01: mm change, target for mm tree
> > > >   - 02-08: KVM change, target for KVM tree
> > > >
> > > > Given KVM is the only current user for the mm part, I have chatted with
> > > > Paolo and he is OK to merge the mm change through KVM tree, but
> > > > reviewed-by/acked-by is still expected from the mm people.
> > > >
> > > > The patches have been verified in Intel TDX environment, but Vishal has
> > > > done an excellent work on the selftests[4] which are dedicated for this
> > > > series, making it possible to test this series without innovative
> > > > hardware and fancy steps of building a VM environment. See Test section
> > > > below for more info.
> > > >
> > > >
> > > > Introduction
> > > > ============
> > > > KVM userspace being able to crash the host is horrible. Under current
> > > > KVM architecture, all guest memory is inherently accessible from KVM
> > > > userspace and is exposed to the mentioned crash issue. The goal of this
> > > > series is to provide a solution to align mm and KVM, on a userspace
> > > > inaccessible approach of exposing guest memory.
> > > >
> > > > Normally, KVM populates secondary page table (e.g. EPT) by using a host
> > > > virtual address (hva) from core mm page table (e.g. x86 userspace page
> > > > table). This requires guest memory being mmaped into KVM userspace, but
> > > > this is also the source where the mentioned crash issue can happen. In
> > > > theory, apart from those 'shared' memory for device emulation etc, guest
> > > > memory doesn't have to be mmaped into KVM userspace.
> > > >
> > > > This series introduces fd-based guest memory which will not be mmaped
> > > > into KVM userspace. KVM populates secondary page table by using a
> > > 
> > > With no mappings in place for userspace VMM, IIUC, looks like the host
> > > kernel will not be able to find the culprit userspace process in case
> > > of Machine check error on guest private memory. As implemented in
> > > hwpoison_user_mappings, host kernel tries to look at the processes
> > > which have mapped the pfns with hardware error.
> > > 
> > > Is there a modification needed in mce handling logic of the host
> > > kernel to immediately send a signal to the vcpu thread accessing
> > > faulting pfn backing guest private memory?
> > 
> > mce_register_decode_chain() can be used.  MCE physical address(p->mce_addr)
> > includes host key id in addition to real physical address.  By searching used
> > hkid by KVM, we can determine if the page is assigned to guest TD or not. If
> > yes, send SIGBUS.
> > 
> > kvm_machine_check() can be enhanced for KVM specific use.  This is before
> > memory_failure() is called, though.
> > 
> > any other ideas?
> 
> That's too KVM-centric. It will not work for other possible user of
> restricted memfd.
> 
> I tried to find a way to get it right: we need to get restricted memfd
> code info about corrupted page so it can invalidate its users. On the next
> request of the page the user will see an error. In case of KVM, the error
> will likely escalate to SIGBUS.
> 
> The problem is that core-mm code that handles memory failure knows nothing
> about restricted memfd. It only sees that the page belongs to a normal
> memfd.
> 
> AFAICS, there's no way to get it intercepted from the shim level. shmem
> code has to be patches. shmem_error_remove_page() has to call into
> restricted memfd code.
> 
> Hugh, are you okay with this? Or maybe you have a better idea?

Okay, here is what I've come up with. It doesn't touch shmem code, but
hooks up directly into memory-failure.c. It is still ugly, but should be
tolerable.

restrictedmem_error_page() loops over all restrictedmem inodes. It is
slow, but memory failure is not hot path (I hope).

Only build-tested. Chao, could you hook up ->error for KVM and get it
tested?

diff --git a/include/linux/restrictedmem.h b/include/linux/restrictedmem.h
index 9c37c3ea3180..c2700c5daa43 100644
--- a/include/linux/restrictedmem.h
+++ b/include/linux/restrictedmem.h
@@ -12,6 +12,8 @@ struct restrictedmem_notifier_ops {
 				 pgoff_t start, pgoff_t end);
 	void (*invalidate_end)(struct restrictedmem_notifier *notifier,
 			       pgoff_t start, pgoff_t end);
+	void (*error)(struct restrictedmem_notifier *notifier,
+			       pgoff_t start, pgoff_t end);
 };
 
 struct restrictedmem_notifier {
@@ -34,6 +36,8 @@ static inline bool file_is_restrictedmem(struct file *file)
 	return file->f_inode->i_sb->s_magic == RESTRICTEDMEM_MAGIC;
 }
 
+void restrictedmem_error_page(struct page *page, struct address_space *mapping);
+
 #else
 
 static inline void restrictedmem_register_notifier(struct file *file,
@@ -57,6 +61,11 @@ static inline bool file_is_restrictedmem(struct file *file)
 	return false;
 }
 
+static inline void restrictedmem_error_page(struct page *page,
+					    struct address_space *mapping)
+{
+}
+
 #endif /* CONFIG_RESTRICTEDMEM */
 
 #endif /* _LINUX_RESTRICTEDMEM_H */
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e7ac570dda75..ee85e46c6992 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -62,6 +62,7 @@
 #include <linux/page-isolation.h>
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
+#include <linux/restrictedmem.h>
 #include "swap.h"
 #include "internal.h"
 #include "ras/ras_event.h"
@@ -939,6 +940,8 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
 		goto out;
 	}
 
+	restrictedmem_error_page(p, mapping);
+
 	/*
 	 * The shmem page is kept in page cache instead of truncating
 	 * so is expected to have an extra refcount after error-handling.
diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index e5bf8907e0f8..0dcdff0d8055 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -29,6 +29,18 @@ static void restrictedmem_notifier_invalidate(struct restrictedmem_data *data,
 	mutex_unlock(&data->lock);
 }
 
+static void restrictedmem_notifier_error(struct restrictedmem_data *data,
+				 pgoff_t start, pgoff_t end)
+{
+	struct restrictedmem_notifier *notifier;
+
+	mutex_lock(&data->lock);
+	list_for_each_entry(notifier, &data->notifiers, list) {
+			notifier->ops->error(notifier, start, end);
+	}
+	mutex_unlock(&data->lock);
+}
+
 static int restrictedmem_release(struct inode *inode, struct file *file)
 {
 	struct restrictedmem_data *data = inode->i_mapping->private_data;
@@ -248,3 +260,30 @@ int restrictedmem_get_page(struct file *file, pgoff_t offset,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(restrictedmem_get_page);
+
+void restrictedmem_error_page(struct page *page, struct address_space *mapping)
+{
+	struct super_block *sb = restrictedmem_mnt->mnt_sb;
+	struct inode *inode, *next;
+
+	if (!shmem_mapping(mapping))
+		return;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
+		struct restrictedmem_data *data = inode->i_mapping->private_data;
+		struct file *memfd = data->memfd;
+
+		if (memfd->f_mapping == mapping) {
+			pgoff_t start, end;
+
+			spin_unlock(&sb->s_inode_list_lock);
+
+			start = page->index;
+			end = start + thp_nr_pages(page);
+			restrictedmem_notifier_error(data, start, end);
+			return;
+		}
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+}
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
