Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8E50A2E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389555AbiDUOqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389148AbiDUOqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:46:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C64092D
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 07:44:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A96B768B05; Thu, 21 Apr 2022 16:43:59 +0200 (CEST)
Date:   Thu, 21 Apr 2022 16:43:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Hillf Danton <hdanton@sina.com>, fweisbec@gmail.com,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de,
        syzbot+10a16d1c43580983f6a2@syzkaller.appspotmail.com,
        syzbot+306090cfa3294f0bbfb3@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: unset MNT_WRITE_HOLD on failure
Message-ID: <20220421144359.GA23202@lst.de>
References: <00000000000080e10e05dd043247@google.com> <20220420131925.2464685-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420131925.2464685-1-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
