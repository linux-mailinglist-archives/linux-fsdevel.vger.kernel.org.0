Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0443B4F4D61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582023AbiDEXlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447575AbiDEPqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:46:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE27E6C67;
        Tue,  5 Apr 2022 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ko1ZOh/6WxK8uIg1DvUVKvUDgcTXdv0+MmX7707NyC8=; b=A76TPFDioO5jl21r/eo/VJ+lL/
        soytwPXZ/pOb8Hog7SmoAgVkb9jOchyECAsD9sZfiiQ9OhPksUMBFA6wnhBnqzOpWs6ubYkyqQLm+
        X6K2hUS3ZbiwWVDtWyzkoaXM0xhfWS30WXoTXHukgvG3AQgOu5hE96eaRHlwAMjvgwj46IoKo+WZv
        gucOCA0eoakP69Efy7oJ1fUAwKcsm2a2YMKBkAKkC1uO5WHiQLk4Mcoe+4zL/rsIlvgJtL+ZUWlV5
        uBackRh0QdvrQ2j29ktfJR/EZZBSZPTzi2lG7wxu/u4rBv5+VWcvijaPZsrCT8ITLMbdwsRJoQg89
        84iZAbmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbk4P-006n9q-E8; Tue, 05 Apr 2022 14:22:09 +0000
Date:   Tue, 5 Apr 2022 15:22:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] Folio fixes for 5.18
Message-ID: <YkxQkZ24Zz9KCxK1@casper.infradead.org>
References: <YkdKgzil38iyc7rX@casper.infradead.org>
 <20220405120848.GV15609@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405120848.GV15609@twin.jikos.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:08:48PM +0200, David Sterba wrote:
> Matthew, can you please always CC linux-btrfs@vger.kernel.org for any
> patches that touch code under fs/btrfs? I've only noticed your folio
> updates in this pull request. Some of the changes are plain API switch,
> that's fine but I want to know about that, some changes seem to slightly
> modify logic that I'd really like to review and there are several missed
> opportunities to fix coding style. Thanks.

I'm sorry, that's an unreasonable request.  There's ~50 filesystems
that use address_space_operations and cc'ing individual filesystems
on VFS-wide changes isn't feaasible.

