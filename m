Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B83B2C5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 19:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfINRPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 13:15:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34870 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfINRPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 13:15:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id w6so24402668lfl.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2019 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XajNnJSwjew6KwlldCW4trbMUIMAhNaxK0rzGF9N0wo=;
        b=GQOPKysw+nT1KEz6EVohZLnaKA4d+YkiLahj1rdu/DdxwLBvXuefzQmdVBiyOJt2j5
         dx06Ak4nIqGwvhPyxS9sr0iYiYf0f5tbN/jKxEQCDYnyi8eselFPLVx7XoQC++0w6tHo
         xX8sfASrxqXtY6cLCEF795kh+3+GZrigs43I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XajNnJSwjew6KwlldCW4trbMUIMAhNaxK0rzGF9N0wo=;
        b=sFy2a9BsupjLP9YZqF6SWyGNm+ba9RrvtNZVKz0P9DUlLkI/ZPE9c8x+T5rcksPyND
         DeCad/oche+so34bCvZ+22qUhfgvvvYgZM/ey1JwHHz8omP+z819ojzQrxGCdjIAxGK0
         LjsM3gsg6Z7XTj+RqZkiMmRTxYADwqOJCwAWtOMWi2ovh+ewZp9EnKNeUWcbwwgANLX6
         gjxCrCNskkUO06SqVTvlWq5prcZkxxWMcTNX5cVDOyNLZq8Z0jgFrQUuIkIiUOgC1VA0
         N2xYnPcNRQdFzY+N+QeW7pHN5ccRMmF8IH7xyBtdtACCBhHKlxmiYxtJzTZXhlyGTKQ4
         QK8w==
X-Gm-Message-State: APjAAAVV5P6e/X59oiJgxHKIShFq+3f/GqRMsaxdjIo+JjFlaenWftvg
        q5IsoSyi82QvHxnyE1NzWblddzdkl44=
X-Google-Smtp-Source: APXvYqwVPy7tDB9+KBHZr2TZw0VWNkD+e3anKEqfPGQQpCXCObqTRuocSFXly/TgB4A00Gs1oJ1ZAA==
X-Received: by 2002:a19:f711:: with SMTP id z17mr15086577lfe.58.1568481339940;
        Sat, 14 Sep 2019 10:15:39 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 77sm7113476ljj.84.2019.09.14.10.15.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2019 10:15:39 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v24so2347155ljj.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Sep 2019 10:15:38 -0700 (PDT)
X-Received: by 2002:a05:651c:103c:: with SMTP id w28mr9278745ljm.90.1568481338454;
 Sat, 14 Sep 2019 10:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190903154007.GJ1131@ZenIV.linux.org.uk> <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com> <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk> <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com> <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk> <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk>
In-Reply-To: <20190914170146.GT1131@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Sep 2019 10:15:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
Message-ID: <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 10:01 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I thought of that, but AFAICS rename(2) is a fatal problem for such
> a scheme.

Duh. You're obviously correct, and I didn't think it through.

             Linus
