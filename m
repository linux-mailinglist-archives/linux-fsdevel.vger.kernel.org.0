Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6E3EE4CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 05:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhHQDNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 23:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhHQDNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:13:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB1BC061764;
        Mon, 16 Aug 2021 20:12:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e19so23127533pla.10;
        Mon, 16 Aug 2021 20:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hrnYNgTHtP48y0J2YUSyxhch0IRbl2Yj7gsmmJ00pXE=;
        b=RDugF2OQYQf8mxDPllRkkjfnJ2PyGzpbpgbv0meEBPbePUIRlk/+dkjsCIf9yHME7v
         qEV00kjUAFgqISq1dCSWzvt47kwtLJ+i/AL7zQ5A0TZqoW7LQDAGZnFb2oOL+pHGyyfr
         q6Q3woOQbC2nN7oB7cEZTfPv9XyXM5drcSOB8v6Ps5zTCC3GFK0pcdjin9b2Zc+AOrlq
         7K6CH8H/VGj9KpyqFmh7cjQ5Fzs7Hd/an04qiSMrsV0MqGISQTKMSAuZ374GE+PkwVwk
         VBM8SbIGCAz31G8yYLDMTGmKopzXlE9jLzpqaF4Lk/6iNUBtsFktld63ck6az2lyRMin
         RKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hrnYNgTHtP48y0J2YUSyxhch0IRbl2Yj7gsmmJ00pXE=;
        b=ldxe1BjRmLsJ5JVNe8Jrm6xHv3v5bvgKEVDyRtKm6irSDqzlJ9sIT6CQFBlaZy8DSb
         i97rBU9xF/I2L+oyUo1SLsfkXlmdIjgGxurtLeb2psfD4gK3clHP2YBn1QQbn4lnKPRc
         xHCP8ghhunIj6RsvTdP+D03g7y5ypIPxqpqoJlp+B3fkIo9ujnkByhJ7gwd96fep309l
         +QFAVspd8gajc2PrGMOuB5iKUAJIbMArkFLBpMuwMdKOq4tSCMJ42BnH7lEgu3UoMz3D
         ltFhzZDqR15dwi1sYhedYGt6+W7BVRL9Vmx786pkC1wegXA60OWRNRPQfOClH+BMKbJ9
         m70w==
X-Gm-Message-State: AOAM532pzJDSy+VvjMrqHrd+DfDjOT+uZ6CzelxoOzdYhmOQu0YSHfAZ
        Vbe6A979dwVxhdTJOoFJdK0=
X-Google-Smtp-Source: ABdhPJxQNUXAe/hWVwHtv+wuQqE2SRkk7C9BfpyhuzN00jUTZ7d0MreeN+6YhZwCpX1+bYMxj9vazg==
X-Received: by 2002:aa7:8b07:0:b029:2f7:d38e:ff1 with SMTP id f7-20020aa78b070000b02902f7d38e0ff1mr1391373pfd.72.1629169949165;
        Mon, 16 Aug 2021 20:12:29 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id y23sm654045pgf.38.2021.08.16.20.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 20:12:28 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man <linux-man@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHi, man-pages] mount_namespaces.7: More clearly explain
 "locked mounts"
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <20210813220120.502058-1-mtk.manpages@gmail.com>
 <87r1et1io8.fsf@disp2133>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <56bbb8ed-8ecf-a0be-5253-350727ae1d24@gmail.com>
Date:   Tue, 17 Aug 2021 05:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87r1et1io8.fsf@disp2133>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

Thanks for your feedback!

On 8/16/21 6:03 PM, Eric W. Biederman wrote:
> Michael Kerrisk <mtk.manpages@gmail.com> writes:
> 
>> For a long time, this manual page has had a brief discussion of
>> "locked" mounts, without clearly saying what this concept is, or
>> why it exists. Expand the discussion with an explanation of what
>> locked mounts are, why mounts are locked, and some examples of the
>> effect of locking.
>>
>> Thanks to Christian Brauner for a lot of help in understanding
>> these details.
>>
>> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
>> Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
>> ---
>>
>> Hello Eric and others,
>>
>> After some quite helpful info from Chrstian Brauner, I've expanded
>> the discussion of locked mounts (a concept I didn't really have a
>> good grasp on) in the mount_namespaces(7) manual page. I would be
>> grateful to receive review comments, acks, etc., on the patch below.
>> Could you take a look please?
>>
>> Cheers,
>>
>> Michael
>>
>>  man7/mount_namespaces.7 | 73 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>
>> diff --git a/man7/mount_namespaces.7 b/man7/mount_namespaces.7
>> index e3468bdb7..97427c9ea 100644
>> --- a/man7/mount_namespaces.7
>> +++ b/man7/mount_namespaces.7
>> @@ -107,6 +107,62 @@ operation brings across all of the mounts from the original
>>  mount namespace as a single unit,
>>  and recursive mounts that propagate between
>>  mount namespaces propagate as a single unit.)
>> +.IP
>> +In this context, "may not be separated" means that the mounts
>> +are locked so that they may not be individually unmounted.
>> +Consider the following example:
>> +.IP
>> +.RS
>> +.in +4n
>> +.EX
>> +$ \fBsudo mkdir /mnt/dir\fP
>> +$ \fBsudo sh \-c \(aqecho "aaaaaa" > /mnt/dir/a\(aq\fP
>> +$ \fBsudo mount \-\-bind -o ro /some/path /mnt/dir\fP
>> +$ \fBls /mnt/dir\fP   # Former contents of directory are invisible
> 
> Do we want a more motivating example such as a /proc/sys?
> 
> It has been common to mount over /proc files and directories that can be
> written to by the global root so that users in a mount namespace may not
> touch them.

Seems reasonable. But I want to check one thing. Can you please
define "global root". I'm pretty sure I know what you mean, but
I'd like to know your definition.

>> +.EE
>> +.in
>> +.RE
>> +.IP
>> +The above steps, performed in a more privileged user namespace,
>> +have created a (read-only) bind mount that
>> +obscures the contents of the directory
>> +.IR /mnt/dir .
>> +For security reasons, it should not be possible to unmount
>> +that mount in a less privileged user namespace,
>> +since that would reveal the contents of the directory
>> +.IR /mnt/dir .
>  > +.IP
>> +Suppose we now create a new mount namespace
>> +owned by a (new) subordinate user namespace.
>> +The new mount namespace will inherit copies of all of the mounts
>> +from the previous mount namespace.
>> +However, those mounts will be locked because the new mount namespace
>> +is owned by a less privileged user namespace.
>> +Consequently, an attempt to unmount the mount fails:
>> +.IP
>> +.RS
>> +.in +4n
>> +.EX
>> +$ \fBsudo unshare \-\-user \-\-map\-root\-user \-\-mount \e\fP
>> +               \fBstrace \-o /tmp/log \e\fP
>> +               \fBumount /mnt/dir\fP
>> +umount: /mnt/dir: not mounted.
>> +$ \fBgrep \(aq^umount\(aq /tmp/log\fP
>> +umount2("/mnt/dir", 0)     = \-1 EINVAL (Invalid argument)
>> +.EE
>> +.in
>> +.RE
>> +.IP
>> +The error message from
>> +.BR mount (8)
>> +is a little confusing, but the
>> +.BR strace (1)
>> +output reveals that the underlying
>> +.BR umount2 (2)
>> +system call failed with the error
>> +.BR EINVAL ,
>> +which is the error that the kernel returns to indicate that
>> +the mount is locked.
> 
> Do you want to mention that you can unmount the entire subtree?  Either
> with pivot_root if it is locked to "/" or with
> "umount -l /path/to/propagated/directory".

Yes, I wondered about that, but hadn't got round to devising 
the scenario. How about this:

[[
       *  Following on from the previous point, note that it is possible
          to unmount an entire tree of mounts that propagated as a unit
          into a mount namespace that is owned by a less privileged user
          namespace, as illustrated in the following example.

          First, we create new user and mount namespaces using
          unshare(1).  In the new mount namespace, the propagation type
          of all mounts is set to private.  We then create a shared bind
          mount at /mnt, and a small hierarchy of mount points underneath
          that mount point.

              $ PS1='ns1# ' sudo unshare --user --map-root-user \
                                     --mount --propagation private bash
              ns1# echo $$        # We need the PID of this shell later
              778501
              ns1# mount --make-shared --bind /mnt /mnt
              ns1# mkdir /mnt/x
              ns1# mount --make-private -t tmpfs none /mnt/x
              ns1# mkdir /mnt/x/y
              ns1# mount --make-private -t tmpfs none /mnt/x/y
              ns1# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
              986 83 8:5 /mnt /mnt rw,relatime shared:344
              989 986 0:56 / /mnt/x rw,relatime
              990 989 0:57 / /mnt/x/y rw,relatime

          Continuing in the same shell session, we then create a second
          shell in a new mount namespace and a new subordinate (and thus
          less privileged) user namespace and check the state of the
          propagated mount points rooted at /mnt.

              ns1# PS1='ns2# unshare --user --map-root-user \
                                     --mount --propagation unchanged bash
              ns2# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
              1239 1204 8:5 /mnt /mnt rw,relatime master:344
              1240 1239 0:56 / /mnt/x rw,relatime
              1241 1240 0:57 / /mnt/x/y rw,relatime

          Of note in the above output is that the propagation type of the
          mount point /mnt has been reduced to slave, as explained near
          the start of this subsection.  This means that submount events
          will propagate from the master /mnt in "ns1", but propagation
          will not occur in the opposite direction.

          From a separate terminal window, we then use nsenter(1) to
          enter the mount and user namespaces corresponding to "ns1".  In
          that terminal window, we then recursively bind mount /mnt/x at
          the location /mnt/ppp.

              $ PS1='ns3# ' sudo nsenter -t 778501 --user --mount
              ns3# mount --rbind --make-private /mnt/x /mnt/ppp
              ns3# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
              986 83 8:5 /mnt /mnt rw,relatime shared:344
              989 986 0:56 / /mnt/x rw,relatime
              990 989 0:57 / /mnt/x/y rw,relatime
              1242 986 0:56 / /mnt/ppp rw,relatime
              1243 1242 0:57 / /mnt/ppp/y rw,relatime shared:518

          Because the propagation type of the parent mount, /mnt, was
          shared, the recursive bind mount propagated a small tree of
          mounts under the slave mount /mnt into "ns2", as can be
          verified by executing the following command in that shell
          session:

              ns2# grep /mnt /proc/self/mountinfo | sed 's/ - .*//'
              1239 1204 8:5 /mnt /mnt rw,relatime master:344
              1240 1239 0:56 / /mnt/x rw,relatime
              1241 1240 0:57 / /mnt/x/y rw,relatime
              1244 1239 0:56 / /mnt/ppp rw,relatime
              1245 1244 0:57 / /mnt/ppp/y rw,relatime master:518

          While it is not possible to unmount a part of that propagated
          subtree (/mnt/ppp/y), it is possible to unmount the entire
          tree, as shown by the following commands:

              ns2# umount /mnt/ppp/y
              umount: /mnt/ppp/y: not mounted.
              ns2# umount -l /mnt/ppp | sed 's/ - .*//'      # Succeeds...
              ns2# grep /mnt /proc/self/mountinfo
              1239 1204 8:5 /mnt /mnt rw,relatime master:344
              1240 1239 0:56 / /mnt/x rw,relatime
              1241 1240 0:57 / /mnt/x/y rw,relatime
]]

?

Thanks,

Michael

> 
>>  .IP *
>>  The
>>  .BR mount (2)
>> @@ -128,6 +184,23 @@ settings become locked
>>  when propagated from a more privileged to
>>  a less privileged mount namespace,
>>  and may not be changed in the less privileged mount namespace.
>> +.IP
>> +This point can be illustrated by a continuation of the previous example.
>> +In that example, the bind mount was marked as read-only.
>> +For security reasons,
>> +it should not be possible to make the mount writable in
>> +a less privileged namespace, and indeed the kernel prevents this,
>> +as illustrated by the following:
>> +.IP
>> +.RS
>> +.in +4n
>> +.EX
>> +$ \fBsudo unshare \-\-user \-\-map\-root\-user \-\-mount \e\fP
>> +               \fBmount \-o remount,rw /mnt/dir\fP
>> +mount: /mnt/dir: permission denied.
>> +.EE
>> +.in
>> +.RE
>>  .IP *
>>  .\" (As of 3.18-rc1 (in Al Viro's 2014-08-30 vfs.git#for-next tree))
>>  A file or directory that is a mount point in one namespace that is not
> 
> Eric
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
