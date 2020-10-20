Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49608293F7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408702AbgJTPXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408694AbgJTPXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:23:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D79C061755;
        Tue, 20 Oct 2020 08:23:04 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id l4so2048365ota.7;
        Tue, 20 Oct 2020 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQmeC0MtZ6s7r4kh7xv1a29XNKomjXnHDh8Hft3R8r4=;
        b=d9+EWROrfbzAVnsg4uHV+ZGoWha4Z2t8hMt9iPwy2H1OV0SoOnkO1sEzuT4KZwlgjo
         OYgXQcGyH37H5hIL7Wi38FYRXivctHAIoFvO2cM2QXujHTeNUOhjRfzVxjZ48BD30ulZ
         bZdzCzx2vqqMoxsI7y8GUs6Oo4AcqYF7g1bQ/xj9PGVJWrlXU0PF6ekjVJEjRG8Q7WzO
         pr0vE17XDUjTi64ToJZ0wQHZSgSfKhmjpIGTQvlcWvMq7j/aEILf6za259aLEcdlF8gb
         VA1XnNswJWRJg6pWVrLtq2IHZR1hkRuywSl2A+KuI4nj/zSknLiHmSBgo4NlbVm5S2qU
         Fi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQmeC0MtZ6s7r4kh7xv1a29XNKomjXnHDh8Hft3R8r4=;
        b=FAf0J+Ik/OJIGTh5uhl2QEvwUZ4AWI+80jkI7K8j80Sk2jpT7EckRQHkV9WcMwrXuC
         J15NH/3wcZOIrxZQJBpktDswqepvyNaE92Y/I18868Qw2trlMAiSZVocHSzsI9jOAn1A
         6dZiut9ISGplsUU2/vOiGVyD4JCgEXXvvy6bTQ0AKv2EdCGfiN09sZJR1sCCTDNLjiqO
         VOdXk/FpOJ+VLZitb2vPmvA6ZibXPOyzrFiUASRQ9ItE1ZRAbEYJ0+60fGlfJdh3x+DS
         rxp+xJHnOrVtY8KfDHO2Ozke+N7y9FcwvHx56hq9TwUydkgYDIL02oA25+thf/v4G4Ee
         K6ng==
X-Gm-Message-State: AOAM532iRb74fxlheK17Egwmqaa/PsM61bUwk9XNK/FVyRK6qh8IX90u
        u1L32e1zSOAKQoOsbzCOkn5IXvOvX8HPtAmVCkE=
X-Google-Smtp-Source: ABdhPJw5N2EmvJNZYdNiAXUf+L9HciQdNpXcB1V0hc2R7tGN7/SSFQckoJpdBIm3OweZtihWQnWP9VwLqpFGAA3BiSU=
X-Received: by 2002:a9d:d13:: with SMTP id 19mr2191904oti.116.1603207383715;
 Tue, 20 Oct 2020 08:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <bdd0250e-4e14-f407-a584-f39af12c4e09@oracle.com>
 <CACZOiM2qKhogXQ_DXzWjGM5UCeCuEqT6wnR=f2Wi_T45_uoYHQ@mail.gmail.com>
 <b963565b-61d8-89d3-1abd-50cd8c8daad5@oracle.com> <CACZOiM26GPtqkGyecG=NGuB3etipV5-KgN+s19_U1WJrFxtYPQ@mail.gmail.com>
 <98be093d-c869-941a-6dd9-fb16356f763b@oracle.com> <CAPcyv4jZ7XTnYd7vLQ18xij7d+80jU0zLs+ykS2frY-LMPS=Nw@mail.gmail.com>
 <3626f5ff-b6a0-0811-5899-703a0714897d@redhat.com> <0c8fd8ab-c0d4-003a-6943-1ec732c96e1c@oracle.com>
In-Reply-To: <0c8fd8ab-c0d4-003a-6943-1ec732c96e1c@oracle.com>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Tue, 20 Oct 2020 23:22:52 +0800
Message-ID: <CACZOiM1-JPv+JzxEZd87+BDs9w+nmaYkizYcBoyw=MtUTd9dvw@mail.gmail.com>
Subject: Re: [PATCH 00/35] Enhance memory utilization with DMEMFS
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jane Y Chu <jane.chu@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 3:03 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 10/19/20 2:37 PM, Paolo Bonzini wrote:
> > On 15/10/20 00:25, Dan Williams wrote:
> >> Now, with recent device-dax extensions, it
> >> also has a coarse grained memory management system for  physical
> >> address-space partitioning and a path for struct-page-less backing for
> >> VMs. What feature gaps remain vs dmemfs, and can those gaps be closed
> >> with incremental improvements to the 2 existing memory-management
> >> systems?
> >
> > If I understand correctly, devm_memremap_pages() on ZONE_DEVICE memory
> > would still create the "struct page" albeit lazily?  KVM then would use
> > the usual get_user_pages() path.
> >
> Correct.
>
> The removal of struct page would be one of the added incremental improvements, like a
> 'map' with 'raw' sysfs attribute for dynamic dax regions that wouldn't online/create the
> struct pages. The remaining plumbing (...)
>
> > Looking more closely at the implementation of dmemfs, I don't understand
> > is why dmemfs needs VM_DMEM etc. and cannot provide access to mmap-ed
> > memory using remap_pfn_range and VM_PFNMAP, just like /dev/mem.  If it
> > did that KVM would get physical addresses using fixup_user_fault and
> > never need pfn_to_page() or get_user_pages().  I'm not saying that would
> > instantly be an approval, but it would make remove a lot of hooks.
> >
>
> (...) is similar to what you describe above. Albeit there's probably no need to do a
> remap_pfn_range at mmap(), as DAX supplies a fault/huge_fault. Also, using that means it's
> limited to a single contiguous PFN chunk.
>
> KVM has the bits to make it work without struct pages, I don't think there's a need for
> new pg/pfn_t/VM_* bits (aside from relying on {PFN,PAGE}_SPECIAL) as mentioned at the
> start of the thread. I'm storing my wip here:
>
>         https://github.com/jpemartins/linux pageless-dax
>
> Which is based on the first series that had been submitted earlier this year:
>
>         https://lore.kernel.org/kvm/20200110190313.17144-1-joao.m.martins@oracle.com/
>
>   Joao

Just as Joao mentioned, remap_pfn_range() may request a single
contiguous PFN range, which
is not our intention. And for VM_DMEM, I think we may drop it in the
next version, and to use the
existing bits as much as possible to minimize the modifications.
