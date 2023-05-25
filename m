Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62645711A4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjEYWqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 18:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEYWqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 18:46:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E189E;
        Thu, 25 May 2023 15:46:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3b9c88af8so22660e87.2;
        Thu, 25 May 2023 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685054767; x=1687646767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/w8kourG8muqgM1V9FJPeJXvMt9bhE45UC3UnTkiIWE=;
        b=rhJxDpWledyLUcsCRXUfcDSoiNMB74XAdor4Y1RM8XQMWeYu7p0EoitLH7+fDL6Pij
         JSF8JZibfbgbJEodyC8jDeF/6uzIgA4HZxsGnHnn/LRcBA74eyTp0uWUndgHavuciFrV
         zv1eeEuIpHouiaSjhbG5qcFlcwSDe6um9+ZFtrobySCMYjOoFPlezRrVKDGD6QkhH1ng
         3v1F2LPl5wIVz8oHEx3kTgMatJhI4eAhRQ4J0Ab39l5qdAzQR5Hzq4xZv2XbSiRs7Wjr
         cyDOhaEFv+ygaS3ulzo166W2y2QVqX7/mhDxSc0qdVKxmg9reaqLlkak0Q7LgoICwIPs
         Q0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685054767; x=1687646767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/w8kourG8muqgM1V9FJPeJXvMt9bhE45UC3UnTkiIWE=;
        b=iDy1hysXXct/GY3bAgZSCHlqeukZ+BoYd9E6YA9LeHd0TF/q3G9yN8SAzZvpKEXit6
         ZW2D10T/O4yce37BynSHuThZxXHQb7/ie1HuZICVWHXDhFcP4PmB/0G35oB6o5+f7q0c
         OiZGLGDL5qghCyMk99cuy9/ukvQ/7s9iCbSZjgUXgeTIH8BPmoIXOFPxO9jS6t3yFCX+
         TB310RVXHo7jAqi7o6QT3SeV4g00K92ORTk1h4OWqcefLFKYTxKqKLsqDx8Pp15ANvNP
         cdwhNlTkx/QJNiWYL7fLGZ74xdzdlVazAAlwyUMSlvLhh1ZtdttZD8WPCFGhtiwv8kCu
         IerA==
X-Gm-Message-State: AC+VfDyrc+OHI5E4oWT6MR2qbZBbtrBgaQcDy4f7y5Kpv7lin4AutjJ6
        i0/O5AhDkJcFvUF6CxLXB5JfUtbbRkKEW7PHNgo=
X-Google-Smtp-Source: ACHHUZ4VB2AEvZmEKL/ToOYQHq7bNrYU7r6ytuAfwSAkDgHAxv18Bh8nagqgxi77E7DS39/2qAzMZ2yLDzeqZIfKhy0=
X-Received: by 2002:a05:6512:25a:b0:4e9:bafc:88d0 with SMTP id
 b26-20020a056512025a00b004e9bafc88d0mr6824592lfo.23.1685054766774; Thu, 25
 May 2023 15:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-7-kent.overstreet@linux.dev> <20230510010737.heniyuxazlprrbd6@quack3>
 <ZFs3RYgdCeKjxYCw@moria.home.lan> <20230523133431.wwrkjtptu6vqqh5e@quack3>
 <ZGzugpw7vgCFxOYL@moria.home.lan> <20230525084731.losrlnarpbqtqzil@quack3>
In-Reply-To: <20230525084731.losrlnarpbqtqzil@quack3>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 26 May 2023 00:45:55 +0200
Message-ID: <CAHpGcMLzYG9RemHsnigj+5e1x0-_Sobra_k7N-tXLkcvEuoYXw@mail.gmail.com>
Subject: Re: [PATCH 06/32] sched: Add task_struct->faults_disabled_mapping
To:     Jan Kara <jack@suse.cz>
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>, dhowells@redhat.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, Bob Peterson <rpeterso@redhat.com>
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

Am Do., 25. Mai 2023 um 10:56 Uhr schrieb Jan Kara <jack@suse.cz>:
> On Tue 23-05-23 12:49:06, Kent Overstreet wrote:
> > > > No, that's definitely handled (and you can see it in the code I linked),
> > > > and I wrote a torture test for fstests as well.
> > >
> > > I've checked the code and AFAICT it is all indeed handled. BTW, I've now
> > > remembered that GFS2 has dealt with the same deadlocks - b01b2d72da25
> > > ("gfs2: Fix mmap + page fault deadlocks for direct I/O") - in a different
> > > way (by prefaulting pages from the iter before grabbing the problematic
> > > lock and then disabling page faults for the iomap_dio_rw() call). I guess
> > > we should somehow unify these schemes so that we don't have two mechanisms
> > > for avoiding exactly the same deadlock. Adding GFS2 guys to CC.
> >
> > Oof, that sounds a bit sketchy. What happens if the dio call passes in
> > an address from the same address space?
>
> If we submit direct IO that uses mapped file F at offset O as a buffer for
> direct IO from file F, offset O, it will currently livelock in an
> indefinite retry loop. It should rather return error or fall back to
> buffered IO. But that should be fixable. Andreas?

Yes, I guess. Thanks for the heads-up.

Andreas

> But if the buffer and direct IO range does not overlap, it will just
> happily work - iomap_dio_rw() invalidates only the range direct IO is done
> to.
>
> > What happens if we race with the pages we faulted in being evicted?
>
> We fault them in again and retry.
>
> > > Also good that you've written a fstest for this, that is definitely a useful
> > > addition, although I suspect GFS2 guys added a test for this not so long
> > > ago when testing their stuff. Maybe they have a pointer handy?
> >
> > More tests more good.
> >
> > So if we want to lift this scheme to the VFS layer, we'd start by
> > replacing the lock you added (grepping for it, the name escapes me) with
> > a different type of lock - two_state_shared_lock in my code, it's like a
> > rw lock except writers don't exclude other writers. That way the DIO
> > path can use it without singlethreading writes to a single file.
>
> Yes, I've noticed that you are introducing in bcachefs a lock with very
> similar semantics to mapping->invalidate_lock, just with this special lock
> type. What I'm kind of worried about with two_state_shared_lock as
> implemented in bcachefs is the fairness. AFAICS so far if someone is e.g.
> heavily faulting pages on a file, direct IO to that file can be starved
> indefinitely. That is IMHO not a good thing and I would not like to use
> this type of lock in VFS until this problem is resolved. But it should be
> fixable e.g. by introducing some kind of deadline for a waiter after which
> it will block acquisitions of the other lock state.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
