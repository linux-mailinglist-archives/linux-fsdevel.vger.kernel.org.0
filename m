Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799123A8A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhFOUfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 16:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOUfn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:35:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4EFC06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 13:33:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 131so540874ljj.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAGqspBT/BVO7fxnKKhBww/cp3Y1v0OmOJX/fh/iBZ0=;
        b=VOKSEebqgQc+ESVIRcLLX6qvkrm3nZhaMpKPgDfmaMHJAzOGQ+/4byx4ylpBgrSD0Q
         3oPPb7wQ9PFr9xYN4xUVhluSSYfWgR9SK4OnQFzwZ9X5FayZ2JQYPVcJcmqvtMmDQnyk
         asTwAR71y1jPOLSZtM/erovDU2qdYBqSXCP2caH7akHCB3uvWSBeBELyrYO4zV9gVkqt
         Auim3ksxefaJ94xdxVQAXXpA9EA++ndAzoTD7AKbllSX2uEm0HhjCtGrn7FuW5/zSEI1
         oEmdkBN3IJ+WH4z/iCNkgianGBtT9aHVjlkt8nL6fQ0QJ+XIhngsadiDJu4/ZufKW6pK
         nhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAGqspBT/BVO7fxnKKhBww/cp3Y1v0OmOJX/fh/iBZ0=;
        b=ZpYIz9fCPeAb2s85pamJiwei/aMUoPKTt10drrCR5cPGyXtFNp54cRUvkEYdL/BYCC
         fYATbdT9D1XpMx7hzO8Vg/VmvSlHq7XViqSLZcXmWPQm6GGp6AyBKSWI9cwYgqXBsYSv
         jmYYKz91Idp5ui97c52mrHdwDjzyFglkZpVWdWZ1Z315vg6St5fcm50u8dnwyByZzu98
         DrizYjag1wHm+bdblfCJakPw6ICQxa1ObtpB7V0rmGZTPAkJCIY37V1enEcy0dh06Cma
         89xCuYoje9VcKsDe9Rf9VY1vxo9bi/HJt3yxD6LFE/dJrLS4j24Q/FcXeyYX0Zfe/QL9
         v/VA==
X-Gm-Message-State: AOAM533GjiIJO9aoduRCRJqcIVHjj/84BM+i45x6jnXm3yUggLHfhxIY
        Ls4wWGS9BN5bRmOzSrwsiPxb/loV9Jchw57XOAdkFQ==
X-Google-Smtp-Source: ABdhPJwRMRbrHZFpr5xUuWiithcUfauQrhqtPGwqFOKdLB1xz510cHn4CtJhB/sBrh7v2fdhbvo1XRrFz16y8Ky5m8w=
X-Received: by 2002:a2e:91c3:: with SMTP id u3mr1308234ljg.13.1623789215338;
 Tue, 15 Jun 2021 13:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210513193204.816681-1-davidgow@google.com> <20210513193204.816681-8-davidgow@google.com>
In-Reply-To: <20210513193204.816681-8-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 15 Jun 2021 13:33:23 -0700
Message-ID: <CAFd5g47LZgn8fV2RHVvxPn+_7TOxbh47aa0i6wb9dcY6UKYZLw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] kernel/sysctl-test: Remove some casts which are
 no-longer required
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 13, 2021 at 12:36 PM David Gow <davidgow@google.com> wrote:
>
> With some of the stricter type checking in KUnit's EXPECT macros
> removed, several casts in sysctl-test are no longer required.
>
> Remove the unnecessary casts, making the conditions clearer.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
