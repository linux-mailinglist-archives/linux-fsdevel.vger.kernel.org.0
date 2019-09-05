Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735C6AA16A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 13:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733090AbfIELa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 07:30:29 -0400
Received: from verein.lst.de ([213.95.11.211]:48134 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfIELa3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:30:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3178868B05; Thu,  5 Sep 2019 13:30:25 +0200 (CEST)
Date:   Thu, 5 Sep 2019 13:30:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 00/25] erofs: patchset addressing Christoph's
 comments
Message-ID: <20190905113024.GA9314@lst.de>
References: <20190901055130.30572-1-hsiangkao@aol.com> <20190904020912.63925-1-gaoxiang25@huawei.com> <52a38cb7-b394-b8a8-7254-aafe47f2caa5@huawei.com> <20190905010328.GA15409@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905010328.GA15409@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 09:03:54AM +0800, Gao Xiang wrote:
> Could we submit these patches if these patches look good...
> Since I'd like to work based on these patches, it makes a difference
> to the current code though...

Yes, I'm fine with these patches.
