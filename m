Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A893A219A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfH2Q70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 12:59:26 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:48847 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726893AbfH2Q70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:59:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6D17A182251B3;
        Thu, 29 Aug 2019 16:59:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2525:2553:2559:2563:2682:2685:2693:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:8603:9025:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12663:12740:12760:12895:12986:13069:13161:13229:13311:13357:13439:14180:14181:14659:14721:21060:21080:21627:21939:30012:30054:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:29,LUA_SUMMARY:none
X-HE-Tag: pen83_8c14c4bdf600f
X-Filterd-Recvd-Size: 3280
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Aug 2019 16:59:22 +0000 (UTC)
Message-ID: <74c4784319b40deabfbaea92468f7e3ef44f1c96.camel@perches.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
From:   Joe Perches <joe@perches.com>
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date:   Thu, 29 Aug 2019 09:59:21 -0700
In-Reply-To: <20190829164442.GA203852@architecture4>
References: <20190828170022.GA7873@kroah.com>
         <20190829062340.GB3047@infradead.org> <20190829063955.GA30193@kroah.com>
         <20190829094136.GA28643@infradead.org> <20190829095019.GA13557@kroah.com>
         <20190829103749.GA13661@infradead.org> <20190829111810.GA23393@kroah.com>
         <20190829151144.GJ23584@kadam> <20190829152757.GA125003@architecture4>
         <20190829154346.GK23584@kadam> <20190829164442.GA203852@architecture4>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2019-08-30 at 00:44 +0800, Gao Xiang wrote:
> Hi Dan,
> 
> On Thu, Aug 29, 2019 at 11:43:46PM +0800, Dan Carpenter wrote:
> > > p.s. There are 2947 (un)likely places in fs/ directory.
> > 
> > I was complaining about you adding new pointless ones, not existing
> > ones.  The likely/unlikely annotations are supposed to be functional and
> > not decorative.  I explained this very clearly.
> > 
> > Probably most of the annotations in fs/ are wrong but they are also
> > harmless except for the slight messiness.  However there are definitely
> > some which are important so removing them all isn't a good idea.
> > 
> > > If you like, I will delete them all.
> > 
> > But for erofs, I don't think that any of the likely/unlikely calls have
> > been thought about so I'm fine with removing all of them in one go.
> 
> Anyway, I have removed them all in
> https://lore.kernel.org/r/20190829163827.203274-1-gaoxiang25@huawei.com/
> 
> Does it look good to you?

Unrelated bikeshed from a trivial look:

There's a block there that looks like:

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
[]
@@ -70,7 +70,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 		}
 
 		err = bio_add_page(bio, page, PAGE_SIZE, 0);
-		if (unlikely(err != PAGE_SIZE)) {
+		if (err != PAGE_SIZE) {
 			err = -EFAULT;
 			goto err_out;
 		}

The initial assignment to err is odd as it's not
actually an error value -E<FOO> but a int size
from a unsigned int len.

Here the return is either 0 or PAGE_SIZE.

This would be more legible to me as:

		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
			err = -EFAULT;
			goto err_out;
		}


