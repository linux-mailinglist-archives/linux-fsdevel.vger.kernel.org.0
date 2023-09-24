Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985497ACB34
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjIXSCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:02:50 -0400
Received: from out-196.mta1.migadu.com (out-196.mta1.migadu.com [IPv6:2001:41d0:203:375::c4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29030FA
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 11:02:44 -0700 (PDT)
Date:   Sun, 24 Sep 2023 14:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695578560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=A2AD1QjSkhr44A054JnK7L84GxXVVRsFRs//bONDMhk=;
        b=blWT0X9pAOCHxt4Uugs9RcDO8uNjyRmMIDDgt3JdirdfL71PpTh4XkjA7wIZ18uUFWg04K
        AuKHH8IpzUG05RjM25/NHxiB4SIXZzpKLs1huaVOcyq2LQqR3LpHgilTiFJVO9gaLJwlC5
        e6MkqJKArGNjR1/f1uxnsjPQ7aCYyL0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: biweekly bcachefs cabal meeting
Message-ID: <20230924180236.xwb2d45ptrh6rmnn@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(Last few meetings didn't happen, conference travel is over so changing
the schedule a bit)

Tuesday, September 26th, 1 pm EST:

We'll be chatting about merging (bcachefs is in linux-next now;
shouldn't be much left to talk about), going over bugs/areas to focus on
(there should be work happening soon to port btrfs snapshot tests to
bcachefs), and generally coordinating and answering questions.

Send me an email if you'd like an invite

Cheers,
Kent
