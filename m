Return-Path: <linux-fsdevel+bounces-56536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC70B188EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 23:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7095A0B5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092B220F2B;
	Fri,  1 Aug 2025 21:53:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459616F8E9;
	Fri,  1 Aug 2025 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085187; cv=none; b=nC9aNKHzYOpj0/Torj3rj7y7LVNbXRxpt9kv274GcIW3jJgzbj0KkMopNBp/uim31fXWNgYtWvKHcXxLBUeKHO1vE9JKSB8W479szJWWS840Bx3Ctl4obd//0LEl92h6ugNI8kjASvWJwPywVxYGg299qdA/2q0g206PgaD4OZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085187; c=relaxed/simple;
	bh=bRWx2pAgCkgzaxaEhGPC83Gy2yU8rwcb+0y2pqaC6A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEb83rxDJsWmlq5wmUW9zVOp3hNRlBZyrKWcHMCSxmhxfPlyP2fBTX66oKcUQ4pDKQNQJWCfhstaJJj3tvIJkdfv51cyfJ1hAfYiUE6tBhLFmKzEvC2nl4PsPpzY/snrgMY7oDapD0Lg+nvLQqDnxHrtzh6pwuBjE5fwXmCPIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 571Lq1OE017435;
	Sat, 2 Aug 2025 06:52:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 571Lq1dn017431
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 2 Aug 2025 06:52:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <98938e56-b404-4748-94bd-75c88415fafe@I-love.SAKURA.ne.jp>
Date: Sat, 2 Aug 2025 06:52:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hfs: update sanity check of the root record
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "leocstone@gmail.com" <leocstone@gmail.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "willy@infradead.org" <willy@infradead.org>,
        "brauner@kernel.org" <brauner@kernel.org>
Cc: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
 <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
 <12de16685af71b513f8027a8bfd14bc0322eb043.camel@ibm.com>
 <0b9799d4-b938-4843-a863-8e2795d33eca@I-love.SAKURA.ne.jp>
 <427fcb57-8424-4e52-9f21-7041b2c4ae5b@I-love.SAKURA.ne.jp>
 <5498a57ea660b5366ef213acd554aba55a5804d1.camel@ibm.com>
 <57d65c2f-ca35-475d-b950-8fd52b135625@I-love.SAKURA.ne.jp>
 <f0580422d0d8059b4b5303e56e18700539dda39a.camel@ibm.com>
 <5f0769cd-2cbb-4349-8be4-dfdc74c2c5f8@I-love.SAKURA.ne.jp>
 <06bea1c3fc9080b5798e6b5ad1ad533a145bf036.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <06bea1c3fc9080b5798e6b5ad1ad533a145bf036.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp

On 2025/08/02 3:26, Viacheslav Dubeyko wrote:
> On Fri, 2025-08-01 at 06:12 +0900, Tetsuo Handa wrote:
>> On 2025/08/01 3:03, Viacheslav Dubeyko wrote:
>>> On Thu, 2025-07-31 at 07:02 +0900, Tetsuo Handa wrote:
>>>> On 2025/07/31 4:24, Viacheslav Dubeyko wrote:
>>>>> If we considering case HFS_CDR_DIR in hfs_read_inode(), then we know that it
>>>>> could be HFS_POR_CNID, HFS_ROOT_CNID, or >= HFS_FIRSTUSER_CNID. Do you mean that
>>>>> HFS_POR_CNID could be a problem in hfs_write_inode()?
>>>>
>>>> Yes. Passing one of 1, 5 or 15 instead of 2 from hfs_fill_super() triggers BUG()
>>>> in hfs_write_inode(). We *MUST* validate at hfs_fill_super(), or hfs_read_inode()
>>>> shall have to also reject 1, 5 and 15 (and as a result only accept 2).
>>>
>>> The fix should be in hfs_read_inode(). Currently, suggested solution hides the
>>> issue but not fix the problem.
>>
>> Not fixing this problem might be hiding other issues, by hitting BUG() before
>> other issues shows up.
>>
> 
> I am not going to start a philosophical discussion. We simply need to fix the
> bug. The suggested patch doesn't fix the issue.

What is your issue?

My issue (what syzbot is reporting) is that the kernel crashes if the inode number
of the record retrieved as a result of hfs_cat_find_brec(HFS_ROOT_CNID) is not
HFS_ROOT_CNID. My suggested patch does fix my issue.

> Please, don't use hardcoded value. I already shared the point that we must use
> the declared constants.
> 
> This function is incorrect and it cannot work for folders and files at the same
> time.

I already shared that I don't plan to try writing such function
( http://lkml.kernel.org/r/38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp ).

Please show us your patch that solves your issue.


