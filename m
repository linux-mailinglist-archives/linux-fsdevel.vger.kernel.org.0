Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0919169B8D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 09:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBRI5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 03:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBRI5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:57:53 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB1F6A5B;
        Sat, 18 Feb 2023 00:57:52 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 526F0C009; Sat, 18 Feb 2023 09:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676710695; bh=ubkQvRzSSBkiGGklnpex2BU+jgWyII/4bCUelk7PNlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0lfYDsXGftZOMT3IXaaAj2YaCMEOhcT6/6mSmLZPpFsw2XR9KO5YsU5gshxN3dD6
         9nRiufsd+S7v9xJKsOuj2wiQQz6H8OtLdSM6KzFSEzwali6Fwg3P9y1YlWLQ6ZTb6U
         ngSBVNmVp5CKW3Gcc14Gbh1BB5TWQCHDC+DpjO57CrchsDZjtruG6T5HGamNyuR79J
         1ERAi4xsMXkNtcKKUG+HLdDxx0QkuYNyBZK3HrcuJk/oTYQhbzr/xOVpeaGH9kAY6P
         NUedCLScCw4AtTigM4gESPUrksCdQ16ZuRgolKNHb7+FpkBC2iqK7wd2BjY18mfqjx
         lwTcEdvUo06TQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 82DEAC009;
        Sat, 18 Feb 2023 09:58:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676710694; bh=ubkQvRzSSBkiGGklnpex2BU+jgWyII/4bCUelk7PNlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCBPvYDUvj/yFub9mWEsBwW5RQthw4bAD68gxcyt4+AgoLY6bx9mBbjB+oYU7KdgZ
         b+Gjh5deCVq0X6xqOsO5lGogGT4n56e408gDNUirqwwA0g3WMOBhdAOMsZ3kCCuCKc
         OrYajWtesVodY4FSCjQzIwa0WWM/o0UhxNUbdCErCJh3pqEgamb6DU1e8sF7cS31f2
         7Dlj53N+SnMCp/A9yIkKhUrStL0YwlXHynE+AfMBqLQMWyN/Y4D1Jcpkk9rwfUfIXt
         BGIlqiEGixcf3jJvJkSU4KPLmxj4iELa4OHDBNNwO7TsJP8QZcsBVGrV0VPRnIslb2
         72K92JpSD2jQQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8c16b593;
        Sat, 18 Feb 2023 08:57:46 +0000 (UTC)
Date:   Sat, 18 Feb 2023 17:57:31 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 02/11] fs/9p: Expand setup of writeback cache to all
 levels
Message-ID: <Y/CS++GmLaVOzy7S@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-3-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-3-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:14AM +0000:
> If cache is enabled, make sure we are putting the right things
> in place (mainly impacts mmap).  This also sets us up for more
> cache levels.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique
