Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE2A600AFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 11:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJQJgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJQJgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:36:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D5CE1A;
        Mon, 17 Oct 2022 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665999352;
        bh=TSo4xsvSk0OvKiVT30ycH0eaXfqa3xMOVrv3YjhH8gw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VDo8Gm0JgtzrHJ6Xii1dCvm/+Hg+CqD/gNGQx5qvTlNwGUtS/stHZhMQ0DtRJ7FTL
         oGQjIn1GNWtsDKdsBnqEvhXpqxlMvpkIeeMSyeO3skYwwnZFVB3bvCxS9z1b7KKbG+
         80m6RKMX91NnFVzzmsBldLgDnM8Md5Cf1lmocFHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKUv-1oPoym2jZn-00LjgT; Mon, 17
 Oct 2022 11:35:52 +0200
Message-ID: <cae729f9-beea-ee04-1258-af393a858430@gmx.com>
Date:   Mon, 17 Oct 2022 17:35:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH RFC 3/7] fs/btrfs: support `DISABLE_FS_CSUM_VERIFICATION`
 config option
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>, Qu Wenruo <wqu@suse.com>
Cc:     Hrutvik Kanabar <hrkanabar@gmail.com>,
        Hrutvik Kanabar <hrutvik@google.com>,
        Marco Elver <elver@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
References: <20221014084837.1787196-1-hrkanabar@gmail.com>
 <20221014084837.1787196-4-hrkanabar@gmail.com>
 <5bc906b3-ccb5-a385-fcb6-fc51c8fea3fd@suse.com>
 <CACT4Y+YeSOZPN+ek6vSLhsCugJ3iGF35-sghnZt4qQJ36DA6mA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CACT4Y+YeSOZPN+ek6vSLhsCugJ3iGF35-sghnZt4qQJ36DA6mA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R4tyK64oAk8yCJaovO8g6oIFOJ5yd0Mfld/q5wiz3kozqAwQUUS
 lpgS3cewdkbxgGeIFdnIcJLSyw3DqgqbHpMKqkq6iJMDWQK1v8r2vvpX8VoMHsrP7DJzziP
 MYTzi+9IfSzLElj6vjzmhop3w/xfDdajdqG4Xl7WiHTNsXM1dH86NANfkatxFl0VWhtQtc1
 LOWc73mYiVifySUhyiVYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P1Pf1vCA0Mo=:LdaK1AhKGgP6q3daQ1FgI+
 pBcZQ2/DqDbjSM/ch5Bo8GYYN5CIdcdy1krTo/c2d5EJLZaP7Ni+/vSh+QDYg8icdsJzrEJiV
 DyhpToTTOzaXYJHOfA/lkrQv03DT75BxKUcYYGw5z41+bZYilmhVlbDTEqV51rSB4lEQZWNkt
 gSv/3W+Kada62LM/xmsqFbFxex/RhjpOJjOz8kNWvnZX0gjjFS9cFs/k3PvcftPS4hTuhZG4w
 bftmdmcvxl3nDA88VlLFErj1cauYmH25vb0EQav9S5jO6XH4lPrAyseyUAlFXrtisV/PLH1ix
 Lr9t4TaaY1zXcO1xp7HBUKiOWI9f7DFv2LrulsEIizyYbV2JnHM11d/+upCrurY0QxNHq84ex
 EVJti0tJkcKvD+Je3sVxY7AkYJy69BqLjTzjqg7m2TaeB067VcveHqZgLhBkdVQ0bGLuwkvk7
 Gl5LA2uk9fwN9UzfBJA4d2ZJCGXE98HgeuyflZtJXL9pdJ7NNIdRY0Z4wAvUAO0QvFkmOtpCc
 zLk4KQu0sQom8HAzsZ80k2k//aHIjvfQ85lPWGYd0aQ1Ruz7FGTF+Mj1zXDFSOuGoKQAZ5Q2m
 YP7LNRSpMc9EP+hRceIdZUGd30O9ZQXYn+6u1L8IYfveqpqt9LbRCjzhuStZfrgDhh6ksWhzM
 GvOd24jy/UInX8Ie6LvqRk2igDeD8MXO0jzINQFZtbORPazSPd4tgmxZscp+SspyB3sVGHLlH
 HgWG0POeE0WOJ3HGjCSXA2ALMZ5MBDO0iwT2bJEknvt0HYviM5XJnV4c5KFVZn5UDtyopx3la
 raCwLOuRATRwc4cTbdoaTzo1XtAL/9JgyJIetUjGKyvZThZXPAhzgw1OgF2+w5Ct6bB0riOuu
 L/J4A+/Tmbet6i6U82+uDBbFeZcb7foWMdNdbRA9RdMKHhT+UXJuhNZEnnulLaf4pNwPBJMOk
 rpYdO9DiqW2bOxfHUVA5RUYrK4rrZMvnmiQ74XbvRGfpo2n4tq1KbJ2YCGDRq9IriS6QUl+WC
 i/lSljuZ7uOzf12RV7xD6we04YJ/imFRkMVxs4CjQKBAFc2q9ACwSDR2Xd0cSS68Og1UIuMBn
 61ALYMrd+wpPJcWbsG/76iN4SWlNye+A5svFDNfPSXLRUZYG0ukwegZr42+XlCCdK66ZEpuUA
 pkfUQVP5DciSSjxxW7NDON2BpahQ8jXq2OEbBeDKLaFVPG3lGdGt3vitfVoFqpb64rT+VGiLT
 Nf9hKGyDJ6O/AIFia3vUtEVE1VCHWoptVZcnMr3EjUwOkpPBISVqxh3NrYxfKqvhPZoLhEwSq
 NVvxK077sqqzQEdMrbxDx+FPG2JpS09q3z8NOyWs50rH0sYij6SkNDkN6gKRVLROpN8VJUCHB
 r3HCMIP1FWt6fJvB+UbEoTwOMypf+E+bukt/DG7PGLhO40nlidAdaUXlH1XaE39QnDYHetpAI
 Xa2bohRAwJVZMHI2pm2o6kSS+7/Se9dJSlJT+wViLdYj0TXA482aaFGEacRWLW+aXU1ylU65+
 yhaQqDUkEWCkmpa48nEPvmw2M0s2+k3ac4/v1BuqYzq8R
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/10/17 16:43, Dmitry Vyukov wrote:
> On Fri, 14 Oct 2022 at 12:24, 'Qu Wenruo' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>>
>> On 2022/10/14 16:48, Hrutvik Kanabar wrote:
>>> From: Hrutvik Kanabar <hrutvik@google.com>
>>>
>>> When `DISABLE_FS_CSUM_VERIFICATION` is enabled, bypass checksum
>>> verification.
>>>
>>> Signed-off-by: Hrutvik Kanabar <hrutvik@google.com>
>>
>> I always want more fuzz for btrfs, so overall this is pretty good.
>>
>> But there are some comments related to free space cache part.
>>
>> Despite the details, I'm wondering would it be possible for your fuzzin=
g
>> tool to do a better job at user space? Other than relying on loosen
>> checks from kernel?
>>
>> For example, implement a (mostly) read-only tool to do the following
>> workload:
>>
>> - Open the fs
>>     Including understand the checksum algo, how to re-generate the csum=
.
>>
>> - Read out the used space bitmap
>>     In btrfs case, it's going to read the extent tree, process the
>>     backrefs items.
>>
>> - Choose the victim sectors and corrupt them
>>     Obviously, vitims should be choosen from above used space bitmap.
>>
>> - Re-calculate the checksum for above corrupted sectors
>>     For btrfs, if it's a corrupted metadata, re-calculate the checksum.
>>
>> By this, we can avoid such change to kernel, and still get a much bette=
r
>> coverage.
>>
>> If you need some help on such user space tool, I'm pretty happy to
>> provide help.
>>
>>> ---
>>>    fs/btrfs/check-integrity.c  | 3 ++-
>>>    fs/btrfs/disk-io.c          | 6 ++++--
>>>    fs/btrfs/free-space-cache.c | 3 ++-
>>>    fs/btrfs/inode.c            | 3 ++-
>>>    fs/btrfs/scrub.c            | 9 ++++++---
>>>    5 files changed, 16 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
>>> index 98c6e5feab19..eab82593a325 100644
>>> --- a/fs/btrfs/check-integrity.c
>>> +++ b/fs/btrfs/check-integrity.c
>>> @@ -1671,7 +1671,8 @@ static noinline_for_stack int btrfsic_test_for_m=
etadata(
>>>                crypto_shash_update(shash, data, sublen);
>>>        }
>>>        crypto_shash_final(shash, csum);
>>> -     if (memcmp(csum, h->csum, fs_info->csum_size))
>>> +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
>>> +         memcmp(csum, h->csum, fs_info->csum_size))
>>>                return 1;
>>>
>>>        return 0; /* is metadata */
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index a2da9313c694..7cd909d44b24 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -184,7 +184,8 @@ static int btrfs_check_super_csum(struct btrfs_fs_=
info *fs_info,
>>>        crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
>>>                            BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, re=
sult);
>>>
>>> -     if (memcmp(disk_sb->csum, result, fs_info->csum_size))
>>> +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
>>> +         memcmp(disk_sb->csum, result, fs_info->csum_size))
>>>                return 1;
>>>
>>>        return 0;
>>> @@ -494,7 +495,8 @@ static int validate_extent_buffer(struct extent_bu=
ffer *eb)
>>>        header_csum =3D page_address(eb->pages[0]) +
>>>                get_eb_offset_in_page(eb, offsetof(struct btrfs_header,=
 csum));
>>>
>>> -     if (memcmp(result, header_csum, csum_size) !=3D 0) {
>>> +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
>>> +         memcmp(result, header_csum, csum_size) !=3D 0) {
>>
>> I believe this is the main thing fuzzing would take advantage of.
>>
>> It would be much better if this is the only override...
>>
>>>                btrfs_warn_rl(fs_info,
>>>    "checksum verify failed on logical %llu mirror %u wanted " CSUM_FMT=
 " found " CSUM_FMT " level %d",
>>>                              eb->start, eb->read_mirror,
>>> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
>>> index f4023651dd68..203c8a9076a6 100644
>>> --- a/fs/btrfs/free-space-cache.c
>>> +++ b/fs/btrfs/free-space-cache.c
>>> @@ -574,7 +574,8 @@ static int io_ctl_check_crc(struct btrfs_io_ctl *i=
o_ctl, int index)
>>>        io_ctl_map_page(io_ctl, 0);
>>>        crc =3D btrfs_crc32c(crc, io_ctl->orig + offset, PAGE_SIZE - of=
fset);
>>>        btrfs_crc32c_final(crc, (u8 *)&crc);
>>> -     if (val !=3D crc) {
>>> +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
>>> +         val !=3D crc) {
>>
>> I'm already seeing this to cause problems, especially for btrfs.
>>
>> Btrfs has a very strong dependency on free space tracing, as all of our
>> metadata (and data by default) relies on COW to keep the fs consistent.
>>
>> I tried a lot of different methods in the past to make sure we won't
>> write into previously used space, but it's causing a lot of performance
>> impact.
>>
>> Unlike tree-checker, we can not easily got a centerlized space to handl=
e
>> all the free space cross-check thing (thus it's only verified by things
>> like btrfs-check).
>>
>> Furthermore, even if you skip this override, with latest default
>> free-space-tree feature, free space info is stored in regular btrfs
>> metadata (tree blocks), with regular metadata checksum protection.
>>
>> Thus I'm pretty sure we will have tons of reports on this, and
>> unfortunately we can only go whac-a-mole way for it.
>
> Hi Qu,
>
> I don't fully understand what you mean. Could you please elaborate?
>
> Do you mean that btrfs uses this checksum check to detect blocks that
> were written to w/o updating the checksum?

I mean, btrfs uses this particular checksum for its (free) space cache,
and currently btrfs just trust the space cache completely to do COW.

This means, if we ignore the checksum for free space cache, we can
easily screw up the COW, e.g. allocate a range for the new metadata to
be written into.

But the truth is, that range is still being utilized by some other
metadata. Thus would completely break COW.


This is indeed a problem for btrfs, but it is not that easiy to fix,
since this involves cross-check 3 different data (free space cache for
free space, extent tree for used space, and the metadata itself).

Thus my concern is, disabling free space cache csum can easily lead to
various crashes, all related to broken COW, and we don't have a good
enough way to validate the result.

>
>
>
>
>>>                btrfs_err_rl(io_ctl->fs_info,
>>>                        "csum mismatch on free space cache");
>>>                io_ctl_unmap_page(io_ctl);
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index b0807c59e321..1a49d897b5c1 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -3434,7 +3434,8 @@ int btrfs_check_sector_csum(struct btrfs_fs_info=
 *fs_info, struct page *page,
>>>        crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
>>>        kunmap_local(kaddr);
>>>
>>> -     if (memcmp(csum, csum_expected, fs_info->csum_size))
>>> +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
>>> +         memcmp(csum, csum_expected, fs_info->csum_size))
>>
>> This skips data csum check, I don't know how valueable it is, but this
>> should be harmless mostly.
>>
>> If we got reports related to this, it would be a nice surprise.
>>
>>>                return -EIO;
>>>        return 0;
>>>    }
>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>> index f260c53829e5..a7607b492f47 100644
>>> --- a/fs/btrfs/scrub.c
>>> +++ b/fs/btrfs/scrub.c
>>> @@ -1997,7 +1997,8 @@ static int scrub_checksum_data(struct scrub_bloc=
k *sblock)
>>>
>>>        crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
>>>
>>> -     if (memcmp(csum, sector->csum, fs_info->csum_size))
>>> +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
>>> +         memcmp(csum, sector->csum, fs_info->csum_size))
>>
>> Same as data csum verification overide.
>> Not necessary/useful but good to have.
>>
>>>                sblock->checksum_error =3D 1;
>>>        return sblock->checksum_error;
>>>    }
>>> @@ -2062,7 +2063,8 @@ static int scrub_checksum_tree_block(struct scru=
b_block *sblock)
>>>        }
>>>
>>>        crypto_shash_final(shash, calculated_csum);
>>> -     if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_si=
ze))
>>> +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
>>> +         memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_si=
ze))
>>
>> This is much less valueable, since it's only affecting scrub, and scrub
>> itself is already very little checking the content of metadata.
>
> Could you please elaborate here as well?

These checksum verification is only done in the scrub path (just as the
file name indicates).

> This is less valuable from what perspective?

It's just much harder to trigger, regular filesystem operations won't go
into scrub path.

Unless there is also a full ioctl fuzzing tests, after corrupting the imag=
e.

> The data loaded from disk can have any combination of
> (correct/incorrect metadata) x (correct/incorrect checksum).
> Correctness of metadata and checksum are effectively orthogonal,

Oh, I almost forgot another problem with the compile time csum
verification skip.

If we skip csum check completely, just like the patch, it may cause less
path coverage (this is very btrfs specific)

The problem is, btrfs has some repair path (scrub, and read-time), which
requires to have a checksum mismatch (and a good copy with good checksum).

Thus if we ignore csum completely, the repair path will never be covered
(as we treat them all as csum match).

Thanks,
Qu

> right?
>
>
>
>> Thanks,
>> Qu
>>
>>>                sblock->checksum_error =3D 1;
>>>
>>>        return sblock->header_error || sblock->checksum_error;
>>> @@ -2099,7 +2101,8 @@ static int scrub_checksum_super(struct scrub_blo=
ck *sblock)
>>>        crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
>>>                        BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calcul=
ated_csum);
>>>
>>> -     if (memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
>>> +     if (!IS_ENABLED(CONFIG_DISABLE_FS_CSUM_VERIFICATION) &&
>>> +         memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
>>>                ++fail_cor;
>>>
>>>        return fail_cor + fail_gen;
