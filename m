Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF21FAEC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 11:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfKMKoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 05:44:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35097 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMKoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:44:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id r7so2021122ljg.2;
        Wed, 13 Nov 2019 02:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=dhEmIfzmqI7tQAcEXbRXTf4UdaZklcdOSd4XS/O15mk=;
        b=ibPduaEdNiokOHpZYkMSTiCcSRya3bI4nur19AswyIaJXjamlemLU8Djl86wrBPkva
         ra4gCQZ2l/mDze6PqpRApTe7zL5OAaDSToJi0lZNEtArnVor/AWTKHqbFFqycF9MW0t1
         5MNXx1t2N1poAqBQBSe+VgT/HzJyjoy+lDwmpjLK3DfQq16V0CYF/Fn12A7kx/XDA1hY
         QqY6r8i3rZeRPJ9k0C7UadYpYJ5a2wCA8tiOY7RgoXAz1YjjS32u4exOe88rczoVFnHT
         EvmODncxGKTRt5bHp2dDc4t+8Z0gHIzx1aKnjBktujZvYUYuI3668at0PtykhoIkr59s
         35Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dhEmIfzmqI7tQAcEXbRXTf4UdaZklcdOSd4XS/O15mk=;
        b=PAA+q1IRJpyp/weghKWSBzASY+c5N/zfriHq0XTU4H+n0o+VmIL2J9B2VTdkkbchtF
         G8fZXoeg4XFdrKhZqWfcjpwuH/fOQeJ/VF8ol8sOThk5QfyKlk2GmXJUJmhqneuHgxhy
         I9XifhKNsBLgk8uhK4WY1B3zKHvApvi1jj7beVm8N9bnTqfyek9t9zRKmbp65sGanlcV
         4zd4Hz69bu40BUdm96q2HT5WBbVIA9AE89KFdjRGWEg8G3khW0nfxeTIZtRzcS3vPJbM
         IM/SuYcH8nBd+eG7rmn/S7Kjbf9gZV17aWvwspYxDfUz/UpnMbMz3tnFYu4A6KUteIqU
         JLEA==
X-Gm-Message-State: APjAAAVVgGwIWcYqa4Oh1g0M0Ua2zNs6FXwQCNq6yDrbmB1Xwra+UGQd
        asZ98EXvF7ECTQ1R//j0u++SwXUz
X-Google-Smtp-Source: APXvYqzb0Gfz1wiPvicjLB+zCE7q5HitJzRnneD+hHncVMfFRam1eCI0E00qQ523jF/CkuNLU7ZWSA==
X-Received: by 2002:a2e:b5b8:: with SMTP id f24mr2042067ljn.188.1573641854044;
        Wed, 13 Nov 2019 02:44:14 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id n12sm1238584lfh.36.2019.11.13.02.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 02:44:13 -0800 (PST)
Subject: Re: [PATCH] proc: Allow restricting permissions in /proc/sys
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org
References: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com>
 <20191113003524.GQ11244@42.do-not-panic.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <8942c5c9-f8b0-5c53-0fb6-ea816243bc22@gmail.com>
Date:   Wed, 13 Nov 2019 12:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113003524.GQ11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.11.2019 2.35, Luis Chamberlain wrote:
> On Mon, Nov 04, 2019 at 02:07:29PM +0200, Topi Miettinen wrote:
>> Several items in /proc/sys need not be accessible to unprivileged
>> tasks. Let the system administrator change the permissions, but only
>> to more restrictive modes than what the sysctl tables allow.
> 
> Thanks for taking the time for looking into this!
> 
> We don't get many eyeballs over this code, so while you're at it, if its
> not too much trouble and since it seems you care: can you list proc sys
> files which are glaring red flags to have their current defaults
> permissions?

I'm not aware if there are any problems with the defaults. It's just 
that the defaults make so many files available to unprivileged tasks, 
when in reality only a few of the files seem to be really needed or useful.

For example, going through the few Debian Code Search hits for 
/proc/sys/debug [1], it seems to me that the default could as well be 
0500 for the directory without breaking anything.

1: https://codesearch.debian.net/search?q=%2Fproc%2Fsys%2Fdebug&literal=1

>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>> ---
>> v2: actually keep track of changed permissions instead of relying on inode
>> cache
>> ---
>>   fs/proc/proc_sysctl.c  | 42 ++++++++++++++++++++++++++++++++++++++----
>>   include/linux/sysctl.h |  1 +
>>   2 files changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index d80989b6c344..1f75382c49fd 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
>> mask)
>>          if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>>                  return -EACCES;
>>
>> +       error = generic_permission(inode, mask);
>> +       if (error)
>> +               return error;
>> +
> 
> This alone checks to see if the inode's uid and gid are mapped to the
> current namespace, amonst other things. A worthy change in and of
> itself, worthy of it being a separate patch.

OK, will separate.

> Can it regress current uses? Well depends if namespaces exists today
> where root is not mapped to other namespaces, and if that was *expected*
> to work.
> 
>>          head = grab_header(inode);
>>          if (IS_ERR(head))
>>                  return PTR_ERR(head);
>> @@ -835,17 +839,46 @@ static int proc_sys_permission(struct inode *inode,
>> int mask)
>>   static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
>>   {
>>          struct inode *inode = d_inode(dentry);
>> +       struct ctl_table_header *head = grab_header(inode);
>> +       struct ctl_table *table = PROC_I(inode)->sysctl_entry;
>>          int error;
>>
>> -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
>> +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>>                  return -EPERM;
>>
>> +       if (attr->ia_valid & ATTR_MODE) {
>> +               umode_t max_mode = 0777; /* Only these bits may change */
>> +
>> +               if (IS_ERR(head))
>> +                       return PTR_ERR(head);
>> +
>> +               if (!table) /* global root - r-xr-xr-x */
>> +                       max_mode &= ~0222;
> 
> max_mode &= root->permissions(head, table) ?

Currently, writing is not allowed by default. For /proc/sys/net and 
/proc/sys/user, which grant write access to suitably ns_capable tasks, I 
think this would allow those tasks also to change the mode to world 
writable. So far, I've tried to allow only tightening of permissions.

> But why are we setting this? More in context below.
> 
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
> 
> Shouldn't this error path call sysctl_head_finish(head) ?

Right, will fix.

>> +                       return -EPERM;
>> +       }
>> +
>>          error = setattr_prepare(dentry, attr);
>>          if (error)
>>                  return error;
>>
>>          setattr_copy(inode, attr);
>>          mark_inode_dirty(inode);
>> +
>> +       if (table)
>> +               table->current_mode = inode->i_mode;
> 
> Here we only care about setting this current_mode if the
> table is set is present, but above we did some processing
> when it was not set. Why?

The processing above when there was no table was to ensure that there is 
some default (0444 for files, 0555 for directories). Here we store the 
changed mode to table, if it is present.

Though if there's no table, the change would remain only in the inode 
cache, so using the table for backing storage for the mode looks now to 
me as a bad idea. Perhaps struct proc_dir_entry should be used instead.

>> +       sysctl_head_finish(head);
>> +
>>          return 0;
>>   }
>>
>> @@ -861,7 +894,7 @@ static int proc_sys_getattr(const struct path *path,
>> struct kstat *stat,
>>
>>          generic_fillattr(inode, stat);
>>          if (table)
>> -               stat->mode = (stat->mode & S_IFMT) | table->mode;
>> +               stat->mode = (stat->mode & S_IFMT) | table->current_mode;
>>
>>          sysctl_head_finish(head);
>>          return 0;
>> @@ -981,7 +1014,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set
>> *set,
>>          memcpy(new_name, name, namelen);
>>          new_name[namelen] = '\0';
>>          table[0].procname = new_name;
>> -       table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>> +       table[0].current_mode = table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>>          init_header(&new->header, set->dir.header.root, set, node, table);
>>
>>          return new;
>> @@ -1155,6 +1188,7 @@ static int sysctl_check_table(const char *path, struct
>> ctl_table *table)
>>                  if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
>>                          err |= sysctl_err(path, table, "bogus .mode 0%o",
>>                                  table->mode);
>> +               table->current_mode = table->mode;
>>          }
>>          return err;
>>   }
>> @@ -1192,7 +1226,7 @@ static struct ctl_table_header *new_links(struct
>> ctl_dir *dir, struct ctl_table
>>                  int len = strlen(entry->procname) + 1;
>>                  memcpy(link_name, entry->procname, len);
>>                  link->procname = link_name;
>> -               link->mode = S_IFLNK|S_IRWXUGO;
>> +               link->current_mode = link->mode = S_IFLNK|S_IRWXUGO;
>>                  link->data = link_root;
>>                  link_name += len;
>>          }
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index 6df477329b76..7c519c35bf9c 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -126,6 +126,7 @@ struct ctl_table
>>          void *data;
>>          int maxlen;
>>          umode_t mode;
>> +       umode_t current_mode;
> 
> Please add kdoc, I know we don't have one, but we have to start, and
> explain at least that mode is the original intended settings, and that
> current_mode can only be stricter settings.

OK, if this remains instead of using proc_dir_entry for storing the mode.

> Also, I see your patch does a good sanity test on the input mask
> and returns it back, howevever, I don't see how proc_sys_permission()
> is using it?

It's not, but the inode mode is checked by generic_permission() added by 
the patch.

-Topi

