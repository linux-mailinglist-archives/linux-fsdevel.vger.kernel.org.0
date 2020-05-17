Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B851D655D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 04:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgEQCkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 May 2020 22:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgEQCkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 May 2020 22:40:08 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61470C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:40:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f6so2996856pgm.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2020 19:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DQ7b10CExQtYq9ez/1sImqvzsTVJs9wfSvWwWE1m+zg=;
        b=bW5p1limV5v31ZEEUmeY80kPntKeAP7HeTDpzq0pJU+hfaLfTwsI5yetINIu44YNQ4
         snELtQQy2ES70Hvlzy5NGA1e2Vll6u48YlTY0+Jj47MitzVgDBJHZ/k/jcQlNILqn1Cc
         rJJD6QDtv+5OQCka5Eyr0n6VANGZDd85j6Bo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQ7b10CExQtYq9ez/1sImqvzsTVJs9wfSvWwWE1m+zg=;
        b=Jy7CmmHVaHME2b4BrtTb33VzSvhJZRseU3yNxbxPnoHH0C/yIiRu3rv+aJ+1zFVnkm
         Ob12t62zZ2DoS3jqTb9VwNxTO/KcJYTywHaD8GUavHd5I/OiU2vOtLy9MgzFYd1QIFbb
         DgbUttk5TBfk7xz9zTovDSP4BX5aMWHywxRYOuJOYOrgeb3xM6h3yLi5Gw+8a34Vbt1R
         pdw+LLK5PzdkAI2HvO1fP1g1yZJPrdvKy5nR/lZWdXRJhoRDEew7WbNzdwzzakb7exF3
         IGVoNvG5EDBFMvMupbnpbbxbufkcNKb3wPmW2wFG1PhCkUQEl7XUmgE+1/M7O1zqp67a
         l9Tg==
X-Gm-Message-State: AOAM530oz0G0O42x6PlHXWjC58VN+FnyJwZR7EBydiL1s8qIpmQh4/gY
        h7pQGTpb0dkVAVq8/maUZxwrruZ/xx0=
X-Google-Smtp-Source: ABdhPJz1ff8Ew1NkzLgoebMXiLgxHRi+QB4XZRAQD23Z+ssqKwPQfvyFa8mCs6ThD962ynyNyBZzKQ==
X-Received: by 2002:aa7:93ac:: with SMTP id x12mr2880478pff.143.1589683207980;
        Sat, 16 May 2020 19:40:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cm14sm4881606pjb.31.2020.05.16.19.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 19:40:07 -0700 (PDT)
Date:   Sat, 16 May 2020 19:40:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        peterz@infradead.org, mingo@kernel.org, patrick.bellasi@arm.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com
Subject: Re: [PATCH v2 2/4] sysctl: Move some boundary constants form
 sysctl.c to sysctl_vals
Message-ID: <202005161940.B8DF981@keescook>
References: <1589619315-65827-1-git-send-email-nixiaoming@huawei.com>
 <1589619315-65827-3-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589619315-65827-3-git-send-email-nixiaoming@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 04:55:13PM +0800, Xiaoming Ni wrote:
> Some boundary (.extra1 .extra2) constants (E.g: neg_one two) in
> sysctl.c are used in multiple features. Move these variables to
> sysctl_vals to avoid adding duplicate variables when cleaning up
> sysctls table.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
