Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F14D78F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 01:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiCNAq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 20:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiCNAq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:46:26 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D69FF1;
        Sun, 13 Mar 2022 17:45:17 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g8so8025800qke.2;
        Sun, 13 Mar 2022 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=FlO9lRSif9R0Ug2qEV/f8XSLIrBLxhJkXCqFTBoTWrA=;
        b=bdht0hIYg+WW0B8vDZN6/fJB2X/reM+mCINwO5nriVdIoBNK0R/dFwhcCCGvFq4zHo
         Upf6mmrH8Liw/L4Uct6zXHjgeTZ0WB2Bp+Ury5gBYTXSOOLYgbcikLkoka4G+MO2lrkG
         FJDfUxUhM50B38HSLQgYj4bxfqV3I/OpN3cE8/56ObAtxQIEbfjaq6D2mD2nsJokCgnC
         M7ensqvbEK+L2AKRedDE57KMJrHz1u0B8qut8y5JFgw/NbYoE5fHMrHyWLt6KbTYQx9+
         JxuVd0QFBgZE0zzoeoZV1BhpytMlZTMW2aYQ9FvSHpcgdJWm+RuiJ/HA6nEWcbJcrgY6
         7Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=FlO9lRSif9R0Ug2qEV/f8XSLIrBLxhJkXCqFTBoTWrA=;
        b=W6h3Ul5eJXBrR7xKtMAg+abZT2uFIFyqYjNKTHuNv5po3YrYnTT7uc1FTlB/VB96Mu
         mQBfUmTdal9O0C0YMDVgZGpNjkNs/BtFpwj9PpF9t/a/TwEZSmQ/QOX9ApF9yHyS7q2/
         rsBI7Fx5totqvOUHSGMUQp/xDMD/3N8yLcYWaafPLEAh9ptBf1EPmxrOSQN1M6BO9HiY
         uwjyeGZrb5p6WrTAay6wE95/MMRVsUPf0KDVPqBJYyU3E+q8mM3ZmKuRQD3LTWhRhjfi
         ThSSf5F+SwejdjXoPztqTM8o27h5RcMPbjyxr58IxuceaSiVVZPYih7i1wwhfkWbKjbp
         tXpg==
X-Gm-Message-State: AOAM5309ZIeA+4zEmlKwQNLIVQo4HCX/HPsjIS2/tqd8yNZ+Ytny1WyD
        PSRgpGHOn5MG9k9C2u7KsKoAx8r5wA==
X-Google-Smtp-Source: ABdhPJxqMcHdGHbN4lyYL6RslgwlJyHVdi2vLhe3hyQWeSeafIgDDrTvoKTgw4kOReGhLz6Gy0mGJw==
X-Received: by 2002:a37:444b:0:b0:67b:2755:3131 with SMTP id r72-20020a37444b000000b0067b27553131mr13150159qka.487.1647218716172;
        Sun, 13 Mar 2022 17:45:16 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b002de4d014733sm10265871qtf.13.2022.03.13.17.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 17:45:15 -0700 (PDT)
Date:   Sun, 13 Mar 2022 20:45:13 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: bcachefs update: New allocator has been merged
Message-ID: <Yi6QGfZ5WeV1TOBs@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just finished a big new update: the big allocator rewrite is finished and
merged.

It's a mandatory disk format upgrade; when switching to the new version on an
existing filesystem you'll see it initialize the freespace btree when you mount.

What's changed: we've got some new persistent data structures that replace code
that used to periodically walk all the buckets in the filesystem, kept in an in
memory array - and now that we don't need to do that anymore, the in-memory
bucket array is gone, too. Specifically, we've got:

 - A new hash table for buckets awaiting journal commit before they can be
   reused, using cuckoo hashing (this one was rolled out awhile ago)

 - An extents-style freespace btree, to replace the code in the old allocator
   threads that periodically walked the arrays of buckets to build up freelists

 - A btree of buckets that need discarding before being moved to the freespace
   btree
 
 - A new LRU btree, for buckets containing cached data - replacing code in the
   allocator threads that would scan buckets and build up a heap of buckets to
   be reused.

The old allocator threads are completely gone - and the code that replaces them
all transactional b-tree code, much of it trigger based, that's _way_ easier to
debug and reason about. This fixes weird performance corner cases and
scalabiilty issues - in particular, the allocator threads were prone to using
excessive CPU when the filesystem was nearly full. Also, we've got a new and
much improved discard implementation! Previously, we'd only issue discards
shortly prior to reusing/writing to a bucket again - now, we'll issue discards
right after buckets become empty.

Exciting stuff - this was the biggest and most invasive change in quite awhile,
and I'm pretty happy with how it turned out.

Next big change is going to be the addition of backpointers to fix copygc
scanning, and a rebalance-work btree to fix rebalance thread scanning, and then
we'll be pretty much set for major scalability work.

Other recent changes/improvements: a lot of assorted debugability improvements.

 - list_journal improvements: now, when going emergency read only, we finish
   writing everything we have pending to the journal - we just mark them as
   noflush writes, so they'll never be used by recovery, but list_journal can
   still see them. This means when we detect an inconsistency, we can see all
   the updates leading up to it in the journal (along with what transactions
   were doing them), making it much easier to work backwards to what went wrong.

   We've been doing a lot of debugging lately with just list_journal and grep -
   yay for grep debugging!

 - A bunch of printbuf and to_text() method improvements, which make it easy to
   write good log messages when something goes wrong

 - Started moving some internal state used for debugging from sysfs to debugfs,
   where we can be much more verbose (yay for grep debugging!)

 - Fixed some snapshots bugs - figured out a major cause of the transaction path
   overflow bugs we've been seeing.

And, big thanks to all the people who put up with and test my crappy code and
help with finding all the bugs and beating it into shape :)
