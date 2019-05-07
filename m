Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB216B3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEGTXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:23:42 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33201 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGTXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:23:42 -0400
Received: by mail-lj1-f177.google.com with SMTP id f23so15392896ljc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k3OcY9pbJ6WCLqW74lBCOIJ1NCdZ1N4Jy0D8+rDYT5w=;
        b=N3JOzGtXz4DP+EdvPDqHKkZQ5CT+Jl4c1TI6ACgF728WziLgGnzdn6LhQkgheSiZ5I
         3p4ssE0AUlIC+OPOE527T9YDgU7bf6jcanuSeDX2LFacMmuyqchpXoddZiIeymXHCKeW
         6WLCCuVAjakaswntOwCQbL1bYM6Cp2ol6tmuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k3OcY9pbJ6WCLqW74lBCOIJ1NCdZ1N4Jy0D8+rDYT5w=;
        b=ZWsxIvsfjPuXXVnOoGQVTPDO23YkLPU2cu9Aeu+7RoTQlhA+BYoA/pTfFefmK/ACal
         o3X/TmgMy3hxmqHgKc29Euw8BrHP2vTjjUqfwGTX8BaxVUGbpysUgbNAZ78uPOjkqdIN
         Pyi4jgpNJz57XYVb6C0/QQjroIot+qE4X1xthNnjWC/BGeCtaaINEGTCtMj3z48OHDCL
         FSUia6uQktNTXseqzNtTPMiJASPnKYfE/Q+jSzi3oVHvi+IhGFn60bz+08lkL4GjbVD/
         y4z3IcPuRxYzU5xgWrb5/hUXBj7q+rmmx6Ui5+aOSrBRfBWVAdQsjdlcHPYPTimRTduH
         MG2w==
X-Gm-Message-State: APjAAAUXtSkgyoBn7kHQNf4PfZ4vVsGANnIc7va3AOFuTvgyVfCZIGNQ
        APPmudGnxDXI0t/iER5nDYkMU2SXvu8=
X-Google-Smtp-Source: APXvYqxYJn1VSLBZB10cOeY5uZA5EwrMjOfoQYew3AQ+EvAtLJAfjt0l21MJNmfmTm4Bqx/Rs9QZ7g==
X-Received: by 2002:a2e:880b:: with SMTP id x11mr18282437ljh.4.1557257020346;
        Tue, 07 May 2019 12:23:40 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b25sm3526321lji.50.2019.05.07.12.23.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:23:39 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id o16so12690240lfl.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 12:23:39 -0700 (PDT)
X-Received: by 2002:ac2:5212:: with SMTP id a18mr2701885lfl.166.1557257019049;
 Tue, 07 May 2019 12:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <af9a8dec-98a2-896f-448b-04ded0af95f0@huawei.com>
 <20190507004046.GE23075@ZenIV.linux.org.uk> <CAHk-=wjjK16yyug_5-xjPjXniE_T9tzQwxW45JJOHb=ho9kqrA@mail.gmail.com>
 <20190507041552.GH23075@ZenIV.linux.org.uk> <CAHk-=wiQ-SdFKP_7TpM3qzNR85S8mxhpzMG0U-H-t4+KRiP35g@mail.gmail.com>
 <20190507191613.GI23075@ZenIV.linux.org.uk>
In-Reply-To: <20190507191613.GI23075@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 12:23:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbaKc+5HvXypMTrS9qGzL=QCuY9U_27Yo8=bHC6BpDsg@mail.gmail.com>
Message-ID: <CAHk-=whbaKc+5HvXypMTrS9qGzL=QCuY9U_27Yo8=bHC6BpDsg@mail.gmail.com>
Subject: Re: system panic while dentry reference count overflow
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     yangerkun <yangerkun@huawei.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yi.zhang@huawei.com, houtao1@huawei.com, miaoxie@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 7, 2019 at 12:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Negative ->d_lockref.count are used for "lockref is dead"...

We can change that to just -1, can't we? It's equally easy to test for.

Those aren't supposed to be incremented anyway, which is the whole point.

But we could do what the page refs also did: consider refcounts in the
"small negative range" to be very special, because they are either
critically close to an overflow, or they are actually a sign of a
fatal underflow due to some bug. And make one of those be the dead
marker.

(See page_ref_zero_or_close_to_overflow() for the particular critical
range check for the page ref)

                 Linus
