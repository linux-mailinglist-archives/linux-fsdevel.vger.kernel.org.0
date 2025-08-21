Return-Path: <linux-fsdevel+bounces-58600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923B2B2F5C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA761CC6362
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD23093A0;
	Thu, 21 Aug 2025 10:58:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DC2ED17C;
	Thu, 21 Aug 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773930; cv=none; b=E6qZU/TAUOncw/RXXsSm6F4FLIi/L7qN9doi0bL14ztuBrlZOrl+l+DqlC+kIWZslG09BZWWxzujPjUGtTEM7NLtNUZoi3dGU7SV96nG0O1/K6bNJjtOPfYoP7kMNHNibj4vXXycUZL3idkXIzEMB8zP6OItJFmSU0U96n7mZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773930; c=relaxed/simple;
	bh=/UrVtg1jA2CXUsGcO4I6cJSGJyssZLggxJl6w2WHg4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Im39VdyEqEeN6Bes7kfCEvD9yypaOphlweM+5u6gaLch08VTotykT10jBB2aW1SLjq5hvAcPKZPQnP/bPb31KfvMi5DSVtVaAzNGROFCy9if3mZHMWZv6hFmW54ILZlDdbaC2VAHcTsxlCx+awGikxtR7fmE/wVsdgmvQdJMzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 57LAvf9g053153;
	Thu, 21 Aug 2025 19:57:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 57LAvfw2053149
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 21 Aug 2025 19:57:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <23498435-ee11-4eb9-9be9-8460a6fa17f1@I-love.SAKURA.ne.jp>
Date: Thu, 21 Aug 2025 19:57:40 +0900
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
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
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
 <98938e56-b404-4748-94bd-75c88415fafe@I-love.SAKURA.ne.jp>
 <a3d1464ee40df7f072ea1c19e1ccf533e34554ca.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <a3d1464ee40df7f072ea1c19e1ccf533e34554ca.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp

On 2025/08/05 7:00, Viacheslav Dubeyko wrote:
>> Please show us your patch that solves your issue.
> 
> OK. It will be faster to write my own patch. It works for me.

I haven't heard from you about your own patch.

I guess that your patch will include

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index bf4cb7e78396..8d033ffeb8af 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -361,6 +361,10 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		break;
 	case HFS_CDR_DIR:
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
+		if (inode->i_ino < HFS_FIRSTUSER_CNID && inode->i_ino != HFS_ROOT_CNID) {
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);

change, which results in the following.

----------
The root inode's i_ino is 0 or 1 = fail with EINVAL
The root inode's i_ino is 2 = success
The root inode's i_ino is 3 or 4 = fail with ENOTDIR
The root inode's i_ino is 5 to 15 = fail with EINVAL
The root inode's i_ino is 16 and beyond = success
----------

But my patch has extra validation on the root inode's i_ino,
which results in the following.

----------
The root inode's i_ino is 2 = success
The root inode's i_ino is all (i.e. including 16 and beyond) but 2 = fail with EIO
----------

Therefore, while you can propose your patch,
I consider that there is no reason to defer my patch.


