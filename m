Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061F46F27BA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 07:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjD3FZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 01:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjD3FZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 01:25:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9971BFB
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 22:25:01 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33U5OgTs026284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 01:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682832285; bh=H7Moc+rihpPCzPD7wCdEPP4bXGikqsMnJrllZeEscZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MY8VywNXeptFx2M2tWYq+tAtzGcFl51QBj+dbg37aEpnViWqAJCjiyxerltP8Fr5Q
         y09lWrp6jRTrw1R2tl/qS09uUAp8DsNhn9+0mamqPWgFoFkdAyl+LwXHuLXPXPEauU
         s6n07NHfqd9NSYLGNrHWZstPD27sCE9Gd8b8d0vt3/plIz+xn46kqrTjtptHblTWjX
         Tju4/m/u27gC8JfI14L06GjQ9mtydeghjMDJSiYs6DiFNGsi07sjFAgETLMlvl5aXL
         +oQ/Zb+7rlMPo961/6WQiJPyBb8U+aqVCLGNexjO4ssV2mdFd4R/76MmCI6Zfp/Zbp
         Kcrci/QsFxKhQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 545678C023E; Sun, 30 Apr 2023 01:24:42 -0400 (EDT)
Date:   Sun, 30 Apr 2023 01:24:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+0c73d1d8b952c5f3d714@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] WARNING: bad unlock balance in ext4_rename2
Message-ID: <ZE37mm9XT7sE7crX@mit.edu>
References: <000000000000435c6905f639ae8e@google.com>
 <ZAeOilzUDPQX7joj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAeOilzUDPQX7joj@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz fix: ext4: fix possible double unlock when moving a directory

