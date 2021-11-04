Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A374458F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhKDRxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhKDRxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:53:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D0C061203
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 10:51:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r5so8538221pls.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osVboQFSwbicbFoOXZ5IiYDe0f9yAlRkYm3/vpZd7R0=;
        b=k+wb762Bm6uC7nUGAIuXLPDquhbuJKeXB+otFAdYX3MKsbmwebAEGVbzhgsoHazR+0
         Ah7TZuenZJ/K+gr0gYZXqoPZQ3SFVjLV01XHhZtNeeMWkjTZdEd2ai1kK3CWe1/tSfzu
         GZFhWCJOT8ZqQKYrbOK1z7uO28zkUcqMzq4v7XMuD3FHrh2x5mBtzwWHDP0v7syTN0YT
         pCZgH4E3aAjbxZnefImOL2vFspqQ1iGDc/8c46jCDvXX3941fIUYn83Kgi45IaacRmhX
         5Rr48Sg9pDWJbXKJWcGFZqbKoQHcL70v9ZGL+TtN4tPvDBtjyst680AtscaCxLsJ+FE5
         Q+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osVboQFSwbicbFoOXZ5IiYDe0f9yAlRkYm3/vpZd7R0=;
        b=sALjFRd+74Io7j+dnC1aeM3qPqFWamwq8JD8hB1zud9QaGQMOJS9PWh2aahnp0xwE/
         fAZs+x7qPm7ORZN7Al8ISsRq5gmDraIZKHDw1tsiIMmkI9HJMK9UrHgqwVmQ+oLiqKoM
         oPml45cnx0Khio2nvScmwBxi0MNjPWvljOhbMDp42Hp/q9M8cEKa6FiR+ER03/0O1wn6
         2iAjkixGnzDASL2NJxJeToOe9wJIrmgOgFR8Mahu9snHwugAx0YiKzQyQeuzkPW7aj0z
         6WU44wCBGB77uINSoh37+2Za4tQXN0AP1Up2uunSac2I7K1/SjnsjTQNmI+rShm9Dcng
         VENw==
X-Gm-Message-State: AOAM531LjldviTP59UAHULPSZYKeX7A5/PrD4AJrePueCL/Tki2vY8ot
        3hhWyLmmTS6vw43duI175DHptTZgqksGLScvfA+8ow==
X-Google-Smtp-Source: ABdhPJzsfQp7zXod4oYdR7XV24jnJGfSVoHwbXv6Lmce3hecH1HMhLjovNQVYDTCF5q5Ti3Rxzt9aFXy52omn+Jgp9E=
X-Received: by 2002:a17:90a:6c47:: with SMTP id x65mr7439629pjj.8.1636048263654;
 Thu, 04 Nov 2021 10:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <YXJN4s1HC/Y+KKg1@infradead.org> <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org> <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com>
 <YYK/tGfpG0CnVIO4@infradead.org> <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
 <YYOaOBKgFQYzT/s/@infradead.org> <CAPcyv4jKHH7H+PmcsGDxsWA5CS_U3USHM8cT1MhoLk72fa9z8Q@mail.gmail.com>
 <YYQbu6dOCVB7yS02@infradead.org>
In-Reply-To: <YYQbu6dOCVB7yS02@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Nov 2021 10:50:53 -0700
Message-ID: <CAPcyv4gSESYBpd_9qtnZNFKBsVZY21VsZ2MxN10BHhcT1g_iQA@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA flag
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
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

On Thu, Nov 4, 2021 at 10:43 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Nov 04, 2021 at 09:24:15AM -0700, Dan Williams wrote:
> > No, the big difference with every other modern storage device is
> > access to byte-addressable storage. Storage devices get to "cheat"
> > with guaranteed minimum 512-byte accesses. So you can arrange for
> > writes to always be large enough to scrub the ECC bits along with the
> > data. For PMEM and byte-granularity DAX accesses the "sector size" is
> > a cacheline and it needed a new CPU instruction before software could
> > atomically update data + ECC. Otherwise, with sub-cacheline accesses,
> > a RMW cycle can't always be avoided. Such a cycle pulls poison from
> > the device on the read and pushes it back out to the media on the
> > cacheline writeback.
>
> Indeed.  The fake byte addressability is indeed the problem, and the
> fix is to not do that, at least on the second attempt.

Fair enough.

> > I don't understand what overprovisioning has to do with better error
> > management? No other storage device has seen fit to be as transparent
> > with communicating the error list and offering ways to proactively
> > scrub it. Dave and Darrick rightly saw this and said "hey, the FS
> > could do a much better job for the user if it knew about this error
> > list". So I don't get what this argument about spare blocks has to do
> > with what XFS wants? I.e. an rmap facility to communicate files that
> > have been clobbered by cosmic rays and other calamities.
>
> Well, the answer for other interfaces (at least at the gold plated
> cost option) is so strong internal CRCs that user visible bits clobbered
> by cosmic rays don't realisticly happen.  But it is a problem with the
> cheaper ones, and at least SCSI and NVMe offer the error list through
> the Get LBA status command (and I bet ATA too, but I haven't looked into
> that).  Oddly enough there has never been much interested from the
> fs community for those.

It seems the entanglement with 'struct page', error handling, and
reflink made people take notice. Hopefully someone could follow the
same plumbing we're doing for pmem to offer error-rmap help for NVME
badblocks.
