Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FDE5E7E2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiIWPV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiIWPVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:21:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5371DF1933
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:20:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a8so753680lff.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=buJ2Vw0w3M4WrtI5/DU3oXsQobrkkmx9rFyElDeN7mE=;
        b=e4OQSAjFu3gpxUO4Unn7HPTzW4khEaeLVPKzk0HjIO1WzfoYTIkCo/F1RYrvwR66SF
         JwCMt5XxADhIKzoYXxMVuOAC/AuI4zxQZgSxUcFBjf8hrr2yXlfmAMcitgt6vZxhWH7Z
         +VIcwj2/Ns3wteLBkCd1UIvA6lB5eXh/e73AYfVmUkfoy7XbWsS6Q2HYL5D+SrhsOsPZ
         qOl0jP48UI31PUrNDZzwE9j3uXZ/4o/lWYfvXhojlsVXKd3GrscU+YcreZEHR9zMjYjf
         xc0uDmUYT7UwO9Q1pGoCLduSZHAasvlCEIMiRTg83bldOSofpAYj2YT99ZO5jc8hyvkT
         Y9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=buJ2Vw0w3M4WrtI5/DU3oXsQobrkkmx9rFyElDeN7mE=;
        b=7hqSh35/QUL6HsLUSyh52W0kl8QyObTh8NG3+Z/1M+48rzlVIaCicIt/biXlI7g8aL
         5y8P+qdhgKKXEw4vSQ6nUiPmRP/LS90JdBd8VGxnXSVjuUkFpXMzmF1PASgX3v1GKSsL
         EwBRHBRGjprbXpTE/lZGP1oY6nTn0jOTuEpQrvPerGZ3a6hrJ804N+jUb4hU8kPg751D
         zENw16iyg1EQp8dLZMVBYTYCH2M3vtAqp3lqdhLh1PxqLl91wDkhXxDSb+7qqUVboMuY
         FLtUooL5/VXISTjLSS9ewIf6rIIZRsLHONaWgSzGMPpFs8YT3OEPx3y28zeQrHOUbTdn
         0bkg==
X-Gm-Message-State: ACrzQf1Nm5RpRgxXcB0Tz6HU/DhOhL/zcldC8Fry1N6PAfvbnqSk8STZ
        YL0KJypklvSXPBMx3pIH5KpStcvkx1++JBFh6043gA==
X-Google-Smtp-Source: AMsMyM7tQgOI6niyU5IXyfNHgsog0iDYl0WXgb5yVh7a8oMMnxo4TbbSeRkhbm4RLcMIb8opCLgiEX29WHKjDwAENJs=
X-Received: by 2002:a05:6512:b85:b0:499:202a:bde9 with SMTP id
 b5-20020a0565120b8500b00499202abde9mr3630798lfv.550.1663946457534; Fri, 23
 Sep 2022 08:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com> <DS0PR11MB63734D4DF4C4F368805EC97DDC4E9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Yyy8Pp0Y4NRzIzNw@google.com> <20220923005319.wkzpl36uailh4zbw@box.shutemov.name>
In-Reply-To: <20220923005319.wkzpl36uailh4zbw@box.shutemov.name>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 23 Sep 2022 16:20:21 +0100
Message-ID: <CA+EHjTy+2JG_=Xw5ojwZAW6+3Nr4-4a8YCBxWN5PmAhh7jjT+A@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
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
        "Lutomirski, Andy" <luto@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, Sep 23, 2022 at 1:53 AM Kirill A . Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Thu, Sep 22, 2022 at 07:49:18PM +0000, Sean Christopherson wrote:
> > On Thu, Sep 22, 2022, Wang, Wei W wrote:
> > > On Thursday, September 15, 2022 10:29 PM, Chao Peng wrote:
> > > > +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> > > > +                  int *order)
> > >
> > > Better to remove "order" from this interface?
> >
> > Hard 'no'.
> >
> > > Some callers only need to get pfn, and no need to bother with
> > > defining and inputting something unused. For callers who need the "order",
> > > can easily get it via thp_order(pfn_to_page(pfn)) on their own.
> >
> > That requires (a) assuming the pfn is backed by struct page, and (b) assuming the
> > struct page is a transparent huge page.  That might be true for the current
> > implementation, but it most certainly will not always be true.
> >
> > KVM originally did things like this, where there was dedicated code for THP vs.
> > HugeTLB, and it was a mess.  The goal here is very much to avoid repeating those
> > mistakes.  Have the backing store _tell_ KVM how big the mapping is, don't force
> > KVM to rediscover the info on its own.
>
> I guess we can allow order pointer to be NULL to cover caller that don't
> need to know the order. Is it useful?

I think that would be useful. In pKVM we don't need to know the order,
and I had to use a dummy variable when porting V7.

Cheers,
/fuad


> --
>   Kiryl Shutsemau / Kirill A. Shutemov
