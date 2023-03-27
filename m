Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6ED6C9A45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 05:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjC0DkA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 23:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjC0Dj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 23:39:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B249F1;
        Sun, 26 Mar 2023 20:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LoG900F1vrZdoQL9EpuQwO64BBi+G7sdGHFuhGA31n8=; b=fKflL0/yiH+kWNsz8KaxHi9mYy
        r+Do6sK3t2NxzqD41tqLlJBirNDC7CCyUAlWevH0yPekfxHKgFmCayUUX7a92nrexdkPrZlB/Bt0i
        CTQvToZEDUrxsYIrMc0He2GSzny3l0E2YjPCNxPOCMAHkmO5cqSBPMWfw/toI181VrWA/ItIlDLT7
        MGonblSxLoPbZ3lq0m4K0zGEDckq493iBg2XGG2VvLpOTwjfwK/nke1yaFCAdadPpwRdTj0+Q0ObN
        3SjEt+BhbpoJ5t1a3Z+znreREqBzFdlR8tI8Oje2aIfbw4KEqk4vk7X9TO2z2+DsJc0avVSt5iE96
        kmUyvuVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgdhx-009gAF-0K;
        Mon, 27 Mar 2023 03:39:45 +0000
Date:   Sun, 26 Mar 2023 20:39:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>, ye.xingchen@zte.com.cn,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V5 1/2] mm: compaction: move compaction sysctl to its own
 file
Message-ID: <ZCEQASf0nxPST/QF@infradead.org>
References: <202303221046286197958@zte.com.cn>
 <ZBq9uO6wLI1fX1x/@infradead.org>
 <8ff68064-3ec6-4aa2-2389-3568483a1bd4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff68064-3ec6-4aa2-2389-3568483a1bd4@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:19:15PM +0100, Vlastimil Babka wrote:

> I think Luis started this initiative, maybe he can provide the canonical
> reasoning :)

No matter who provides it, it needs to go into the commit log.
