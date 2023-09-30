Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4118A7B3F95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 11:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjI3JD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjI3JD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:03:56 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A3195;
        Sat, 30 Sep 2023 02:03:53 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9A087C01D; Sat, 30 Sep 2023 11:03:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1696064629; bh=59HjiSLDEo3+ACXnA5m66IoUgd/1egFkIi0M5pdESts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uh6aS3FToSiY1OuqcKcYZQBx6bn7jOph77qLpcDrgGOejGkSJlCopVeE57cMCpl8U
         mQkJUBPzCO7xzUeTIT3DlKQ7KeowF/NyI2a/JQygNNMSOuzUg0QIoH+ZX6os83LiVd
         V/stCmX3JK1bVJhmjP458/WL9RtXIF8fXzRNtO9JkeHgEtJgiUufVCF6yXENZh++Np
         jSB3QGJAmujXIgKKA40r8LT/9ues0cmjPzI7YIFW8Zr1ApBs3mXazL26te0efbbiDp
         /UdvGdBLlvGscmcpWgFtqVI1aNTt7Zmed/rNaLlzhYyhe7x2WddbnltlyUBOHcSmER
         Nf8JiQ8uFd75g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C7991C009;
        Sat, 30 Sep 2023 11:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1696064618; bh=59HjiSLDEo3+ACXnA5m66IoUgd/1egFkIi0M5pdESts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iw0vHfxRkAHS1WfrcDJdZmjG5MMjaNPpGr+3uo2ujOYAGp3KLHj8VUDhrDJ8oEcAF
         U+os1aA5XJxPhVIujNlfifVYvjhaXAq7KmE6+k2mRxHb4ze+GDNotHcNxGYz8N8cwT
         pO3zg2egZxTOYHxeTGHqh7x89o2ajW6Gu/n7iOqaicYyiybcQYPlxKHauFsfzOzAmk
         Hw/6RjA3H6k+sDKaLW68ayZplMEcli3uBwdIvitEAEKQNDmkvwkF0sXT/5zpMu834h
         1DtzBTRnq8lk8yDcEI7rTlkgIXpVl35SC1uPl61GCTfUq9W+l6bBk0h0/htYLHeyAO
         mkQdNslNkGyUg==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id bceda604;
        Sat, 30 Sep 2023 09:03:32 +0000 (UTC)
Date:   Sat, 30 Sep 2023 18:03:17 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev
Subject: Re: [PATCH 03/29] 9p: move xattr-related structs to .rodata
Message-ID: <ZRfkVWyuNaapaOOO@codewreck.org>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-4-wedsonaf@gmail.com>
 <41368837.HejemxxR3G@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41368837.HejemxxR3G@silver>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Schoenebeck wrote on Sat, Sep 30, 2023 at 10:12:25AM +0200:
> On Saturday, September 30, 2023 7:00:07 AM CEST Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> > 
> > This makes it harder for accidental or malicious changes to
> > v9fs_xattr_user_handler, v9fs_xattr_trusted_handler,
> > v9fs_xattr_security_handler, or v9fs_xattr_handlers at runtime.
> > 
> > Cc: Eric Van Hensbergen <ericvh@kernel.org>
> > Cc: Latchesar Ionkov <lucho@ionkov.net>
> > Cc: Dominique Martinet <asmadeus@codewreck.org>
> > Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> > Cc: v9fs@lists.linux.dev
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

Looks good to me on principle as well (and it should blow up immediately
on testing in the unlikely case there's a problem...)

Eric, I don't think you have anything planned for this round?
There's another data race patch laying around that we didn't submit for
6.6, shall I take these two for now?

(Assuming this patch series is meant to be taken up by individual fs
maintainers independantly, it's never really clear with such large
swatches of patchs and we weren't in Cc of a cover letter if there was
any... In the future it'd help if either there's a clear cover letter
everyone is in Cc at (some would say keep everyone in cc of all
patches!), or just send these in a loop so they don't appear to be part
of a series and each maintainer deals with it as they see fit)

-- 
Dominique
