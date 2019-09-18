Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6499DB5FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfIRJBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 05:01:21 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39871 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfIRJBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:01:21 -0400
Received: by mail-vs1-f65.google.com with SMTP id f15so3964543vsq.6;
        Wed, 18 Sep 2019 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m8Kbvew+H70KpTTMv2ofbzrIP+F0bBe1liPoWD4miY=;
        b=r0UknZwf2+8JpDjjhIEWROvbWYzXYMt5KU+XFaRy8O2oZv7qnP8kWSLB8BbcsmbGFN
         LLA4lwghiGSGhp7ITukzlR+/Myqev6I/n2zD/ZCNYW9qI7wg5NEKWizx72+F6FIxJsyT
         ND8gv24NOfqoAMDxGnp6rTf7NzybZkHV1WIt8nQm07vDHiDY2wWLOH2GJ1sXSaVkNIFB
         bW6zh902XUEBugns22O/eoBr9xqsZVECkyWWTJwSMZp7NEspUbtdOg0NKxsENWX0SoBP
         knHNHYaMixPD67xuQpa793M2HTbIUSV5hvWris56FjTWVW92dz1RQYgf/kQTKkbdbnKH
         gMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m8Kbvew+H70KpTTMv2ofbzrIP+F0bBe1liPoWD4miY=;
        b=CypHiU0QMgjFoE1josIptSkNznsahEBuZlAsPyzGkLpsan2RdqN9oWhR+tVZzz6wFW
         we95YgdpFILuulW03l5qTEo9hzXXgOZioBu4iZv8gteKqh0WiepIbkSVybZpwOVxceyl
         +BofeF7TTGR3z38MuEif4S0ym/MIgWSoHRPwXAg0qgznxwfeuOFMTczbN3cx4K9h9xpe
         2sjcL594Egcne+YJJZBYmxYkXa132G7hbge/Pjy8c/NWkzQ8Lq2b04QfReXC2OPlY0Z7
         txwBX9Y3l85ma+QxYgvxOOch0EpTXyNkVXXKT+D0aUUtPouVRdvo1PkecEgTQclvtl0W
         FZ0A==
X-Gm-Message-State: APjAAAXCN0+/tEec3xcDkLFRpo0rJu7qPIlWfQ4ewfwfUB64/ht1AI4d
        GolHB4EY0a2cbDjP9/PYq5HFtl5SCyJmX5POc4s=
X-Google-Smtp-Source: APXvYqx+sirlevR/SKCoElfu4AwtwRMyey7zB4BSWHuYr8xvj+GPsyb0ZSXrMqM0S9P/quXnE9tHeoDGjIUJbDDg4C8=
X-Received: by 2002:a67:7087:: with SMTP id l129mr1566826vsc.83.1568797280016;
 Wed, 18 Sep 2019 02:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <8998.1568693976@turing-police> <20190917053134.27926-1-qkrwngud825@gmail.com>
 <20190917054726.GA2058532@kroah.com> <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
 <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com> <20190918061605.GA1832786@kroah.com>
 <20190918063304.GA8354@jagdpanzerIV> <20190918082658.GA1861850@kroah.com>
In-Reply-To: <20190918082658.GA1861850@kroah.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Wed, 18 Sep 2019 18:01:09 +0900
Message-ID: <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 5:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> He did?  I do not see a patch anywhere, what is the message-id of it?

I'm just repeating myself at this point, but again, I'm more than
willing to work on a patch.
I just want to make it clear on how should I.

> He took the "best known at the time" codebase, as we had nothing else to
> work with.

It wasn't the "best known at the time". sdFAT has been around now for years.

Thanks.
