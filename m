Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A4C78AFF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjH1MTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjH1MT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:19:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767A124;
        Mon, 28 Aug 2023 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Grp8/JCuPAsIViMfplUamWtTBlk01R4dnjqvGinzDMs=; b=uJED1QrCMJXRtdI5sHHfmYpoZ0
        Cbud45Vdrn0X3VeeuUfk1XWR7h4lJ2QO6GscBNIhzAynrBQE8HJb/CsjlY77Xx00l6Rqg6istSk2e
        HVJljAoOHx5jJel7lfp8JBYYwHzWJxrzPP/friZRA2oWTjjaGszC7SRR7l4A9CKttq8pD7XeQLahL
        xNEFlD57bG+KsynLi29XORLPL6MNeE++csJ5Ai80HGf7BA5OGM6PtTKYSsm2WBUXFaXFwih52y8RN
        Vl5nVERU2BkCJQtsoha1HyuDDKo1eqOx2YBaCuWwK7wPCrkSUSKhsWhSWAvyWsyy1Yz4d/ZLpncac
        x7zit3lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qabD7-000Be9-1R; Mon, 28 Aug 2023 12:19:13 +0000
Date:   Mon, 28 Aug 2023 13:19:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: use helpers for calling f_op->{read,write}_iter()
 in read_write.c
Message-ID: <ZOyQwJBWO3zQM8m7@casper.infradead.org>
References: <20230828155056.4100924-1-shikemeng@huaweicloud.com>
 <ZOyMZO2i3rKS/4tU@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOyMZO2i3rKS/4tU@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:00:36AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 28, 2023 at 11:50:56PM +0800, Kemeng Shi wrote:
> > use helpers for calling f_op->{read,write}_iter() in read_write.c
> > 
> 
> Why?  We really should just remove the completely pointless wrappers
> instead.

Agreed.
