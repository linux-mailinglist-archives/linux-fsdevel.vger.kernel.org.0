Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A671599B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgBKT0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 14:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgBKT0Q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:26:16 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D8320637;
        Tue, 11 Feb 2020 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581449176;
        bh=BP1X49GBVhtO7J9Mxx4rEnC2+jALec49Ut+zDmtg/6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GzVg36cvpotIo2pYXPWTFNNRLfCgZLYTwIYZkLi6ZbGVoBZtjOZ498AzvS5KyfVIA
         LcxMoMYp3XK3bePOVonxsPpNPUaaA6GnTeUszsLUo5Pno2ZcLaQ+ObcGD1x2vcTFlC
         qjsmCbKk98a6yqPdV0Zip823GubPQ8GC2CRZWRBU=
Date:   Tue, 11 Feb 2020 11:26:15 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2 00/19] Renaming some identifiers.
Message-ID: <20200211192615.GA1967960@kroah.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:05:39AM +0530, Pragat Pandya wrote:
> This patchset renames following nineteen variables in exfat.h
> Fix checkpatch warning: Avoid CamelCase
>  -Year->year
>  -Day->day
>  -Hour->hour
>  -Minute->minute
>  -Second->second
>  -Millisecond->millisecond
>  -FatType->fat_type
>  -ClusterSize->cluster_size
>  -NumClusters->num_clusters
>  -FreeClusters->free_clusters
>  -UsedClusters->used_clusters
>  -Name->name
>  -ShortName->short_name
>  -Attr->attr
>  -NumSubdirs->num_subdirs
>  -CreateTimestamp->create_timestamp
>  -ModifyTimestamp->modify_timestamp
>  -AccessTimestamp->access_timestamp
> 
> v2:
>  -Correct misplaced quatation character in subject line(s).
>  -Remove unnecessary '_'(underscore) character in renaming of identifier
>   MilliSecond.
>  -Drop commits renaming unused structure members.

Not all of these patches applied, so can you please rebase against my
testing tree and resend the remaining patches?

thanks,

greg k-h
