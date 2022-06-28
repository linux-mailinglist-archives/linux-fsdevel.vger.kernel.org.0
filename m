Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358D355E841
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346982AbiF1Nzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 09:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbiF1Nzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:55:38 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956CB30F7B;
        Tue, 28 Jun 2022 06:55:37 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id h38so12075171vsv.7;
        Tue, 28 Jun 2022 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PZRrLa/gPwlZue+iihv4jMpTjI+TnuHIQB9q2n8QmY=;
        b=M+buCNLkWBrtxZEBQcc3rM6oR4zXWbbDMmtzldqzYX8LfPZMw1gnPvDSDLkNBUZS7u
         rIuLEubKZ2QIULizoJmhFLGWfZh+HXp7LBuWsGLqycaX0DnNYuen6F9WDmjhTgpYwgQd
         gn+EdE4s/ggUl8LZ54UD8DNnfkbsGvoZdHoP7lm4OHG1AHAydfiLJrIOxDi0J7acoYn4
         BDeZFSPhKvbkxW7+2rVloPMTPR6kcjecs9iJmAqXnfqx7BeX1jl3RepzJE6xScgGeh2a
         w3ez5StsjqPwWtiMPtzKYGBp+DM7QyX07UpNop2jxXnSLnQo4/G4s+GTZpew5XR6vr19
         /vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PZRrLa/gPwlZue+iihv4jMpTjI+TnuHIQB9q2n8QmY=;
        b=uBkVJ0XPdpIiMnXAjVFlWz/FISZwTUt2A7gDao2TgEiLmFeK5eLLMpkEqArLIKAX35
         sbOc9bM6AEtSvH93MQa3FLt4A0QqIAyDc0swSqZARK8i7h8YY//5Kc8MEOzScvx10a66
         1d5hvrjsvl4GzsqKZIDMW0v5TFvMYp9e+aTP0rDd+kTIb+N5nsYXaPUvr7hd8tek1Cg3
         oPHMjTkXXD/U1ChIUzhp5sJ0/552x3lKYrPyV7Ox7o0iAeSt2BsEUlUNe4Ar223uXo9y
         AUamx+pn2+GfvCmp/IGwEP2kvEPYiZZX6W6a97zvm+XlvVsu8Kj+T7xqspM++EAKPIVJ
         ndwA==
X-Gm-Message-State: AJIora+RizbABiD9sG6M68eqeOYrD4qWlqDdYuntoGlXQjeGJpOZDH+2
        8IksIxAKi2VxagYbxb9U/8i8Wd+G7Ez5kuctdEY=
X-Google-Smtp-Source: AGRyM1shfa4wR7pziBusGHpnivBMbEG4eycmH+FjbLVz10Q0BEXDpZPb9janCInlZsR4yjIK9V/POOrH1fVkUvZ+J+8=
X-Received: by 2002:a67:c113:0:b0:354:3ef9:3f79 with SMTP id
 d19-20020a67c113000000b003543ef93f79mr2050138vsj.3.1656424536522; Tue, 28 Jun
 2022 06:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220628101413.10432-1-duguoweisz@gmail.com> <20220628104528.no4jarh2ihm5gxau@quack3>
 <20220628104853.c3gcsvabqv2zzckd@wittgenstein> <CAC+1NxtAfbKOcW1hykyygScJgN7DsPKxLeuqNNZXLqekHgsG=Q@mail.gmail.com>
 <CAOQ4uxgtZDihnydqZ04wjm2XCYjui0nnkO0VGzyq-+ERW20pJw@mail.gmail.com> <20220628125617.pljcpsr2xkzrrpxr@quack3>
In-Reply-To: <20220628125617.pljcpsr2xkzrrpxr@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jun 2022 16:55:25 +0300
Message-ID: <CAOQ4uxjbKgEoRM4DXBq0T3-jP96FCHjUY0PLsqVE0_s-hS3xLg@mail.gmail.com>
Subject: Re: [PATCH 6/6] fanotify: add current_user_instances node
To:     Jan Kara <jack@suse.cz>
Cc:     guowei du <duguoweisz@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duguowei <duguowei@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 3:56 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 28-06-22 15:29:08, Amir Goldstein wrote:
> > On Tue, Jun 28, 2022 at 2:50 PM guowei du <duguoweisz@gmail.com> wrote:
> > >
> > > hi, Mr Kara, Mr Brauner,
> > >
> > > I want to know how many fanotify readers are monitoring the fs event.
> > > If userspace daemons monitoring all file system events are too many, maybe there will be an impact on performance.
> >
> > I want something else which is more than just the number of groups.
> >
> > I want to provide the admin the option to enumerate over all groups and
> > list their marks and blocked events.
>
> Listing all groups and marks makes sense to me. Often enough I was
> extracting this information from a crashdump :).
>
> Dumping of events may be a bit more challenging (especially as we'd need to
> format the events which has some non-trivial implications) so I'm not 100%
> convinced about that. I agree it might be useful but I'd have to see the
> implementation...
>

I don't really care about the events.
I would like to list the tasks that are blocked on permission events
and the fanotify reader process that blocks them, so that it could be killed.

Technically, it is enough to list the blocked task pids in fanotify_fdinfo().
But it is also low hanging to print the number of queued events
in fanotify_fdinfo() and inotify_fdinfo().

Thanks,
Amir.
