Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602F93DB381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 08:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhG3GY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 02:24:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:53821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237398AbhG3GY2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627626237;
        bh=Y5CJGn+v3SJXsKlHd7DqX3nGKWWffaNpVtwSn1lUK9g=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=ZNjlNpeFDzEeSTmdMNaS4NUnuVrSZ76mDBn610ZqLEy93jt4tTtexJ5k2uC59iNEZ
         37BGrUzqAUUL4Cjx5HuRVv5wKTSphDFwZzqcsTi78L8rplJytJKP0GTuC+TSPnYVEq
         wl2cczxXtMwF5Txxxztt1BmkI5bnB/UduUebRx+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuUj2-1mzWmc1rKU-00rc7m; Fri, 30
 Jul 2021 08:23:57 +0200
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
Message-ID: <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
Date:   Fri, 30 Jul 2021 14:23:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162762468711.21659.161298577376336564@noble.neil.brown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y1ixsLsnOm9AlTFuebCR83kUbN1rZm+hI0Xb+rAOGPYVv1yLGiq
 fhC33AL19MTTY4MfUTEz7DbTi+4+qHX1Zs7yhS+dIUpQVFfnPZpFU7FnPdO+4IxdnjURG8R
 IBiCT++gA6ux9o/oahWlzajzXc6431lMl3ZY3TpbJ+SdduUyN29w8fMejbkZ8432kd3GTWC
 hqLCgOO1RnibPAIZlxHtA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GUgh+Iljc3M=:IRKn3XkR18gJKXauCnfeT9
 C/QabFxnK0FkyE0YPebpiv9cOdLZzGZ0rZTuhTQGg2PqLhWXbi86R+8bfpyPzNjyuMWX9mhpu
 5Pl7Q3KN+CTW8AAJN6e9LH7pc3jEHg0RdV/Mfkk+5S0AzNKmzH03AEolbBvoWrBnlXZwacJ90
 fJxxMJl17CNeMdttrCkCpYVsrF466THBIdgspQGp912mT4EOsfTcQjl1d3E+mXeMEbrGVNf43
 iKKJcgBiZSx01EbMgL1usM37hOgTd8c4TLFEj4oINGvjjzBxp2fteMJ5FpeIjeXx7oknEetbv
 LtFSXs5dKVza7Q+z1yTSiymKhMZ5b413EHAaCX1LFjbXIkPLSKbXp31Z8UHxmPeclHVuuYRwU
 ZIG3XIahxu2oh5BpeGhI1mPIVAgpk2wGqtYbjwGutqODghbgPPAnDYolfkZPeCdNuBLIpZJph
 TOZyCKk/RRvjapjP4zIYp9SbN7kLc1Rym9vnm0hqJXhzS/fNbOXSnWQeRQlJS9VsKknWPknW4
 tED5TCgz9zV/t05xaFvX06UNbvxiUOj3fnzu/HfRJfy2U0KeKx4RM+f+h6VIi4YZSQo5Jg/iM
 qaCYpredqgFqhhw2454fvo+7iwvn3+NE1zU5Gv/g2RE9MOcbrSjJvSUP83uuOUl5GDdQ3HbuP
 NZwa6K7GP1zPG14q6ijxb4BULfKEu23gXpPGIa+a6gzNZ85hXL3jJ1WceuSFv8dVZtYFTe3ZU
 r3hYnUp3/qIyr8Sene0O3R28TziurvlTuOD5FyLTInpJpnxBF1N5wWuSXvnJddqybpx5vTANp
 pR9pqVUkfyicA75MYNG/VL2z7SWYxODjIQ1jgX2ctwr6KjLgYeJRCeJYByXWDac0Lg9Xs2QNq
 OtkTnLRdNyJ7iu6UB7GL0dom6hovtHqN4hSah7lqlbVMN7QOVnmDunTpymHHZe03cKJKCboMi
 DWC9CfykO395XrWDAgmXR6+WRLViUpaUdW6jWWQz9bnzSly+NqVqOhEmFkNPtq0HgVmQy0jeV
 p5tn9pyAeohD76fPbvasChOVwshRAe55iCEt3cUDhlY6ljv4ARqeZ7bplPppyoSPRjZ7yt3rD
 /4BfPH1EK6gjwF13m2tUeIXOkhIV02wCn1+oZRGP2F200L/GjbeE4H4Ew==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/30 =E4=B8=8B=E5=8D=881:58, NeilBrown wrote:
> On Fri, 30 Jul 2021, Qu Wenruo wrote:
>>
>> On 2021/7/30 =E4=B8=8A=E5=8D=8810:36, NeilBrown wrote:
>>>
>>> I've been pondering all the excellent feedback, and what I have learnt
>>> from examining the code in btrfs, and I have developed a different
>>> perspective.
>>
>> Great! Some new developers into the btrfs realm!
>
> :-)
>
>>
>>>
>>> Maybe "subvol" is a poor choice of name because it conjures up
>>> connections with the Volumes in LVM, and btrfs subvols are very differ=
ent
>>> things.  Btrfs subvols are really just subtrees that can be treated as=
 a
>>> unit for operations like "clone" or "destroy".
>>>
>>> As such, they don't really deserve separate st_dev numbers.
>>>
>>> Maybe the different st_dev numbers were introduced as a "cheap" way to
>>> extend to size of the inode-number space.  Like many "cheap" things, i=
t
>>> has hidden costs.
>>>
>>> Maybe objects in different subvols should still be given different ino=
de
>>> numbers.  This would be problematic on 32bit systems, but much less so=
 on
>>> 64bit systems.
>>>
>>> The patch below, which is just a proof-of-concept, changes btrfs to
>>> report a uniform st_dev, and different (64bit) st_ino in different sub=
vols.
>>>
>>> It has problems:
>>>    - it will break any 32bit readdir and 32bit stat.  I don't know how=
 big
>>>      a problem that is these days (ino_t in the kernel is "unsigned lo=
ng",
>>>      not "unsigned long long). That surprised me).
>>>    - It might break some user-space expectations.  One thing I have le=
arnt
>>>      is not to make any assumption about what other people might expec=
t.
>>
>> Wouldn't any filesystem boundary check fail to stop at subvolume bounda=
ry?
>
> You mean like "du -x"?? Yes.  You would lose the misleading illusion
> that there are multiple filesystems.  That is one user-expectation that
> would need to be addressed before people opt-in

OK, forgot it's an opt-in feature, then it's less an impact.

But it can still sometimes be problematic.

E.g. if the user want to put some git code into one subvolume, while
export another subvolume through NFS.

Then the user has to opt-in, affecting the git subvolume to lose the
ability to determine subvolume boundary, right?

This is more concerning as most btrfs users won't want to explicitly
prepare another different btrfs.

>
>>
>> Then it will go through the full btrfs subvolumes/snapshots, which can
>> be super slow.
>>
>>>
>>> However, it would be quite easy to make this opt-in (or opt-out) with =
a
>>> mount option, so that people who need the current inode numbers and wi=
ll
>>> accept the current breakage can keep working.
>>>
>>> I think this approach would be a net-win for NFS export, whether BTRFS
>>> supports it directly or not.  I might post a patch which modifies NFS =
to
>>> intuit improved inode numbers for btrfs exports....
>>
>> Some extra ideas, but not familiar with VFS enough to be sure.
>>
>> Can we generate "fake" superblock for each subvolume?
>
> I don't see how that would help.  Either subvols are like filesystems
> and appear in /proc/mounts, or they aren't like filesystems and don't
> get different st_dev.  Either of these outcomes can be achieved without
> fake superblocks.  If you really need BTRFS subvols to have some
> properties of filesystems but not all, then you are in for a whole world
> of pain.

I guess it's time we pay for the hacks...

>
> Maybe btrfs subvols should be treated more like XFS "managed trees".  At
> least there you have precedent and someone else to share the pain.
> Maybe we should train people to use "quota" to check the usage of a
> subvol,

Well, btrfs quota has its own pain...

> rather than "du" (which will stop working with my patch if it
> contains refs to other subvols) or "df" (which already doesn't work), or
> "btrs df"


BTW, since XFS has a similar feature (not sure with XFS though), I guess
in the long run, it may be worthy to make the VFS to have some way to
treat such concept that is not full volume but still different trees.

>
>> Like using the subolume UUID to replace the FSID of each subvolume.
>> Could that migrate the problem?
>
> Which problem, exactly?  My first approach to making subvols work on NFS
> took essentially that approach.  It was seen (quite reasonably) as a
> hack to work around poor behaviour in btrfs.
>
> Given that NFS has always seen all of a btrfs filesystem as have a
> uniform fsid, I'm now of the opinion that we don't want to change that,
> but should just fix the duplicate-inode-number problem.
>
> If I could think of some way for NFSD to see different inode numbers
> than VFS, I would push hard for fixs nfsd by giving it more sane inode
> numbers.

Really not familiar with NFS/VFS, thus some ideas from me may sounds
super crazy.

Is it possible that, for nfsd to detect such "subvolume" concept by its
own, like checking st_dev and the fsid returned from statfs().

Then if nfsd find some boundary which has different st_dev, but the same
fsid as its parent, then it knows it's a "subvolume"-like concept.

Then do some local inode number mapping inside nfsd?
Like use the highest 20 bits for different subvolumes, while the
remaining 44 bits for real inode numbers.

Of-course, this is still a workaround...

Thanks,
Qu

>
> Thanks,
> NeilBrown
>
