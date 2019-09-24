Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DFBD318
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633017AbfIXTw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 15:52:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36943 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfIXTw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:52:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so3389487wro.4;
        Tue, 24 Sep 2019 12:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SbmHfsmTtyk1Jf/7pHuYO9Paq+uzsOyD6aVzZqtjMnE=;
        b=bL1q7c+usPv7hqqqT3/tKie6BjCNJtADeDmTXiWoYao1zJaM3l8tBUCm+Co2Jw4OrA
         02CLF/B55nhRD+6BrAsYSbjOWzwQew/iKuTNz/Sxpx2dYcwBts4emsrdwPNRNPkfnEjZ
         uQaNU7Hr/L9pzwoAFljkKZLpy9SEzpEwI1jg+ijwwYkAlEka97r2NFw74+IMYXNnHzgr
         /kIObHdt5WewBoo9hWO50fu8TSTeTageFwx7otwA3JSXuDRBeAuFZHNxE6zdZBag8Lpb
         k/sp/HZRERCTfqxF6bcqNBaOKwKBLjApO0Kb8TWmrkl1Wvh8VVXXe/5Xx2rL6pqu3YI8
         H7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbmHfsmTtyk1Jf/7pHuYO9Paq+uzsOyD6aVzZqtjMnE=;
        b=LfKkpyzfpvtJYcaZC6jwFDienNErvttZFfNSMvy1jOPWsvVoGmAEGr7SZ73kodMqvD
         gr3EtzrYZtB4IZRZEKCoSCcEwe++iZVNyvmLwTdsNG6/XjvcaazT6zKyemkaSPxwP9sB
         4vDVliJbATouIAMQ7M4xW6vYWnzy+GkNQzt626VZYmy8tpkRBftgdPFrMpD1Ifydxiyl
         Jowzgw9Ttt8bRkOxxb01USoAbjTYNyHb2mRCWlQFhRs/wwZS5JeDOpemBTiS0CC/l1Rk
         Rc7P7mFac6uzpnzfyXMg+ANKh7YhS8GYxZdzRgU5dGag/f/qocNs3OV0A1oYP0/h35mT
         oaRg==
X-Gm-Message-State: APjAAAW31VKzng9CcQWIxaPrCj7idNn4o1gnhTVXL/5OdNex0Tm7Q+fj
        qiDkb0xUlco2y7rNmuIggw==
X-Google-Smtp-Source: APXvYqzCS4ZVKgMQO0EsN+OwVuRwH2VWbw8Jy6Xoa808ESWltMZ+/o5mgTazR2J4NhJ64cO/hAMO6A==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr4102703wrn.291.1569354777257;
        Tue, 24 Sep 2019 12:52:57 -0700 (PDT)
Received: from avx2 ([46.53.253.60])
        by smtp.gmail.com with ESMTPSA id z189sm1690191wmc.25.2019.09.24.12.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:52:56 -0700 (PDT)
Date:   Tue, 24 Sep 2019 22:52:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, akpm@linux-foundation.org,
        sabyasachi.linux@gmail.com, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Fix _GNU_SOURCE redefined build warns
Message-ID: <20190924195253.GA2633@avx2>
References: <20190924181910.23588-1-skhan@linuxfoundation.org>
 <20190924181910.23588-2-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924181910.23588-2-skhan@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 12:19:10PM -0600, Shuah Khan wrote:
> Fix the following _GNU_SOURCE redefined build warns:
> 
> proc-loadavg-001.c:17: warning: "_GNU_SOURCE" redefined
> proc-self-syscall.c:16: warning: "_GNU_SOURCE" redefined
> proc-uptime-002.c:18: warning: "_GNU_SOURCE" redefined

> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
> +#endif

Why are you doing this.

There are 140 redefinitions of _GNU_SOURCE
