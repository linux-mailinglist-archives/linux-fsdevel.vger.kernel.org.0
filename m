Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116A7754987
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGOO4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGOO43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:56:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46592726;
        Sat, 15 Jul 2023 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gX2Ur56CpmqFeyTI5I1MG2pU7sRyHX4d4pChbT4mh+c=; b=B5zVT4IcoB76XE8RWVSIUOQH2I
        xgxMCzyS7OA1VYd40ZyS6+2gsIvDn1qgLguSLVH71cf1zOSFQee3+i9jgTf3+L26Gxpi9mm0nE64e
        zSUPzmTnee8R6tC1bsR1AWv9PPgQJvXI77qhHt+K76S0y2LmnTj8N8fJZapmwUteSOtZzHQRcZpJR
        NXtDwHM7EXfLyX56JkfwfDOVR/du50e5HNXyeZzUSc7RKrDbdtCII9rlMYunTaC2lxHEuh24DOfLf
        rmdXbIMUhCUhpk8kbkgj01gUYumQxWlTs21nha2+o5tAKoGLNYz2MpvL5jILrEGbqq+x0VqSrDCK5
        xXjcPFzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qKgh5-002GWX-JB; Sat, 15 Jul 2023 14:56:23 +0000
Date:   Sat, 15 Jul 2023 15:56:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Leesoo Ahn <lsahn@ooseel.net>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leesoo Ahn <lsahn@wewakecorp.com>
Subject: Re: [PATCH v2] fs: inode: return proper error code in bmap()
Message-ID: <ZLKzl+Ac+px98GwC@casper.infradead.org>
References: <20230715082204.1598206-1-lsahn@wewakecorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715082204.1598206-1-lsahn@wewakecorp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 15, 2023 at 05:22:04PM +0900, Leesoo Ahn wrote:
> Return -EOPNOTSUPP instead of -EINVAL which has the meaning of

EOPNOTSUPP is the wrong errno.  ENOTTY is "more" correct.

By the way, don't send v2 just because Markus has picked at a nit.
Wait for substantive feedback.

