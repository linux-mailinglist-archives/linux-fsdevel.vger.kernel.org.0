Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0702358B556
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 14:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiHFMPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 08:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiHFMP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:15:26 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B32B877;
        Sat,  6 Aug 2022 05:15:21 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 20C3141273;
        Sat,  6 Aug 2022 12:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1659788118; x=1661602519; bh=19EybQC+1gn5CR7Z0N2mdrVXzygyocg/h0i
        6NwEVs8A=; b=CAdNJIFsxV9D3u+0W7WT+pmyZb1P3mUNea56rbZ+zN37JS14K1p
        TUF6XFY7zY/aSp3hmQzRcHZU2Te1PbeEabbapFEORYNF5zF6f+csiUlsA3nd24fA
        KpdPr0mJAFosVf5tVK47+RUigUOtOFlBu0S56kmtVToXaZ9IPvp/eHLs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cJHOOhsCYjML; Sat,  6 Aug 2022 15:15:18 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A558841252;
        Sat,  6 Aug 2022 15:15:14 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Sat, 6 Aug 2022 15:15:14 +0300
Received: from yadro.com (10.178.119.167) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Sat, 6 Aug 2022
 15:15:13 +0300
Date:   Sat, 6 Aug 2022 15:15:12 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <ark.email@gmail.com>,
        <bjorn3_gh@protonmail.com>, <bobo1239@web.de>,
        <bonifaido@gmail.com>, <boqun.feng@gmail.com>,
        <davidgow@google.com>, <dev@niklasmohrin.de>,
        <dsosnowski@dsosnowski.pl>, <foxhlchen@gmail.com>,
        <gary@garyguo.net>, <geofft@ldpreload.com>,
        <gregkh@linuxfoundation.org>, <jarkko@kernel.org>,
        <john.m.baublitz@gmail.com>, <leseulartichaut@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m.falkowski@samsung.com>, <me@kloenk.de>, <milan@mdaverde.com>,
        <mjmouse9999@gmail.com>, <patches@lists.linux.dev>,
        <rust-for-linux@vger.kernel.org>, <thesven73@gmail.com>,
        <torvalds@linux-foundation.org>, <viktor@v-gar.de>,
        <wedsonaf@google.com>, Andreas Hindborg <andreas.hindborg@wdc.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
Message-ID: <Yu5bUK4/70SanMss@yadro.com>
References: <20220805154231.31257-13-ojeda@kernel.org>
 <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
X-Originating-IP: [10.178.119.167]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 06, 2022 at 01:22:52PM +0200, Miguel Ojeda wrote:
> > I sense possible problems here. It's common for a kernel code to pass
> > flags during memory allocations.
> 
> Yes, of course. We will support this, but how exactly it will look
> like, to what extent upstream Rust's `alloc` could support our use
> cases, etc. has been on discussion for a long time.
> 
> For instance, see https://github.com/Rust-for-Linux/linux/pull/815 for
> a potential extension trait approach with no allocator carried on the
> type that Andreas wrote after a discussion in the last informal call:
> 
>     let a = Box::try_new_atomic(101)?;

IMO it's just easier to always pass flags like this:

  let a = Box::try_new(GFP_KERNEL | GFP_DMA, 101)?;

But if allocate_with_flags() will be somehow present in the API that's
just what we need.

P.S. Thanks for a quick reply!
