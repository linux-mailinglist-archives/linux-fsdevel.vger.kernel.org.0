Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086C9243D53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHMQZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 12:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHMQZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:25:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E61CC061757;
        Thu, 13 Aug 2020 09:25:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so5709858qka.3;
        Thu, 13 Aug 2020 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MowTd3fsw3oazxlDPxjuTvtQgpHnYsiLm67c7t1uMu4=;
        b=lMzKV2+6SLZsfczlHACdvtAjRypFyTbivwvbglrFIhpv0v4R52VGs1dhSOGH3AI4fG
         9rewbvFk31UUfusXGm+vHe/chH7G/AGGp0zDu55kyZpoZ0AGttjkN5x3SRydNo7AdopN
         4atvqzECauZvT/pUCB18iVQYe6xQ3ExVRTMbCuX1MXJ/N1+9ZYjmHkl4zrYOObI6rLi4
         j4B1dEv+JKOuio70NJDPF37KpXlAElKaQ0ShoxbjFUa1upcJGGdSIMQUfEiWEV6nsA45
         4dNfe2MJ/raZggw7ovMO6d/rp5IT1tCv8EfUfRn4paU9a5NLsdN/Gm1vJOjVCeAOW98d
         Frzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MowTd3fsw3oazxlDPxjuTvtQgpHnYsiLm67c7t1uMu4=;
        b=S9+EIjcafougyo+AvYLd5XadWrpYdP91Fv1M5S+BVxlYdlqYGR0+t2u3kooNxdmEqH
         AVwLLaWAZCK6mpxOKxtmls16XZBNUpMIVjovVhOiqRrE+y3Q7RzASIPL/d29nsUxUNRr
         iWjC+ccJUyv4FE2Q3H2oItGAglCxtAh4w2N3pBcKjQsTz/BCAkMVKqzR7iVtksH30ADw
         iEr6/obu0xJuhV5+bMHYe6FXH0opmDYQp25oY28RFu+lJcMlxPo5cVyIPZOnejg0L5xL
         ZuVvf9NA1OQEvAXjNAOynSpUaBn2nh1F++yMXkN3GRV23JfkGmqE8hprVUkA5NrdY1Bk
         70sQ==
X-Gm-Message-State: AOAM5320oX+zKIkWND6C0sH0kbZ/E0+yzfzlpObav4jQB2gg7095LYP5
        CvKahuZ86lzCneAPvWOitb8=
X-Google-Smtp-Source: ABdhPJyRs07qIHgN2eVDBdyM9K3v8au2o1CX7eH3HCQS7cFm9obu67iV+hMQD01HGDWl3aTS2yHdjg==
X-Received: by 2002:a37:b787:: with SMTP id h129mr5168271qkf.402.1597335958375;
        Thu, 13 Aug 2020 09:25:58 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id w12sm5564438qkj.116.2020.08.13.09.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 09:25:57 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] selinux: Create new booleans and class dirs out of
 tree
To:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
 <20200812191525.1120850-5-dburgener@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <8540e665-1722-35f9-ec39-f4038e1f90ca@gmail.com>
Date:   Thu, 13 Aug 2020 12:25:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812191525.1120850-5-dburgener@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/20 3:15 PM, Daniel Burgener wrote:

> In order to avoid concurrency issues around selinuxfs resource availability
> during policy load, we first create new directories out of tree for
> reloaded resources, then swap them in, and finally delete the old versions.
>
> This fix focuses on concurrency in each of the three subtrees swapped, and
> not concurrency across the three trees.  This means that it is still possible
> that subsequent reads to eg the booleans directory and the class directory
> during a policy load could see the old state for one and the new for the other.
> The problem of ensuring that policy loads are fully atomic from the perspective
> of userspace is larger than what is dealt with here.  This commit focuses on
> ensuring that the directories contents always match either the new or the old
> policy state from the perspective of userspace.
>
> In the previous implementation, on policy load /sys/fs/selinux is updated
> by deleting the previous contents of
> /sys/fs/selinux/{class,booleans} and then recreating them.  This means
> that there is a period of time when the contents of these directories do not
> exist which can cause race conditions as userspace relies on them for
> information about the policy.  In addition, it means that error recovery in
> the event of failure is challenging.
>
> In order to demonstrate the race condition that this series fixes, you
> can use the following commands:
>
> while true; do cat /sys/fs/selinux/class/service/perms/status
>> /dev/null; done &
> while true; do load_policy; done;
>
> In the existing code, this will display errors fairly often as the class
> lookup fails.  (In normal operation from systemd, this would result in a
> permission check which would be allowed or denied based on policy settings
> around unknown object classes.) After applying this patch series you
> should expect to no longer see such error messages.
>
> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> ---
>   security/selinux/selinuxfs.c | 145 +++++++++++++++++++++++++++++------
>   1 file changed, 120 insertions(+), 25 deletions(-)
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f09afdb90ddd..d3a19170210a 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> +	tmp_policycap_dir = sel_make_dir(tmp_parent, POLICYCAP_DIR_NAME, &fsi->last_ino);
> +	if (IS_ERR(tmp_policycap_dir)) {
> +		ret = PTR_ERR(tmp_policycap_dir);
> +		goto out;
> +	}

No need to re-create this one.

> -	return 0;
> +	// booleans
> +	old_dentry = fsi->bool_dir;
> +	lock_rename(tmp_bool_dir, old_dentry);
> +	ret = vfs_rename(tmp_parent->d_inode, tmp_bool_dir, fsi->sb->s_root->d_inode,
> +			 fsi->bool_dir, NULL, RENAME_EXCHANGE);

One issue with using vfs_rename() is that it will trigger all of the 
permission checks associated with renaming, and previously this was 
never required for selinuxfs and therefore might not be allowed in some 
policies even to a process allowed to reload policy.  So if you need to 
do this, you may want to override creds around this call to use the init 
cred (which will still require allowing it to the kernel domain but not 
necessarily to the process that is performing the policy load).  The 
other issue is that you then have to implement a rename inode operation 
and thus technically it is possible for userspace to also attempt 
renames on selinuxfs to the extent allowed by policy.  I see that 
debugfs has a debugfs_rename() that internally uses simple_rename() but 
I guess that doesn't cover the RENAME_EXCHANGE case.

> +	// Since the other temporary dirs are children of tmp_parent
> +	// this will handle all the cleanup in the case of a failure before
> +	// the swapover

Don't use // style comments please, especially not for multi-line 
comments.  I think they are only used in selinux for the 
script-generated license lines.

> +static struct dentry *sel_make_disconnected_dir(struct super_block *sb,
> +						unsigned long *ino)
> +{
> +	struct inode *inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
> +
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +
> +	inode->i_op = &sel_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	inode->i_ino = ++(*ino);
> +	/* directory inodes start off with i_nlink == 2 (for "." entry) */
> +	inc_nlink(inode);
> +	return d_obtain_alias(inode);
> +}
> +

Since you are always incrementing the last_ino counter and never reusing 
the ones for the removed inodes, you could technically eventually end up 
with one of these directories have the same inode number as one of the 
inodes whose inode numbers are generated in specific ranges (i.e. for 
initial_contexts, booleans, classes, and policy capabilities). Optimally 
we'd just reuse the inode number for the inode we are replacing?


