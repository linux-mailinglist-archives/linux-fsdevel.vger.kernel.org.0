Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB57685E6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjG3OFv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 10:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjG3OFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 10:05:50 -0400
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 07:05:47 PDT
Received: from out-100.mta1.migadu.com (out-100.mta1.migadu.com [IPv6:2001:41d0:203:375::64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA2173D
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Jul 2023 07:05:46 -0700 (PDT)
Message-ID: <40a3ab47-da3e-0d08-b3fa-b4663f3e727d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690725435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGVwrSKPSqOKImBWbZoAx1qzxZDIg0U6/MyAhWrgbuQ=;
        b=iwoYw6Haq+kOYGPuPZKv5wW+uOf7UmUbzIK+dEi5BcvQ8JE87XsTTo3/OaLFjVQBD/o/ir
        fRSrCMrpEvqE0XtHAMIKkjF5ulAwlVSYlFZPhPk/oZ9ZcnH4KqxFkMf4MzqaUwsOND4ZDJ
        4e/ew8GqIOajhMOJNNAbOKquCrq4by4=
Date:   Sun, 30 Jul 2023 21:57:06 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 03/13] scatterlist: Add sg_set_folio()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230621164557.3510324-1-willy@infradead.org>
 <20230621164557.3510324-4-willy@infradead.org>
 <a2a2180c-62ac-452f-0737-26f01f228c79@linux.dev>
 <ZMZHH5Xc507OZA1O@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZMZHH5Xc507OZA1O@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2023/7/30 19:18, Matthew Wilcox 写道:
> On Sun, Jul 30, 2023 at 07:01:26PM +0800, Zhu Yanjun wrote:
>> Does the following function have folio version?
>>
>> "
>> int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
>> 		struct page **pages, unsigned int n_pages, unsigned int offset,
>> 		unsigned long size, unsigned int max_segment,
>> 		unsigned int left_pages, gfp_t gfp_mask)
>> "
> No -- I haven't needed to convert anything that uses
> sg_alloc_append_table_from_pages() yet.  It doesn't look like it should
> be _too_ hard to add a folio version.

In many places, this function is used. So this function needs the folio 
version.

Another problem, after folio is used, I want to know the performance 
after folio is implemented.

How to make tests to get the performance?

Thanks a lot.

Zhu Yanjun

