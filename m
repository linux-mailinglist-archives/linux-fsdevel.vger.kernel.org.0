Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0FCED23
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfJGUE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 16:04:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36698 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJGUEz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:04:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so10190628lff.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 13:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GePA4mA7sQIEG3MZZwlVQLPV66eifOkmE3PgU1n0qK0=;
        b=OzoZMg8bsThH/7YIIYERa+GnGEoGVQOmOpZZdz6Wwt94Bq5dPr5CAjoh6XGWzyvJ5e
         50FMWPp8sPelV93ADS+wQ5tvxWRniBO0qj+eWq+cQy18boRXEd0PKM1UgyHKVhaZQarY
         zh5t4iLJHEVqOHZA4vr+iys3VqD6HhTC6RMqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GePA4mA7sQIEG3MZZwlVQLPV66eifOkmE3PgU1n0qK0=;
        b=as/Gn26yI4JThEby62my5qemb590sBHlB8oEe6Zz0y/LAZ4yvPyDRzQvoNC9DGiTBQ
         EtJjsQnMLBrdqYFCvpHH2ga5TFQ1ZUxmq8v7AHiyEPfq3m4vpGdukoNkQcm2LY7MlV1T
         B+22l+nsmaEUuatoY3BYshqjuobL6DL+nh6+FO4lpfM1F8WSzTESL94rglN1w+CGAX9S
         +C1Xzv3MkEzsEHMv/BQUzJWdz9+eLi1sf9SFPg+YZAVIYvqbqVzSSZgZHbJYSutnsfjr
         BPgkVIm+yvOp517E3AtwIWAeL2EGuvwNkkvoGWJQUe2H1MNn7xgBN0o4gs++gTHKJl6o
         VLew==
X-Gm-Message-State: APjAAAUHYtwXlFDgV2/+xOXMEnJQgo249B9rmcT4cCDQpP+vo9rH9Swx
        g/SKyHh43iXiMEZZmvphxb4Wht5nO6s=
X-Google-Smtp-Source: APXvYqyqAm9c+mT7+DpNpgiyAssx0Yjo8m0lXZ8nC8E2Ljopfzv0EBci9u9AuHgIFI/MY15yW0+yMQ==
X-Received: by 2002:a19:644c:: with SMTP id b12mr7655536lfj.104.1570478692731;
        Mon, 07 Oct 2019 13:04:52 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b21sm3073255lff.96.2019.10.07.13.04.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:04:52 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w6so10176225lfl.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 13:04:51 -0700 (PDT)
X-Received: by 2002:a19:f204:: with SMTP id q4mr17645967lfh.29.1570478690784;
 Mon, 07 Oct 2019 13:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
 <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net> <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
 <20191007012437.GK26530@ZenIV.linux.org.uk> <CAHk-=whKJfX579+2f-CHc4_YmEmwvMe_Csr0+CPfLAsSAdfDoA@mail.gmail.com>
 <20191007025046.GL26530@ZenIV.linux.org.uk> <CAHk-=whraNSys_Lj=Ut1EA=CJEfw2Uothh+5-WL+7nDJBegWcQ@mail.gmail.com>
 <CAHk-=witTXMGsc9ZAK4hnKnd_O7u8b1eiou-6cfjt4aOcWvruQ@mail.gmail.com>
 <CA+8MBb+VKk0aQZaJ+tMbFV7+s37HrQ6pzy4sHDAA3yqS-3nVwA@mail.gmail.com>
 <CAHk-=wi3P2NvBNocyNFTAb-G08P0ASVihMVKmiw__oNU4V2M5g@mail.gmail.com> <CA+8MBb+Vubsx3Qyav25tgUgiGbs1XmEwoaCXTM=8jk4m2CxRbw@mail.gmail.com>
In-Reply-To: <CA+8MBb+Vubsx3Qyav25tgUgiGbs1XmEwoaCXTM=8jk4m2CxRbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 13:04:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFQNxO+JgA808pCMO333N5PkxrwU4kCntiPxqZKuxgQA@mail.gmail.com>
Message-ID: <CAHk-=wjFQNxO+JgA808pCMO333N5PkxrwU4kCntiPxqZKuxgQA@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Tony Luck <tony.luck@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:49 PM Tony Luck <tony.luck@gmail.com> wrote:
>
> If PSR.ac is set, we trap. If it isn't set, then model specific
> (though all implementations will
> trap for an unaligned access that crosses a 4K boundary).

Ok. At that point, setting AC unconditionally is the better model just
to get test coverage for "it will trap occasionally anyway".

Odd "almost-but-not-quite x86" both in naming and in behavior (AC was
a no-op in kernel-mode until SMAP).

> Your patch does make all the messages go away.
>
> Tested-by: Tony Luck <tony.luck@intel.com>

Ok, I'll commit it, and we'll see what Al can come up with that might
be a bigger cleanup.

             Linus
