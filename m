Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DDD1773A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 11:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgCCKOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 05:14:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43429 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgCCKOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:14:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id s23so2195191lfs.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 02:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HZLJdyompUEUfGaYkKC4//Srq4/t18wcP+yf/P65E7A=;
        b=a5uUjNdkPvsrGH3XeHiv1khDvumuDRVBlNJFC6lUcfnUmuEr9PE65vkxV2uphGI8I+
         3UDxl8sCAJQepm6KrwdpYMCFAy4EhMEfbAtQadb5vks/qYfRrfHpQmiOnHv3zLQHSL64
         LsKSugPrYvGKzFfo8Wcxx57HXmjc6Rh5nN3sM0/Vc7MX01beFpdLGSt6E72oLxzAtRQo
         4hbRPYZQs8ryVm7Mxw3O7gto5lZutkgVkcNa7CFh/DpvT8w2plqfGGrWnnV4TP8cgK6O
         ET/tJ71P9YBvAv1wQtLs9YjEUD7/VNYhhflzk+EiIRITC1vrifpAWn3tuqabLLlztiXE
         2WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HZLJdyompUEUfGaYkKC4//Srq4/t18wcP+yf/P65E7A=;
        b=q7d2WDji6zXIRiu5IyGzTVY+sIU3AN4/e3zGZw98Ums8aKLs7iq0URzcWLYTPaHjT7
         MkBe68EE6pjG1c9VNnlJdEIg6XaR7ylmFLI5dzfRktrEkHuBKgQ7fvZrMFplZaV/js+l
         3wruOzYeivibPkm+sKo5Btx/UqN2zR4m+FSWrEM/SlMAq39rl199uPkXURXpJ6u+MfZd
         +PA+CFXG1k5/ENadv/pYZo/U8oqXKcItqQp51umSDC6IInNEelz3rriu+FX77zJYieAi
         LZm8vDzh3ld4Acju0W4UbYQ6WQRBu6FCu/SuE7R/GPtYnvC/QhDh40U5yojYkskSsvPu
         PnMg==
X-Gm-Message-State: ANhLgQ1nNtoRqRPd+vqm65mXIEZdqS/sQJOHJf39fmeqHT+QgYIJF3l7
        r7lXHVdxQS/lJ4MJixmvFwXB32ZJFfxjRCeWnA5/fXbeniA=
X-Google-Smtp-Source: ADFU+vu5Z+2UkQtHXzD5lzUdpVS3/bgA81N4t8QmWWStrtzKpM10C+DUPxwjWYbFyWaEbFuH3qhuWk3LkwXpW6YO3Nw=
X-Received: by 2002:ac2:5699:: with SMTP id 25mr2373610lfr.54.1583230449412;
 Tue, 03 Mar 2020 02:14:09 -0800 (PST)
MIME-Version: 1.0
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302103754.nsvtne2vvduug77e@yavin> <20200302104741.b5lypijqlbpq5lgz@yavin>
 <CAB3eZfuAXaT4YTBSZ4sGe=NP8=71OT8wu7zXMzOjkd4NzjtXag@mail.gmail.com> <20200303070928.aawxoyeq77wnc3ts@yavin>
In-Reply-To: <20200303070928.aawxoyeq77wnc3ts@yavin>
From:   lampahome <pahome.chen@mirlab.org>
Date:   Tue, 3 Mar 2020 18:13:56 +0800
Message-ID: <CAB3eZfu1=-FwJTnnH=sfg=J2gkeF0bgMs43V5tSkxdqP+m+R9A@mail.gmail.com>
Subject: Re: why do we need utf8 normalization when compare name?
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Unicode normalisation will take the strings "=C3=B1" (U+00F1) and "n=E2=
=97=8C=CC=83"
> (U+006E U+0303) and turn them into the same Unicode string. Note that
> there are four kinds of Unicode normalisation (NFD, NFC, NFKD, NFKC), so
> what precise string you end up with depends on which form you're using.
> Linux uses NFD, I believe.


> And yes, once the strings are normalised and encoded as UTF-8 you then
> do a byte-by-byte comparison (if the comparison is case-insensitive then
> fs/unicode/... will case-fold the Unicode symbols during normalisation).
>

What I'm confused is why encoded as utf-8 after normalize finished?
From above, turn "=C3=B1" (U+00F1) and "n=E2=97=8C=CC=83" (U+006E U+0303) i=
nto the same
Unicode string. Then why should we just compare bytes from normalized.
