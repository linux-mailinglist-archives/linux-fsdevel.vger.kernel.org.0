Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B291B47C962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 23:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhLUWst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 17:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUWst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:48:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4272C061574;
        Tue, 21 Dec 2021 14:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BKkXw7MNjVkk1g8b0s54kNVZ35EPgyCnfbympk+YPxE=; b=AXDzERoWGiE0lRhCAL7w33D0Hc
        4qfgoSdM6kkZeBjGDA4kZGNHvBUpus5urBM3L9uUcgpWWeMP/bkQ3//48cpiF6Ts9dKbX49lstFlA
        sk4nL9BU2TKHqZtCWpwj7Mkj3o3JyMpzRTmjHTzz6I8KZzThJNptXuoS3FCcnvMJpA0XiNgiGn/vH
        tGqc5C3anHnVNujWmVwiYarNTlXPoQfpHR/Xv40tXsnu13ckiX9Ftx9MnMKNvLuo+JeBQ6com+VyE
        aWes0334RbzjRtw8zcjUuZXb25VvEo5XSJJfZ2BIWSDz5aezyEzJNGb8ZNTogtW8PSpzdph2t+e3s
        Af8T9A7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mznw2-008fAd-Ld; Tue, 21 Dec 2021 22:48:42 +0000
Date:   Tue, 21 Dec 2021 14:48:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH][next] kernel/sysctl.c: remove unused variable
 ten_thousand
Message-ID: <YcJZyiUrlsPYExZ/@bombadil.infradead.org>
References: <20211221184501.574670-1-colin.i.king@gmail.com>
 <YcJLFQh9IA2XzXu3@bombadil.infradead.org>
 <CAKwvOdnK2Zc72tw6CdQkz=VxoRC0voWpda8Tgo38LaiRukDfKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnK2Zc72tw6CdQkz=VxoRC0voWpda8Tgo38LaiRukDfKA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:17:41PM -0800, Nick Desaulniers wrote:
> On Tue, Dec 21, 2021 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Dec 21, 2021 at 06:45:01PM +0000, Colin Ian King wrote:
> > > The const variable ten_thousand is not used, it is redundant and can
> > > be removed.
> > >
> > > Cleans up clang warning:
> > > kernel/sysctl.c:99:18: warning: unused variable 'ten_thousand' [-Wunused-const-variable]
> > > static const int ten_thousand = 10000;
> > >
> > > Fixes: c26da54dc8ca ("printk: move printk sysctl to printk/sysctl.c")
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> >
> > Acked-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Just double checking; I don't think I've seen someone supply someone
> else's Acked by tag in a reply before. Was there some discussion off
> thread that I missed? If so, do you mind linking to it?  Was this a
> typo, perhaps, and you meant to supply your own Acked by tag? Are
> "Luis Chamberlain" and "Andrew Morton" aliases? :^P

Haha sorry I copied and paste error.

Acked-by: Luis Chamberlain <mcgrof@kernel.org> 

  Luis
