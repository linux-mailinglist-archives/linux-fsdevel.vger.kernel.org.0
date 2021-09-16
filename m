Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7F40EA96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbhIPTFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 15:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344813AbhIPTFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:05:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0219C06639D
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 11:40:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e7so7044758pgk.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wf67Cflfm8IYYsTzaYKBdKTyyIkowqSuJvIyiG8CUCY=;
        b=LvlvtWTKlD9s/EDivdE4mILBwFWDacQU+lTor8a93tgHOXWU9Jp17vq0h3RX4ogJjN
         DVLh6goKK3t5EHBKcD6gMMpy7qnqsMS/0B6dWGUuyi4lJ0Z/Zgl4lhfSEARlWNyDkJk8
         PTt3irJB9bwoir0gqUfmv7MClmERI2AdcVOEJYG8BrkHFLVEDTLbempK83vBXFiIFhXq
         P+E12qv6w7MDRccMJuObh/6EEkzrslmfLzfOtkIqPvTt5XDZJ8JVeY9yc6l4TZ0k1GwY
         HnuSiSoamLaphKntM41GgfAPVBlUnM1GwZZLJl9I/3psnuonX+9T+KuqE/5ruoj2w6f+
         h4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wf67Cflfm8IYYsTzaYKBdKTyyIkowqSuJvIyiG8CUCY=;
        b=4wcyYbJm0fPY0z2zCl+elZNTZX+QlYf5Y9bG2XiheWYQBbX8HjtsgMav0GeGZ2/KAS
         tejjhvhc1woC1upywB/ZZ4QSfls88ls+PAYGr/Tggmm/0H3eOBL75EHVweCKgFuif6CN
         Fr+8UtnF+Eggo0qBEMUm12sSXrFPzrJqiiT1cb20Opr4L2QDjfbr3Ace/0uugVzzHrXC
         U5RrvPHkZPxLER53O/jkd4exBuaa/cPpT41+/W33nLCjgiuAZ/Qsuzw8q1iyB/c0Kxqq
         ss4oGA1uWKVvJML5oMzrLUdTHPZEpURcUa543xuhfTOMg7LGWLM8PpYs0hOQ4ScyR6FP
         BDVQ==
X-Gm-Message-State: AOAM531jjymhXeqnZNmOGMSXQ9oPw74fwRkG6ZMc7jciZzlTZ7D5HzEb
        ePNDrZd2Z8xwccLh6uLKyzlmgVfZUZfPdy6ENqs+XQ==
X-Google-Smtp-Source: ABdhPJzELJdpBHezctnL7cSPyzwljRxL/PM+INjo/MR1amWdcvrpzwpjsPu/TvVdYHWHVeKNatCqBtUgaI9XGGs40LI=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr6491253pfb.3.1631817639221; Thu, 16
 Sep 2021 11:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210914233132.3680546-1-jane.chu@oracle.com> <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com> <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com> <YULuMO86NrQAPcpf@infradead.org>
In-Reply-To: <YULuMO86NrQAPcpf@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Sep 2021 11:40:28 -0700
Message-ID: <CAPcyv4g_qPBER2W+OhCf29kw-+tjs++TsTiRGWgX3trv11+28A@mail.gmail.com>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jane Chu <jane.chu@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 12:12 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Sep 15, 2021 at 01:27:47PM -0700, Dan Williams wrote:
> > > Yeah, Christoph suggested that we make the clearing operation explicit
> > > in a related thread a few weeks ago:
> > > https://lore.kernel.org/linux-fsdevel/YRtnlPERHfMZ23Tr@infradead.org/
> >
> > That seemed to be tied to a proposal to plumb it all the way out to an
> > explicit fallocate() mode, not make it a silent side effect of
> > pwrite().
>
> Yes.
>
> > >
> > > Each of the dm drivers has to add their own ->clear_poison operation
> > > that remaps the incoming (sector, len) parameters as appropriate for
> > > that device and then calls the lower device's ->clear_poison with the
> > > translated parameters.
> > >
> > > This (AFAICT) has already been done for dax_zero_page_range, so I sense
> > > that Dan is trying to save you a bunch of code plumbing work by nudging
> > > you towards doing s/dax_clear_poison/dax_zero_page_range/ to this series
> > > and then you only need patches 2-3.
> >
> > Yes, but it sounds like Christoph was saying don't overload
> > dax_zero_page_range(). I'd be ok splitting the difference and having a
> > new fallocate clear poison mode map to dax_zero_page_range()
> > internally.
>
> That was my gut feeling.  If everyone feels 100% comfortable with
> zeroingas the mechanism to clear poisoning I'll cave in.  The most
> important bit is that we do that through a dedicated DAX path instead
> of abusing the block layer even more.

...or just rename dax_zero_page_range() to dax_reset_page_range()?
Where reset == "zero + clear-poison"?

> > > > BTW, our customer doesn't care about creating dax volume thru DM, so.
> > >
> > > They might not care, but anything going upstream should work in the
> > > general case.
> >
> > Agree.
>
> I'm really worried about both patartitions on DAX and DM passing through
> DAX because they deeply bind DAX to the block layer, which is just a bad
> idea.  I think we also need to sort that whole story out before removing
> the EXPERIMENTAL tags.

I do think it was a mistake to allow for DAX on partitions of a pmemX
block-device.

DAX-reflink support may be the opportunity to start deprecating that
support. Only enable DAX-reflink for direct mounting on /dev/pmemX
without partitions (later add dax-device direct mounting), change
DAX-experimental warning to a deprecation notification for DAX on
DM/partitions, continue to fail / never fix DAX-reflink for
DM/partitions, direct people to use namespace provisioning for
sub-divisions of PMEM capacity, and finally look into adding
concatenation and additional software striping support to the new CXL
region creation facility.
