Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518353FA7E9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhH1WWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 18:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1WV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 18:21:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03579C061756;
        Sat, 28 Aug 2021 15:21:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so9974085pjb.1;
        Sat, 28 Aug 2021 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6Li8Xzq3GZpRD4yRN9H4niugZXTcIcOHoay7QTmmqc=;
        b=i199VmbLftiUhfm5w9TMwG+4Zf15RGuEdy9vUNnpXVkRH8IKECoWxujWMKUM6b84Xj
         vJIt4AyP193AT6JMaZqM2108oM703qbcQXepEStj+SyN34yY5kAbjEpMOLGRfvEnhLwD
         Yw/zR35PCA1ul7az8DVV6WxmaAmrVxAjUhxlMJYrp5LwHhJhncGjh+kEO6C+xUOwIYIK
         HGZRfwPHEz91HYwm0f0LbEqHi8eFfah3zdtLG65KiyNGXMieukAjYa8GmhDCRYzKMtkJ
         a/N3lSlUJEK/v4Iu5eztYUtd5dIYRDNtlqGhxh5lAkVeMe1c5VFf3McWOZ9uFYYtGopY
         f0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6Li8Xzq3GZpRD4yRN9H4niugZXTcIcOHoay7QTmmqc=;
        b=e4hUbu3fbwQM2zstgIZvxxBCSsQe2x77fe060r4oGQon99KQn2VU21iWWDOlt6MVIx
         M5RvzYFHw9vzwS0SBdZFAcetMMaz8tkbekpxu/eAoVTAOP9L1JVrxDeNuu3ODFdVeWOh
         F419tbrWRnxiY68Rr16N+HCFtuL9ile0QLN1uUKziZENHful4ZMzxJR3Q2khRwG54rET
         XLLtJzeFAqGZFOWBsZJ0sDTdc8reafTzUQ45tCC+NnnHEVrYkgMngq3yFL5lSkmoqZtU
         gu1jLqFrUqSkDBt7MSr1L2aLUQfJBiwaTPrmiaRbhIE1gQQw/ZJmPlLT6tPkAQvsbWjA
         tFDg==
X-Gm-Message-State: AOAM530jCRaylwgaPPnMG/7QPh3xWPzMr1z4LH1CukAYDHpsszy87mmM
        5oJniNSedg5l4oQlE2WYLXUVASTcoh8FZd5G6LY=
X-Google-Smtp-Source: ABdhPJz5Ffz08GjVQcWFqoF1crFop4nyJwqZjDMwOjo601G/TSenqG6Qmt+G6ELqJMjIOGz8touEqFLJCNdEjf1f3Wg=
X-Received: by 2002:a17:90a:eb0d:: with SMTP id j13mr18377241pjz.163.1630189268569;
 Sat, 28 Aug 2021 15:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk> <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk> <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk> <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSlftta38M4FsWUq@zeniv-ca.linux.org.uk> <20210827232246.GA1668365@agluck-desk2.amr.corp.intel.com>
 <87r1edgs2w.ffs@tglx> <YSqy+U/3lnF6K0ia@zeniv-ca.linux.org.uk> <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
In-Reply-To: <YSq0mPAIBfqFC/NE@zeniv-ca.linux.org.uk>
From:   Tony Luck <tony.luck@intel.com>
Date:   Sat, 28 Aug 2021 15:20:58 -0700
Message-ID: <CA+8MBbLLze0siip=h-2hR3XiceBFQCN7uh5BPvqYRyBXgT318g@mail.gmail.com>
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, Borislav Petkov <bp@alien8.de>,
        X86-ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 28, 2021 at 3:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> BTW, is #MC triggered on stored to a poisoned cacheline?  Existence of CLZERO
> would seem to argue against that...

No #MC on stores. Just on loads. Note that you can't clear poison
state with a series of small writes to the cache line. But a single
64-byte store might do it (architects didn't want to guarantee that
it would work when I asked about avx512 stores to clear poison
many years ago).

-Tony
