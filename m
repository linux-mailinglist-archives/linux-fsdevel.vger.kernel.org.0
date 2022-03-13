Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7D4D7322
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 07:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiCMGwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 01:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiCMGwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 01:52:37 -0500
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12BAA36171;
        Sat, 12 Mar 2022 22:51:29 -0800 (PST)
Received: by swift.blarg.de (Postfix, from userid 1000)
        id EABBD41024; Sun, 13 Mar 2022 07:45:14 +0100 (CET)
Date:   Sun, 13 Mar 2022 07:45:14 +0100
From:   Max Kellermann <max@blarg.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] include/pipe_fs_i.h: add missing #includes
Message-ID: <Yi2S+n+0lnuua4eC@swift.blarg.de>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
 <Yi1NkNkL5N1m4yU5@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi1NkNkL5N1m4yU5@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/03/13 02:49, Al Viro <viro@zeniv.linux.org.uk> wrote:
> TBH, I'd rather avoid breeding chain includes; sure, mutex.h and wait.h
> are extremely common anyway.  Oh, well....

In my usual coding style, I expect I can include any header and it
will bring its whole dependency chain (which should be as small as
possible, but not smaller).  This seems cleaner to me, because .c
files need to have no insight what a .h file needs (even if the
dependencies are "extremely common").

If the kernel coding style does not consider this useful, we can of
course easily drop that patch.
