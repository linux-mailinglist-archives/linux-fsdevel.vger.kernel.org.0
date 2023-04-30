Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0546F27CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 08:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjD3GcO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 02:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD3GcN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:32:13 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBC3C1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 23:32:12 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33U6W56Y005819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 02:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682836328; bh=643DuUgAB//cYcsxro4WK5uhMJqgvM367EgOy2Z/Ql4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ix2qo65UsPkP4+Vgx1NsvAWHRqWBJCBpHgCK2RBPWGsOYQ2ZZwVJZTyrGNzgUBdeK
         CLU3M4X/pUMVlt4at4pccS+KOU5tvzCHuR9C2sYwUecZTu8YAT2g43dILCxUB4X3mB
         OJdXOw1ITDeoH+bAiX3UpkfFBY7cvu4Uj3St8kLnq9Yh8WJlZDn8/1b0JMjgTYbItI
         SqR13hKqihbG5/tAiyVCv1R7reIDNBJl6LFzAKqdGO29L60qGPWCPPwh66f2j6QtQk
         XuKmjRwyyrISeqvU9nHlwU8JXZWrG0akPcGjoSJVXpfgmDg6QVlxKfbEO3wjOKwAEZ
         UDjvjxld4yebQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id E3DCC8C023E; Sun, 30 Apr 2023 02:32:04 -0400 (EDT)
Date:   Sun, 30 Apr 2023 02:32:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+221d75710bde87fa0e97@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: INFO: task hung in lock_mount
Message-ID: <ZE4LZP5V/TGMoRwz@mit.edu>
References: <0000000000006de361056b146dbe@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006de361056b146dbe@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set subsystems: nilfs

Per the information in the dashboard:

	https://syzkaller.appspot.com/bug?extid=221d75710bde87fa0e97

There is no mention of ext4 anywhere, and nilfs does show up in the
stack trace.  So why this is marked with the lables "ext4", "nilfs" is
a mystery.

Fix it.

