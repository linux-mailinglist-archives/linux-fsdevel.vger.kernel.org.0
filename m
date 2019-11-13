Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58787FB4E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfKMQWc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:22:32 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49492 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKMQWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:22:32 -0500
X-Greylist: delayed 5386 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 11:22:30 EST
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iUu0g-0000MD-Hj; Wed, 13 Nov 2019 07:52:42 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iUu0f-0006lB-4K; Wed, 13 Nov 2019 07:52:42 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list\:FILESYSTEMS \(VFS and infrastructure\)" 
        <linux-fsdevel@vger.kernel.org>
References: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com>
        <201911121523.9C097E7D2C@keescook>
Date:   Wed, 13 Nov 2019 08:52:19 -0600
In-Reply-To: <201911121523.9C097E7D2C@keescook> (Kees Cook's message of "Tue,
        12 Nov 2019 15:25:23 -0800")
Message-ID: <87ftir7rrw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iUu0f-0006lB-4K;;;mid=<87ftir7rrw.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18KxC5XgtHIW1ehZqrpZAzNm4fHWg4UKk8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4966]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1023 ms - load_scoreonly_sql: 0.15 (0.0%),
        signal_user_changed: 4.6 (0.4%), b_tie_ro: 2.5 (0.2%), parse: 1.82
        (0.2%), extract_message_metadata: 19 (1.9%), get_uri_detail_list: 6
        (0.6%), tests_pri_-1000: 14 (1.4%), tests_pri_-950: 1.82 (0.2%),
        tests_pri_-900: 1.29 (0.1%), tests_pri_-90: 44 (4.3%), check_bayes: 42
        (4.1%), b_tokenize: 21 (2.1%), b_tok_get_all: 11 (1.1%), b_comp_prob:
        3.6 (0.3%), b_tok_touch_all: 4.2 (0.4%), b_finish: 0.63 (0.1%),
        tests_pri_0: 916 (89.5%), check_dkim_signature: 1.47 (0.1%),
        check_dkim_adsp: 5 (0.5%), poll_dns_idle: 0.43 (0.0%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 14 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: Allow restricting permissions in /proc/sys
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> Ah! I see the v2 here now. :) Can you please include that in your
> Subject next time, as "[PATCH v2] proc: Allow restricting permissions
> in /proc/sys"? Also, can you adjust your MUA to not send a duplicate
> attachment? The patch inline is fine.
>
> Please CC akpm as well, since I think this should likely go through the
> -mm tree.
>
> Eric, do you have any other thoughts on this?

This works seems to be a cousin of having a proc that is safe for
containers.

Which leads to the whole mess that hide_pid is broken in proc last I
looked.

So my sense is that what we want to do is not allow changing the
permissions but to sort through what it will take to provide actual
mount options to proc (that are per mount).  Thus removing the sharing
that is (currently?) breaking the hide_pid option.

With such an infrastructure in place we can provide a mount option
(possibly default on when mounted by non-root) that keeps anything that
unprivileged users don't need out of proc.  Which is likely to be most
things except the pid files.

It is something I probably should be working on, but I got derailed
by the disaster that has that happened with mounting.    Even after
I gave code review and showed them how to avoid it the new mount api
is still not possible to use safely.

Eric

> -Kees
>
> On Mon, Nov 04, 2019 at 02:07:29PM +0200, Topi Miettinen wrote:
>> Several items in /proc/sys need not be accessible to unprivileged
>> tasks. Let the system administrator change the permissions, but only
>> to more restrictive modes than what the sysctl tables allow.
>> 
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>> ---
>> v2: actually keep track of changed permissions instead of relying on inode
>> cache
>> ---
>>  fs/proc/proc_sysctl.c  | 42 ++++++++++++++++++++++++++++++++++++++----
>>  include/linux/sysctl.h |  1 +
>>  2 files changed, 39 insertions(+), 4 deletions(-)
>> 
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index d80989b6c344..1f75382c49fd 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
>> mask)
>>         if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>>                 return -EACCES;
>> 
>> +       error = generic_permission(inode, mask);
>> +       if (error)
>> +               return error;
>> +
>>         head = grab_header(inode);
>>         if (IS_ERR(head))
>>                 return PTR_ERR(head);
>> @@ -835,17 +839,46 @@ static int proc_sys_permission(struct inode *inode,
>> int mask)
>>  static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
>>  {
>>         struct inode *inode = d_inode(dentry);
>> +       struct ctl_table_header *head = grab_header(inode);
>> +       struct ctl_table *table = PROC_I(inode)->sysctl_entry;
>>         int error;
>> 
>> -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
>> +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>>                 return -EPERM;
>> 
>> +       if (attr->ia_valid & ATTR_MODE) {
>> +               umode_t max_mode = 0777; /* Only these bits may change */
>> +
>> +               if (IS_ERR(head))
>> +                       return PTR_ERR(head);
>> +
>> +               if (!table) /* global root - r-xr-xr-x */
>> +                       max_mode &= ~0222;
>> +               else /*
>> +                     * Don't allow permissions to become less
>> +                     * restrictive than the sysctl table entry
>> +                     */
>> +                       max_mode &= table->mode;
>> +
>> +               /* Execute bits only allowed for directories */
>> +               if (!S_ISDIR(inode->i_mode))
>> +                       max_mode &= ~0111;
>> +
>> +               if (attr->ia_mode & ~S_IFMT & ~max_mode)
>> +                       return -EPERM;
>> +       }
>> +
>>         error = setattr_prepare(dentry, attr);
>>         if (error)
>>                 return error;
>> 
>>         setattr_copy(inode, attr);
>>         mark_inode_dirty(inode);
>> +
>> +       if (table)
>> +               table->current_mode = inode->i_mode;
>> +       sysctl_head_finish(head);
>> +
>>         return 0;
>>  }
>> 
>> @@ -861,7 +894,7 @@ static int proc_sys_getattr(const struct path *path,
>> struct kstat *stat,
>> 
>>         generic_fillattr(inode, stat);
>>         if (table)
>> -               stat->mode = (stat->mode & S_IFMT) | table->mode;
>> +               stat->mode = (stat->mode & S_IFMT) | table->current_mode;
>> 
>>         sysctl_head_finish(head);
>>         return 0;
>> @@ -981,7 +1014,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set
>> *set,
>>         memcpy(new_name, name, namelen);
>>         new_name[namelen] = '\0';
>>         table[0].procname = new_name;
>> -       table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>> +       table[0].current_mode = table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>>         init_header(&new->header, set->dir.header.root, set, node, table);
>> 
>>         return new;
>> @@ -1155,6 +1188,7 @@ static int sysctl_check_table(const char *path, struct
>> ctl_table *table)
>>                 if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
>>                         err |= sysctl_err(path, table, "bogus .mode 0%o",
>>                                 table->mode);
>> +               table->current_mode = table->mode;
>>         }
>>         return err;
>>  }
>> @@ -1192,7 +1226,7 @@ static struct ctl_table_header *new_links(struct
>> ctl_dir *dir, struct ctl_table
>>                 int len = strlen(entry->procname) + 1;
>>                 memcpy(link_name, entry->procname, len);
>>                 link->procname = link_name;
>> -               link->mode = S_IFLNK|S_IRWXUGO;
>> +               link->current_mode = link->mode = S_IFLNK|S_IRWXUGO;
>>                 link->data = link_root;
>>                 link_name += len;
>>         }
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index 6df477329b76..7c519c35bf9c 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -126,6 +126,7 @@ struct ctl_table
>>         void *data;
>>         int maxlen;
>>         umode_t mode;
>> +       umode_t current_mode;
>>         struct ctl_table *child;        /* Deprecated */
>>         proc_handler *proc_handler;     /* Callback for text formatting */
>>         struct ctl_table_poll *poll;
>> -- 
>> 2.24.0.rc1
>> 
>
>> From 3cde64e0aa2734c335355ee6d0d9f12c1f1e8a87 Mon Sep 17 00:00:00 2001
>> From: Topi Miettinen <toiwoton@gmail.com>
>> Date: Sun, 3 Nov 2019 16:36:43 +0200
>> Subject: [PATCH] proc: Allow restricting permissions in /proc/sys
>> 
>> Several items in /proc/sys need not be accessible to unprivileged
>> tasks. Let the system administrator change the permissions, but only
>> to more restrictive modes than what the sysctl tables allow.
>> 
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>> ---
>>  fs/proc/proc_sysctl.c  | 42 ++++++++++++++++++++++++++++++++++++++----
>>  include/linux/sysctl.h |  1 +
>>  2 files changed, 39 insertions(+), 4 deletions(-)
>> 
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index d80989b6c344..1f75382c49fd 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int mask)
>>  	if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>>  		return -EACCES;
>>  
>> +	error = generic_permission(inode, mask);
>> +	if (error)
>> +		return error;
>> +
>>  	head = grab_header(inode);
>>  	if (IS_ERR(head))
>>  		return PTR_ERR(head);
>> @@ -835,17 +839,46 @@ static int proc_sys_permission(struct inode *inode, int mask)
>>  static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
>>  {
>>  	struct inode *inode = d_inode(dentry);
>> +	struct ctl_table_header *head = grab_header(inode);
>> +	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
>>  	int error;
>>  
>> -	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
>> +	if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>>  		return -EPERM;
>>  
>> +	if (attr->ia_valid & ATTR_MODE) {
>> +		umode_t max_mode = 0777; /* Only these bits may change */
>> +
>> +		if (IS_ERR(head))
>> +			return PTR_ERR(head);
>> +
>> +		if (!table) /* global root - r-xr-xr-x */
>> +			max_mode &= ~0222;
>> +		else /*
>> +		      * Don't allow permissions to become less
>> +		      * restrictive than the sysctl table entry
>> +		      */
>> +			max_mode &= table->mode;
>> +
>> +		/* Execute bits only allowed for directories */
>> +		if (!S_ISDIR(inode->i_mode))
>> +			max_mode &= ~0111;
>> +
>> +		if (attr->ia_mode & ~S_IFMT & ~max_mode)
>> +			return -EPERM;
>> +	}
>> +
>>  	error = setattr_prepare(dentry, attr);
>>  	if (error)
>>  		return error;
>>  
>>  	setattr_copy(inode, attr);
>>  	mark_inode_dirty(inode);
>> +
>> +	if (table)
>> +		table->current_mode = inode->i_mode;
>> +	sysctl_head_finish(head);
>> +
>>  	return 0;
>>  }
>>  
>> @@ -861,7 +894,7 @@ static int proc_sys_getattr(const struct path *path, struct kstat *stat,
>>  
>>  	generic_fillattr(inode, stat);
>>  	if (table)
>> -		stat->mode = (stat->mode & S_IFMT) | table->mode;
>> +		stat->mode = (stat->mode & S_IFMT) | table->current_mode;
>>  
>>  	sysctl_head_finish(head);
>>  	return 0;
>> @@ -981,7 +1014,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
>>  	memcpy(new_name, name, namelen);
>>  	new_name[namelen] = '\0';
>>  	table[0].procname = new_name;
>> -	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>> +	table[0].current_mode = table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>>  	init_header(&new->header, set->dir.header.root, set, node, table);
>>  
>>  	return new;
>> @@ -1155,6 +1188,7 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
>>  		if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
>>  			err |= sysctl_err(path, table, "bogus .mode 0%o",
>>  				table->mode);
>> +		table->current_mode = table->mode;
>>  	}
>>  	return err;
>>  }
>> @@ -1192,7 +1226,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
>>  		int len = strlen(entry->procname) + 1;
>>  		memcpy(link_name, entry->procname, len);
>>  		link->procname = link_name;
>> -		link->mode = S_IFLNK|S_IRWXUGO;
>> +		link->current_mode = link->mode = S_IFLNK|S_IRWXUGO;
>>  		link->data = link_root;
>>  		link_name += len;
>>  	}
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index 6df477329b76..7c519c35bf9c 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -126,6 +126,7 @@ struct ctl_table
>>  	void *data;
>>  	int maxlen;
>>  	umode_t mode;
>> +	umode_t current_mode;
>>  	struct ctl_table *child;	/* Deprecated */
>>  	proc_handler *proc_handler;	/* Callback for text formatting */
>>  	struct ctl_table_poll *poll;
>> -- 
>> 2.24.0.rc1
>> 
