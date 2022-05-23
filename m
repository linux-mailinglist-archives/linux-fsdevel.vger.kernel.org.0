Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65ADD531D6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiEWVKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEWVKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:10:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECA7982A;
        Mon, 23 May 2022 14:10:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653340238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZiVLOut3toqD/VOTDgtnLvcL3HaiWUE+iIrgXPs3fck=;
        b=c3xRM8BH9Olb3zo+EHl+YVEpqVm6bGScYMJUGfIGnmSSVq9otqBzkMmMG132AUma2Zq2Wc
        EcaI0Ebw/ET7Z5YQNSugJ7I/WxJecSEIy7SJPn0x/QPGXLqNe0Oxbju8NsrFcrD2s7cDx/
        1piEDwsaIHw2R62SEy3bg8WeyfWE7nJi+jrCe+ZHctir9aULZPTj7KfVlMansHOFOq1o/x
        qwbtxlkXYF3WPMu/+wcJmOLX/dVsTJWwpk77jkpw47YHf/hdekUCFATcXwiXnO+KmKPew9
        aguhprY1Txgt2x0G0UOyviVs/9CixjlAGTXPI+X3FxtRPw2KNj2oghBc0a3jQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653340238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZiVLOut3toqD/VOTDgtnLvcL3HaiWUE+iIrgXPs3fck=;
        b=dV8zH4VID1ptGJGwhN5Y2lQR7fsJwIrvQcdP2100QjG7n57FMo1WzxnJS02b79c3qvrFWc
        Gjd+55byU2+1SHCw==
To:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        jeyu@kernel.org, shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        mcgrof@kernel.org, keescook@chromium.org, rostedt@goodmis.org,
        minchan@kernel.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        copyleft-next@lists.fedorahosted.org,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
In-Reply-To: <20211029184500.2821444-2-mcgrof@kernel.org>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org>
Date:   Mon, 23 May 2022 23:10:37 +0200
Message-ID: <87h75g0xbm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29 2021 at 11:44, Luis Chamberlain wrote:
> preferred. A summary of benefits why projects outside of Linux might
> prefer to use copyleft-next >= 0.3.1 over GPLv2:
>
<snip>
>
> o copyleft-next has a 'built-in or-later' provision

Not convinced that this is a benefit under all circumstances, but that's
a philosopical problem. The real problem is this:

> +Valid-License-Identifier: copyleft-next-0.3.1

and

> +11. Later License Versions
> +
> +    The Copyleft-Next Project may release new versions of copyleft-next,
> +    designated by a distinguishing version number ("Later Versions").
> +    Unless I explicitly remove the option of Distributing Covered Works
> +    under Later Versions, You may Distribute Covered Works under any Later
> +    Version.

If I want to remove this option, then how do I express this with a SPDX
license identifier?

Sigh!

        tglx
