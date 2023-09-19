Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9AF7A5D6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 11:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjISJIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 05:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISJIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:08:41 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C361F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 02:08:35 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso47092441fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695114513; x=1695719313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr6YqgTf+tI4+iLdsHcAw8XH4SGBeT5+8DAb392RXeE=;
        b=QTezz27+ajjBNkIB5ToJnRMdLNyNs/hqLhUW5Rx0fh9AqmF7vvJAH4dZ5O+dvv25/k
         +Mmv/oK8eKjPuB1Nyfm8norGmz3u+4v0MKQC8kkbKSDwytdeJok1WrM6vF5DpHwuopbd
         Zi2qNRzqyvoRcye7k12i3vw5aORAFUW71DzBqdTsraAeffUMch6QLpXdpozvbibRj1PY
         TY6PhMSbovuq7PE5p+JkgpKFP/RG9PW7QGbIRCpriPTJ/YJETKfzdwc0buLiWxj0/S+g
         5FdNSR6zBpNRUFafH7DC9tiYR8NvPmffLmA5ZL35fZmYJ1dKKYRzBuVfNgI8ipv8Bvec
         MbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114513; x=1695719313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr6YqgTf+tI4+iLdsHcAw8XH4SGBeT5+8DAb392RXeE=;
        b=W9g2FICgqm9DJOMPFpb9Jej0RgnDAm6eT8tHbzCdvduTcPwdekFm6JgTvEZu8PQZqE
         eIS/MMNZd5balN24iw25AsUCw4lZW0VMooSjtUb4g8PtrSxmB09+E3n0VEhHBqVSa2RJ
         /QjIofHZ+jrsukzfvPHw+FXDbJOCQZmMpMtSxjAtij0KhX5uEi7zqMW5kqnrs152c8kJ
         v14K2EdJ2a/mUdmV1qQ9sPcWLXZP8/MRZNQx1iVShb4PzygTJCjgEvWcrAOYNORi04G+
         XJqiD7hbIE5nbAOvWlOBsbG3xiGPq7LUTh4z+94Bj2L/tzzO0BhaDrnC/f2HiBdsTl0R
         iaUw==
X-Gm-Message-State: AOJu0YwqYw/jYoDeuiPRcBqz2LLCKhU9310va1OiftobvjtFYQ8uC8fn
        DpUJqAX+9Zn7iOkx5oT0XI0eB59MaW/Zva4VKggTHA==
X-Google-Smtp-Source: AGHT+IFkgPts+eg7SxmzxG6YCSsD/TAaeLzoA1/fpPtgXSaLdUtiM9AsldgLsJPmT0r1ioGtvhi0hCkNrAW95Hqdzdo=
X-Received: by 2002:a2e:3614:0:b0:2b9:f1ad:9503 with SMTP id
 d20-20020a2e3614000000b002b9f1ad9503mr10512614lja.35.1695114513252; Tue, 19
 Sep 2023 02:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com> <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 11:08:21 +0200
Message-ID: <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 9:17=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> This was just fixed by Ivan in commit:
> 0ce7c12e88cf ("kernfs: attach uuid for every kernfs and report it in fsid=
")

Indeed, nice to see this will soon be fixed.

> As my summary above states, it is correct that fanotify does not
> yet fully supersedes inotify, but there is a plan to go in this direction=
,
> hence, inotify is "being phased out" it is not Obsolete nor Deprecated.

I agree that if inotify is to be phased out, we should concentrate on fanot=
ify.

I'm however somewhat disappointed with the complexity of the fanotify
API. I'm not entirely convinced that fanotify is a good successor for
inotify, or that inotify should really be replaced. The additional
features that fanotify has could have been added to inotify instead; I
don't get why this needs an entirely new API. Of course, I'm late to
complain, having just learned about (the unprivileged availability of)
fanotify many years after it has been invented.

System calls needed for one inotify event:
- read()

System calls needed for one fanotify event:
- read()
- (do some magic to look up the fsid -
https://github.com/martinpitt/fatrace/blob/master/fatrace.c implements
a lookup table, yet more complexity that doesn't exist with inotify)
- open() to get a file descriptor for the fsid
- open_by_handle_at(fsid_fd, fid.handle)
- readlink("/proc/self/fd/%d") (which adds a dependency on /proc being moun=
ted)
- close(fd)
- close(fsid_fd)

I should mention that this workflow still needs a privileged process -
yes, I can use fanotify in an unprivileged process, but
open_by_handle_at() is a privileged system call - it requires
CAP_DAC_READ_SEARCH. Without it, I cannot obtain information on which
file was modified, can I?
There is FAN_REPORT_NAME, but it gives me only the name of the
directory entry; but since I'm watching a lot of files and all of them
are called "memory.events.local", that's of no use.

Or am I supposed to use name_to_handle_at() on all watched files to
roll my own lookup? (The name_to_hamdle_at() manpage doesn't make me
confident it's a reliable system call; it sounds like it needs
explicit support from filesystems.)

> > (By the way, what was not documented is that fanotify_init() can only
> > be used by unprivileged processes if the FAN_REPORT_FID flag was
[...]
> I find this documentation that was written by Matthew very good,

Indeed! That's my mistake, I missed this section.

> FAN_REPORT_FID is designed in a way to be almost a drop in replacement
> for inotify watch descriptors as an opaque identifier of the object, exce=
pt that
> fsid+fhanle provide much stronger functionality than wd did.

How is it stronger?
