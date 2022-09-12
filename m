Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D935B57AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiILJ6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiILJ6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:58:45 -0400
X-Greylist: delayed 945 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 02:58:43 PDT
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1111763D8;
        Mon, 12 Sep 2022 02:58:42 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=226828f8df=fe@dev.tdt.de>)
        id 1oXfxm-000Oq0-87; Mon, 12 Sep 2022 11:42:46 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1oXfxl-000FzA-H8; Mon, 12 Sep 2022 11:42:45 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 136A0240049;
        Mon, 12 Sep 2022 11:42:45 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 8660E240040;
        Mon, 12 Sep 2022 11:42:44 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 0774E28CA4;
        Mon, 12 Sep 2022 11:42:44 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Sep 2022 11:42:43 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Eckert.Florian@googlemail.com
Subject: Re: [PATCH] fs/proc: add compile time info
In-Reply-To: <CAK7LNAT3cyv07p7AZ54D=HOZRZ7-zLgMM+YPNLzcPidpDvXZgA@mail.gmail.com>
References: <20220908113449.259942-1-fe@dev.tdt.de>
 <CAK7LNAT3cyv07p7AZ54D=HOZRZ7-zLgMM+YPNLzcPidpDvXZgA@mail.gmail.com>
Message-ID: <c8577c14a1663cbdea70534c086c247c@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1662975766-314C93D3-96E302D4/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Masahiro,

thanks for your feedback.

> https://patchwork.kernel.org/project/linux-kbuild/patch/20220828024003.28873-6-masahiroy@kernel.org/
> lands, nobody cannot reference KBUILD_BUILD_TIMESTAMP,
> then this whack-a-mole game will end.

I was not aware of that problem. Thanks for the link.

I understood that this is a bad idea to create the timestamp for proc 
like this!
But how does it look in principle to offer the build timestamp in proc 
for reading?
You have only made your point about creating the timestamp but not about 
reading it out via the proc directory.

So far the timestamp is only readable as a string via dmesg.

Best regards

Florian
