Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C73179113D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 08:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348928AbjIDGJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 02:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjIDGJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:09:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CB6DE;
        Sun,  3 Sep 2023 23:09:05 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-573675e6b43so827189eaf.0;
        Sun, 03 Sep 2023 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693807745; x=1694412545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow7q3YrPUF4rmCouRThEW+Kvbo87wf7uRShpFG7WQ+4=;
        b=FTZZzQ1hkqNqlxHjwmumOCgG1LSPjmRGg1sCovIgjoBwBBISpkW8gcxD+6GvcoAGlC
         BgYhLrGHrAnVrHDWvoXN7QpFfL3nqPhUAtVJNQLaqZXBrV7WwIqJasgwDdxrvWVxw5vV
         V29D709GadLFeZIkZZkdO71uGsUSTqjw4t+vZVb50qlUrDFz69OaHsPdU+iiTOflQ4av
         3Gg6k2clDbTr5YDTXeZ7WWkKTZZ0jgxnO5sRbiTGu7UChWZ3TIuQ/ZljGX0MuwVzcPB9
         3tfDmv4mfHyGmsK+XVMjqPbfGfWYBjHTHuauZrZnWzY7rYPmPO1dIT+nhfnatyUBTxSI
         r7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693807745; x=1694412545;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow7q3YrPUF4rmCouRThEW+Kvbo87wf7uRShpFG7WQ+4=;
        b=Et25eOHzcZNJ+/S8BzPJ90I+dycnRpx7b+m1mpRxenVd2Dyl2tA3mzZk6sxgmuBZSM
         bImYqCnp3Jirl2DE8x3JkbwyqQYw0cfGVQttGvMKaA4u39OUtrEafbYdWQ91R64BRcEP
         xqx4jG93eKr3yG1+Ic1t6DaYESwIkgqLo6lkQHrMIKlGWGGweLV1pVHY4BGbKfS7972F
         LZ/t7dukjW5enCAW/DNOtNyiDIrlWb6gghD1KUw6PWXdRsZn+3cAF3FvKLiDAL4Rt098
         /ZJ4cXHJHJUmnhzVYmv86Sagpwpx603We/9UY5nLO64hUpZn45DsMp2AgO3aQsdT8s6l
         nuig==
X-Gm-Message-State: AOJu0YxAJXHePUmtuI62yIQq0E3Xomw9j/6vPuObOiqgDx7V3KIORktj
        D8KWY26TmqFCsgqqGfURfz4HRxJPDHCLEnwp73o=
X-Google-Smtp-Source: AGHT+IG3nFFAktlP9gmDSjBy/AiFL1SeCq2TBV9/SIjBnmsOMwtrgoMqg4CTLO3DAnZc3DUpprjq7FXCKzDH/DjnUXw=
X-Received: by 2002:a4a:8089:0:b0:56e:466c:7393 with SMTP id
 z9-20020a4a8089000000b0056e466c7393mr7339052oof.5.1693807745127; Sun, 03 Sep
 2023 23:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Sun, 3 Sep 2023
 23:09:04 -0700 (PDT)
In-Reply-To: <20230904032658.GA701295@mit.edu>
References: <000000000000e6432a06046c96a5@google.com> <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f> <ZPUIQzsCSNlnBFHB@dread.disaster.area>
 <20230903231338.GN3390869@ZenIV> <ZPU2n48GoSRMBc7j@dread.disaster.area> <20230904032658.GA701295@mit.edu>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 4 Sep 2023 08:09:04 +0200
Message-ID: <CAGudoHGtPOj-HpA25nAkQFmth0F=6WpMFbaqSuu+b34vd243SQ@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/4/23, Theodore Ts'o <tytso@mit.edu> wrote:
> On Mon, Sep 04, 2023 at 11:45:03AM +1000, Dave Chinner wrote:
>> Entirely possible - this is syzbot we are talking about here.
>> Especially if reiser or ntfs has been tested back before the logs we
>> have start, as both are known to corrupt memory and/or leak locks
>> when trying to parse corrupt filesystem images that syzbot feeds
>> them.  That's why we largely ignore syzbot reports that involve
>> those filesystems...
>>
>> Unfortunately, the logs from what was being done around when the
>> tasks actually hung are long gone (seems like only the last 20-30s
>> of log activity is reported) so when the hung task timer goes off
>> at 143s, there is nothing left to tell us what might have caused it.
>>
>> IOWs, it's entirely possible that it is a memory corruption that
>> has resulted in a leaked lock somewhere...
>
> ... and this is why I ignore any syzbot report that doesn't have a C
> reproducer.  Life is too short to waste time with what is very likely
> syzbot noise....  And I'd much rather opt out of the gamification of
> syzbot dashboards designed to use dark patterns to guilt developers to
> work on "issues" that very likely have no real impact on real life
> actual user impact, if it might cause developers and maintainers to
> burn out and quit.
>
> Basically, if syzbot won't prioritize things for us, it's encumbent on
> us to prioritize things for our own mental health.  And so syzbot
> issues without a real reproducer are very low on my priority list; I
> have things I can work on that are much more likely to make real world
> impact.  Even ones that have a real reproducer, there are certain
> classes of bugs (e.g., "locking bugs" that require a badly corrupted
> file system, or things that are just denial of service attacks if
> you're too stupid to insert a USB thumb drive found in a parking lock
> --- made worse by GNOME who has decided to default mount any random
> USB thumb drive inserted into a system, even a server system that has
> GNOME installed, thanks to some idiotic decision made by some random
> Red Hat product manager), that I just ignore because I don't have
> infinite amounts of time to coddle stupid Red Hat distro tricks.
>

Hello everyone.

When I first stumbled upon this report I was almost completely
oblivious to syzbot vs fsdevel -- I only knew you guys are not fond of
ntfs reports, which made sense but was not indicating there are much
bigger issues.

Given this and other responses I poked around the history and that
made it apparent there are long-standing non-technical problems going
here, none of which I intend to deal with.

That is to say I'm bailing from this thread.

Cheers and sorry for poking the nest,
-- 
Mateusz Guzik <mjguzik gmail.com>
