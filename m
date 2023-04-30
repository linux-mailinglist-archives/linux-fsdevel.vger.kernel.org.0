Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC96F27D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 08:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjD3Gev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 02:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjD3Get (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:34:49 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E819AF
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 23:34:48 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33U6YaB2007449
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 02:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682836479; bh=nUUgc/JMrbEeUkh1Vk6I4IYe2bkmJ/DGJQpE4V6OUoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=McyxwVs1+Cc0uIyxiLq9NCeJziWRiGaq+oL4vWx4YNecceAN67idVL6XdMYhiR2O3
         QAhayMsJY61+d2W9U1rjCxAup1FZTIunY//Mt5NhlXD+d5m0p/uzIrA6TO7f39LfzP
         dnnEL88+kWhdk7e5l0rmoZPjKKojmYVyoSEHp2rUoEqiZ26Ueej57pLOc8hiG/ooIs
         Mk9PLdElD9QQHo6aUpXKoGY/vHb4gFO/G9Kq8FpFdarcrWqwIg1GXNQKWQlJVU/hz2
         zQ331NiHKoE8iJp71pI5+pXqISo2XhQSu8haplTG2jCfh98S2uEyPpRCePRrKiTHj9
         ZBEh55uN1pG+A==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 025348C023E; Sun, 30 Apr 2023 02:34:35 -0400 (EDT)
Date:   Sun, 30 Apr 2023 02:34:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+e6dab35a08df7f7aa260@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in eventpoll_release_file
Message-ID: <ZE4L+x5SjT3+elhh@mit.edu>
References: <000000000000c6dc0305f75b4d74@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c6dc0305f75b4d74@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set subsystem: fs

This somehow got tagged with the ext4 label, and not the fs label.
(And this is not the first one I've noticed).  I'm beginning to
suspect there may have been some syzbot database hiccup?  Anyway,
fixing...

						- Ted
