Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AA5B91D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 02:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIOAlD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 20:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIOAlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:41:00 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4225D7F130;
        Wed, 14 Sep 2022 17:40:52 -0700 (PDT)
X-UUID: 2505da2ba7af4b02a38ec67ca03e61bd-20220915
X-CPASD-INFO: ac03eae5191241108bbf27eaa03f2769@qrNqU5KTk2VdWXN-g3R8aliTkpZiY4W
        wo2pTlmBnYlmVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3sKVqU5WPlQ==
X-CLOUD-ID: ac03eae5191241108bbf27eaa03f2769
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:168.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:170.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:-2.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5,
        AUF:1,DUF:4775,ACD:80,DCD:80,SL:0,EISP:0,AG:0,CFC:0.855,CFSR:0.036,UAT:0,RAF:
        2,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF
        :0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 2505da2ba7af4b02a38ec67ca03e61bd-20220915
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 2505da2ba7af4b02a38ec67ca03e61bd-20220915
X-User: sunke@kylinos.cn
Received: from [10.8.0.3] [(118.250.49.117)] by mailgw
        (envelope-from <sunke@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 378164889; Thu, 15 Sep 2022 08:41:23 +0800
Message-ID: <1b9c2f74-c16d-8e19-17fa-615ff51f27f1@kylinos.cn>
Date:   Thu, 15 Sep 2022 08:40:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/filemap: Make folio_put_wait_locked static
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        k2ci <kernel-bot@kylinos.cn>, linux-fsdevel@vger.kernel.org
References: <20220914015836.3193197-1-sunke@kylinos.cn>
From:   Ke Sun <sunke@kylinos.cn>
In-Reply-To: <20220914015836.3193197-1-sunke@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,RDNS_DYNAMIC,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping.

On 2022/9/14 09:58, Ke Sun wrote:
> It's only used in mm/filemap.c, since commit <ffa65753c431>
> ("mm/migrate.c: rework migration_entry_wait() to not take a pageref").
>
> Make it static.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Ke Sun <sunke@kylinos.cn>
> ---
>   include/linux/pagemap.h | 1 -
>   mm/filemap.c            | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 0178b2040ea3..82880993dd1a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1042,7 +1042,6 @@ static inline int wait_on_page_locked_killable(struct page *page)
>   	return folio_wait_locked_killable(page_folio(page));
>   }
>   
> -int folio_put_wait_locked(struct folio *folio, int state);
>   void wait_on_page_writeback(struct page *page);
>   void folio_wait_writeback(struct folio *folio);
>   int folio_wait_writeback_killable(struct folio *folio);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 15800334147b..ade9b7bfe7fc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
>    *
>    * Return: 0 if the folio was unlocked or -EINTR if interrupted by a signal.
>    */
> -int folio_put_wait_locked(struct folio *folio, int state)
> +static int folio_put_wait_locked(struct folio *folio, int state)
>   {
>   	return folio_wait_bit_common(folio, PG_locked, state, DROP);
>   }
