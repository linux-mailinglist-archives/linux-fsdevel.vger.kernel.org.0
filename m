Return-Path: <linux-fsdevel+bounces-55665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988EB0D839
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 13:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AA718956DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24F72E3380;
	Tue, 22 Jul 2025 11:29:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF9127456;
	Tue, 22 Jul 2025 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183755; cv=none; b=N3dnhh4Bi0hN5g9v5O1G+Zgw0Yx66XPy2cqtL0wwkFKvTgaIBPM3uG/fhOgWSBQea4VEShBwAMRzBYPoFyGakh5+WXDt+4Ox9CkH8JaJmZcnftiUsQez4WceonSGWA7ITeeX0DCMibKzz2LQSI/WJLTd5QaVlTIE2yqF7fD8WjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183755; c=relaxed/simple;
	bh=tDMXmkuXWFEiObLEX0JEu1AbKcmcq54Z8EFGI7S6Iy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EImySs/nb/B2h9zMeN4XfVgu2EI2FZzpiI9PXB+ultbTTXW1U9TOz9I9X9blaYb53wDQxjTPrdRQCfY2sExatX6sBiDAz1BchrJfCrMqBQm97RG1j1zTNYG2+pRhUNpUWFLAl8JqTmqJhXgK1t52QW+WzdUwEe6L17jUeot05DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 56MAgdQo090700;
	Tue, 22 Jul 2025 19:42:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 56MAgdPt090697
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 22 Jul 2025 19:42:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
Date: Tue, 22 Jul 2025 19:42:35 +0900
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
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
 <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
 <175a5ded-518a-4002-8650-cffc7f94aec4@I-love.SAKURA.ne.jp>
 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/07/22 2:04, Viacheslav Dubeyko wrote:
> On Fri, 2025-07-18 at 07:08 +0900, Tetsuo Handa wrote:
>> On 2025/07/18 4:49, Viacheslav Dubeyko wrote:
>>> I assume if we created the inode as normal with i_ino == 0, then we can make it
>>> as a dirty. Because, inode will be made as bad inode here [2] only if rec->type
>>> is invalid. But if it is valid, then we can create the normal inode even with
>>> i_ino == 0.
>>
>> You are right. The crafted filesystem image in the reproducer is hitting HFS_CDR_DIR with
>> inode->i_ino = 0 ( https://elixir.bootlin.com/linux/v6.16-rc6/source/fs/hfs/inode.c#L363   ).
> 
> So, any plans to rework the patch?
> 

What do you mean by "rework"?

I can update patch description if you have one, but I don't plan to try something like below.

@@ -393,20 +393,30 @@ struct inode *hfs_iget(struct super_block *sb, struct hfs_cat_key *key, hfs_cat_
        switch (rec->type) {
        case HFS_CDR_DIR:
                cnid = be32_to_cpu(rec->dir.DirID);
                break;
        case HFS_CDR_FIL:
                cnid = be32_to_cpu(rec->file.FlNum);
                break;
        default:
                return NULL;
        }
+       if (cnid < HFS_FIRSTUSER_CNID) {
+               switch (cnid) {
+               case HFS_ROOT_CNID:
+               case HFS_EXT_CNID:
+               case HFS_CAT_CNID:
+                       break;
+               default:
+                       return NULL;
+               }
+       }
        inode = iget5_locked(sb, cnid, hfs_test_inode, hfs_read_inode, &data);
        if (inode && (inode->i_state & I_NEW))
                unlock_new_inode(inode);
        return inode;
 }


