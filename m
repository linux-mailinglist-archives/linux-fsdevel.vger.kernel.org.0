Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65E3974FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 16:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhFAOHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhFAOHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:07:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CDBC0613CE;
        Tue,  1 Jun 2021 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gcY/MQ7qRRnSW8QOpP9FIZIGtZGtZiloEjHxScAgk9g=; b=oib1s3WsjrcdgwbGW+9YuOFSnb
        jFMdDeGs7GowzUCXEinPv+sOu5tlcoKCP9ILZeF7y8co2evsX3w+RJ9VyBCpCHg8NiXiaDk/yDMxx
        xQ0a8Wi8h/iOROiH4p/yWavdK2OXfbG08iyQ9hGPNV8CmE3OgFpOw8p2uElNq0eiE+DsHvzRIy+Yy
        YC0S0yy+du6JIJZjFmi4K4FNib5umQtDYXveP/KWYIhFjiioTKLQxZxEIQZTCO8JH29nF7wVoFXVE
        RTJlzX1HoL4LeiEgijINmkamN1DTW6odFhFtxMLjltNGPN0PLEJG7CdcDA1pmr/RMCso6JnqYKCjO
        PXg2SBBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lo4zQ-00A5wj-NF; Tue, 01 Jun 2021 14:03:33 +0000
Date:   Tue, 1 Jun 2021 15:03:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>, joe@perches.com,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        hare@suse.de, tj@kernel.org, gregkh@linuxfoundation.org,
        song@kernel.org, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        pmladek@suse.com, Alexander Potapenko <glider@google.com>,
        Chris Down <chris@chrisdown.name>, jojing64@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, mingo@kernel.org,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] init/initramfs.c: make initramfs support
 pivot_root
Message-ID: <YLY+MNDgCT89hwQg@casper.infradead.org>
References: <20210528143802.78635-1-dong.menglong@zte.com.cn>
 <20210529112638.b3a9ec5475ca8e4f51648ff0@kernel.org>
 <CADxym3Ya3Jv_tUMJyq+ymd8m1_S-KezqNDfsLtMcJCXtDytBzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxym3Ya3Jv_tUMJyq+ymd8m1_S-KezqNDfsLtMcJCXtDytBzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 01, 2021 at 09:55:33PM +0800, Menglong Dong wrote:
> Hello!
> 
> What's the status or fate of this patch? Does anyone do an in-depth
> study of this field? Knock-knock~

You sent this on Friday.  Monday was a holiday in the USA.  Generally
you should wait a week before pinging a patch.
