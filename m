Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EF852D275
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 14:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiESM2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiESM2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 08:28:02 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE52BA57A;
        Thu, 19 May 2022 05:28:01 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 20D5C1C0B92; Thu, 19 May 2022 14:27:58 +0200 (CEST)
Date:   Thu, 19 May 2022 14:27:46 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Walt Drummond <walt@drummond.us>, Theodore Ts'o <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>, aacraid@microsemi.com,
        viro@zeniv.linux.org.uk, anna.schumaker@netapp.com, arnd@arndb.de,
        bsegall@google.com, bp@alien8.de, chuck.lever@oracle.com,
        bristot@redhat.com, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, dietmar.eggemann@arm.com, dinguyen@kernel.org,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        idryomov@gmail.com, mingo@redhat.com, yzaikin@google.com,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, jmorris@namei.org,
        bfields@fieldses.org, jlayton@kernel.org, jirislaby@kernel.org,
        john.johansen@canonical.com, juri.lelli@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com, mgorman@suse.de,
        oleg@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rth@twiddle.net, richard@nod.at, serge@hallyn.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        trond.myklebust@hammerspace.com, vincent.guittot@linaro.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] signals: Support more than 64 signals
Message-ID: <20220519122746.GA3904@localhost>
References: <20220103181956.983342-1-walt@drummond.us>
 <87iluzidod.fsf@email.froward.int.ebiederm.org>
 <YdSzjPbVDVGKT4km@mit.edu>
 <87pmp79mxl.fsf@email.froward.int.ebiederm.org>
 <YdTI16ZxFFNco7rH@mit.edu>
 <CADCN6nzT-Dw-AabtwWrfVRDd5HzMS3EOy8WkeomicJF07nQyoA@mail.gmail.com>
 <YdiUiHAhLyfgpvVY@cello>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdiUiHAhLyfgpvVY@cello>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

> > The only standard tools that support SIGINFO are sleep, dd and ping,
> > (and kill, for obvious reasons) so it's not like there's a vast hole
> > in the tooling or something, nor is there a large legacy software base
> > just waiting for SIGINFO to appear.   So while I very much enjoyed
> > figuring out how to make SIGINFO work ...
> 
> As far as I recall, GNU make on *BSD does support SIGINFO (Not a
> standard tool, but obviously an established one).
> 
> The developers of strace have expressed interest in SIGINFO support
> to print tracer status messages (unfortunately, not on a public list).
> Computational software can use this instead of stderr progress spam, if
> run in an interactive fashion on a terminal, as it frequently is. There
> is a user base, it's just not very vocal on kernel lists. :)

And often it would be useful if cp supported this. Yes, this
is feature I'd like to see.

BR,							Pavel

-- 
