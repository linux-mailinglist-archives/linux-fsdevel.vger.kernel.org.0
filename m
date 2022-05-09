Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ECA51FCBF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiEIM3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 08:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiEIM3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 08:29:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AD8266C8C;
        Mon,  9 May 2022 05:25:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A528921AC6;
        Mon,  9 May 2022 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652099107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ynoy/ao8c7pL11Uo7S4P9d6Jg9Te35Ic6VRwYiiIv6E=;
        b=PSQIXl8g4N5S/lo1VuIZ3tc7gYxK2tf8DjVbIQ4cv/lmXA1n7Gms5KRzhuLGwb89ZuwgC4
        NiHYe7iGRd30IOKnzLspaIwBry981cMs8w8LdgCCjiJKwumc/exy8BhoIJCVBEthaBC9wR
        FXwdjam3SQnWrzJ4GTAjMF4hsnp+rBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652099107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ynoy/ao8c7pL11Uo7S4P9d6Jg9Te35Ic6VRwYiiIv6E=;
        b=4GZkvriYrrNgdBsTvNGFnlArIKvd1UfqYlBN07ROttnb/yufO4o2cNL5wFC8hYuQzdTUhs
        8fvL0WPnzH2ItcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F076132C0;
        Mon,  9 May 2022 12:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LPpnGiMIeWLQQAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 May 2022 12:25:07 +0000
Message-ID: <b4935d67-36b1-3346-f04c-8d247b462583@suse.cz>
Date:   Mon, 9 May 2022 14:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v3 PATCH 1/8] sched: coredump.h: clarify the use of
 MMF_VM_HUGEPAGE
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220404200250.321455-1-shy828301@gmail.com>
 <20220404200250.321455-2-shy828301@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220404200250.321455-2-shy828301@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/4/22 22:02, Yang Shi wrote:
> MMF_VM_HUGEPAGE is set as long as the mm is available for khugepaged by
> khugepaged_enter(), not only when VM_HUGEPAGE is set on vma.  Correct
> the comment to avoid confusion.
> 
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Vlastmil Babka <vbabka@suse.cz>

> ---
>  include/linux/sched/coredump.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index 4d9e3a656875..4d0a5be28b70 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -57,7 +57,8 @@ static inline int get_dumpable(struct mm_struct *mm)
>  #endif
>  					/* leave room for more dump flags */
>  #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
> -#define MMF_VM_HUGEPAGE		17	/* set when VM_HUGEPAGE is set on vma */
> +#define MMF_VM_HUGEPAGE		17	/* set when mm is available for
> +					   khugepaged */
>  /*
>   * This one-shot flag is dropped due to necessity of changing exe once again
>   * on NFS restore

