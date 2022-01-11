Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E375C48AE8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 14:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiAKNid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 08:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbiAKNic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:38:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84120C06173F;
        Tue, 11 Jan 2022 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H4sc0o/V8WhWPvaY+DPT4s85xLZBSsAiCEXQ91ENMtY=; b=H7Mgl0WQOtRKPuoFc0OqFv8q94
        SK+7VQJQOsngr8poXByWN+kLc4rERvp44eT/PfQ6iDdC4Y/qVVGbfnKwBM6sE7Hw3kFDPDDwa+RUH
        /VIbgUTXQ1eMKRa8jS0DYV9TPJKwdI1YkZmFUV17QrJM9fxZfT8xg/SgFNkzdACBMEJpOuGuQJ/yX
        +QiB3qlMMIrV/1r/MtX4+/2SbBZrboSk2uvcApvMbpQTzfHCY6KPzhxi4orMpTel/KqmaEcuXQlz6
        Hjxt6vftH9TGrVozhuZA8b0p1gPiEoJNQn7XzCQerRvkaaO+5QgVwtOx4gVW1MfMS9FMfMGiGqiR3
        /h8zQTiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7HM4-003I0S-Dh; Tue, 11 Jan 2022 13:38:28 +0000
Date:   Tue, 11 Jan 2022 13:38:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     cruise k <cruise4k@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        sunhao.th@gmail.com, syzkaller <syzkaller@googlegroups.com>
Subject: Re: INFO: task hung in path_openat
Message-ID: <Yd2IVM1q2Mmck3fJ@casper.infradead.org>
References: <CAKcFiNCg-hp7g-yBZFBB4D8yJ7uXyLvsZ_1P8804YgqLhWUt8w@mail.gmail.com>
 <Ydz71Ux9fCVB2bGB@casper.infradead.org>
 <CANp29Y5tjwYLk3WdfjmsQy3qXbk6V8vW1vERRSTHsAhpzzMGpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y5tjwYLk3WdfjmsQy3qXbk6V8vW1vERRSTHsAhpzzMGpg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:38:02AM +0100, Aleksandr Nogikh wrote:
> Hi Matthew,
> 
> That report was not sent by syzbot, rather by someone else. syzbot tries to
> be much more careful with the INFO: reports.
> 
> During the past couple of weeks there has been some outburst of similar
> reports from various senders - this is the third different sender I see,
> probably there are also much more.

Right.  Perhaps syzcaller could *not* call sched_setscheduler() by
default.  Require an --i-know-what-im-doing-and-wont-submit-bogus-reports
flag to be specified by the user in order to call that syscall?
