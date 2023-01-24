Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91AC67A0AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 18:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjAXR6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 12:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjAXR63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:58:29 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84E46159;
        Tue, 24 Jan 2023 09:58:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q8so12078234wmo.5;
        Tue, 24 Jan 2023 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pHojIfH7mPoYEvGud+s1TGzI5a9ONBh3yI2E9bhxwuE=;
        b=DAnTpjO0/mkgf9pkRLf5wRr7TAchsXeFYnhq0fR9DRc/d+sK+yvQun8QF19rWy/6fJ
         hC3zTLccF9TP0ov6gVwGegZ3/aCT3TxBu6W6leXwM3P3gtt71Wc/gvpYnRBUgj5nwwbt
         Zm6uUdlKkhslLh97iR0znrLiOlUOKWd/+tMXvBlgFOp3ibg6vb5XoMIu/Y1rpUeXS/Yp
         s/05fWK8vHJExnNypvM1Pj2NQdS3YWabasBIZ4TJMkgC6OKIgWnTG3uZ3bh5abA7k/8z
         BzOAI8zj4JrtdVQESAbib2P1kpCGHPqoOLs9WaXKv+myXgqcKIXq5UiXPiej44SWUdfT
         8/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHojIfH7mPoYEvGud+s1TGzI5a9ONBh3yI2E9bhxwuE=;
        b=rJDsxWpqB6YVsNrlxOO4qsjr/6ahi4uCpiE8dyOvdJliIabSTaxmC5+4PP+jPCImJL
         MybPLiHmlQ5Y+cyZkkMRzIr/jLmCN0bP+aA/Xft9yvMqEBGgzeodhQoJ5db3tCj1jLL+
         HHZEybyPl3OX7zYME4VyQW6KM2wlvGy9NgjggM6kRgEJj48YJFpuiwkPg/3L1v5yAk7R
         3hm+lf2ONVKK5DVrKF2CkxMM9T51YzDe7dsH3JaDWXwhNANv3c46Bq8VfPsjb86slCTw
         ROMxknBitwWhgVi6LV+Z4Ghg78KIQ/gB/fdOUSuaN37gKzS4v3NmAqg+wWzuKsmoQroq
         HZuA==
X-Gm-Message-State: AFqh2kovtignvKzGuYmX/SC3Yb0I5UxVIqP2haBxRtf8a/V15c1OkxmL
        V1ozZyL1mk2cLUfq42ZfKTfnjfdF3Hh4NzUyjzg=
X-Google-Smtp-Source: AMrXdXtlfu8opsQ0soNTGE9/M+8iwAgYCCDH4vkFL3mYltaU7lG78XFHRvBuGsDBaq++OIafyW9ieDeyeLqqlS5BZuI=
X-Received: by 2002:a05:600c:47cf:b0:3cf:b1c2:c911 with SMTP id
 l15-20020a05600c47cf00b003cfb1c2c911mr1887357wmo.16.1674583106429; Tue, 24
 Jan 2023 09:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20230123032942.18263-1-gregory.price@memverge.com>
 <20230123032942.18263-4-gregory.price@memverge.com> <20230123154101.GA6268@redhat.com>
 <Y87OEdDXwZG8pmmE@memverge.com> <20230123195228.GD6268@redhat.com>
 <Y9AAcuomaVM2JRCA@memverge.com> <20230124164347.GA28280@redhat.com> <Y9ANOfzl+iZSBIEP@memverge.com>
In-Reply-To: <Y9ANOfzl+iZSBIEP@memverge.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Tue, 24 Jan 2023 09:58:02 -0800
Message-ID: <CANaxB-wASWa1k6X5umJ=wt-K47uiBo9N5hxc--xz5cmU2bvysA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ptrace,syscall_user_dispatch: add a getter/setter for
 sud configuration
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 8:54 AM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Tue, Jan 24, 2023 at 05:43:47PM +0100, Oleg Nesterov wrote:
> > I won't really argue, but...
> >
> > On 01/24, Gregory Price wrote:
> > >
> > > On Mon, Jan 23, 2023 at 08:52:29PM +0100, Oleg Nesterov wrote:
> > > > On 01/23, Gregory Price wrote:
> > > > >
> > > > > So i think dropping 2/3 in the list is good.  If you concur i'll do
> > > > > that.
> > > >
> > > > Well I obviously think that 2/3 should be dropped ;)
> > > >
> > > > As for 1/3 and 3/3, feel free to add my reviewed-by.
> > > >
> > > > Oleg.
> > > >
> > >
> > > I'm actually going to walk my agreement back.
> > >
> > > After one more review, the need for the proc/status entry is not to
> > > decide whether to dump SUD settings, but for use in deciding whether to
> > > set the SUSPEND_SYSCALL_DISPATCH option from patch 1/3.
> >
> > Rather than read /proc/pid/status, CRIU can just do
> > PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG unconditionally
> > and check syscall_user_dispatch_config.mode ?
> >
> > Why do want to expose SYSCALL_USER_DISPATCH in /proc/status? If this task
> > is not stopped you can't trust this value anyway. If it is stopped, I don't
> > think ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG) is slower than reading
> > /proc.
> >
> > but perhaps I missed something?
> >
> > Oleg.
> >
>
> *facepalm* good point, i'm wondering if there's a reason CRIU doesn't do
> the same for SECCOMP.

Because information about seccomp was in /proc/pid/status forever and we
started using it before the ptrace interface was merged. I am not sure that
this is the only reason, but  it is definitely one of them.

>
> either way, going to drop it
