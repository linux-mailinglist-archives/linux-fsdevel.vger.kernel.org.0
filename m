Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87314D8B18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 18:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiCNRwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbiCNRwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:52:24 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4DF13F1A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 10:51:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id v75so9339392oie.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wn8hm9UElH+SgEeKg7n3dJ9PkAEuPfHXFh8ZNIAwTGk=;
        b=Z9CzWSg1WGLUabIHMMJH5f/0q4DgOAV8OuwRSCXuVpgzk5gaHQodnUc2xTf5JahNYj
         KKSNgqPj71DNsYJEsxMsnyUt8vH9k+X+k6cKZwkCQ5c5qvKz6KSt/S+Zr3FHjh1iNBxW
         VZjuWXyBJvsiEi2P0cxyN6kgOvJqCIkKfHS3un+b8kXnf4J8EBrkQi0CJg1WRLJDZHNR
         1nr1RjDuVB9zYRUFiwbiz1thsujgRlKB5NRxHDM0SeXROs7ulO8M1oqHCaaK654TvOty
         olXMm68Si7FszRKDswp5Y8AMDot1HfIzb0Uh16d6AS/i2k5JWcQ6ECy+lXatie8QIr9E
         PESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wn8hm9UElH+SgEeKg7n3dJ9PkAEuPfHXFh8ZNIAwTGk=;
        b=gGVMw+brSZ6TuqeS1BAET+xTASGrl0h1ZU1Dz3ACdwpqasGT10q+0XbXe5f840Hvoc
         ioUNGRQJRvxhVYS6Za0FqCpwGncpb76jxzeohXOKdJeXsH1zHbjp0bpOGic/04/uwNe6
         d+9/P1bwTXAQ4LrMG5uUxSUYh3mvCWk7kFhu1rdvcLLJXm0+h+dpsq+eezYzup/07K0g
         aCzExjDlbuwmAuIBX3gL/QJRUoR78pWP14btBLu192FhhDU5lnoex8Iu3cVcyEoan9GF
         wam5VktTvd1SKS61PJ6PPi/8hJgIwmdA+DXUh9S166KoQEl4OVGavle8tvDAxU+31BG2
         pEUg==
X-Gm-Message-State: AOAM532tlMCf+vFEJmjOdmG+imxLtHDov+lyyHBrgh2J77yajOu6Nxx2
        k+ZZYx2g7hv14lKi/7EpGct8ugcbT1bd+y23fCo=
X-Google-Smtp-Source: ABdhPJwXkjLBSDNNf1W9JF9GHQav/vDumqV6yz8gYkehoM7l9s1+lSWJKWy9yXf12CVLxQe3lsQYcFcvV21tO65pVk0=
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id
 bq1-20020a05680823c100b002da30fd34d9mr151356oib.203.1647280271873; Mon, 14
 Mar 2022 10:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan> <1255823004.1416038.1647279152879@mail.yahoo.com>
In-Reply-To: <1255823004.1416038.1647279152879@mail.yahoo.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 14 Mar 2022 19:51:00 +0200
Message-ID: <CAOQ4uxhaD+v1=Qi_pA9z5EJYAW63TM5E8bqsNaCe+-2ZNB=KUw@mail.gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using FAN_MARK_MOUNT
To:     Srinivas <talkwithsrinivas@yahoo.co.in>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 14, 2022 at 7:32 PM Srinivas <talkwithsrinivas@yahoo.co.in> wro=
te:
>
> Thanks Amir/Jan.
> Apart from the directory exclusion i called out, i think  from a anti-vir=
us agent side, what would be good to have is the ability to add a mark for =
FAN_MARK_MOUNT but then additionally ignore an entire subtree of directorie=
s under the mount point.  Basically express interest in everything but then=
 ignore (trust) some root only writeable directories etc.
> Can this be done today?
> My experiments again show that it is not. Thoughts?
>

You can do something similar with volatile exclude marks [1]
You can grab my branch for testing from [2]

What you do is create the exclude marks lazily -
you can an event, see that it is under the trusted subtree and you call:

fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_CREATE | FAN_MARK_VOLATILE,
                       FAN_EVENT_ON_CHILD,
                       AT_FDCWD, "/trusted/foo/");
fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
                       FAN_MARK_IGNORED_SURV_MODIFY,
                       FAN_OPEN_PERM | FAN_CLOSE_WRITE,
                       AT_FDCWD, "/trusted/foo/");

Then you won't get further events until /trusted/foo is not accessed
for a while and memory pressure evicts its inode, then on next access
to /trusted/foo you will get an event, set the volatile ignored mask again.

Let me know if you think that is useful for AV agents
and if not, please let me know why not.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20220307155741.1352405-1-amir73il=
@gmail.com/
[2] https://github.com/amir73il/linux/commits/fsnotify-volatile
