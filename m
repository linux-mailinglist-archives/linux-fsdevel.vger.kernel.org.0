Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA3E4456D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 17:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhKDQLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhKDQLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:11:30 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78582C061203
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 09:08:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id r28so5847914pga.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJc11Y8854aO1pDJriycOvwdVvyzfDm/4ES7HzJB+FM=;
        b=IsnPdnBom5LpEFlGcLWkFA9sW7xGG8iOp50ZHuzEB4vQDUSiDguPpZOqfovPfwIarp
         GsKSCbR87dHhdnK+ldotdA9Dbfq2sjEmSbTuQ5UY0613Wk7auCSP74m1QFrpDaW2u/sC
         ZFnFhs5kkVCJMWE6/gQem/FTNxnco9Y30Wvy+SRy6QWFEsRBD/sH0B/4cVB8fQZMJYli
         o/FUeNd9Wa9xTTJyrJOB/sjYPFO8bf/ZCsaOqjq5HfAtKNnJS7+bF/FxfdfxnSgKyRlE
         a8T4w8vcLyfYZYARqfbaz7B2UovGGoPthbHEqZGn0Bv1y/rPFtfapIWXuUDyDAgaUXj3
         4F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJc11Y8854aO1pDJriycOvwdVvyzfDm/4ES7HzJB+FM=;
        b=1uw8zPcae7Yk/L6AS8WTimgwh+xC7S+iLwO20d68f+8qrfWVHv4pbLfKJ05UwVusw0
         7hg4dgiMOMXo5hCmbVXBPIgZJvG1/5AUz9r9v9Ty3QVWGhnYccG3nO6LcGmNI1dtdo/i
         DYNqVNd9AHn9XsRD79xMHaaxT6qCCFYdiCVDhIJZBOzKoG7Y6BAk5uYp4kDW32QDlaAD
         X6GIj5yq+ZJo0WqIE3EF9NT2EODzUAdf1mq2u/8xKSVNGywap2JjM8+8arnqnEpkd5wN
         Oq7wjhQw/hLnMzu2GDIP/iKFAC2ck1ba15r9FYg+X5HLhkDdxCa9vrAEPaUkx+NBSwyC
         19aQ==
X-Gm-Message-State: AOAM5316mUkSPfLSe1STG2nTJANTsIBwZ8TzMMSPpf9/ZfSo//bYMwMi
        +mCNhx3eYplXljQa4nTpFBDYoQ0rns5nrv2PJKXjkA==
X-Google-Smtp-Source: ABdhPJyuzAAG5CU7otzDHpwNiRjP4pLsoDhcZ+jrxhUJJnHdOCa7XkPGXqg6HNGSe8SXKVxET1je/GYiOS8VYyK+gAE=
X-Received: by 2002:a63:6302:: with SMTP id x2mr22207191pgb.5.1636042131973;
 Thu, 04 Nov 2021 09:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211021001059.438843-1-jane.chu@oracle.com> <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com> <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com> <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia> <YYDYUCCiEPXhZEw0@infradead.org>
 <dfca8558-ad70-41d5-1131-63db66b70542@oracle.com> <CAPcyv4jLn4_SYxLtp_cUT=mm6Y3An22BA+sqex1S-CBnAm6qGA@mail.gmail.com>
 <YYObn+0juAFvH7Fk@infradead.org>
In-Reply-To: <YYObn+0juAFvH7Fk@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Nov 2021 09:08:41 -0700
Message-ID: <CAPcyv4jaCj=qDw-MHEcYjVGHYGvX8wbJ_d3kv5nnv7agHnMViQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA flag
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 4, 2021 at 1:36 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Nov 03, 2021 at 11:21:39PM -0700, Dan Williams wrote:
> > The concern I have with dax_clear_poison() is that it precludes atomic
> > error clearing.
>
> atomic as in clear poison and write the actual data?  Yes, that would
> be useful, but it is not how the Intel pmem support actually works, right?

Yes, atomic clear+write new data. The ability to atomic clear requires
either a CPU with the ability to overwrite cachelines without doing a
RMW cycle (MOVDIR64B), or it requires a device with a suitable
slow-path mailbox command like the one defined for CXL devices (see
section 8.2.9.5.4.3 Clear Poison in CXL 2.0).

I don't know why you think these devices don't perform wear-leveling
with spare blocks?

> > Also, as Boris and I discussed, poisoned pages should
> > be marked NP (not present) rather than UC (uncacheable) [1].
>
> This would not really have an affect on the series, right?  But yes,
> that seems like the right thing to do.

It would because the implementations would need to be careful to clear
poison in an entire page before any of it could be accessed. With an
enlightened write-path RWF flag or custom fault handler it could do
sub-page overwrites of poison. Not that I think the driver should
optimize for multiple failed cachelines in a page, but it does mean
dax_clear_poison() fails in more theoretical scenarios.

> > With
> > those 2 properties combined I think that wants a custom pmem fault
> > handler that knows how to carefully write to pmem pages with poison
> > present, rather than an additional explicit dax-operation. That also
> > meets Christoph's requirement of "works with the intended direct
> > memory map use case".
>
> So we have 3 kinds of accesses to DAX memory:
>
>  (1) user space mmap direct access.
>  (2) iov_iter based access (could be from kernel or userspace)
>  (3) open coded kernel access using ->direct_access
>
> One thing I noticed:  (2) could also work with kernel memory or pages,
> but that doesn't use MC safe access.

Yes, but after the fight to even get copy_mc_to_kernel() to exist for
pmem_copy_to_iter() I did not have the nerve to push for wider usage.

> Which seems like a major independent
> of this discussion.
>
> I suspect all kernel access could work fine with a copy_mc_to_kernel
> helper as long as everyone actually uses it,

All kernel accesses do use it. They either route to
pmem_copy_to_iter(), or like dm-writecache, call it directly. Do you
see a kernel path that does not use that helper?

> missing required bits of (2) and (3) together with something like the
> ->clear_poison series from Jane. We just need to think hard what we
> want to do for userspace mmap access.

dax_clear_poison() is at least ready to go today and does not preclude
adding the atomic and finer grained support later.
