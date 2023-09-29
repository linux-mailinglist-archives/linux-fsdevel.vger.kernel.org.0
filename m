Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35C7B3CDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 01:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjI2XDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 19:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjI2XDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:03:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D12E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 16:02:58 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c60128d3f6so54585ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 16:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696028578; x=1696633378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9BzlJqBcof6n6pTueaTjw4kqspqP+j9P0b11XcgH9M=;
        b=CnOULgSoeqtnG2DEUO92aN94BuTOfYs1ZZ+MDYf09bZOpvPdeCdrA2rdvSCOO8Nf0u
         JtWyTEI9s+G11oI9c0tH8XsypgGgTTUHiPsn8KoJaTcdpRD69uWn7Ejb6vWll1+c3t4t
         DH9u1UK3VGkxQILF97rWzZp0P+MBDLMAp5pZGQ10FnbeLFYnU5wVCluqW6Dy/OJQVyPM
         iTakiENrf3f613oXHaeFewGif0PpP/7DifAz5tBRttkYFmo2W34jO94yaPPc5s26Pg8r
         j5wDqFyFVxwPAcr+R/AQuDnvz+SHgBnaWc52SulMzzwmcON42aGd96z6NLTSVQo5cD1j
         TCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696028578; x=1696633378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9BzlJqBcof6n6pTueaTjw4kqspqP+j9P0b11XcgH9M=;
        b=qWSAGtMYcXIGxc72wPDg/fIXEKkh3wgQPl2X+ir3m7FKxbSFKEyW2iwA56nV+apZI0
         WSO+P2WcIGfXbWPcqRwV3lCAu9Ye9Nj42iNQebtQEqjbLh9fH6q4QIV+skNqXzsWfVr0
         1tTHEMo5LlkFPKtzwLAWxaKIYwrKXyHw9+o+FFXbUKyxuV9+nzdV0WMBRpL9iueYq+SW
         WzWS5o/5VBy6HwS0SxQ02Vakp8xG29x2nyNcfhyK6fzW9R/RUmUdfP7rgzDbrC89ai8m
         4xgNhxCUoo5XK3UuL6nke6oBmQXsUoR4/Z1vrUssi1OrHsWi0oU8SuQHKN8WUouHL7P8
         dTaQ==
X-Gm-Message-State: AOJu0Yw8sl9vojbyh0k70yWLi5LP4aFawnaG1HefKZCjOmfvh7GSvl+t
        vyzVqzct31MxC4sqHWEZLDlMwUBpb59WS4rg6QY3lQ==
X-Google-Smtp-Source: AGHT+IHuzxCPFg+yAg7bNAEuuY0F4OlEqd2dJ6C3ksfq4ULTTVvrtLlyYBq/2idpo+DkjFeEVmfJs3J0t6+FOH+Q3Ag=
X-Received: by 2002:a17:903:184:b0:1c2:446:5259 with SMTP id
 z4-20020a170903018400b001c204465259mr15735plg.19.1696028577492; Fri, 29 Sep
 2023 16:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZRR1Kc/dvhya7ME4@f> <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
 <20230928-kulleraugen-restaurant-dd14e2a9c0b0@brauner> <20230928-themen-dilettanten-16bf329ab370@brauner>
 <CAG48ez2d5CW=CDi+fBOU1YqtwHfubN3q6w=1LfD+ss+Q1PWHgQ@mail.gmail.com>
 <CAHk-=wj-5ahmODDWDBVL81wSG-12qPYEw=o-iEo8uzY0HBGGRQ@mail.gmail.com>
 <20230929-kerzen-fachjargon-ca17177e9eeb@brauner> <CAG48ez2cExy+QFHpT01d9yh8jbOLR0V8VsR8_==O_AB2fQ+h4Q@mail.gmail.com>
 <20230929-test-lauf-693fda7ae36b@brauner> <CAGudoHHwvOMFqYoBQAoFwD9mMmtq12=EvEGQWeToYT0AMg9V0A@mail.gmail.com>
 <ZRdOkpXUva8UHfEJ@casper.infradead.org>
In-Reply-To: <ZRdOkpXUva8UHfEJ@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 30 Sep 2023 01:02:21 +0200
Message-ID: <CAG48ez3QA7arOtjsUR1FJ_yqyXibK+uftdyrrB3=E0FAYz9g3g@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 12:24=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
> On Fri, Sep 29, 2023 at 11:23:04PM +0200, Mateusz Guzik wrote:
> > Extending struct file is not ideal by any means, but the good news is t=
hat:
> > 1. there is a 4 byte hole in there, if one is fine with an int-sized co=
unter
> > 2. if one insists on 8 bytes, the struct is 232 bytes on my kernel
> > (debian). still some room up to 256, so it may be tolerable?
>
> 256 isn't quite the magic number for slabs ... at 256 bytes, we'd get 16
> per 4kB page, but at 232 bytes we get 17 objects per 4kB page (or 35 per
> 8kB pair of pages).
>
> That said, I thik a 32-bit counter is almost certainly sufficient.

I don't like the sequence number proposal because it seems to me like
it's adding one more layer of complication, but if this does happen, I
very much would want that number to be 64-bit. A computer doesn't take
_that_ long to count to 2^32, and especially with preemptible RCU it's
kinda hard to reason about how long a task might stay in the middle of
an RCU grace period. Like, are we absolutely sure that there is no
pessimal case where the scheduler will not schedule a runnable
cpu-pinned idle-priority task for a few minutes? Either because we hit
some pessimal case in the scheduler or because the task gets preempted
by something that's spinning a very long time with preemption
disabled?
(And yes, I know, seqlocks...)
