Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98310ED438
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 19:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfKCSvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 13:51:09 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:42093 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKCSvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:51:09 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iRKxv-0004oZ-Jg; Sun, 03 Nov 2019 11:51:07 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iRKxu-0002B7-Ob; Sun, 03 Nov 2019 11:51:07 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list\:FILESYSTEMS \(VFS and infrastructure\)" 
        <linux-fsdevel@vger.kernel.org>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
Date:   Sun, 03 Nov 2019 12:50:55 -0600
In-Reply-To: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com> (Topi
        Miettinen's message of "Sun, 3 Nov 2019 16:55:48 +0200")
Message-ID: <87d0e8g5f4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iRKxu-0002B7-Ob;;;mid=<87d0e8g5f4.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+wN/gS3wwKlC/YmuKcs2nkjhNP/60xnQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4079]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Topi Miettinen <toiwoton@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 400 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.7%), b_tie_ro: 1.94 (0.5%), parse: 1.02
        (0.3%), extract_message_metadata: 4.7 (1.2%), get_uri_detail_list: 2.4
        (0.6%), tests_pri_-1000: 3.5 (0.9%), tests_pri_-950: 1.28 (0.3%),
        tests_pri_-900: 1.05 (0.3%), tests_pri_-90: 24 (6.0%), check_bayes: 22
        (5.6%), b_tokenize: 8 (2.0%), b_tok_get_all: 7 (1.8%), b_comp_prob:
        2.5 (0.6%), b_tok_touch_all: 3.1 (0.8%), b_finish: 0.59 (0.1%),
        tests_pri_0: 342 (85.6%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.0 (0.5%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        3.1 (0.8%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> Several items in /proc/sys need not be accessible to unprivileged
> tasks. Let the system administrator change the permissions, but only
> to more restrictive modes than what the sysctl tables allow.

This looks quite buggy.  You neither update table->mode nor
do you ever read from table->mode to initialize the inode.
I am missing something in my quick reading of your patch?

The not updating table->mode almost certainly means that as soon as the
cached inode is invalidated the mode changes will disappear.  Not to
mention they will fail to propogate between  different instances of
proc.

Loosing all of your changes at cache invalidation seems to make this a
useless feature.

Eric


> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index d80989b6c344..88c4ca7d2782 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
> mask)
>         if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>                 return -EACCES;
>
> +       error = generic_permission(inode, mask);
> +       if (error)
> +               return error;
> +
>         head = grab_header(inode);
>         if (IS_ERR(head))
>                 return PTR_ERR(head);
> @@ -837,9 +841,35 @@ static int proc_sys_setattr(struct dentry *dentry, struct
> iattr *attr)
>         struct inode *inode = d_inode(dentry);
>         int error;
>
> -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>                 return -EPERM;
>
> +       if (attr->ia_valid & ATTR_MODE) {
> +               struct ctl_table_header *head = grab_header(inode);
> +               struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> +               umode_t max_mode = 0777; /* Only these bits may change */
> +
> +               if (IS_ERR(head))
> +                       return PTR_ERR(head);
> +
> +               if (!table) /* global root - r-xr-xr-x */
> +                       max_mode &= ~0222;
> +               else /*
> +                     * Don't allow permissions to become less
> +                     * restrictive than the sysctl table entry
> +                     */
> +                       max_mode &= table->mode;
> +
> +               sysctl_head_finish(head);
> +
> +               /* Execute bits only allowed for directories */
> +               if (!S_ISDIR(inode->i_mode))
> +                       max_mode &= ~0111;
> +
> +               if (attr->ia_mode & ~S_IFMT & ~max_mode)
> +                       return -EPERM;
> +       }
> +
>         error = setattr_prepare(dentry, attr);
>         if (error)
>                 return error;
> @@ -853,17 +883,8 @@ static int proc_sys_getattr(const struct path *path, struct
> kstat *stat,
>                             u32 request_mask, unsigned int query_flags)
>  {
>         struct inode *inode = d_inode(path->dentry);
> -       struct ctl_table_header *head = grab_header(inode);
> -       struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> -
> -       if (IS_ERR(head))
> -               return PTR_ERR(head);
>
>         generic_fillattr(inode, stat);
> -       if (table)
> -               stat->mode = (stat->mode & S_IFMT) | table->mode;
> -
> -       sysctl_head_finish(head);
>         return 0;
>  }
