Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE317A6115
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 13:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjISLWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 07:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISLWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:22:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D033F7
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 04:22:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso87776591fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695122527; x=1695727327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxr0g9QJnEAuUaDmoar9PC6+7zR9VeOGpFWUhb9wkTE=;
        b=MzrMZSZN009jYRLJ8bgoAC5wBnuCIMvvhW3xdsvg7/jLVGPAXLIzuKwIi0dKwb2wrc
         KCKq+h7VS3L8WR8rU1ZbTEwSwbibkIqqEhKGcOuVCKOtPTDcs5LnHL+7Fa80okU8PRjP
         lNjujLe4vRabFLvueWtPOyObiOsumZpziLmGa4zG6rfBr7/xLEOCZaIfwOhWOK3tr+5q
         6k255Bb0TauqdjGuH4VMzezBwfIEm603vj/scJH33rf0fggq1LVwH41zepI40f6OChEj
         AGPRtLRENMcCYU6d9ocX5KdKEif6IVxtxVXWoMNQtXwAF7YbBXlBJywYBz9lEHC/X8u4
         OM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695122527; x=1695727327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxr0g9QJnEAuUaDmoar9PC6+7zR9VeOGpFWUhb9wkTE=;
        b=KkJ8PlPWK8wMg7+CJZOHhJjfJmuQSMdfisTY83YRWMs7m8RDc5k+o9NAT23oOI+qdl
         7MRSRaGcwNPpB9pKAzJYPv+AY+DrqamfGMCMNUCtmkC+XOjwG4PJUHwcKd5Ohfiakn7G
         JEOiPQ2oyo+IplYCNCzChE9UHm0hOJAAvR9nmn8B04YKbTZipVp2NGcqD7wwxCAPAFc5
         NOLUh/uU4IGlZWeUAsDVVc1mw/Jj5bLXFGZ3pHdEi4JzajQCzpYNCWPbsddD94ejLKqk
         R+pbH43nP8pHX/Um74iEMPxSOYmO2vYTD50l05/gNO/9sy8+45IFOFhikPRmhp5NPWVa
         b+wg==
X-Gm-Message-State: AOJu0YzaOTCxNz4XNEJ7gqKKtMGtqKlxjAnxvwzFyfDBsEgrVOQdYf5J
        0yiqjEKlFXQ21EVX6+OVBKrVrPp2ow7j7jcSL7nV1g==
X-Google-Smtp-Source: AGHT+IHR50NEkB3piP/yQTcJ2TebuvdCdBfzNmIQLZ1SvugIhuCFPmRLnzjBBw/SYuivtE0/hH8GOYzDRWCWTIVKxok=
X-Received: by 2002:a2e:3008:0:b0:2c0:2b44:6ebe with SMTP id
 w8-20020a2e3008000000b002c02b446ebemr1092028ljw.13.1695122527429; Tue, 19 Sep
 2023 04:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
 <20230919100112.nlb2t4nm46wmugc2@quack3> <CAKPOu+-apWRekyqRyYfsFkdx13uocCPKMzYJqmTsVEc6a=9uuA@mail.gmail.com>
 <CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com>
In-Reply-To: <CAOQ4uxgG6ync6dSBJiGW98docJGnajALiV+9tuwGiRt8NE8F+w@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 13:21:56 +0200
Message-ID: <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:59=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> Any API complexity can be hidden from users with userspace
> libraries. You can use the inotify-tools lib if you prefer.

That doesn't convince me at all, but that's a question of taste. We'll
just keep using inotify (with a patched kernel, which we have anyway).

> > Getting an already-opened file descriptor, or just the file_handle, is
> > certainly an interesting fanotify feature. But that could have easily
> > been added to inotify with a new "mask" flag for the
> > inotify_add_watch() function.
> >
>
> "could have easily been added" is not a statement that I am willing
> to accept.

Are you willing to take a bet? I come up with a patch for implementing
this for inotify, let's say within a week, and you agree to merge it?

(I'm not interested in this feature, I won't ever use it - all I
wanted is dfd support for inotify_add_watch()).

> The things that you are complaining about in the API are the exact
> things that were needed to make the advanced features work.

Not exactly - I complain that fanotify makes the complexity mandatory,
the complexity is the baseline of the API. It would have been possible
to design an API that is simple for 99% of all users, as simple as
inotify; and only those who need the advanced features get the
complexity as an option.

I don't agree with your point that unnecessary complexity should be
mitigated by throwing more (library) code at it. That's just adding
more complexity and more overhead, the opposite of what I want.

Max
