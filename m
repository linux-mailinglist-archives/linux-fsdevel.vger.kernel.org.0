Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7306C69B8A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 09:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBRIFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 03:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBRIFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 03:05:40 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B939241F1;
        Sat, 18 Feb 2023 00:05:39 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0D381C009; Sat, 18 Feb 2023 09:06:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676707562; bh=OAFcUBrsFSt/oLsR9EX7XJPu+XPQ3u8XJHEt8p0SO6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BHd8YQX7F8Yb5vCd7Wz0fW+8gJYl0yPKGqWXeRSBmxrHzvCWMYCynq+HmxjibxaSq
         CV/eZIjxmlmOskC0qyM+4ppyoxHlvTnL+Mk4RxHAv/8WqGDJtRN58qhrnwGHJ8sqme
         ULClBf0mySrEau33jjTAweqRdxHPUUJMx50BGA4NxOHWluWruPNI2QkkZBCrgzeyev
         FLpBxB4RfvC9aLGZDuAsCjEEUA+PcOjfmb2JF5+KvrXc8SUZ09yjsp/y0A+rTmYueZ
         brZhlzYfnlFhSlLX55I92b8z0HsEPQEHa+z+rWXUqa9stwD65y72MsVpSPN8GTlHT/
         /V9XWUNA+YfKQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 53958C009;
        Sat, 18 Feb 2023 09:05:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676707561; bh=OAFcUBrsFSt/oLsR9EX7XJPu+XPQ3u8XJHEt8p0SO6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4o7yZ0dQS0w/9C742EN6EZy3polnQtnWPv3DhkBLu2PWmWTPxvhXV6CYW+ZIKYQb
         NMbERoFfPK3EXtTFk/TfePHaKmJCP6liTcAC9BFCDLd1GB9VPjJJiUPcxk4VsXO45p
         QVvwvAi/PckB3N58LuzcOH7zR9qsb1TIh9qU9SYq8IEOH5TcJL5ZoaIEUTtF9nFDCc
         sbwG+dvkVa2iMX/LGoB0ng1c6hrqpb/lHI0LnfJWd94IBRaKhFLTWdwm2jXvO8mFVa
         rMfywRxcUD9mdfwm6PfGha0TxXZpANhmjO96P4GbCzumjfQb90K7bd+TQco2dF6wx5
         3Ej7embvrv59Q==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id fb6f5d93;
        Sat, 18 Feb 2023 08:05:32 +0000 (UTC)
Date:   Sat, 18 Feb 2023 17:05:17 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 07/11] 9p: Add additional debug flags and open modes
Message-ID: <Y/CGvTCyhjFITkFs@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-8-ericvh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230218003323.2322580-8-ericvh@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:19AM +0000:
> Add some additional debug flags to assist with debugging
> cache changes.  Also add some additional open modes so we
> can track cache state in fids more directly.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

New debug flags can't hurt.

For open modes: don't we send the mode verbatim to servers? won't they
be confused?
I guess I'll see in the next patch if you trim it down, but we might
want to add a P9_MODE_MASK or something with values we're allowed to
send and have client.c filter it out?

-- 
Dominique
