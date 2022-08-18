Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2FF598084
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 11:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbiHRJEp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbiHRJEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:04:44 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E0452462;
        Thu, 18 Aug 2022 02:04:42 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7E57443592;
        Thu, 18 Aug 2022 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1660813480; x=1662627881; bh=lZ4MHUT1h0SuflNPwEUcHRIabFx1neVnwfo
        FKAZ0Szk=; b=cdUCp5GIUr/L2oQg2eA1PKXmGBJiAZ7m96fJ3culr4twAWLXX7A
        CMQH/It+URbV8p7oLIr6slzdmYButZi7QT6DBYlMTrfaKHwVV9ISyOE7xJ2Pnxl8
        lQ64+WiwGQyDLwQKHVh+NB2IHeIOJU3SJrEyzNMmH6yoy5YJ7mBgH0J8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3DwWc1YOCtfa; Thu, 18 Aug 2022 12:04:40 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 9EA1B435A1;
        Thu, 18 Aug 2022 12:04:37 +0300 (MSK)
Received: from T-EXCH-09.corp.yadro.com (172.17.11.59) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Thu, 18 Aug 2022 12:04:37 +0300
Received: from yadro.com (10.178.119.167) by T-EXCH-09.corp.yadro.com
 (172.17.11.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Thu, 18 Aug
 2022 12:04:36 +0300
Date:   Thu, 18 Aug 2022 12:04:32 +0300
From:   Konstantin Shelekhin <k.shelekhin@yadro.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
        <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
        <gary@garyguo.net>, <gregkh@linuxfoundation.org>,
        <jarkko@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <me@kloenk.de>,
        <milan@mdaverde.com>, <patches@lists.linux.dev>,
        <rust-for-linux@vger.kernel.org>, <torvalds@linux-foundation.org>,
        <wedsonaf@google.com>
Subject: Re: [PATCH v9 26/27] samples: add first Rust examples
Message-ID: <Yv4AoOupMrFJe5qZ@yadro.com>
References: <20220805154231.31257-27-ojeda@kernel.org>
 <Yu5pUp5mfngAU7da@yadro.com>
 <CANiq72n029==Oc5wbG9pHGrRawRNzYxqZMBK6_S5gMjny5SoQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANiq72n029==Oc5wbG9pHGrRawRNzYxqZMBK6_S5gMjny5SoQg@mail.gmail.com>
X-Originating-IP: [10.178.119.167]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:02:01PM +0200, Miguel Ojeda wrote:
> On Sat, Aug 6, 2022 at 3:15 PM Konstantin Shelekhin
> <k.shelekhin@yadro.com> wrote:
> >
> > I wonder if it would make more sense to implement exit() in
> > kernel::Module, just for the sake of uniformity.
> 
> Do you mean uniformity with respect to the C side?

Yeah. It's weird that entry point is implemented in Module while exit
point in Drop.
