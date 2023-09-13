Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528C779EB04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbjIMO0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjIMO0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:26:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D6392;
        Wed, 13 Sep 2023 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZXBuq9nlAZ8Gx9opg+N9hx7NUH9GGqRP1vud5p5Ibo=; b=FHWpHLjEa4KdWZE8TtWTPhcn0I
        yWxOQWgxioBqMpzsytL1GL6l3NyvPbggD9sZaTptbhEyLMtGfZMUlzAmvzWnuABbzMWYITrG2Ez5j
        21JlneI0akvl/1LO6hF1EDn0rdupGpGc3yeCMF+o3H6IiT5IkRBd6I3hq+CXgPampQ5JoIGXFwm/O
        zqj7nfwkGHI8JSQuIfi+w3Ce3ZuC5bRUYR35Ecu3RiudFBEEm8sgcywP9yTbK4OGDyiyN/1xgkk+8
        2J+LZ8gT5WDxVclXATACkDAbVU1aAX26RK8OQ7W+886USKWqBwJdPvK/qiJixXb0DhjOxhYgmRhSn
        qAv2a4yQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgQow-00EMRZ-Bc; Wed, 13 Sep 2023 14:26:22 +0000
Date:   Wed, 13 Sep 2023 15:26:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
Subject: Re: KASAN: null-ptr-deref Read in filemap_fault
Message-ID: <ZQHGjs484J5poT4N@casper.infradead.org>
References: <BL0PR11MB31060BABA61005C5C8CBE092E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB31060BABA61005C5C8CBE092E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:02:23PM +0000, Sanan Hasanov wrote:
> Good day, dear maintainers,

It was a better day before I got this email.

Same question as in
https://lore.kernel.org/all/ZPo%2FHdan9JaYWor0@casper.infradead.org/

> Kernel Branch: 6.3.0-next-20230426

except this one is even older.  Five months?!
