Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685916A8FF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 04:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCCDto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 22:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCDtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:49:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5603B866;
        Thu,  2 Mar 2023 19:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9J5j/WBJ0EjRrGqH9QgPaIe5U384Ztfn9toz+cAiS5Y=; b=lW3l2m4648CVrEmVRo/Ka8z8sd
        /DWj0HKINsGoU+J/BK9HzsBGkJ10zkLTUzHcZUssveOUIgUf/zRpUQsQz0Meybkaurs6mPB4v4bmw
        1tt5OJPusax1o80WQUleiRdVg4oFmYtH+CjdV7wcfKTRm5neXb/4Xstjxs5MfI5x0yY+9NFj97UY+
        h2NB363fKi4P8vq14DW2e6wdnyoxpwJWMIAvk8UG002UCx0gW4BMrPIOzrag31D/zRt+nweVgM5Di
        x8EaOcsXSGpJbHhfkJC1eeofeqfOh5zk9k5FoX3m9OYdCuIUvrqLdpO7LUKQYyVsnpr0iFJZoo2Lv
        Ss/mFabA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXwQD-002s1p-Pz; Fri, 03 Mar 2023 03:49:29 +0000
Date:   Fri, 3 Mar 2023 03:49:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
> That said, I was hoping you were going to suggest supporting 16k logical block
> sizes. Not a problem on some arch's, but still problematic when PAGE_SIZE is
> 4k. :)

I was hoping Luis was going to propose a session on LBA size > PAGE_SIZE.
Funnily, while the pressure is coming from the storage vendors, I don't
think there's any work to be done in the storage layers.  It's purely
a FS+MM problem.
