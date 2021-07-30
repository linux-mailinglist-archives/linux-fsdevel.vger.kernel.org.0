Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D8E3DB2D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 07:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhG3Fco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 01:32:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:56669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhG3Fcn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627623125;
        bh=b5navuO/N0oGqtPx02ORt1XaUmDaNLkStMF4+5Irj/k=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=X8gNk6Ztz9lDTzeCKyA0Z6rE4xHbwdOh3YRTWXhErxHr0oo8ejEKZ5Awz69h6CvJs
         kAAQ8O2ZxInFbHofjOMBqR41kMHulammqC2gDW9yt3kK145D0XlVA+LNyQRDkcyWBl
         ydWMVtaxOYyjipT12YNGOZtv3hWZB9I8JcpoMw/w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N95iR-1nDaTQ2GRz-0163um; Fri, 30
 Jul 2021 07:32:05 +0200
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     NeilBrown <neilb@suse.de>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Neal Gompa <ngompa13@gmail.com>,
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
Message-ID: <046c96cd-f2a5-be04-e7b5-012e896c5816@gmx.com>
Date:   Fri, 30 Jul 2021 13:31:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oHWhFBgVvBy7HxVc78VMRG0Q4AzRlDGzSW6iAQsUrImd5UFHFOB
 jay/gKLOi8ttcEBG/x2+AKW1PiOAuWzVa03iYBxBip4avC0xrXrZ5ma0vzu0fssD6+LXwO4
 54THHuDvelmBCkWqDHXyc23aAplbgy258C44fTpxbEGlvziz6cArCqCbze9FoIVqo70BjKU
 JHkmIgqxVYYOiEmLgbLyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:boYNmi/KOwg=:1bPbIqLdcfCl+epPxdmjbK
 56a7bswXVyNWrTWT6miPswHnBkRIl4nMQW1PMovcJNBOQg8XL37f02O8zsxbKOKRBAT+gE99i
 EHQoUEBPwfoyLTyrphlHEpE5NehvLcFqG+338kohY3UmIluiID/9CrQJNqyoxKa9ABXjQRX0I
 bK174NJVpA5pjfl3r6RBcBjSomG2XDlDiUC2Rq9c+WgwlzeOyRWKi/0zPO11fcSQ+AVESyBH6
 VzElkUz8W6yoYfwvotBcj/NMQ/O3xk9EoHzAkuBbRwNtuUT77REhScKUu9pmAK2VZpOXASz9j
 S7v/42a/tpMI1yt1o/cXkf/7gfphIv1UD2jTVWaafXxZ5Hto+UJCc4L+YXmzPsvuvekoJuL9s
 83izSK01vI4AuBnmNnv0XaAlXv1PdLHLrXxj5bqi2mbPWkJ7KvYgibItvP492pHYsjKi3WP0M
 WXpJE3rB1iMWTjP6x5dyh3JJl2LyZ8UQhAf8nl7qYfOJyYGzI08PeN7N3vI37L0PnxbzRr2oX
 Qf0Y8+m/cgSFN9LIwqn3C1q87HHzX7ClxwohCXmN4dztPeTJzh6E5AZGZHsxSLHEPpjpNF+Sq
 HMVljngjfN4qs8i8uvCIjrgiEdBxFVgbuhB+wKsygQGciUax9I31ZqfoS+AK9se5a6ZG16kqO
 IWrDiQTEuOkUs592oGyJ90Kyl2W4aJBlhomu8+0Oej3+dBwjlDu57s8LsRxmhX2CmJEyzC0Ap
 Nm18P85QrakZERHFZdnxzZOE/NkXjUm+q0dstGFjxAcL06RimX7xOG1WAZ44A00Y4ATiVoJB3
 q5O/XRiR489fRWDo+OfJfq8nkyp3f5cZwqzr5sS2g8tOL1s+2JsbsT50GT68Am3RUXMEBp9on
 w6l7vR4+saePuyAt4ydHtpF1QnURVjQB3IenQ+6cjypZ9mU9aQkXXO5ahFPI/UqHXqNtUMQU5
 JaUYnOQs02ssCZtUc8i+eWmw34KcV16rH4KMvOxzObvLbLJ9CaUHqxbEfWRZTSyT9JlmCibF5
 Ntx9tjfGcbHp/T3LO7ddr+JhwKR/ZGXbPwM0duPNW6aheLfxsFkULU6etnIdbqqJ9O2l3VNl6
 sNNlkYbFWvjzyq61IbHB7g5wKjlFgW44EG9z+yffJveorqJ+ayFndNC1w==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/30 =E4=B8=8B=E5=8D=881:25, Qu Wenruo wrote:
>
>
> On 2021/7/30 =E4=B8=8A=E5=8D=8810:36, NeilBrown wrote:
>>
>> I've been pondering all the excellent feedback, and what I have learnt
>> from examining the code in btrfs, and I have developed a different
>> perspective.
>
> Great! Some new developers into the btrfs realm!
>
>>
>> Maybe "subvol" is a poor choice of name because it conjures up
>> connections with the Volumes in LVM, and btrfs subvols are very differe=
nt
>> things.=C2=A0 Btrfs subvols are really just subtrees that can be treate=
d as a
>> unit for operations like "clone" or "destroy".
>>
>> As such, they don't really deserve separate st_dev numbers.
>>
>> Maybe the different st_dev numbers were introduced as a "cheap" way to
>> extend to size of the inode-number space.=C2=A0 Like many "cheap" thing=
s, it
>> has hidden costs.

Forgot another problem already caused by this st_dev method.

Since btrfs uses st_dev to distinguish them its inode name space, and
st_dev is allocated using anonymous bdev, and the anonymous bdev poor
has limited size (much smaller than btrfs subvolume id name space), it's
already causing problems like we can't allocate enough anonymous bdev
for each subvolume, and failed to create subvolume/snapshot.

Thus it's really a time to re-consider how we should export this info to
user space.

Thanks,
Qu

>>
>> Maybe objects in different subvols should still be given different inod=
e
>> numbers.=C2=A0 This would be problematic on 32bit systems, but much les=
s so on
>> 64bit systems.
>>
>> The patch below, which is just a proof-of-concept, changes btrfs to
>> report a uniform st_dev, and different (64bit) st_ino in different
>> subvols.
>>
>> It has problems:
>> =C2=A0 - it will break any 32bit readdir and 32bit stat.=C2=A0 I don't =
know how big
>> =C2=A0=C2=A0=C2=A0 a problem that is these days (ino_t in the kernel is=
 "unsigned long",
>> =C2=A0=C2=A0=C2=A0 not "unsigned long long). That surprised me).
>> =C2=A0 - It might break some user-space expectations.=C2=A0 One thing I=
 have learnt
>> =C2=A0=C2=A0=C2=A0 is not to make any assumption about what other peopl=
e might expect.
>
> Wouldn't any filesystem boundary check fail to stop at subvolume boundar=
y?
>
> Then it will go through the full btrfs subvolumes/snapshots, which can
> be super slow.
>
>>
>> However, it would be quite easy to make this opt-in (or opt-out) with a
>> mount option, so that people who need the current inode numbers and wil=
l
>> accept the current breakage can keep working.
>>
>> I think this approach would be a net-win for NFS export, whether BTRFS
>> supports it directly or not.=C2=A0 I might post a patch which modifies =
NFS to
>> intuit improved inode numbers for btrfs exports....
>
> Some extra ideas, but not familiar with VFS enough to be sure.
>
> Can we generate "fake" superblock for each subvolume?
> Like using the subolume UUID to replace the FSID of each subvolume.
> Could that migrate the problem?
>
> Thanks,
> Qu
>
>>
>> So: how would this break your use-case??
>>
>> Thanks,
>> NeilBrown
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 0117d867ecf8..8dc58c848502 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -6020,6 +6020,37 @@ static int btrfs_opendir(struct inode *inode,
>> struct file *file)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>>
>> +static u64 btrfs_make_inum(struct btrfs_key *root, struct btrfs_key
>> *ino)
>> +{
>> +=C2=A0=C2=A0=C2=A0 u64 rootid =3D root->objectid;
>> +=C2=A0=C2=A0=C2=A0 u64 inoid =3D ino->objectid;
>> +=C2=A0=C2=A0=C2=A0 int shift =3D 64-8;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ino->type =3D=3D BTRFS_ROOT_ITEM_KEY) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* This is a subvol root fo=
und during readdir. */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootid =3D inoid;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inoid =3D BTRFS_FIRST_FREE_=
OBJECTID;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (rootid =3D=3D BTRFS_FS_TREE_OBJECTID)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* this is main vol, not su=
bvol (I think) */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return inoid;
>> +=C2=A0=C2=A0=C2=A0 /* store the rootid in the high bits of the inum.=
=C2=A0 This
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * will break if 32bit inums are required - we=
 cannot know
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 while (rootid) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inoid ^=3D (rootid & 0xff) =
<< shift;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rootid >>=3D 8;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift -=3D 8;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return inoid;
>> +}
>> +
>> +static inline u64 btrfs_ino_to_inum(struct inode *inode)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return btrfs_make_inum(&BTRFS_I(inode)->root->root_=
key,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &BTRFS_I(inode)->location);
>> +}
>> +
>> =C2=A0 struct dir_entry {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 ino;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 offset;
>> @@ -6045,6 +6076,49 @@ static int btrfs_filldir(void *addr, int
>> entries, struct dir_context *ctx)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>>
>> +static inline bool btrfs_dir_emit_dot(struct file *file,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dir_conte=
xt *ctx)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return ctx->actor(ctx, ".", 1, ctx->pos,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_ino_to_inum(file->f_path.dentry->d_inode),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 DT_DIR) =3D=3D 0;
>> +}
>> +
>> +static inline ino_t btrfs_parent_ino(struct dentry *dentry)
>> +{
>> +=C2=A0=C2=A0=C2=A0 ino_t res;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Don't strictly need d_lock here? If the par=
ent ino could change
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * then surely we'd have a deeper race in the =
caller?
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 spin_lock(&dentry->d_lock);
>> +=C2=A0=C2=A0=C2=A0 res =3D btrfs_ino_to_inum(dentry->d_parent->d_inode=
);
>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&dentry->d_lock);
>> +=C2=A0=C2=A0=C2=A0 return res;
>> +}
>> +
>> +static inline bool btrfs_dir_emit_dotdot(struct file *file,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dir_context *ct=
x)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return ctx->actor(ctx, "..", 2, ctx->pos,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 btrfs_parent_ino(file->f_path.dentry), DT_DIR) =3D=3D 0;
>> +}
>> +static inline bool btrfs_dir_emit_dots(struct file *file,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dir=
_context *ctx)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (ctx->pos =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!btrfs_dir_emit_dot(fil=
e, ctx))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->pos =3D 1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (ctx->pos =3D=3D 1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!btrfs_dir_emit_dotdot(=
file, ctx))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->pos =3D 2;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return true;
>> +}
>> =C2=A0 static int btrfs_real_readdir(struct file *file, struct dir_cont=
ext
>> *ctx)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode *inode =3D file_inode(file)=
;
>> @@ -6067,7 +6141,7 @@ static int btrfs_real_readdir(struct file *file,
>> struct dir_context *ctx)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool put =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key location;
>>
>> -=C2=A0=C2=A0=C2=A0 if (!dir_emit_dots(file, ctx))
>> +=C2=A0=C2=A0=C2=A0 if (!btrfs_dir_emit_dots(file, ctx))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D btrfs_alloc_path();
>> @@ -6136,7 +6210,8 @@ static int btrfs_real_readdir(struct file *file,
>> struct dir_context *ctx)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_unaligned(fs=
_ftype_to_dtype(btrfs_dir_type(leaf, di)),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &entry->type);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_dir_item_k=
ey_to_cpu(leaf, di, &location);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_unaligned(location.obje=
ctid, &entry->ino);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_unaligned(btrfs_make_in=
um(&root->root_key, &location),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &entry->ino);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_unaligned(fo=
und_key.offset, &entry->offset);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entries++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr +=3D sizeof=
(struct dir_entry) + name_len;
>> @@ -9193,7 +9268,7 @@ static int btrfs_getattr(struct user_namespace
>> *mnt_userns,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STATX_ATTR_NODUMP);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 generic_fillattr(&init_user_ns, inode, s=
tat);
>> -=C2=A0=C2=A0=C2=A0 stat->dev =3D BTRFS_I(inode)->root->anon_dev;
>> +=C2=A0=C2=A0=C2=A0 stat->ino =3D btrfs_ino_to_inum(inode);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&BTRFS_I(inode)->lock);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 delalloc_bytes =3D BTRFS_I(inode)->new_d=
elalloc_bytes;
>>
