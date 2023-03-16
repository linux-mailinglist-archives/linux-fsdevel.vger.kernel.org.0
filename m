Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48A6BD195
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 14:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCPN4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 09:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCPN4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:56:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBCB78A1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 06:55:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32GDtS2I018576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 09:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678974930; bh=b4yJHZSm1FYoCQ7iaTvyJObJNWidspS4Mj0nisvHJ0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RAXeP+ooejXrnKCF9isKnOmzIAipeNxJAh3MzkkJdy5XIcFqk41kn3/PvaitgTGuO
         Pir8RPV4bo4v9pvyWQvqzROWT59MDeGnuDNRsHWtw9A+1GZR65hgY17DRc0OFyHRCq
         fcIeWlSoWONPKi93EjCV2hpBuwx7N7gtDV5LuNZGnroyf0q6u09y8Ft1SFFlpGWLpo
         eiNvWi8GsiPGPsrme6UH24p6gx8XGFo312iM/v5ZepYpcw2sxkq62VWGTlpGeGYAi+
         Cwnr/LLMMHuQrMbfgjagxsVnHKtl/2HYS3P6GO9NHkFwQYfn2dk5TH8uTpiaTDXGGq
         pPLWFmeRa8aBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 03BAE15C33A7; Thu, 16 Mar 2023 09:55:28 -0400 (EDT)
Date:   Thu, 16 Mar 2023 09:55:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+636aeec054650b49a379@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING: bad unlock balance in ext4_rename
Message-ID: <20230316135527.GM860405@mit.edu>
References: <0000000000007e653f05f7023f88@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007e653f05f7023f88@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 03:51:50AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9c1bec9c0b08 Merge tag 'linux-kselftest-fixes-6.3-rc3' of ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d6a556c80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c84f77790aba2eb
> dashboard link: https://syzkaller.appspot.com/bug?extid=636aeec054650b49a379
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.5-rc2

