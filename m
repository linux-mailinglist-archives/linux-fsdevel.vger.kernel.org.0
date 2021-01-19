Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59D2FC20B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 22:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391818AbhASVMj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 16:12:39 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47868 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391929AbhASVMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:12:24 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l1yHc-0074ac-TD; Tue, 19 Jan 2021 14:11:24 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l1yHb-009ut1-VR; Tue, 19 Jan 2021 14:11:24 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <code@tyhicks.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
Date:   Tue, 19 Jan 2021 15:10:14 -0600
In-Reply-To: <20210119162204.2081137-1-mszeredi@redhat.com> (Miklos Szeredi's
        message of "Tue, 19 Jan 2021 17:22:02 +0100")
Message-ID: <87y2go8wg9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l1yHb-009ut1-VR;;;mid=<87y2go8wg9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/4Ah3dTvupV5EVHSjncD8jAwEeZNW5C5M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 400 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.8 (1.0%), b_tie_ro: 2.6 (0.6%), parse: 0.65
        (0.2%), extract_message_metadata: 2.5 (0.6%), get_uri_detail_list:
        1.11 (0.3%), tests_pri_-1000: 2.8 (0.7%), tests_pri_-950: 1.03 (0.3%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 153 (38.3%), check_bayes:
        152 (38.0%), b_tokenize: 4.8 (1.2%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 1.63 (0.4%), b_tok_touch_all: 136 (33.9%), b_finish: 0.72
        (0.2%), tests_pri_0: 221 (55.3%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.3 (0.6%), poll_dns_idle: 0.88 (0.2%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 6 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] capability conversion fixes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> It turns out overlayfs is actually okay wrt. mutliple conversions, because
> it uses the right context for lower operations.  I.e. before calling
> vfs_{set,get}xattr() on underlying fs, it overrides creds with that of the
> mounter, so the current user ns will now match that of
> overlay_sb->s_user_ns, meaning that the caps will be converted to just the
> right format for the next layer
>
> OTOH ecryptfs, which is the only other one affected by commit 7c03e2cda4a5
> ("vfs: move cap_convert_nscap() call into vfs_setxattr()") needs to be
> fixed up, since it doesn't do the cap override thing that overlayfs does.
>
> I don't have an ecryptfs setup, so untested, but it's a fairly trivial
> change.
>
> My other observation was that cap_inode_getsecurity() messes up conversion
> of caps in more than one case.  This is independent of the overlayfs user
> ns enablement but affects it as well.
>
> Maybe we can revisit the infrastructure improvements we discussed, but I
> think these fixes are more appropriate for the current cycle.

I mostly agree.  Fixing the bugs in a back-portable way is important.

However we need to sort out the infrastructure, and implementation.

As far as I can tell it is only the fact that overlayfs does not support
the new mount api aka fs_context that allows this fix to work and be
correct.

I believe the new mount api would allow specifying a different userns
thatn curent_user_ns for the overlay filesystem and that would break
this.

So while I agree with the making a minimal fix for now.  We need a good
fix because this code is much too subtle, and it can break very easily
with no one noticing.

Eric





> Thanks,
> Miklos
>
> Miklos Szeredi (2):
>   ecryptfs: fix uid translation for setxattr on security.capability
>   security.capability: fix conversions on getxattr
>
>  fs/ecryptfs/inode.c  | 10 +++++--
>  security/commoncap.c | 67 ++++++++++++++++++++++++++++----------------
>  2 files changed, 50 insertions(+), 27 deletions(-)
