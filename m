Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7350BB3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449155AbiDVPLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiDVPK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:10:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD52CEB5;
        Fri, 22 Apr 2022 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i53aMRF5IR/1YEbTTTBtgQzdvvCZxmKNoDHWB/w+PEc=; b=hzvdnyYH0twiH1hf9W3tCLoalb
        hkHaa425tjaUC7Ol+dOVHJPXGZJ07RENAnlP8lqT0WvN56R4wi83p9ZMw4rsUaenZWpNOK7w5MTDK
        SlgZ+pUSh9p27lcaJ0ubaxFL1Rd7CcjVOnVEdtC1lNsszhssYY0kUD+beDpuMMpdSMmLIBav2K40o
        yExN3nt/UUL6flU/LqOsjZbG0F2kr7HGtnJfIldcXlHXKuhnoWLH0mOIgIRpJb/y6K1257l0e6m1D
        f1DKaYZPxliHqL2KekDcdNQVM8q3l2MBDK5TFdsdhP94WDRRpjdqMR3zlyGUtVRYafuV/T+uZrQvj
        V38D8tMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhut9-0010Kj-Uw; Fri, 22 Apr 2022 15:08:03 +0000
Date:   Fri, 22 Apr 2022 08:08:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <YmLE0xVn/knBZga0@bombadil.infradead.org>
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
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:34:12AM -0400, Theodore Ts'o wrote:
> I think we would need to make some changes to how scsi_debug and other
> block device modules, first, though.  blktests is using modules
> because that appears to be the only way to configure some of these
> test/debug drivers and then have the debug device show up with the
> specified characteristics.

Agreed.

  Luis
