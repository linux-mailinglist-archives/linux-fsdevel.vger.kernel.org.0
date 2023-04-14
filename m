Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D8E6E2419
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDNNQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNNQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:16:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69D3A8D;
        Fri, 14 Apr 2023 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bewZGEzP35vOEXrv26we0KnfsWo+fadUsj5rz09UWlo=; b=M7yC6Q+jM2U3PddJlmSmpxqjld
        f+Z4QA9pWdhgZxLjWmRlJ5QjWCC4IBiXjKiOp9Czax+yyheHN6U6AAs5w+eeZZl5JRQIcPIrPTMpt
        atfU/GFREm+KcRjeyFYOewq3SCGANJFQJCAKi+KNd7GsZ/0v+Z3dHvby1AHmKs5xcuTKpIgDfRzKl
        yLf+h27KHF2atKCDi94Or0Tz7m6+NNEB6iijcSd9vgSvjBHuXNC1CbwxKIj3WdXP6/AZBHZrj5rmG
        LZH+ArxJCHV2tOdi3O9G1X1UXntJv2+fRwXVo038hiBQdgKweffqWqq4/z05EELHTnFv5/PFUqoyA
        ap1zGQjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnJHd-008lmQ-Qx; Fri, 14 Apr 2023 13:16:09 +0000
Date:   Fri, 14 Apr 2023 14:16:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        gost.dev@samsung.com, hare@suse.de
Subject: Re: [RFC 3/4] fs/buffer: add folio_create_empty_buffers helper
Message-ID: <ZDlSGRCKLcwyqMgU@casper.infradead.org>
References: <20230414110821.21548-1-p.raghav@samsung.com>
 <CGME20230414110827eucas1p1b872c350b7e81f01e65ba0985082ba20@eucas1p1.samsung.com>
 <20230414110821.21548-4-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414110821.21548-4-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:08:20PM +0200, Pankaj Raghav wrote:
> Folio version of create_empty_buffers(). This is required to convert
> create_page_buffers() to create_folio_buffers() later in the series.
> 
> It removes several calls to compound_head() as it works directly on folio
> compared to create_empty_buffers().

Again, I would create a create_empty_buffers() wrapper, but this time I
would put it in buffer.c.
