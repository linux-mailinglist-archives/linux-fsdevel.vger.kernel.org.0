Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A0E59EC21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 21:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiHWTWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 15:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiHWTVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:21:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0B5B8F08;
        Tue, 23 Aug 2022 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F7agJyyQPBoKNSgYn2p8RhiVuoRJhF3uXfjMiiS+Xls=; b=Wkq47664wvidT/E01+KEhjp+FD
        R/XHD8tSjJ7wbSR/mUYAeZLcN9Qztr4HbAaptjmHf13Xvc/HhezApMdO9elvyO4yJky2geT4qJGiw
        ETVjqHkgyGMdGpfM/33Fu3FbWJdqyfvE7Gomlu8XUsphUa3UHMz1vW6QuUX6itShiWHOgh4mGnADK
        YLDxjyt+6hcWU3rUXSjXdG6cQBEL2pNTZFjh++GgJJwfdeTjQ2/EajCeR3hrpA1nrARg48VXIBoRv
        OY5Z8UvCwBhsFnazcFBsKtMiFMSi83zfhtHu4mnNppp6ZoBJ+FcwKhqsvBLgMFWMPweTwDT8k1nEh
        EeOcNoqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQYDz-00FUl4-TM; Tue, 23 Aug 2022 18:02:03 +0000
Date:   Tue, 23 Aug 2022 19:02:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Convert to filemap_get_folios_contig()
Message-ID: <YwUWG73OkS+3Eelr@casper.infradead.org>
References: <20220816175246.42401-1-vishal.moola@gmail.com>
 <20220823172642.GJ13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823172642.GJ13489@twin.jikos.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 07:26:42PM +0200, David Sterba wrote:
> I've tested the whole branch in my fstest setup, no issues found and
> did a light review of the code changes, looks ok as well.

Thanks!

> How do you want get the patches merged? As it's an API conversion I can
> ack it and let it go via the mm tree. So far there are no conflicts with
> our btrfs development patches, I assume it'll be a clean merge in the
> future too.

I was planning on taking this patch series through the pagecache tree;
it's in -next, so any problems will show up as conflicts there.
