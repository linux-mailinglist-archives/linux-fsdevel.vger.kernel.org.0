Return-Path: <linux-fsdevel+bounces-3868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21E7F96B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 01:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B169EB20AEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 00:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5345D17739;
	Sun, 26 Nov 2023 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux4Mogbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143A16404;
	Sun, 26 Nov 2023 23:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08323C433C7;
	Sun, 26 Nov 2023 23:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701043198;
	bh=SXTPU9LjxJP3teW5tBbkyM+aFCjC4uBgeyHr0bF9mMM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=ux4MogbmJROnK9hjNBKf2Po+6F/zquCmiYItclY0IUhGrxZcLMyV+OX/xfFYv51Xo
	 oJh6EFGE101uw76s3D0bLK2sYTiSm88Z+4WC6pZtFyMFcpUnPWZyrQaCtWeUn6EMaF
	 aGD5GGGKQgum8GefbueyyEaaRa8IR/KW9cqVW15cV/ll1sXiiJYCT96geC5z+pN6S5
	 2hQeaEsx9g40EBcy7/If4HURZksXFz7AtZXEKa/xFspqOnJtn5+dEiANp3bsq4HzAH
	 O8mLtgzep+HAlLJ4utgujEby9c7dKBgPeFL1i/FTD6mn6rj9tnMIzmCGWTTzL++89j
	 0VM+EekX8sobA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f9efd5303cso1763964fac.0;
        Sun, 26 Nov 2023 15:59:57 -0800 (PST)
X-Gm-Message-State: AOJu0YxiJZeMHouElST1YNEmvLG0tIyw6NyE8maMxRY3CYZBEk7jSCDC
	TgUQJ3MTnNTC4tUtsctBHp9AyWtcFqTGQA5IsD0=
X-Google-Smtp-Source: AGHT+IF7x9TYD1f/9BdHxpBv6zsxnS+LHF75GZhR7bdxVFyfS12brsZkXdHPSbDIN+kRgg/RdTyLiGUZ3kbCr6SDpk4=
X-Received: by 2002:a05:6871:79a:b0:1fa:36cb:bb5e with SMTP id
 o26-20020a056871079a00b001fa36cbbb5emr5034749oap.57.1701043197268; Sun, 26
 Nov 2023 15:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:407:0:b0:507:5de0:116e with HTTP; Sun, 26 Nov 2023
 15:59:56 -0800 (PST)
In-Reply-To: <ZVxUXZrlIaRJKghT@archie.me>
References: <CAJ8C1XPdyVKuq=cL4CqOi2+ag-=tEbaC=0a3Zro9ZZU5Xw1cjw@mail.gmail.com>
 <ZVxUXZrlIaRJKghT@archie.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 27 Nov 2023 08:59:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_WFKXt1GqzFyfrJo6KHf6iaDwp-n3Qb1Hu63wokNhO9g@mail.gmail.com>
Message-ID: <CAKYAXd_WFKXt1GqzFyfrJo6KHf6iaDwp-n3Qb1Hu63wokNhO9g@mail.gmail.com>
Subject: Re: Add sub-topic on 'exFAT' in man mount
To: Seamus de Mora <seamusdemora@gmail.com>
Cc: Linux Manual Pages <linux-man@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Alejandro Colomar <alx@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"

2023-11-21 15:55 GMT+09:00, Bagas Sanjaya <bagasdotme@gmail.com>:
> On Mon, Nov 20, 2023 at 04:55:18PM -0600, Seamus de Mora wrote:
>> I'd like to volunteer to add some information to the mount manual.
>>
>> I'm told that exFAT was added to the kernel about 4 years ago, but
>> last I checked, there was nothing about it in man mount.  I feel this
>> could be addressed best by adding a sub-topic on exFAT under the topic
>> `FILESYSTEM-SPECIFIC MOUNT OPTIONS`.
>>
>> If my application is of interest, please let me know what steps I need
>> to take - or how to approach this task.
>>
>
> I'm adding from Alejandro's reply.
>
> You can start reading the source in fs/exfat in linux.git tree [1].
> Then you can write the documentation for exfat in Documentation/exfat.rst
> (currently doesn't exist yet), at the same time of your manpage
> contribution.
>
> Cc'ing exfat maintainers for better treatment.
Thanks Bagas for forwarding this to us!

Hi Seamus,

Some of mount options are same with fatfs's ones. You can refer the
descriptions of fatfs
documentation(Documentation/filesystems/vfat.rst).
If you have any questions about other options or documentation for
exfat, please give an email me.

Thanks!
>
> Thanks.
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/exfat
>
> --
> An old man doll... just what I always wanted! - Clara
>

