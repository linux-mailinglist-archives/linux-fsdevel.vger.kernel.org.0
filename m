Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC27D3DB448
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhG3HJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:09:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:53241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhG3HJz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627628964;
        bh=DJiPBk8dAZp27zMgEw9hd3enqxi6oBhLFOvski7HTfs=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Ip4FRPLK2lfsX8PnjJ6IPvrVbS22n3JKOGAgs9Z1jjdftTUA0mgg8MPabqChO4KkY
         J7LFkdgw5zLFwkqVcbhWdep4yqXzMdgSycdE/04jZGYuK7JQd8MsEIZAmmZGbYtYTp
         idbTev6mhEgUz3uDseRNuDgd/22rAFezAp5yZed8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McYCl-1mlS5W1drZ-00cyOW; Fri, 30
 Jul 2021 09:09:24 +0200
To:     NeilBrown <neilb@suse.de>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728125819.6E52.409509F4@e16-tech.com>
 <20210728140431.D704.409509F4@e16-tech.com>
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>
 <20210729023751.GL10170@hungrycats.org>
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>
 <20210729232017.GE10106@hungrycats.org>
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
 <162762468711.21659.161298577376336564@noble.neil.brown.name>
 <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
 <162762802395.21659.5310176078177217626@noble.neil.brown.name>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <21939589-bd90-116d-7351-b84ba58446b3@gmx.com>
Date:   Fri, 30 Jul 2021 15:09:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162762802395.21659.5310176078177217626@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9iKG73216aiMQtG7mwed1Oi8Gq6A7ab40akZQBtAhEAQSxD5cga
 uxME4u42ySQgmZRvHtpCkrUAUuNL/8J6qvcBuVKnOBLgpG684oa2yAWtCa9Gb5zvmqJnr3r
 IEZSUZlWRNXzyhYsFNyOu7e8VtkEFmNn2aKdwXLVRiIuxyP8u0BkDBgizcd4Z1RDsaHcVG8
 erlvutp04lxqs8EkSr/XA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6n5SfNDoNiU=:HFcpoO3pInKlIIHJyRV0Fv
 I6eLDH0LmDBpjJad9yWFzPi/3gqoz5/SNux8CLQCDN0kyJPJuzKw+KFqVNCpBwetQ0qmCGwjA
 9Z1+UKdSnN9JaVQ05m3Ha9fIXnoHxg2K6icSp6h8U7Wr9IjqSLQQDUlcCA3KilAOZ4+eTxzh7
 +H953UUB5VdbAxyUDSpTyFOFYl5aFLzDDuteb3Iu2dIQuoYj2CfaFzZETUHRwLWQ9BzZRxgpi
 vtv4Gi7Vgnwp3nzjrEO56GPzNmFdO6NFr1ajJGX+AoViAmR7owmn23bTdrVYYlJjmce1A2yDn
 A5BXp7ZQLIxLuiJirJucrMqQtBSUnUu/czptRHRsl5d8qlg5VwuJWCFQQOiez0M8B4qJ7Wdo4
 BFBQwKbzHAb9YD1uPBR5C+0fTk5vYkLChRTL6GSFU+UFKXKVSXG8Vuz8/XOTkiHR/M9F2nVlD
 mjt64AfiNRKv2p1I6vKYhNEly1VDQv+YDt12Q8rH9nOAxeKXdSUDhNtmAmRWtRssohNDF+vR1
 vW4mZ6i164gfmqB1V5uH40KSH+INe8/9MTlZi+X2fvcEq+BD/4tRcK3p6WFZBdlG7c92hQ5XK
 FV7bUtCyj7jStxDNTtTB5AQ5MVnd5q5VQr/huy7I6fk7jEZGYFtQxfpdCiiFmxuvDqUT2EZTH
 Rx5Pnw0qqOJbnpStB6GgNwEc5t1f+7Fwi3/Yi3iaY1oplMXBsAoDSRKkhoItD6M4gOTCBwIgT
 js/6zTJTtku4MTbs5W+75bZTGzfx2nHwj5LOXUA26+UkKFBdbuBvS+bKlPcrlKWGUIDT/PBUw
 TdETnW344ZJvDkdJ3WRlNpn1yA6WcNw0Gz5xeLg/rCRVeXSBuqRI0L34eHBppRF+oHzCa9vna
 G0G4GX3PnXl8A6TWAUlrhgDLP/0yWQUVciMsUFlj9YU6bGxj3+cdpxSwIdBdbwxuRj9KVtjBw
 9t4bXNmfiBtf+jECou6KIQ4r/ON9t5hf/iv/uqyBtnA0QVxhuDerOz+54ul7OSWqgJ7SHt1CJ
 39BigYcwEP/gLbBNx5HD/iSR6AO37SuxmMZiZeXSV7E4XFxdFLcgmguY9Dp1YNHQK1sagQPJc
 eaZrVrIfzKSAEP//E8HZll6SKPL9p+HxWU7g5gGcIODlDlHmPZ+WdYo7g==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/30 =E4=B8=8B=E5=8D=882:53, NeilBrown wrote:
> On Fri, 30 Jul 2021, Qu Wenruo wrote:
>>>
>>> You mean like "du -x"?? Yes.  You would lose the misleading illusion
>>> that there are multiple filesystems.  That is one user-expectation tha=
t
>>> would need to be addressed before people opt-in
>>
>> OK, forgot it's an opt-in feature, then it's less an impact.
>
> The hope would have to be that everyone would eventually opt-in once all
> issues were understood.
>
>>
>> Really not familiar with NFS/VFS, thus some ideas from me may sounds
>> super crazy.
>>
>> Is it possible that, for nfsd to detect such "subvolume" concept by its
>> own, like checking st_dev and the fsid returned from statfs().
>>
>> Then if nfsd find some boundary which has different st_dev, but the sam=
e
>> fsid as its parent, then it knows it's a "subvolume"-like concept.
>>
>> Then do some local inode number mapping inside nfsd?
>> Like use the highest 20 bits for different subvolumes, while the
>> remaining 44 bits for real inode numbers.
>>
>> Of-course, this is still a workaround...
>
> Yes, it would certainly be possible to add some hacks to nfsd to fix the
> immediate problem, and we could probably even created some well-defined
> interfaces into btrfs to extract the required information so that it
> wasn't too hackish.
>
> Maybe that is what we will have to do.  But I'd rather not hack NFSD
> while there is any chance that a more complete solution will be found.
>
> I'm not quite ready to give up on the idea of squeezing all btrfs inodes
> into a 64bit number space.  24bits of subvol and 40 bits of inode?
> Make the split a mkfs or mount option?

Btrfs used to have a subvolume number limit in the past, for different
reasons.

In that case, subvolume number is limited to 48 bits, which is still too
large to avoid conflicts.

For inode number there is really no limit except the 256 ~ (U64)-256 limit=
.

Considering all these numbers are almost U64, conflicts would be
unavoidable AFAIK.

> Maybe hand out inode numbers to subvols in 2^32 chunks so each subvol
> (which has ever been accessed) has a mapping from the top 32 bits of the
> objectid to the top 32 bits of the inode number.
>
> We don't need something that is theoretically perfect (that's not
> possible anyway as we don't have 64bits of device numbers).  We just
> need something that is practical and scales adequately.  If you have
> petabytes of storage, it is reasonable to spend a gigabyte of memory on
> a lookup table(?).

Can such squishing-all-inodes-into-one-namespace work to be done in a
more generic way? e.g, let each fs with "subvolume"-like feature to
provide the interface to do that.


Despite that I still hope to have a way to distinguish the "subvolume"
boundary.

If completely inside btrfs, it's pretty simple to locate a subvolume
boundary.
All subvolume have the same inode number 256.

Maybe we could reserve some special "squished" inode number to indicate
boundary inside a filesystem.

E.g. reserve (u64)-1 as a special indicator for subvolume boundaries.
As most fs would have reserved super high inode numbers anyway.


>
> If we can make inode numbers unique, we can possibly leave the st_dev
> changing at subvols so that "du -x" works as currently expected.
>
> One thought I had was to use a strong hash to combine the subvol object
> id and the inode object id into a 64bit number.  What is the chance of
> a collision in practice :-)

But with just 64bits, conflicts will happen anyway...

Thanks,
Qu
>
> Thanks,
> NeilBrown
>
