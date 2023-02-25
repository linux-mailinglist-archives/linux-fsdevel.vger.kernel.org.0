Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C366A2BFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 23:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBYWCu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Feb 2023 17:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBYWCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:02:49 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0E61AF;
        Sat, 25 Feb 2023 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hhDirpwaPCZSKJXUK8XIZ9hVnNz+2+5eqhf9ieMCStA=; b=kVf1MdRP2tCfbzQYeSj//BCOiN
        wIak5n6vq/Q/qU3EttLc0svgy/gMvZnc4Wu94F0qqwDf/Wtqa7iLvfUYGGVbvzzwMgH/xVX2aPrf1
        WxF56TAK6VwQfXHb2GCg6ZEAv9xowjCOByusrZCICG3RKk56HL5I3UQCck+yxBcC4IAsLud/Ywsug
        z/b3eZvnM6a7kP5WmC6ayEL/eQeSLDzYYMIjAISa++UDizHi7FbcG91RbSt/P/yLJE6Q1jarFYY/e
        aPsCHruI/xmXfAqAIJUzDkZITiLqwynmq+B2ij3QALamKIdo7DdV8KZ6gMv60SwoBntoLM+kUbps+
        6DHfUpZw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pW2cv-00CJ2q-0X;
        Sat, 25 Feb 2023 22:02:45 +0000
Date:   Sat, 25 Feb 2023 22:02:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mezgani Ali <ali.mezgani@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [git pull] vfs.git misc bits
Message-ID: <Y/qFhd367Nq8iula@ZenIV>
References: <Y/gxyQA+yKJECwyp@ZenIV>
 <CAHk-=wiPHkYmiFY_O=7MK-vbWtLEiRP90ufugj1H1QFeiLPoVw@mail.gmail.com>
 <Y/mEQUfLqf8m2s/G@ZenIV>
 <Y/mVP5EsmoCt9NwK@ZenIV>
 <CAHk-=wgQz8VDDxdaj3rk861Ucjzk72hJoCjZvfaeo8jCyVc_2w@mail.gmail.com>
 <Y/pPV0q43R+drVtV@ZenIV>
 <3805D9F9-FB5D-4A8A-BE4B-845DDC508441@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3805D9F9-FB5D-4A8A-BE4B-845DDC508441@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 25, 2023 at 10:21:16PM +0100, Mezgani Ali wrote:
> Hello,
> 
> 
> Please clean the mailing list from lamers.

	First of all, I'm not an admin of vger.kernel.org; Dave Miller is.
Convincing him to make the lists subscriber-only is flat-out impossible - 
the best you can hope for is a personal ban.
	With sufficient effort you might be able to convince him to block
an exceptionally unpleasant wanker from posting; please, do not take that
as an expression of doubt regarding your capacity (or, heaven forbid,
a challenge), but you are still very far from the required level of
obnoxiousness - Dave has seen much worse.
					Hope this helps,
							Al
