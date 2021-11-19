Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B222045670A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 01:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhKSA4k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 19:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhKSA4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 19:56:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219E1C061574;
        Thu, 18 Nov 2021 16:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=qKGELyL4aCtaaSFlrFfy2GDax7ugJmenjGWL4VW8cso=; b=1WWH1rqVi4pj6/R0uchiYGoIZm
        K1G44pD6j74aMuSvjN22VweP5K3ZpalA0/3OM4avmt4ArRjg4401cyfSRbnHmpNk6HQMb90SuSAXF
        kvbeSyCYwTiN3jQnicz2QB9ESrGzx1eGFqEvFwff1rwNAwVwApGU3y+l1ky11i/c0UkFuq76KZatI
        Q5p83QmMRwZsvx/Jx11WKmLcYc5l9HXKz4s7D8wcIaheoznzDtTzl7qtDDTYRA+piM3c8fYvV2y75
        2Bv0YdQSNEUl4z3ucZPS/dM4imzyy1hw1Y+1FJm/c0LL9CfOFkDNs6GL8lDONDR17gRsqHAIt860M
        mdg89XVg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mns9k-0096Vz-Pk; Fri, 19 Nov 2021 00:53:32 +0000
Subject: Re: mmotm 2021-11-18-15-47 uploaded (<linux/proc_fs.h>)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Hans de Goede <hdegoede@redhat.com>
References: <20211118234743.-bgoWMQfK%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <db0b9313-fef6-2977-9b1c-4c830edea5c5@infradead.org>
Date:   Thu, 18 Nov 2021 16:53:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118234743.-bgoWMQfK%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/21 3:47 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-11-18-15-47 has been uploaded to
> 
>     https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

Hi,

I get hundreds of warnings from <linux/proc_fs.h>:

from proc-make-the-proc_create-stubs-static-inlines.patch:

../include/linux/proc_fs.h:186:2: error: parameter name omitted
../include/linux/proc_fs.h:186:32: error: parameter name omitted
../include/linux/proc_fs.h:186:63: error: parameter name omitted


-- 
~Randy
