Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B3F3D553F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 10:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhGZHhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 03:37:04 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:19119 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231707AbhGZHhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:37:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uh-wICr_1627287439;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Uh-wICr_1627287439)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Jul 2021 16:17:21 +0800
Date:   Mon, 26 Jul 2021 16:17:19 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <YP5vj0c56iMLoDfS@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas =?utf-8?Q?Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>, linux-erofs@lists.ozlabs.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4zUvnBCAb86Mny@B-P7TQMD6M-0146.local>
 <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMKZP8b3TbRv3D-pcrE_iDU5TKUFHst9emuQmRPntFSArA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:08:06AM +0200, Andreas Grünbacher wrote:
> Am Mo., 26. Juli 2021 um 06:00 Uhr schrieb Gao Xiang

...

> >
> > iomap_inline_buf() was suggested by Darrick. From my point of view,
> > I think it's better since it's a part of iomap->inline_data due to
> > pos involved.
> 
> I find iomap_inline_buf a bit more confusing because it's not
> immediately obvious that "buf" == "data".
> 
> I'll send an updated version.

Okay, thank you very much!

Thanks,
Gao Xiang

> 
> Thanks,
> Andreas
