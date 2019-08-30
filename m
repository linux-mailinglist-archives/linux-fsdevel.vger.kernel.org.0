Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E0A3607
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3LvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 07:51:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbfH3LvW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:51:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E999AFF2;
        Fri, 30 Aug 2019 11:51:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 690C2DA809; Fri, 30 Aug 2019 13:51:42 +0200 (CEST)
Date:   Fri, 30 Aug 2019 13:51:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190830115142.GM2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chao Yu <yuchao0@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
 <20190829111810.GA23393@kroah.com>
 <20190829151144.GJ23584@kadam>
 <20190829152757.GA125003@architecture4>
 <20190829154346.GK23584@kadam>
 <cd38b645-2930-3e02-6c6a-5972ea02b537@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd38b645-2930-3e02-6c6a-5972ea02b537@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:06:25AM +0800, Chao Yu wrote:
> On 2019/8/29 23:43, Dan Carpenter wrote:
> >> p.s. There are 2947 (un)likely places in fs/ directory.
> > 
> > I was complaining about you adding new pointless ones, not existing
> > ones.  The likely/unlikely annotations are supposed to be functional and
> > not decorative.  I explained this very clearly.
> > 
> > Probably most of the annotations in fs/ are wrong but they are also
> > harmless except for the slight messiness.  However there are definitely
> > some which are important so removing them all isn't a good idea.
> 
> Hi Dan,
> 
> Could you please pick up one positive example using likely and unlikely
> correctly? so we can follow the example, rather than removing them all blindly.

Remove all of them and re-add with explanation if and how each is going
to make things better. If you can't reason about, prove by benchmarks or
point to inefficient asm code generated, then don't add them again.

The feedback I got from CPU and compiler people over the years is not to
bother using the annotations. CPUs are doing dynamic branch prediction
and compilers are applying tons of optimizations.

GCC docs state about the builtin: "In general, you should prefer to use
actual profile feedback for this (-fprofile-arcs), as programmers are
notoriously bad at predicting how their programs actually perform."
(https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html)
