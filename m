Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C632744D3D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjGBK3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 06:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGBK3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257F1B0;
        Sun,  2 Jul 2023 03:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF2A160BEB;
        Sun,  2 Jul 2023 10:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECE2C433C8;
        Sun,  2 Jul 2023 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688293759;
        bh=FwL43aRkt+bUazVx2ORIAyQiYbCyKiMCIfwG2xP9eJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iu6s4Dtx4B2m4NNXRAWD5PKdPPJ0Hofmknk+UD9urfpm1fo5C1ZoCezyd/M4RpxYx
         dHnqKw/cqfqSGkTFzRZ5wPC6tR9zWyoqmwqZkcCc5cylGQUvXTqVsnisyk8TRknNdD
         kmhoubXE//UvjdUWuWNeoEO+kFxrDQ0ROIXuXEHPFHSvcd+jnyfif+wsGM8wePrysk
         Lh1Es2NFVsx5pfRTbpYjdNvGM00TUlOaFnGyPeVGMxfIjEBsT5a0ZtLitnnvucXgC3
         TMnlm4l6opAIBsysUSFWRPL3Mym2G1YlRsGdaGgpm+DgvB6rzuNgsp8Y29VtTy1BOH
         vXG0nnjjsy2vg==
Date:   Sun, 2 Jul 2023 12:29:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in init_file
Message-ID: <20230702-neuer-anrief-61b5b722de0f@brauner>
References: <000000000000b7a0c305ff6da727@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000b7a0c305ff6da727@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 01, 2023 at 07:21:53AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1ef6663a587b Merge tag 'tag-chrome-platform-for-v6.5' of g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=120fd3a8a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=33c8c2baba1cfc7e
> dashboard link: https://syzkaller.appspot.com/bug?extid=ada42aab05cf51b00e98
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130a5670a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aac680a80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.fixes 
