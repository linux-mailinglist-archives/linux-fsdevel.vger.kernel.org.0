Return-Path: <linux-fsdevel+bounces-870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D97D1D15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 14:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8A2B2150B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 12:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F151118A;
	Sat, 21 Oct 2023 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2629HcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146991079B
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 12:13:55 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC606E9;
	Sat, 21 Oct 2023 05:13:53 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-581b6b93bd1so1027807eaf.1;
        Sat, 21 Oct 2023 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697890433; x=1698495233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhVz9azCV/vrdF8MlrpbOzEjmntEbZAUTW3gxmj6+yw=;
        b=j2629HcGDHLmuICJmyQ70JPgNrtdrf0lWfuFAnKCazWHwXZRyEncpfq8BCFQxlgutN
         Wee9tfDuZVkXc8osMeKe5oK74y0K06H0zh1H6M0fisw0JMYqgOMR97WfH7I7eT++++DX
         KScRhtjTd6N0nvPrPdakW21dmFFesB5D7mp0hrsUi/Ogr/HsX0aZ8e4Ex8aUwd6xBlaS
         CpEjGi0QNd8vJ4luqIldX3AKSpFZ279o1mB6uOseZF/Jipc/6KnWxke3kuYR+flOVDut
         0C3K+G/fPkWI79speulIpoGJIfhwnddyRVwujnRbfQp5DHF/7yEDtirwRFPrunwkg0+F
         P2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697890433; x=1698495233;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhVz9azCV/vrdF8MlrpbOzEjmntEbZAUTW3gxmj6+yw=;
        b=vxjXiZ3jayWAp2yEIGwSlIYz1BQ6R2Azw1c1to6a1EodECG6mOl8HAV6IPQeBbzXFs
         MQkU0EpgMdBz2b1dUQQo5c8YUDcx9J1r6wxCpBiyQ+5GoH+fltZ6T08HVFBg+2It3qR7
         1y/wmJIUxEbUeCzbgcPZZAvnYuIcgtiZ9Bmsch67D1stZBytq4mqcIoSl7S1Sot8MmTG
         3MbGeQZCHbz0J85IfMgB6DnMY1AABsNlqooQMwC2lcs+CyuOmX20NTnzH4zEOsKlSeil
         Z8XrqyGKd9asoOLvX0DkXDRcU5TE6S6zQXNrmmggxB3g5p/C1mw6MDX9B/xGyJyzmDQK
         sAXA==
X-Gm-Message-State: AOJu0Yw/H1XJ/YUwdQfNztUvoz6qKVZxJQ7SHe23ZPVZZ6os7XF2QK3T
	wEYxLnbAOXcpCM1JOS1s6/pikXPOsvhZ9g5u6iNIdMgAejI=
X-Google-Smtp-Source: AGHT+IEJnNMnlUT23fA3NLfWmP1W1ZyETwDn8yAKHoeKAW2VBhbgT/vTD+IHqZMkntMLZxjVwAhiC3EFgqCG/YVxL2g=
X-Received: by 2002:a4a:e782:0:b0:56e:466c:7393 with SMTP id
 x2-20020a4ae782000000b0056e466c7393mr4463846oov.5.1697890432955; Sat, 21 Oct
 2023 05:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:7b90:0:b0:4f0:1250:dd51 with HTTP; Sat, 21 Oct 2023
 05:13:52 -0700 (PDT)
In-Reply-To: <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev> <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f> <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area> <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 21 Oct 2023 14:13:52 +0200
Message-ID: <CAGudoHFcz1wQgQ53sy-HPJvJhx_DHhXcVVg3FfrFKHHdxt=scg@mail.gmail.com>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, Dave Chinner <dchinner@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

It was bugging me that find_inode_fast is at the top of the profile
(modulo the locking routine).

Internals don't look too bad (it skips collisions without taking
locks), so I started wondering if hashing is any good.

I re-ran the scan of 20 mln and started counting visited inodes for
each call, got this:

[0, 1)             58266 |                                                    |
[1, 2)            385228 |@@@                                                 |
[2, 3)           1252480 |@@@@@@@@@@                                          |
[3, 4)           2710082 |@@@@@@@@@@@@@@@@@@@@@@@                             |
[4, 5)           4385945 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
[5, 6)           5662628 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    |
[6, 7)           6074390 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[7, 8)           5575381 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     |
[8, 9)           4475706 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@              |
[9, 10)          3183676 |@@@@@@@@@@@@@@@@@@@@@@@@@@@                         |
[10, 11)         2041743 |@@@@@@@@@@@@@@@@@                                   |
[11, 12)         1189850 |@@@@@@@@@@                                          |
[12, 13)          637683 |@@@@@                                               |
[13, 14)          313830 |@@                                                  |
[14, 15)          143277 |@                                                   |
[15, 16)           61501 |                                                    |
[16, 17)           25116 |                                                    |
[17, 18)            9693 |                                                    |
[18, 19)            3435 |                                                    |
[19, 20)            1120 |                                                    |
[20, 21)             385 |                                                    |
[21, 22)              99 |                                                    |
[22, 23)              45 |                                                    |
[23, 24)              15 |                                                    |
[24, 25)               2 |                                                    |
[25, 26)               2 |                                                    |
[26, 27)               2 |                                                    |

I compared this to literally just taking the ino & i_hash_mask as the
value, got this:
[0, 1)            119800 |                                                    |
[1, 2)            508063 |@@@                                                 |
[2, 3)           1576390 |@@@@@@@@@@@                                         |
[3, 4)           2763163 |@@@@@@@@@@@@@@@@@@@                                 |
[4, 5)           3696348 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |
[5, 6)           5975274 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          |
[6, 7)           7253615 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[7, 8)           6563736 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     |
[8, 9)           5012728 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                 |
[9, 10)          3495208 |@@@@@@@@@@@@@@@@@@@@@@@@@                           |
[10, 11)         1606659 |@@@@@@@@@@@                                         |
[11, 12)          459458 |@@@                                                 |
[12, 13)            3940 |                                                    |
[13, 14)              21 |                                                    |
[14, 15)               6 |                                                    |
[15, 16)               2 |                                                    |

That is to say distribution is much better, in particular the longest
streak is 15 (as opposed to 26).

While I'm not saying just taking ino is any good, I am saying there is
room for improvement here as far as one mount point is concerned.

Side note is that sb could have a randomly generated seed instead of
its address, which should help distributing this better.

So tl;dr hash distribution leaves some room for improvement and
*maybe* I'll prod it some time next month. One can also grow the table
of course, but that's for later.

-- 
Mateusz Guzik <mjguzik gmail.com>

