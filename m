Return-Path: <linux-fsdevel+bounces-33058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D49B2FDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 13:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E4328173F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854761D86ED;
	Mon, 28 Oct 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s56hn1P0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF34189B8D;
	Mon, 28 Oct 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117491; cv=none; b=lk9gkAK/zGvK4cgkG7m+PKNlnFKzqI5Aaw/7/4zlditpZ9MFaJG41/gh/nBB8tVqjWtH47ozCkuwEZet5jwlZZE6r7QjN8HEpiUiE52Ube+D3B8B6G5P8yBxt7vyF65klMqkukRGDbNrC0LlNzWq4PHL7Vxz3BMnwUIAZSPltFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117491; c=relaxed/simple;
	bh=rv69JvQBuERLoDd8e9ag5C41cMWOhw/9p+RshC/x6lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdrBpU7n/hncD2NYHMckYoEzdUptLI60E+WubywBihQQQe7MSKHLRRw4yKGbSQBvOE/YhTKY3VV3FwzCJLBq1jT1scwtqu3EZxvG/AHpH/zo0gg6bXjTv5D7bDV/ROjNl6M5mN/y7Xib+ZpwU+bYl1uYitPjeqgyt9iI44YDYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s56hn1P0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AC3C4CEC3;
	Mon, 28 Oct 2024 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730117491;
	bh=rv69JvQBuERLoDd8e9ag5C41cMWOhw/9p+RshC/x6lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s56hn1P0WYwxElh6FCKpnpSdxRyQaBzWC13T9yiz1VUQ9l8aYngJEp0QLxEHyfm/z
	 +/0xA+LUyD1twvPJhCdvgueubcP1CvRLaQgy219IW38iLmi/ee8Yrd2ZiaZiUN1kft
	 EGURvmnwxjx46cEj5TTKr5k+9hAIXTNmVKytyuueq7dxig19EdZ3QvjUXUd39zlDG3
	 WMndXSkoDBneDiUqJ4/fKtKbTjQt4WAqgmeKrfPeh35qN+DXI8I1K/soTjZA/vmw6E
	 yzd8F8vlybffYcVVwA34pPv0losWcviNasCETKIYwHn6tnOd93x7KwAvLkTp3b4r79
	 RpA/ytWrLNJTw==
Date: Mon, 28 Oct 2024 13:11:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: zhouyuhang <zhouyuhang1010@163.com>
Cc: sforshee@kernel.org, shuah@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, zhouyuhang <zhouyuhang@kylinos.cn>
Subject: Re: [PATCH v2] selftests/mount_setattr: fix idmap_mount_tree_invalid
 failed to run
Message-ID: <20241028-rodung-kotzen-577438c3b82c@brauner>
References: <20241028084132.3212598-1-zhouyuhang1010@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028084132.3212598-1-zhouyuhang1010@163.com>

On Mon, Oct 28, 2024 at 04:41:32PM +0800, zhouyuhang wrote:
> From: zhouyuhang <zhouyuhang@kylinos.cn>
> 
> Test case idmap_mount_tree_invalid failed to run on the newer kernel
> with the following output:
> 
>  #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
>  # mount_setattr_test.c:1428:idmap_mount_tree_invalid:Expected sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,  sizeof(attr)) (0) ! = 0 (0)
>  # idmap_mount_tree_invalid: Test terminated by assertion
> 
> This is because tmpfs is mounted at "/mnt/A", and tmpfs already
> contains the flag FS_ALLOW_IDMAP after the commit 7a80e5b8c6fa ("shmem:
> support idmapped mounts for tmpfs"). So calling sys_mount_setattr here
> returns 0 instead of -EINVAL as expected.
> 
> Ramfs does not support idmap mounts, so we can use it here to test invalid mounts,
> which allows the test case to pass with the following output:
> 
>  # Starting 1 tests from 1 test cases.
>  #  RUN           mount_setattr_idmapped.idmap_mount_tree_invalid ...
>  #            OK  mount_setattr_idmapped.idmap_mount_tree_invalid
>  ok 1 mount_setattr_idmapped.idmap_mount_tree_invalid
>  # PASSED: 1 / 1 tests passed.
> 
> Signed-off-by: zhouyuhang <zhouyuhang@kylinos.cn>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

