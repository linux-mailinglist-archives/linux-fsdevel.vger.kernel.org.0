Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275747C922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 23:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhLUWRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 17:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhLUWRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:17:54 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FA0C061401
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 14:17:54 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id i63so614235lji.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Dec 2021 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dsxFBdm2QviBZ29N5dveyQzOQKlgfiIrc+0yxADMNCQ=;
        b=NXGLxSCpObD2flRKPbCq9IFPdHnTLn2G9uiMQbiGfRWzwaeJ2bD8taKQdDhT7vmYJQ
         XKN0OrMjsTFtN4wpAuKb0rktrM3wvPlOc/x9PIKTiD8RUbXS7EVGu5eZV8Z593A+RmdE
         f/WyA0N9jfdkw5Fk7b/SMzwK11A0I6YzbkyPgQz1mxFDG+9fP4JmVDpjEC44R3vUzr8R
         Q3z5exdX1Y33rGrCOUViS3xHKetapJhi7PURL5aohZDHl9JqfMHvdqUGgZtD7eupsRMU
         4RT7vvBNqyV+J7FlzlcUCHul5Xo7HG73kaTCwJR/I68a5eFShE1J6AwN1ZfI4UMCSl/M
         SBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dsxFBdm2QviBZ29N5dveyQzOQKlgfiIrc+0yxADMNCQ=;
        b=IBtgz0z7i/HciT+G2EvTSiYWocHBzWbYejTFPb1F7lxGQYkjgCIBWjykVCeq2AZuIf
         OPPF7Cx+si61xwFabeJyTE8WjOLODqpge8XxBlPh+l6MSC8Y/sJawwhJuvMhK/mJy/19
         OO5vFDpLchsvT9a5h9P8UfDLtbvdw+hE4/HO+BGZLYrGoRB8yJdh3Wm4pm1TrT9BAoAq
         WbKb+dR3fdqEp9FwtK842vDPMSHXOPWbvid9yeFKqmcftS++jJaBPCZLtBU+jeziLuwd
         u+C4u3l0M1KNQsFT13DMhkItf6Ho3ma67TaxK/yCr4YcyKQ1VRaq//qbQVPuHZujwUoe
         3KHg==
X-Gm-Message-State: AOAM530wqNxg8ykmnU6tnXtOsrYHOHSbzctalZSbKwNuptRzNIvtbh1v
        lzPwmf65mSQdZr6Cq1Qv6FsQHwpKw4l7D9dn13HaQg==
X-Google-Smtp-Source: ABdhPJwwMIZzbtN/WFjr6/Ly3vHEn6ix3T31OaNoEmwDcGRQg/3sYZ7JNkTLTnzGEzM47tPaVs915sWc4CTh4BE+7YI=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr315614ljo.128.1640125072220;
 Tue, 21 Dec 2021 14:17:52 -0800 (PST)
MIME-Version: 1.0
References: <20211221184501.574670-1-colin.i.king@gmail.com> <YcJLFQh9IA2XzXu3@bombadil.infradead.org>
In-Reply-To: <YcJLFQh9IA2XzXu3@bombadil.infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Dec 2021 14:17:41 -0800
Message-ID: <CAKwvOdnK2Zc72tw6CdQkz=VxoRC0voWpda8Tgo38LaiRukDfKA@mail.gmail.com>
Subject: Re: [PATCH][next] kernel/sysctl.c: remove unused variable ten_thousand
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 21, 2021 at 1:46 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Dec 21, 2021 at 06:45:01PM +0000, Colin Ian King wrote:
> > The const variable ten_thousand is not used, it is redundant and can
> > be removed.
> >
> > Cleans up clang warning:
> > kernel/sysctl.c:99:18: warning: unused variable 'ten_thousand' [-Wunused-const-variable]
> > static const int ten_thousand = 10000;
> >
> > Fixes: c26da54dc8ca ("printk: move printk sysctl to printk/sysctl.c")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Just double checking; I don't think I've seen someone supply someone
else's Acked by tag in a reply before. Was there some discussion off
thread that I missed? If so, do you mind linking to it?  Was this a
typo, perhaps, and you meant to supply your own Acked by tag? Are
"Luis Chamberlain" and "Andrew Morton" aliases? :^P

-- 
Thanks,
~Nick Desaulniers
