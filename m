Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92920BC30
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgFZWJg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 18:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZWJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:09:36 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AF3C03E979;
        Fri, 26 Jun 2020 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=7ItslY+2tZnH34AnvCzD4Nhf2IFkOH4VABumb9nnzMY=; b=SzqF7WY4VAjL+0alZFowiV+qcm
        7czxSpcJw4zxoxv7fTg+JJQcdru+suTLjcqhuQrVhYmDSRzl0d5Xif2s9g+AcR69pGGMKDuMGPkWU
        sAhYnwzzaKbri/0T22CP684gLPZICM63L1qmwF0Iexg26oWJ71f1UQgDqNCFbmar22df+L3NcuflU
        RZ3giORw/uMQJugFrkRb3y0HGjpAd43ztQLiCiYrVAcIsRP3qlvSahWbmgeiukYOLdvyF3OU5B7o9
        oAq3FAh3lhSsuNNsJtslo8Z0dDqt0rAJrmT+cCmn6Gqm/id3XV8TfR30U+DkVPQv9mXk+Jhkdw9i0
        s2DH3uFg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jowX3-0005QC-Gg; Fri, 26 Jun 2020 22:09:15 +0000
Subject: Re: mmotm 2020-06-25-20-36 uploaded (mm/memory-failure.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
References: <20200626033744.URfGO%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <700cf5c7-6e8c-4c09-5ab6-5f946689b012@infradead.org>
Date:   Fri, 26 Jun 2020 15:09:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626033744.URfGO%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/25/20 8:37 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-06-25-20-36 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 

when CONFIG_MIGRATION is not set/enabled:

../mm/memory-failure.c: In function ‘new_page’:
../mm/memory-failure.c:1692:9: error: implicit declaration of function ‘alloc_migration_target’; did you mean ‘alloc_migrate_target’? [-Werror=implicit-function-declaration]
  return alloc_migration_target(p, (unsigned long)&mtc);
         ^~~~~~~~~~~~~~~~~~~~~~
         alloc_migrate_target
../mm/memory-failure.c:1692:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
  return alloc_migration_target(p, (unsigned long)&mtc);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
