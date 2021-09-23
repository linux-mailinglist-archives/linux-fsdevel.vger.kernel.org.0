Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE0D4160D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 16:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhIWOOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 10:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241304AbhIWOOs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632406396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HgIdrh9IMw3T6yu/iriHzVRHYPl5P8FCimYDVN32Xkw=;
        b=gOXxA7rMFN0fU7J5rTA5jOlKPaqIFEbyIgSsieio3JaUiVGj2KKGJ02syOerTLMPGvMvOr
        OOywXtJIg3UQ8OJginzTxY7DaTMU0E1Y93cD7pD6RChaJkrpjGCTSIs9VvhnbcyAhLHYtS
        FfB1YlfjPs5j8SPhtUng7wYlbsSG6i4=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Hkn8T7BIMhGmHMUZszsIow-1; Thu, 23 Sep 2021 10:13:15 -0400
X-MC-Unique: Hkn8T7BIMhGmHMUZszsIow-1
Received: by mail-il1-f199.google.com with SMTP id b18-20020a92dcd2000000b00234edde2da9so5524235ilr.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 07:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgIdrh9IMw3T6yu/iriHzVRHYPl5P8FCimYDVN32Xkw=;
        b=KIn0dYUJEiRg+XuM4HNNOUHr/wgwuKDKr9rQ2yBn3AhyMduS1N6khmqW8dXDQ/W+3j
         n6hLXECZ9vZ716V6mb2oEUlpUqKEDGuum7U52sSGENSKheXuYkDNj5N04krH/7X9K/Wt
         BlscZ1hCJl+V4URH9EeX+Z3vpLkGx4da/xPMmsfnLARM2u+ib2OVVwrdU04mikCj2PyD
         x0wHI07NoiLJjAUfoZ8m/Oks7bhVVFLem4CpRrv3z1XGsGxsm0v53NJA+iHre/s+S3OS
         CYs8CD3taERpDkosQZIrX9Srfg5RKQm9NURSCM8OC+NrXDtnKJA7yV2gTe8APPWQdw55
         Z2ew==
X-Gm-Message-State: AOAM533oGzb6ZFl6pp9acCCIilWujmWcGypAMEy3jNxEkFMY2XfpfhDR
        kgbaEkDNOThpEkDlheMOaD7CvsdODTvLOvnDx+GLSyYCz/RouGqXmRjTEs1el7l1YyqbMR/z8ZK
        1Eohl6tI3lGYv9MWN5JWKnOIoT4ykVnA2qeTd+WVziQ==
X-Received: by 2002:a6b:5d0b:: with SMTP id r11mr4127906iob.92.1632406394556;
        Thu, 23 Sep 2021 07:13:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwiQDPf0cTFJ+26nFlrAJ/SIJT1pK7r2TkmdY9wUBXQSZVP/rMUDfLFdvY7yohcxljIef+KUJKtxPEL77QIBA=
X-Received: by 2002:a6b:5d0b:: with SMTP id r11mr4127884iob.92.1632406394332;
 Thu, 23 Sep 2021 07:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210721113057.993344-1-rbergant@redhat.com> <YSeNNnNBW7ceLuh+@casper.infradead.org>
 <a5873099-a803-3cfa-118f-0615e7a65130@sandeen.net> <CACWnjLxtQOcpLGES1bX1cN8E4PYSx-EVk0=akMUss1pXuk1Q7A@mail.gmail.com>
 <CALF+zOmuj2VJn=g-HwB8mbEPLtKcUC29LxLx4Vh2a_cjYw5A6A@mail.gmail.com>
In-Reply-To: <CALF+zOmuj2VJn=g-HwB8mbEPLtKcUC29LxLx4Vh2a_cjYw5A6A@mail.gmail.com>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Thu, 23 Sep 2021 16:13:03 +0200
Message-ID: <CACWnjLy6xfzPtxHWLrLZXguVYXMNS7mXjHZVs648yKeZsY_0nA@mail.gmail.com>
Subject: Re: [PATCH] vfs: parse sloppy mount option in correct order
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Roberto, it sounded like David H was suggesting maybe an alternative
> approach.  Did you look into that?

No, sorry about that, it is in my todo list. i'll take a look at it

