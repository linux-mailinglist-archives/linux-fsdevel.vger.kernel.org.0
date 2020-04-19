Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6651AFE1A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 22:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgDSUb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgDSUb3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:31:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAE4C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 13:31:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t63so7690922wmt.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=d5VtsmW+LpjLHdcq4ZjY3P7veLYRpTQdnfKzsYw6pgg=;
        b=CVt67Gs5IDYXKGWVWzSq+CeFk/Ps3XUrm8R+NedII0r1XWEWc5humnviOvuRLD3O57
         vqz/0k7+Qle33cv3xlpVHJvv3tKtC3l8OIaosTxynE1rjdwlm1cb9wt8D+1n1VRNfqZj
         m890yh5C6velg9rj4tDO/+fUPDCKcuv0zlHk/gm9HbeaYV/JEUuORZyY6nTs1c71g/Er
         /XFSMGGU/wxSL2lDIhTJnpq1uXWvzH8qsi0B6ZQWfCnXuMZheSo8YtNsGUZmctF2umJY
         R0Ce464aPy/wpQ8kQEy85ZiBhd+LwwEd1ERKNO+MPFtsjsuwFG1ECJwuHa/3dljB2eh3
         LXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=d5VtsmW+LpjLHdcq4ZjY3P7veLYRpTQdnfKzsYw6pgg=;
        b=B/exn8H7Qmjx6UyIlD0NMKTi3SEcD9O2z1pfh8O3UIs2gr/xEO/fVB5lyFbdG4ZkOB
         PPYRiWKxIRpc6WK+wOT7PNV68+3TDzz4q07xHOI0jL++TzfrHpW6xdmoIuaTEROmXRAm
         eQjMF8EYOhJqYW4Rv9jbBQPm/twqQ3LF2rc/TX3PoDdt+ilWhgKXRvkimgb1xiZRpwDP
         2C8Mz+p3ljYc3P4eoXdvVI3iZiM0IfsHNVAuk8GHM0CbSE3pZj6bm/Nd7Yzr19Nb0IO8
         I/JNBn2VYgz4XrtbYamcCUwsYqm5NFd7yjcX8+QUmz3kO7drGgL4IUHy+ElL5R33fVGt
         Xbpw==
X-Gm-Message-State: AGi0PuYn+h1NRK5sx2SRyWIABDkdEiem1mv1FvzAokvZ7/bHy1pXIpM8
        yZ4c/frSxfyXRAc1Gy8fuciW9zPzZqwecA==
X-Google-Smtp-Source: APiQypJ7wXg+TvqgrdPfqRYt4DPnsd5pT35Ox+VBWkTwnMPocosyRY9HPDWdhAFLB6eayebqziHxRg==
X-Received: by 2002:a1c:44b:: with SMTP id 72mr13747676wme.58.1587328287493;
        Sun, 19 Apr 2020 13:31:27 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2? ([2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id k184sm16970016wmf.9.2020.04.19.13.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 13:31:26 -0700 (PDT)
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <e412762b-3121-b69f-2b4b-263e888a171c@cloud.ionos.com>
Date:   Sun, 19 Apr 2020 22:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200419031443.GT5820@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mattew,

On 19.04.20 05:14, Matthew Wilcox wrote:
> On Sun, Apr 19, 2020 at 12:51:18AM +0200, Guoqing Jiang wrote:
>> When reading md code, I find md-bitmap.c copies __clear_page_buffers from
>> buffer.c, and after more search, seems there are some places in fs could
>> use this function directly. So this patchset tries to export the function
>> and use it to cleanup code.
> OK, I see why you did this, but there are a couple of problems with it.
>
> One is just a sequencing problem; between exporting __clear_page_buffers()
> and removing it from the md code, the md code won't build.

Seems the build option BLK_DEV_MD is depended on BLOCK, and buffer.c
is relied on the same option.

ifeq ($(CONFIG_BLOCK),y)/x
obj-y +=        buffer.o block_dev.o direct-io.o mpage.o
else
obj-y +=        no-block.o
endif

So I am not sure it is necessary to move the function to include/linux/mm.h
if there is no sequencing problem, thanks for your any further suggestion.

Thanks,
Guoqing

