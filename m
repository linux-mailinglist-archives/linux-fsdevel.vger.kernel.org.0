Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF8E13393
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 20:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfECSWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 14:22:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38584 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfECSWC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 14:22:02 -0400
Received: by mail-io1-f68.google.com with SMTP id y6so5990415ior.5;
        Fri, 03 May 2019 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZlTHogcw3KVs5ezkA2HfvmM7+WIz+rn1RRu7f/yTLM=;
        b=f6k1uHljZs07eZhXKFGQV6w98Iz0Wj1FniGxObqMqW1AtTH6CIF5gbVZ4BT00adoBs
         b0xZlZ49T6AwfR4hl571yx4Hv5IlGlhjUGKXOkg8azD6Zed2EbsoNJ4RUSXUwYl/Y1tb
         cktneFJ/yX7TtcxyNYNw9CLsqy6aOQm0u4j6WxuIg/Q9S/La5/JOYl1l29ejdMzs93YA
         CxO+xL31l0H5Fc+64Sbqa3rlpq5/jDgQgOAceFDxf63zYIDVKBTJ4PXBfxuu1dJpW6g/
         cTCMn1gXrKZtYnCS4YIBmJ0/TzcNGbw+HaMf2IHnEU/SixkMPv7BbqlaDoRhIf/Icqfl
         4rGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZlTHogcw3KVs5ezkA2HfvmM7+WIz+rn1RRu7f/yTLM=;
        b=c+pv0npgxyyk6Qpa+/kqm6X+gBcFTTWbdY2q238edPCwkaM4NBKVDqOhHnZtdj1wlV
         LzUofcdxSXQCQwE1KgquSqs2CO+GifJ6UvdqKjSIN9hee/4jJuJf/+RsRkAFx558CAXb
         QhYK79c2KKP8Nxy1NAWroJSH+9zmeerGMvZ0juV36gDRLdZnqKk7nX0aIKI3/Pzvsbvk
         +OlMKxTR28IezScPpSSWCBXtYQ9RcrWtRvDetpITzLQVSOjrdHvxBBgIyIQn02cNRJQk
         ItBxmRMP7pNVMdWy9isFO7+hhnJvY6j7FbwVXYmESEELzZ0ZqzrGiVc/epjUC0RmCwiT
         tQ7w==
X-Gm-Message-State: APjAAAWlQF5UTFlMamIzVzmEqZzsSacjWp+E0RRciow7ARIS2o9n+rS3
        1UABDNNFqt+Kdzs9BRZbxjNgaGTWnjFE3btMujs=
X-Google-Smtp-Source: APXvYqyUsl1h5FgNtwD0YXSW86kllAPBQCoUKFVBx24yK9p7xaOUXnLQNgLk8G8jbdCVY9TU0/BI4xbenWu9CrlpcZ4=
X-Received: by 2002:a5e:c20c:: with SMTP id v12mr1824375iop.184.1556907721138;
 Fri, 03 May 2019 11:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190503033440.cow6xm4p4hezgkxv@linux-r8p5> <20190503034205.12121-1-deepa.kernel@gmail.com>
 <20190503063435.446aqcckbc6ri7xx@dcvr>
In-Reply-To: <20190503063435.446aqcckbc6ri7xx@dcvr>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 3 May 2019 11:21:50 -0700
Message-ID: <CABeXuvqRSO_0pkU2i0eNK2JtRZcPquF0X0h_GJANiQvEuisQHw@mail.gmail.com>
Subject: Re: [PATCH] signal: Adjust error codes according to restore_user_sigmask()
To:     Eric Wong <e@80x24.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Kilani <omar.kilani@gmail.com>,
        Jason Baron <jbaron@akamai.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 11:34 PM Eric Wong <e@80x24.org> wrote:
>
> Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > Sorry, I was trying a new setup at work. I should have tested it.
> > My bad, I've checked this one.
>
> Thanks.  This is good w.r.t. epoll_pwait and ppoll when applied
> to 5.0.11 (no fs/io_uring.c).

Thanks. Al, would you be picking up this patch? I can resend it.

> Can't think of anything which uses pselect or aio on my system;
> but it looks right to me.
>
> > I've removed the questionable reported-by, since we're not sure if
> > it is actually the same issue.
>
> Yes, I hope Omar can test this, too.

Omar, would you be able to test this?

Thanks,
Deepa
