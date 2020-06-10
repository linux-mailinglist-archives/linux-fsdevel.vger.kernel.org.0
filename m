Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC181F5713
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgFJOxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 10:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgFJOxu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:53:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBAC2072F;
        Wed, 10 Jun 2020 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591800830;
        bh=TC73ZRDSuoUg0mbgkZG8iBdzAr9faRcRABDM7yMly28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFu/AplpxtnCVEq78ohceG29T7SYBjPC5HIAjxG+hxCRxeLrPsNRy6j26NYJwFeJ3
         QvsLuNdCVS76nhPuHuTAwnK+XQfju0sw8jNByZiGyMECclLQF04DAR+Z4IqXPkEVqP
         MgQGPcl1Ntz21ulzRCF6E58ON+T9q5eiGmmkIeOE=
Date:   Wed, 10 Jun 2020 16:53:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: exfat: Improving exception handling in two functions
Message-ID: <20200610145344.GA2102023@kroah.com>
References: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
 <208cba7b-e535-c8e0-5ac7-f15170117a7f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <208cba7b-e535-c8e0-5ac7-f15170117a7f@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:27:58AM +0200, Markus Elfring wrote:
> Hello,
> 
> I have taken another look at pointer usage after calls of the function “brelse”.
> My source code analysis approach pointed implementation details
> like the following out for further software development considerations.
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/fs/exfat/namei.c?id=3d155ae4358baf4831609c2f9cd09396a2b8badf#n1078
> 
> …
> 		epold = exfat_get_dentry(sb, p_dir, oldentry + 1, &old_bh,
> 			&sector_old);
> 		epnew = exfat_get_dentry(sb, p_dir, newentry + 1, &new_bh,
> 			&sector_new);
> 		if (!epold || !epnew)
> 			return -EIO;
> …
> 
> I suggest to split such an error check.
> How do you think about to release a buffer head object for the desired
> exception handling if one of these function calls succeeded?
> 
> Would you like to adjust such code in the functions “exfat_rename_file”
> and “exfat_move_file”?
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
