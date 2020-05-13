Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA001D03C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 02:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbgEMAj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 20:39:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38514 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731946AbgEMAjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 20:39:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so6132474plt.5;
        Tue, 12 May 2020 17:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uFKqSypxRhLNaszQ9FU/hBZK81MFbv8LrHsXvYdnkac=;
        b=ZVrDbV9qgKnN9gGLjhFInOMSdohdaRKyVB77Y4evG8EWZu0shRcJgpdEp7QfqutPXR
         8ZBfZawSLOABG+DfMUayCADnV+CoSQLc2XB8Tmvb01oMeQOj1hpvC1LhCJSdzV3cHXgT
         gdAQHC5auyQNhfCWSUyzhT0G3Msq+T9Yjqnt9fwXLww3PzZKV5BS8vzsELMT0CxQnBU0
         zf8gMOXRZdnrNn8B3ejlPOjLSfNKRxs4KWyJzqfJgsJVL5iYMW9hlBarAWr9suDi282x
         KXvBWPnLHnWwcBPaa+Z6qi6d5WsPp35CXwBgdwvUdAlnCfqB4KvcpOE8DXwvvGvTycDr
         wz3g==
X-Gm-Message-State: AGi0Puba5MOjRpgUlYmyVH26OvXVnLZbmLlO4Pqpl82Rur0LqKvPbhwL
        m4yIcdvN/jJ7v96K1FXO9DQ=
X-Google-Smtp-Source: APiQypJr5rRSiDKwiSO/nto67eapmrLp4s/LDV8LT/NHSh6XPftTcm8GM6AQNahRp6cm0AhcCcYHqA==
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr29078872pjq.184.1589330394632;
        Tue, 12 May 2020 17:39:54 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h31sm14142647pjb.33.2020.05.12.17.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:39:53 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0F22C4063E; Wed, 13 May 2020 00:39:53 +0000 (UTC)
Date:   Wed, 13 May 2020 00:39:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        yzaikin@google.com, tytso@mit.edu
Subject: Re: [PATCH v2] kernel: sysctl: ignore out-of-range taint bits
 introduced via kernel.tainted
Message-ID: <20200513003953.GK11244@42.do-not-panic.com>
References: <20200512223946.888020-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512223946.888020-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 06:39:46PM -0400, Rafael Aquini wrote:
> Users with SYS_ADMIN capability can add arbitrary taint flags
> to the running kernel by writing to /proc/sys/kernel/tainted
> or issuing the command 'sysctl -w kernel.tainted=...'.
> These interface, however, are open for any integer value
> and this might an invalid set of flags being committed to
> the tainted_mask bitset.
> 
> This patch introduces a simple way for proc_taint() to ignore
> any eventual invalid bit coming from the user input before
> committing those bits to the kernel tainted_mask.
> 
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
