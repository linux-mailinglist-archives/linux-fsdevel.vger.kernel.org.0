Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C531E213217
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 05:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGCDSr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 23:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgGCDSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:18:46 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7128C08C5C1;
        Thu,  2 Jul 2020 20:18:46 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i25so31207512iog.0;
        Thu, 02 Jul 2020 20:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U9YC5H2y22Q5M5VCA+FjTxvf6edeH10IvXxu6UDAN64=;
        b=a/jJSrmHkjCwYVfUkiJ6wv0sa8zPKB6xO9+QMR426qTU1gNrvJdSPYnF+hoYEOW9WD
         VkSt22lFsNd9iHlbOk/Y0nJtfBkqOMi/RRV7fRMTBWRgFQmv+S6YRbgmZW/W/qTYDuaJ
         83fZAOlUDnhN9PyNGvReL0mYUUWxtZrH1vG3klkjzKrx/kxoxQvisopdZIaZZAIfCcYO
         oiCVbgaxiM/E2WMOP9f8Se9xsLESaZmvtb76fEQRqaMOxm1XLgNBezus8WdSf2qNeTca
         ygPmbILz365ppAnmd6G3goyAZTk6dz6JKBowhdArUzVnCJPGen8Is7ErQo2/6osYU4Iw
         WVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U9YC5H2y22Q5M5VCA+FjTxvf6edeH10IvXxu6UDAN64=;
        b=OD7Su5m257Tn4NcL4mdF/Y1qEJ95G8EecU6GWYsrnFUb1yEGcScb3qMzB7wwF1vJZk
         mKY4vcKsF3NSUPDDENMF2/a1aCF7upog8TMqM3W42iWqRHAjx2sdmuclIh5NDuxGGFrh
         aPf/2+KTMtvrVEje6vVK++OrocZBQ6k043PH8oSWk3RLCM2lxvgDhgLEvx0V2bNJhEIa
         gewaM473/5xUUVWtcQAP11ABHBJnT4VEhEShP9LhU5EEdARgJahT2V+V+mZ2ZYvlTqOU
         PTRST/0eMbUFfKdibXlSlxZpzaBLGcOkvWf8Ffa524xgKB0ZYdysGFXa0NwL7nAjPUL/
         aMEw==
X-Gm-Message-State: AOAM530ieN/YD2lDSoA2R7PqRxhV8jY8q2P8TQI+mh0lbAqrNy6CBYI+
        UBbFxtBdbSjD4ate8nC0o/wEDRuwF3M/0jo9/JY=
X-Google-Smtp-Source: ABdhPJyfDnVvEywAmUiCTEEJgoyLdhnj95M0/d5L30vIG/ouwtnmL8lSc/0hvfUEGrL7hUtpT5jCFubvgSmhcHOYlgQ=
X-Received: by 2002:a6b:7106:: with SMTP id q6mr10448992iog.122.1593746324189;
 Thu, 02 Jul 2020 20:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <1593698893-6371-1-git-send-email-chey84736@gmail.com> <20200702174346.GB25523@casper.infradead.org>
In-Reply-To: <20200702174346.GB25523@casper.infradead.org>
From:   yang che <chey84736@gmail.com>
Date:   Fri, 3 Jul 2020 11:18:28 +0800
Message-ID: <CAN_w4MWMfoDGfpON-bYHrU=KuJG2vpFj01ZbN4r-iwM4AyyuGw@mail.gmail.com>
Subject: Re: [RFC] hung_task:add detecting task in D state milliseconds timeout
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  my understanding, KernelShark can't trigger panic, hung_task can
trigger. According to my use,
sometimes need to trigger panic to grab ramdump to analyze lock and
memory problems.
So I want to increase this millisecond support.


Matthew Wilcox <willy@infradead.org> =E4=BA=8E2020=E5=B9=B47=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jul 02, 2020 at 10:08:13PM +0800, yang che wrote:
> > current hung_task_check_interval_secs and hung_task_timeout_secs
> > only supports seconds.in some cases,the TASK_UNINTERRUPTIBLE state
> > takes less than 1 second.The task of the graphical interface,
> > the unterruptible state lasts for hundreds of milliseconds
> > will cause the interface to freeze
>
> The primary problem I see with this patch is that writing to the
> millisecond file silently overrides the setting in the seconds file.
> If you end up redoing this patch, there needs to be one variable which
> is scaled when reading/writing the seconds file.
>
> Taking a step back though, I think this is the wrong tool for the job.
> I'm pretty sure KernelShark will do what you want without any kernel
> modifications.
>
