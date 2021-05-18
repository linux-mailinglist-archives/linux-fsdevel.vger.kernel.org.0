Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8E3878A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 14:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349045AbhERM1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 08:27:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:39652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234046AbhERM12 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 08:27:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6705B0B3;
        Tue, 18 May 2021 12:26:09 +0000 (UTC)
Subject: Re: [PATCH v10 31/33] mm/filemap: Add folio private_2 functions
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-32-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <6b57b706-ebaf-e15d-d121-1ac048a0d3f7@suse.cz>
Date:   Tue, 18 May 2021 14:26:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511214735.1836149-32-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> end_page_private_2() becomes folio_end_private_2(),
> wait_on_page_private_2() becomes folio_wait_private_2() and
> wait_on_page_private_2_killable() becomes folio_wait_private_2_killable().
> 
> Adjust the fscache equivalents to call page_folio() before calling these
> functions to avoid adding wrappers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>


Acked-by: Vlastimil Babka <vbabka@suse.cz>
