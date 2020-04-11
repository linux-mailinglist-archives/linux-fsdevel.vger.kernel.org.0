Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15B5A1A53DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Apr 2020 00:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgDKWDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 18:03:00 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37138 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgDKWDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:03:00 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so5286823ljd.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2020 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxTwvLNyEWOqcyAMAl1px4l2VagsXdtElsWFFoHMqrA=;
        b=MUvvXNsBgMfrf2utiUefNgGNFiz8tc8Ft0POaCCNM8mjBA8s9X3yh2N4pcl2VO4plF
         zgsBnYEca8khVlPVEAnJq3PsGRt3JkvKkINq01m+F2sKy2CBtt0z9Qcz00Z8C59gDQbY
         gKZLgQz//ILFSG7Ir8gaz/C4iH7pzhhrvxXDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxTwvLNyEWOqcyAMAl1px4l2VagsXdtElsWFFoHMqrA=;
        b=EFCqzhveMhxwPQXBE5q2TVRNRV9e0aDXgUNPcLopByPRTAebjUHgG6pe23okMi96Ac
         uNS0JdGjdi60QkWwXykQ28tKBjPN+Co0NgvvhG/6UIV+F6kYQTdxFociFi3pkKOAwXNJ
         S4Vg32xrFuBB1aGDIdxclBP+DA/tkR6mI+NOmEG0AGVt3xUxQWQO4HNmcNVufLMTQkGu
         0qu+X2sMOrpPf8iS1SelQTtq9e6FrWhtngG+HeDEHox9Fe5WNltbt4j7c+S3m0MBzLox
         f/zxp08KJORgnx0q5k1Nlg1YsEbAyNWtbORqc9ESEW+112d1AbdMzvJSxZe6nnxCDwO3
         TD3A==
X-Gm-Message-State: AGi0PuZfJhyAEr7xZUF/RwsEcmKMOxM+qr/inyzNHq8cPYr1kW64uqXn
        UCcyI5rUb1UO4fvecmfTIsTJqih7rhE=
X-Google-Smtp-Source: APiQypIl454LP/o6pwbDJpog/w6wTnSBchzBwYkTJja1BCpk3ACCMySVc6v5rkGvuCsD4AftL12zVQ==
X-Received: by 2002:a2e:b4f1:: with SMTP id s17mr6454781ljm.283.1586642577127;
        Sat, 11 Apr 2020 15:02:57 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id i25sm4257803ljg.82.2020.04.11.15.02.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 15:02:56 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id r24so5286779ljd.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2020 15:02:56 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr6273872ljc.209.1586642575880;
 Sat, 11 Apr 2020 15:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200411203220.GG21484@bombadil.infradead.org>
 <CAHk-=wgCAGVwAVTuaoJu4bF99JEG66iN7_vzih=Z33GMmOTC_Q@mail.gmail.com> <20200411214818.GH21484@bombadil.infradead.org>
In-Reply-To: <20200411214818.GH21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 15:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
Message-ID: <CAHk-=wj71d1ExE-_W0hy87r3d=2URMwx0f6oh+bvdfve6G71ew@mail.gmail.com>
Subject: Re: [GIT PULL] Rename page_offset() to page_pos()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 11, 2020 at 2:48 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I wasn't entirely forthcoming ... I actually want to introduce a new
>
> #define page_offset(page, x) ((unsigned long)(x) & (page_size(page) - 1))

No, no, no.

THAT would be confusing. Re-using a name (even if you renamed it) for
something new and completely different is just bad taste. It would
also be a horrible problem - again - for any stable backport etc.

Just call that "offset_in_page()" and be done with it.

                Linus
