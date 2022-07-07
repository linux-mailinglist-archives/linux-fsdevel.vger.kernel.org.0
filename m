Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EB556A584
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiGGOei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 10:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiGGOee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:34:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F78831353;
        Thu,  7 Jul 2022 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PVv/YKfz7Bw0xjcgtMQhhzWPkVQsFxjQSOmphQOK37M=; b=paTmFhWa9n/PSns35Y7QeDgthf
        7eO00PoDK9Un3HIWlQs3Z3wZ/z3yeQTLFQgMfLJKnvdVOmidJl89jsiEr43rPlpIREnrgp0dIk4gn
        unu+9iwnTLKmly1ZVSaZbyO4qAcF0fvBbwvvVUgsu+uy2pp084sgum4CGgXpKZFnBdRoFLpJeTZ0g
        6VikpqrMB7a/jOcXxQaB6BtEtGc+4fMg+4+EThyWX++diWkhBpdhJbYt+7MkrfBCF5tuaJG7mFyyM
        8wHLFLQ0ER546GxktelpduWXQgFKxV3zNVyypawz2nl29pe63e7twUpR2kswi6AHEoqp1Rhjs7pS7
        BKLdnZZg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9SaK-002eFG-E0; Thu, 07 Jul 2022 14:34:28 +0000
Date:   Thu, 7 Jul 2022 15:34:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] efs: removed useless conditional checks in function
Message-ID: <Ysbu9PllO6dqZLhB@casper.infradead.org>
References: <20220707142652.14447-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707142652.14447-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 07, 2022 at 05:26:52PM +0300, Andrey Strachuk wrote:
> However, it cannot be NULL because kernel crashes at
> line 293 otherwise.
> The patch removes useless comparisons.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Not sure who's going to merge this patch.  I guess I can throw it into
the pagecache tree if nobody else wants it.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

If you really want to be fancy, you can delve into linux-fullhistory and
come up with:

Fixes: 2b50c6738b500 ("Import 2.3.2")

although I bet that breaks a few scripts.
