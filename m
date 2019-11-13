Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A15FAEFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 11:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKMKwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 05:52:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33598 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfKMKwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:52:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id t5so2062701ljk.0;
        Wed, 13 Nov 2019 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Ypz5d/EIOPP3+HgUGxWHqAdsciGE/zJP/FpY+Rga3WE=;
        b=stnNNsN/sfAxPgiBtWDZj00CJI0auiagHBLWp7ywLng3NGgC00xPZQ6N3c/TgoSBSw
         UldL3aKv/EVTpoXtF5TbxwzxWSrtRUMb67AVtCouH3nePmLbjEbunHen3z2ICaSkd99m
         3sN1fMrbOr8mk/sm50/+LD1Kyf8jqBCdrvhxVGUXCOOrPQv2Eeg5aCqdEAZrYHyWvwHC
         OtBvZrm8nvRIEMF3ad6LPv+0j2C0lM6qikbjkJDVn0GnwtpNvJrguwuKuUrA0CXSDEUG
         jGef7C6p+1WzsESliOiLxuGYlkm2kAkmj8kiS8VcmW2AmYPR2G3VUcZcWcpyiy7Qttgm
         3g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ypz5d/EIOPP3+HgUGxWHqAdsciGE/zJP/FpY+Rga3WE=;
        b=FOk9jXrMI3K3Zw1E6xKAyo3Tc61/jmsk7bdQE/xpfjuiu/u1LM3O4dhj+wlRn7UPX8
         KrjkCBhXW9jjA2QK2I7v64psQG0cssjrrxMjvuyzpdiRU5OQ5IlayemDTG5dcnLjPEJO
         CCWu50Nd3QvscxtsdZruXIDOTJ96FujTZtmq5Rlz9v7s1pY9rAnTkO7EoJHccLas+nMa
         BRRx0R+RqCYpxnEatXWtx4X7LiedgY7gPuYFtuX7qydVgS4QP846dWM8BbKmooRZOEj9
         ksjJQLldtFCmFnIspvKyaNy1DV+Ke70fImq7ExaV/O5PAK4iiMDTSaW+o7xITb1CPpGa
         xAtw==
X-Gm-Message-State: APjAAAXT29AOAAmhQbNnObzoHGHWBPOTQRR6iMmGv21Hljc8dNUMQJnl
        18aYUo6TI4wWEUyoOmKm9Og=
X-Google-Smtp-Source: APXvYqxTIaFXx7+vrJZk0Tb0sXjmjzbZPFYZVWLtIiEKoaaXbqHjUi3uPPdwmrlXOk8Y2QR0IezC4g==
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr1940598ljo.221.1573642324819;
        Wed, 13 Nov 2019 02:52:04 -0800 (PST)
Received: from [192.168.1.36] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id z20sm1208922ljj.85.2019.11.13.02.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 02:52:04 -0800 (PST)
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
 <20191112232239.yevpeemgxz4wy32b@wittgenstein>
 <CALCETrUEQMdugz1t6HfK5MvDq_kOw13yuF+98euqVJgZ4WR1VA@mail.gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <0ba24187-caf6-c851-baaa-f768885cda47@gmail.com>
Date:   Wed, 13 Nov 2019 12:52:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUEQMdugz1t6HfK5MvDq_kOw13yuF+98euqVJgZ4WR1VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.11.2019 6.50, Andy Lutomirski wrote:
> On Tue, Nov 12, 2019 at 3:22 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
>>
>> [Cc+ linux-api@vger.kernel.org]
>>
>> since that's potentially relevant to quite a few people.
>>
>> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
>>> Several items in /proc/sys need not be accessible to unprivileged
>>> tasks. Let the system administrator change the permissions, but only
>>> to more restrictive modes than what the sysctl tables allow.
>>>
>>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>> ---
>>>   fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
>>>   1 file changed, 31 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>>> index d80989b6c344..88c4ca7d2782 100644
>>> --- a/fs/proc/proc_sysctl.c
>>> +++ b/fs/proc/proc_sysctl.c
>>> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
>>> mask)
>>>          if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>>>                  return -EACCES;
>>>
>>> +       error = generic_permission(inode, mask);
>>> +       if (error)
>>> +               return error;
>>> +
>>>          head = grab_header(inode);
>>>          if (IS_ERR(head))
>>>                  return PTR_ERR(head);
>>> @@ -837,9 +841,35 @@ static int proc_sys_setattr(struct dentry *dentry,
>>> struct iattr *attr)
>>>          struct inode *inode = d_inode(dentry);
>>>          int error;
>>>
>>> -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
>>> +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>>>                  return -EPERM;
> 
> Supporting at least ATTR_GID would make this much more useful.

Yes, also XATTR/ACL support would be useful. But so far I've tried to 
allow only tightening of permissions.

>>>
>>> +       if (attr->ia_valid & ATTR_MODE) {
>>> +               struct ctl_table_header *head = grab_header(inode);
>>> +               struct ctl_table *table = PROC_I(inode)->sysctl_entry;
>>> +               umode_t max_mode = 0777; /* Only these bits may change */
>>> +
>>> +               if (IS_ERR(head))
>>> +                       return PTR_ERR(head);
>>> +
>>> +               if (!table) /* global root - r-xr-xr-x */
>>> +                       max_mode &= ~0222;
>>> +               else /*
>>> +                     * Don't allow permissions to become less
>>> +                     * restrictive than the sysctl table entry
>>> +                     */
>>> +                       max_mode &= table->mode;
> 
> Style nit: please put braces around multi-line if and else branches,
> even if they're only multi-line because of comments.

OK, thanks.

>>> +
>>> +               sysctl_head_finish(head);
>>> +
>>> +               /* Execute bits only allowed for directories */
>>> +               if (!S_ISDIR(inode->i_mode))
>>> +                       max_mode &= ~0111;
> 
> Why is this needed?
> 

In general, /proc/sys does not allow executable permissions for the 
files, so I've continued this policy.

-Topi
