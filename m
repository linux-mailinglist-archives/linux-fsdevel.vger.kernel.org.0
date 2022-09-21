Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674695BFCE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 13:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIULXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 07:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiIULXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:23:52 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B457971719;
        Wed, 21 Sep 2022 04:23:51 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 340BC404AD;
        Wed, 21 Sep 2022 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1663759428; x=1665573829; bh=/ca90bYJbAUSLeDn7WlM+Z6xGiYMcY7eT0U
        VuGEulUw=; b=CMJA3sbkU91jjir4K3cS4PstFDEZO7LZvIUAe37XcnH5ShbHkZj
        3veg/dOkkxtYHsWegxFwib4nhlUra47XlWA0n8PM7M/SFExvpgeZTW5DRjdOQwR/
        W/W2jHo13s8jkZVRSDxyBtBWExR9fNyqGytlc1TO584M5URDP58baGpU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jt2JIju1GUOH; Wed, 21 Sep 2022 14:23:48 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 20176400F6;
        Wed, 21 Sep 2022 14:23:44 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 21 Sep 2022 14:23:44 +0300
Received: from yadro.com (10.199.23.254) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 21 Sep
 2022 14:23:43 +0300
Date:   Wed, 21 Sep 2022 14:23:42 +0300
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
Message-ID: <Yyr0PmHaxvJ0r4hm@yadro.com>
References: <20220805154231.31257-13-ojeda@kernel.org>
 <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
X-Originating-IP: [10.199.23.254]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 06, 2022 at 01:22:52PM +0200, Miguel Ojeda wrote:
> On Sat, Aug 6, 2022 at 12:25 PM Konstantin Shelekhin
> <k.shelekhin@yadro.com> wrote:
> >
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

In my opinion, the rest of the thread clearly shows that the
conservative approach is currently the only solid option. I suggest the
following explicit API:

  let a = Box::try_new(size, flags)?;
  Vec::try_push(item, flags)?;

etc. Whadda you think?
