Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBBC1D558B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 18:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgEOQHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 12:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbgEOQHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 12:07:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E755C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 09:07:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a5so1063857pjh.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9lk2egJhzBkTB4zC9tb4jrnU8imm78/hX23YMPbVKfQ=;
        b=fMD+L8NK8FKpFxTEhw1RZGtfsQxfPUv7B+Cvvd8a8BlgkrWgF87cXb+NZpK1O8och0
         XfqnfqEUkeLwHJF3tPhtEJtOyH2omo6rlv/aoGUWv9vxAoj2eMmpUfZQsHnGfZP656mJ
         1uajo5Tr49Z0sLUbnHVBXmOg/cxIn/PaW/9Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lk2egJhzBkTB4zC9tb4jrnU8imm78/hX23YMPbVKfQ=;
        b=jQ9GLKjDopMclq0loaWje/6GQju8BTcDGCfV9vhI/xd+G9ZdHDJYr/kZVUbXYVmqAV
         cwFhNlhFZY4nF1bJPxizN7/5qP5lF/Vh9qSIlfoyZOKp1BnJPRskZ+Sa4s79y4+jODH8
         /FzkVO0wW2Kic5em5M4soMErClifh4eILwzpr8Sjra+KydOaNBHT47s2sfw6GMbH9f3K
         TXvxGq1Csv1HAmAHvkFEJFP06HdMvpmf613f8DBTkF5MuUV1K/QkBlf+YE+Do3CfTj3J
         B/Bpjrv88w/KwNCdyiLfQBNQS2zFqp3KRBwOklxJji6gNBU28cnnTQKWIoM30z62LuOH
         QKMQ==
X-Gm-Message-State: AOAM530W47T1/oeAamijEiCieqTCqvDI/rBebqq6igPAO+9gcjw0+QqX
        na0OhWGgWgr4UH6yUE+5mFdfTw==
X-Google-Smtp-Source: ABdhPJy+0aSyniv8UGid5FsroMuBxpp31zjBJlhwWHhAQ+52X1FGJutpZXlwTXeZA8S/KPWONU3yig==
X-Received: by 2002:a17:902:b945:: with SMTP id h5mr4328601pls.224.1589558837461;
        Fri, 15 May 2020 09:07:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d184sm2233645pfc.130.2020.05.15.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:07:16 -0700 (PDT)
Date:   Fri, 15 May 2020 09:07:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sysctl/kernel: document ngroups_max
Message-ID: <202005150907.9C685E5FD@keescook>
References: <20200515160222.7994-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515160222.7994-1-steve@sk2.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 06:02:22PM +0200, Stephen Kitt wrote:
> This is a read-only export of NGROUPS_MAX, so this patch also changes
> the declarations in kernel/sysctl.c to const.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
