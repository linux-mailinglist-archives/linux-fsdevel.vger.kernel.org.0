Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638703D5C85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhGZOSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 10:18:33 -0400
Received: from verein.lst.de ([213.95.11.211]:45604 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234126AbhGZOSc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:18:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC39C67373; Mon, 26 Jul 2021 16:58:58 +0200 (CEST)
Date:   Mon, 26 Jul 2021 16:58:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Jianan <huangjianan@oppo.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v8] iomap: make inline data support more flexible
Message-ID: <20210726145858.GA14066@lst.de>
References: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726145734.214295-1-hsiangkao@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me:

Signed-off-by: Christoph Hellwig <hch@lst.de>
