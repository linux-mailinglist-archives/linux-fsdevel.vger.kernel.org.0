Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35CD52CC07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 08:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiESGg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 02:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiESGgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 02:36:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6472BE8;
        Wed, 18 May 2022 23:36:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k8so4109765qki.8;
        Wed, 18 May 2022 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1OyebEqky4Oe0zwnP9eg21l4J+bevlDJ8+xqEADNNM=;
        b=Z+ORlfWO/S1nKkRn+dn8DHEwJ5DYi8HR/X5RooNa6qUX/pd8EtZ9MzIV7hrefrVMWQ
         9pNQQ8rfly1X5xcKMfWn5ojjOlA4R6JscLMZKdIQBYwkywg5lJQ7/72ZAZG2+bfpQwPn
         FRRj9l/QNhQ3apC/Cd8hk8JjuGRjJ49yQKwgoPkPqztMvWyQWuBu9EcVqpxQ6kzfWmW6
         BJNqyDBlEQSW+6SCNAqV1Pz2wgFJ9ZqZdGdrNwMf7vIYU7zxDbXzFFiWIjD2xbeczsLp
         tqU+2ps2spTBx/YNuA+oG4ihNOLIzPO1CA1Ddxoj7U/JvGjq6r4Qcm6Oh4xIqXbqfAXi
         2kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1OyebEqky4Oe0zwnP9eg21l4J+bevlDJ8+xqEADNNM=;
        b=ItnVHnjM5p+akDY66fZG0t+qV5T6MDf6iTEsjfhOAgi/qk784mh/ykIacF/cfhasYD
         X6N2mPYBiJjkwzBp4ZxCtjMy3Xzw5puC+i5+6wFlkA46pyppgCuxQgTShsZDedO703li
         8shPNtJyZ8Yb3KgiBUMo/XoqQ+lkhbGJ1cUmFgQt5COm1Skw4EN7VfY/zB77ZIhw25M2
         MQYqimdrbqZkqLJ55woLylzxVzN+IFQ+J3lbJ3oyee270HkS8hmXpbwmnmmQd/oAczol
         Wx/U+kh9CIr7uiiQgLnceVE7PvdIJh5kdzZM0QX2Kh7jaOaj654Km36/iND99ocEdNNc
         Vrig==
X-Gm-Message-State: AOAM533V1NnVNDoNbpeI7mJUleDi3nbVoz9Ni94QdmSno97pEqPWObxx
        QjEhrL3jyek+bD8IuWu3nTfY7I6Mu43rLnDSzXE=
X-Google-Smtp-Source: ABdhPJw9M0Ywfk5vrY98XRwu85oOlt42KN+yVK4PM2g6rKV67xs7yIMXznAgkO7WMqoJo8E1DLshSDWFfjoc1H9UIHw=
X-Received: by 2002:a05:620a:2909:b0:6a0:472b:a30d with SMTP id
 m9-20020a05620a290900b006a0472ba30dmr2129359qkp.258.1652942213030; Wed, 18
 May 2022 23:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
In-Reply-To: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 May 2022 09:36:41 +0300
Message-ID: <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for expunges
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
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

[adding fstests and Zorro]

On Thu, May 19, 2022 at 6:07 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> I've been promoting the idea that running fstests once is nice,
> but things get interesting if you try to run fstests multiple
> times until a failure is found. It turns out at least kdevops has
> found tests which fail with a failure rate of typically 1/2 to
> 1/30 average failure rate. That is 1/2 means a failure can happen
> 50% of the time, whereas 1/30 means it takes 30 runs to find the
> failure.
>
> I have tried my best to annotate failure rates when I know what
> they might be on the test expunge list, as an example:
>
> workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
>
> The term "failure rate 1/15" is 16 characters long, so I'd like
> to propose to standardize a way to represent this. How about
>
> generic/530 # F:1/15
>

I am not fond of the 1/15 annotation at all, because the only fact that you
are able to document is that the test failed after 15 runs.
Suggesting that this means failure rate of 1/15 is a very big step.

> Then we could extend the definition. F being current estimate, and this
> can be just how long it took to find the first failure. A more valuable
> figure would be failure rate avarage, so running the test multiple
> times, say 10, to see what the failure rate is and then averaging the
> failure out. So this could be a more accurate representation. For this
> how about:
>
> generic/530 # FA:1/15
>
> This would mean on average there failure rate has been found to be about
> 1/15, and this was determined based on 10 runs.
>
> We should also go extend check for fstests/blktests to run a test
> until a failure is found and report back the number of successes.
>
> Thoughts?
>

I have had a discussion about those tests with Zorro.

Those tests that some people refer to as "flaky" are valuable,
but they are not deterministic, they are stochastic.

I think MTBF is the standard way to describe reliability
of such tests, but I am having a hard time imagining how
the community can manage to document accurate annotations
of this sort, so I would stick with documenting the facts
(i.e. the test fails after N runs).

OTOH, we do have deterministic tests, maybe even the majority of
fstests are deterministic(?)

Considering that every auto test loop takes ~2 hours on our rig and that
I have been running over 100 loops over the past two weeks, if half
of fstests are deterministic, that is a lot of wait time and a lot of carbon
emission gone to waste.

It would have been nice if I was able to exclude a "deterministic" group.
The problem is - can a developer ever tag a test as being "deterministic"?

Thanks,
Amir.
