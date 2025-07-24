Return-Path: <linux-fsdevel+bounces-55979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF875B1138E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED137AF1C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AA230D0A;
	Thu, 24 Jul 2025 22:06:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A961DFE22;
	Thu, 24 Jul 2025 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394789; cv=none; b=L1LmLQxwmI1Xv6TnBr2ACiMG6vRV5Bxa7LwLftaZQpa3CagZwvxKqWjBTJ5p4r9SP/8DGjJYOlk7v1dp7Cilreq+5t0cufe20IwwpXjEQnYPAou0W+KaOevqx/DmC1nwe6RgMMPLLgwNW7l9uSXOChuhH3VxL3RTQGPufdIi8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394789; c=relaxed/simple;
	bh=FtZ/IEN8OSOIgWYdGGd82du/8nLifYh3kXMGkOGXw1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRP4aq8W2Kv68imGnjLsXzgnLJl9616h/V4GPaJxKaRF0kbTZeJ0YAKdtPwmLP1av0DgRMDMWMyzHJqzqKt3N+gRXPhyAmikjFi3vMqCPcW0kyOmb2EOOsuP4JKMZQiTQfwbFY5vHg395e+RaK74asry1Xqo9rd9SEOefFazwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56OM5YJt001980;
	Fri, 25 Jul 2025 07:05:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56OM5YgN001970
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 25 Jul 2025 07:05:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
Date: Fri, 25 Jul 2025 07:05:32 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "willy@infradead.org" <willy@infradead.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
 <aH-enGSS7zWq0jFf@casper.infradead.org>
 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/25 4:49, Viacheslav Dubeyko wrote:
> On Thu, 2025-07-24 at 15:55 +0900, Tetsuo Handa wrote:
>> Then, something like below change?
>>
>> --- a/fs/hfs/inode.c
>> +++ b/fs/hfs/inode.c
>> @@ -318,6 +318,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
>>         struct hfs_iget_data *idata = data;
>>         struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
>>         hfs_cat_rec *rec;
>> +       /* https://developer.apple.com/library/archive/technotes/tn/tn1150.html#CNID   */
> 
> We already have all declarations in hfs.h:
> 
> /* Some special File ID numbers */
> #define HFS_POR_CNID		1	/* Parent Of the Root */
> #define HFS_ROOT_CNID		2	/* ROOT directory */
> #define HFS_EXT_CNID		3	/* EXTents B-tree */
> #define HFS_CAT_CNID		4	/* CATalog B-tree */
> #define HFS_BAD_CNID		5	/* BAD blocks file */
> #define HFS_ALLOC_CNID		6	/* ALLOCation file (HFS+) */
> #define HFS_START_CNID		7	/* STARTup file (HFS+) */
> #define HFS_ATTR_CNID		8	/* ATTRibutes file (HFS+) */
> #define HFS_EXCH_CNID		15	/* ExchangeFiles temp id */
> #define HFS_FIRSTUSER_CNID	16

These declarations does not define 14, and some flags are never used despite
being declared here.

> 
> So, adding the link here doesn't make any sense.
> 
>> +       static const u16 bad_cnid_list = (1 << 0) | (1 << 6) | (1 << 7) | (1 << 8) |
>> +               (1 << 9) | (1 << 10) | (1 << 11) | (1 << 12) | (1 << 13);

Some of values in this constant are not declared.

> 
> I don't see any sense to introduce flags here. First of all, please, don't use
> hardcoded values but you should use declared constants from hfs.h (for example,
> HFS_EXT_CNID instead of 3). Secondly, you can simply compare the i_ino with
> constants, for example:

This will save a lot of computational power compared to switch().

> 
> bool is_inode_id_invalid(u64 ino) {
>       switch (inode->i_ino) {
>       case HFS_EXT_CNID:
>       ...
>           return true;
> 
>       }
> 
>       return false;
> }
> 
> Thirdly, you can introduce an inline function that can do such check. And it
> make sense to introduce constant for the case of zero value.
> 
> Why have you missed HFS_EXT_CNID, HFS_CAT_CNID? These values cannot used in
> hfs_read_inode().

Is hfs_read_inode() never called for HFS_EXT_CNID and HFS_CAT_CNID ?

> 
>>
>>         HFS_I(inode)->flags = 0;
>>         HFS_I(inode)->rsrc_inode = NULL;
>> @@ -358,6 +361,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
>>                 inode->i_op = &hfs_file_inode_operations;
>>                 inode->i_fop = &hfs_file_operations;
>>                 inode->i_mapping->a_ops = &hfs_aops;
>> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
>> +                       make_bad_inode(inode);
> 
> It looks pretty complicated. You can simply use one above-mentioned function
> with the check:
> 
> if (is_inode_id_invalid(be32_to_cpu(rec->dir.DirID)))
>      <goto to make bad inode>
> 
> We can simply check the the inode ID in the beginning of the whole action:
> 
> <Make the check here>
> 		inode->i_ino = be32_to_cpu(rec->file.FlNum);
> 		inode->i_mode = S_IRUGO | S_IXUGO;
> 		if (!(rec->file.Flags & HFS_FIL_LOCK))
> 			inode->i_mode |= S_IWUGO;
> 		inode->i_mode &= ~hsb->s_file_umask;
> 		inode->i_mode |= S_IFREG;
> 		inode_set_mtime_to_ts(inode,
> 				      inode_set_atime_to_ts(inode,
> inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->file.MdDat))));
> 		inode->i_op = &hfs_file_inode_operations;
> 		inode->i_fop = &hfs_file_operations;
> 		inode->i_mapping->a_ops = &hfs_aops;
> 
> It doesn't make any sense to construct inode if we will make in bad inode,
> finally. Don't waste computational power. :)
> 
>>                 break;
>>         case HFS_CDR_DIR:
>>                 inode->i_ino = be32_to_cpu(rec->dir.DirID);
>> @@ -368,6 +373,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
>>                                       inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
>>                 inode->i_op = &hfs_dir_inode_operations;
>>                 inode->i_fop = &hfs_dir_operations;
>> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
>> +                       make_bad_inode(inode);
> 
> We already have make_bad_inode(inode) as default action. So, simply jump there.
> 
>>                 break;
>>         default:
>>                 make_bad_inode(inode);
>>
>>
>>
>> But I can't be convinced that above change is sufficient, for if I do
>>
>> +		static u8 serial;
>> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
>> +                       inode->i_ino = (serial++) % 16;
> 
> I don't see the point in flags introduction. It makes logic very complicated.

The point of this change is to excecise inode->i_ino for all values between 0 and 15.
Some of values between 0 and 15 must be valid as inode->i_ino , doesn't these? Then,

> 
>>
>> instead of
>>
>> +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inode->i_ino) & bad_cnid_list))
>> +                       make_bad_inode(inode);
>>
>> , the reproducer still hits BUG() for 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15
>> because hfs_write_inode() handles only 2, 3 and 4.
>>
> 
> How can we go into hfs_write_inode() if we created the bad inode for invalid
> inode ID? How is it possible?

are all of 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15 invalid value for hfs_read_inode() ?

If all of 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15 are invalid value for hfs_read_inode(),
and 3 and 4 are also invalid value for hfs_read_inode(), hfs_read_inode() would accept only 2.
Something is crazily wrong.

Can we really filter some of values between 0 and 15 at hfs_read_inode() ?


