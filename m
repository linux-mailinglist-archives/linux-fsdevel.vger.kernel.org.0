Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD920BDFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 05:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgF0Dlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 23:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgF0Dlv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 23:41:51 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679D520857;
        Sat, 27 Jun 2020 03:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593229310;
        bh=Ali5IZNLTIW8llvxQDSSeqrZ636VTDReJzcRNiixCTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aYgiC1Cmppmj+lWV8ausXHZpLkIb+IgodES53DwyIvVVnwsgutwPqyuqj1OU0f6Av
         Ft7CT76o3C9myEmF/idXHzZk0aN9LpIc+UD86qfFy32f5YEnrjx30YBIoE8Iw3nEb0
         /FEvX8jGyVucATfpIHWtMsBVvO9AhBEurlojSejM=
Date:   Fri, 26 Jun 2020 20:41:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: mmotm 2020-06-25-20-36 uploaded (mm/memory-failure.c)
Message-Id: <20200626204148.6c8c3c359e8baa310ecb744f@linux-foundation.org>
In-Reply-To: <700cf5c7-6e8c-4c09-5ab6-5f946689b012@infradead.org>
References: <20200626033744.URfGO%akpm@linux-foundation.org>
        <700cf5c7-6e8c-4c09-5ab6-5f946689b012@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 26 Jun 2020 15:09:08 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 6/25/20 8:37 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-06-25-20-36 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> 
> when CONFIG_MIGRATION is not set/enabled:
> 
> ../mm/memory-failure.c: In function ‘new_page’:
> ../mm/memory-failure.c:1692:9: error: implicit declaration of function ‘alloc_migration_target’; did you mean ‘alloc_migrate_target’? [-Werror=implicit-function-declaration]
>   return alloc_migration_target(p, (unsigned long)&mtc);
>          ^~~~~~~~~~~~~~~~~~~~~~
>          alloc_migrate_target
> ../mm/memory-failure.c:1692:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
>   return alloc_migration_target(p, (unsigned long)&mtc);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks.

Appears to be due to Joonsoo Kim's "mm/migrate: make a standard
migration target allocation function".

