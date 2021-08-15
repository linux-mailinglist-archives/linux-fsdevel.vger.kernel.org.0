Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762D63ECB11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 23:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhHOVDx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 17:03:53 -0400
Received: from smtp-31.italiaonline.it ([213.209.10.31]:50428 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229760AbhHOVDw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:03:52 -0400
Received: from venice.bhome ([78.12.137.210])
        by smtp-31.iol.local with ESMTPA
        id FNHrmeTPUzHnRFNHrmNSLi; Sun, 15 Aug 2021 23:03:20 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1629061400; bh=HUqeopDghBjN488S7Ec9uWXxPsppM6mmFOLOjo8z9aM=;
        h=From;
        b=yFqUElIPQxSaBEBtnO481alVF0sEDvnm3/93LTCTGTsbFIK5rHOp64j8sWKEpflbQ
         QRBrs34HfqZdlxkhQTGBmFkOShpm3+wayzJZzP72BvWZfnLop6HktDhamsAT++8Bbp
         m5r0uc6fZKaOccpK+apBQ5oKLoFWp6AtX5gUjJ3Bwy+9yhQe4vgy2OVU8Dc7uNDKDY
         yXTTHGs1bmKUa/QOlQ6P8WxNxkSoknLBhsI0OPjytjMaPunTyX96YtwQh+FgyvwnfH
         mEp8qZv2rmhE9MzLS8nTAL7qtoY7idlX2yiSmubHD0wxNme2XKvmh8lMCuHI4eEdjW
         rMHJ1XITwNXxg==
X-CNFS-Analysis: v=2.4 cv=L6DY/8f8 c=1 sm=1 tr=0 ts=61198118 cx=a_exe
 a=VHyfYjYfg3XpWvNRQl5wtg==:117 a=VHyfYjYfg3XpWvNRQl5wtg==:17
 a=IkcTkHD0fZMA:10 a=OLL_FvSJAAAA:8 a=2yU5_425C8Wy4Xom6_EA:9 a=QEXdDO2ut3YA:10
 a=sB6geW_GkGoA:10 a=05sTH6Zuzt8A:10 a=oIrB72frpwYPwTMnlWqB:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for
 btrfs export
To:     Roman Mamedov <rm@romanrm.net>, NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <ee167ffe-ad11-ea95-1bd5-c43f273b345a@libero.it>
Date:   Sun, 15 Aug 2021 23:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210816003505.7b3e9861@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAGBQ8wBppXFkPgpY4SS2c4JYsugjXcdIGWZG1YTTrWdmSWMa7XyKbDxS5fXOMLNASOwIdy0vhdqFR3/vahLO1Wr4N6te15p+ZdHQpQ0DNtOClysT6bx
 OdMz6UQzqnnmozaUqdBWh2UEcEqcGRGW3EI0P8VWjlC4fewO+Oji20ZdGeGlf4l5qoBmYpCoW1KL2viekXIzl5Kz6lXXGDovgSEYlGzSJ+dttNkws34cWBFq
 HL832MUK0895S1OROmvAT3Xu8kikkRz32gB69jRHvagPO0XjxMoQTkaye+ODPXfY0lwZ4hb8wAOXapfspz+dbJgTjpki41aWYBqmQ32fybFlCk9kpnCrExbl
 FARImf415768hoYCe2UlN1eN7NpSaEcti9byL8YCc7c63Y1kbMfEfsRPHij2iuUf3NjNmeYSiUeL6yRLlP02JkgTjCfULqu3y3Z7l8/kt7k/c4dPH+CrN7qr
 Yy7Z+qqDjdKms+Q5xC9Dd1gfFvT4UnZODk3Jel3Y9L4lwZzIpeGiO7iNwfk=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/15/21 9:35 PM, Roman Mamedov wrote:
> On Sun, 15 Aug 2021 09:39:08 +0200
> Goffredo Baroncelli <kreijack@libero.it> wrote:
> 
>> I am sure that it was discussed already but I was unable to find any track
>> of this discussion. But if the problem is the collision between the inode
>> number of different subvolume in the nfd export, is it simpler if the export
>> is truncated to the subvolume boundary ? It would be more coherent with the
>> current behavior of vfs+nfsd.
> 
> See this bugreport thread which started it all:
> https://www.spinics.net/lists/linux-btrfs/msg111172.html
> 
> In there the reporting user replied that it is strongly not feasible for them
> to export each individual snapshot.

Thanks for pointing that.

However looking at the 'exports' man page, it seems that NFS has already an
option to cover these cases: 'crossmnt'.

If NFSd detects a "child" filesystem (i.e. a filesystem mounted inside an already
exported one) and the "parent" filesystem is marked as 'crossmnt',  the client mount
the parent AND the child filesystem with two separate mounts, so there is not problem of inode collision.

I tested it mounting two nested ext4 filesystem, and there isn't any problem of inode collision
(even if there are two different files with the same inode number).

---------
# mount -o loop disk2 test3/
# echo 123 >test3/one
# mkdir test3/test4
# sudo mount -o loop disk3 test3/test4/
# echo 123 >test3/test4/one
# ls -liR test3/
test3/:
total 24
11 drwx------ 2 root  root  16384 Aug 15 22:27 lost+found
12 -rw-r--r-- 1 ghigo ghigo     4 Aug 15 22:29 one
  2 drwxr-xrwx 3 root  root   4096 Aug 15 22:46 test4

test3/test4:
total 20
11 drwx------ 2 root  root  16384 Aug 15 22:45 lost+found
12 -rw-r--r-- 1 ghigo ghigo     4 Aug 15 22:46 one

# egrep test3 /etc/exports
/tmp/test3 *(rw,no_subtree_check,crossmnt)

# mount 192.168.1.27:/tmp/test3 3
ls -lRi 3
3:
total 24
11 drwx------ 2 root  root  16384 Aug 15 22:27 lost+found
12 -rw-r--r-- 1 ghigo ghigo     4 Aug 15 22:29 one
  2 drwxr-xrwx 3 root  root   4096 Aug 15 22:46 test4

3/test4:
total 20
11 drwx------ 2 root  root  16384 Aug 15 22:45 lost+found
12 -rw-r--r-- 1 ghigo ghigo     4 Aug 15 22:46 one

# mount | egrep 192
192.168.1.27:/tmp/test3 on /tmp/3 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.1.27,local_lock=none,addr=192.168.1.27)
192.168.1.27:/tmp/test3/test4 on /tmp/3/test4 type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.1.27,local_lock=none,addr=192.168.1.27)


---------------

I tried to mount even with "nfsvers=3", and it seems to work.

However the tests above are related to ext4; in fact it doesn't work with btrfs, but I think this is more a implementation problem than a strategy problem.
What I means is that NFS already has a way to mount different parts of the fs-tree with different mounts (form a client POV). I think that this strategy should be used when NFSd exports a BTRFS filesystem:
- if the 'crossmnt' is NOT Passed, the export should ends at the subvolume boundary (or allow inode collision)
- if the 'crossmnt' is passed, the client should automatically mounts each nested subvolume as a separate mount

> 
>> In fact in btrfs a subvolume is a complete filesystem, with an "own
>> synthetic" device. We could like or not this solution, but this solution is
>> the more aligned to the unix standard, where for each filesystem there is a
>> pair (device, inode-set). NFS (by default) avoids to cross the boundary
>> between the filesystems. So why in BTRFS this should be different ?
> 
>  From the user point of view subvolumes are basically directories; that they
> are "complete filesystems"* is merely a low-level implementation detail.
> 
> * well except they are not, as you cannot 'dd' a subvolume to another
> blockdevice.
> 
>> Why don't rename "ino_uniquifier" as "ino_and_subvolume" and leave to the
>> filesystem the work to combine the inode and the subvolume-id ?
>>
>> I am worried that the logic is split between the filesystem, which
>> synthesizes the ino_uniquifier, and to NFS which combine to the inode. I am
>> thinking that this combination is filesystem specific; for BTRFS is a simple
>> xor but for other filesystem may be a more complex operation, so leaving an
>> half in the filesystem and another half to the NFS seems to not optimal if
>> other filesystem needs to use ino_uniquifier.
> 
> I wondered a bit myself, what are the downsides of just doing the
> uniquefication inside Btrfs, not leaving that to NFSD?
> 
> I mean not even adding the extra stat field, just return the inode itself with
> that already applied. Surely cannot be any worse collision-wise, than
> different subvolumes straight up having the same inode numbers as right now?
> 
> Or is it a performance concern, always doing more work, for something which
> only NFSD has needed so far.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
