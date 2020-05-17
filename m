Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B211D6561
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 04:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgEQCoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 22:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQCoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 22:44:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D7EC05BD09
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:44:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f6so2999170pgm.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxqibz6u//AudMT2I1ARGsf1Me7UhpEYD8y+pnhWIpY=;
        b=d3cstiY6gDBn4aMz8bpUhxxoMwZGVOHwN8YofmIdJRCHvyLUctClFeHYQOcqqBJFvR
         G8YNmf06SK9P79w1RZojxbv8wsLCoyhs969+9o2C/XmI3PTSno2Rgr8Rsil1KFZ5l/s/
         azsLDeoU7EiBDYz4zxzLKClh0LKrQA8N/j6eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxqibz6u//AudMT2I1ARGsf1Me7UhpEYD8y+pnhWIpY=;
        b=RdAftr4VWgDlCNwAjoFEXOjbnzRJw/C2lYWy4Gf1bUhZzZKPjx8FfGMss7scrlWrGu
         U+mo4euQJ4B3I6EYyLLefvgVPF5F1GEe4+FoopNCFGDqzBwWF0hPv+6SKCOL0YS0dWCK
         UKPX7ML8HMG3LJrpVo+gdoodfZahX/b6cemMbH3a5k6GZV7evO6k3AFOlCc4gi27/mAx
         8kt6CufDbDQZa5eHg9W891c1Vvcmbo3VK6Ej8vyNZG916JYalxX7b6Vkm5cUhyPeG7UT
         cX5X9FbwzTEhKIaaISK2fofrgTZiAe6QH0nHJIux6Cctff7VDyNgirIftnJsJCkulhB5
         o1CA==
X-Gm-Message-State: AOAM5331hW393AlHIDQNzv1aZgq8uPv7J6LH/WrajXR8RpTJT6exgfuU
        zFru8+DPIoRYQ6l5X1wZMrbgAg==
X-Google-Smtp-Source: ABdhPJxehxf7fk4k860rUeZr0MjMnear8BYSqBn6G0ZjDSi6Z0+EPk+E1jqMWIogilie0gXavfMpMw==
X-Received: by 2002:a62:2fc4:: with SMTP id v187mr10683638pfv.312.1589683459911;
        Sat, 16 May 2020 19:44:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z6sm4662345pgu.85.2020.05.16.19.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:44:19 -0700 (PDT)
Date:   Sat, 16 May 2020 19:44:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        peterz@infradead.org, mingo@kernel.org, patrick.bellasi@arm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2 4/4] watchdog: move watchdog sysctl interface to
 watchdog.c
Message-ID: <202005161944.75CFAD8@keescook>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-5-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589619315-65827-5-git-send-email-nixiaoming@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 04:55:15PM +0800, Xiaoming Ni wrote:
> Move watchdog syscl interface to watchdog.c.
> Use register_sysctl() to register the sysctl interface to avoid
> merge conflicts when different features modify sysctl.c at the same time.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
