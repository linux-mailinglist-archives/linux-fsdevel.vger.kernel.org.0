Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F3263345
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgIIRAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 13:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbgIIPvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855DCC0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 08:51:09 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o8so4251331ejb.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebI2CZT5sFSOyIJmsHXUvAoUxP/mIFBJnxrOROHyq1w=;
        b=j+YHjrcPZ12jt2TR6VZ0SQLasTjXLm4QzCvH5I2QEq+TUS19U2aDKWvL4m3OSGEwX1
         27sy149nq1tT/ngLrFPEjv3Qwi7oeD6dbVzHxonhKo90/tZwF9WN8vcMJDyd50A8sMrL
         DzAzS4WAx8T4ldCFNWw2BLm0vsDAwPZU3f0wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebI2CZT5sFSOyIJmsHXUvAoUxP/mIFBJnxrOROHyq1w=;
        b=TvwALXTVmX2fyqEJSEeqUSyKbY1Bg84bUjsqHEZiqqlEJ984RReQTLjCJEvZYaEWUk
         zp3s9+y0CGR2MJO/ZZu2lJLeoCsFKo46dRB1oO90VTYse0ZTEdOjzpxO4blUFKGKyFhJ
         WUCgIOsRxQfFVJCmXY/zqQxlicefM3o14aTaPdZzctr898oCIleLWdUbGWH/22kjBhx5
         zXVQr0uxTjCKFfThui0jVBbIukSGrAi50ytGZsDPYfrewd/XE0HD6AZNpUWjNUVjd1zu
         kThbTdfkSfuS58UCWUq9PxJU304k2AN2gVDEQIRrhT7RcwJ4AOBUW5iqrkFqFb+9hnwY
         bVxg==
X-Gm-Message-State: AOAM530tMWn5KhgM3TICl+eyPYjDW/udNzL6BAImFi1/zkMMk4Kwy5Wx
        /RUagYN7ZehSyU5CCGRHJIwLatE5qlLluA==
X-Google-Smtp-Source: ABdhPJzOdaLrm6Hjo2oZT0VyovJiSnyoaQyVGKeMoAlKYjBnk16uHrvaRP6pJP2TZV8SyH5piZ7dpw==
X-Received: by 2002:a17:907:377:: with SMTP id rs23mr4523618ejb.415.1599666667202;
        Wed, 09 Sep 2020 08:51:07 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id k25sm2893053ejk.3.2020.09.09.08.51.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 08:51:05 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id j11so4320257ejk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 08:51:03 -0700 (PDT)
X-Received: by 2002:a17:906:cec9:: with SMTP id si9mr4172770ejb.351.1599666663650;
 Wed, 09 Sep 2020 08:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200827170947.429611-1-zwisler@google.com> <20200827200801.GB1236603@ZenIV.linux.org.uk>
 <20200827201015.GC1236603@ZenIV.linux.org.uk> <20200827202517.GA484488@google.com>
In-Reply-To: <20200827202517.GA484488@google.com>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Wed, 9 Sep 2020 09:50:52 -0600
X-Gmail-Original-Message-ID: <CAGRrVHxj6sJfToQm3-fhDfDbQVuvU+aOnRdnfo4L6CYYnurSew@mail.gmail.com>
Message-ID: <CAGRrVHxj6sJfToQm3-fhDfDbQVuvU+aOnRdnfo4L6CYYnurSew@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] Add a "nosymfollow" mount option.
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gordon <bmgordon@google.com>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Micah Morton <mortonm@google.com>,
        Raul Rangel <rrangel@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 2:25 PM Ross Zwisler <zwisler@google.com> wrote:
> On Thu, Aug 27, 2020 at 09:10:15PM +0100, Al Viro wrote:
> > On Thu, Aug 27, 2020 at 09:08:01PM +0100, Al Viro wrote:
> > Applied (to -rc1) and pushed
>
> Many thanks!

(apologies for the resend, the previous one had HTML and was rejected
by the lists)

Just FYI, here is the related commit in upstream util-linux:

https://github.com/karelzak/util-linux/commit/50a531f667c31d54fbb920d394e6008df89ae636

and the thread to linux-man, which I will ping when the v5.10 merge
window closes:

https://lore.kernel.org/linux-man/CAKgNAkiAkyUjd=cUvASaT2tyhaCdiMF48KA3Ov_1mQf0=J2PXw@mail.gmail.com/
