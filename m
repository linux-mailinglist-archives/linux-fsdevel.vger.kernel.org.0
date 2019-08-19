Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7C891CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 07:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfHSFrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 01:47:22 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:58588 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbfHSFrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:47:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 94ED253B3;
        Mon, 19 Aug 2019 05:47:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3873:3874:4321:4605:5007:7974:10004:10400:10848:11232:11233:11658:11914:12043:12296:12297:12679:12740:12760:12895:13019:13069:13071:13161:13229:13311:13357:13439:14180:14659:14721:21060:21080:21627:21740:30054:30056:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: salt01_5cf136d77bd2a
X-Filterd-Recvd-Size: 2569
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Aug 2019 05:47:18 +0000 (UTC)
Message-ID: <31cb3e54fe532630b45bb74ba4fc688eb86eab1f.camel@perches.com>
Subject: Re: [PATCH] erofs: Use common kernel logging style
From:   Joe Perches <joe@perches.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel <devel@driverdev.osuosl.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Date:   Sun, 18 Aug 2019 22:47:17 -0700
In-Reply-To: <20190819055243.GB30459@138>
References: <20190817082313.21040-1-hsiangkao@aol.com>
         <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
         <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
         <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
         <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
         <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
         <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
         <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
         <20190818092839.GA18975@hsiangkao-HP-ZHAN-66-Pro-G1>
         <52e4e3a7f160f5d2825bec04a3bc4eb4b0d1165a.camel@perches.com>
         <20190819055243.GB30459@138>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-08-19 at 13:52 +0800, Gao Xiang wrote:
> Hi Joe,

Hello.

> On Sun, Aug 18, 2019 at 10:28:41PM -0700, Joe Perches wrote:
> > Rename errln, infoln, and debugln to the typical pr_<level> uses
> > to the typical kernel styles of pr_<level>
> 
> How about using erofs_err / ... to instead that?

<shrug>  I've no opinion.
It seems most fs/*/* filesystems actually do use pr_<level>
sed works well if you want that.

>  - I can hardly see directly use pr_<level> for those filesystems in fs/...

just fyi:

There was this one existing pr_<level> use in erofs

drivers/staging/erofs/data.c:366:                               pr_err("%s, readahead error at page %lu of nid %llu\n",
drivers/staging/erofs/data.c-367-                                      __func__, page->index,
drivers/staging/erofs/data.c-368-                                      EROFS_V(mapping->host)->nid);



