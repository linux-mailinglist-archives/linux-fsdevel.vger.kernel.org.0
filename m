Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BA53FB9F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhH3QRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbhH3QRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:17:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E78C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 09:16:26 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f15so29218768ybg.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=939bu+vC3jVVcLM9PeqTLcUxKeTQvKl0T/UCGWNALp8=;
        b=ITcI2RF50tbf5jpbW8hW2EUztHNlrwGsnfhzC6mjwauuNvS7Ua57LXmxQsEnU6SN4T
         lto0AKR9E+HNrA9uKZlePPX15hLOkKucpln1AUjIYkD7r7xSa3cKuEc7anPJF1svsnfO
         i6BGb2efCdpIl7cKmaMjc0QMbb/duELn6Xi+FOJIky16dA00UFatdp/+ivybREcLter0
         eVp/pctX4PieOXuJmI7pr65UDYdEmRdtGBnMrUvXdskwjfGi+hEO4yAY2WV23PIUXpod
         3Xz7s5C5n7uMdSMZy2ShvmwViZLPojKgRtCfw/fWgP7Z7fPUiarooICeuhOQppGopW13
         13yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=939bu+vC3jVVcLM9PeqTLcUxKeTQvKl0T/UCGWNALp8=;
        b=fNbJGTJeuNtFPWsZyW8XAzjuY3gLJLQuwd29ulZygW4o+OG7eZyVuQcyfwbEoKblz3
         c1CFWxV6kL6GLt9+zoagU2ZLAV8PZ7Z1HQwhNRMIZl8uUs+5ZmUJa5xNFrMD6sJpb7Kc
         qtblwZwChc8Ge6Zj6f6/RxtSUXu6oIjaYRKh3Fhl6HNtNtq4kMncM+8DOSpQ0vkCVlf4
         gnGXri1hcG2qFmTZpTTr6jj6PIThp3tAiOXDcZjPey4gMHaZ5cSuov4duYYtus7gCllY
         I6ukl6KqSY4ogD4NIpCdVhYmDCbKZZfkdEIAUVMna2Oy6CQt5R+9yvIMaa/Ve6rPDiiC
         JVBw==
X-Gm-Message-State: AOAM530O5h4KiuoLcAVhGorKgKqGA5hwfiE5qJcKWTrJmQJd1kVd/Ag+
        K4sBObrwc0J0Iy8yBY31wigMH5Q+f+Iqdj1qnG+oWg==
X-Google-Smtp-Source: ABdhPJxpO4KRrWzp9HPBWsZPHteLt3ldMMBKdPlVWSrBRAgXZx0fVjGjzTe9UARBxOQ2FzMofCcoEJhTK10UQiuzOkM=
X-Received: by 2002:a25:2f84:: with SMTP id v126mr23529062ybv.397.1630340185705;
 Mon, 30 Aug 2021 09:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-3-surenb@google.com>
 <YSmVl+DEPrU6oUR4@casper.infradead.org> <202108272228.7D36F0373@keescook>
 <CAJuCfpEWc+eTLYp_Xf9exMJCO_cFtvBUzi39+WbcSKZBXHe3SQ@mail.gmail.com> <f7117620-28ba-cfa5-b2c6-21812f15e4d6@rasmusvillemoes.dk>
In-Reply-To: <f7117620-28ba-cfa5-b2c6-21812f15e4d6@rasmusvillemoes.dk>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 30 Aug 2021 09:16:14 -0700
Message-ID: <CAJuCfpHXF34THa=zVcRozYiLA9QPeNyU09WvyJFKk=ZjCq0ZZw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm: add a field to store names for private
 anonymous memory
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 1:12 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 28/08/2021 23.47, Suren Baghdasaryan wrote:
> > On Fri, Aug 27, 2021 at 10:52 PM Kees Cook <keescook@chromium.org> wrote:
> >>
> >>>> +   case PR_SET_VMA_ANON_NAME:
> >>>> +           name = strndup_user((const char __user *)arg,
> >>>> +                               ANON_VMA_NAME_MAX_LEN);
> >>>> +
> >>>> +           if (IS_ERR(name))
> >>>> +                   return PTR_ERR(name);
> >>>> +
> >>>> +           for (pch = name; *pch != '\0'; pch++) {
> >>>> +                   if (!isprint(*pch)) {
> >>>> +                           kfree(name);
> >>>> +                           return -EINVAL;
> >>>
> >>> I think isprint() is too weak a check.  For example, I would suggest
> >>> forbidding the following characters: ':', ']', '[', ' '.  Perhaps
>
> Indeed. There's also the issue that the kernel's ctype actually
> implements some almost-but-not-quite latin1, so (some) chars above 0x7f
> would also pass isprint() - while everybody today expects utf-8, so the
> ability to put almost arbitrary sequences of chars with the high bit set
> could certainly confuse some parsers. IOW, don't use isprint() at all,
> just explicitly check for the byte values that we and up agreeing to
> allow/forbid.
>
> >>> isalnum() would be better?  (permit a-zA-Z0-9)  I wouldn't necessarily
> >>> be opposed to some punctuation characters, but let's avoid creating
> >>> confusion.  Do you happen to know which characters are actually in use
> >>> today?
> >>
> >> There's some sense in refusing [, ], and :, but removing " " seems
> >> unhelpful for reasonable descriptors. As long as weird stuff is escaped,
> >> I think it's fine. Any parser can just extract with m|\[anon:(.*)\]$|
> >
> > I see no issue in forbidding '[' and ']' but whitespace and ':' are
> > currently used by Android. Would forbidding or escaping '[' and ']' be
> > enough?
>
> how about allowing [0x20, 0x7e] except [0x5b, 0x5d], i.e. all printable
> (including space) ascii characters, except [ \ ] - the brackets as
> already discussed, and backslash because then there's nobody who can get
> confused about whether there's some (and then which?) escaping mechanism
> in play - "\n" is simply never going to appear. Simple rules, easy to
> implement, easy to explain in a man page.

Thanks for the suggestion, Rasmus. I'm all for keeping it simple.
Kees, Matthew, would that be acceptable?

>
> >>
> >> For example, just escape it here instead of refusing to take it. Something
> >> like:
> >>
> >>         name = strndup_user((const char __user *)arg,
> >>                             ANON_VMA_NAME_MAX_LEN);
> >>         escaped = kasprintf(GFP_KERNEL, "%pE", name);
>
> I would not go down that road. First, it makes it much harder to explain
> the rules for what are allowed and not allowed. Second, parsers become
> much more complicated. Third, does the length limit then apply to the
> escaped or unescaped string?
>
> Rasmus
