Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22645531DBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 23:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiEWV2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 17:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiEWV1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 17:27:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99069859B;
        Mon, 23 May 2022 14:27:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653341254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lyoADbaI9emEad6jxvsYrqkAZsvu9nykyZtsZApDNGk=;
        b=U5JSdkBfUq+/gQs6cgBxyfnRFOkp3Zi8j+l4uZcB0Kl8MdOLSVnp6TTibzHBwIUixnPKV2
        Rtde+pvh2XvPAEX2n6oOFAiiR5aG5TDmwijdyvwEyHUXs/VrIDHg0G+OycqrPlB4XeS+1t
        x46iIVpcqgmy1iMi6m7fkBxNDmPkU7UWHDQuwAX8XaY7kRNZI5ujTeIp36qt6ah3Gtpd1Q
        a69DJyOnkP3forcj4Vju+62Y8+EYWoL+W80/BO42YfRUe5sM46RhApf0IEiZpEC6TRPuwd
        FlxSXvkflX9xQ82ypW5chavkGnICUkKjzUQpGqr0DdwZzPQIqakzTZd+h+ZMjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653341254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lyoADbaI9emEad6jxvsYrqkAZsvu9nykyZtsZApDNGk=;
        b=ZRFd0DHKFx2tvHdvBqapAmLm1Gtb088QyRoFCfzolsaPjkOVDT7sbYSSrJPENH443xtZnY
        djojoPCD2iM4FFBg==
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
Date:   Mon, 23 May 2022 23:27:34 +0200
Message-ID: <87bkvo0wjd.ffs@tglx>
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
> +    "FSF-Free" means classified as 'free' by the Free Software Foundation.
> +
> +    "OSI-Approved" means approved as 'Open Source' by the Open Source
> +    Initiative.

copyleft-next is neither nor. Confused...
