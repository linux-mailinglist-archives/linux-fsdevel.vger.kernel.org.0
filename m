Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6CE37C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439796AbfJXQX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 12:23:28 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:48995 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405586AbfJXQX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:23:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id EF6CC182CF66E;
        Thu, 24 Oct 2019 16:23:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:960:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3872:3873:3874:4321:5007:7875:8784:10004:10400:11232:11658:11914:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:14721:21080:21433:21627:21810:30012:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: vest79_1df99958b091f
X-Filterd-Recvd-Size: 2247
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Oct 2019 16:23:25 +0000 (UTC)
Message-ID: <db3315695d3ea493e05f63f3b21fb3a1482293fd.camel@perches.com>
Subject: Re: [PATCH 00/15] staging: exfat: Clean up return codes
From:   Joe Perches <joe@perches.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Oct 2019 09:23:24 -0700
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-10-24 at 11:53 -0400, Valdis Kletnieks wrote:
> The code had its own non-standard FFS_FOO return codes. Go through
> and convert them all the kernel standard -EFOO codes.
> 
> Valdis Kletnieks (15):
>   staging: exfat: Clean up return codes - FFS_FULL
>   staging: exfat: Clean up return codes - FFS_NOTFOUND
>   staging: exfat: Clean up return codes - FFS_DIRBUSY
>   staging: exfat: Clean up return codes - FFS_PERMISSIONERR
>   staging: exfat: Clean up return codes - FFS_NAMETOOLONG
>   staging: exfat: Clean up return codes - FFS_FILEEXIST
>   staging: exfat: Clean up return codes - FFS_INVALIDPATH
>   staging: exfat: Clean up return code - FFS_MEMORYERR
>   staging: exfat: Clean up return codes - FFS_FORMATERR
>   staging: exfat: Clean up return codes - FFS_MEDIAERR
>   staging: exfat: Clean up return codes - FFS_EOF
>   staging: exfat: Clean up return codes - FFS_INVALIDFID
>   staging: exfat: Clean up return codes - FFS_ERROR
>   staging: exfat: Clean up return codes - remove unused codes
>   staging: exfat: Clean up return codes - FFS_SUCCESS

All well and good, but does converting the error code from
positive to negative have any impact on any of the code
paths that use these return values?

	if (error > 0)
vs
	if (error < 0)

?

If you've gone through all the return tests,
then it would be nice to say so.


