Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BF66F2974
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 18:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjD3QNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjD3QNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 12:13:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F9DE4E
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Apr 2023 09:13:04 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UGCnlL009113
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 12:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682871172; bh=nHD7XK7HRUbCzAD1Qp3+raTGPLH0kufM08uKe4zuaWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=d9xtTrzZlS1jJkdhDcu9bscLaOdVLUgfATJqmcM2FU3curK9urZ9nv5NKCmuTvlpT
         pZo93MzkpvawhVwytXmXhjYefPx9S9S4QMomJoIYcp0xS1tpKhPi0QKsC7vsDhP9ng
         cbr4HjtQ22599ZX1rpHEYru7NTmTEDtYQB83MUoIOZxmxjv1xLEX6qxrhvNQR2CLpe
         KfRfezjtuXzR3NYyQuH4VrQApcM5UBTBCSdFQugjHfrp5yC2ZBiZEev3FyYjWz861o
         EKKoH+QM+DiuSnCZun+NUSdeZiB1Aammh8CruvEsQdREAJb9DQQCw54QzvnxeBxosr
         NQ+qMaMBnyFWQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 9A4818C023E; Sun, 30 Apr 2023 12:12:49 -0400 (EDT)
Date:   Sun, 30 Apr 2023 12:12:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+9743a41f74f00e50fc77@syzkaller.appspotmail.com>
Cc:     hch@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [sysv?] [vfs?] WARNING in invalidate_bh_lru
Message-ID: <ZE6TgcjJX46FO4bW@mit.edu>
References: <000000000000eccdc505f061d47f@google.com>
 <ZE4NVo6rTOeGQdK+@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZE4NVo6rTOeGQdK+@mit.edu>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz set subsystems: udf

There are two reproducers, one that mounts a sysv file system, and the
other which mounts a udf file system.  There is no mention of ext4 in
the stack trace, and yet syzbot has assigned this to the ext4
subsystem for some unknown reason.

					- Ted
