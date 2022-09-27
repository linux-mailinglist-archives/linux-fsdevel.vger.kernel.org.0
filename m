Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1062F5EC4E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiI0NsP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiI0NsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:48:14 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC441FCA6A;
        Tue, 27 Sep 2022 06:48:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id E2B8941207;
        Tue, 27 Sep 2022 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1664286489; x=1666100890; bh=w3Kw4XLDtH2wwQmuL/OCBaR7NpeKaBFnp0N
        szIMowAk=; b=Dw0itN2ZVuGYy/y0Szazu/MAo1dCH2lbagbJtraAY3UJg0uwCno
        WHgwW83yCK1PaP2mi/yVRkkQ6tZ2DMCyTrSLs+waLOrlBnuvHInIVdDBTqbA9vB+
        sAA74wzhRZ5ZYzs0UvRyHmaajKgCpUuwIml1gXAgRDGZt+GviOXwhbU0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PqYWjEWmNHtU; Tue, 27 Sep 2022 16:48:09 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4E7CB41203;
        Tue, 27 Sep 2022 16:48:08 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 27 Sep 2022 16:48:08 +0300
Received: from yadro.com (10.199.23.254) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 27 Sep
 2022 16:48:06 +0300
Date:   Tue, 27 Sep 2022 16:48:05 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Miguel Ojeda <ojeda@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <patches@lists.linux.dev>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Sumera Priyadarsini" <sylphrenadin@gmail.com>,
        Gary Guo <gary@garyguo.net>, "Matthew Bakhtiari" <dev@mtbk.me>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v10 10/27] rust: add `macros` crate
Message-ID: <YzL/FfwKoL5eBiWS@yadro.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-11-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-11-ojeda@kernel.org>
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

On Tue, Sep 27, 2022 at 03:14:41PM +0200, Miguel Ojeda wrote:
[...]
> For instance, the `module!` macro that is used by Rust modules
> is implemented here. It allows to easily declare the equivalent
> information to the `MODULE_*` macros in C modules, e.g.:
> 
>     module! {
>         type: RustMinimal,
>         name: b"rust_minimal",
>         author: b"Rust for Linux Contributors",
>         description: b"Rust minimal sample",
>         license: b"GPL",
>     }
[...]

I remember that there was a switch from &u8 to &str on master branch a
while ago. Why this patch was reverted? Strings are really better here.
