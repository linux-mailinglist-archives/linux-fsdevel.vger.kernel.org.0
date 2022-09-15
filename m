Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABACF5B91E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 02:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiIOApu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 20:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiIOAps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:45:48 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3009356C0;
        Wed, 14 Sep 2022 17:45:47 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id bh13so15860519pgb.4;
        Wed, 14 Sep 2022 17:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n05HjcTTlTQT7owpfGLGmfiA73hG6sYlZ2pnjGc9I30=;
        b=lZcbZe+MT0nu4mgrEfOK3CnqVTprLZCEADfd+Yi10o+U33xJ8hd/VDSF6Cz+hRZn1P
         2bJbPOjVxey0hBO21ERXFHr33plHIBlxqM4RSJslr7sRfWp+z23xI9snWp8Tuv1jEbRE
         +NRXehpYnc/qzatQ5w5/AdZF3C9JzR3jqJmeHtbh9y+EdmFdtfvhx1maBZq/vs9osZpY
         poYVQ9GKXXUZVocawb2GP2RsEwDLRzZHWeoEF7SH8zi5vligwa17fEZEoLIZT4qgXg0B
         4xaIO91ZWfeM2bc5jgrAkh7yOSNHG8eeOdr5r70ndgCyGmwPmXC03rAXbp4dFcjKbHjm
         bYlA==
X-Gm-Message-State: ACgBeo3P75INW4+D+ygcaFBknw2M/JOvVeuS4kvCxId1P14U6W0kf2ki
        F4asE3c3NQd5PbZyOhY857E=
X-Google-Smtp-Source: AA6agR7OUk1btd2IJ6tSFOA3HxLtLLbIojIYWD6zfrKjJ4mcN0cqytEeSz5/Ar49RMNHPPoLUXbJRg==
X-Received: by 2002:a65:638d:0:b0:420:849f:77ed with SMTP id h13-20020a65638d000000b00420849f77edmr34202536pgv.523.1663202747475;
        Wed, 14 Sep 2022 17:45:47 -0700 (PDT)
Received: from [10.8.0.3] (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id k29-20020aa7999d000000b00537b6bfab7fsm11144548pfh.177.2022.09.14.17.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 17:45:46 -0700 (PDT)
Message-ID: <44af62e3-8f51-bf0a-509e-4a5fdbf62b29@kylinos.cn>
Date:   Thu, 15 Sep 2022 08:45:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Ke Sun <sunke@kylinos.cn>
Subject: Re: [PATCH] mm/filemap: Make folio_put_wait_locked static
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        k2ci <kernel-bot@kylinos.cn>, linux-fsdevel@vger.kernel.org
References: <20220914015836.3193197-1-sunke@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20220914015836.3193197-1-sunke@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> include/linux/pagemap.h | 1 -
> mm/filemap.c | 2 +-
> 2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 0178b2040ea3..82880993dd1a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1042,7 +1042,6 @@ static inline int 
> wait_on_page_locked_killable(struct page *page)
> return folio_wait_locked_killable(page_folio(page));
> }
> -int folio_put_wait_locked(struct folio *folio, int state);
> void wait_on_page_writeback(struct page *page);
> void folio_wait_writeback(struct folio *folio);
> int folio_wait_writeback_killable(struct folio *folio);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 15800334147b..ade9b7bfe7fc 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1467,7 +1467,7 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
> *
> * Return: 0 if the folio was unlocked or -EINTR if interrupted by a 
> signal.
> */
> -int folio_put_wait_locked(struct folio *folio, int state)
> +static int folio_put_wait_locked(struct folio *folio, int state)
> {
> return folio_wait_bit_common(folio, PG_locked, state, DROP);
> }
