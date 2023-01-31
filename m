Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CA26833BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 18:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjAaRWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 12:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAaRWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:22:12 -0500
X-Greylist: delayed 1825 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 09:21:49 PST
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13AC4E536;
        Tue, 31 Jan 2023 09:21:48 -0800 (PST)
Received: from pool-98-118-100-52.bstnma.fios.verizon.net ([98.118.100.52] helo=[10.0.0.49])
        by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <conlanc@csail.mit.edu>)
        id 1pMtFP-0028A9-V2;
        Tue, 31 Jan 2023 11:12:39 -0500
Message-ID: <9c5a6b24-ce6b-b43d-aace-63af74fb6c38@csail.mit.edu>
Date:   Tue, 31 Jan 2023 11:12:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4] fcntl: Add 32bit filesystem mode
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        =?UTF-8?B?572X5YuH5Yia?= <luoyonggang@gmail.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <20201117233928.255671-1-linus.walleij@linaro.org>
From:   Conlan Cesar <conlanc@csail.mit.edu>
In-Reply-To: <20201117233928.255671-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> Reported-by: 罗勇刚(Yonggang Luo) <luoyonggang@gmail.com>
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://bugs.launchpad.net/qemu/+bug/1805913
> Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
Sorry to bump an old thread. Just wanted to note that the applicable 
qemu bug has been migrated to GitLab.

Link: https://gitlab.com/qemu-project/qemu/-/issues/263

