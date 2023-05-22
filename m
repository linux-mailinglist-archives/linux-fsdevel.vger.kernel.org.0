Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059F070BB0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjEVLDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjEVLDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA68D1FDE;
        Mon, 22 May 2023 03:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5031E6205F;
        Mon, 22 May 2023 10:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6D3C433D2;
        Mon, 22 May 2023 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684753017;
        bh=zQsTzWn7y4pqd57xyUbQt4p5dqkH1QaLp7gBSc/ZoRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYrLFlR3rXnvsEQt6mU5TKijvOn9r9AgTE6HybrEGFLQx72tuBt8iFZ/cIYOrYMfF
         Y1QS8Tvv4M78BO7dqTbG/sJ8dAwC6d+wDeQegHJ1b0OrmcLH7X/aWsl/S2/g2wapGl
         V3WQOHcMld74V7bm/jkkZv7Hxkt2IJ2/RgfAxz0OTLMt6fK02KTZ5VpW/xndTE/GqS
         qLO0Eso41FH/UEIUp+ctVpY1fyhnSl0cX2Y4SNKweO6g5NydSZ7+Ry6pNHubmlLDpi
         iVyUVicMlU9wjKGW3qMMWG1etQpgoMnsyNZnoyIiOrxdoxlRshYNqBzglB3pFODeMf
         4LEPZkbytbcdA==
Date:   Mon, 22 May 2023 12:56:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?B?5L6v5Lyf5qGD?= Vincent Hou <houweitao@didiglobal.com>
Cc:     "syzbot+92ef9ee419803871020e@syzkaller.appspotmail.com" 
        <syzbot+92ef9ee419803871020e@syzkaller.appspotmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "glider@google.com" <glider@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_listxattr
Message-ID: <20230522-karotten-biotechnologie-aa6ce3707ca4@brauner>
References: <a2f03e2ab9c34dcaabcf9fb11c0a1f45@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2f03e2ab9c34dcaabcf9fb11c0a1f45@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 10:12:38AM +0000, 侯伟桃 Vincent Hou wrote:
> Since the strbuf in hfsplus_listxattr was allocated with kmalloc and filled with hfsplus_uni2asc,
> which did not fill "\0" in last byte,  in some cases,  the uninited byte may be accessed when
> compare the strbuf with known namespace.  But I still need check the value of xattr in strbuf
> to confirm the root cause.  Please help test with below debug patch.

Uhm, no... The fs maintainers aren't responsible for testing random
debug patches sent to the list. This thing is also orphaned so the
chance of someone doing the work for you is drastically close to zero.
