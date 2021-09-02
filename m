Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CDE3FF329
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 20:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346896AbhIBSWZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 14:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhIBSWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:22:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99B5261041;
        Thu,  2 Sep 2021 18:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630606886;
        bh=44DLHjL939OemOnIN1/VdzLyyxAZ2hVSWSI7E3ypWvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZO3g5S/N3lilzVtOABmurSqX4WR8b3Q2yohwgQbgd00ue248U0DSuWQaXgQsiKmU
         jSx0eo7eAHLYO1wLo2pO2snJwG0XrsyESDus912BITtP/+IdcmRcnNpLcqwbn75RUj
         m1D1wqSL9WYCOnTWvnvZaYQE4hBI0tLwmRxsC3KTRQ2gRITj+qY3Kz4GH6wx02z1KB
         VggxEueaCiiPuhueoexcH2BLCjh9x3MlFIcCn6nTeswTUiqqHjaY1Tb/GiEGAf5RmK
         edTE/CemVojmSou7B36A1cLXTHWU/tCiP7hlUWYm4Z2TP+3FZRRBfNfSOAaeQUOwoB
         Sckv4hMqwDQPg==
Date:   Fri, 3 Sep 2021 02:20:55 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huang Jianan <huangjianan@oppo.com>,
        Yue Hu <huyue2@yulong.com>, Miao Xie <miaoxie@huawei.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Subject: Re: [GIT PULL] erofs updates for 5.15-rc1
Message-ID: <20210902182053.GB26537@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huang Jianan <huangjianan@oppo.com>, Yue Hu <huyue2@yulong.com>,
        Miao Xie <miaoxie@huawei.com>, Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 09:18:59AM -0700, Linus Torvalds wrote:
> On Tue, Aug 31, 2021 at 4:00 PM Gao Xiang <xiang@kernel.org> wrote:
> >
> > All commits have been tested and have been in linux-next. Note that
> > in order to support iomap tail-packing inline, I had to merge iomap
> > core branch (I've created a merge commit with the reason) in advance
> > to resolve such functional dependency, which is now merged into
> > upstream. Hopefully I did the right thing...
> 
> It all looks fine to me. You have all the important parts: what you
> are merging, and _why_ you are merging it.
> 
> So no complaints, and thanks for making it explicit in your pull
> request too so that I'm not taken by surprise.

Yeah, thanks. That was my first time to merge another tree due to hard
dependency like this. I've gained some experience from this and will be
more confident on this if such things happen in the future. :)

Thanks,
Gao Xiang

> 
>          Linus
