Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49C13F0A3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhHRRZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 13:25:24 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:40876 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229661AbhHRRZY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:25:24 -0400
Received: from venice.bhome ([78.12.137.210])
        by smtp-31.iol.local with ESMTPA
        id GPJ0mO7iazHnRGPJ0mwspf; Wed, 18 Aug 2021 19:24:47 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1629307487; bh=GS9nRlQPrwPW5RmZBrGAuNY0KO6xdcgHq2IdmWkZkM0=;
        h=From;
        b=K18tIs04pet4ULW4ZVjRomSsC/aGo6zxsQFjZAed84drfLTtbsuiknoQtzK11gHcD
         Q9UQw971yo00B9/oN6j7susEZNOFT8gQ8rfhXRDH0j+25rOw6RgoJOAtY3r0ZtXD9/
         KpMq/w1wUltQ5VBjKyFVVKRRCTmHJxOZSVDLn7PUhDiUaKsRIxgfnUTbhvzqnPn3py
         vtZ1ZIRPwLNDG4iUMNmFufDd0uRYgJEpts9bELVA50ExEMfGVZk/fyA4w4uxylnrUd
         MXaEoOiY/3S3QH/RqFtYFWSwJKik5YRsM3SHeq59xveUnbDn0KMreAK5nL03UKlSwk
         /dw1rGcJoWVmA==
X-CNFS-Analysis: v=2.4 cv=L6DY/8f8 c=1 sm=1 tr=0 ts=611d425f cx=a_exe
 a=VHyfYjYfg3XpWvNRQl5wtg==:117 a=VHyfYjYfg3XpWvNRQl5wtg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=Uq0mbvy6AAAA:8 a=zmC5LoGOwyVqHsGVwkYA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=9nAYT2xhiIK_ZOnRzmc7:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
To:     NeilBrown <neilb@suse.de>
Cc:     Roman Mamedov <rm@romanrm.net>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>
 <bf49ef31-0c86-62c8-7862-719935764036@libero.it>
 <20210816003505.7b3e9861@natsu>
 <ee167ffe-ad11-ea95-1bd5-c43f273b345a@libero.it>
 <162906443866.1695.6446438554332029261@noble.neil.brown.name>
 <d8d67284-8d53-ed97-f387-81b27d17fdde@inwind.it>
 <162923637125.9892.2416104366790758503@noble.neil.brown.name>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <ba85200b-feb9-14ba-aa5a-993a598deba6@inwind.it>
Date:   Wed, 18 Aug 2021 19:24:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <162923637125.9892.2416104366790758503@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAuTy7JQ4T3/6Jol4BdjMEfQ5nej97/lfxbjHPjdhKSDj5/9VTqbDuag/uk8TDxtlzDJJZ6BdB5xggeWuoD/VzeSZYOUbV8WjfWno+rpIlH3i/MLbWRP
 KYpseUTykNZ+jJgNHXy/NVYsHpEZ06WL1i8/4siRO9LGVNx9RsNcdeLOCsNLhZ7RLjkXfFkVP8cyxYHoiUGyx9Nx6UVCZ8+2tVtFrLL08QmcougXGLGqCMye
 8/3ZWeGexMZSfs+vRT2L56vZ4PYl603v27fhPdXR22t+ZwhQrgKQlsi41in7mq1p7qUzaQ81bFeTJyeWEJYfUKu3u78UWE0Jf2sB30E5zDN58db7NDPFjuEZ
 bnPTLGCIMWRWEowNPwJ5bX0WdMFAvNnewXHzHcQaFYM2LLhzsffmegmxC66uaE/EJBAtJ9pA9wg04K+QC3gwj+SGlNzuKzaUAfsFe8N6+21Ci1ysozZCHtEo
 GT6X1+zjJtOplT3p2OWT2oCdQx4ua8fXdxneyGpbsuQO5vvZCoOSrRs+FNQ=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/21 11:39 PM, NeilBrown wrote:
> On Wed, 18 Aug 2021, kreijack@inwind.it wrote:
>> On 8/15/21 11:53 PM, NeilBrown wrote:
>>> On Mon, 16 Aug 2021, kreijack@inwind.it wrote:
>>>> On 8/15/21 9:35 PM, Roman Mamedov wrote:
> 
>>>>
>>>> However looking at the 'exports' man page, it seems that NFS has already an
>>>> option to cover these cases: 'crossmnt'.
>>>>
>>>> If NFSd detects a "child" filesystem (i.e. a filesystem mounted inside an already
>>>> exported one) and the "parent" filesystem is marked as 'crossmnt',  the client mount
>>>> the parent AND the child filesystem with two separate mounts, so there is not problem of inode collision.
>>>
>>> As you acknowledged, you haven't read the whole back-story.  Maybe you
>>> should.
>>>
>>> https://lore.kernel.org/linux-nfs/20210613115313.BC59.409509F4@e16-tech.com/
>>> https://lore.kernel.org/linux-nfs/162848123483.25823.15844774651164477866.stgit@noble.brown/
>>> https://lore.kernel.org/linux-btrfs/162742539595.32498.13687924366155737575.stgit@noble.brown/
>>>
>>> The flow of conversation does sometimes jump between threads.
>>>
>>> I'm very happy to respond you questions after you've absorbed all that.
>>
>> Hi Neil,
>>
>> I read the other threads.  And I still have the opinion that the nfsd
>> crossmnt behavior should be a good solution for the btrfs subvolumes.
> 
> Thanks for reading it all.  Let me join the dots for you.
> 
[...]
> 
> Alternately we could change the "crossmnt" functionality to treat a
> change of st_dev as though it were a mount point.  I posted patches to
> do this too.  This hits the same sort of problems in a different way.
> If NFSD reports that is has crossed a "mount" by providing a different
> filesystem-id to the client, then the client will create a new mount
> point which will appear in /proc/mounts.  

Yes, this is my proposal.

> It might be less likely that
> many thousands of subvolumes are accessed over NFS than locally, but it
> is still entirely possible.  

I don't think that it would be so unlikely. Think about a file indexer
and/or a 'find' command runned in the folder that contains the snapshots...

> I don't want the NFS client to suffer a
> problem that btrfs doesn't impose locally.  

The solution is not easy. In fact we are trying to map a u64 x u64 space to a u64 space. The true is that we
cannot guarantee that a collision will not happen. We can only say that for a fresh filesystem is near
impossible, but for an aged filesystem it is unlikely but possible.

We already faced real case where we exhausted the inode space in the 32 bit arch.What is the chances that the subvolumes ever created count is greater  2^24 and the inode number is greater  2^40 ? The likelihood is low but not 0...

Some random toughs:
- the new inode number are created merging the original inode-number (in the lower bit) and the object-id of the subvolume (in higher bit). We could add a warning when these bits overlap:

	if (fls(stat->ino) >= ffs(stat->ino_uniquifer))
		printk("NFSD: Warning possible inode collision...")

More smarter heuristic can be developed, like doing the check against the maximum value if inode and the maximum value of the subvolume once at mount time....

- for the inode number it is an expensive operation (even tough it exists/existed for the 32bit processor), but we could reuse the object-id after it is freed

- I think that we could add an option to nfsd or btrfs (not a default behavior) to avoid to cross the subvolume boundary

> And 'private' subvolumes
> could again appear on a public list if they were accessed via NFS.

(wrongly) I never considered  a similar scenario. However I think that these could be anonymized using a alias (the name of the path to mount is passed by nfsd, so it could create an alias that will be recognized by nfsd when the clienet requires it... complex but doable...)

> 
> Thanks,
> NeilBrown
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
