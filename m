Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8CA1C6313
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 23:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgEEVaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgEEVaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 17:30:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE02C061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 14:30:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so1384300plk.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AYOhvViGtfOYUpiUVO6St0IFegyeJIOeiAmdAI4TNGQ=;
        b=aZRjcMSGm6tpJdp5dwhoA4BnTL577pukRa7mQxkssp3Sui1VOiL8Cg5ituwtaTjV63
         puUEc6X0vUmy9Ut2Ru4iG7PiSQeUG9f5uPgZ7vStJgQ5nKW+uovurKtQKfkKF/xcGUEi
         lexkvpQCX0AhebneUv6ca46cPDFaGMd+VR3ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AYOhvViGtfOYUpiUVO6St0IFegyeJIOeiAmdAI4TNGQ=;
        b=IYYyl8bL5w0YOBatZWHkdSoZMrZoDAJKbD271sFeDjIn35jl2N9MS8w1vpJapQKaIE
         cvaDirykXinhL/jWyJddXrX6BVO3oPM1TKBVWAw1GhFfSKrGXIAORNNv+0YAVoK+m+ts
         2BXi2XSMGeIMom9nBmqwQRV6cQ8XWnDxJDwR3CTxId8Qs4hc53LPBcB20x6IcONrc/vK
         eNDp/B7+KdBhYK7Usj2JAxVHAwKDwRXjg9uLrjou+I0kGzUhdWG8EkFBMiTLhHnNh6oa
         HAA29eHIOdEHoUtOPT/1LOgoQ9vkrcF9URLHsn5L84YTadYW8CMI1h3ESlld09kY5+tC
         VaaQ==
X-Gm-Message-State: AGi0PuZ3rBC8oTnzmm98+Z7tyiGB1SBt+uiaN0NEAVkEkfEWHXIBjKb4
        XJVe9p3ECytGq5MGUBhEkSIv9Q==
X-Google-Smtp-Source: APiQypK3WcjO6U2JPoW88Je3vxrfxgNXgBI2d3GGp00OAegb5kl+6AC9gnF876wanQj3MCGBJKiezw==
X-Received: by 2002:a17:902:a98c:: with SMTP id bh12mr4905381plb.176.1588714209118;
        Tue, 05 May 2020 14:30:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm2883000pjs.35.2020.05.05.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 14:30:08 -0700 (PDT)
Date:   Tue, 5 May 2020 14:30:07 -0700
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
Subject: Re: [PATCH 7/7] exec: Rename flush_old_exec begin_new_exec
Message-ID: <202005051430.6ED1CC450@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87a72mi2rq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a72mi2rq.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 02:46:01PM -0500, Eric W. Biederman wrote:
> 
> There is and has been for a very long time been a lot more going on in
> flush_old_exec than just flushing the old state.  After the movement
> of code from setup_new_exec there is a whole lot more going on than
> just flushing the old executables state.
> 
> Rename flush_old_exec to begin_new_exec to more accurately reflect
> what this function does.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
