Return-Path: <linux-fsdevel+bounces-891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E4B7D26E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 00:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80072B20D32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Oct 2023 22:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461C56130;
	Sun, 22 Oct 2023 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hrcb1QlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B711C3C
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 22:53:22 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9EEC2
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 15:53:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6be0277c05bso1971490b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698015201; x=1698620001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oRYglAKPkAepx6qheWxbJfkWRfk28WNVjjfLpReBOUk=;
        b=hrcb1QlTURXDpNZ+jY1eA481caltABBqY9kb3Eod7uU7r1wdLpUQuwLGJbh5RbXF8L
         vAc9n8Gg/Zcl2gRIuyEMLGIboEeLlVT+wSD069vZvMJYNhRVNn5bXinsrbalRiTHoJsy
         pw48keadrlj4dBAw3lvrLcK68ZsJiSk8S8LVRJxCZTGrZgIYKDUiXQAfTIKZoTv7yAVo
         icM5ln9aQlTSrivggJ9oQITRIDFlx4ReTc0Ke1+NH433RMrDttE4pv7mk+uEHW3Vf8F0
         ReZj2ZH8GO9j959baiwM443gCPXhlSaNO0UoeXlqR8lbh0tJxpz2EeqelTZU+2JZwxxs
         m4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698015201; x=1698620001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRYglAKPkAepx6qheWxbJfkWRfk28WNVjjfLpReBOUk=;
        b=UkFM4yTwiJDOd1dncY3MQBrvlv82pBPSwjWZIhXw+6Xj/YdBX6BwTMmeqXCIqwTwbR
         M6LSRhOgY+rszrAvhDO8/KwxB8mVUZmdROBpMbbXZGYBI5FXYL1PUc8LgPGy1+lebhs+
         KhDGU7R0H8/ret+p0MmNZXotCXX9kSxUSUv0M81gq/pBvbFHa9HFKPVFkcr3kAf01ZYz
         o2jv2qE98SDBTQOw1gm9+Y4Io7LYffAug7nBp/fePce7hVHBnpY0Hgsc3PC/s5dCPw1B
         IDrrARouCKa5ZnGSOYlDuaoq+z1F0R/9dDj12kBzWnrmYPyrCQFXURjM/lmorVCEw41b
         vRKQ==
X-Gm-Message-State: AOJu0YztptwBSKbgSt6nCfqGLoeYujFkzxIZONbGoimLAw8PKRvATu55
	aHtNMxPXKYAaOs7sV9jObBCXAw==
X-Google-Smtp-Source: AGHT+IHwrBNhRCFQtpnzt/uIlF/fMD3afTTUcvPkMAGKpgkIKsDEfkiim78m3y1jcY1kFXpDO4/Jzw==
X-Received: by 2002:a05:6a00:15c4:b0:6be:2991:d878 with SMTP id o4-20020a056a0015c400b006be2991d878mr6482900pfu.15.1698015200772;
        Sun, 22 Oct 2023 15:53:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id e12-20020aa7980c000000b006889348ba6esm4914612pfl.127.2023.10.22.15.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 15:53:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1quhJt-002ctP-2Z;
	Mon, 23 Oct 2023 09:53:17 +1100
Date: Mon, 23 Oct 2023 09:53:17 +1100
From: Dave Chinner <david@fromorbit.com>
To: David Wang <00107082@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PERFORMANCE]fs: sendfile suffer performance degradation when
 buffer size have performance impact on underling IO
Message-ID: <ZTWn3QtTggmMHWxS@dread.disaster.area>
References: <28de01eb.208.18b4f9a0051.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28de01eb.208.18b4f9a0051.Coremail.00107082@163.com>

On Sat, Oct 21, 2023 at 08:19:34AM +0800, David Wang wrote:
> Hi, 
> 
> I was trying to confirm the performance improvement via replacing read/write sequences with sendfile, 
> But I got quite a surprising result:
> 
> $ gcc -DUSE_SENDFILE cp.cpp
> $ time ./a.out 
> 
> real	0m56.121s
> user	0m0.000s
> sys	0m4.844s
> 
> $ gcc  cp.cpp
> $ time ./a.out 
> 
> real	0m27.363s
> user	0m0.014s
> sys	0m4.443s
> 
> The result show that, in my test scenario,  the read/write sequences only use half of the time by sendfile.
> My guess is that sendfile using a default pipe with buffer size 1<<16 (16 pages), which is not tuned for the underling IO, 
> hence a read/write sequences with buffer size 1<<17 is much faster than sendfile.

Nope, it's just that you are forcing sendfile to do synchronous IO
on each internal loop. i.e:

> But the problem with sendfile is that there is no parameter to tune the buffer size from userspace...Any chance to fix this?
> 
> The test code is as following:
> 
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <sys/sendfile.h>
> #include <fcntl.h>
> 
> char buf[1<<17];   // much better than 1<<16
> int main() {
> 	int i, fin, fout, n, m;
> 	for (i=0; i<128; i++) {
> 		// dd if=/dev/urandom of=./bigfile bs=131072 count=256
> 		fin  = open("./bigfile", O_RDONLY);
> 		fout = open("./target", O_WRONLY | O_CREAT | O_DSYNC, S_IWUSR);

O_DSYNC is the problem here.

This forces an IO to disk for every write IO submission from
sendfile to the filesystem. For synchronous IO (as in "waiting for
completion before sending the next IO), a larger IO size will
*always* move data faster to storage.

FWIW, you'll get the same behaviour if you use O_DIRECT for either
source or destination file with sendfile - synchronous 64kB IOs are
a massive performance limitation even without O_DSYNC.

IOWs, don't use sendfile like this. Use buffered IO and
sendfile(fd); fdatasync(fd); if you need data integrity guarantees
and you won't see any perf problems resulting from the size of the
internal sendfile buffer....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

