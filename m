Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1D7171B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 01:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjE3Xa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 19:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjE3Xaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 19:30:55 -0400
Received: from out-48.mta0.migadu.com (out-48.mta0.migadu.com [91.218.175.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEBBEC
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 16:30:53 -0700 (PDT)
Date:   Tue, 30 May 2023 19:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685489422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UuvmlC8dfa/P9bSVjs6YkTnrMCD9NpB2rL2GnbUhBoc=;
        b=c/Ny5llV5hrc9DelqbfyA+JLy2iM+UAp/lBcH88QYp+aK95wORjfuVAb3ebEQMo+XNNs7g
        3UM/AW907ThcSNgUZH4AnBowSQzyDyJMSgKzY/MTpzPv999NEVgZ9Zvm0rV6Hdl5DeLe7B
        EN6J+kU1H4IbPDYbGNt0RTZUgHzIAB4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
Message-ID: <ZHaHC63OG+Q0N9wM@moria.home.lan>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
 <ZHEaKQH22Uxk9jPK@moria.home.lan>
 <8e874109-db4a-82e3-4020-0596eeabbadf@kernel.dk>
 <ZHYfGvPJFONm58dA@moria.home.lan>
 <2a56b6d4-5f24-9738-ec83-cefb20998c8c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a56b6d4-5f24-9738-ec83-cefb20998c8c@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 10:50:55AM -0600, Jens Axboe wrote:
> Sorry typo, I meant text. Just checked stack and it looks identical, but
> things like blk-map grows ~6% more text, and bio ~3%. Didn't check all
> of them, but at least those two are consistent across x86-64 and
> aarch64. Ditto on the data front. Need to take a closer look at where
> exactly that is coming from, and what that looks like.

Weird - when I looked kernel text size was unchanged, it was data that
increased with the earlier version of the patch due to a new WARN_ON().
I'll have another look.
