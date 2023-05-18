Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77287089EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 22:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjERUzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 16:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjERUzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 16:55:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361D1F7;
        Thu, 18 May 2023 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YPhP6BC+IEsfoXB2aA0bVLzSVsaUv9891PdK+C1Dx8g=; b=tt6ENj/lVkKUJKiCYXjfjkcAgl
        E1CE5UrauzZwRVEElGcCTmu8epF1a4mGfMbBfAkXKwjH5q2F1eGd9tVyROLDRXDSxDuYOD7kFuo9J
        QClvD48BhsS7IcENKjAOSAlShtPujeLos50tHDAYM0XQvweiKi7RTBQZNcKeBnr+OHDzzE+bj9iLj
        wgWwyDZPDIM+md6dmmZ66Mu9UZ4dzSbkUYmTs3XEW3hUdN2tf26kYUqB3Xs8I19yOjW/qHeQDxWX7
        v9180P287Yh/woZlzZVheCx3vYqiqTPaDO+wn5Qa5HppftycV9NrqXqPdeC3+XMtkI7rQyeI6jFTh
        4a0LBx+Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzkf6-00EAQG-0R;
        Thu, 18 May 2023 20:55:48 +0000
Date:   Thu, 18 May 2023 13:55:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     corbet@lwn.net, jake@lwn.net, hch@infradead.org, djwong@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH v2] Documentation: add initial iomap kdoc
Message-ID: <ZGaQ1KzKGuuPIpTb@bombadil.infradead.org>
References: <20230518150105.3160445-1-mcgrof@kernel.org>
 <707b28de-2449-5cf3-9360-b2faec0481c7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <707b28de-2449-5cf3-9360-b2faec0481c7@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 08:49:26AM -0700, Randy Dunlap wrote:
> On 5/18/23 08:01, Luis Chamberlain wrote:
> >   * use 80 char length as if we're in the 1980's
> 
> Well, like Jon said, long lines are difficult to read, even on printed paper.
> That's (at least one reason) why newspapers(!) have narrow columns of print.

Makes sense!

> Anyway, thanks for doing it.

Heh yeah, I just trying to follow the convention, but I didn't know it was
a special-case for bumping up to 100 only, and that it was definitely
not good for docs. It's easy to loose it though, we have one for commit log,
one for length on code with an exception, and we have a clear perference
for docs. Makes me wonder if editors pick up on project specific requirements
somehow? 

So for instance I used to have incorrectly;

set textwidth=100
autocmd FileType gitcommit set textwidth=72
set colorcolumn=+1

Cleary that 100 is wrong now and I've now updated it bacak to 80.
Could one be used for FileType for rst and ascii files?

If we shared something on the top level which lets developers
optionally pick up on project specific guideline it would be a less
common problem to ping back / forth about this. Curious how many
patches "length" is the reason introduces a latency for patches getting
upstream. You figured this would be a simple fix in year 2023 :P

Thanks for the fix recommendations! I'll wait and see if others find
others!

  Luis
