Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C816E531D9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiEWVWj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEWVWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:22:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B96939A2;
        Mon, 23 May 2022 14:22:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653340956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=59DfhzYe72S2hFk3ZpzXUpbAoT1XkzoxJ1ayQv+aGxs=;
        b=XRNrsXdvZ/svutzu4W0qC2B5F0dKf/1VcNM0aY/b6p1XFSu2lbe7mnf/2JEF9hSQityyKe
        nCc3JaO0JHTdrddoXESum0RZA4aNm2qIr2KPmJhEilgnkVkuhSVgv/ZeaHD36/I91s0fnF
        YkB4WlZvqMeJCG1O9f2u8CZD7e++8fsYEUewtwYWMIgpXiXR3ztUcIqbbhSmIZuFrFv4B/
        6navIvFI06g6Kc7Icv5SwU+vKIS4MP1xncmslyuAGBbr++XXoj/nYrCU9gThBt3CG10xDn
        baM8N7KA0miLmNYkGGewvwt3y0l0FOPsdd7CNjhTOpqs6F9h+iG1NvYPd59W9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653340956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=59DfhzYe72S2hFk3ZpzXUpbAoT1XkzoxJ1ayQv+aGxs=;
        b=GzuEXz4lAMUxV3PWK9SCtm1vnrVCmYCYuy16Y+0kilnaAoyOxElbE6W5Amp68QChjt2Vsm
        UIWuDnKIp8lFJ7Cw==
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
Date:   Mon, 23 May 2022 23:22:36 +0200
Message-ID: <87ee0k0wrn.ffs@tglx>
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
> --- /dev/null
> +++ b/LICENSES/dual/copyleft-next-0.3.1
> @@ -0,0 +1,237 @@
> +Valid-License-Identifier: copyleft-next-0.3.1
> +SPDX-URL: https://spdx.org/licenses/copyleft-next-0.3.1
> +Usage-Guide:
> +  This license can be used in code, it has been found to be GPLv2 compatible
> +  by attorneys at Redhat and SUSE, however to air on the side of caution,

air ?

> +  it's best to only use it together with a GPL2 compatible license using "OR".

This paragraph is not really understandable for Joe Developer.

  copyleft-next-0.3.1 is explicitly compatible with GPLv2 (or later) and
  can therefore be used for kernel code. Though the best and recommended
  practice is to express this in the SPDX license identifier by
  licensing the code under both licenses expressed by the OR operator.

Hmm?

> +  To use the copyleft-next-0.3.1 license put the following SPDX tag/value
> +  pair into a comment according to the placement guidelines in the
> +  licensing rules documentation:
> +    SPDX-License-Identifier: GPL-2.0 OR copyleft-next-0.3.1
> +    SPDX-License-Identifier: GPL-2.0-only OR copyleft-next 0.3.1
> +    SPDX-License-Identifier: GPL-2.0+ OR copyleft-next-0.3.1
> +    SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1

Please don't propagate the GPL-2.0 and GPL-2.0+ tags. They are
outdated (still valid) in the SPDX spec, which reminds me that I should
update the relevant documentation...

Thanks,

        tglx
