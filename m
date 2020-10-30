Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0CD2A0A92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 17:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJ3QAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJ3QAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:00:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25865C0613D7
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 09:00:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b19so3172400pld.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kKt7pHAKQpnFJF12jxzi9fLLgrjsbw4l8hL54Ww6iU8=;
        b=NahNG3PvD8Awiwv/sUn2qOB5hiM+g/VNjnR6xA9UfRw77lqHX8DS5k2mmtDndEYvNd
         TcyBWTeyzvogkivnYN2KpUOchUBCBDW7MYh6c9gQrk7yQwNRehqBlVy9stqHFQCKXAxp
         mAruZcvz17zbcOVZyupeN2LEHIVlEcuF0kA6OM7kluy4kBKGICzQO7TRVFtGhRYgm4G/
         epGDpjWJAhgVJvmjQl9VvC9Y+rMPrLfKjO1W8hFKx/Hsjx8kxaBOgURdl7CPgVj/ADZE
         Ry2cFQhksssN5Qc2L5GciynEZYukVYwGVdv+MPS8Jl7m/B6eenSqJIp3iOM3sAYOmzCD
         qFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kKt7pHAKQpnFJF12jxzi9fLLgrjsbw4l8hL54Ww6iU8=;
        b=e3gwau0ZSpTfGidV4VybkdAPBe7qfSRl4EPX0/KCFBAQaQF4UrigvKQ+2nwapZMMlw
         tYU/MERqQ+hY7uDNFza0Netad5Q28gQKiiXFFexlYRglOW3re/+0LVusmGDfVpRyg3xU
         qo+WC8dkAbI+oJ05HGTDvWX6ctZn36Jab1MSD1a558N6/dVZFGv0Qg3PbFDBJNejuJro
         4rlKDBlPuL3UUxKT9YFVYM8fC/AWAyoj/77YmISQq5Xp6fouXlP9kEUWPXKxdVOg7/vB
         xePWKRztugUYip/9dx2F1F8C0YU5bhGcmozKK0OAn5P/3yeI0t/uoylkaYzmVzFahpPH
         snhw==
X-Gm-Message-State: AOAM531Ih8wZKICRc1vjGWshy6Kmarzhmquq3GI3pjU6EIjPHX1OGDJw
        LY/Dweoy/sM+vpURELmdWytsIA==
X-Google-Smtp-Source: ABdhPJyFHNJ15LoD22fVBqJzTUJvOmXvhHBsh0O/WA1uU8bivi1QJRg5Mzi9O6wFnruxqZUW2T202g==
X-Received: by 2002:a17:902:8f87:b029:d6:8da3:96ec with SMTP id z7-20020a1709028f87b02900d68da396ecmr7812217plo.55.1604073637475;
        Fri, 30 Oct 2020 09:00:37 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:4a0f:cfff:fe35:d61b])
        by smtp.googlemail.com with ESMTPSA id e20sm6058721pgr.54.2020.10.30.09.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 09:00:36 -0700 (PDT)
Subject: Re: [RESEND PATCH v18 2/4] overlayfs: handle XATTR_NOSECURITY flag
 for get xattr method
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>, linux-doc@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
References: <20201021151903.652827-1-salyzyn@android.com>
 <20201021151903.652827-3-salyzyn@android.com>
 <CAJfpegtMoD85j5namV592sJD23QeUMD=+tq4SvFDqjVxsAszYQ@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <2fd64e4f-c573-c841-abb6-ec0908f78cdd@android.com>
Date:   Fri, 30 Oct 2020 09:00:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegtMoD85j5namV592sJD23QeUMD=+tq4SvFDqjVxsAszYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 8:07 AM, Miklos Szeredi wrote:
> On Wed, Oct 21, 2020 at 5:19 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> Because of the overlayfs getxattr recursion, the incoming inode fails
>> to update the selinux sid resulting in avc denials being reported
>> against a target context of u:object_r:unlabeled:s0.
>>
>> Solution is to respond to the XATTR_NOSECURITY flag in get xattr
>> method that calls the __vfs_getxattr handler instead so that the
>> context can be read in, rather than being denied with an -EACCES
>> when vfs_getxattr handler is called.
>>
>> For the use case where access is to be blocked by the security layer.
>>
>> The path then would be security(dentry) ->
>> __vfs_getxattr({dentry...XATTR_NOSECURITY}) ->
>> handler->get({dentry...XATTR_NOSECURITY}) ->
>> __vfs_getxattr({realdentry...XATTR_NOSECURITY}) ->
>> lower_handler->get({realdentry...XATTR_NOSECURITY}) which
>> would report back through the chain data and success as expected,
>> the logging security layer at the top would have the data to
>> determine the access permissions and report back to the logs and
>> the caller that the target context was blocked.
>>
>> For selinux this would solve the cosmetic issue of the selinux log
>> and allow audit2allow to correctly report the rule needed to address
>> the access problem.
>>
>> Check impure, opaque, origin & meta xattr with no sepolicy audit
>> (using __vfs_getxattr) since these operations are internal to
>> overlayfs operations and do not disclose any data.  This became
>> an issue for credential override off since sys_admin would have
>> been required by the caller; whereas would have been inherently
>> present for the creator since it performed the mount.
>>
>> This is a change in operations since we do not check in the new
>> ovl_do_getxattr function if the credential override is off or not.
>> Reasoning is that the sepolicy check is unnecessary overhead,
>> especially since the check can be expensive.
>>
>> Because for override credentials off, this affects _everyone_ that
>> underneath performs private xattr calls without the appropriate
>> sepolicy permissions and sys_admin capability.  Providing blanket
>> support for sys_admin would be bad for all possible callers.
>>
>> For the override credentials on, this will affect only the mounter,
>> should it lack sepolicy permissions. Not considered a security
>> problem since mounting by definition has sys_admin capabilities,
>> but sepolicy contexts would still need to be crafted.
> This would be a problem when unprivileged mounting of overlay is
> introduced.  I'd really like to avoid weakening the current security
> model.

The current security model does not deal with non-overlapping security 
contexts between init (which on android has MAC permissions only when 
necessary, only enough permissions to perform the mount and other 
mundane operations, missing exec and read permissions in key spots) and 
user calls.

We are only weakening (that is actually an incorrect statement, security 
is there, just not double security of both mounter and caller) the 
security around calls that retrieve the xattr for administrative and 
internal purposes. No data is exposed to the caller that it would not 
otherwise have permissions for.

This patch becomes necessary when matched with the PATCH v18 3/4 of the 
series which fixes the user space break introduced in ~4.6 that formerly 
used the callers credentials for all accesses in all places. Security is 
weakened already as-is in overlayfs with all the overriding of the 
credentials for internal accesses to overlayfs mechanics based on the 
mounter credentials. Using the mounter credentials as a wider security 
hole is the problem, at least with PATCH v18 3/4 of the series we go 
back optionally to only using the caller's credentials to perform the 
operations. Admittedly some of the internal operations like mknod are 
privileged, but at least in Android's use case we are not using them 
with callers without the necessary credentials.

Android does not give the mounter more credentials than the callers, 
there is very little overlap in the MAC security.

> The big API churn in the 1/4 patch also seems excessive considering
> that this seems to be mostly a cosmetic issue for android.  Am I
> missing something?

Breaks sepolicy, it no longer has access to the context data at the 
overlayfs security boundary.

unknown is a symptom of being denied based on the denial to xattr data 
from the underlying filesystem layer. Being denied the security context 
of the target is not a good thing within the sepolicy security layer.

>
> Thanks,
> Miklos


