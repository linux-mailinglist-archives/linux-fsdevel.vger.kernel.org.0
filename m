Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BA50A952
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392018AbiDUTkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 15:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392017AbiDUTj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BC34705B;
        Thu, 21 Apr 2022 12:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE1661C99;
        Thu, 21 Apr 2022 19:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BE3C385A1;
        Thu, 21 Apr 2022 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650569826;
        bh=Q6hxPwdWAM/6TqcEm/jAq+s1htCa8HBEP5b8F+ScUCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAH/GZzsfN8bVNuzQts+ou3GSuPk4puZ/0oel9IuGQF1jNwQDef2Z899wlJl/2kv9
         u/hFl+QIN3m2Vw7sR9qeHUKVnJyseDDYvskPUtKkkPb1FaCZ8nXGtgqAnQhFyWxZSe
         yClqT5SLuEhKbOci+Ux3upXr3TZ12j7LLin41oOkaj/dPu71XLmDAq4n+7cxJE2CDr
         o5jkKUJk/Off79lhjPcuOm1kL0EtZvzxReAy8n7a7fjtTncmODFEnMfZSDHkQ/bXWe
         P/rmUbGtlFUMq/8audbog+68KweSJ5XSwO76pRrB70S2GiB9brN7iHMjm3oMRmC5N8
         13RfQ3ZI7/FqA==
Date:   Thu, 21 Apr 2022 12:37:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+e0fda9a3d66127dea5c2@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] possible deadlock in evict (2)
Message-ID: <YmGyYOLMT2/m1CrE@sol.localdomain>
References: <00000000000018117c05dd29952c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000018117c05dd29952c@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 05:52:28AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a2c29ccd9477 Merge tag 'devicetree-fixes-for-5.18-2' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13508568f00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ac042ae170e2c50f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e0fda9a3d66127dea5c2
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e0fda9a3d66127dea5c2@syzkaller.appspotmail.com

Duplicate of https://lore.kernel.org/r/00000000000070395e05dd1fb4d7@google.com :

#syz dup: possible deadlock in fscrypt_initialize

This is an ext4 bug, and I've been planning to fix it; see
https://lore.kernel.org/r/YmC2epeJNChYxWB3@gmail.com

- Eric
