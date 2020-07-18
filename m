Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C3224849
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 05:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgGRDYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 23:24:19 -0400
Received: from mail.hallyn.com ([178.63.66.53]:36422 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbgGRDYT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 23:24:19 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 06B712D5; Fri, 17 Jul 2020 22:24:17 -0500 (CDT)
Date:   Fri, 17 Jul 2020 22:24:16 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200718032416.GC11982@mail.hallyn.com>
References: <20200715144954.1387760-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715144954.1387760-1-areber@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 04:49:48PM +0200, Adrian Reber wrote:
> This is v5 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. The
> changes to v4 are:
> 
>  * split into more patches to have the introduction of
>    CAP_CHECKPOINT_RESTORE and the actual usage in different
>    patches
>  * reduce the /proc/self/exe patch to only be about
>    CAP_CHECKPOINT_RESTORE
> 
> Adrian Reber (5):
>   capabilities: Introduce CAP_CHECKPOINT_RESTORE
>   pid: use checkpoint_restore_ns_capable() for set_tid
>   pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
>   proc: allow access in init userns for map_files with CAP_CHECKPOINT_RESTORE
>   selftests: add clone3() CAP_CHECKPOINT_RESTORE test
> 
> Nicolas Viennot (1):
>   prctl: Allow checkpoint/restore capable processes to change exe link

(This is probably bad form, but)  All

Reviewed-by: Serge Hallyn <serge@hallyn.com>

Assuming you changes patches 4 and 6 per Christian's suggestions,
I'd like to re-review those then.

> 
>  fs/proc/base.c                                |   8 +-
>  include/linux/capability.h                    |   6 +
>  include/uapi/linux/capability.h               |   9 +-
>  kernel/pid.c                                  |   2 +-
>  kernel/pid_namespace.c                        |   2 +-
>  kernel/sys.c                                  |  12 +-
>  security/selinux/include/classmap.h           |   5 +-
>  tools/testing/selftests/clone3/Makefile       |   4 +-
>  .../clone3/clone3_cap_checkpoint_restore.c    | 203 ++++++++++++++++++
>  9 files changed, 236 insertions(+), 15 deletions(-)
>  create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
> 
> 
> base-commit: d31958b30ea3b7b6e522d6bf449427748ad45822
> -- 
> 2.26.2
