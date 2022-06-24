Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7655455A4BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 01:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiFXXR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiFXXRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:17:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEB488B3B;
        Fri, 24 Jun 2022 16:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9682B82C96;
        Fri, 24 Jun 2022 23:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5F4C34114;
        Fri, 24 Jun 2022 23:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656112642;
        bh=SRbeoCVoiP6sAFPfqupaswhL4ShhqUzJCFcbcVdT1ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WasipiMD3gyvv8IhJSrx1zqYqylQVtMNii+iyRVfl/rJC9Q+8LGcF3wvYtYneavOB
         esoo5iPRq1xTCGkgbKkETprVcICaaACnkkLB6rY6EQ5zdn+fjcvSEwGMzn8qWG2fzm
         sVrHZISZSeo+DgynPlJ3YuKMNRzO6TPlFaPaO3d1L22HuOr4Q4BT2t50h5nPOaA8d9
         +s3LEW6ofy8z9jNyNXcV10qtKwUi6a9cHzkbwwajvVQwpwup3UMtMPdIA6mSfg+L9G
         m7UXT840HdH3MXqH/pcQMKF3prpUJl5AAKEox9pZ1APA0KADGeM8cIhQq3wcRDd+Fx
         oWUgUTqYmwB+A==
Date:   Fri, 24 Jun 2022 16:17:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org
Subject: Re: Triggered assertion from "mm: Add an assertion that PG_private
 and folio->private are in sync"
Message-ID: <YrZGAOxqHwwunFtK@dev-arch.thelio-3990X>
References: <YrYzhB7aDNIBz/uV@dev-arch.thelio-3990X>
 <YrZEmsorZ/g+Os9+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrZEmsorZ/g+Os9+@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 25, 2022 at 12:11:22AM +0100, Matthew Wilcox wrote:
> On Fri, Jun 24, 2022 at 02:58:28PM -0700, Nathan Chancellor wrote:
> > Hi Matthew,
> > 
> > I bisected a boot failure on one of my test machines to your commit
> > c462f63731e0 ("mm: Add an assertion that PG_private and folio->private
> > are in sync"), which landed in next-20220624. I didn't see this patch
> > posted to any mailing list on lore, hence this separate thread;
> > apologies if it was and I missed it. I didn't see this reported yet but
> > I see the assertion triggered when systemd-zram-setup@zram0 runs:
> 
> urgh, sorry about that.  i really need to wean zsmalloc off using struct
> page.  i'll drop this patch; feel free to just revert it, there's nothing
> that will depend on it.

Ack, I'll do just that, thanks a lot for the quick reply!

Cheers,
Nathan
