Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFEE4C8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440409AbfJYNnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 09:43:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56345 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfJYNna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:43:30 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iNzsH-00072g-Pn; Fri, 25 Oct 2019 07:43:29 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iNzsG-0006vL-SW; Fri, 25 Oct 2019 07:43:29 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191025112917.22518-1-mszeredi@redhat.com>
Date:   Fri, 25 Oct 2019 08:42:24 -0500
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com> (Miklos Szeredi's
        message of "Fri, 25 Oct 2019 13:29:12 +0200")
Message-ID: <87r231rlfj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iNzsG-0006vL-SW;;;mid=<87r231rlfj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19PFgdLj+d0f0xnbf++PpDtbqlJ7o3tTO0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4944]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 365 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.8 (1.0%), b_tie_ro: 2.5 (0.7%), parse: 1.31
        (0.4%), extract_message_metadata: 4.8 (1.3%), get_uri_detail_list:
        1.73 (0.5%), tests_pri_-1000: 6 (1.5%), tests_pri_-950: 1.88 (0.5%),
        tests_pri_-900: 1.48 (0.4%), tests_pri_-90: 24 (6.5%), check_bayes: 22
        (6.0%), b_tokenize: 8 (2.3%), b_tok_get_all: 6 (1.6%), b_comp_prob:
        2.5 (0.7%), b_tok_touch_all: 2.7 (0.7%), b_finish: 0.75 (0.2%),
        tests_pri_0: 300 (82.3%), check_dkim_signature: 0.62 (0.2%),
        check_dkim_adsp: 2.4 (0.7%), poll_dns_idle: 0.52 (0.1%), tests_pri_10:
        2.5 (0.7%), tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/5] allow unprivileged overlay mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> Hi Eric,
>
> Can you please have a look at this patchset?
>
> The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
> whether I'm correct in stating that this isn't going to introduce any
> holes, or not...

I will take some time and dig through this.

From a robustness standpoint I worry about the stackable filesystem
side.  As that is uniquely an attack vector with overlayfs.

There is definitely demand for this.


> Thanks,
> Miklos
>
> ---
> Miklos Szeredi (5):
>   ovl: document permission model
>   ovl: ignore failure to copy up unknown xattrs
>   vfs: allow unprivileged whiteout creation
>   ovl: user xattr
>   ovl: unprivieged mounts
>
>  Documentation/filesystems/overlayfs.txt | 44 +++++++++++++
>  fs/char_dev.c                           |  3 +
>  fs/namei.c                              | 17 ++---
>  fs/overlayfs/copy_up.c                  | 34 +++++++---
>  fs/overlayfs/dir.c                      |  2 +-
>  fs/overlayfs/export.c                   |  2 +-
>  fs/overlayfs/inode.c                    | 39 ++++++------
>  fs/overlayfs/namei.c                    | 56 +++++++++--------
>  fs/overlayfs/overlayfs.h                | 81 +++++++++++++++---------
>  fs/overlayfs/ovl_entry.h                |  1 +
>  fs/overlayfs/readdir.c                  |  5 +-
>  fs/overlayfs/super.c                    | 53 +++++++++++-----
>  fs/overlayfs/util.c                     | 82 +++++++++++++++++++++----
>  include/linux/device_cgroup.h           |  3 +
>  14 files changed, 298 insertions(+), 124 deletions(-)

Eric
