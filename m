Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA234B4FA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 13:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiBNMIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 07:08:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiBNMIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:08:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC5912C128
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 04:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644840504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooxX/xRFxcUNwx8Utj75/oEIKXrvFZcoKQ+3anmvESk=;
        b=Oga9W6jo08vDuCs8yzAVHfo5e/B95mmQIFBwz3leD1Dp/nIUh/gfQAp1veJfq8r+4SnnZx
        5SISNlax9lQh4Imj0AtgFxKn8Fu129lNTokvwxfXGW8UikOLuxn4SdrCU22eod7CRp1NA6
        EP10Z2cz1RFYkNyYoEgWkJ1c6In5eQM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-MWSlCQJVPsWM-v0jiwml_w-1; Mon, 14 Feb 2022 07:08:23 -0500
X-MC-Unique: MWSlCQJVPsWM-v0jiwml_w-1
Received: by mail-pf1-f199.google.com with SMTP id c192-20020a621cc9000000b004e0ff94313dso3388298pfc.17
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 04:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ooxX/xRFxcUNwx8Utj75/oEIKXrvFZcoKQ+3anmvESk=;
        b=Y9eRlUQfc8Vi/3e1s0V0yhB5TJ/bCeMHaVtssMpCAnDISZbe634GXMa0SbMsG8jeOQ
         qTfypSpwW4PY0fTRY0DpoC0SXXU1R2fK8BYFYKQ38n4a0pkh4UiU7cukcz7w9ebr65Bi
         jPJ3JpDnfBepO4uYjVc+ldzfxp4JoL0g/CBnSfaPquBrTke51iqbv/hgKf21No5fChyD
         HezkRccu5yi1yERWX3CI4QnoHdKnyvMswk2qu1JxPybg3pqyU99cv4viuPcirL8TSTow
         wDHvDVG1L1/Xj0U4s2K/VMGnoDPEipP8XNt4EoWxM0IsdI1TZqiipp2OZPb7CXoUUDRi
         T07g==
X-Gm-Message-State: AOAM531oC9aeh2lw1eset0e0kjoyp0K0n7wy8BoZauehKOWL+J6Mg3n2
        axECnI67O7EK18y9eh+bVOsBN1NFolmMCjFBNrpQkFQKi5yjIunuuy9dsA7+U6XK1hkDQz9uKjz
        wBhJZFbQIJcJae+2POeNLpkBtNA==
X-Received: by 2002:a17:90b:3e86:: with SMTP id rj6mr8567976pjb.226.1644840500987;
        Mon, 14 Feb 2022 04:08:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzm5MvpH3v7diTkG8MZNo2rgllDc1UEg9hwaPCnTgwte+A/qf2PT71j1qCIA0KjhtcikN56zg==
X-Received: by 2002:a17:90b:3e86:: with SMTP id rj6mr8567933pjb.226.1644840500541;
        Mon, 14 Feb 2022 04:08:20 -0800 (PST)
Received: from [10.72.12.153] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 132sm24020977pfw.21.2022.02.14.04.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 04:08:19 -0800 (PST)
Subject: Re: [RFC PATCH v10 00/48] ceph+fscrypt: full support
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
References: <20220111191608.88762-1-jlayton@kernel.org>
 <e7812f96-dae2-208d-bb95-372f3a92b1f6@redhat.com>
 <439916d0590448120a6e92261207bc91fe672dca.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <ba8115f5-3c38-d152-05ef-e02f7aff22a1@redhat.com>
Date:   Mon, 14 Feb 2022 20:08:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <439916d0590448120a6e92261207bc91fe672dca.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2/14/22 7:33 PM, Jeff Layton wrote:
> On Mon, 2022-02-14 at 17:37 +0800, Xiubo Li wrote:
>> Hi Jeff,
>>
>> I am using the 'wip-fscrypt' branch to test other issue and hit:
>>
>> cp: cannot access './dir___683': No buffer space available
>> cp: cannot access './dir___686': No buffer space available
>> cp: cannot access './dir___687': No buffer space available
>> cp: cannot access './dir___688': No buffer space available
>> cp: cannot access './dir___689': No buffer space available
>> cp: cannot access './dir___693': No buffer space available
>>
>> ...
>>
>> [root@lxbceph1 kcephfs]# diff ./dir___997 /data/backup/kernel/dir___997
>> diff: ./dir___997: No buffer space available
>>
>>
>> The dmesg logs:
>>
>> <7>[ 1256.918228] ceph:  do_getattr inode 0000000089964a71 mask AsXsFs
>> mode 040755
>> <7>[ 1256.918232] ceph:  __ceph_caps_issued_mask ino 0x100000009be cap
>> 0000000014f1c64b issued pAsLsXsFs (mask AsXsFs)
>> <7>[ 1256.918237] ceph:  __touch_cap 0000000089964a71 cap
>> 0000000014f1c64b mds0
>> <7>[ 1256.918250] ceph:  readdir 0000000089964a71 file 00000000065cb689
>> pos 0
>> <7>[ 1256.918254] ceph:  readdir off 0 -> '.'
>> <7>[ 1256.918258] ceph:  readdir off 1 -> '..'
>> <4>[ 1256.918262] fscrypt (ceph, inode 1099511630270): Error -105
>> getting encryption context
>> <7>[ 1256.918269] ceph:  readdir 0000000089964a71 file 00000000065cb689
>> pos 2
>> <4>[ 1256.918273] fscrypt (ceph, inode 1099511630270): Error -105
>> getting encryption context
>> <7>[ 1256.918288] ceph:  release inode 0000000089964a71 dir file
>> 00000000065cb689
>> <7>[ 1256.918310] ceph:  __ceph_caps_issued_mask ino 0x1 cap
>> 00000000aa2afb8b issued pAsLsXsFs (mask Fs)
>> <7>[ 1257.574593] ceph:  mdsc delayed_work
>>
>> I did nothing about the fscrypt after mounting the kclient, just create
>> 2000 directories and then made some snapshots on the root dir and then
>> try to copy the root directory to the backup.
>>
>> - Xiubo
>>
> That means that ceph_crypt_get_context returned -ENODATA, which it can

It should be -ENOBUFS.

I am not sure it relates to the snapshot stuff. I will try without the 
snapshot later.

I can debug it later, maybe in next week.

-- Xiubo

> do for several different reasons. We probably need to add in some
> debugging there to see which one it is...
>
> TBH, I've done absolutely no testing with snapshots, so it's quite
> possible there is some interaction there that is causing problems.
>
> -- Jeff
>
>> On 1/12/22 3:15 AM, Jeff Layton wrote:
>>> This patchset represents a (mostly) complete rough draft of fscrypt
>>> support for cephfs. The context, filename and symlink support is more or
>>> less the same as the versions posted before, and comprise the first half
>>> of the patches.
>>>
>>> The new bits here are the size handling changes and support for content
>>> encryption, in buffered, direct and synchronous codepaths. Much of this
>>> code is still very rough and needs a lot of cleanup work.
>>>
>>> fscrypt support relies on some MDS changes that are being tracked here:
>>>
>>>       https://github.com/ceph/ceph/pull/43588
>>>
>>> In particular, this PR adds some new opaque fields in the inode that we
>>> use to store fscrypt-specific information, like the context and the real
>>> size of a file. That is slated to be merged for the upcoming Quincy
>>> release (which is sometime this northern spring).
>>>
>>> There are still some notable bugs:
>>>
>>> 1/ we've identified a few more potential races in truncate handling
>>> which will probably necessitate a protocol change, as well as changes to
>>> the MDS and kclient patchsets. The good news is that we think we have
>>> an approach that will resolve this.
>>>
>>> 2/ the kclient doesn't handle reading sparse regions in OSD objects
>>> properly yet. The client can end up writing to a non-zero offset in a
>>> non-existent object. Then, if the client tries to read the written
>>> region back later, it'll get back zeroes and give you garbage when you
>>> try to decrypt them.
>>>
>>> It turns out that the OSD already supports a SPARSE_READ operation, so
>>> I'm working on implementing that in the kclient to make it not try to
>>> decrypt the sparse regions.
>>>
>>> Still, I was able to run xfstests on this set yesterday. Bug #2 above
>>> prevented all of the tests from passing, but it didn't oops! I call that
>>> progress! Given that, I figured this is a good time to post what I have
>>> so far.
>>>
>>> Note that the buffered I/O changes in this set are not suitable for
>>> merge and will likely end up being discarded. We need to plumb the
>>> encryption in at the netfs layer, so that we can store encrypted data
>>> in fscache.
>>>
>>> The non-buffered codepaths will likely also need substantial changes
>>> before merging. It may be simpler to just move that into the netfs layer
>>> too as cifs will need something similar anyway.
>>>
>>> My goal is to get most of this into v5.18, but v5.19 might be more
>>> realistiv. Hopefully I'll have a non-RFC patchset to send in a few
>>> weeks.
>>>
>>> Special thanks to Xiubo who came through with the MDS patches. Also,
>>> thanks to everyone (especially Eric Biggers) for all of the previous
>>> reviews. It's much appreciated!
>>>
>>> Jeff Layton (43):
>>>     vfs: export new_inode_pseudo
>>>     fscrypt: export fscrypt_base64url_encode and fscrypt_base64url_decode
>>>     fscrypt: export fscrypt_fname_encrypt and fscrypt_fname_encrypted_size
>>>     fscrypt: add fscrypt_context_for_new_inode
>>>     ceph: preallocate inode for ops that may create one
>>>     ceph: crypto context handling for ceph
>>>     ceph: parse new fscrypt_auth and fscrypt_file fields in inode traces
>>>     ceph: add fscrypt_* handling to caps.c
>>>     ceph: add ability to set fscrypt_auth via setattr
>>>     ceph: implement -o test_dummy_encryption mount option
>>>     ceph: decode alternate_name in lease info
>>>     ceph: add fscrypt ioctls
>>>     ceph: make ceph_msdc_build_path use ref-walk
>>>     ceph: add encrypted fname handling to ceph_mdsc_build_path
>>>     ceph: send altname in MClientRequest
>>>     ceph: encode encrypted name in dentry release
>>>     ceph: properly set DCACHE_NOKEY_NAME flag in lookup
>>>     ceph: make d_revalidate call fscrypt revalidator for encrypted
>>>       dentries
>>>     ceph: add helpers for converting names for userland presentation
>>>     ceph: add fscrypt support to ceph_fill_trace
>>>     ceph: add support to readdir for encrypted filenames
>>>     ceph: create symlinks with encrypted and base64-encoded targets
>>>     ceph: make ceph_get_name decrypt filenames
>>>     ceph: add a new ceph.fscrypt.auth vxattr
>>>     ceph: add some fscrypt guardrails
>>>     libceph: add CEPH_OSD_OP_ASSERT_VER support
>>>     ceph: size handling for encrypted inodes in cap updates
>>>     ceph: fscrypt_file field handling in MClientRequest messages
>>>     ceph: get file size from fscrypt_file when present in inode traces
>>>     ceph: handle fscrypt fields in cap messages from MDS
>>>     ceph: add infrastructure for file encryption and decryption
>>>     libceph: allow ceph_osdc_new_request to accept a multi-op read
>>>     ceph: disable fallocate for encrypted inodes
>>>     ceph: disable copy offload on encrypted inodes
>>>     ceph: don't use special DIO path for encrypted inodes
>>>     ceph: set encryption context on open
>>>     ceph: align data in pages in ceph_sync_write
>>>     ceph: add read/modify/write to ceph_sync_write
>>>     ceph: plumb in decryption during sync reads
>>>     ceph: set i_blkbits to crypto block size for encrypted inodes
>>>     ceph: add fscrypt decryption support to ceph_netfs_issue_op
>>>     ceph: add encryption support to writepage
>>>     ceph: fscrypt support for writepages
>>>
>>> Luis Henriques (1):
>>>     ceph: don't allow changing layout on encrypted files/directories
>>>
>>> Xiubo Li (4):
>>>     ceph: add __ceph_get_caps helper support
>>>     ceph: add __ceph_sync_read helper support
>>>     ceph: add object version support for sync read
>>>     ceph: add truncate size handling support for fscrypt
>>>
>>>    fs/ceph/Makefile                |   1 +
>>>    fs/ceph/acl.c                   |   4 +-
>>>    fs/ceph/addr.c                  | 128 +++++--
>>>    fs/ceph/caps.c                  | 211 ++++++++++--
>>>    fs/ceph/crypto.c                | 374 +++++++++++++++++++++
>>>    fs/ceph/crypto.h                | 237 +++++++++++++
>>>    fs/ceph/dir.c                   | 209 +++++++++---
>>>    fs/ceph/export.c                |  44 ++-
>>>    fs/ceph/file.c                  | 476 +++++++++++++++++++++-----
>>>    fs/ceph/inode.c                 | 576 +++++++++++++++++++++++++++++---
>>>    fs/ceph/ioctl.c                 |  87 +++++
>>>    fs/ceph/mds_client.c            | 349 ++++++++++++++++---
>>>    fs/ceph/mds_client.h            |  24 +-
>>>    fs/ceph/super.c                 |  90 ++++-
>>>    fs/ceph/super.h                 |  43 ++-
>>>    fs/ceph/xattr.c                 |  29 ++
>>>    fs/crypto/fname.c               |  44 ++-
>>>    fs/crypto/fscrypt_private.h     |   9 +-
>>>    fs/crypto/hooks.c               |   6 +-
>>>    fs/crypto/policy.c              |  35 +-
>>>    fs/inode.c                      |   1 +
>>>    include/linux/ceph/ceph_fs.h    |  21 +-
>>>    include/linux/ceph/osd_client.h |   6 +-
>>>    include/linux/ceph/rados.h      |   4 +
>>>    include/linux/fscrypt.h         |  10 +
>>>    net/ceph/osd_client.c           |  32 +-
>>>    26 files changed, 2700 insertions(+), 350 deletions(-)
>>>    create mode 100644 fs/ceph/crypto.c
>>>    create mode 100644 fs/ceph/crypto.h
>>>

