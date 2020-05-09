Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4B51CBDA0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 07:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgEIFDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 01:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgEIFDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 01:03:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909AC05BD09
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 22:03:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so1649796plt.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 22:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/AENFOpTjGHR02cL1kgiq9GWV1My/wAsjJBe1VOhVZI=;
        b=Xa+u0P6IAVg8Cqpns68XcVm1URkmY2rSFhaSgvn42NcL6IorVKtLP/pPqNddqaZwi4
         hyecJMJHW//EZMy34y2Ou/Ppuk28Q4Os3wCA9Mqtt5mgbC83jKnlC8VOjmCrLSqn+3FL
         XyNwHFFtg5Y/19RzcqHh4kkFp84mbach2CBRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/AENFOpTjGHR02cL1kgiq9GWV1My/wAsjJBe1VOhVZI=;
        b=OTl08vpUUIv4GlXh8Fz8z9RuK6OEI5u5ZkQrNSFDRTwifLxlgNrflrpsvvPVdyGfYC
         pcjy6MiTtNb0Z9VTIebZmk4e8RQ9PqTcXyxGCZJnE0Si9XoEprYcLk8o92hfPjx0uoxd
         nJs/9E8HlhQfK7XWA0sj0EPJlP13Rxq1T/diXaQa969SCjOvFWf36NTiTouneI6oMOWO
         2DBxijT+mZmLfLO/ZE3bCcVfYhb7IUsAA4h1/eLlpkI7ewp5dBOhVoHZxrNcHY7xq+Dt
         ryTi20F3Ttbf44Us6LR1ez/wWVKPFQxxPk/ZaJdE5FbA+tJgiPBU3g90i09N2Wcw7dcB
         NHbw==
X-Gm-Message-State: AGi0PuaWKHwUBKDEjP3O+dIHqtbPtjK8GkAO+WpMVDYj2eF7ZHKsKf5u
        cvabQQnbYz4jeVUw91eOru4dFQ==
X-Google-Smtp-Source: APiQypKW+Opy6mPlgNDF55OnSt0CqJPvBIxWqCykHAn+1QO6N6FkGQw5hLxGdYVG8qzolJ9wH1qBOQ==
X-Received: by 2002:a17:90a:da05:: with SMTP id e5mr9981232pjv.140.1589000584491;
        Fri, 08 May 2020 22:03:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y63sm3391530pfg.138.2020.05.08.22.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:03:03 -0700 (PDT)
Date:   Fri, 8 May 2020 22:03:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] exec: Fix spelling of search_binary_handler in a
 comment
Message-ID: <202005082203.585C2F6@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87h7wq6zc1.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7wq6zc1.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 01:44:46PM -0500, Eric W. Biederman wrote:
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
