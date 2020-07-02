Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046D2212BEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgGBSLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgGBSLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:11:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3ECC08C5DD
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2020 11:11:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so26235391lji.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ZF2RO7D0EVWwMJZ+4s9BUuPvy5hetDDT+LtkKbx5jA=;
        b=aBC7CVuq4bDi327CCmAk00uAKzXwDXFwka2t1budpO1vnfIVa2mhtpM0hyc23Ybcsc
         4Q9QSrTL8XeuvC6s7HWsM8siP9hY3nACHvOUGoA9Ud6+Hmi67VrIhRHxBHHtC9gyA+ed
         oAFRom3cS+moVq1MRyTJGXkqatICUT293Pa3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ZF2RO7D0EVWwMJZ+4s9BUuPvy5hetDDT+LtkKbx5jA=;
        b=qD/jCwqY1Zb0Qmw3XPMRTrXKLoNJh9fIPFtDzzJoABwh3+lhgxiUzng94ovqat8G5k
         w65P7dv0Je106acmOiEeN4XqmPJvHgbXr37APSWmR/aCDcVneGnWkrY0c8O6ow7cjMC/
         FXUplBWUUij/8/GwQQJ+KTJfLMsDCvi8MKl8b4q0vHBVe35usDJtUNnv0sgi8kOS67wx
         YQ8Ia31eTCtWy01cFbILS+OiCOcvEnk5iWqwESuvjLAMdMixBygHWWjCCzzgiX7HvFrv
         VK5KnfyqNep/dyEXUA7S1KKxQlIW7/l8/GWE6JOYO5K5WpUeuERhlM2XoXMVUFIi76wX
         izYQ==
X-Gm-Message-State: AOAM5327c6Dw+Y6v9qumraPAwrNNyten9mWoGCMfTzT5Pkwxyo9IHxUp
        4mTV06dBDo7oSxq42mH/eiKayZ7HaGU=
X-Google-Smtp-Source: ABdhPJxly2gg9ctJWNSozthSgG+E+wXac6DfHsJ7on+KMvEU3/vOxRSc1n670FhHFf7769qMs5qvwg==
X-Received: by 2002:a2e:905a:: with SMTP id n26mr1335193ljg.254.1593713459806;
        Thu, 02 Jul 2020 11:10:59 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id l23sm3205449lji.31.2020.07.02.11.10.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 11:10:59 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id n23so33440506ljh.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2020 11:10:58 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr2189529ljc.285.1593713458587;
 Thu, 02 Jul 2020 11:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com>
In-Reply-To: <20200702165120.1469875-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 11:10:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whb4H3ywKcwGxgjFSTEap_WuFj5SW7CYw0J2j=WGUs4nQ@mail.gmail.com>
Message-ID: <CAHk-=whb4H3ywKcwGxgjFSTEap_WuFj5SW7CYw0J2j=WGUs4nQ@mail.gmail.com>
Subject: Re: [RFC 0/4] Fix gfs2 readahead deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Of this patch queue, either only the first patch or all four patches can
> be applied to fix gfs2's current issues in 5.8.  Please let me know what
> you think.

I think the IOCB_NOIO flag looks fine (apart from the nit I pointed
out), abnd we could do that.

However, is the "revert and reinstate" looks odd. Is the reinstate so
different front he original that it makes sense to do that way?

Or was it done that way only to give the choice of just doing the revert?

Because if so, I think I'd rather just see a "fix" rather than
"revert+reinstate".

But I didn't look that closely at the gfs2 code itself, maybe there's
some reason you did it that way.

              Linus
