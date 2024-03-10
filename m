Return-Path: <linux-fsdevel+bounces-14069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C252087749C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 01:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4FA281549
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 00:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5AC1FBF;
	Sun, 10 Mar 2024 00:54:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76491FA0
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710032048; cv=none; b=WKd6hwYhM8A0YWJ4jw5WnLgipPFldzHUcP7/59g2ds86LZwGqWghO0eccjs9XwyfYAGjIeao0c3ldmcS9FnlaGt6gZ7bYl4Zk/gdd5B2GF/QJO2fuUoF4updOUK8xM1D3vivgUx7JTjnk35tR4qnOAV6h85ymdQYt/n/QcvxQcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710032048; c=relaxed/simple;
	bh=G/6KdXu31T1VAui/RJwqf6i/24VbdcZQazuZ9wjU2fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k1AVgznKpvtY5QCsEOK5/+oMhgeZeBojR3apCTyb1CSsPFdaL52/1dkk5CUCW6hA+Hhdc3b2C02cJNn1LBAsnQpQKkTFY3HkQ8UKOJIzC7wcGtxkbMkxLX7E4TpF4CidhWI0l14esZdMJYWAi+Df/cQjI25rROC0qCY0t+viaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42A0s5Sp087296;
	Sun, 10 Mar 2024 09:54:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sun, 10 Mar 2024 09:54:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42A0s4lc087293
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 10 Mar 2024 09:54:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f2a9b546-433e-4661-aca9-8c58fdfc5be7@I-love.SAKURA.ne.jp>
Date: Sun, 10 Mar 2024 09:54:03 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_dirty_inode
Content-Language: en-US
To: syzbot <syzbot+c319bb5b1014113a92cf@syzkaller.appspotmail.com>,
        axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz,
        jeffm@suse.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        paul@paul-moore.com, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
References: <000000000000b6989a0613375b88@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000b6989a0613375b88@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: fs: Block writes to mounted block devices


