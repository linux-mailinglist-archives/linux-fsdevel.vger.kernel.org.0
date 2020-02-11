Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141D5159B85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 22:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgBKVpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 16:45:22 -0500
Received: from smtprelay0002.hostedemail.com ([216.40.44.2]:35935 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727361AbgBKVpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 16:45:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id F0EAE45BC;
        Tue, 11 Feb 2020 21:45:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:4321:4605:5007:7514:8660:8957:10004:10400:10848:11026:11232:11658:11914:12043:12050:12297:12555:12740:12760:12895:13069:13148:13230:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21810:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dad09_4b9b27a703123
X-Filterd-Recvd-Size: 1989
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Feb 2020 21:45:19 +0000 (UTC)
Message-ID: <161f395543309adb94475cbfbdd442616b68cda9.camel@perches.com>
Subject: Re: [PATCH 07/22] staging: exfat: Rename variable "MilliSecond" to
 "milli_second"
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 11 Feb 2020 13:44:03 -0800
In-Reply-To: <20200127115530.GZ1847@kadam>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
         <20200127101343.20415-8-pragat.pandya@gmail.com>
         <20200127115530.GZ1847@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-01-27 at 14:55 +0300, Dan Carpenter wrote:
> On Mon, Jan 27, 2020 at 03:43:28PM +0530, Pragat Pandya wrote:
> > Change all the occurrences of "MilliSecond" to "milli_second" in exfat.
> > 
> > Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> > ---
> >  drivers/staging/exfat/exfat.h       |  2 +-
> >  drivers/staging/exfat/exfat_super.c | 16 ++++++++--------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> > index 85fbea44219a..5c207d715f44 100644
> > --- a/drivers/staging/exfat/exfat.h
> > +++ b/drivers/staging/exfat/exfat.h
> > @@ -228,7 +228,7 @@ struct date_time_t {
> >  	u16      hour;
> >  	u16      minute;
> >  	u16      second;
> > -	u16      MilliSecond;
> > +	u16      milli_second;
> 
> Normally we would just call it "ms".

msec is a bit more common.


