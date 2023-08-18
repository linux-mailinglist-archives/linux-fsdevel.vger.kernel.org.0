Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C15780DDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377253AbjHROUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 10:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377761AbjHROT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:19:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE4C3AA7;
        Fri, 18 Aug 2023 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1X0hAoodz7PkGM1HdXxW/xIIRbIJBuCe4QV036xiiIM=; b=Y1/1Uo0dX8MKmWsYdq7cjSomje
        BWc4+LrHc3tG1DvkKvjBtKxHh778+rgUZpXoIZQmw+jpRXu+GDqoTu5jAYN+lmVqvfS1OQzSGoaml
        MyyI2wX1yUFLKZh8zfDk/W6B9Vg3/64SOWmOzgZsrkg/6Rgdk1o/z87iSg8nmUpuILtajWo29eE8R
        NRQnf9cc4XflvB+DZPkv8Ng+9JqPi4+UgX5+yCOquxWnq3Lh0ZqR31FR7Fgyf2mpzvB1k2lXsEevU
        rPoKHRy0PWFlAw4px4iSWOBL4NARj3MGy0DTddEWbDM0UuWk9e1d2RJGjPIzTFC7F3lZ+5QvaoKKI
        /fazeN7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX0Jt-009tKE-32; Fri, 18 Aug 2023 14:19:21 +0000
Date:   Fri, 18 Aug 2023 15:19:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [BUG] KCSAN: data-race in xas_clear_mark / xas_find_marked
Message-ID: <ZN996RyhG8K5u8i7@casper.infradead.org>
References: <06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr>
 <ZN9iPYTmV5nSK2jo@casper.infradead.org>
 <873686fb-6e42-493d-2dcd-f0f04cbcb0c0@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873686fb-6e42-493d-2dcd-f0f04cbcb0c0@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:37:10PM +0200, Mirsad Todorovac wrote:
> I am new to KCSAN. I was not aware of KCSAN false positives thus far, so my best bet was to report them.
> 
> I thought that maybe READ_ONCE() was required, but I will trust your judgment.
> 
> I hope I can find this resolved.

I haven't looked into KCSAN in any detail, I don't know what the right
way is to resolve this.
