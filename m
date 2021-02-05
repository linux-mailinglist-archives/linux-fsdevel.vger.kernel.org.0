Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0EB3104D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 07:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhBEGBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 01:01:00 -0500
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:33568 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230379AbhBEGA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:00:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3255B182CED2A;
        Fri,  5 Feb 2021 06:00:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3874:4321:5007:6119:7514:7652:10004:10400:10848:11232:11658:11914:12296:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21611:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: song61_3716dc4275e2
X-Filterd-Recvd-Size: 1998
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  5 Feb 2021 06:00:16 +0000 (UTC)
Message-ID: <0c62fcfacca67bfef2275040da7150602fd2003a.camel@perches.com>
Subject: Re: [PATCH v2 1/3] fs/efs: Use correct brace styling for statements
From:   Joe Perches <joe@perches.com>
To:     Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 04 Feb 2021 22:00:13 -0800
In-Reply-To: <20210205051429.553657-2-enbyamy@gmail.com>
References: <20210205051429.553657-1-enbyamy@gmail.com>
         <20210205051429.553657-2-enbyamy@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-02-04 at 21:14 -0800, Amy Parker wrote:
> Many single-line statements have unnecessary braces, and some statement 
> pairs have mismatched braces. This is a clear violation of the kernel 
> style guide, which mandates that single line statements have no braces 
> and that pairs with at least one multi-line block maintain their braces.
> 
> This patch fixes these style violations. Single-line statements that 
> have braces have had their braces stripped. Pair single-line statements 
> have been formatted per the style guide. Pair mixed-line statements have 
> had their braces updated to conform.
> 
> Signed-off-by: Amy Parker <enbyamy@gmail.com>
> ---
>  fs/efs/inode.c | 10 ++++++----
>  fs/efs/super.c | 15 ++++++---------
>  2 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/efs/inode.c b/fs/efs/inode.c
> @@ -120,8 +120,10 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
>  			device = 0;
>  		else
>  			device = MKDEV(sysv_major(rdev), sysv_minor(rdev));
> -	} else
> +	}
> +	else {

Not the kernel specified style.

	} else {

Try using checkpatch on your proposed patches.


