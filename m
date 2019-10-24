Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06C0E27C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 03:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392652AbfJXBd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 21:33:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38179 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392621AbfJXBd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:33:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id c13so2831724pfp.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 18:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzW923PDOaFWZLYNBS+ZAT/dQUlLsBw1xA3tQqC14LE=;
        b=MePawSy7G7ab3fyxYb19SAhjqaFXuVviUvLejjX4rvP8CqBwpHokO1ZzZyHhrghHfA
         BjyykblEJYWgdbrpSHkT4o3/Sr0ngCaHT4CnhgI4jmCBPlZj4RH7giHxF9isEekzG5/R
         Oa75DnFrTuQzrsK/iAFHxL4TnW0RX0fdRmcdVODwproybPRkPEyZv53womwfwEw2GiyN
         WHzB7vmE5oyrO1l4Z1CO7m7o1IwvW+fEIFf9rFJ51HgJqBAT/+Uev1fGSwmnL6CcUXy2
         U4Ef78lcQSppkUTAG9Eb9ExLetpOsvQaKVs1YcNAnslXvqGGuEfBvwo+b/TKJ4D/P4tS
         /uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzW923PDOaFWZLYNBS+ZAT/dQUlLsBw1xA3tQqC14LE=;
        b=OkqIo7eAGZjQuOMr+9BNYXjcPTv+eGDOZIXQ8LftN8qiHTD2D5hRqJYxGLLdIfgXO2
         lBkjjQtmhnYh4AFyLI7cpEkxmr9PrUz3OXdOrV2cWDu1aXZRCxLVv6/q4Y7N+B6vadV5
         GJ0QgllHhjfHo1njCYrGlOWEmb8lqqZHUGmVKZHVIStJc+dLVZyw9oP22cfGmHxpHRoH
         BmITYtBePlynUsSKHHYyKqKdSDx4onAHX6etvskGBZuF6MJ87XxUMJZ84rkfQQ5YGRUq
         JEmYLIvk0lapk8TyvYhgM7oJ02ATFlz5m2C8nrxIBZzH13CsxqQq+SnbS0XBTeyVyqNv
         0H+Q==
X-Gm-Message-State: APjAAAXckH3l1rUqM3XFMk1YTC9qhbjeUbNW/9pFcAfZWWWY5suRzVT7
        TLYkbd9aDgk6AZUKoBXI+Q43ghg1JWAo/lqFVjOErQ==
X-Google-Smtp-Source: APXvYqwkXuRs73dz9Oxxu6xMfhgj/rivfh87OSdGtX/ZgPAej8TyXZ3fhlT9KrUm5FbuVLWT6c1TjEcugwWSEOGFDcg=
X-Received: by 2002:a63:3044:: with SMTP id w65mr13157060pgw.384.1571880806585;
 Wed, 23 Oct 2019 18:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <1570546546-549-2-git-send-email-alan.maguire@oracle.com> <20191008213535.GB186342@google.com>
 <alpine.LRH.2.20.1910091726010.2517@dhcp-10-175-191-127.vpn.oracle.com>
 <CAFd5g46_6McK06XSrX=EZ9AaYYitQzd2CTvPMX+rPymisDq5uQ@mail.gmail.com>
 <alpine.LRH.2.20.1910111105350.21459@dhcp-10-175-191-48.vpn.oracle.com>
 <20191016230116.GA82401@google.com> <alpine.LRH.2.20.1910171930410.21739@dhcp-10-175-161-223.vpn.oracle.com>
 <20191018122142.GC11244@42.do-not-panic.com>
In-Reply-To: <20191018122142.GC11244@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Oct 2019 18:33:15 -0700
Message-ID: <CAFd5g44FJa0P622cjPw_SGtp45ArHq6rVq=1o10b0RsS35_9YQ@mail.gmail.com>
Subject: Re: [PATCH v2 linux-kselftest-test 1/3] kunit: allow kunit tests to
 be loaded as a module
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:21 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Oct 17, 2019 at 07:32:18PM +0100, Alan Maguire wrote:
> > kunit needs a non-exported global kernel symbol
> > (sysctl_hung_task_timeout_secs).
>
> Sounds like a perfect use case for the new symbol namespaces [0]. We
> wouldn't want random drivers importing this namespace, but for kunit it
> would seem reasonable.
>
> [0] https://lwn.net/Articles/798254/

Sounds good to me.
