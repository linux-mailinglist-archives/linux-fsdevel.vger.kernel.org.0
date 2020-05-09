Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826D81CC3D8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 20:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgEIS7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 14:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728011AbgEIS7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 14:59:13 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6EC05BD0A
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2020 11:59:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so5750813pjb.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2020 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uk9SlQz0CEzsa9L5BG2dNiuhefw99CVH+DuavxyjFwA=;
        b=WpMlExT/LVZeacy+KQ32hrpYo3R8XLnZFgCb869aNV+iiJ4EApUMjwk4xusqybUsck
         IQsuT29KxtXyciI21GTLSAOx5ucTEuI1DNlfzz+U1uA4nl/ZYLB37ks3l7sCuyFgfsb7
         C39XCT5j6YqMLMPgPmiFNCU6Ambyi9SwoV1Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uk9SlQz0CEzsa9L5BG2dNiuhefw99CVH+DuavxyjFwA=;
        b=Yhewy1564SCUirj0Oohaemj29/xtCHBZsdECXtKftVbXe2aoLMn4wH/JWJRqSaWH0f
         dLJbN/QTobM2UgdeSn5SMc0+6aN24mlwai0AAg996t+jkLlyeToN7j+5ubg96XI/1don
         ADVyGVg+VRUBndkf4Slc/uEkIfmQXZeKRFXAjl0HTSmTYR8BMpe9jzgecb6YbsORR745
         iCI1zuZ6uqZzwr4MEBY1Sn9L4wKvYax0CiKEbyAQdUcdnLbd6fPXY4QzAWMiVC4PzM9R
         zyIanmj31n/qN/g5/086F7s5w9hMAnc1VkrCEA66U8MY/NmorWyTqkA/Qeym1c2o0JgO
         LtaA==
X-Gm-Message-State: AGi0PuZIaoevVCMe0w224mYeWyJpxFRtqEJ/WdRFsB0npP1JipSLk7JC
        GAkPulPdg8fvLnCwlCArfvaF3A==
X-Google-Smtp-Source: APiQypKBNQXLzuVMARkaYrebfFtrKeGEowsUVjfCgRHf5JpipmwnEaSx8EB4o1ubtEkZ1ly+hXTS1A==
X-Received: by 2002:a17:90a:db0a:: with SMTP id g10mr13107736pjv.54.1589050752729;
        Sat, 09 May 2020 11:59:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm5139846pfr.215.2020.05.09.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 11:59:11 -0700 (PDT)
Date:   Sat, 9 May 2020 11:59:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        mcgrof@kernel.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org, tytso@mit.edu, bunk@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        labbott@redhat.com, jeffm@suse.com, jikos@kernel.org, jeyu@suse.de,
        tiwai@suse.de, AnDavis@suse.com, rpalethorpe@suse.de
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <202005091159.A317BEFF@keescook>
References: <20200509135737.622299-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509135737.622299-1-aquini@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 09:57:37AM -0400, Rafael Aquini wrote:
> Analogously to the introduction of panic_on_warn, this patch
> introduces a kernel option named panic_on_taint in order to
> provide a simple and generic way to stop execution and catch
> a coredump when the kernel gets tainted by any given taint flag.
> 
> This is useful for debugging sessions as it avoids rebuilding
> the kernel to explicitly add calls to panic() or BUG() into
> code sites that introduce the taint flags of interest.
> Another, perhaps less frequent, use for this option would be
> as a mean for assuring a security policy (in paranoid mode)
> case where no single taint is allowed for the running system.
> 
> Suggested-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
