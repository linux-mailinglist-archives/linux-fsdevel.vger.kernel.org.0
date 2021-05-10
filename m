Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B16379144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 16:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbhEJOuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbhEJOsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 10:48:51 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A8FC0613ED
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 07:06:11 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id j13so8457527vsf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFnuGB+WCMGHz+QwS2RJAsJc85f4hduXdUzgwOYUvXg=;
        b=ikSMd3g5O44fa24TXY7ber77UATQvCsJnp3HdelBQZ/3BsWQD4VVrSmqV9ITzwzUnu
         90yn7BZ5dUX9MFAWrnM0kmV+l+qu9YdPV5q6uZ75FIpAjY0bqeWFXkNvt4rhcYB1Gmzk
         7F4cUi1Tdxoy7hKt2+U+U5k+tCGFehJh9N2Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFnuGB+WCMGHz+QwS2RJAsJc85f4hduXdUzgwOYUvXg=;
        b=bEItBwuaA2JKre5jzO13xa4b5ZRTpjegjPQMt/c7ge+5vqkc1DVJ5a8RQ8l7O7B4i/
         Q69iJAdxSonA0lD8B3Oj8KBV16kSP4H7oBxvCdRwKxrR4cwbr59aDcn7NXj8f0XREBmu
         /yU7V9GdApQueqtXYbDGU7LPbOZAYQHHwOwTNTF1r1x+PkDKXodBqMysUyYd84ZYT2aH
         +zfxSrOAXmiPbFSrC4i5LWfvDq5zApOdP8xj2RmmgQQgt3fjNob4oThnJi78Y5SZf3rD
         TplwGf7WZwbDmkHkykfl2m5kYwbMmqLoZg03z6oiy2MOigJvcdnL5VChT1/2yglZwz5l
         zPuA==
X-Gm-Message-State: AOAM533wQS0MQI67XpSyqeSQx3ba12fkAm8dCAPxY10PSywJqJ7uCHnt
        RXsK659CtO0qUu1GOPk2q8DBW+E0FlF8st9/eWLCeg==
X-Google-Smtp-Source: ABdhPJyJ38FHmQxketdQoTWrKTzUEYSbJi/KlkryhCGy2mWbGpsFCQMFl+CAeQrokVAKaT2lR1fvGAPJupKRSkTax4s=
X-Received: by 2002:a67:ebd2:: with SMTP id y18mr19369613vso.7.1620655569135;
 Mon, 10 May 2021 07:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <1618582752-26178-1-git-send-email-pragalla@codeaurora.org> <c0c0c33be51672f01d4f7a2e097bb978@codeaurora.org>
In-Reply-To: <c0c0c33be51672f01d4f7a2e097bb978@codeaurora.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 May 2021 16:05:58 +0200
Message-ID: <CAJfpegt=QmVvMi=wmYfT1QKD80uV5+uOmLWg=T7W0uh01eDz8w@mail.gmail.com>
Subject: Re: [PATCH V1] fuse: Set fuse request error upon fuse abort connection
To:     pragalla@codeaurora.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 9:52 AM <pragalla@codeaurora.org> wrote:
>
> Hi Miklos,
>
> Did you get a chance to look on the below change ?
> could you please review and provide your comments if any.

Hi Pradeep,

Patch looks good at first glance.  Will review properly.

Thanks,
Miklos
