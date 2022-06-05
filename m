Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78953DB4D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbiFELC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jun 2022 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiFELCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jun 2022 07:02:55 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ADA6312;
        Sun,  5 Jun 2022 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Lsci107I6M24lE6c1fQ4KPG2t5kPnztRkgO0YO/CCs=; b=Q+sQ23xRh5/92KzDaEtwF3xAKe
        1iODhKIEnfCBDwpEH06Oj/WMaXu+fbpoDGMturmLOXvDpEyN+/FVZnjphSYfWgRhJCDptYkWxG7MG
        W4BflCsrrqY+sRwoTaH7fu0E2WUPOH5BZ6tCQPXATGFCylJFIUsraowxZ8prc6WCBfLtosm60FIYu
        ziL3uf2DQRCxQI2BNKskgZACHvzKDRK5znSGFPiaxnLcWK0o3QjdJQI7WNbLA5rZrI9qI/uh/6REQ
        4U1MzwGFXdpjL8ucqf6Tt5sIy/raClQ5/ETaGThxUt2KzlQw04xKPQ0LGlYeGWrOZgf72InAjE6tt
        T41UcDzw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nxo1y-003ksI-Qq; Sun, 05 Jun 2022 11:02:50 +0000
Date:   Sun, 5 Jun 2022 11:02:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+47dd250f527cb7bebf24@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in filp_close
Message-ID: <YpyNWgSXNityT14C@zeniv-ca.linux.org.uk>
References: <000000000000fd54f805e0351875@google.com>
 <00000000000063ee3105e0af6e6e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000063ee3105e0af6e6e@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 05, 2022 at 01:49:19AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    952923ddc011 Merge tag 'pull-18-rc1-work.namei' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=173fb6dbf00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3096247591885bfa
> dashboard link: https://syzkaller.appspot.com/bug?extid=47dd250f527cb7bebf24
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114f7bcdf00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1659a94ff00000

_Very_ interesting.  Has anything of that sort been observed on -next?

Because everything in that branch had been present there since at least
January.
