Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63C03DD575
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 14:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhHBMPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 08:15:55 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55492 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233498AbhHBMPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:15:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UhmnTvb_1627906541;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UhmnTvb_1627906541)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Aug 2021 20:15:42 +0800
Date:   Mon, 2 Aug 2021 20:15:41 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v9] iomap: Support file tail packing
Message-ID: <YQfh7V0lvLNx0QlR@B-P7TQMD6M-0146.local>
Mail-Followup-To: Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
 <CAHc6FU5x3XOTyu8vooReSZ-hacfTdo3cu7wFJRcQrfTH8NkVeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHc6FU5x3XOTyu8vooReSZ-hacfTdo3cu7wFJRcQrfTH8NkVeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andreas,

On Sun, Aug 01, 2021 at 02:03:33PM +0200, Andreas Gruenbacher wrote:
> On Tue, Jul 27, 2021 at 5:00 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

...

> > +static int iomap_write_begin_inline(struct inode *inode,
> > +               struct page *page, struct iomap *srcmap)
> > +{
> > +       /* needs more work for the tailpacking case, disable for now */
> 
> Nit: the comma should be a semicolon or period here.

Sorry for some delay (busy in other things...)

Yeah, that's fine to me, in English contexts it'd be better like that
(there is some punctuation rule difference between languages.)


Hi Darrick,
Should I resend v10 for this punctuation change or could you kindly
help revise this?

(btw, would you mind set up a for-next iomap branch so I could rebase
 other EROFS patches on iomap for-next, thank you very much!)

Thanks,
Gao Xiang
