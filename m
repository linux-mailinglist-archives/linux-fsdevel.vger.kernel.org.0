Return-Path: <linux-fsdevel+bounces-7793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A582AFA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 14:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653B11F24134
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 13:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A375171DB;
	Thu, 11 Jan 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mEvfMIL8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9C171BB;
	Thu, 11 Jan 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T9lp50cJjzMqlwl;
	Thu, 11 Jan 2024 13:27:25 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4T9lp40hDzzMpnPr;
	Thu, 11 Jan 2024 14:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704979644;
	bh=NcqqHqbHcG+SCp8ggpuwIKesgMZhBMGU2oOkDWhEbbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEvfMIL8w/91vuf2+ilbVcjIHYmM1diMZINM0JzdDDczWXcvNNoaBmlCHuEJQnw3L
	 BF4gtyQax3ytNPKu7AV8CoDCavZzV54n9xTZq2APhQB677qFd/Jar7UulQVKRDVU0Y
	 Ili5KwP5JpLXiJb25B6Fasjvym0M9aOWUuRxGLpk=
Date: Thu, 11 Jan 2024 14:27:22 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 514118380@qq.com, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v4] selftests/move_mount_set_group:Make tests build with
 old libc
Message-ID: <20240111.mee0ohZie5he@digikod.net>
References: <20240111113229.10820-1-hu.yadi@h3c.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111113229.10820-1-hu.yadi@h3c.com>
X-Infomaniak-Routing: alpha

On Thu, Jan 11, 2024 at 07:32:29PM +0800, Hu Yadi wrote:
> From: "Hu.Yadi" <hu.yadi@h3c.com>
> 
> Replace SYS_<syscall> with __NR_<syscall>.  Using the __NR_<syscall>
> notation, provided by UAPI, is useful to build tests on systems without
> the SYS_<syscall> definitions.
> 
> Replace SYS_move_mount with __NR_move_mount
> 
> Similar changes: commit 87129ef13603 ("selftests/landlock: Make tests build with old libc")
> 
> Acked-by: Mickaël Salaün <mic@digikod.net>

Sorry, it should have been Reviewed-by: Mickaël Salaün <mic@digikod.net>

Also, this is maintained by the VFS maintainers. I CCed three relevant addresses.

> Signed-off-by: Hu.Yadi <hu.yadi@h3c.com>
> Suggested-by: Jiao <jiaoxupo@h3c.com>
> Reviewed-by: Berlin <berlin@h3c.com>
> ---
> Changes v4 -> v3:
>  - Adjust comments for consistent
>  - Add Acked-by
> Changes v2 -> v3:
>  - Adjust comments
> Changes v1 -> v2:
>  - Fix mail of Suggested-by and Reviewed-by
> 
>  .../move_mount_set_group/move_mount_set_group_test.c          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> index 50ed5d475dd1..bcf51d785a37 100644
> --- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> @@ -218,7 +218,7 @@ static bool move_mount_set_group_supported(void)
>  	if (mount(NULL, SET_GROUP_FROM, NULL, MS_SHARED, 0))
>  		return -1;
>  
> -	ret = syscall(SYS_move_mount, AT_FDCWD, SET_GROUP_FROM,
> +	ret = syscall(__NR_move_mount, AT_FDCWD, SET_GROUP_FROM,
>  		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
>  	umount2("/tmp", MNT_DETACH);
>  
> @@ -363,7 +363,7 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
>  		       CLONE_VM | CLONE_FILES); ASSERT_GT(pid, 0);
>  	ASSERT_EQ(wait_for_pid(pid), 0);
>  
> -	ASSERT_EQ(syscall(SYS_move_mount, ca_from.mntfd, "",
> +	ASSERT_EQ(syscall(__NR_move_mount, ca_from.mntfd, "",
>  			  ca_to.mntfd, "", MOVE_MOUNT_SET_GROUP
>  			  | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH),
>  		  0);
> -- 
> 2.23.0
> 
> 

