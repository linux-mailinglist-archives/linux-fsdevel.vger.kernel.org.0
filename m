Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A2072B713
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 07:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjFLEzw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 00:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjFLEzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:55:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A451984;
        Sun, 11 Jun 2023 21:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=UR/qNgYvbFATim9cZ6J3Ui0/Qb
        Z/qB/Di6msTuVRG0xWAvMD+ZDIS1PAQBU4jZ2UEd+V47TdYOMVSEfmA6ERb6FefX5TO477/pfnRf3
        oRpEHmOTj9U+zN2rT1gA+qMO4WCeEVp8frrbRMKNX/O7fpmXr1WS27bj/FoAoh43Br5tAhh60vSup
        cuqy+p5ACMPmWDhpvoEHEAtfqzWqbkVt0Wohz7JPXUL+81PVFpHTw2sfjGiJ3GuWmRt6IoGhc8eF/
        3sy/dUxagvL2yODupuuSl6+2oTdqGB40MsWgclCxP4K7Qc1S7xjE1twqoV87diqAzEMY6M/J4yTd9
        HSz7CYcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8ZYz-002aKv-0P;
        Mon, 12 Jun 2023 04:53:57 +0000
Date:   Sun, 11 Jun 2023 21:53:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        david@redhat.com, yuzhao@google.com, dhowells@redhat.com,
        hughd@google.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/6] swap: remove remnants of polling from
 read_swap_cache_async
Message-ID: <ZIak5RU9iyHL5RHH@infradead.org>
References: <20230609005158.2421285-1-surenb@google.com>
 <20230609005158.2421285-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609005158.2421285-2-surenb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
