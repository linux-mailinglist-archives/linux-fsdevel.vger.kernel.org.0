Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA350AF8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 07:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiDVFjh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 01:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiDVFZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:25:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FDB4F445;
        Thu, 21 Apr 2022 22:22:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 59F8D68B05; Fri, 22 Apr 2022 07:22:09 +0200 (CEST)
Date:   Fri, 22 Apr 2022 07:22:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev,
        rostedt@goodmis.org
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422052208.GA10745@lst.de>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com> <20220421234837.3629927-7-kent.overstreet@gmail.com> <20220422042017.GA9946@lst.de> <YmI5yA1LrYrTg8pB@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmI5yA1LrYrTg8pB@moria.home.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:14:48AM -0400, Kent Overstreet wrote:
> Christoph, you have no problem making more work for me but I can't even get you

I think you are misunderstanding this.  You are trying to create more
work for people maintainaing the kernel by creating duplicate
infrastructure.  The burden is always on the submitter.

> to look at the bugs you introuduce in your refactorings that I report to you.
> 
> Still waiting on you to look at oops you introduced in bio_copy_data_iter...

I'm not sure why I shoud care about your out of tree code making
assumptions about block layer helpers.
