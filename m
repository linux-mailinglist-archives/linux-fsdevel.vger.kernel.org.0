Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53973BE866
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 14:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhGGM4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 08:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229757AbhGGM4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625662413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wy5ncZuQPIqmGF2aBdw1jfG4h9ylCDcrB9SiXIRRXtI=;
        b=bpDES1BuhgBKBfd5TfMoFjdgiIr/EGZcO4AntsIPZSPhiwrpMiaWDuF6GArNB5ZEVEcith
        37gEsXp+70nrYUtaxoJS2cvMt0aqrQIRXziGl4xMKjnfIG9dxIqIY3V4/BsAnhL/0ZT8QL
        eoyeKCmz60VfkBAqPo9DHToilKnhQE8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-R7ENG0CKMN-Do1jFjjkCSw-1; Wed, 07 Jul 2021 08:53:32 -0400
X-MC-Unique: R7ENG0CKMN-Do1jFjjkCSw-1
Received: by mail-pf1-f199.google.com with SMTP id l21-20020a056a0016d5b0290319e1ac27b1so1456551pfc.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 05:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Wy5ncZuQPIqmGF2aBdw1jfG4h9ylCDcrB9SiXIRRXtI=;
        b=S1iUmyap4ac6iuKxer9trd6JNqisRJgGMlRSw405/Cv9nE/ZHCuKyJETNMSf3uEoSa
         2lEOmGSAE4LRQ0g0gFPZrRbXLzv1NkloTDGn4qGvaGSCn1DaExnmZ6WTZkzPjM21zlwv
         Dmoh/ezZh6IcL5NIpNR5ecqpJrIHHrkvvczDvhc8HC/xgM17aqMjzDiv8iKNKbow1BBW
         uh1VrlTlJVjf5/YTHHb8OifiP/GWi3XfKGhdD+HwMh5jo9sVa8Y7y7jKZeFq0sWVNZqw
         ykXufrmNktoDGE0RvkMDbOb1nwHJ+yi8GuRh3+db5RDCOFpi0bKU9yMm+SPxZBkiNM0j
         xoEg==
X-Gm-Message-State: AOAM5305sDySFTNBfH4zBTWRwLfb8lMjX+B4cM6PN+aGO50IyacmvDSp
        ThOiwqQ40xhVx2xUASV6jNh1cPi0mtDt62SSizjm2kUqX0M7iNGdRSqOLzC6Te0igiLKZOlgNfM
        nVP5x82pketHF7Tl0Z6d4ufzCFg==
X-Received: by 2002:a63:4f11:: with SMTP id d17mr26146093pgb.20.1625661993943;
        Wed, 07 Jul 2021 05:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzzqw0reNUVSU8vvw5fXlTRmFdOsQCOXi+wf4gWpcbMIPBp1DB0iu/41x/kALhmf8qWnM+ng==
X-Received: by 2002:a63:4f11:: with SMTP id d17mr26146062pgb.20.1625661993659;
        Wed, 07 Jul 2021 05:46:33 -0700 (PDT)
Received: from [10.72.12.137] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s193sm21174394pfc.183.2021.07.07.05.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 05:46:33 -0700 (PDT)
Subject: Re: [RFC PATCH v7 06/24] ceph: parse new fscrypt_auth and
 fscrypt_file fields in inode traces
To:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc:     lhenriques@suse.de, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, dhowells@redhat.com
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-7-jlayton@kernel.org>
 <fbf80709-e87a-9334-45d7-9cca5726b037@redhat.com>
 <ca7405d2353adb1af1b9ff2555785ba01b6266f3.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <47a3c1bb-6277-45f5-4cb5-94eaa4e3787b@redhat.com>
Date:   Wed, 7 Jul 2021 20:46:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ca7405d2353adb1af1b9ff2555785ba01b6266f3.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/7/21 8:09 PM, Jeff Layton wrote:
> On Wed, 2021-07-07 at 11:53 +0800, Xiubo Li wrote:
>> On 6/25/21 9:58 PM, Jeff Layton wrote:
>>> ...and store them in the ceph_inode_info.
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>    fs/ceph/file.c       |  2 ++
>>>    fs/ceph/inode.c      | 18 ++++++++++++++++++
>>>    fs/ceph/mds_client.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>    fs/ceph/mds_client.h |  4 ++++
>>>    fs/ceph/super.h      |  6 ++++++
>>>    5 files changed, 74 insertions(+)
>>>
>>> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
>>> index 2cda398ba64d..ea0e85075b7b 100644
>>> --- a/fs/ceph/file.c
>>> +++ b/fs/ceph/file.c
>>> @@ -592,6 +592,8 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
>>>    	iinfo.xattr_data = xattr_buf;
>>>    	memset(iinfo.xattr_data, 0, iinfo.xattr_len);
>>>    
>>> +	/* FIXME: set fscrypt_auth and fscrypt_file */
>>> +
>>>    	in.ino = cpu_to_le64(vino.ino);
>>>    	in.snapid = cpu_to_le64(CEPH_NOSNAP);
>>>    	in.version = cpu_to_le64(1);	// ???
>>> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
>>> index f62785e4dbcb..b620281ea65b 100644
>>> --- a/fs/ceph/inode.c
>>> +++ b/fs/ceph/inode.c
>>> @@ -611,6 +611,13 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
>>>    
>>>    	ci->i_meta_err = 0;
>>>    
>>> +#ifdef CONFIG_FS_ENCRYPTION
>>> +	ci->fscrypt_auth = NULL;
>>> +	ci->fscrypt_auth_len = 0;
>>> +	ci->fscrypt_file = NULL;
>>> +	ci->fscrypt_file_len = 0;
>>> +#endif
>>> +
>>>    	return &ci->vfs_inode;
>>>    }
>>>    
>>> @@ -619,6 +626,9 @@ void ceph_free_inode(struct inode *inode)
>>>    	struct ceph_inode_info *ci = ceph_inode(inode);
>>>    
>>>    	kfree(ci->i_symlink);
>>> +#ifdef CONFIG_FS_ENCRYPTION
>>> +	kfree(ci->fscrypt_auth);
>>> +#endif
>>>    	kmem_cache_free(ceph_inode_cachep, ci);
>>>    }
>>>    
>>> @@ -1021,6 +1031,14 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
>>>    		xattr_blob = NULL;
>>>    	}
>>>    
>>> +	if (iinfo->fscrypt_auth_len && !ci->fscrypt_auth) {
>>> +		ci->fscrypt_auth_len = iinfo->fscrypt_auth_len;
>>> +		ci->fscrypt_auth = iinfo->fscrypt_auth;
>>> +		iinfo->fscrypt_auth = NULL;
>>> +		iinfo->fscrypt_auth_len = 0;
>>> +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
>>> +	}
>>> +
>>>    	/* finally update i_version */
>>>    	if (le64_to_cpu(info->version) > ci->i_version)
>>>    		ci->i_version = le64_to_cpu(info->version);
>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>> index 3b3a14024ca0..9c994effc51d 100644
>>> --- a/fs/ceph/mds_client.c
>>> +++ b/fs/ceph/mds_client.c
>>> @@ -183,8 +183,48 @@ static int parse_reply_info_in(void **p, void *end,
>>>    			info->rsnaps = 0;
>>>    		}
>>>    
>>> +		if (struct_v >= 5) {
>>> +			u32 alen;
>>> +
>>> +			ceph_decode_32_safe(p, end, alen, bad);
>>> +
>>> +			while (alen--) {
>>> +				u32 len;
>>> +
>>> +				/* key */
>>> +				ceph_decode_32_safe(p, end, len, bad);
>>> +				ceph_decode_skip_n(p, end, len, bad);
>>> +				/* value */
>>> +				ceph_decode_32_safe(p, end, len, bad);
>>> +				ceph_decode_skip_n(p, end, len, bad);
>>> +			}
>>> +		}
>>> +
>>> +		/* fscrypt flag -- ignore */
>>> +		if (struct_v >= 6)
>>> +			ceph_decode_skip_8(p, end, bad);
>>> +
>>> +		if (struct_v >= 7) {
>>> +			ceph_decode_32_safe(p, end, info->fscrypt_auth_len, bad);
>>> +			if (info->fscrypt_auth_len) {
>>> +				info->fscrypt_auth = kmalloc(info->fscrypt_auth_len, GFP_KERNEL);
>>> +				if (!info->fscrypt_auth)
>>> +					return -ENOMEM;
>>> +				ceph_decode_copy_safe(p, end, info->fscrypt_auth,
>>> +						      info->fscrypt_auth_len, bad);
>>> +			}
>>> +			ceph_decode_32_safe(p, end, info->fscrypt_file_len, bad);
>>> +			if (info->fscrypt_file_len) {
>>> +				info->fscrypt_file = kmalloc(info->fscrypt_file_len, GFP_KERNEL);
>>> +				if (!info->fscrypt_file)
>>> +					return -ENOMEM;
>> Should we kfree(info->fscrypt_auth) before return ?
>>
>> I didn't anywhere is freeing it.
>>
> It'll get freed in destroy_reply_info(). We could do it here, but it
> should be fine to wait until we're tearing the "info" structure down.
>
Yeah, I just missed the destory_reply_info() code that time.



>>
>>> +				ceph_decode_copy_safe(p, end, info->fscrypt_file,
>>> +						      info->fscrypt_file_len, bad);
>>> +			}
>>> +		}
>>>    		*p = end;
>>>    	} else {
>>> +		/* legacy (unversioned) struct */
>>>    		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
>>>    			ceph_decode_64_safe(p, end, info->inline_version, bad);
>>>    			ceph_decode_32_safe(p, end, info->inline_len, bad);
>>> @@ -625,6 +665,10 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
>>>    
>>>    static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
>>>    {
>>> +	kfree(info->diri.fscrypt_auth);
>>> +	kfree(info->diri.fscrypt_file);
>>> +	kfree(info->targeti.fscrypt_auth);
>>> +	kfree(info->targeti.fscrypt_file);
>>>    	if (!info->dir_entries)
>>>    		return;
>>>    	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
>>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>> index 64ea9d853b8d..0c3cc61fd038 100644
>>> --- a/fs/ceph/mds_client.h
>>> +++ b/fs/ceph/mds_client.h
>>> @@ -88,6 +88,10 @@ struct ceph_mds_reply_info_in {
>>>    	s32 dir_pin;
>>>    	struct ceph_timespec btime;
>>>    	struct ceph_timespec snap_btime;
>>> +	u8 *fscrypt_auth;
>>> +	u8 *fscrypt_file;
>>> +	u32 fscrypt_auth_len;
>>> +	u32 fscrypt_file_len;
>>>    	u64 rsnaps;
>>>    	u64 change_attr;
>>>    };
>>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>>> index 0cd94b296f5f..e032737fe472 100644
>>> --- a/fs/ceph/super.h
>>> +++ b/fs/ceph/super.h
>>> @@ -429,6 +429,12 @@ struct ceph_inode_info {
>>>    
>>>    #ifdef CONFIG_CEPH_FSCACHE
>>>    	struct fscache_cookie *fscache;
>>> +#endif
>>> +#ifdef CONFIG_FS_ENCRYPTION
>>> +	u32 fscrypt_auth_len;
>>> +	u32 fscrypt_file_len;
>>> +	u8 *fscrypt_auth;
>>> +	u8 *fscrypt_file;
>>>    #endif
>>>    	errseq_t i_meta_err;
>>>    

