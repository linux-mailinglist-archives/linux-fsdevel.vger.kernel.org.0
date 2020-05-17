Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDE1D6563
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 04:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgEQCoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 22:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQCoa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 22:44:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40852C05BD09
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:44:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r22so2976270pga.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uq35MuQh3BQE+DEOjJ7MGVBKpzrL1FTb+VJBwvU0AHk=;
        b=Vq/A/08d+NZoCgyOliCZLorADWTSYNvj6xapzwZHoaC6teYOP2FUgFGAwp5kRgXP2U
         WebvMdP05Dt0Wf7N0hXDc6ZKwwhmU09sLVqoQVqPMpBWnfO2K/RTcxN3/czYC+W7b4cf
         ar7NC7/fE6rN9MVdNtAyE95jwARW0VlxM+x1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uq35MuQh3BQE+DEOjJ7MGVBKpzrL1FTb+VJBwvU0AHk=;
        b=sTi0rp97k8Vb3JSD3/vkP+SBz+wRnrNqxrWYijGifaoVOmv3bX+53m2NAJCw8Qk39a
         lS+HhcY4BTG+Xp7EyJ9H+TuLXc/8/gB4pM8iVkmjqDfXBo1ukAF60w2fyWz5SG1xLqpF
         9bPQdWMbMolsDfxUmNo5D3N8XJ/wYUVZHIcJFDIjSIVWWAkUO6Zzw0cgKv6CNh+XBUru
         doL1VQ8hkOVHNEVgqve739OQE74coCSGVp6Spxw/o2ptOt3JKxzWrooZaeZOhsqGq0YX
         cqAEgwredXvPs29TNOSgbZxFZ5ArIgfHiCXxaVHJiAZk7M528+YEG8c6t/QG2uBkl5CC
         WE4g==
X-Gm-Message-State: AOAM532mgljIdy5YWWS6KiXsic3O17Sy2eMzMoVD9PrC3lWBvsRfCyNP
        AoX8Si2sn/ZJR/ckAl/hpoU1GA==
X-Google-Smtp-Source: ABdhPJy3BU6dz6uT5khRoyvolBvyM5FsmNt5nbdXI6CfaDE94Hq4l+4J14lStQnkWTOViSRy0+5V0g==
X-Received: by 2002:aa7:8ad6:: with SMTP id b22mr6394643pfd.251.1589683469828;
        Sat, 16 May 2020 19:44:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13sm5153898pfn.200.2020.05.16.19.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:44:29 -0700 (PDT)
Date:   Sat, 16 May 2020 19:44:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        peterz@infradead.org, mingo@kernel.org, patrick.bellasi@arm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2 1/4] sysctl: Add register_sysctl_init() interface
Message-ID: <202005161944.CD304B5@keescook>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-2-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589619315-65827-2-git-send-email-nixiaoming@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 04:55:12PM +0800, Xiaoming Ni wrote:
> In order to eliminate the duplicate code for registering the sysctl
> interface during the initialization of each feature, add the
> register_sysctl_init() interface
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
