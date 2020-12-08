Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDAB2D20CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgLHC12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgLHC12 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:27:28 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CC3C061793
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 18:26:42 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so12390053pfu.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 18:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uyek9MkTmVFbzSBRjPGvZAHmGE/+Xxg4KtWWjpNIQM=;
        b=YPa5oW5Hgi1GhmfO+I8COAhhJ1zpJhBu3US5LoUescGZWhMX6Y3lQW0U3KTjwmn293
         fhctzsSt5F9cFgmK4rpOaoVzygUNv/wq0alLedG+kjPBThKbaDnIxgVVEnpKstL2f98S
         VlE7DpOtpIrICE5enlkHBREoTYhqvZW+vCfyCwfzgJrqLOLOF1JWnCq+C8BGfgYcqC8V
         kEAEiKYAvFcbyNPJnR9rVKS/Rt3z5c+UNoVCewMEvV1F4yVXI54ukFZmnOJG+6mRssyS
         UFSxwr0DtKP8q2Rf8O+wrblQwBigLOhR1/8jOT2rwGyN6a+A4uvUsKcmFHBa1+C5ojzM
         KX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uyek9MkTmVFbzSBRjPGvZAHmGE/+Xxg4KtWWjpNIQM=;
        b=BURf3+unRh+ZqJq9M2WVJtuzfh1ajCZDo1nuRu9kxe9X0CFFncYfTKUwVLCsTdHR1e
         d1AwADd99ZO9N0hy85+CGJ+ZbOaN6qXQH2SII94Ynd18Dk/YirQA4fE3G5tiAi7VunMT
         TRuOt35/SUo8EV9rBnu5ZtxQ3irtVcK95sPqX/Nrw7L9l6tbB7uZmOVCaQFAzabJa4No
         5VVMIi4oBOgfrHmegwLExsGdlvgvB/tSNc5xEr9kZ4Jkf/Dm27m5WEQtx2g8C9SKKfAO
         ktf4pyeGFpL9eelS3GsjdMIQE3psGHEaPkMNQVOXYSEK5RLmMDsSZlSfQ7j6JPAxxGs9
         Sktw==
X-Gm-Message-State: AOAM532phP+EuZHT0pxf1Yey46jItGpiy+irRk/cIFfOqkd0hmEhh0zQ
        Rffj5mAWjiBI6lEm5LbTk2RWMiLxqcoVceKgo2dFXg==
X-Google-Smtp-Source: ABdhPJyCq3UF1fpgl0WcY/IWKImwVBiH+TUtaeJ0hWsOuC6cDWgqA4zTZpgtjMbTdH04swBbXun4cYCZlCpRJYe1Y4Q=
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr1867229pjq.13.1607394401606;
 Mon, 07 Dec 2020 18:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
 <CAMZfGtWvLEytN5gBN+OqntrNXNd3eNRWrfnkeCozvARmpTNAXw@mail.gmail.com>
 <600fd7e2-70b4-810f-8d12-62cba80af80d@oracle.com> <CAMZfGtX2mu1tyE_898mQeEpmP4Pd+rEKOHpYF=KN=5v4WExpig@mail.gmail.com>
 <20201207183814.GA3786@localhost.localdomain>
In-Reply-To: <20201207183814.GA3786@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Dec 2020 10:26:05 +0800
Message-ID: <CAMZfGtVpTyUfpU7KXY8XZWxpguxLdZ=JmPAyHm4eipQ9o_Z6Bw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v7 00/15] Free some vmemmap pages of
 hugetlb page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, bp@alien8.de, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, mchehab+huawei@kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk,
        Peter Zijlstra <peterz@infradead.org>, luto@kernel.org,
        oneukum@suse.com, jroedel@suse.de,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        anshuman.khandual@arm.com, Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 8, 2020 at 2:38 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Fri, Dec 04, 2020 at 11:39:31AM +0800, Muchun Song wrote:
> > On Fri, Dec 4, 2020 at 7:49 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > As previously mentioned, I feel qualified to review the hugetlb changes
> > > and some other closely related changes.  However, this patch set is
> > > touching quite a few areas and I do not feel qualified to make authoritative
> > > statements about them all.  I too hope others will take a look.
> >
> > Agree. I also hope others can take a look at other modules(e.g.
> > sparse-vmemmap, memory-hotplug). Thanks for everyone's efforts
> > on this.
>
> I got sidetracked by some other stuff but I plan to continue reviewing
> this series.

Many thanks, Oscar.

>
> One thing that came to my mind is that if we do as David suggested in
> patch#4, and we move it towards the end to actually __enable__ this
> once all the infrastructure is there (unless hstate->nr_vmemmap_pages
> differs from 0 we should not be doing any work AFAIK), we could also
> move patch#6 to the end (right before the enablement), kill patch#7
> and only leave patch#13.
>
> The reason for that (killing patch#7 and leaving patch#13 only)
> is that it does not make much sense to me to disable PMD-mapped vmemmap
> depending on the CONFIG_HUGETLB_xxxxx as that is enabled by default
> to replace that later by the boot kernel parameter.
> It looks more natural to me to disable it when we introduce the kernel
> boot parameter, before the actual enablement of the feature.

Thanks for your suggestions. I agree with you. :)

>
> As I said, I plan to start the review again, but the order above would
> make more sense to me.
>
> thanks
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
