Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA91EEDE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgFDWpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 18:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgFDWps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:45:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CC5C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2020 15:45:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n23so4143904pgb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2020 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0/Ifpw3zohhhizup/iPeLdkC3yBceaz+iR6KHJ3Yp7w=;
        b=SrQ7VnScu3Op+k3qtU1bTlBve/IrhoIvaPcQQfuMsKsMtmX3GiGycjsmpSaJ2AnuDA
         sLq4MjD67cj2rWV6lZm9AXde9aoXtHyST0fTrFSBtBortq/FKnBoCzc4AjAVf67w4Qok
         MGxBkAmDISkBXLpBye8qEIXP9D2ZMSO395T7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/Ifpw3zohhhizup/iPeLdkC3yBceaz+iR6KHJ3Yp7w=;
        b=WbyqOnzfZZ6AL3kF7xeGNlqBGfCg7L7q20WkZZlig+Ujhl5YL9cXOdGQaPtbApGtWg
         WHu5QvMTH7To4jFycWgrqx8M78Vk+q2MG2esmo/YpeNt7n/Zeyzgr87vekGi+v9e8xlW
         aH9wVoqUBVC0iigkLYtAQUi3Jeq9C6GSULhyPcwU5L8H9H7dQF/Vd6vfOvegc9SaduUj
         bmEvqOx9QO+eTB+rARp6Lr9DDgIDQK/WAdpXhwaZ9YRDvdYp8pRRl2ctAgk6TdWl+3PT
         cVHp4ooxy90smq0PlNdiRvjozl6H//9Xrf9QPqoJ6gz3tKsBatOqn/rF0EsldV1MQzsW
         pPYg==
X-Gm-Message-State: AOAM533g6Mo7uMhguftQn1ie93Cgohs1+RLqRC2metO6lk37KQJ8uRvh
        J6987HiPdtBjPLOw2qnqZUbQ3Q==
X-Google-Smtp-Source: ABdhPJyN4dzHONC8ss9AIERs8X2Xzk+pU9aR8JSs6krPWrNtYee6rEeKAqIdDe6qG44ooQ6X4qDCxQ==
X-Received: by 2002:a63:f856:: with SMTP id v22mr6764340pgj.64.1591310748187;
        Thu, 04 Jun 2020 15:45:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10sm5065247pgk.50.2020.06.04.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 15:45:47 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:45:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org, ltp@lists.linux.it
Subject: Re: [exec] 166d03c9ec: ltp.execveat02.fail
Message-ID: <202006041542.0720CB7A@keescook>
References: <20200518055457.12302-3-keescook@chromium.org>
 <20200525091420.GI12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525091420.GI12456@shao2-debian>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 25, 2020 at 05:14:20PM +0800, kernel test robot wrote:
> Greeting,

(Whoops, I missed this in my inbox.)

> <<<test_start>>>
> tag=execveat02 stime=1590373229
> cmdline="execveat02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> execveat02.c:64: PASS: execveat() fails as expected: EBADF (9)
> execveat02.c:64: PASS: execveat() fails as expected: EINVAL (22)
> execveat02.c:61: FAIL: execveat() fails unexpectedly, expected: ELOOP: EACCES (13)
> execveat02.c:64: PASS: execveat() fails as expected: ENOTDIR (20)

I will go check on this. Looking at the expected result (ELOOP) I think
this just means the test needs adjustment because it's trying to
double-check for a pathological case, but it seems their test setup
trips the (now earlier) IS_SREG() test. But I'll double-check and report
back!

-- 
Kees Cook
