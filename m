Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88EB289F3B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgJJIQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Oct 2020 04:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbgJJIPe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Oct 2020 04:15:34 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6E8C0613CF;
        Sat, 10 Oct 2020 01:15:31 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h10so129178oie.5;
        Sat, 10 Oct 2020 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4tihMGS3ElCYUguFSIvEvXuQDG95gCqR3K5leSMmqQ=;
        b=X2b/27BR29hjxeoC7uBvJfCQ/kxzfGR6ALliZUrtC8nDzYIx2JUn1yqitABLoVvhAc
         BNvgkGbgS3nUS4UjqkVkvxXIUSoH8u22x4DINAXzQPWvBx6PThE8FiZ0efTtxgv+Pyau
         pfrDXdESOeCbJjQpcc9r6AcrmxIQmvSbTzVE5J/1ftcxGC3VlX0axk2IUXfzXoYIHHLq
         2vH3b6NlsYas1JgztdzQP4iH4kreh1rT9K/1uHS6DY5W2hvTVD0wLhE6myzKQhi9iwey
         CUvvyuKEGTdnVqrNpWJHGnFgAc+AwOTgzhvVEoaO5BMNphaYM3D0tUBVI0Lsa1/dWith
         V2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4tihMGS3ElCYUguFSIvEvXuQDG95gCqR3K5leSMmqQ=;
        b=oKVl4r+jaQgiBRo3k2bFjoriZul12z1Md7awyU9I5qhtpsa2Y0jxtepSRsqkVa8FLL
         zIusmhkyKy7dbPlB1pkdBn8sFxFcfQdiIcPv9/u4TOOuRzq9U91Hzox5O+FzEnG+oCNi
         dV3KtgadBU7A4wTV5DCBddvoiit5UdBnc7jv75u+kSH2ObOI5aOo1xl46qpXA7y9WHYP
         Hjs0TiQ7jm8Ckx/TFrTviITsptxs2r5K7GQ2XriYS1bWL1GwHSzznalz6Z+/9BPfbeHp
         bVqfZgA6mMB4WetQgheP7Fq/ZNsTJVEWwHS5/tg2Nv79meJWH9QoN/ivWTumshcfX7B6
         +/0A==
X-Gm-Message-State: AOAM533kmrZhFJQ9DAQZ3hMBGRIsbu6g2UPdcS2IxTnvkNwuWlqGQuTE
        9PoVcb+P8s6i3+M/y1jUsV2EFxLicpBtV9r9/zM=
X-Google-Smtp-Source: ABdhPJwzBIblpdCOMVMEJIwL/0hb5cC6jDdnPSAdiwBLu6GTdSFXV346FkplIBrYU1uA//AnWPCVl4H6eWlJmpMaatM=
X-Received: by 2002:aca:ec4d:: with SMTP id k74mr4964135oih.96.1602317730445;
 Sat, 10 Oct 2020 01:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <bdd0250e-4e14-f407-a584-f39af12c4e09@oracle.com>
 <CACZOiM2qKhogXQ_DXzWjGM5UCeCuEqT6wnR=f2Wi_T45_uoYHQ@mail.gmail.com> <b963565b-61d8-89d3-1abd-50cd8c8daad5@oracle.com>
In-Reply-To: <b963565b-61d8-89d3-1abd-50cd8c8daad5@oracle.com>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Sat, 10 Oct 2020 16:15:19 +0800
Message-ID: <CACZOiM26GPtqkGyecG=NGuB3etipV5-KgN+s19_U1WJrFxtYPQ@mail.gmail.com>
Subject: Re: [PATCH 00/35] Enhance memory utilization with DMEMFS
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, Paolo Bonzini <pbonzini@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jane Y Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 7:53 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 10/9/20 12:39 PM, yulei zhang wrote:
> > Joao, thanks a lot for the feedback. One more thing needs to mention
> > is that dmemfs also support fine-grained
> > memory management which makes it more flexible for tenants with
> > different requirements.
> >
> So as DAX when it allows to partition a region (starting 5.10). Meaning you have a region
> which you dedicated to userspace. That region can then be partitioning into devices which
> give you access to multiple (possibly discontinuous) extents with at a given page
> granularity (selectable when you create the device), accessed through mmap().
> You can then give that device to a cgroup. Or you can return that memory back to the
> kernel (should you run into OOM situation), or you recreate the same mappings across
> reboot/kexec.
>
> I probably need to read your patches again, but can you extend on the 'dmemfs also support
> fine-grained memory management' to understand what is the gap that you mention?
>

sure, dmemfs uses bitmap to track the memory usage in the reserved
memory region in
a given page size granularity. And for each user the memory can be
discrete as well.

> > On Fri, Oct 9, 2020 at 3:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>
> >> [adding a couple folks that directly or indirectly work on the subject]
> >>
> >> On 10/8/20 8:53 AM, yulei.kernel@gmail.com wrote:
> >>> From: Yulei Zhang <yuleixzhang@tencent.com>
> >>>
> >>> In current system each physical memory page is assocaited with
> >>> a page structure which is used to track the usage of this page.
> >>> But due to the memory usage rapidly growing in cloud environment,
> >>> we find the resource consuming for page structure storage becomes
> >>> highly remarkable. So is it an expense that we could spare?
> >>>
> >> Happy to see another person working to solve the same problem!
> >>
> >> I am really glad to see more folks being interested in solving
> >> this problem and I hope we can join efforts?
> >>
> >> BTW, there is also a second benefit in removing struct page -
> >> which is carving out memory from the direct map.
> >>
> >>> This patchset introduces an idea about how to save the extra
> >>> memory through a new virtual filesystem -- dmemfs.
> >>>
> >>> Dmemfs (Direct Memory filesystem) is device memory or reserved
> >>> memory based filesystem. This kind of memory is special as it
> >>> is not managed by kernel and most important it is without 'struct page'.
> >>> Therefore we can leverage the extra memory from the host system
> >>> to support more tenants in our cloud service.
> >>>
> >> This is like a walk down the memory lane.
> >>
> >> About a year ago we followed the same exact idea/motivation to
> >> have memory outside of the direct map (and removing struct page overhead)
> >> and started with our own layer/thingie. However we realized that DAX
> >> is one the subsystems which already gives you direct access to memory
> >> for free (and is already upstream), plus a couple of things which we
> >> found more handy.
> >>
> >> So we sent an RFC a couple months ago:
> >>
> >> https://lore.kernel.org/linux-mm/20200110190313.17144-1-joao.m.martins@oracle.com/
> >>
> >> Since then majority of the work has been in improving DAX[1].
> >> But now that is done I am going to follow up with the above patchset.
> >>
> >> [1]
> >> https://lore.kernel.org/linux-mm/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com/
> >>
> >> (Give me a couple of days and I will send you the link to the latest
> >> patches on a git-tree - would love feedback!)
> >>
> >> The struct page removal for DAX would then be small, and ticks the
> >> same bells and whistles (MCE handling, reserving PAT memtypes, ptrace
> >> support) that we both do, with a smaller diffstat and it doesn't
> >> touch KVM (not at least fundamentally).
> >>
> >>         15 files changed, 401 insertions(+), 38 deletions(-)
> >>
> >> The things needed in core-mm is for handling PMD/PUD PAGE_SPECIAL much
> >> like we both do. Furthermore there wouldn't be a need for a new vm type,
> >> consuming an extra page bit (in addition to PAGE_SPECIAL) or new filesystem.
> >>
> >> [1]
> >> https://lore.kernel.org/linux-mm/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com/
> >>
> >>
> >>> We uses a kernel boot parameter 'dmem=' to reserve the system
> >>> memory when the host system boots up, the details can be checked
> >>> in /Documentation/admin-guide/kernel-parameters.txt.
> >>>
> >>> Theoretically for each 4k physical page it can save 64 bytes if
> >>> we drop the 'struct page', so for guest memory with 320G it can
> >>> save about 5G physical memory totally.
> >>>
> >> Also worth mentioning that if you only care about 'struct page' cost, and not on the
> >> security boundary, there's also some work on hugetlbfs preallocation of hugepages into
> >> tricking vmemmap in reusing tail pages.
> >>
> >>   https://lore.kernel.org/linux-mm/20200915125947.26204-1-songmuchun@bytedance.com/
> >>
> >> Going forward that could also make sense for device-dax to avoid so many
> >> struct pages allocated (which would require its transition to compound
> >> struct pages like hugetlbfs which we are looking at too). In addition an
> >> idea <handwaving> would be perhaps to have a stricter mode in DAX where
> >> we initialize/use the metadata ('struct page') but remove the underlaying
> >> PFNs (of the 'struct page') from the direct map having to bear the cost of
> >> mapping/unmapping on gup/pup.
> >>
> >>         Joao
