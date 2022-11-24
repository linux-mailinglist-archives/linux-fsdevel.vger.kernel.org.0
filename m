Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD4637AEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 15:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKXOBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 09:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiKXOBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:01:00 -0500
X-Greylist: delayed 2297 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Nov 2022 05:58:48 PST
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2B411373E;
        Thu, 24 Nov 2022 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=SWkN2cRi13sxU3o59s3qG/QDoeZoq61rFYW1PBVwJ8w=; b=TvAs7spYQ0q9IWL0m7fFZISB5s
        zqa0bx4S3fLnYvvqjAE4TSnkb9pHHoRtrCJhmaCA9B67B2mcryRHmQCo0Czo7rWACHF/Qbj099/a7
        vJzST2g0ZpM+T+b6qfj/Ya6k6jufquPl45j9q0fvuPyKRNepWC92K9a90SoIoEgAIrtEFQmv1H4V0
        tbBuS89Pug8x5zbOZVqCMUTqGqXFK6+APh73kS3HA9/KAsBUOFR6HCnM8DVWTXPJfZoiGAT7n3WrJ
        ANWaueoPXg5/+5XJ6RqeTH+afhyY73oAx0C95/EgwIAKnH8l35/GbpI4ZYwe0wYhsNGEn6aN4Bck0
        wmVCdgryBfLppavnEaudlssP8EHPVJNxntGOa66M+cmy3AO2AhonM84e49/oe4gQZz4sy8/1bNMkF
        2hZMyiOl1Fz7SQnBI9cQkVYjnAFUvFxCA1aBtfnmk5MS/iNix8Is8a2rMrLayDRNgEJRYmca9n6Or
        lPL5uRHoIphwzgXw/pu0J5yMrZ2CILL3jEQyQO/c8/gyK5qfw3X1AWMbO95+FAxYt73ctmzybWEu6
        sZv9ECMtN0EIGJn2OZb9sihO8OUg7Qq84keAwEYXfd8MEm0ZbhVur/xbDKK+E0rikSVL3kjmrJ2Ha
        xtpg5gprK2SYW415jQpo4+duga5v38QC1ihiBSsps=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [GIT PULL] 9p fixes for 6.1-rc7
Date:   Thu, 24 Nov 2022 14:20:28 +0100
Message-ID: <2899577.0geWjkyWJQ@silver>
In-Reply-To: <CAHk-=winPSOAoRAc3vUSy9UZ-kLpjehVkEsncbiyqZ4cZfV0xg@mail.gmail.com>
References: <Y32sfX54JJbldBIt@codewreck.org>
 <CAHk-=winPSOAoRAc3vUSy9UZ-kLpjehVkEsncbiyqZ4cZfV0xg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, November 23, 2022 8:08:48 PM CET Linus Torvalds wrote:
> On Tue, Nov 22, 2022 at 9:16 PM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> >
> >  net/9p/trans_fd.c  | 24 +++++++++++++-----------
> >  net/9p/trans_xen.c |  9 +++++++++
> >  2 files changed, 22 insertions(+), 11 deletions(-)
> >  9 files changed, 254 insertions(+), 28 deletions(-)
> 
> Strange bogus second line of statistics.
> 
> But the first line looks right, and I've pulled it. I'm assuming this
> is some odd cut-and-paste error on your part where you had some stale
> data from before.

First line and above is correct, and merged patches look fine as well.

Best regards,
Christian Schoenebeck


