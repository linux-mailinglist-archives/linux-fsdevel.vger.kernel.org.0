Return-Path: <linux-fsdevel+bounces-7754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4717682A3DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 23:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B171F28B82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 22:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98F4F8A2;
	Wed, 10 Jan 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNtPaD4k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB344F882;
	Wed, 10 Jan 2024 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d4ca2fd2fbso24861035ad.2;
        Wed, 10 Jan 2024 14:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704925409; x=1705530209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxsxElpc+jT4mmfFhZPh3DZtom6DY7JYexQS1ckDeao=;
        b=HNtPaD4kJRUspPNKpAUr2dxoiG8LyYKKlLz247S4HTflSjv54I01jFxnLeaxPplTKq
         JL5L2ui0g8zSJfFie9jlZ8/n/LODPmODsrKOkWvBPWOTBlJlvcRBKIoYnSSJIDS5XbKz
         e0MufS6DsxAexT8E7O6UgDpuHBoiarsdaTQjZp9YTyEQKIrpMTCZWPYIv3Ns4oKJ606I
         XQ7eP7eLQAJCHSjByllqx8D0qj1bUXy61yxVO/Zhiaxxaud42LX0RW/iECrAioeLad1F
         quq2NYU30qnuhN5yCjl3avY/1G0fY5iPsnemHGKzeRB+O+YrYu4+UakLYFS38GVxS5ri
         FtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925409; x=1705530209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxsxElpc+jT4mmfFhZPh3DZtom6DY7JYexQS1ckDeao=;
        b=TkKzWy2hqWN7eP/jxQGEk5nnugI9YSV+Kd00lBRS6rjSNDyevCALOHNanZvgyGjcxt
         a8PV9XWKzlQUqtKOI0KkokdghfHxuciCbSemIMz4wC4GCH/2f66eo6PuwY7ThNcBjUO2
         /GDmNVMINCT754PRR1ASd4h4SeXIHTZF29SX0F1C685oqh+Ud9kIKMjcy28Mto7OPWYf
         DAan5cbS9dRlN9KxTBTVvClPgdQOS2YbycFYwSQ5l5lvbOg/z9EmEAomVLkRPWPNcCtp
         PVHw+9gRvkNbyJLOuqfWjtaoowJeAy9lfdf9btU1nBaEnauKpUOvb9ybFMxCjuiNZu5w
         6C6Q==
X-Gm-Message-State: AOJu0YwaLBJU6uW1TOsuH0ppW4GAYtz6cgcOK5Zp0rJy55diBcV9Ls0U
	IfpZp2dRLaGPv1tlOwFLdt4=
X-Google-Smtp-Source: AGHT+IGeLGDDAGN9Ml97cgT8MOww4VOvyzegLjaWhxhlroPbTTKHlKjmxi9wcV5Ku03hRVlwCCLv3w==
X-Received: by 2002:a17:90b:4d91:b0:28b:d90c:c724 with SMTP id oj17-20020a17090b4d9100b0028bd90cc724mr180672pjb.54.1704925408886;
        Wed, 10 Jan 2024 14:23:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gk9-20020a17090b118900b0028d19ddb1afsm2095854pjb.33.2024.01.10.14.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:23:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Jan 2024 14:23:26 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
Message-ID: <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025140205.3586473-6-mszeredi@redhat.com>

Hi,

On Wed, Oct 25, 2023 at 04:02:03PM +0200, Miklos Szeredi wrote:
> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
> 
> Allow listing either
> 
>  - immediate child mounts only, or
> 
>  - recursively all descendant mounts (depth first).
> 
> Lookup the mount by the new 64bit mount ID.  If a mount needs to be queried
> based on path, then statx(2) can be used to first query the mount ID
> belonging to the path.
> 
> Return an array of new (64bit) mount ID's.  Without privileges only mounts
> are listed which are reachable from the task's root.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

with this patch in the tree, all sh4 builds fail with ICE.

during RTL pass: final
In file included from fs/namespace.c:11:
fs/namespace.c: In function '__se_sys_listmount':
include/linux/syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275

I tested with gcc 8.2, 11.3, 11.4, and 12.3. The compiler version
does not make a difference. Has anyone else seen the same problem ?
If so, any idea what to do about it ?

Thanks,
Guenter

