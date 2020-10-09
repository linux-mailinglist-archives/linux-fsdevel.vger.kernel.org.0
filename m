Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138C72887EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388142AbgJILkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731908AbgJILkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:40:00 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DCCC0613D2;
        Fri,  9 Oct 2020 04:39:59 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m11so8652483otk.13;
        Fri, 09 Oct 2020 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXsB/QVQRYyXFbKxYCEyS3/5LBs8o136vGIU2Jgeew0=;
        b=X/OvMvqMRAC510RhUV8pSOUwthMvQ2dTBGynnk184JaqGE1m+pcEPtDFBuCBYX4kY4
         Jj5u8u73BPjXJE+UXn9iVKjtZ4qqsAMcGqP24Haet3K/pg7xu0oqEQulI/vOsRzQKu8g
         1tOugOLsMLuuMD33qnnf8pjyVu0uskmsjyxoGdBcnlMU2ZQXBUDmW3r6NU3L9M7wL8vN
         JF0sELrt6ngM0S/Ltl2WpQQtwNChb5LpP2BqKtqI3k6vLTANbPKaL7CKZlmvF/9u/WdX
         KCNHVtLmvXhHzSS/uk3PRTQ6uZPiYaq1Uk9gejNLOgtfiEoKrOXjxqrO5h5Cm9mrqKh3
         JcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXsB/QVQRYyXFbKxYCEyS3/5LBs8o136vGIU2Jgeew0=;
        b=giAhRcinAdG/8DzJTwxC1E2JF1KAI3G+HOARqUMhzUxCt6sJaLeDkHewrzM9NNZw5X
         rmF9C56p5b2wzrfk7ees+TIl6gwmsV0Vpx8OGSsosonWMN0RCeAAALMrp//yT727nvn3
         tIvWwKOJQnF65c/gFFf7x5SUHQCqsvS/gMsNO9lEJiseTrOeDJ4909JQe66eSZKCVaxs
         52NfsfUE9F6DppBbdctZGq5KqH4BmskKTH5eLR8A8U+2ZNMWeAfHf302ZlEXtYmTG28w
         C9eJt4YSAXh23TbPI6WbXkTtClJdyzVDusiRkg7QN6ss0w6LzvJ6rotHH98Ht/GIlZVn
         aZ0Q==
X-Gm-Message-State: AOAM530OOA3FB45TMoBH+MTrTInKL/rUAz6CR/XufsuTYwQ475yzrA0T
        iebGv2RC6rIPSDyHRdNcDHzoM9Zu3UCr0BXbWik=
X-Google-Smtp-Source: ABdhPJy68YZcI0wwimcOeMZsDG/1H0xEIksRYNZLcYIPR6NmZldSZXo9t7sGWbaIUNrENfudIP970EH/+3bouXCFse4=
X-Received: by 2002:a9d:d13:: with SMTP id 19mr8829529oti.116.1602243599317;
 Fri, 09 Oct 2020 04:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <bdd0250e-4e14-f407-a584-f39af12c4e09@oracle.com>
In-Reply-To: <bdd0250e-4e14-f407-a584-f39af12c4e09@oracle.com>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Fri, 9 Oct 2020 19:39:47 +0800
Message-ID: <CACZOiM2qKhogXQ_DXzWjGM5UCeCuEqT6wnR=f2Wi_T45_uoYHQ@mail.gmail.com>
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

Joao, thanks a lot for the feedback. One more thing needs to mention
is that dmemfs also support fine-grained
memory management which makes it more flexible for tenants with
different requirements.

On Fri, Oct 9, 2020 at 3:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> [adding a couple folks that directly or indirectly work on the subject]
>
> On 10/8/20 8:53 AM, yulei.kernel@gmail.com wrote:
> > From: Yulei Zhang <yuleixzhang@tencent.com>
> >
> > In current system each physical memory page is assocaited with
> > a page structure which is used to track the usage of this page.
> > But due to the memory usage rapidly growing in cloud environment,
> > we find the resource consuming for page structure storage becomes
> > highly remarkable. So is it an expense that we could spare?
> >
> Happy to see another person working to solve the same problem!
>
> I am really glad to see more folks being interested in solving
> this problem and I hope we can join efforts?
>
> BTW, there is also a second benefit in removing struct page -
> which is carving out memory from the direct map.
>
> > This patchset introduces an idea about how to save the extra
> > memory through a new virtual filesystem -- dmemfs.
> >
> > Dmemfs (Direct Memory filesystem) is device memory or reserved
> > memory based filesystem. This kind of memory is special as it
> > is not managed by kernel and most important it is without 'struct page'.
> > Therefore we can leverage the extra memory from the host system
> > to support more tenants in our cloud service.
> >
> This is like a walk down the memory lane.
>
> About a year ago we followed the same exact idea/motivation to
> have memory outside of the direct map (and removing struct page overhead)
> and started with our own layer/thingie. However we realized that DAX
> is one the subsystems which already gives you direct access to memory
> for free (and is already upstream), plus a couple of things which we
> found more handy.
>
> So we sent an RFC a couple months ago:
>
> https://lore.kernel.org/linux-mm/20200110190313.17144-1-joao.m.martins@oracle.com/
>
> Since then majority of the work has been in improving DAX[1].
> But now that is done I am going to follow up with the above patchset.
>
> [1]
> https://lore.kernel.org/linux-mm/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com/
>
> (Give me a couple of days and I will send you the link to the latest
> patches on a git-tree - would love feedback!)
>
> The struct page removal for DAX would then be small, and ticks the
> same bells and whistles (MCE handling, reserving PAT memtypes, ptrace
> support) that we both do, with a smaller diffstat and it doesn't
> touch KVM (not at least fundamentally).
>
>         15 files changed, 401 insertions(+), 38 deletions(-)
>
> The things needed in core-mm is for handling PMD/PUD PAGE_SPECIAL much
> like we both do. Furthermore there wouldn't be a need for a new vm type,
> consuming an extra page bit (in addition to PAGE_SPECIAL) or new filesystem.
>
> [1]
> https://lore.kernel.org/linux-mm/159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com/
>
>
> > We uses a kernel boot parameter 'dmem=' to reserve the system
> > memory when the host system boots up, the details can be checked
> > in /Documentation/admin-guide/kernel-parameters.txt.
> >
> > Theoretically for each 4k physical page it can save 64 bytes if
> > we drop the 'struct page', so for guest memory with 320G it can
> > save about 5G physical memory totally.
> >
> Also worth mentioning that if you only care about 'struct page' cost, and not on the
> security boundary, there's also some work on hugetlbfs preallocation of hugepages into
> tricking vmemmap in reusing tail pages.
>
>   https://lore.kernel.org/linux-mm/20200915125947.26204-1-songmuchun@bytedance.com/
>
> Going forward that could also make sense for device-dax to avoid so many
> struct pages allocated (which would require its transition to compound
> struct pages like hugetlbfs which we are looking at too). In addition an
> idea <handwaving> would be perhaps to have a stricter mode in DAX where
> we initialize/use the metadata ('struct page') but remove the underlaying
> PFNs (of the 'struct page') from the direct map having to bear the cost of
> mapping/unmapping on gup/pup.
>
>         Joao
