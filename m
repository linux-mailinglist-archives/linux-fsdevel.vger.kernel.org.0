Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E26A713B64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjE1RwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 13:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjE1RwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 13:52:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2DEA9;
        Sun, 28 May 2023 10:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45A0360F39;
        Sun, 28 May 2023 17:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62576C433D2;
        Sun, 28 May 2023 17:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685296333;
        bh=4HvaVQR1ubJwphBZulWTFAhkUjWttPrNPN9+qUwM4Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otrqXXqbeNYZ5LbkbRSPIJwObcvyPPgJBuvBNksIdu1rZQDPwIjqBsbP1+VjbVl2k
         ODRP21Laqudk2kShW850by1GxOaBM2jVPIkbLv7WpNIcq1KjayetGg4jL25yPXzIzF
         K2FrLqs+uJwlDRo89wdT3A/WbRgVfCYcDnjNXwtc=
Date:   Sun, 28 May 2023 18:52:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>
Cc:     skhan@linuxfoundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chenzhongjin@huawei.com,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Null check to prevent null-ptr-deref bug
Message-ID: <2023052852-footwork-sanding-e450@gregkh>
References: <000000000000cafb9305fc4fe588@google.com>
 <20230528173546.593511-1-princekumarmaurya06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528173546.593511-1-princekumarmaurya06@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 28, 2023 at 10:35:46AM -0700, Prince Kumar Maurya wrote:
> sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on
> that leads to the null-ptr-deref bug.
> 
> Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
> ---
> Change since v1: update the commit message.
> The bug was reproducible using the reproducer code and assets found in
> bug report:https://syzkaller.appspot.com/bug?extid=aad58150cbc64ba41bdc

Also, did you forget to properly credit the syzbot tool like it asks you
to?

