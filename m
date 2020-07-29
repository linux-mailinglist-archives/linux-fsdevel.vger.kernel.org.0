Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935432324D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgG2Srr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgG2Srr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:47:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BDEC0619D2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 11:47:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 2so19142985qkf.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=de92zVYajUZRhB1uxDhwk9+GWBtXRj8Z9N8YqTT4pXA=;
        b=tulOiKgwhpXla1+dxpXaNWsRkCJ6mqgeNv1wePakOerlPst9LSR8Oi165paGpcPkxE
         Kp9DPcVm797w0sgwqPXc7A2VwW4rU4n5ayMEgKHtZ++NSvRc3jJqJWctzozvy0sR2qzn
         Tw5+eRfsYxlM3sVvSwM/oeBwbmh9B6QskAYiimaHJPLToJJT9GnsXClPDCLFZgP4bBMO
         C8U4geZPUs2F3AXkZm3HXw+Up1WyW9/Lj1YsmZLzQJdYUrFhGOiAdWyGPdLEmWLmNtf4
         jApkbJdSlS7DWvEy2BNxbll75JfOZ7luEllg6d51ZQBtvI2CZc8q7WJY1n0Hjxu+M4Fi
         reCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=de92zVYajUZRhB1uxDhwk9+GWBtXRj8Z9N8YqTT4pXA=;
        b=Cfdq2feiOYFQ//Tj3j2yE5T4travxh6hR/lqAFb8BzRPvjwOPhcHxrT3MYMt/a9JV3
         hV95mOEZZFoGK6FCoIs6eK6M29xG8vRjNarBPJLtmWTAobp42/jwRgxGi6d4CUhM1i/7
         DUO0a13hAKkPMTBKEpS4b9Gr+8wXO0Ip8aSOOippazVfn2yYt+WsgVKx2oT1CMwpKtNE
         5mwEUwUoIgzrmwpjCwJlV6iaMNMSEHWpI9LmFK9pbyJo7covQvbgmIHnYw5924HQD9pZ
         Uw98NgB53Tplm6E8HTPsPpd46NPqWG4En7a5QpYREFKspfGpoXkWtOcf8Q02Wlk6jUay
         o//Q==
X-Gm-Message-State: AOAM530FgViQLg3lrXMS/qv4u9jGY3fvI8Fduh0m3uOo1T5CoQYl6rex
        Juj7wNmyAKIwxX+GTr6sRLr5IQ==
X-Google-Smtp-Source: ABdhPJy+qIWfZGcgwPuaP0Yke5sjGxIvpb/hZbPh59TzQelDx2QYkw7+P7jjnyXIDnBgeCK4CFiCdw==
X-Received: by 2002:a37:517:: with SMTP id 23mr35137201qkf.63.1596048465682;
        Wed, 29 Jul 2020 11:47:45 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e1::10a7? ([2620:10d:c091:480::1:2ed9])
        by smtp.gmail.com with ESMTPSA id c133sm2231150qkb.111.2020.07.29.11.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 11:47:44 -0700 (PDT)
Subject: Re: Inverted mount options completely broken (iversion,relatime)
To:     Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <0b154b9b-728f-7d57-d4c5-ec25fc9dfdf3@toxicpanda.com>
 <1f56432b-a245-a010-51fd-814a9cf4e2b1@redhat.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b8c98c88-d6e2-de53-5906-27970d23c0b2@toxicpanda.com>
Date:   Wed, 29 Jul 2020 14:47:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1f56432b-a245-a010-51fd-814a9cf4e2b1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/29/20 2:41 PM, Eric Sandeen wrote:
> On 7/29/20 11:32 AM, Josef Bacik wrote:
>> Hello,
>>
>> Eric reported a problem to me where we were clearing SB_I_VERSION on remount of a btrfs file system.  After digging through I discovered it's because we expect the proper flags that we want to be passed in via the mount() syscall, and because we didn't have "iversion" in our show_options entry the mount binary (form util-linux) wasn't setting MS_I_VERSION for the remount, and thus the VFS was clearing SB_I_VERSION from our s_flags.
>>
>> No big deal, I'll fix show_mount.  Except Eric then noticed that mount -o noiversion didn't do anything, we still get iversion set.  That's because btrfs just defaults to having SB_I_VERSION set.  Furthermore -o noiversion doesn't get sent into mount, it's handled by the mount binary itself, and it does this by not having MS_I_VERSION set in the mount flags.
> 
> This was beaten^Wdiscussed to death in an earlier thread,
> [PATCH] fs: i_version mntopt gets visible through /proc/mounts
> 
> https://lore.kernel.org/linux-fsdevel/20200616202123.12656-1-msys.mizuma@gmail.com/
> 
> tl;dr: hch doesn't think [no]iversion should be exposed as an option /at all/
> so exposing it in /proc/mounts in show_mnt_opts for mount(8)'s benefit was
> nacked.
> 
>> This happens as well for -o relatime, it's the default and so if you do mount -o norelatime it won't do anything, you still get relatime behavior.
> 
> I think that's a different issue.
> 
>> The only time this changes is if you do mount -o remount,norelatime.
> 
> Hm, not on xfs:
> 
> # mount -o loop,norelatime xfsfile  mnt
> # grep loop /proc/mounts
> /dev/loop0 /tmp/mnt xfs rw,seclabel,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0
> 
> # mount -o remount,norelatime mnt
> # grep loop /proc/mounts
> /dev/loop0 /tmp/mnt xfs rw,seclabel,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0
> 

Oops you're right, I'm blind.  Same happens for btrfs, so using -o norelatime 
simply does nothing because it's considered a kernel wide default.

> 
> Are there other oddities besides iversion and relatime?

It doesn't look like it, I checked a few others of the MS_INVERT variety, these 
appear to be the only ones.  I really don't want to have this discussion again 
in the future tho when we introduce MS_SOME_NEW_AWESOME.  Thanks,

Josef

