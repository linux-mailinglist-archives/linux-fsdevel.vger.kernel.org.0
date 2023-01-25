Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CED667B2D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjAYNB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAYNBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:01:25 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D19712064;
        Wed, 25 Jan 2023 05:01:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6D5F8581DCF;
        Wed, 25 Jan 2023 07:53:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 25 Jan 2023 07:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674651208; x=1674658408; bh=4+
        WTh2wxYnUegwTOEldoemeAGUATx2lachXfcnNgrRM=; b=rW63RSV1s6p/5iI23s
        pPb3Yev73vywbEK2l+K+UINyN0wq/ycFBZaIek7/rkZOTLRNsrb0bR8ni0tCGKby
        EHkp3vTR7w59Cpw8IPpHzmtvU/PAFIfoRD4vaV/obIMlj05qa0x0RAP2GeD852oI
        ql2jJRikMcmoNxIvJmcP7Y2F4bop+DZRBWkTHAJ76vxDVBlc2G1W0ri4zWEjF47W
        RNJyjY1rMDCHnYAKtmDJut0wQz71Qi2dD1xllshO9o7KofTMflb45iXB1p9qfcp5
        4SQQayRWg5q076nLUgQgb8PIAPhLi5FkrHBJEv3jQavuT8nd6Rl0xsJ+kfBWIN0h
        5v+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674651208; x=1674658408; bh=4+WTh2wxYnUegwTOEldoemeAGUAT
        x2lachXfcnNgrRM=; b=nMswIvhy39T0VwYZ++ke/f29wffPClGz2z3gerpeHY/P
        veXiiALrTIG/Tq9iBnbIj1PjWFh/FIo+58pZWDG6X1UIpGokb3bWoMHiLtdDhXvK
        7o1HZ0CYempwzfVV2O7x73la0cJpLaWtgAH5HWaHiJocgmAeMgBmgq83HcWq7Ffd
        xvNnslwVO7SP3TDfN3BfKw3R3so/jjjZlzOtsjm8FsMi5As2hPcsHhGyN4/OiZIK
        LX495GAPtTfvbAzlrws4yqPcGPUor/eUCjtIKv9eZOOb+PPPEZC7I6bP5Noa2dFF
        yaaaeBAAMwBnWn3TsiT6GRQTzvIVT0bmyhlBeCVDHw==
X-ME-Sender: <xms:RSbRY0TA1r4YQIZjOVqLRPcMjJJroxY05TIFzvdQrmh3afSbh6tl0A>
    <xme:RSbRYxwR07Buzc1-9g4iscFNJklm3cZWzy2UjM9A9nop7GWGvW8iVknU2UCQDhQZs
    1jR5u6ldOQ0FQDh9ho>
X-ME-Received: <xmr:RSbRYx3JbfBe5NnwBX2dniGaNNSfnmu1-cBMXGWYcGd0-PPhiHZ3gt9pmNtJln1bG9KsoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetvdehffelffeiveeikeduffetudeuheeiiefg
    ueduvdevtdejhedvhfffffehfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhl
    sehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:RSbRY4AbDtPzxiU39td1Iki7uLF6-jp-3aOZzfoZGyoDTIrf9RfLeA>
    <xmx:RSbRY9h5-h-9JQGeknGeWaqQNuf4_aCfT7IpAqbyOUSGtA1M0YIPFw>
    <xmx:RSbRY0qNJMsSbCQasoVfsWkaEgxvOFJLjZxj4oEPBCIybrVRiUPRqg>
    <xmx:SCbRY7GTBtI4J-Eaiys6yGJBW86fFTQIdmIVpm3Ln5Wgc4JKyv-GBA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:53:24 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 83A27104985; Wed, 25 Jan 2023 15:53:21 +0300 (+03)
Date:   Wed, 25 Jan 2023 15:53:21 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Liam Merwick <liam.merwick@oracle.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Message-ID: <20230125125321.yvsivupbbaqkb7a5@box.shutemov.name>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com>
 <48953bf2-cee9-f818-dc50-5fb5b9b410bf@oracle.com>
 <Y9B1yiRR8DpANAEo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9B1yiRR8DpANAEo@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:20:26AM +0000, Sean Christopherson wrote:
> On Tue, Jan 24, 2023, Liam Merwick wrote:
> > On 14/01/2023 00:37, Sean Christopherson wrote:
> > > On Fri, Dec 02, 2022, Chao Peng wrote:
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
> > > >    - 01: mm change, target for mm tree
> > > >    - 02-09: KVM change, target for KVM tree
> > > 
> > > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > > is available here:
> > > 
> > >    git@github.com:sean-jc/linux.git x86/upm_base_support
> > > 
> > > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > > a WIP.
> > > 
> > 
> > When running LTP (https://github.com/linux-test-project/ltp) on the v10
> > bits (and also with Sean's branch above) I encounter the following NULL
> > pointer dereference with testcases/kernel/syscalls/madvise/madvise01
> > (100% reproducible).
> > 
> > It appears that in restrictedmem_error_page() inode->i_mapping->private_data
> > is NULL
> > in the list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list)
> > but I don't know why.
> 
> Kirill, can you take a look?  Or pass the buck to someone who can? :-)

The patch below should help.

diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index 15c52301eeb9..39ada985c7c0 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -307,14 +307,29 @@ void restrictedmem_error_page(struct page *page, struct address_space *mapping)
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
-		struct restrictedmem *rm = inode->i_mapping->private_data;
 		struct restrictedmem_notifier *notifier;
-		struct file *memfd = rm->memfd;
+		struct restrictedmem *rm;
 		unsigned long index;
+		struct file *memfd;
 
-		if (memfd->f_mapping != mapping)
+		if (atomic_read(&inode->i_count))
 			continue;
 
+		spin_lock(&inode->i_lock);
+		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		rm = inode->i_mapping->private_data;
+		memfd = rm->memfd;
+
+		if (memfd->f_mapping != mapping) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+		spin_unlock(&inode->i_lock);
+
 		xa_for_each_range(&rm->bindings, index, notifier, start, end)
 			notifier->ops->error(notifier, start, end);
 		break;
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
