Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE130445D16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 01:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhKEAtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhKEAtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 20:49:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43CFC061205
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 17:46:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id np3so1977652pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 17:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MDx1GrQOub7zJ6Bty8NHKGO6IrOVwg4Q81dxTNGuQk=;
        b=z1/ZhSMbHBPL6xzuOjXk5p5q8nj06Ql+kZbdIIDYl2CXDWH4nHvtvPlsJceWFuEGIF
         myQd9Ksfn0kR9uPGa8zftxWOEOG59ZNoGv1CtLfKrvIUpSB7vYlJGNyyZekRAnKXBD7N
         hsybPk2pAfClRxwqPoUjS45Zg5Tq6fAbsnpeF1TjYVSUzg7Sa1GGmQMgocz6Ur7p+kyh
         NjRzOqs4+/kxpk/kJVoKkUYXZuLzbiNNMBoikc2mVwUAK+rMppBW6zq18u8KusKY6kd/
         kZS0fDZuKBAfOGbMeFC9mp4qg0YUwo8+QioiDMxufM4dq7qAm4W3NRici1vzeQprCAsJ
         OqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MDx1GrQOub7zJ6Bty8NHKGO6IrOVwg4Q81dxTNGuQk=;
        b=hba19oCr824/oILHphv7NV2Qxi7hrCTaOrMP2VM/DR/dqpR+xbJgr7EiHgkon1PfXH
         gQnQ94V+fKoxdEXMpzIoswr6h1vNYM1kpo4ZQ/F88bFYqwz1WB8xO4PkeHXTp1l55u9r
         9DrjrGLYC3U28eStWAsp/s653jg9z/7k7+ofkytZflDH85vaWBe63z3bALv1WBxZzg1I
         iDUaVTmHLz900gTlAJON8/z/dzKE0W22H1ZvJetBGM9DmQ7R0YOHdGdakqq6n3RKktIY
         39cutbPTl7lWDbwBcohk0gt3kxRikJR+r00KVAA/KNcfRdaVgAshrOoyOdcdFKr8E5g8
         iN/A==
X-Gm-Message-State: AOAM533naONV7wgSXLidxM6zBc6q03EmG/wf4HkT06vkMIhW2KaxI6XM
        3iPQEhbvuNj1PD8rxmTvnI6//m7qyUh6g75yi9F7QA==
X-Google-Smtp-Source: ABdhPJzBlY9sEgYPXRy5uLLbIJXLqIS5AXvLIJiE838XFcN7i811yjUHS7Ho7WZmKGzY4qGtN0/EXqtZX8wW5x0PKF4=
X-Received: by 2002:a17:902:b697:b0:141:c7aa:e10f with SMTP id
 c23-20020a170902b69700b00141c7aae10fmr35263948pls.18.1636073186843; Thu, 04
 Nov 2021 17:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <YXFPfEGjoUaajjL4@infradead.org> <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org> <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org> <20211028002451.GB2237511@magnolia>
 <YYDYUCCiEPXhZEw0@infradead.org> <CAPcyv4j8snuGpy=z6BAXogQkP5HmTbqzd6e22qyERoNBvFKROw@mail.gmail.com>
 <YYK/tGfpG0CnVIO4@infradead.org> <CAPcyv4it2_PVaM8z216AXm6+h93frg79WM-ziS9To59UtEQJTA@mail.gmail.com>
 <YYOaOBKgFQYzT/s/@infradead.org> <CAPcyv4jKHH7H+PmcsGDxsWA5CS_U3USHM8cT1MhoLk72fa9z8Q@mail.gmail.com>
 <6d21ece1-0201-54f2-ec5a-ae2f873d46a3@oracle.com> <CAPcyv4hJjcy2TnOv-Y5=MUMHeDdN-BCH4d0xC-pFGcHXEU_ZEw@mail.gmail.com>
 <342eb71c-0aff-77e5-3c71-92224d7d48e0@oracle.com>
In-Reply-To: <342eb71c-0aff-77e5-3c71-92224d7d48e0@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Nov 2021 17:46:17 -0700
Message-ID: <CAPcyv4hVu+A0PXgXTwWj3SBimP5pjX_97g+sfGeT47P0-SJkiQ@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with RWF_RECOVERY_DATA flag
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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

On Thu, Nov 4, 2021 at 1:27 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> On 11/4/2021 12:00 PM, Dan Williams wrote:
>
> >>
> >> If this understanding is in the right direction, then I'd like to
> >> propose below changes to
> >>     dax_direct_access(), dax_copy_to/from_iter(), pmem_copy_to/from_iter()
> >>     and the dm layer copy_to/from_iter, dax_iomap_iter().
> >>
> >> 1. dax_iomap_iter() rely on dax_direct_access() to decide whether there
> >>      is likely media error: if the API without DAX_F_RECOVERY returns
> >>      -EIO, then switch to recovery-read/write code.  In recovery code,
> >>      supply DAX_F_RECOVERY to dax_direct_access() in order to obtain
> >>      'kaddr', and then call dax_copy_to/from_iter() with DAX_F_RECOVERY.
> >
> > I like it. It allows for an atomic write+clear implementation on
> > capable platforms and coordinates with potentially unmapped pages. The
> > best of both worlds from the dax_clear_poison() proposal and my "take
> > a fault and do a slow-path copy".
> >
> >> 2. the _copy_to/from_iter implementation would be largely the same
> >>      as in my recent patch, but some changes in Christoph's
> >>      'dax-devirtualize' maybe kept, such as DAX_F_VIRTUAL, obviously
> >>      virtual devices don't have the ability to clear poison, so no need
> >>      to complicate them.  And this also means that not every endpoint
> >>      dax device has to provide dax_op.copy_to/from_iter, they may use the
> >>      default.
> >
> > Did I miss this series or are you talking about this one?
> > https://lore.kernel.org/all/20211018044054.1779424-1-hch@lst.de/
>
> I was referring to
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dax-devirtualize
> that has not come out yet, I said early on that I'll rebase on it,
> but looks like we still need pmem_copy_to/from_iter(), so.

Yeah, since the block-layer divorce gets rid of the old poison
clearing path, then we're back to pmem_copy_to_iter() (or something
like it) needing to pick up the slack for poison clearing. I do agree
it would be nice to clean up all the unnecessary boilerplate, but the
error-list coordination requires a driver specific callback. At least
the DAX_F_VIRTUAL flag can eliminate the virtiofs and fuse callbacks.
