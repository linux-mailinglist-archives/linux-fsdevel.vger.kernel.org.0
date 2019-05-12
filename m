Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DACE11AB78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfELJU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 05:20:26 -0400
Received: from mail-yw1-f46.google.com ([209.85.161.46]:39026 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfELJU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 05:20:26 -0400
Received: by mail-yw1-f46.google.com with SMTP id w21so8482717ywd.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2019 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVLpMWLmvA+1MZebHEXOjs0gxZTpjXeTr1TwlkLKA9w=;
        b=DYv9J9CeSEGGWv+PK1K0JgVhE3UfH+yhjPTRcbpkf2RM/V0AWYIgMXTiD7PiQUJI7c
         HGnbLReZLK0+vYfmf5WAT4Mi1aWUqTcX7Jcp57islxjnefGDXf+FvhfXp254YqQP97v2
         rV/bFWoJGq55qj/jdBh94LnHGc2X8rFUWvHVkE58yWl8qfwUDikS4Jwgk2FgBsjAExmg
         7twSb7NeBXytunAUmNswHWmV6vMB+JR5wfHaWQbz9h5UowKgzPrZe59UAoUTnuCh1rpX
         AfVFO6hL7E+ofyuJtnqgiWy5LTde+y6XfFUqbumxq1Yq9burCnonIKMFxu2x8EcMwi2y
         FZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVLpMWLmvA+1MZebHEXOjs0gxZTpjXeTr1TwlkLKA9w=;
        b=ciW89sBhv77IP/LjYgfZ5Mj2R8m9GmYsCLJcW+tIXPQFivB02NzK9w047yBRVPl0RE
         YipbNs6kHigORJ8r4LyPtK39++R99HpUFqR3EmH+FkB7VI7SJQclRARYEEAKRhBeQRYe
         w/XxrlEotXxy/cXslC9cxZw1aBwyVoq/z4Roz3I8w1jFizFK42967EpyW8awfr3y6vZk
         B+AxW8aMR9fSl7W51SYNnGPxehZ5+LVGbYfRPDgySncUZ4C79Cb9A9zunvdxWB9c2+xM
         6Y2ZY+xf9e9stVHGsJ2YtUIK8wEu9Nx/faqVHRwCczz7zbR2R/RIXmEzSQaATtnsmXaJ
         oq+A==
X-Gm-Message-State: APjAAAXjEBPaXoaCHL8dL35aoXdpfj1cvcUEA+dGoEPQns8XqBdltOE6
        h2hpEB+WyyR6SuXzemb0tP+jDT3RxVWUBhyKDaU=
X-Google-Smtp-Source: APXvYqw5ZDH1uFbKa9Uj0YQ831yEgReHltFqCjXKejrtBguLR3FrJeYcDphS9gPdAxGUTV4GnPfVciSQl/YtN9h9aOo=
X-Received: by 2002:a25:d64a:: with SMTP id n71mr10841661ybg.462.1557652825546;
 Sun, 12 May 2019 02:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <0ce0173a-78f0-ae69-05b2-8374fbe3ba37@huawei.com>
In-Reply-To: <0ce0173a-78f0-ae69-05b2-8374fbe3ba37@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 12 May 2019 12:20:14 +0300
Message-ID: <CAOQ4uxjVf5yTNpuj=6Yb9eXpUwALx3-4tmbFG9g_WKrtkWw7wA@mail.gmail.com>
Subject: Re: [Question] softlockup in __fsnotify_update_child_dentry_flags
To:     yangerkun <yangerkun@huawei.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        huawei.libin@huawei.com, Miao Xie <miaoxie@huawei.com>,
        suoben@huawei.com, Al Viro <viro@zeniv.linux.org.uk>,
        Waiman Long <longman@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 10, 2019 at 5:38 PM yangerkun <yangerkun@huawei.com> wrote:
>
> Hi,
>
> Run process parallel which each code show as below(ARM64 + 2T ram):
>
> #include<stdlib.h>
> #include<stdio.h>
> #include<string.h>
> #include<time.h>
>
>
> int main()
> {
>      const char *forname="_dOeSnotExist_.db";
>      int i;
>      char filename[100]="";
>      struct timespec time1 = {0, 0};
>      for(;;)
>      {
>          clock_gettime(CLOCK_REALTIME, &time1);
>          for(i=0; i < 10000; i++) {
>
> sprintf(filename,"/%d%d%d%s",time1.tv_sec,time1.tv_nsec,i,forname);
>              access(filename,0);
>              memset(filename,'\0',100);
>          }
>      }
>      return 0;
>
>
> }
>
> Sometimes later, system will report softlockup with stack:
>
> #10 [ffff00002ffc39f0] el1_irq at ffff000008083474
>       PC: ffff00000814570c  [queued_spin_lock_slowpath+420]
>       LR: ffff000008146ca4  [do_raw_spin_lock+260]
>       SP: ffff00002ffc3a00  PSTATE: 80000005
>      X29: ffff00002ffc3a00  X28: ffff802fa1f62f40  X27: 0000000000000002
>      X26: ffff00002ffc3bac  X25: ffff801fac95bd60  X24: ffff00002ffc3bb0
>      X23: ffff801fa8a9ce80  X22: ffff00002ffc3bb8  X21: 0000000000000002
>      X20: 0000000000d80000  X19: ffff801fa8a9ced8  X18: 0000000000000000
>      X17: 0000000000d80000  X16: 0000000000d80000  X15: 0000000000000000
>      X14: 0000000000000000  X13: 0000000000000000  X12: 0000000000000000
>      X11: 0000000000000000  X10: ffff801fa614c200   X9: ffff801ffbe68e00
>       X8: 0000000000000000   X7: ffff809ffbfd4e00   X6: 0000000000040000
>       X5: ffff00000976b788   X4: ffff801ffbe68e00   X3: ffff0000093c7000
>       X2: 0000000000000000   X1: 0000000000000000   X0: ffff801ffbe68e08
> #11 [ffff00002ffc3a00] queued_spin_lock_slowpath at ffff000008145708
> #12 [ffff00002ffc3a20] do_raw_spin_lock at ffff000008146ca0
> #13 [ffff00002ffc3a40] _raw_spin_lock at ffff000008d0da6c
> #14 [ffff00002ffc3a60] lockref_get_not_dead at ffff0000085abca8
> #15 [ffff00002ffc3a80] legitimize_path at ffff00000832aee0
> #16 [ffff00002ffc3ab0] unlazy_walk at ffff00000832b09c
> #17 [ffff00002ffc3ad0] lookup_fast at ffff00000832ba2c
> #18 [ffff00002ffc3b40] walk_component at ffff00000832bc30
> #19 [ffff00002ffc3bd0] path_lookupat at ffff00000832c5d8
> #20 [ffff00002ffc3c40] filename_lookup at ffff00000832e464
> #21 [ffff00002ffc3d70] user_path_at_empty at ffff00000832e67c
> #22 [ffff00002ffc3db0] do_faccessat at ffff000008317750
> #23 [ffff00002ffc3e40] __arm64_sys_faccessat at ffff00000831795c
> #24 [ffff00002ffc3e60] el0_svc_common at ffff000008097514
> #25 [ffff00002ffc3ea0] el0_svc_handler at ffff00000809762c
> #26 [ffff00002ffc3ff0] el0_svc at ffff000008084144
>
>
> We find the lock of lockref has been catched with cpu 40. And since
> there is too much negative dentry in root dentry's d_subdirs, traversing
> will spend so long time with holding d_lock of root dentry. So other
> thread waiting for the lockref.lock will softlockup.
>
> For this problem, thought?

IMO, this is DoS that can be manifested in several other ways.
__fsnotify_update_child_dentry_flags() is just a private case of single
level d_walk(). Many other uses of d_walk(), such as path_has_submounts()
will exhibit the same behavior under similar DoS.

Here is a link to a discussion of a similar issue with negative dentries:
https://lore.kernel.org/lkml/187ee69a-451d-adaa-0714-2acbefc46d2f@redhat.com/

I suppose we can think of better ways to iterate all non-negative
child dentries,
like keep them all at the tail of d_subdirs, but not sure about the implications
of moving the dentry in the list on d_instantiate().
We don't really have to move the dentries that turn negative (i.e. d_delete()),
because those are not likely to be the real source of DoS.

Thanks,
Amir.
