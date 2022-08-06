Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D8E58B5AF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Aug 2022 15:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiHFNPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 09:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiHFNPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 09:15:08 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62CD124;
        Sat,  6 Aug 2022 06:15:04 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C985E41252;
        Sat,  6 Aug 2022 13:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:message-id:subject:subject:from:from:date:date
        :received:received:received:received; s=mta-01; t=1659791701; x=
        1661606102; bh=q5OKKxZRBgM4bW1kdQ8O8zT04WTFJvoyidSvN/4zvCk=; b=d
        jJdaxptRbpCKR69fqecsPXwgJzgwgDY4kTVclLUm+z6sSJGSrP3lU+LANWLgpjjT
        8Qd/YgJn2ZrxF/x69EzptU/c9y9BDc7QrW+F/xQhbT0n2S4MfBGayVMrCxENXM+l
        W4EY8n5gnseKUSvroAFIQyQ47AyJOwqtKDk7po6+DI=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jz0tFemnO3kQ; Sat,  6 Aug 2022 16:15:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 10C0741235;
        Sat,  6 Aug 2022 16:15:00 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Sat, 6 Aug 2022 16:14:59 +0300
Received: from yadro.com (10.178.119.167) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Sat, 6 Aug 2022
 16:14:59 +0300
Date:   Sat, 6 Aug 2022 16:14:58 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     <ojeda@kernel.org>
CC:     <alex.gaynor@gmail.com>, <bjorn3_gh@protonmail.com>,
        <boqun.feng@gmail.com>, <gary@garyguo.net>,
        <gregkh@linuxfoundation.org>, <jarkko@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <me@kloenk.de>, <milan@mdaverde.com>, <patches@lists.linux.dev>,
        <rust-for-linux@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <wedsonaf@google.com>
Subject: Re: [PATCH v9 26/27] samples: add first Rust examples
Message-ID: <Yu5pUp5mfngAU7da@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-27-ojeda@kernel.org>
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

> +impl Drop for RustMinimal {
> +    fn drop(&mut self) {
> +        pr_info!("My numbers are {:?}\n", self.numbers);
> +        pr_info!("Rust minimal sample (exit)\n");
> +    }
> +}

I wonder if it would make more sense to implement exit() in
kernel::Module, just for the sake of uniformity.
