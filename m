Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7103D1B5E20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDWOoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 10:44:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWOoQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:44:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75C7BAAC7;
        Thu, 23 Apr 2020 14:44:14 +0000 (UTC)
Date:   Thu, 23 Apr 2020 09:44:11 -0500
From:   'Goldwyn Rodrigues' <rgoldwyn@suse.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'LKML' <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, 'Hyunchul Lee' <hyc.lee@gmail.com>,
        'Eric Sandeen' <sandeen@sandeen.net>,
        'Sedat Dilek' <sedat.dilek@gmail.com>
Subject: Re: [ANNOUNCE] exfatprogs-1.0.2 version released
Message-ID: <20200423144411.hmby6ux2utdrqsls@fiona>
References: <CGME20200423084908epcas1p1b5d43c33b263b30844fc03a341f67413@epcas1p1.samsung.com>
 <004701d6194c$0d238990$276a9cb0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004701d6194c$0d238990$276a9cb0$@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Namjae,

On 17:49 23/04, Namjae Jeon wrote:
> This is the second release of exfatprogs since the initial version(1.0.1).
> We have received various feedbacks and patches since the previous release
> and applied them in this release. Thanks for feedback and patches!
> 
> According to Goldwyn's comments, We renamed the project name from
> exfat-utils to exfatprogs. However, There is an opinion that just renaming
> the name is not enough. Because the binary names(mkfs.exfat, fsck.exfat)
> still are same with ones in current exfat-utils RPM package.
> 
> If that's real problem, We are considering a long jump with 2.0.0 when adding
> repair feature.
> 
> Any feedback is welcome!:)

I agree with Eric. We can add "Conflicts" flag to make sure there are
conflicting capabilities in packages.

> 
> The major changes in this release:
>  * Rename project name to exfatprogs.
>  * label.exfat: Add support for label.exfat to set/get exfat volume label.
>  * Replace iconv library by standard C functions mbstowcs() and wcrtomb().
>  * Fix the build warnings/errors and add warning options.
>  * Fix several bugs(memory leak, wrong endian conversion, zero out beyond end of file) and cleanup codes
>  * Fix issues on big endian system and on 32bit system.
>  * Add support for Android build system.
> 
> The git tree is at:
>       https://github.com/exfatprogs/exfatprogs
> 
> The tarballs can be found at:
>       https://github.com/exfatprogs/exfatprogs/releases/tag/1.0.2
> 

Can we follow the standard of source tarballs be
<projectname>-<version>.tar.gz? In this case, exfat-1.0.2.tar.gz
instead of 1.0.2.tar.gz?

-- 
Goldwyn
