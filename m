Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA3E12EAC9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 21:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgABUIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 15:08:44 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36614 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgABUIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:08:44 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so34992997iln.3;
        Thu, 02 Jan 2020 12:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1hCTeEJqsz6sWXLkCqqNE2eKwc5EpIhnHr0o3azERM=;
        b=YHy6+D53T4cPFvuwLUjZGVTKkquTiuGD6AitwjaBRiQ3DdYLaHec3ZV999kJ9qo4Za
         har4bTLHRnY9mb71uY1zQynzPq7vkSzRU2KrBtnXvv7uZPMbAslAqrJN+Lvz9ALAdgtG
         Kr3iilYtQiFX4jzTT0jXPQcCnQbfAymt8TpBDosZTgA5aNeQl9UjDr+K4t8g7dqK7hYs
         XF3++apSF5WvAYRu0/bChLc+YDKi+6ay8omWZd0EUA9zw8AexAdSree9gki2b4kYQKhQ
         FGtwc50eyjLeg74Bsp9qtdEatfdO5pGqTjR1W4cVD6lSdQK22A/P7+xdflx+lQDgsfeZ
         tMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1hCTeEJqsz6sWXLkCqqNE2eKwc5EpIhnHr0o3azERM=;
        b=VU7j5wuTqmrrw1HjbxxpaVTIgVZgYbMPZcy3l71wOM1fT0S7tpGMhReCRjcdaLdNNj
         1Nj3CSoysS6JYLwhp5wQZ0suU9bBLzjiuLmjQUpYEPtyyNyNny+Ycijj+mkSdXhVisb/
         F1vp4AI3hP1ViE4o8ykwXvwrsLL4i+6tn5q/6vX1eWT6pq2BsR134CK37i60qR4odxIb
         Kp+KSt2YVgnBWH1wEx1o59x1ncTIoypTijyEZDpZZn+MLFJKg565S2cVRt5H74c5TMic
         iLbj2z7pNqnuS02g6ay0hsVeYuW3fyVAD3c018/aq9O9ThaOCcToorCq2sjWe5giyhnM
         RZtw==
X-Gm-Message-State: APjAAAXGq5DRVj3EXArm0VuFRWR+ZwT7pYJK+jlGOUWL659nuWHU6XWB
        PtnRq9eUd5m5ONEi4Zd/SqHKc4aLUgNu+1huoyd18KI7
X-Google-Smtp-Source: APXvYqz3enXjzakAbF0V7JKTkSMXPmAAGWsbsoVkM7ASVQzbwdh9Zi3BRz/t2ThMi2QOVNHME0TuYtdt/e7QP3iRG4k=
X-Received: by 2002:a92:1087:: with SMTP id 7mr41342954ilq.275.1577995723830;
 Thu, 02 Jan 2020 12:08:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577990599.git.chris@chrisdown.name> <738b3d565fe7c65f41c38e439fe3cbfa14f87465.1577990599.git.chris@chrisdown.name>
 <CAOQ4uxi0v4WL30gpedUbex-TD5wN8p8kCop_3VDYV0UBJGB21w@mail.gmail.com> <20200102200052.GA1181932@chrisdown.name>
In-Reply-To: <20200102200052.GA1181932@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 Jan 2020 22:08:32 +0200
Message-ID: <CAOQ4uxg7a=U674CeT5=j7181=Y8EyMCQhFeL76B95_tGpQeJdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tmpfs: Add per-superblock i_ino support
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 2, 2020 at 10:00 PM Chris Down <chris@chrisdown.name> wrote:
>
> Amir Goldstein writes:
> >Wouldn't it be easier to check max_inodes instead of passing this
> >use_sb_ino arg?
> >Is there any case where they *need* to differ?
>
> Hmm, I suppose probably not? In that case should I just check against
> SB_KERNMOUNT, since max_inodes can only be 0 in that case?
>

Yes, I think that would be best.

Thanks,
Amir.
