Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4E28679D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 20:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgJGSoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJGSoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:44:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE39EC0613D2
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2020 11:44:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g9so1969122pgh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2020 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X8jO+k78iPi+PQAecC0Q3ap/SytXosdxrChjraSoqaw=;
        b=WXlaV9pjXkhbYj7Tg3Q1c0hwqAynsaOgzckoDSnGldqENxpknhYFK+5HgLYSpow9GR
         FA1COQvpB8NLwrZ6HZ5yEyhxNDEVzPNlCrGNETZoLg/yTH6YMwVaZfS6Cd5ikwVO95aL
         lHiAXKSV918g2lozIMNiL3bie1lJw3NAvn3fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X8jO+k78iPi+PQAecC0Q3ap/SytXosdxrChjraSoqaw=;
        b=EGadpCWt1/KBhekbb3UVepxd9DBb+gUFvynSnOfN+SltS1mCdmOKqf6xXS3ihsbQ3g
         qQe9MGN8oqNN3Emdx7P3UaJX4gBTSt14FllXv5bCqIPMGu12TWICCnFvjynkRfZtKFWw
         /ot8pB5pNfPJn6l7FFhr0uuy/HpVCdqAdf3GivH3scU3FHnl9/FuoDuQZ4dZltTuYRis
         EEc9PMtZhBifB6MT8ejEJc5n6TSEW+6Q8r5LGtTtxwROOkCcK3/NGGUIwE9qb7PZ8mv3
         Nx0HOHhWVWAh5ffGjMEa2dRli1m7jdHpxBPGDtAuPkNy0slFTrky+JXT/DSWBKQzWcT3
         mebA==
X-Gm-Message-State: AOAM530y/v+/xUMhYaRCtVhf9/1wESPoP4wNqQicj8cauRWWPUXxQczZ
        I0wcv9uaWjjyr0KO84Jw7YZLnVDMNRQvKaqm
X-Google-Smtp-Source: ABdhPJxnc93bpj6O2XDgoB+4iJqQIaVqQaTINKkUrGuNUPDT7MwB5tqBz0QOGR7AhWiAKFDQbgzAJw==
X-Received: by 2002:a05:6a00:d2:b029:152:5ebd:426 with SMTP id e18-20020a056a0000d2b02901525ebd0426mr4181620pfj.5.1602096248247;
        Wed, 07 Oct 2020 11:44:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm4014370pgl.92.2020.10.07.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 11:44:07 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:44:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/sysctl.c: drop unneeded assignment in
 proc_do_large_bitmap()
Message-ID: <202010071144.FA87F25D5D@keescook>
References: <20201007151904.20415-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007151904.20415-1-sudipm.mukherjee@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 04:19:04PM +0100, Sudip Mukherjee wrote:
> The variable 'first' is assigned 0 inside the while loop in the if block
> but it is not used in the if block and is only used in the else block.
> So, remove the unneeded assignment and move the variable in the else block.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
