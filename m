Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9884DDCD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiCRPaj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 11:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiCRPah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:30:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56241C4E03;
        Fri, 18 Mar 2022 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wLbciClnuT4FSNA8HsmJGJalLFVE6s7HbXIbgp6eJdM=; b=IsuUGYajcuYM0U53vE46zyyASS
        bNzQ5ALzgIrvDwvGPqV5TLTDXJ4eJnja9+7o4uSEsVqj9oSLTcs/MYIxj2KfzrTFACOd2QkSqbSBE
        KG8MDdgDYJqAZ3NBtGSP8RO1M7xa8ojnj0bvjBa42fBtQEwHUI8SgKHznYePnkDpJOoNp2R2z2Pdt
        IegysZDBkxF2MrLK+3/Ytc7dyOKAUQZO9yYbtZTj2g5fIcjwQDM03csHaiXvAq/n4rY1Tqt2I27C7
        QE0wtXFSKZ9wkRC+coAy7Qr/EmMa86RAS+bl9P76wR0Sba3oWe61mp0sFBY6Mo/3wJCOlscUAD1CD
        pNpWdAYw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVEXN-0083dY-GX; Fri, 18 Mar 2022 15:29:09 +0000
Date:   Fri, 18 Mar 2022 15:29:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+2b3af42c0644df1e4da9@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in inc_nlink (3)
Message-ID: <YjSlRR/qd8AjIzRu@casper.infradead.org>
References: <20220318151034.2395-1-hdanton@sina.com>
 <000000000000e8202805da7fc37b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e8202805da7fc37b@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 08:26:06AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:

FWIW, neither of Hillf's patches have made it to the list.

https://lore.kernel.org/linux-fsdevel/000000000000e8202805da7fc37b@google.com/T/#u

Hillf, can you fix your mail setup?
