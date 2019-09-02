Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B80A5C20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfIBSLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 14:11:49 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:58928 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbfIBSLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 14:11:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BF9D618224D8A;
        Mon,  2 Sep 2019 18:11:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:877:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2551:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3874:4184:4250:4321:4423:5007:6119:7576:7903:7996:9545:10004:10400:10848:10967:11026:11232:11473:11658:11914:12043:12050:12296:12297:12438:12555:12663:12740:12760:12895:12986:13439:13848:14096:14097:14180:14181:14659:14721:21060:21080:21451:21611:21627:21740:21810:30054:30060:30090:30091,0,RBL:47.151.137.30:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:34,LUA_SUMMARY:none
X-HE-Tag: heat65_83e2ed7ab5f20
X-Filterd-Recvd-Size: 3481
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  2 Sep 2019 18:11:46 +0000 (UTC)
Message-ID: <f7f8f751e77578edb88c0d9888930de3f3b60670.camel@perches.com>
Subject: Re: linux-next: Tree for Sep 2 (exfat)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 02 Sep 2019 11:11:45 -0700
In-Reply-To: <13e2db80-0c89-0f36-6876-f9639f0d30ab@infradead.org>
References: <20190902224310.208575dc@canb.auug.org.au>
         <cecc2af6-7ef6-29f6-569e-b591365e45ad@infradead.org>
         <20190902174631.GB31445@kroah.com>
         <13e2db80-0c89-0f36-6876-f9639f0d30ab@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-09-02 at 11:07 -0700, Randy Dunlap wrote:
> On 9/2/19 10:46 AM, Greg KH wrote:
> > On Mon, Sep 02, 2019 at 10:39:39AM -0700, Randy Dunlap wrote:
> > > On 9/2/19 5:43 AM, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > News: I will only be doing 2 more releases before I leave for Kernel
> > > > Summit (there may be some reports on Thursday, but I doubt I will have
> > > > time to finish the full release) and then no more until Sept 30.
> > > > 
> > > > Changes since 20190830:
> > > > 
> > > 
> > > Hi,
> > > I am seeing lots of exfat build errors when CONFIG_BLOCK is not set/enabled.
> > > Maybe its Kconfig should also say
> > > 	depends on BLOCK
> > > ?
> > 
> > Here's what I committed to my tree:
> > 
> > 
> > From e2b880d3d1afaa5cad108c29be3e307b1917d195 Mon Sep 17 00:00:00 2001
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: Mon, 2 Sep 2019 19:45:06 +0200
> > Subject: staging: exfat: make exfat depend on BLOCK
> > 
> > This should fix a build error in some configurations when CONFIG_BLOCK
> > is not selected.  Also properly set the dependancy for no FAT support at
> > the same time.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> That works. Thanks.
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> > ---
> >  drivers/staging/exfat/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
> > index f52129c67f97..290dbfc7ace1 100644
> > --- a/drivers/staging/exfat/Kconfig
> > +++ b/drivers/staging/exfat/Kconfig
> > @@ -1,11 +1,13 @@
> >  config EXFAT_FS
> >  	tristate "exFAT fs support"
> > +	depends on BLOCK
> >  	select NLS
> >  	help
> >  	  This adds support for the exFAT file system.
> >  
> >  config EXFAT_DONT_MOUNT_VFAT
> >  	bool "Prohibit mounting of fat/vfat filesysems by exFAT"
> > +	depends on EXFAT_FS
> >  	default y
> >  	help
> >  	  By default, the exFAT driver will only mount exFAT filesystems, and refuse

I think this last one is backwards and should be

config EXFAT_ALLOW_MOUNT_VFAT
and
default n

> 
> 

