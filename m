Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348FA435ACA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 08:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhJUGVY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 02:21:24 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:59666 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231154AbhJUGVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:21:20 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 85EFE180A7FD9;
        Thu, 21 Oct 2021 06:19:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id E44AE268E38;
        Thu, 21 Oct 2021 06:19:01 +0000 (UTC)
Message-ID: <fcadd8a722eabf33638a234f3d1cb026977b35df.camel@perches.com>
Subject: Re: [v5 PATCH 3/6] mm: filemap: coding style cleanup for
 filemap_map_pmd()
From:   Joe Perches <joe@perches.com>
To:     Yang Shi <shy828301@gmail.com>, naoya.horiguchi@nec.com,
        hughd@google.com, kirill.shutemov@linux.intel.com,
        willy@infradead.org, peterx@redhat.com, osalvador@suse.de,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Oct 2021 23:19:00 -0700
In-Reply-To: <20211020210755.23964-4-shy828301@gmail.com>
References: <20211020210755.23964-1-shy828301@gmail.com>
         <20211020210755.23964-4-shy828301@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.80
X-Stat-Signature: 64ft3rw8juah3bgj3ctej1k981mcjdh9
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E44AE268E38
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19JoPEesXP36Tf6MauoxaqjNy1Pzi0FNk8=
X-HE-Tag: 1634797141-827303
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-10-20 at 14:07 -0700, Yang Shi wrote:
> A minor cleanup to the indent.
[]
> diff --git a/mm/filemap.c b/mm/filemap.c
[]
> @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
>  	}
>  
>  	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> -	    vm_fault_t ret = do_set_pmd(vmf, page);
> -	    if (!ret) {
> -		    /* The page is mapped successfully, reference consumed. */
> -		    unlock_page(page);
> -		    return true;
> -	    }
> +		vm_fault_t ret = do_set_pmd(vmf, page);
> +		if (!ret) {
> +			/* The page is mapped successfully, reference consumed. */
> +			unlock_page(page);
> +			return true;
> +		}

It might be more preferred to add a blank line after the automatic
when touching this block.


