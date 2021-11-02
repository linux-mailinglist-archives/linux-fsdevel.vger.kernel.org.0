Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCBF4435BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhKBSlO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 14:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbhKBSlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:41:11 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A4FC061203
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Nov 2021 11:38:36 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b4so183776pgh.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Nov 2021 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtwMNok/oS+uqbAcXvNbRmtV8aoGFRlPvBnKAS2OABs=;
        b=dkUsvt1FXSekVZLjszihzsGgRAeAnAB1GtlL1olNIkdMTc4Vzi+c12TbSA89d04EW5
         gK9VzjcQECAHmGa50uE2H/MGxFR3hVZSMH8sMfk2Is/mMBolgXd4IIaocWJjwi7UPXaG
         D3L2CSxsIcC749fCI0qafHRFXV3Gj+UNrXyNJ40Uhb3JfVADYVrrv/wSxEhLH49B/1O6
         xgkuA5r39aUvYXzviXoh9fZ9NBg4tqkuqeNBOmyJICyt2o2dO8qJ7VfQpZfg2bjGmFEX
         1qGA2X4LMRtJPesld/eEpsJH2K1UA8G+nJ8BH/mvroNC23RdSOhFuh+LiZ1gY5fxE4iD
         gNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtwMNok/oS+uqbAcXvNbRmtV8aoGFRlPvBnKAS2OABs=;
        b=IhbIgpz924Z5LuRrUsh0EtoNfh+GBRMlJdpWjggk9T2MYq4RYagUUhMmZuRBkuENU0
         vTFYuylHQ6gmPEHiZMRzhZ4tzB72UhyYpZKsD+1dMJt8tfbY6eLqVTIJP4QuOeObOCkG
         2YQrlaXIMvCyDqbCeqPJoKEii73uJsg76EEge/zRfHTs/b6Cpl+4sIUTsQ/pNR9rdAwT
         tu0Eb76KGb6JmiMEnfkMGhwu56sLZ6ScVlwwltMMTW2+dePjSeh3AEYILoXb3cSAHQRy
         KOomVwRtThhQ2v1tCIIJSNTLgXmOyO24qcnGJ0gVdCjYq2i7Ykq4heAi8b/vDGWlwdqu
         KFow==
X-Gm-Message-State: AOAM532xlmaiEX1PgLb/dE6I0S+12CkFLcYiXSLsOX9qdF3qPssDdWHM
        b4m5aQeMRTxzDfc7MLLWd3gSHC9POTNVROl7YqQuRw==
X-Google-Smtp-Source: ABdhPJyVRrrsb4RUC9XUP9L6QjFp/rQ6P5+Rlce6y59oRmwUDtlYFYFCdn9M2NfT/WwqSdkvL1KAQXuQxGtpnLSrITI=
X-Received: by 2002:a63:3fcd:: with SMTP id m196mr28982342pga.417.1635878315614;
 Tue, 02 Nov 2021 11:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211028205854.830200-1-almasrymina@google.com>
 <2fede4d2-9d82-eac9-002b-9a7246b2c3f8@redhat.com> <CAHS8izMckg03uLB0vrTGv2g-_xmTh1LPRc2P8sfnmL-FK5A8hg@mail.gmail.com>
 <e02b1a75-58ab-2b8a-1e21-5199e3e3c5e9@redhat.com> <CAHS8izOkvuZ2pEGZXaYb0mfwC3xwpvXSgc9S+u_R-0zLWjzznQ@mail.gmail.com>
 <9fd0a86f-c012-4bb7-78eb-7413346448e0@redhat.com>
In-Reply-To: <9fd0a86f-c012-4bb7-78eb-7413346448e0@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 2 Nov 2021 11:38:23 -0700
Message-ID: <CAHS8izOrwiUrMD=QYjpda3trMkHLaK4UuAee_zvnmPj1h6Lycg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Add /proc/$PID/pageflags
To:     David Hildenbrand <david@redhat.com>
Cc:     Nathan Lewis <npl@google.com>, Yu Zhao <yuzhao@google.com>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 2, 2021 at 4:42 AM David Hildenbrand <david@redhat.com> wrote:
>
> >> Bit 58-60 are still free, no? Bit 57 was recently added for uffd-wp
> >> purposes I think.
> >>
> >> #define PM_SOFT_DIRTY           BIT_ULL(55)
> >> #define PM_MMAP_EXCLUSIVE       BIT_ULL(56)
> >> #define PM_UFFD_WP              BIT_ULL(57)
> >> #define PM_FILE                 BIT_ULL(61)
> >> #define PM_SWAP                 BIT_ULL(62)
> >> #define PM_PRESENT              BIT_ULL(63)
> >>
> >> PM_MMAP_EXCLUSIVE and PM_FILE already go into the direction of "what is
> >> mapped" IMHO. So just a thought if something in there (PM_HUGE? PM_THP?)
> >> ... could make sense.
> >>
> >
> > Thanks! I _think_ that would work for us, I'll look into confirming.
> > To be honest I still wonder if eventually different folks will find
> > uses for other page flags and eventually we'll run out of pagemaps
> > bits, but I'll yield to whatever you think is best here.
>
> Using one of the remaining 3 bits should be fine. In the worst case,
> we'll need pagemap_ext at some point that provides more bits per PFN, if
> we ever run out of bits.
>

That sounds great to me. Thank you Both Matthew and David for
patiently explaining the concerns with /proc/self/pageflags to me and
suggesting alternatives that could work :-)

> But as mentioned by Matthew, extending mincore() could also work: not
> only indicating if the page is resident, but also in which "form" it is
> resident.
>

I need to learn more about mincore() to be honest, from casually
reading some docs I didn't get a full understanding on if/why that
would work better. I'll do some investigating and upload V2 either
with /proc/self/pagemaps or mincore() and why I chose such and we can
go from there.

> We could separate the cases "cont PTE huge page" vs. "PMD huge page".
>

So to be completely honest (and I need to confirm), we are using this
on x86 and we essentially care that the virt address is mapped by 2MB,
so mapped by PMD. I think (but need to confirm) that's what the
pageflags HUGE bit refers to as well as does PageHuge() and
TransPageHuge(). After confirming I'll upload V2 with the precise info
we need (I think it's going to be "PMD huge page" as David says).

> I recall that the information (THP / !THP) might be valuable for users:
> there was a discussion to let user space decide where to place THP.
> (IIRC madvise() extension to have something like MADV_COLLAPSE_THP /
> MADV_DISSOLVE_THP)
>
> --
> Thanks,
>
> David / dhildenb
>
