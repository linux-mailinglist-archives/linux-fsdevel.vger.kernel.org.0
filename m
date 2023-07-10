Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E874DB4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjGJQlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGJQlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:41:31 -0400
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7C7137
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 09:41:28 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689007286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=fE9HLq2D3bbcbrtonmy8SYvKYdr7dPe99IuPrx6LP38=;
        b=e7zsj30rYoqhF3z41bTAN0V6otomQbkRWoyoAq92Lvq6sttnzLnW6NqAopHVsjeAjWHEAQ
        ulJMa1Xwuy/HK4VQ8IYBqiGdAfnic0HXo1zOFipyIaMAW9Pwn+QrEUhAMuL/KDtibsWmDL
        GuFVaXpP+eMlA21Vb9Y1w7Mcin1z4jo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [biweekly bcachefs cabal]
Message-ID: <20230710164123.za3fdhb5lozwwq6y@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cabal meeting is tomorrow at 1 pm eastern.

We'll be talking about upstreaming, gathering input and deciding what
still needs to be worked on - shoot me an email if you'd like an invite.

Cheers,
Kent
