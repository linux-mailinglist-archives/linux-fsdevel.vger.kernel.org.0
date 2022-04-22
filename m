Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AF350BB90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 17:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351771AbiDVPXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449405AbiDVPWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:22:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B488E093;
        Fri, 22 Apr 2022 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nIt0HvtWAi7tSIj0kbqPEjdjwfm2aCcxWjAjplI4Eqk=; b=gh7qIgCmO2h1kzss7bU+3HG1QO
        ewzcJdVhPdEpSRkdim/oqKPWN0jiJkSN4vMxD4To+9+cmt02DkAczVcEnk98NMCK/AA1XbTG/WAGI
        lhFawYPQYB6hOlzKDTU9zIKm5nIV66VergAeali0TvR6dISxua/ivaYgLGJPc9JLbnu4BYBiJi/KR
        HDKjSObLSRDdk+FjPB9gARKjqFyA0mR1jpkzsui7ewdldZTFJ4l4DhEH7Kld1EOmiHfGIowKCpnL2
        eT0cOlUoWV9rIWvmLxb6V0zQZJPR6QRs2a8qXhtxFsQGg+SgEo57K3HPx6cMHWjjP5/2TToe3EFOr
        SJDunzCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhv4M-0014P5-DU; Fri, 22 Apr 2022 15:19:38 +0000
Date:   Fri, 22 Apr 2022 08:19:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pankaj Malhotra <pankaj1.m@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: Re: scsi_debug in fstests and blktests (Was: Re: Fwd: [bug
 report][bisected] modprob -r scsi-debug take more than 3mins during blktests
 srp/ tests)
Message-ID: <YmLHin571pO+umo+@infradead.org>
References: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
 <fba69540-b623-9602-a0e2-00de3348dbd6@interlog.com>
 <YlW7gY8nr9LnBEF+@bombadil.infradead.org>
 <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
 <YmGaGoz2+Kdqu05l@bombadil.infradead.org>
 <YmJDqceT1AiePyxj@infradead.org>
 <YmKgxGFc4SMi7MnB@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmKgxGFc4SMi7MnB@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:34:12AM -0400, Theodore Ts'o wrote:
> I would love it if blktests didn't require modules, period.  That's
> because it's super-convenient to be able to pluck a kernel out from
> the build tree without having to install it first.  If all of the
> necessary devices could be built-into the kernel, this would allow
> this to work:

Yes, all my testing runs that way normally.  And running blktests
does not fit that workflow at all.
