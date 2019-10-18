Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B4DC495
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392742AbfJRMVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 08:21:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37076 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387570AbfJRMVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:21:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so3301533pgi.4;
        Fri, 18 Oct 2019 05:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VcukdS+h2wwJ3/U/N/4m0S2AoPCXUWoZLLc3DYniW2I=;
        b=Q1msBJ3e099t2nSvYex7Z+jTlpopRllh6mguFZOeeE/m7DMYYYL/lcy4zZY7iravmh
         8j9vf+/tlXDsLORK298oltaRNxfF6CBcQjtLOArMJyzbhA1ZpLrJj+BWFWS0IaN728eQ
         xsZTBwLn41uMv4KqA9pw3hGXllxMNnqTCEfew/8Ly4k0XbdwWGAsB0ok7BAxw4iljEiI
         5EfWa71cpcSoM2uC4hAwdkGO+KeoRuRoxAprpIkCUPs+fJsU67Zbd8bT1GGV6QHGEgFe
         3cHE1udYLTIJQU0ttyl5AdAJ1iPS/qYkGW4cGlDVS7GwZ2hewbDQkTTVImp9LzkWg0TI
         /4Kw==
X-Gm-Message-State: APjAAAUsMEl/Ik/gBhxQlSpCpK7vgio3BMcbFr7GADiKQz94GQjNiD+J
        TJvpz7wziqUL4cdVqnxVlc4=
X-Google-Smtp-Source: APXvYqx1rmDV8Tbar4XUzXvi4MjLnC0zwf0LcXubUrDJ70/UhX+bBzy1YlAwSw1OAw5siYTwcytnzg==
X-Received: by 2002:a62:ae06:: with SMTP id q6mr6445843pff.96.1571401304946;
        Fri, 18 Oct 2019 05:21:44 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r24sm6749355pfh.69.2019.10.18.05.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:21:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 843DE4042C; Fri, 18 Oct 2019 12:21:42 +0000 (UTC)
Date:   Fri, 18 Oct 2019 12:21:42 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
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
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v2 linux-kselftest-test 1/3] kunit: allow kunit tests to
 be loaded as a module
Message-ID: <20191018122142.GC11244@42.do-not-panic.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <1570546546-549-2-git-send-email-alan.maguire@oracle.com>
 <20191008213535.GB186342@google.com>
 <alpine.LRH.2.20.1910091726010.2517@dhcp-10-175-191-127.vpn.oracle.com>
 <CAFd5g46_6McK06XSrX=EZ9AaYYitQzd2CTvPMX+rPymisDq5uQ@mail.gmail.com>
 <alpine.LRH.2.20.1910111105350.21459@dhcp-10-175-191-48.vpn.oracle.com>
 <20191016230116.GA82401@google.com>
 <alpine.LRH.2.20.1910171930410.21739@dhcp-10-175-161-223.vpn.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1910171930410.21739@dhcp-10-175-161-223.vpn.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:32:18PM +0100, Alan Maguire wrote:
> kunit needs a non-exported global kernel symbol 
> (sysctl_hung_task_timeout_secs).

Sounds like a perfect use case for the new symbol namespaces [0]. We
wouldn't want random drivers importing this namespace, but for kunit it
would seem reasonable.

[0] https://lwn.net/Articles/798254/

  Luis
