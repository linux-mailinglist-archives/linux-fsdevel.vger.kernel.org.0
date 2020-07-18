Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D20224D64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 19:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGRRsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jul 2020 13:48:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41694 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRRsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:48:12 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jwqw0-0003uS-Rf; Sat, 18 Jul 2020 17:47:40 +0000
Date:   Sat, 18 Jul 2020 19:47:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Adrian Reber <areber@redhat.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200718174739.bg73idrihaj4p2qf@wittgenstein>
References: <20200715144954.1387760-1-areber@redhat.com>
 <20200718032416.GC11982@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200718032416.GC11982@mail.hallyn.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:24:16PM -0500, Serge Hallyn wrote:
> On Wed, Jul 15, 2020 at 04:49:48PM +0200, Adrian Reber wrote:
> > This is v5 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. The
> > changes to v4 are:
> > 
> >  * split into more patches to have the introduction of
> >    CAP_CHECKPOINT_RESTORE and the actual usage in different
> >    patches
> >  * reduce the /proc/self/exe patch to only be about
> >    CAP_CHECKPOINT_RESTORE
> > 
> > Adrian Reber (5):
> >   capabilities: Introduce CAP_CHECKPOINT_RESTORE
> >   pid: use checkpoint_restore_ns_capable() for set_tid
> >   pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
> >   proc: allow access in init userns for map_files with CAP_CHECKPOINT_RESTORE
> >   selftests: add clone3() CAP_CHECKPOINT_RESTORE test
> > 
> > Nicolas Viennot (1):
> >   prctl: Allow checkpoint/restore capable processes to change exe link
> 
> (This is probably bad form, but)  All
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> 
> Assuming you changes patches 4 and 6 per Christian's suggestions,
> I'd like to re-review those then.

Thanks, once Adrian has reposted the changes and you agree with them as
well, I'll pick them up though I might end up pushing this into the next
merge window...

Christian
