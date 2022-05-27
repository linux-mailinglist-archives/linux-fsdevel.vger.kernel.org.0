Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC4535E6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 12:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiE0Kgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 06:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348631AbiE0Kgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 06:36:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4C767F
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 03:36:44 -0700 (PDT)
Received: from zn.tnic (p200300ea97465727329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5727:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 498131EC0494;
        Fri, 27 May 2022 12:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653647799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jizd7AeuKIuaq0vjYIt+y1mUir09bWapASJVbAXv5Ew=;
        b=m87rpqzrvGdMAAvyyf90q4AzHwKAlbZ0kJmn07jAGRFmYQarrDBybeWqzcoyFT+uqHYXHl
        aOEqxErYug6Sw1Y6NpO97q1TDvZ8e/+ZA9feXE7PJ62bxHkARr1Kbi8YXHxziba/D4AGsL
        aNi7VLuSbyYZVI3t5mUceAwiiJJuf44=
Date:   Fri, 27 May 2022 12:36:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YpCps3oyGOZZNZ3z@zn.tnic>
References: <0343869c-c6d1-5e7c-3bcb-f8d6999a2e04@kernel.dk>
 <YoueZl4Zx0WUH3CS@zeniv-ca.linux.org.uk>
 <6594c360-0c7c-412f-29c9-377ddda16937@kernel.dk>
 <f74235f7-8c55-8def-9a3f-bc5bacd7ee3c@kernel.dk>
 <YoutEnMCVdwlzboT@casper.infradead.org>
 <ef4d18ee-1c3e-2bd6-eff5-344a0359884d@kernel.dk>
 <2ae13aa9-f180-0c71-55db-922c0f18dc1b@kernel.dk>
 <Yo+S4JtT6fjwO5GL@zx2c4.com>
 <YpCjaL9QuuCB23A5@gmail.com>
 <YpCnMaT823RM3qU5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YpCnMaT823RM3qU5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 12:25:53PM +0200, Ingo Molnar wrote:
> Turns out Boris just sent a competing optimization to clear_user() 3 days ago:
> 
>   https://lore.kernel.org/r/YozQZMyQ0NDdD8cH@zn.tnic

Yes, and that one needs to be properly measured and verified it doesn't
impact any workload. I have been working on this for a while now so
let's all relax ourselves - it'll get fixed properly eventually.

What you could do in the meantime is, run it and see if your
microbenchmarks are happy with it.

Because clear_user() doesn't matter one whit in real workloads, as we
realized upthread.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
