Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471F5251001
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 05:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgHYDe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 23:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHYDeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:34:25 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A30FC061574;
        Mon, 24 Aug 2020 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=qo7vXrEZhpDizbZsPI7G5k0fUIjudAsV66SwXq7rzag=; b=guBrQLSexeg0VYTb0hsSOclFGL
        wEiobKE8SjCyUbrMdiNu63wvh2S2K9KnD4Lbi7ulX+RyYlRazbW8sVfl6Pcy4miVdUM+ma/bpwQQi
        hgHkY3jHm7utKnf2HUSEH+k3goBWtDHJa/tFmktWJSiHYRST/PwFSJUoSLWivd51x8TtpzAhBAuEe
        cHhI0KbvRXnrI+JA76LoWvyT3+TMkzA8K12dYwDLyHosschKz+/ZxGzZ2b980Ufl/L+jNmAS1koYL
        pfRIM3gKZWDQoD3X0t4KnT5UvFr2OXSJ0Q9rJ7Sfhylw027HGYinrdZz2/art7gRSAuctzt5grUzq
        xwVNbdHw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAPit-0006GU-5m; Tue, 25 Aug 2020 03:34:12 +0000
Subject: Re: mmotm 2020-08-24-16-06 uploaded (drivers/nvdimm/e820.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Dan Williams <dan.j.williams@intel.com>
References: <20200824230725.8gXQoJFD-%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b579d385-3c87-d822-1651-e5acb9ce413e@infradead.org>
Date:   Mon, 24 Aug 2020 20:34:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824230725.8gXQoJFD-%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/20 4:07 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-08-24-16-06 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

on i386:

when MEMORY_HOTPLUG is not set and NUMA is not set:

../drivers/nvdimm/e820.c: In function ‘e820_register_one’:
../drivers/nvdimm/e820.c:24:12: error: implicit declaration of function ‘phys_to_target_node’; did you mean ‘set_page_node’? [-Werror=implicit-function-declaration]
  int nid = phys_to_target_node(res->start);
            ^~~~~~~~~~~~~~~~~~~

In include/linux/memory_hotplug.h, phys_to_target_node() is hidden inside
CONFIG_MEMORY_HOTPLUG.


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
