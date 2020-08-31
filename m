Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE32257B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHaOuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 10:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaOuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:50:05 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF86CC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 07:50:04 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id p3so3363059vsr.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8/6FtzmNQ4XUI22DDUh7WP15760g1u/VF5kYrz4MaI=;
        b=B7Wp3JaE4eKXWms+vthBQhfjguFFVbLZquburINPT0faRyTg73Mk+9nqkebuq0m09r
         OGHhlUASsenTFpmfcqf66hpIN/DbcP8OYFhNBDTkA+P1ItID1LO0NQxGqv7Y9WpRujIv
         sxtmMxKVnJOjpljaGPvUUNaD75mnEj57lrl+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8/6FtzmNQ4XUI22DDUh7WP15760g1u/VF5kYrz4MaI=;
        b=LygOX5L+azlZZsPEzfh/3IIG1ZiFyvG+kWleQxOrudu/f7nA7GF+WajA/mQygIIMqt
         ALE8aOVuYBhxPppHkuFVwwea72SbOqPtnpRcflP+ZOI1poJ6AWm69aaznEukIDAush/r
         yAwN1uGD6rEAJ8mOdYUSsFdPAzLj4QiOI5hsXmOfZ3BasxH/VqjqFLuvGiYXmWk1v+Lt
         99jSv+p9mGLxJzXbGFs0Hm+8mZ6PRHZoXPRnXPS3xJQJiE4Vel+EdtIDo3q1yDNJ98r6
         UcPBJvOdxfk5GsFimpIpVaHr55hT8SJp0PqRvXJ0URoHpx/17aePDUPoh0Z+mYApbzjd
         Wk7w==
X-Gm-Message-State: AOAM531zoE29MfN9497PHakNj9k6E/tw10ugsib2/cTulyi8V9kwLmeH
        fixiZ21CMgtYJIfpICDcJwEzWDaYdjCeaItGDdp89g==
X-Google-Smtp-Source: ABdhPJwWpUAb2X54o3/p++y0s+NAeuNx/66wvgJ0cOcy/872hXSf+z6Ao8GGRD1+seW9z5F0S600F8gHrU+tMfbCRJw=
X-Received: by 2002:a67:8783:: with SMTP id j125mr1325565vsd.174.1598885403014;
 Mon, 31 Aug 2020 07:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200829180448.GQ1236603@ZenIV.linux.org.uk> <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk> <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org> <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org> <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
 <20200831132339.GD14765@casper.infradead.org> <20200831142532.GC4267@mit.edu> <20200831144554.GF14765@casper.infradead.org>
In-Reply-To: <20200831144554.GF14765@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 31 Aug 2020 16:49:50 +0200
Message-ID: <CAJfpegufcUwasWvqJybbMjOHsJkVVKTyp5YTdHMh7YgQWoomnw@mail.gmail.com>
Subject: Re: xattr names for unprivileged stacking?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 4:45 PM Matthew Wilcox <willy@infradead.org> wrote:

> If one thinks that Miklos' crazypants infinite hierarchy is the way to

Oh, I care about ADS *implementation* not a wee bit.  You can
implement that as a flat structure, or not implement it at all.

What I care about is the *interface*.

Thanks,
Miklos
