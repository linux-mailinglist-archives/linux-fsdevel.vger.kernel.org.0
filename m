Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4E3611F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhDOSS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhDOSS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:18:27 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B000C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:18:02 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d15so13211074qkc.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FboUBx+M7wiC2Vc9ohnMu1xFLntMIR1IX9IeLkEPHjI=;
        b=B03mrf5IAbFUf4B8lNYRNg/BJbtQSZsQEhMlkF6ndvHEbOuxkenRmydetxWF7gzpTT
         7MzBb6QgYldj531EgGVSDSQd9RbXexAh6ZHvjRDAl1NRm1h5hegzEDhHs0jhhuApYQH7
         IU+E0i23QU0wmN4wVKSSca4bg5UiAN/V4aiTxZYShFGltfRKGGKhJJg/0ul3dd4kIgxo
         mlHcMDQ5EbzfpLv3IgD4GIjWXNU/TFZc+xUSiocQPBIs9Sy+f6oMvzUF2moGCU5obTD+
         qZGpYJV6qGdDRdNM3Hetv6PABFnZCYNhNEOepzKhn7agw+tDxs8lglyebVISVoy2k/1v
         Q3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FboUBx+M7wiC2Vc9ohnMu1xFLntMIR1IX9IeLkEPHjI=;
        b=Oz6q0MqG287/DGKPz4nCI5sm8hASacJJ72q4lY8bZ6fMqM39BsuanYrQFAxmtktbn/
         cL/VHeqa5UuqB3iBb4qsRsnL/AXHtFnNIF2FT3/StkmNeTlKxxHSNyAgZERKCt26i3Fv
         5LR3CIWXYkpnWn9a+Qf8JKgNHRVDRnZOXT+G4gXJ6tyFmdINzNjc3MkRLP8IdR/egB2g
         Eb80cU7bnXt+4feQqvz+hZT++5ez402MVpZQ2ThkEYkUayskeLAgHXx41bQop5zKbmOL
         4cCG4EtoU8XQdetAyvdPHTqk4U3bhRmoEV4+nFVcG80xM50J38fNf0D+u0cYaCQZss5r
         Wi3Q==
X-Gm-Message-State: AOAM5310UdfuZxa6AyrwgmgCWIRkWQosKGtGYs3cw4rQgBINvBxrNzmd
        oFlQ0l7r5B1XDwoSJACR3HId9w==
X-Google-Smtp-Source: ABdhPJzwmJZmG/p+pl3buOTcZzktD3WLTreTOFcX4K4JsmD+TrNZ3sJfvua3mjs+PVPFIecVlojLpA==
X-Received: by 2002:ae9:d61c:: with SMTP id r28mr4721507qkk.462.1618510681561;
        Thu, 15 Apr 2021 11:18:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c9::1288? ([2620:10d:c091:480::1:2677])
        by smtp.gmail.com with ESMTPSA id d62sm2569722qkg.55.2021.04.15.11.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:18:00 -0700 (PDT)
Subject: Re: [RFC v3 0/2] vfs / btrfs: add support for ustat()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Mahoney <jeffm@suse.com>
References: <1408071538-14354-1-git-send-email-mcgrof@do-not-panic.com>
 <20140815092950.GZ18016@ZenIV.linux.org.uk>
 <c3b0feac-327c-15db-02c1-4a25639540e4@suse.com>
 <CAB=NE6X2-mbZwVFnKUwjRmTGp3auZFHQXJ1h_YTJ2driUeoR+A@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com>
Date:   Thu, 15 Apr 2021 14:17:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAB=NE6X2-mbZwVFnKUwjRmTGp3auZFHQXJ1h_YTJ2driUeoR+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/21 1:53 PM, Luis Chamberlain wrote:
> On Wed, Aug 23, 2017 at 3:31 PM Jeff Mahoney <jeffm@suse.com> wrote:
>>
>> On 8/15/14 5:29 AM, Al Viro wrote:
>>> On Thu, Aug 14, 2014 at 07:58:56PM -0700, Luis R. Rodriguez wrote:
>>>
>>>> Christoph had noted that this seemed associated to the problem
>>>> that the btrfs uses different assignments for st_dev than s_dev,
>>>> but much as I'd like to see that changed based on discussions so
>>>> far its unclear if this is going to be possible unless strong
>>>> commitment is reached.
>>
>> Resurrecting a dead thread since we've been carrying this patch anyway
>> since then.
>>
>>> Explain, please.  Whose commitment and commitment to what, exactly?
>>> Having different ->st_dev values for different files on the same
>>> fs is a bloody bad idea; why does btrfs do that at all?  If nothing else,
>>> it breaks the usual "are those two files on the same fs?" tests...
>>
>> It's because btrfs snapshots would have inode number collisions.
>> Changing the inode numbers for snapshots would negate a big benefit of
>> btrfs snapshots: the quick creation and lightweight on-disk
>> representation due to metadata sharing.
>>
>> The thing is that ustat() used to work.  Your commit 0ee5dc676a5f8
>> (btrfs: kill magical embedded struct superblock) had a regression:
>> Since it replaced the superblock with a simple dev_t, it rendered the
>> device no longer discoverable by user_get_super.  We need a list_head to
>> attach for searching.
>>
>> There's an argument that this is hacky.  It's valid.  The only other
>> feedback I've heard is to use a real superblock for subvolumes to do
>> this instead.  That doesn't work either, due to things like freeze/thaw
>> and inode writeback.  Ultimately, what we need is a single file system
>> with multiple namespaces.  Years ago we just needed different inode
>> namespaces, but as people have started adopting btrfs for containers, we
>> need more than that.  I've heard requests for per-subvolume security
>> contexts.  I'd imagine user namespaces are on someone's wish list.  A
>> working df can be done with ->d_automount, but the way btrfs handles
>> having a "canonical" subvolume location has always been a way to avoid
>> directory loops.  I'd like to just automount subvolumes everywhere
>> they're referenced.  One solution, for which I have no code yet, is to
>> have something like a superblock-light that we can hang things like a
>> security context, a user namespace, and an anonymous dev.  Most file
>> systems would have just one.  Btrfs would have one per subvolume.
>>
>> That's a big project with a bunch of discussion.
> 
> 4 years have gone by and this patch is still being carried around for
> btrfs. Other than resolving this ustat() issue for btrfs are there new
> reasons to support this effort done to be done properly? Are there
> other filesystems that would benefit? I'd like to get an idea of the
> stakeholder here before considering taking this on or not.
> 

Not really sure why this needs to be addressed, we have statfs(), and what we 
have has worked forever now.  There's a lot of larger things that need to be 
addressed in general to support the volume approach inside file systems that is 
going to require a lot of work inside of VFS.  If you feel like tackling that 
work and then wiring up btrfs by all means have at it, but I'm not seeing a 
urgent need to address this.  Thanks,

Josef

