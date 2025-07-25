Return-Path: <linux-fsdevel+bounces-56056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE53EB12644
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 23:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB8D1CC319D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C40252903;
	Fri, 25 Jul 2025 21:52:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA57DA6C;
	Fri, 25 Jul 2025 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753480376; cv=none; b=SJajlavi3o0o9VWVodgwlhpqlotOZWkU22Wq5vSRvRqCO0Ie6U+IOMEioSf1CQXyJV0JFAjP1inVsWTj/aOyW9wFkUlCmCb2/MGbJSpJG6OFOb5APkmfeUl2ChfqcFggg7g1mL1cUkQ8bVyTFMkFaERGW07g6sFdtVS8V9F7mb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753480376; c=relaxed/simple;
	bh=DbnWyxYjv1mpp0jU0z4R93m+cj8fGJpyLneUXGiR4cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEgzb1TXpPEUXUhGISPHBl9jGkpldbgsYBEX6xe8oFZO/tTy0SKjzQSVrSEwnmO+kdVlX0HKG3JZprPCOJD7N1N6yYB5Kig8g7EzJYLbg27z5WTw5Ii3BI7fswi436BXrUpkQYYFQAHuYch+uW2P2nCf8JmoQd+7b91kdYvjXX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56PLqMGf046548;
	Sat, 26 Jul 2025 06:52:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56PLqL49046545
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 26 Jul 2025 06:52:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1779f2ad-77da-40e3-9ee0-ef6c4cd468fa@I-love.SAKURA.ne.jp>
Date: Sat, 26 Jul 2025 06:52:21 +0900
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
 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
 <d4abeee2-e291-4da4-9e0e-7880a9c213e3@I-love.SAKURA.ne.jp>
 <650d29da-4f3a-4cfe-b633-ea3b1f27de96@I-love.SAKURA.ne.jp>
 <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <6db77f5cb0a35de69a5b6b26719e4ffb3fdac8c5.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp

On 2025/07/26 2:47, Viacheslav Dubeyko wrote:
>> I managed to find the offset of rec->dir.DirID in the filesystem image used by
>> the reproducer, and confirmed that any 0...15 values except 2..4 shall hit BUG()
>> in hfs_write_inode().
>>
>> Also, a legitimate filesystem image seems to have rec->dir.DirID == 2.
>>
>> That is, the only approach that can avoid hitting BUG() without removing BUG()
>> would be to verify that rec.type is HFS_CDR_DIR and rec.dir.DirID is HFS_ROOT_CNID.
>>
>> --- a/fs/hfs/super.c
>> +++ b/fs/hfs/super.c
>> @@ -354,7 +354,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>                         goto bail_hfs_find;
>>                 }
>>                 hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
>> -               if (rec.type != HFS_CDR_DIR)
>> +               if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
>>                         res = -EIO;
>>         }
>>         if (res)
>>
>> Is this condition correct?

Please explicitly answer this question.

Is this validation correct that rec.dir.DirID has to be HFS_ROOT_CNID ?

 	res = hfs_cat_find_brec(sb, HFS_ROOT_CNID, &fd);
 	if (!res) {
 		if (fd.entrylength != sizeof(rec.dir)) {
 			res =  -EIO;
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
-		if (rec.type != HFS_CDR_DIR)
+		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
 			res = -EIO;
 	}

I hope that this validation is correct because the "rec" which hfs_bnode_read()
reads is controlled by the result of hfs_cat_find_brec(HFS_ROOT_CNID).

>>
>> Discussion on what values should be filtered by hfs_read_inode() is
>> out of scope for this syzbot report.
> 
> I already shared in previous emails which particular inode IDs are valid or not
> for [0-16] group of values in the environment of hfs_read_inode().
> 

Checking which particular inode IDs hfs_read_inode() should accept is fine.
But such check cannot fix the bug reported at
https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b .

Checking the inode ID retrieved by hfs_cat_find_brec(HFS_ROOT_CNID) is indeed
HFS_ROOT_CNID can fix the bug reported at
https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b .


