Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810AC3EEF4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhHQPmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhHQPmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:42:35 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CBEC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 08:42:02 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id f25so9172863uam.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 08:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHHPSO7jj5Afaui6tVKtLhUAhQD8i8NyYo0isR8GeJg=;
        b=YSOL+GxlNb0S979n5o2kfajOCu22Bob5lPDXI6IBgRssAlAcRMbcVVX/Gidt16L1OR
         jTuhRZlQH24ibQhE/kyExIgclwitpCfgme2vgluGUviCww0iXqalV0La9XAP8ciBvK1x
         UBa6vaUkjX1tpfdJHITL1GxtUGWmzDT2Tstns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHHPSO7jj5Afaui6tVKtLhUAhQD8i8NyYo0isR8GeJg=;
        b=qX5KH3pw5Jk/LO3uXcor+YAzejwk70kIXnx1w0qXjlYhoSPFMT+BbGAm4U1oeQUaEO
         GDMt8NRQL9Fc1jzCSzEevfBWklsjOlohbXMT3Mxnsy7vut1yJzxrdG5PpzFndnlkSz4y
         CDClmzDjhkmvYZiFqEsECyS5a1EWZoWREaYy6zlrI5XYyqAkPyH8R9Vw9gehkYAYRwkp
         5DhzyJpThzx7KS+RKpoApmCEHZbMMxTfCq9Y0xnGuMwI2nI8WRD0SABE4Wk1C1jUGpDy
         GPowoqX86NOgmPCMcMKSvRXzVaKiAHBd8SW/WyM98YltoKjwsrwB6RB8YR13EiGs073y
         a/eA==
X-Gm-Message-State: AOAM531zDtwgXPC9oC0ECEphSrKcFU6WliqwltspF8LhoT6H2URRut+4
        uf3SbnPTrngV+PsJmwp7hryXQwf/BipOygTkv1tXLA==
X-Google-Smtp-Source: ABdhPJxb/TTQAIpO2p0zoRWOCHSajvQZpOfEeLKrHzg9Rtd51kKyTyAiNDo4k3MtOtVyNxm7iMo1QFl0DYO7gAtwOpo=
X-Received: by 2002:ab0:3a8f:: with SMTP id r15mr2993319uaw.13.1629214921954;
 Tue, 17 Aug 2021 08:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aLNUNGo94u1yVKSJwy3rehRP84ha8YmbOdMyehFeVah0w@mail.gmail.com>
In-Reply-To: <CAPm50aLNUNGo94u1yVKSJwy3rehRP84ha8YmbOdMyehFeVah0w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Aug 2021 17:41:51 +0200
Message-ID: <CAJfpeguDzHO9rx4eVRi4Lvjj0O9-oT8SEN7JAfWtsNj-6M_YAA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Use kmap_local_page()
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Aug 2021 at 05:17, Hao Peng <flyingpenghao@gmail.com> wrote:
>
> kmap_local_page() is enough.

This explanation is not enough for me to understand the patch.  Please
describe in more detail.

Thanks,
Miklos
