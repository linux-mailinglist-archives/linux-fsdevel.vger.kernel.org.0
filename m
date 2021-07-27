Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2483D79D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhG0Pax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 11:30:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57793 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232698AbhG0Paj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:30:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UhAApBh_1627399832;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UhAApBh_1627399832)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Jul 2021 23:30:34 +0800
Date:   Tue, 27 Jul 2021 23:30:31 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re:
Message-ID: <YQAml8DRs4dTWS2n@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
References: <20210727025956.80684-1-hsiangkao@linux.alibaba.com>
 <20210727151051.GH8572@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210727151051.GH8572@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 08:10:51AM -0700, Darrick J. Wong wrote:
> I'll change the subject to:
> 
> iomap: support reading inline data from non-zero pos

I'm fine with this too. Many thanks for updating!

Thanks,
Gao Xiang

