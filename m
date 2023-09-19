Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE287A6480
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjISNLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjISNLi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:11:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92036F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:11:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bff936e10fso30622101fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695129091; x=1695733891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGy8O/c7tHA5r0iH2O6LljxMZAGjJAAY3hCKQmkXcwo=;
        b=fx9IeduXVZ8PaoPQQUb7HgTiZ+/V/cXaCMawTL9oKEyJm053J/NhEDk6Q+9HgTCGZl
         ZJ7sWLzMQ8/Z1o7Oe1GFatS1yXX8g4t3A1GnGOMemzI+3z/mE0WSKOLgTSAICzaonU85
         NgSVTiFhHY09drQx78eVbTBDESC8EwydMgaznSZ1fXqbbOBroQ0tg6XZgnuZKb3WfFH3
         wX1S45qQdrHNrA6ieQ/+QCGzByxlwr4VdqluE26o48tkvk/rBFrTJtjgLZdbf2pUMIao
         6mdNaQ/4BI5E64bb9zAj18FKf+MT5gzgpFDfuIyLKVj5VeBrcpHo3kLw5syXgkATius7
         jr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129091; x=1695733891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGy8O/c7tHA5r0iH2O6LljxMZAGjJAAY3hCKQmkXcwo=;
        b=qYyCQVbGw5ZvnlgYvWNlirhZ+kM2uGhY9gZQ586zB/bpWtRuxoXgamOyMwX0aosNuB
         MZXluqC+IBubEQQNdFfiu9hBPmyG53NJT186Ia39LHflnQ+jqsZokeejpBw6smP2cQjo
         YcUZ4yAx/51kqVOnumGRBiSgcFa5mdvgCXFzwRrFZ6h9hRdguddzuKp5RkkTvOAaARwr
         Y8Kxmr5AQd5+opblQixrYnNH/XSFl7IXelXzVFJRp0a+0vBdYLdyyqIRiN9326hn/zO/
         +8bDc9Hluy/QcnakD6pEWXUlkxoFsA0KwY35W4Z636wToK4eSKlI+EnZBfnPVWfHkf/Y
         5iVQ==
X-Gm-Message-State: AOJu0Yynu/8cSgAuBdD+xzqPeNSbGBpJqpKYx4S/B9CbgQ02Lj64N+3G
        UH5tuvabp8H0KdBmb8r3FVIs6/+6yofsQ6wS2glwCA==
X-Google-Smtp-Source: AGHT+IFoLJDB/zJyBGc/oO6qS+0fjzE6lJeOtSn75A9IILE1W0q1Nlzt9Utz5xVTwzGuRfsxBeVrMazwpu7Jbb1BoTI=
X-Received: by 2002:a05:651c:118c:b0:2bc:e94e:fda0 with SMTP id
 w12-20020a05651c118c00b002bce94efda0mr969341ljo.5.1695129090856; Tue, 19 Sep
 2023 06:11:30 -0700 (PDT)
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
 <CAKPOu+9ds-dbq2-idehU5XR2s3Xz2NL-=fB+skKoN_zCym_OtA@mail.gmail.com>
 <CAOQ4uxgvh6TG3ZsjzzdD+VhMUss3NLTO8Hk7YWDZs=yZagc+oQ@mail.gmail.com>
 <CAKPOu+_y-rCsKXJ1A7YGqEXKeWyji1tF6_Nj2WWtrB36MTmpiQ@mail.gmail.com> <CAOQ4uxhtfyt8v3LwYLOY9FwA46RYrwcZpZv7J8znn5zW-1N5sA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhtfyt8v3LwYLOY9FwA46RYrwcZpZv7J8znn5zW-1N5sA@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 15:11:19 +0200
Message-ID: <CAKPOu+8tCP+bRXFy0br3D7C8h5iHxBr+WoSfiMyBQnrYN8g7Uw@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:01=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> We do not add new system calls for doing something that is already
> possible with existing system calls to make the life of a programmer
> easier - this has never been a valid argument for adding a new syscall.

- it's not possible to safely add an inotify watch; this isn't about
making something easier, but about making something
safe/reliable/race-free in a way that wasn't possible before
- there are many precedents of new system calls just to add dfd
support (fchmodat, execveat, linkat, mkdirat, ....)
- there are also a few new system calls that were added to make the
life of a programmer easier even though the same was already possible
with existing system calls (close_range, process_madvise, pidfd_getfd,
mount_setattr, ...)
