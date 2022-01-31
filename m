Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788224A3EF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 10:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiAaJAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 04:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiAaJAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:00:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE3C061714;
        Mon, 31 Jan 2022 01:00:30 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643619627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/u2+IgTtu6/QxflymQZe2Y0md+IS7nr1bny9V+yCgU4=;
        b=sVcdCOdygLRPc/pOmGY/Nw3lt5jft0nsPJJLIJZQpVmdRfozfUzaLh4KbUPQGf5hZ9oPyf
        LdmZydn5pxEwHTz0sIw6XgWUljVvVzRnNcQxWeSX/VO4ESZ7NugSu+o360XHsTTPBAfOzA
        KlCApbUDbKTI989Mkv3G90Th+hvWNlTuA4vrE24COijbzqVdXeh0Ob8erhyhnKxJEJhSv7
        F+ujvTsNxOqRVmcq8+nmniuvcxIRXooZzsGblbEOYxQlixuj/nORrhpTnJj8Zs7iapRa2n
        poUQs+B/nXJHeX9F+u0IqBM701rYHCUqNeaP3e11k2/W7WN1Jy4rC+nHp8b31Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643619627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/u2+IgTtu6/QxflymQZe2Y0md+IS7nr1bny9V+yCgU4=;
        b=qtB+hPO69Bjac5X5ymCvTkpg7HDKkqJw2CzZcHmY6D/iG/PgAb9zW0oqTMXOf374VbxccY
        eIiyuhBdvHfW8kAQ==
To:     tangmeng <tangmeng@uniontech.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH v4] kernel/time: move timer sysctls to its own file
In-Reply-To: <20220131065728.6823-1-tangmeng@uniontech.com>
References: <20220131065728.6823-1-tangmeng@uniontech.com>
Date:   Mon, 31 Jan 2022 10:00:26 +0100
Message-ID: <87pmo82sb9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31 2022 at 14:57, tangmeng@uniontech.com wrote:
> This moves the kernel/timer/timer.c respective sysctls to its own
> file.

Why? What's the reason and purpose of this? We are not moving code
around just because we can.

Thanks,

        tglx
