Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0B1AFA69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDSNPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgDSNPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:15:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB4CC061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 06:15:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so8613913wrs.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2020 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/5D1HJQCdtvBqKyZeiaC+xwJ/7LTAOg0hEOsLd16cec=;
        b=VSahUVOhOBhExsY4KQlmPOzVmW3osQuhNWv08iOfW1hASIdiDNknvINhL3OJAooz1G
         fWdDLB4d7TFOBD5QvlXE6tLhm8KA6Z5O0GL3VJmvHRK3MYyfpVbglnGCxEGE7JVArT9d
         YL4dgMuI46PNLrPthUGAtfVTrk51qPeKUBH86Kw0mvjx17r7gZZMxKYlHrQg3zDtetYZ
         WK/37nRd0yT8n+1Z53LBNhJnIo2UKUCz1L0zsWnGaPzkwJCwXgNZno+IPxCu7r5Gp5NK
         IoEUwpzJSwWipXpLQ2+/cEGnZrpz4EmFbD/3loeTmWeu8EzNZ3i0o+OX9ZhMx4sbY+TV
         gcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/5D1HJQCdtvBqKyZeiaC+xwJ/7LTAOg0hEOsLd16cec=;
        b=lOndJC11D4RRDo5qwjuRBZ15pMGpOBSUmFJWJTe43moqVfM5+RIVmPRAiQ9rpAijbZ
         1jCwIHi7mvhHwg3zCt+CCYt5ojdyGURY1dqf2Yskm+lDdSuLOzGIphc61k/Oimq8cIhl
         jI+Z/lqL89J7YxqVbQJZ5UJt/SHXL+fxNlQSZNZH7s7m4rdlWmUbWqflOvzHKXArqdXV
         C3Z3713NqEvxEII6pIbIzvTDre1GvIERHeaFj7R3C0ZUoJHG5Y5s30uHUR9+IZ+BJqXI
         Rx8GlshHMO+ely6qDkvD0upTEufNyMM++zAKxk2O1oM0ZdwbjaX1rSlIGHbsqpFBFSlE
         x2wQ==
X-Gm-Message-State: AGi0PuaXjB0//YRIk4xjEcJ4WjJ7fgWX5fbYCKEvGq2LY5GObsLCQZM8
        cFkpL9ogM/DGSJvOX+o+crEeM7a5DtQ=
X-Google-Smtp-Source: APiQypIFB6Og1u+d9xTwzQFys+yfDQP1kzAmsIrEihoqmhorQuxzRWoWLIvGHH01pZ27aUP+81WKvQ==
X-Received: by 2002:adf:82b1:: with SMTP id 46mr12676984wrc.44.1587302106043;
        Sun, 19 Apr 2020 06:15:06 -0700 (PDT)
Received: from ?IPv6:2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2? ([2001:16b8:48da:6b00:34d4:fc5b:d862:dbd2])
        by smtp.gmail.com with ESMTPSA id q10sm36672783wrv.95.2020.04.19.06.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 06:15:05 -0700 (PDT)
Subject: Re: [PATCH 0/5] export __clear_page_buffers to cleanup code
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
 <20200419031443.GT5820@bombadil.infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <b4454f80-95c4-3164-e650-4abb7637fc98@cloud.ionos.com>
Date:   Sun, 19 Apr 2020 15:15:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200419031443.GT5820@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Thank for reminder, I missed that.

> More seriously, most of this code has nothing to do with buffers.  It
> uses page->private for its own purposes.
>
> What I would do instead is add:
>
> clear_page_private(struct page *page)
> {
> 	ClearPagePrivate(page);
> 	set_page_private(page, 0);
> 	put_page(page);
> }
>
> to include/linux/mm.h, then convert all callers of __clear_page_buffers()
> to call that instead.
>

Thanks for your suggestion!

Thanks,
Guoqing

