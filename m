Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE82CB59B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 08:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbgLBHPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 02:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgLBHPU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:15:20 -0500
Date:   Wed, 2 Dec 2020 09:14:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606893279;
        bh=r9lBvNLf060yzQHPZcKoDIPwOZLCXF+OC0jER6EqYE8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=wT49VF25j17+qMQAVEXVRjsH4L8jOTzl07zqrb3R6/MykEtip20Xt9J18zFMOaZ2v
         UIE8Gqusz6j75TITTsJbOfI3E3FfrTzJ6BOWagH5bzy9BLdh+yt2jnejJgPuPHA9os
         2VTy7RW8ddzE/3xCPSiM0eGtnB7iUkiaQi7so7e4=
From:   Mike Rapoport <rppt@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 00/13] arch, mm: deprecate DISCONTIGMEM
Message-ID: <20201202071427.GD751215@kernel.org>
References: <43c53597-6267-bdc2-a975-0aab5daa0d37@physik.fu-berlin.de>
 <20201117062316.GB370813@kernel.org>
 <a7d01146-77f9-d363-af99-af3aee3789b4@physik.fu-berlin.de>
 <20201201102901.GF557259@kernel.org>
 <e3d5d791-8e4f-afcc-944c-24f66f329bd7@physik.fu-berlin.de>
 <20201201121033.GG557259@kernel.org>
 <49a2022c-f106-55ec-9390-41307a056517@physik.fu-berlin.de>
 <20201201135623.GA751215@kernel.org>
 <4c752ff0-27a6-b9d7-ab81-8aac1a3b7b65@physik.fu-berlin.de>
 <ea5bae0e-9f27-355f-d841-cf8b362b0b70@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea5bae0e-9f27-355f-d841-cf8b362b0b70@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Adrian,

On Tue, Dec 01, 2020 at 08:55:37PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Mike!
> 
> On 12/1/20 4:07 PM, John Paul Adrian Glaubitz wrote:
> > This fixes the issue for me.
> > 
> > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> I just booted the kernel from the linux-mm branch and I can't get the hpsa driver
> to work anymore. Even if I compile it into the kernel, the driver is no longer
> loaded and hence I can't access the disks.
> 
> Any idea what could be wrong?

I know nearly nothing about SCSI, I can only suggest to enable all the
debug options available and see if anything shows up :)

> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 
> 

-- 
Sincerely yours,
Mike.
