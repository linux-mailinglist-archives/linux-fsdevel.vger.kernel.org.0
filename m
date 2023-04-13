Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9D6E037C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 03:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDMBHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 21:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjDMBHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:07:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85261B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 18:07:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id h64-20020a638343000000b0050760997f4dso5469668pge.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 18:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681348050; x=1683940050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBLbhNm3fsRbkajEjRmINqzacPrnC3sWkejBQFnfCeY=;
        b=l81F5p/zxISuNsOTdPBgLBjqThC2vDQDK5Uw+271tLolnlAHCMjlZe8AeG/jf3nOrx
         ExWxIQK7CKtblDvJ8H3VSzPnmPuqB/YeLXauyGbc5MYvJjSXVvNUPEsSQLuxsR77moKZ
         UlTepofDb02LxLShDY5FjB4dpGfEQe3unZKqgtyJNvz/0ht5ta0+OYjQykpOh/ft4xiY
         iCpoKLuH+PMrGysZjyKXtcxmXgl9ury1l15XbUM9kGssTvMz69Uh47nolIPDiQg/ZLYy
         kWyCbb4PMZcJ8WgWH7QKSQOInzUxQhQDlNJXdkLhsMb661/+oYSUbCYk/vgAZ5pUqK7f
         uA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681348050; x=1683940050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBLbhNm3fsRbkajEjRmINqzacPrnC3sWkejBQFnfCeY=;
        b=lxr3YIwaUW8N6t7r+qCFpzacPmrkpwCrzvhByeVxeXsUG1XY7jax+5fskBXY8B+TRJ
         xY6KX7hwxxXwNILLP/IVYgevHTkhDwAItNkpmrgvdE4DmKIuo59kJ6W56ItvFSnYXkH9
         kewoNkOeviHh9KcmKK5tPgO0RcxokqdUEH+T3s1F35gKwaqv7in4ClD4/2S67wfK59ir
         ziYJoDJgNsZTcw4YDTP2mb4sd8YdvJ6d/IarXhk3zMdyPOgZi9D9uUAqV9ITMMqzJX7r
         0WPnVMFyJmWxfqjKz3bMhB0vszJdyR4MCdmwyj2+6fHirJzeLJNkUatC2udmwQAKXbEl
         LJ8Q==
X-Gm-Message-State: AAQBX9cKAtbgJEXeDFJzeYrOp+5RyuepyKsnYrgmi5rqC27BjZdbl1KP
        SvCkOLGMp0rkjz28HczcWQpJTLbsPlk=
X-Google-Smtp-Source: AKy350Yi++EiqbAHiD3SnOi84M+UlU1LyPdYHPeuc+OePAq+A1CU6oZwmUR77MLD4jcxJ/2tHyPNMvmLNLU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d413:b0:19a:7f9c:66e3 with SMTP id
 b19-20020a170902d41300b0019a7f9c66e3mr13167ple.5.1681348050454; Wed, 12 Apr
 2023 18:07:30 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:07:28 -0700
In-Reply-To: <20230125125321.yvsivupbbaqkb7a5@box.shutemov.name>
Mime-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <Y8H5Z3e4hZkFxAVS@google.com> <48953bf2-cee9-f818-dc50-5fb5b9b410bf@oracle.com>
 <Y9B1yiRR8DpANAEo@google.com> <20230125125321.yvsivupbbaqkb7a5@box.shutemov.name>
Message-ID: <ZDdV0Fh7nDEnY/eW@google.com>
Subject: Re: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023, Kirill A. Shutemov wrote:
> On Wed, Jan 25, 2023 at 12:20:26AM +0000, Sean Christopherson wrote:
> > On Tue, Jan 24, 2023, Liam Merwick wrote:
> > > On 14/01/2023 00:37, Sean Christopherson wrote:
> > > > On Fri, Dec 02, 2022, Chao Peng wrote:
> > > > > This patch series implements KVM guest private memory for confidential
> > > > > computing scenarios like Intel TDX[1]. If a TDX host accesses
> > > > > TDX-protected guest memory, machine check can happen which can further
> > > > > crash the running host system, this is terrible for multi-tenant
> > > > > configurations. The host accesses include those from KVM userspace like
> > > > > QEMU. This series addresses KVM userspace induced crash by introducing
> > > > > new mm and KVM interfaces so KVM userspace can still manage guest memory
> > > > > via a fd-based approach, but it can never access the guest memory
> > > > > content.
> > > > > 
> > > > > The patch series touches both core mm and KVM code. I appreciate
> > > > > Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
> > > > > reviews are always welcome.
> > > > >    - 01: mm change, target for mm tree
> > > > >    - 02-09: KVM change, target for KVM tree
> > > > 
> > > > A version with all of my feedback, plus reworked versions of Vishal's selftest,
> > > > is available here:
> > > > 
> > > >    git@github.com:sean-jc/linux.git x86/upm_base_support
> > > > 
> > > > It compiles and passes the selftest, but it's otherwise barely tested.  There are
> > > > a few todos (2 I think?) and many of the commits need changelogs, i.e. it's still
> > > > a WIP.
> > > > 
> > > 
> > > When running LTP (https://github.com/linux-test-project/ltp) on the v10
> > > bits (and also with Sean's branch above) I encounter the following NULL
> > > pointer dereference with testcases/kernel/syscalls/madvise/madvise01
> > > (100% reproducible).
> > > 
> > > It appears that in restrictedmem_error_page()
> > > inode->i_mapping->private_data is NULL in the
> > > list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) but I
> > > don't know why.
> > 
> > Kirill, can you take a look?  Or pass the buck to someone who can? :-)
> 
> The patch below should help.
> 
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> index 15c52301eeb9..39ada985c7c0 100644
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -307,14 +307,29 @@ void restrictedmem_error_page(struct page *page, struct address_space *mapping)
>  
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> -		struct restrictedmem *rm = inode->i_mapping->private_data;
>  		struct restrictedmem_notifier *notifier;
> -		struct file *memfd = rm->memfd;
> +		struct restrictedmem *rm;
>  		unsigned long index;
> +		struct file *memfd;
>  
> -		if (memfd->f_mapping != mapping)
> +		if (atomic_read(&inode->i_count))

Kirill, should this be

		if (!atomic_read(&inode->i_count))
			continue;

i.e. skip unreferenced inodes, not skip referenced inodes?
