Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E533268EED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgINPEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgINPDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:03:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39AFC061788;
        Mon, 14 Sep 2020 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=wulbEpVG9y6PsrWLiE952ZIiq7qXbTBlk+RovXIeNiU=; b=pGpOyTWSJIO3+I3N4/zuuVQjjO
        zdlBe+d6oX+42X1Y/OzXLsKo7vSefQiLSydMjQ2rx1r8sx9Uymu6QLbEYu70gG/tOf1t6ixxAHCAk
        rm/5Zr/nD6fncGYH8z/Y1hJwvFJgDeQU+ugoR9y+yrE7YTJjYzVHhrcvlypoUef+hX61a6ySsIFAH
        psvD1rdDCbSujPYYoMlOkvD8mytXHytMOpU05FeAHFoAQ5AUOgocKePM8Bd84RLg/pTb89mI4Kpgz
        8E7IhWeVyEeq3NgJPMYJuFOnJfsmAhFnLtEtGF037qK/gD3kMq3QsLuZ+v3PATro1ROQcZxwKn6Sh
        8zoytUyQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHq15-0002XS-GE; Mon, 14 Sep 2020 15:03:41 +0000
Subject: Re: mmotm 2020-09-13-21-39 uploaded (arch/x86/kernel/kvm.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        KVM <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200914044009.bRyqjBRrs%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25f9de21-a825-2e6d-38ba-b86e80271390@infradead.org>
Date:   Mon, 14 Sep 2020 08:03:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914044009.bRyqjBRrs%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/13/20 9:40 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-09-13-21-39 has been uploaded to
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
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.
> 
> This tree is partially included in linux-next.  To see which patches are
> included in linux-next, consult the `series' file.  Only the patches
> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
> linux-next.
> 


(found in mmotm but not in one of its patches; i.e., in linux-next or mainline)

on i386:

../arch/x86/kernel/kvm.c: In function ‘kvm_alloc_cpumask’:
../arch/x86/kernel/kvm.c:800:35: error: ‘kvm_send_ipi_mask_allbutself’ undeclared (first use in this function); did you mean ‘apic_send_IPI_allbutself’?
  apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   apic_send_IPI_allbutself


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
