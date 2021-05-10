Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C75379370
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhEJQOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 12:14:01 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:42531 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhEJQN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 12:13:56 -0400
Received: by mail-ej1-f47.google.com with SMTP id s20so19857715ejr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 09:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=s9ivQboVSyOyjLv+HlTdjqOcvqx4Lxx5bdBUkl++3I8=;
        b=m00i3Jgy60Ld4j9ZqIhaHqYHu3jljzYyGy/e7ZFxPtOzw7OxsOhW+agRqFkUpBX6m1
         q3VEdU8hGmprAKFBUGVgEVHbn/Im/zOv5cUanfALlf8dvOex8Zb9rMXPURfEckVUCIxd
         jmIG+fZh/sWFMJRuHX8ooSQ0S2k0NvjzJ1KvYZpwA0GqedpP83VStYrMYe/nAyofopRz
         pjOeyWNRpO0emg98h/DcWLm8G/nGFYIPVSIZoKoyZUlSZzd8A3cnFcjPIh5vAis7SRa7
         EfF5GxzS6d/BQwcrlVcdj4IhYTY++PgGUKeI+Fnw8WVtEyhz6t2kx561EPgIoEW2WNNs
         Lesg==
X-Gm-Message-State: AOAM531yastxy16vofQZiwI1ddb+rcHJnavgm9GvvM8k0o9tXcb+U6kA
        W2ePILTM07RVvrrF2e9RFHQ=
X-Google-Smtp-Source: ABdhPJzizHzxacpiOGjfyfpDO2KKzW/9wBbkSTLcJXU6HTr1N3tBFjy6az0amQrO9jfdBJnpUKDLrg==
X-Received: by 2002:a17:906:82d4:: with SMTP id a20mr26628624ejy.14.1620663169357;
        Mon, 10 May 2021 09:12:49 -0700 (PDT)
Received: from localhost (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id g17sm13993162edv.47.2021.05.10.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 09:12:48 -0700 (PDT)
Date:   Mon, 10 May 2021 18:12:45 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 0/8] Folio Prequel patches
Message-ID: <20210510181245.15b4701e@linux.microsoft.com>
In-Reply-To: <20210430145549.2662354-1-willy@infradead.org>
References: <20210430145549.2662354-1-willy@infradead.org>
Organization: Microsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Apr 2021 15:55:41 +0100
"Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> These patches have all been posted before and not picked up yet.  I've
> built the folio patches on top of them; while they are not necessarily
> prerequisites in the conceptual sense, I'm not convinced that the
> folio patches will build without them.  The nth_page patch is purely
> an efficiency question, while patch 5 ("Make compound_head
> const-preserving") is required for the current implementation of
> page_folio().  Patch 8 ("Fix struct page layout on 32-bit systems")
> is required for the struct folio layout to match struct page layout
> on said 32-bit systems (arm, mips, ppc).
> 
> They are on top of next-20210430
> 

I'm running them since a couple days on an arm64 machine which uses the
page_pool API. No issues so far.

Regards,
-- 
per aspera ad upstream
