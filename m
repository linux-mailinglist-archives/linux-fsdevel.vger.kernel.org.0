Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F101D1EB257
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 01:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgFAXrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 19:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFAXrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:47:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD136C05BD43
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2020 16:47:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c11so10371027ljn.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2020 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPAAhtEgMQMtmHDbk4KgNVVpl7a42uJF+VjoetnC8jI=;
        b=bESB1wsrBJTiKsNhLK8BXuVH4tt31XqGwfNRhMk2+/Xu4/15TnKxr/43IFI11Ff20e
         E71y386MHxjxyD7FDbtXRAwyaf210o9T33Um8QCdKVeopCwtiFvuy3IyPzIPDwLGTs6I
         Skc//o42qw2/7f77dLgDy021eRqbsEEj0r+Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPAAhtEgMQMtmHDbk4KgNVVpl7a42uJF+VjoetnC8jI=;
        b=CqG/Cqb1Po6EC9jA61bPym7AwPXegAfvq6roy+z7E+y6TrkwZk0r2WwD+lLKMwanPy
         QjdxJ++9ihUTlST8j+37J/yCDtyJcxJLB6lyLnkECLEuyuxF3CFx4RNXrQj7galoGC4R
         6HiGka6EHW7gVs1/i0NG+AFfGp4euPbCfKHxKDaijrf17WDB5YmiidHsxlHdxNDpO6nD
         ggI3h4e+haoDvL5KZOq7bJjzz3LKZspNQmzY4IvZJU3W/ZiFnCEnX5TubQftmn9FLZOz
         dB2MWNrO+SCQ8LFIk+n90IWm7auNzNFavSBliQIZ5tLSUWJk9SiU88WRzfGM183o+iEP
         6CDg==
X-Gm-Message-State: AOAM531ZRRkvjwOWRlmQSrtOHv89CrlQaYTFizbD6l/uUBnP3txNpWGy
        maLgYDXz6r86EIB3+/i5v5EhuaqOKc0=
X-Google-Smtp-Source: ABdhPJzoMt1bHzq8bblolKrp2SDOQNbQ/SpvYYJA9lORsVqQXR0mptyHKBIyesuL/89D6KGU+PbwjQ==
X-Received: by 2002:a2e:8953:: with SMTP id b19mr6718015ljk.187.1591055222820;
        Mon, 01 Jun 2020 16:47:02 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j26sm243422lfp.87.2020.06.01.16.47.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 16:47:02 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id h188so5010348lfd.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2020 16:47:01 -0700 (PDT)
X-Received: by 2002:ac2:5a0a:: with SMTP id q10mr12574943lfn.142.1591055221658;
 Mon, 01 Jun 2020 16:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200601184036.GH23230@ZenIV.linux.org.uk>
In-Reply-To: <20200601184036.GH23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 16:46:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQ8vRE3jSby=KOejXORsL2qgQ2g=KQ=Y10NvVoVBFtxQ@mail.gmail.com>
Message-ID: <CAHk-=wjQ8vRE3jSby=KOejXORsL2qgQ2g=KQ=Y10NvVoVBFtxQ@mail.gmail.com>
Subject: Re: [git pull] vfs patches from Miklos
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Assorted patches from Miklos; an interesting part here is /proc/mounts
> stuff...

You know, this could really have done with more of a real description, Al...

              Linus
