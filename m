Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB81F08CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgFFUns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 16:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgFFUns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 16:43:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F81C03E96A;
        Sat,  6 Jun 2020 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aEoF+ZLxblPQyT1S+5dFpEMDuviUhW9tSKv6lHduQJs=; b=Oah1W8SknSDqTifpoN8YjTTkgi
        V4M87nSLEoW2xexOvAOMS4ropGdHVU4qlnmxmD7KjaNbGa8HHkvX4DuplQCLFFPhda2UPbyUUkusp
        Bk3t8qZp3E3tlKyAZZjiv/tcge2zgyo2kgZNRsSSQulgPtD361+eq8Zcpnf5ZTVrWPZznns6JiA82
        Ku4SHwLjCi09bpxkmaj3rHUpRn+HErum5x/pyv4FGwvuKXnRtUBrz0ezWoufBYqNePxJ8sJP2xAdf
        ZIre74HgecJbVErC873Pegfrj39vyErqUhEoQBB5f7BJyauTSY8XxusKENb0JGYCFgLrWjp+G3VHO
        lKV8p9mg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhff5-0001p5-2J; Sat, 06 Jun 2020 20:43:27 +0000
Date:   Sat, 6 Jun 2020 13:43:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        akpm@linux-foundation.org, ast@kernel.org, davem@davemloft.net,
        viro@zeniv.linux.org.uk, bpf <bpf@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] net/bpfilter:  Remove this broken and apparently
 unmantained
Message-ID: <20200606204326.GQ19604@bombadil.infradead.org>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 06, 2020 at 02:20:36PM -0500, Eric W. Biederman wrote:
> @@ -39,7 +37,6 @@ static kernel_cap_t usermodehelper_inheritable = CAP_FULL_SET;
>  static DEFINE_SPINLOCK(umh_sysctl_lock);
>  static DECLARE_RWSEM(umhelper_sem);
>  static LIST_HEAD(umh_list);
> -static DEFINE_MUTEX(umh_list_lock);

You can delete the umh_list too; you've deleted all its users.

