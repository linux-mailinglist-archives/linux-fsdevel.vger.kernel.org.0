Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED25C756C6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 20:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjGQSsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGQSsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E199;
        Mon, 17 Jul 2023 11:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FD11611E7;
        Mon, 17 Jul 2023 18:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBF0C433CD;
        Mon, 17 Jul 2023 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689619698;
        bh=KMJqZG7kZ3B5FFTPNWgNWHYx6C6P5j2AOUjAg1aSwCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AB5dsAaQMWdU2tx9h9C1Qsj+8Umi/53q5n/fAyFXgpb5J2QHCQ2U4XcTpdWYSHNXl
         Cii8NSx93kxP42yTv6j6w0igBktXP6FcihyM6kMa9kbdFXnqQruxmS4xl4aekFaUqU
         560d5jZCswiLbEJnWKkdkjo3ubiEiY8AJBLVXEec=
Date:   Mon, 17 Jul 2023 20:48:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 6.4 000/800] 6.4.4-rc1 review
Message-ID: <2023071702-cardboard-fleshy-35a3@gregkh>
References: <20230716194949.099592437@linuxfoundation.org>
 <CA+G9fYsSE1q5UiCZxP+EW_QuhMsLqBmVUoRnJqR=59S+5JFEZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsSE1q5UiCZxP+EW_QuhMsLqBmVUoRnJqR=59S+5JFEZA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 17, 2023 at 11:23:40AM +0530, Naresh Kamboju wrote:
> On Mon, 17 Jul 2023 at 01:24, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.4.4 release.
> > There are 800 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Following kernel warnings / BUG noticed on qemu-arm64 while running
> Kunit / KASAN tests while booting stable rc 6.4 kernel.
> 
> Similar issues have been reported on Linux next [1].
>  next: qemu-arm64: kernel BUG at fs/inode.c:1763!
> [1] https://lore.kernel.org/linux-mm/5d48dd9a-1822-4917-a77e-193a48ed3bd8@kili.mountain/
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Does bisection help?

thanks,

greg k-h
