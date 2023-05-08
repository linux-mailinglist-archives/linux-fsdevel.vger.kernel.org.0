Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E14B6FB55C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjEHQkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjEHQkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 12:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6872A7;
        Mon,  8 May 2023 09:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D19B61D48;
        Mon,  8 May 2023 16:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C48C433D2;
        Mon,  8 May 2023 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683563941;
        bh=ELyESaT3VGjs/tLzzPRioIMW1+mw8WNX1w4bnRTpoeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8q9oE+gO17Z36AIuQ54QZR0+HQdZtQmT5jmlPVnQWRgOfqcuAKz4hlx71M41pxee
         FM/osBCdZtCFEir9ogxaCvmm1osXFbSJxHWFLpmzB6oSjkQOJccXo3R2ZXcse+08zd
         /mn9oFd7xjwtY1+XnVHLi7odsfhVmZrgm3n7Ur1eferF80u3RkAVFGRoIEarZe6r3r
         vbMyIT9niNwc3khpZrPno5J/J5l0wNu/2Uaa+k2KC+ZcS25cTM8R3JBXcxhabTLO/W
         /MQ2+pVbSBHqqgyVogzOZwUekbqnI1YLDR+MbTSeLdRffp9EdUz+hpFBn1BCUccO+J
         EN28Ml5lnvDbA==
Date:   Mon, 8 May 2023 18:39:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
        Peng Tao <bergwolf@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Documentation/filesystems: sharedsubtree: add section
 headings
Message-ID: <20230508-zonen-aufkeimen-800844200121@brauner>
References: <20230508055938.6550-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230508055938.6550-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 07, 2023 at 10:59:38PM -0700, Randy Dunlap wrote:
> Several of the sections are missing underlines. This makes the
> generated contents have missing entries, so add the underlines.
> 
> Fixes: 16c01b20ae05 ("doc/filesystems: more mount cleanups")
> Fixes: 9cfcceea8f7e ("[PATCH] Complete description of shared subtrees.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Ram Pai <linuxram@us.ibm.com>
> Cc: Peng Tao <bergwolf@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>
