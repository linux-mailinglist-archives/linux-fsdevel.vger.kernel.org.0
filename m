Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D45FFCF192
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 06:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfJHEYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 00:24:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33644 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbfJHEYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:24:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so10875932lfc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 21:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ibOtN5zf55brhdHuZKhclLlUWgiBgKFnugDa2ZrV1A=;
        b=QpdIgpspj1uKTJeRIV+rb5IqCsrK/WhrG85qjV26pC9dTDaiih4t0xTBb3STpoRZM8
         jaYC3nDYkrX3Eu4RlO7a92ZHnXWQFD/u6MxVsxrYZlj/42wy+oxwnUITZ1324bcp/G3h
         zA4GaBxcUmaUrESAvwEiD2TuZ7xkaIY1kKoO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ibOtN5zf55brhdHuZKhclLlUWgiBgKFnugDa2ZrV1A=;
        b=kVGQlVnQ/Xu7KP4+boEoKRznWQiFVaNH+0qA6cMr0HhLSrpCZ/oqkrfSayGmvjBA6W
         gJ6id8s7E5RtOqVPli+pPeKWVAm4tQja8afB4Y3JFmFanpP41enuyZFWSdPR/VOnNdOQ
         T/ifk1KWEC+TRWFJpdIkUICQVHrlMXkzEiStY9rRRI8Cp10bQqC4TgD7TiSJfFtoDn8K
         bKtFEJnVEOyO6GEvM5GO2xLGKT6Us/6cc14XCJpcNnsJGCYMj5BRhyf6OhLQ7tojffB3
         YJkIZoPBvCYBL2FqqaGslF7Ngznn1DF7FpzrFfzp+x3xJVBwJRPhb+AKg1MzsIuzlnnW
         IwGw==
X-Gm-Message-State: APjAAAU9A0ZX0y033Sk0HQQSGKL8f2++zy1VmsOyxo9oIuXCQVPOfdyS
        ff8IQXhyvtWc8MjrXAHdhyJ+/QFW7Q4=
X-Google-Smtp-Source: APXvYqxgkC0mRVQs2Krv76VDE2JMsZ3XOpZ85GjM2t62ghYYCkfnXCVAoxtcRFgMjjQg10ow7gT09Q==
X-Received: by 2002:a19:6455:: with SMTP id b21mr19116122lfj.167.1570508674554;
        Mon, 07 Oct 2019 21:24:34 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c4sm3184954lfm.4.2019.10.07.21.24.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 21:24:33 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id y3so15983938ljj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 21:24:33 -0700 (PDT)
X-Received: by 2002:a2e:551:: with SMTP id 78mr21151541ljf.48.1570508673174;
 Mon, 07 Oct 2019 21:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <20191008032912.GQ26530@ZenIV.linux.org.uk> <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
In-Reply-To: <CAHk-=wiAyZmsEp6oQQgHiuaDU0bLj=OVHSGV_OfvHRSXNPYABw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 21:24:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
Message-ID: <CAHk-=wgOWxqwqCFuP_Bw=Hxxf9njeHJs0OLNGNc63peNd=kRqw@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 7, 2019 at 9:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Try the attached patch, and then count the number of "rorx"
> instructions in the kernel. Hint: not many. On my personal config,
> this triggers 15 times in the whole kernel build (not counting
> modules).

.. and four of them are in perf_callchain_user(), and are due to those
"__copy_from_user_nmi()" with either 4-byte or 8-byte copies.

It might as well just use __get_user() instead.

The point being that the silly code in the header files is just
pointless. We shouldn't do it.

            Linus
