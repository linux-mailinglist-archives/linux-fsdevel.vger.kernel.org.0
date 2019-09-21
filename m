Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E059B9F31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2019 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfIURij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Sep 2019 13:38:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42143 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfIURii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:38:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so7188819lfg.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2019 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9uzXWOnb3Pc5Qsb1LE5MUvC1fVGZwEM0q61PiSxnxLU=;
        b=VU396UY8L/Spo6Oc4Q07B48YPPQ3eOQEIGPyhhH4QrFNUbqtdGILMLZTV08RFVO32A
         A6SwxESY8rNKzloxo4+kIVeBAqaF1MLVGnwEusFTKFQMoh7j8gaJd9rQED6q16xeVcqm
         JJtrc32B22MCxS28WGdsD4JlZKB20RdbZcWaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uzXWOnb3Pc5Qsb1LE5MUvC1fVGZwEM0q61PiSxnxLU=;
        b=o9RULAHaCfjfIjckh6y844SgzrqrkAeeorK8Imb8jozxsVu9Gi/wkYqp+HEdvrLe38
         MDy0QZIdraIn4QxV0Lp6YZg8872kIrv2aE7gaX4jWB1NprFVuI2JkACv9XrBwBBvTPs4
         e1MWilhRFBFEnqktoKULIUwxOEMT6RlJljclMsNI7ii/pbQKXunsPEsWVA40vnxu/rIN
         qUmWvX1b/Q5327TcBlsoUniqka/3YzwlSHiTZgSYPNePmEoaPJvlY/Q/TiaKZaFEBphk
         Uto5vDbZNR1w1tG12bEu2FvU4SRbviZ1+AATLOtPe7OOS/ouX/m/ytfo2HQQIE8Pp+g/
         9c2A==
X-Gm-Message-State: APjAAAXUffYtjICU+Mw+YsitktecmCW6OvyM7E+ioDNDrpexkZ3ji75d
        tPIo6mEduict/96JxZyl/r9ihTEgbEg=
X-Google-Smtp-Source: APXvYqxW9lK1ewAWb5LiJ61KDGCqW27xCutnJRXf0RUCtQL8vSEVW+htjHrcgofi168zB/rAmLW/yQ==
X-Received: by 2002:ac2:5463:: with SMTP id e3mr11796376lfn.117.1569087516523;
        Sat, 21 Sep 2019 10:38:36 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id h9sm1204800lfp.40.2019.09.21.10.38.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2019 10:38:35 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id j19so8478570lja.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2019 10:38:34 -0700 (PDT)
X-Received: by 2002:a2e:8789:: with SMTP id n9mr12554952lji.52.1569087514698;
 Sat, 21 Sep 2019 10:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190914170146.GT1131@ZenIV.linux.org.uk> <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
 <20190914200412.GU1131@ZenIV.linux.org.uk> <CAHk-=whpoQ_hX2KeqjQs3DeX6Wb4Tmb8BkHa5zr-Xu=S55+ORg@mail.gmail.com>
 <20190915005046.GV1131@ZenIV.linux.org.uk> <CAHk-=wjcZBB2GpGP-cxXppzW=M0EuFnSLoTXHyqJ4BtffYrCXw@mail.gmail.com>
 <20190915160236.GW1131@ZenIV.linux.org.uk> <CAHk-=whjNE+_oSBP_o_9mquUKsJn4gomL2f0MM79gxk_SkYLRw@mail.gmail.com>
 <20190921140731.GQ1131@ZenIV.linux.org.uk> <CAHk-=wgrfvGOdgCQARA5Jwt7TbdM7MG8AUMyz_+GCdBZ7_x21w@mail.gmail.com>
 <20190921171858.GA29065@ZenIV.linux.org.uk>
In-Reply-To: <20190921171858.GA29065@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Sep 2019 10:38:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0A7jd9bvm1gN8yykWDL1SBbUVwGdH3rSuHBShamEmuw@mail.gmail.com>
Message-ID: <CAHk-=wg0A7jd9bvm1gN8yykWDL1SBbUVwGdH3rSuHBShamEmuw@mail.gmail.com>
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

On Sat, Sep 21, 2019 at 10:19 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, how much is the cost of smp_store_release() affected by a recent
> smp_store_release() on the same CPU?

Depends on the architecture.

On x86, smp_store_release() is free - all stores are releases.

(Well, there's the cost of the compiler barrier and the fact that gcc
generates horrid code for volatiles, but that's it).

On modern arm64 it should be fairly cheap. A store-release is just
about the cheapest barrier you can find.

On ppc, it's an lwsync, which is again the cheapest barrier there is,
and is usually just a few cycles. Although on older powerpc I think it
becomes a 'sync' which is fairly expensive.

Other architectures are a mix of the above. It's usually not all that
expensive, but ..

> IOW, if we have
>         smp_store_release(p, v1);
>         <some assignments into the same cacheline>
>         r = *q;                 // different cacheline
>         smp_store_release(q, v2);
> how much overhead will the second smp_store_release() give?

It really should only order the store queue, and make sure that
earlier reads have completed by the time the store queue entry drains.

Which sounds like a big deal, but since you have to be all kinds of
silly to delay reads past later writes (reads are latency-important,
buffered writes are not), that really isn't a performance issue.

Except some architectures are stupid and lack the proper barrier
model, and then it can be a full memory barrier. But honestly, I don't
think we have any architecture where we really care.

               Linus
