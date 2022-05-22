Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAF5303BE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347717AbiEVPGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 11:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiEVPGr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 11:06:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BAF34BAA;
        Sun, 22 May 2022 08:06:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653232005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQJxoIOG9BwCxxHhxQMhF2ZBIhG1CDWoR7s9LjjPX0Y=;
        b=W7okeNoZ6TeXYA9CiZ8DUMjWTYHZ++NYvSYoc6xB+vqeT9ZfbQQZDoDDUFvguvDe+eY3YX
        uqSKcrAd279SjCUAUHbgFYHI5S/FYuERBof46BnwS8+zH48h/V6K65hPCQKYATHwJ/EXXe
        BKprNgYX9lo5HgRDyfYHDsGEJoWkT2Xu3RobDM7HJ8jW6fr0vJ024EHDZ5Y26ZvJIWNLf4
        9p90Lb7HcabJTEVg/QSOgijHEgrYwQt1MqsRJ6a1dwLTSYybWiRy8/TrZgQSal64A2mJfx
        FAci8rRLfFNTFpD1X6PU72+CNcNZyMmBk5qiuRJvW1SeY4g4Y02alsjMrxsGdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653232005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQJxoIOG9BwCxxHhxQMhF2ZBIhG1CDWoR7s9LjjPX0Y=;
        b=W/lqxyrm75peM69EweXkxgQFSW4gzSeg0W15Y0rs3B6x5LRaGKDp9wBeI/DRQNI17aXPN2
        yVde12xMql8cddDQ==
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        keescook@chromium.org, rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/6] selftests: add tests_sysfs module
In-Reply-To: <YopM5XGMdqVCU+bL@kroah.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-4-mcgrof@kernel.org> <Yao3vtSKBKLyQY1E@kroah.com>
 <87fsl1iqg0.ffs@tglx> <YopM5XGMdqVCU+bL@kroah.com>
Date:   Sun, 22 May 2022 17:06:44 +0200
Message-ID: <87czg5ip2z.ffs@tglx>
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

On Sun, May 22 2022 at 16:47, Greg KH wrote:
> On Sun, May 22, 2022 at 04:37:19PM +0200, Thomas Gleixner wrote:
>> On Fri, Dec 03 2021 at 16:29, Greg KH wrote:
>> 
>> While I agree that we want to keep the number of licenses as small as
>> possible, we cannot really dictate which dual licensing options a
>> submitter selects unless the license is GPL-2.0-only incompatible, which
>> copyleft-next is not.
>> 
>> Can we just get over this, add the license with the SPDX identifier and
>> move on?
>
> From what I recall, I had technical reasons I didn't take this series,
> but that was a long time ago and I would be glad to review it again if
> it were rebased and resubmitted after the next merge window is closed.

The license addition and the SPDX identifier cleanup should be seperated
from the new test code which was part of the series.

Thanks,

        tglx
