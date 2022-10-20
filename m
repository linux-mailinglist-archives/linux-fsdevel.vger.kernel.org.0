Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AE605E2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJTKvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 06:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJTKvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:51:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673771CA59F
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 03:51:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so2707338pjl.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Oct 2022 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=THcn/iHYHuaAA2JhGclOSPj+v18JyGtJUfmP5t8z+lQ=;
        b=PmJinTSn6bOFY1sRc3n5f1hZ15Jyjk2crnp6tAUK4UsMnuuKaRiwyIZ9vxnvm6EgX1
         BdiOuFPJTUj+Jd5ruhpQt87Sy2B+pJVlB4/vaWJicwCHmvwFg61SgSaguaJ1lBmd7QXS
         QFioDLsch2dRK9t/P8KldC7XER1zMfGFurOJPEvK5LnYFXZs6vhi+qqy1asHbDDF+aD6
         ILFP948uKub82ZM5zYCQEeBuIgE3icp8W05VylvPJmUBugZ9WUWsELxM/uUoK0c4FHxC
         vWtsfquLcn0jnYKc5NyAZA7wi5EkmZgOEKQEbFJ00pVUkTdd0i4WhDkxKS+UknN/+mhi
         I2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THcn/iHYHuaAA2JhGclOSPj+v18JyGtJUfmP5t8z+lQ=;
        b=q+hnLJVEHL5OlDedf3OKznHGGDMehN3nbnHAobx91/Z/j3Ove0JwJi3q/hSQhM/seF
         lPCXGFNqa/AMixNn2JgC2NnIGYV8gZ8Urygk/K/3z/IXUdgnVutlR6HUmF71QY6YSXZ+
         FYscAjQsI8kGkRjC0stzt6jk/PM4kc+xWMOqvBtyPlwJFZCK594Kt5yiDGcLNbFVpX2T
         KDfbpyV1ADpkihEdJc1BtQodSjOTxyRFuMS1ZD6j+YctWaR5qILSw5o0DKmLbMRSDeov
         2E7bQWQjnzPeWn3Co6KWSjsXPmXCHgi3rFVtrwquV3RJzQWr6SE88HX54UbJqXvOXIMZ
         V7AQ==
X-Gm-Message-State: ACrzQf3CqJaXwtCsI2tY1ac0h8oV1oz+NJWYOBSePyty08AVPTtrUrvJ
        /XCE7gq9k7XVrOZjQunPQ2yGsMu1NVw18Y2bruCEjA==
X-Google-Smtp-Source: AMsMyM40B/PslhPwM5x2D9ZaTJvWzWPry4q1P2rbX5amIPTYMJjCA42jA3LnrGgZY+4rHUIhjKLhhZn1nSOt0iwlCU0=
X-Received: by 2002:a17:90b:38c3:b0:20d:406e:26d9 with SMTP id
 nn3-20020a17090b38c300b0020d406e26d9mr15478335pjb.121.1666263069563; Thu, 20
 Oct 2022 03:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com> <de680280-f6b1-9337-2ae4-4b2faf2b823b@suse.cz>
 <20221017161955.t4gditaztbwijgcn@box.shutemov.name> <c63ad0cd-d517-0f1e-59e9-927d8ae15a1a@amd.com>
 <20221017215640.hobzcz47es7dq2bi@box.shutemov.name> <CAGtprH8xEdgATjQdhi2b_KqUuSOZHUM-Lh+O-ZtcFKbHf2_75g@mail.gmail.com>
 <20221019153225.njvg45glehlnjgc7@box.shutemov.name>
In-Reply-To: <20221019153225.njvg45glehlnjgc7@box.shutemov.name>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Thu, 20 Oct 2022 16:20:58 +0530
Message-ID: <CAGtprH-8y9iTyVZ+EYW2t=zGqz7fVgPu-3wVm0Wgv5134NU6WQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 9:02 PM Kirill A . Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Oct 18, 2022 at 07:12:10PM +0530, Vishal Annapurve wrote:
> > On Tue, Oct 18, 2022 at 3:27 AM Kirill A . Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Mon, Oct 17, 2022 at 06:39:06PM +0200, Gupta, Pankaj wrote:
> > > > On 10/17/2022 6:19 PM, Kirill A . Shutemov wrote:
> > > > > On Mon, Oct 17, 2022 at 03:00:21PM +0200, Vlastimil Babka wrote:
> > > > > > On 9/15/22 16:29, Chao Peng wrote:
> > > > > > > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > > > > >
> > > > > > > KVM can use memfd-provided memory for guest memory. For normal userspace
> > > > > > > accessible memory, KVM userspace (e.g. QEMU) mmaps the memfd into its
> > > > > > > virtual address space and then tells KVM to use the virtual address to
> > > > > > > setup the mapping in the secondary page table (e.g. EPT).
> > > > > > >
> > > > > > > With confidential computing technologies like Intel TDX, the
> > > > > > > memfd-provided memory may be encrypted with special key for special
> > > > > > > software domain (e.g. KVM guest) and is not expected to be directly
> > > > > > > accessed by userspace. Precisely, userspace access to such encrypted
> > > > > > > memory may lead to host crash so it should be prevented.
> > > > > > >
> > > > > > > This patch introduces userspace inaccessible memfd (created with
> > > > > > > MFD_INACCESSIBLE). Its memory is inaccessible from userspace through
> > > > > > > ordinary MMU access (e.g. read/write/mmap) but can be accessed via
> > > > > > > in-kernel interface so KVM can directly interact with core-mm without
> > > > > > > the need to map the memory into KVM userspace.
> > > > > > >
> > > > > > > It provides semantics required for KVM guest private(encrypted) memory
> > > > > > > support that a file descriptor with this flag set is going to be used as
> > > > > > > the source of guest memory in confidential computing environments such
> > > > > > > as Intel TDX/AMD SEV.
> > > > > > >
> > > > > > > KVM userspace is still in charge of the lifecycle of the memfd. It
> > > > > > > should pass the opened fd to KVM. KVM uses the kernel APIs newly added
> > > > > > > in this patch to obtain the physical memory address and then populate
> > > > > > > the secondary page table entries.
> > > > > > >
> > > > > > > The userspace inaccessible memfd can be fallocate-ed and hole-punched
> > > > > > > from userspace. When hole-punching happens, KVM can get notified through
> > > > > > > inaccessible_notifier it then gets chance to remove any mapped entries
> > > > > > > of the range in the secondary page tables.
> > > > > > >
> > > > > > > The userspace inaccessible memfd itself is implemented as a shim layer
> > > > > > > on top of real memory file systems like tmpfs/hugetlbfs but this patch
> > > > > > > only implemented tmpfs. The allocated memory is currently marked as
> > > > > > > unmovable and unevictable, this is required for current confidential
> > > > > > > usage. But in future this might be changed.
> > > > > > >
> > > > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > > > Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> > > > > > > ---
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > +static long inaccessible_fallocate(struct file *file, int mode,
> > > > > > > +                                  loff_t offset, loff_t len)
> > > > > > > +{
> > > > > > > +       struct inaccessible_data *data = file->f_mapping->private_data;
> > > > > > > +       struct file *memfd = data->memfd;
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > > > > > +               if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
> > > > > > > +                       return -EINVAL;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       ret = memfd->f_op->fallocate(memfd, mode, offset, len);
> > > > > > > +       inaccessible_notifier_invalidate(data, offset, offset + len);
> > > > > >
> > > > > > Wonder if invalidate should precede the actual hole punch, otherwise we open
> > > > > > a window where the page tables point to memory no longer valid?
> > > > >
> > > > > Yes, you are right. Thanks for catching this.
> > > >
> > > > I also noticed this. But then thought the memory would be anyways zeroed
> > > > (hole punched) before this call?
> > >
> > > Hole punching can free pages, given that offset/len covers full page.
> > >
> > > --
> > >   Kiryl Shutsemau / Kirill A. Shutemov
> >
> > I think moving this notifier_invalidate before fallocate may not solve
> > the problem completely. Is it possible that between invalidate and
> > fallocate, KVM tries to handle the page fault for the guest VM from
> > another vcpu and uses the pages to be freed to back gpa ranges? Should
> > hole punching here also update mem_attr first to say that KVM should
> > consider the corresponding gpa ranges to be no more backed by
> > inaccessible memfd?
>
> We rely on external synchronization to prevent this. See code around
> mmu_invalidate_retry_hva().
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

IIUC, mmu_invalidate_retry_hva/gfn ensures that page faults on gfn
ranges that are being invalidated are retried till invalidation is
complete. In this case, is it possible that KVM tries to serve the
page fault after inaccessible_notifier_invalidate is complete but
before fallocate could punch hole into the files?
e.g.
inaccessible_notifier_invalidate(...)
... (system event preempting this control flow, giving a window for
the guest to retry accessing the gfn range which was invalidated)
fallocate(.., PUNCH_HOLE..)
