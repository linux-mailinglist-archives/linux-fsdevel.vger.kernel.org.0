Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922AB78A8D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjH1JVJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjH1JUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5280130;
        Mon, 28 Aug 2023 02:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A3EE63523;
        Mon, 28 Aug 2023 09:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BB1C433C8;
        Mon, 28 Aug 2023 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693214424;
        bh=2Jz6MwB5q9EjiEODTH2uREHsQFEeyxWdlot1lPdULao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fo54WGr7KCftesChplDFjARqPCcW7TG9x/w6tXgLeOarY4CytHtFtGGIoPLisA5+1
         5SUfdHSF7S7CD8Xdp9dpQdoSXAWHZNubf1JhKThz5bqss38qY90u2hMBzWF1q7NJEc
         YKnuXNZvt9+ZPNOIJ7uqb85VshFLqIz/rqnrGVA5gjVYwYtwYuhA8az2DoiqYaT5Rd
         2FIZlDTs3ILSpOqgWXx9UMXgNyQPuBdivb9bqksCpjp33e04KhslNn3u1MvqCZxXAZ
         CzNR5oK6dKJKkwtrHe1oLgRVExjRaMaKjae+zlNI+Bv0kBi4xLb69MwFitovSgb9au
         pno1HoCOXGg9Q==
Date:   Mon, 28 Aug 2023 11:20:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     syzbot <syzbot+2b8cbfa6e34e51b6aa50@syzkaller.appspotmail.com>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com, jack@suse.cz,
        jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiubli@redhat.com
Subject: Re: [syzbot] [ceph?] [fs?] KASAN: slab-use-after-free Read in
 ceph_compare_super
Message-ID: <20230828-storch-einbehalten-96130664f1f1@brauner>
References: <000000000000cb1dec0603d13898@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000cb1dec0603d13898@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz dup: [syzbot] [fuse?] KASAN: slab-use-after-free Read in fuse_test_super
