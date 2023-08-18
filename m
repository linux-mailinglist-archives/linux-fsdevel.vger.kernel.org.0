Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8978059A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 07:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356368AbjHRFWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 01:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357075AbjHRFVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:21:34 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA54C0A
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 22:20:05 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-79ddb7fae73so125648241.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Aug 2023 22:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692335933; x=1692940733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kpLB9nUoya1zg6wDKkXayE7Tz/XHKIUeAAVe5xKhK0=;
        b=KaJjLiyhBSvhpgsm8YiFaBS8xI7UGZoG5drkaowj2GP6x3bnrlC3xOI9td0TTSOaAe
         U8CIrSHQWflISPqATW2Jo4GQiAlJPU0m/8d2f85PGndrz8aD8hfh2jAjRsTiH+CTkLXa
         m7Jyn6jzSFdoWq8Cj3ukeolSvabGfHWqd3VkCvjM329jQTuiE3+JNp4UdwbXKk2U9XJN
         +sVLZ11JcehL6jteXQVA0W10g46ms6XNkh0ocrcENaiTzXDHMmhQV2Yk2ioO5jxIIELt
         b9a3SmTagu6fnJsvmeaZRCTHEiUrhVsd+wOWsCbL+Vw6pMR3+OvW+biIoAtgD8wdZeIS
         w68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692335933; x=1692940733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kpLB9nUoya1zg6wDKkXayE7Tz/XHKIUeAAVe5xKhK0=;
        b=LVq8E4H5N8aBYn3xiqO5CTTZnENBvs1sQU7vIV58sEASDGaF6zIHQgiNdMao1NZz96
         XcxyI7ue4dZYqbtLdNHPafinzI1yJsboGK68Qp24nxC6rP+WG8T+85sCKHRtxxv0vcEs
         +knh2OwKf6vc2XFggWyhANGnV3XUN3355f1CMGkSNs69vgCduVrY6fLKldjRYzd1Vp8N
         PDS448kBTzAmB3LyLZN4grdhcjjsdRjkJdtF7N4tMBfiZK2uHUU6EXSOf+Bpit9NReQa
         narIor9hQh5/ai3UFHWvUfPyUkw7kVlVvUHVGlpOQ27cW8We+5C5zU3hS9xGY8AJMKX8
         f4OA==
X-Gm-Message-State: AOJu0YxMuUtS1IURqPuoobPAR4LBOY//kpsJ9OjaSLcFlzlm2Dz+9cmT
        FfX0L3HJX2YT5SafLi/ek5cZyyirihDuXnd923hFZw==
X-Google-Smtp-Source: AGHT+IEf2oEZW2NUvuhCzB/XQOkZOamd12TFRt7JdNd8j2TpdIAQwd5X10QtMAXKbXbUwLs+I54R8FqOfRXoI/bJsKM=
X-Received: by 2002:a67:b648:0:b0:44a:c20a:ebb1 with SMTP id
 e8-20020a67b648000000b0044ac20aebb1mr1545884vsm.13.1692335932647; Thu, 17 Aug
 2023 22:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvFD-kE0+EGWkwcnR1DXRxh7p7OwQThJ6KWxYWVROJ4+A@mail.gmail.com>
 <CAKwvOd=h4aFisiY0w0awKkxk+i-aJM5+QbExYnboqzojLigx1Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=h4aFisiY0w0awKkxk+i-aJM5+QbExYnboqzojLigx1Q@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 18 Aug 2023 10:48:41 +0530
Message-ID: <CA+G9fYtRMde7Ksswa8pY8sFgnWVN-snRHfz4YRM04HSQ4LFBZQ@mail.gmail.com>
Subject: Re: landlock: fs_test: fs_test.c:4524:9: error: initializer element
 is not a compile-time constant
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Aug 2023 at 21:24, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> On Thu, Aug 17, 2023 at 3:51=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > While building selftests landlock following warnings / errors noticed o=
n the
> > Linux next with clang-17.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build errors:
> > ------------
> > landlock/fs_test
> > fs_test.c:4524:9: error: initializer element is not a compile-time cons=
tant
>
> Hi Naresh,
> Can you tell me more about your specific version of clang-17?

    compiler:
        name: clang,
        version: 17.0.0,
        version_full: Debian clang version 17.0.0
(++20230725053429+d0b54bb50e51-1~exp1~20230725173444.1)

>
> I believe a fix of mine to clang should address this. It landed in
> clang-18, and was backported to clang-17 recently.
> https://github.com/llvm/llvm-project-release-prs/commit/0b2d5b967d9837579=
3897295d651f58f6fbd3034
>
> I suspect your clang-17 might need a rebuild.  Thanks for the report.

I will rebuild / re-test and confirm soon.

- Naresh
