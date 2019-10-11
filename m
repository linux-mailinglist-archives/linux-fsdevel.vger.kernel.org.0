Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB35CD41E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 15:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfJKN4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 09:56:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46431 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKN4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:56:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id b8so5830270pgm.13;
        Fri, 11 Oct 2019 06:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pYZN44tcf/xxU7kx6DIe0UpJjwcz9PJmB2YvNccREKU=;
        b=qCjcFEW/08aMG+fans3bgrmsxov+uC01SXJMtpOlo5OhWEet5s5zkSCxI7pvzHtTx9
         D9zmNmqf8jA/c9r8GhYEa6fmw8aCfm/EBfwQezZwDTuCfrxMZpx2UtOLBTeGiWrtcK08
         07eu8DiceRgjOcSf3qiZeeVVoUc7qjeS+4viGAhgXiD7BWXNhi1FYdZ8/QWUpq+dFKna
         vx9lwIwKdwepilkC9mdJYU2wzXwkqIlREjMk+nandJt0cn0CSBmjQOIm24kdjHN3A8EB
         LIPJj6g204zn5rrvRtP9GsJj6IieZh1IOvm+8mLFwJ5A8nlF8E2A00Z4PUoqv1xr481L
         pTWg==
X-Gm-Message-State: APjAAAW9+ABvWVLA1S0rvMFGXM1ERlNpNkpCupiTG6Lqak6hg355SdiQ
        xGagfR3wZzhczgaWxsBrvQM=
X-Google-Smtp-Source: APXvYqyq4Whjhv1pHWqqj6KBdO9ycjVgyQXHccB+LvUmvUApvbU2oRx83Mlu8DosconGWrSq1CRDFA==
X-Received: by 2002:a63:f646:: with SMTP id u6mr16575972pgj.71.1570802206866;
        Fri, 11 Oct 2019 06:56:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id dw19sm7901861pjb.27.2019.10.11.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:56:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EBB72403EA; Fri, 11 Oct 2019 13:56:44 +0000 (UTC)
Date:   Fri, 11 Oct 2019 13:56:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alessio Balsini <balsini@android.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sysctl: Inline braces for ctl_table and ctl_table_header
Message-ID: <20191011135644.GQ16384@42.do-not-panic.com>
References: <20190903154906.188651-1-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903154906.188651-1-balsini@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:49:06PM +0100, Alessio Balsini wrote:
> Fix coding style of "struct ctl_table" and "struct ctl_table_header" to
> have inline brances.
> Before:
> 
> struct ctl_table
> {
> 	...
> 
> After:
> 
> struct ctl_table {
> 	...
> 
> Besides the wide use of this proposed cose style, this change helps to
> find at a glance the struct definition when navigating the code.
> 
> Signed-off-by: Alessio Balsini <balsini@android.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
