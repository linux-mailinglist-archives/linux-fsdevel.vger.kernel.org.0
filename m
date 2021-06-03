Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1974339A681
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 18:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFCRBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 13:01:38 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38048 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhFCRBi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 13:01:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1loqhD-000jT9-SG; Thu, 03 Jun 2021 10:59:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1loqhB-0014ta-S2; Thu, 03 Jun 2021 10:59:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <162218365578.34379.12523496660412609287.stgit@web.messagingengine.com>
        (Ian Kent's message of "Fri, 28 May 2021 14:34:15 +0800")
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
        <162218365578.34379.12523496660412609287.stgit@web.messagingengine.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Thu, 03 Jun 2021 11:59:26 -0500
Message-ID: <87sg1yq3yp.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1loqhB-0014ta-S2;;;mid=<87sg1yq3yp.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HxLa+PRc0hpmh8oMEaTcHefBrxSzyR14=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Ian Kent <raven@themaw.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1450 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.6 (0.3%), b_tie_ro: 2.5 (0.2%), parse: 0.65
        (0.0%), extract_message_metadata: 8 (0.6%), get_uri_detail_list: 1.03
        (0.1%), tests_pri_-1000: 4.1 (0.3%), tests_pri_-950: 1.04 (0.1%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 118 (8.1%), check_bayes:
        109 (7.5%), b_tokenize: 6 (0.4%), b_tok_get_all: 6 (0.4%),
        b_comp_prob: 1.50 (0.1%), b_tok_touch_all: 92 (6.3%), b_finish: 0.73
        (0.1%), tests_pri_0: 1301 (89.7%), check_dkim_signature: 0.56 (0.0%),
        check_dkim_adsp: 3.3 (0.2%), poll_dns_idle: 0.71 (0.0%), tests_pri_10:
        2.5 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REPOST PATCH v4 3/5] kernfs: switch kernfs to use an rwsem
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ian Kent <raven@themaw.net> writes:

> The kernfs global lock restricts the ability to perform kernfs node
> lookup operations in parallel during path walks.
>
> Change the kernfs mutex to an rwsem so that, when opportunity arises,
> node searches can be done in parallel with path walk lookups.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/kernfs/dir.c             |  117 ++++++++++++++++++++++++-------------------
>  fs/kernfs/file.c            |    4 +
>  fs/kernfs/inode.c           |   16 +++---
>  fs/kernfs/kernfs-internal.h |    5 +-
>  fs/kernfs/mount.c           |   12 ++--
>  fs/kernfs/symlink.c         |    4 +
>  include/linux/kernfs.h      |    2 -
>  7 files changed, 86 insertions(+), 74 deletions(-)
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 5151c712f06f5..1e2e35a201dfb 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -17,7 +17,7 @@
>  
>  #include "kernfs-internal.h"
>  
> -DEFINE_MUTEX(kernfs_mutex);
> +DECLARE_RWSEM(kernfs_rwsem);
>  static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
>  static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
>  static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
> @@ -26,10 +26,21 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
>  
>  static bool kernfs_active(struct kernfs_node *kn)
>  {
> -	lockdep_assert_held(&kernfs_mutex);
>  	return atomic_read(&kn->active) >= 0;
>  }
>  
> +static bool kernfs_active_write(struct kernfs_node *kn)
> +{
> +	lockdep_assert_held_write(&kernfs_rwsem);
> +	return kernfs_active(kn);
> +}
> +
> +static bool kernfs_active_read(struct kernfs_node *kn)
> +{
> +	lockdep_assert_held_read(&kernfs_rwsem);
> +	return kernfs_active(kn);
> +}

This bit is unnecessary and confusing.  There is nothing read/write
about how the kernfs file is active (aka being used be a function).
Further all that is needed for correct operation is:

>  static bool kernfs_active(struct kernfs_node *kn)
>  {
> -	lockdep_assert_held(&kernfs_mutex);
> +	lockdep_assert_held(&kernfs_rwsem);
>  	return atomic_read(&kn->active) >= 0;
>  }

Eric
