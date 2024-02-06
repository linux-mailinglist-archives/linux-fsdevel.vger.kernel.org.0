Return-Path: <linux-fsdevel+bounces-10417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B04E84AD67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 05:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FD31F25B34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 04:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990874E3D;
	Tue,  6 Feb 2024 04:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QsZRrd1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F42774E0E;
	Tue,  6 Feb 2024 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193216; cv=none; b=cKrZdiYQul5iUH68Zge+DGrfOyue1L+n5tMX71iszAJoP6cLTqEojR5gqtnLj1x2nIMrQ7C29QXSIKhZzRgGRCoQzcNWbVw63xC2nZJnp8xk/EnBJMkD8AdRJ5huXli/xf0mMv30LWH2QlHSphJUhEjYADgr3FFQiiu63HgIF8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193216; c=relaxed/simple;
	bh=v2eV89CFfg0ysp6EkHVTL96Fg1zaUIzw2XEMoAZm9IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klojETWzc0W4Njot3rERkkGQVgSyn6GUlut6P+PpiEd1HA6gWOqTuO/C4iLs6+y6L+9V4ayJngM7RwVVcmfQ2t+vJt4iclJcQFtrHSKDlc+TmJAaroUrgLWY0NmaZ4+lvKyw2sfyG9osixoBu+94Hk6pXuqUUcbn/a1Z+6Wfh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QsZRrd1H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8KnBD4rHlGntZQoBsKk3YytjdSLLdJZ0CNvsOChcWKY=; b=QsZRrd1HhHlHz06X66uZZdqjLo
	1+rrPAIvCkAAJicO7CBx5oJZBvt1/VlxVYJFQ9ewI/sAlcGLZsJ83g+tZpP41dzF9OaMLI6KpM9im
	atfaWBSSAn/MWNpj9QqA3/ZZp+RG4J+vSne+7YWKd7DsX8+/dcj68yXltM/tPC6gawnHsPy80ll74
	MGelLAYtiPlBRJF6xcsvRXTxAUAyvWawp0I9p7M/LcJChVxjh3/fdId8UiF5X+Dana6FI7YEYLopk
	jt3O7jAimwRImUScVUyDcQsXpfs/zZ7ALi4qFfPGWkf+i0orGluaGXP98zTFWugC+asTTjgjNJRwL
	/IlzbF8g==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXCwN-0000000603T-0d86;
	Tue, 06 Feb 2024 04:20:11 +0000
Message-ID: <ca885dd8-4ac1-43a9-9b0c-79b63cae0620@infradead.org>
Date: Mon, 5 Feb 2024 20:20:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] fs: FS_IOC_GETSYSFSNAME
Content-Language: en-US
To: dsterba@suse.cz, Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Dave Chinner <dchinner@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Josef Bacik <josef@toxicpanda.com>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
 <20240205200529.546646-5-kent.overstreet@linux.dev>
 <20240205222732.GO616564@frogsfrogsfrogs>
 <7si54ajkdqbauf2w64xnzfdglkokifgsjptmkxwdhgymxpk353@zf6nfn53manb>
 <20240206013931.GK355@twin.jikos.cz>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240206013931.GK355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/5/24 17:39, David Sterba wrote:
> On Mon, Feb 05, 2024 at 05:43:37PM -0500, Kent Overstreet wrote:
>> On Mon, Feb 05, 2024 at 02:27:32PM -0800, Darrick J. Wong wrote:
>>> On Mon, Feb 05, 2024 at 03:05:15PM -0500, Kent Overstreet wrote:
>>>> @@ -231,6 +235,7 @@ struct fsxattr {
>>>>  #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
>>>>  #define FS_IOC_GETFSUUID		_IOR(0x94, 51, struct fsuuid2)
>>>>  #define FS_IOC_SETFSUUID		_IOW(0x94, 52, struct fsuuid2)
>>>> +#define FS_IOC_GETFSSYSFSNAME		_IOR(0x94, 53, struct fssysfsname)
>>>
>>> 0x94 is btrfs, don't add things to their "name" space.
>>
>> Can we please document this somewhere!?
>>
>> What, dare I ask, is the "namespace" I should be using?
> 
> Grep for _IOCTL_MAGIC in include/uapi:
> 
> uapi/linux/aspeed-lpc-ctrl.h:#define __ASPEED_LPC_CTRL_IOCTL_MAGIC 0xb2
> uapi/linux/aspeed-p2a-ctrl.h:#define __ASPEED_P2A_CTRL_IOCTL_MAGIC 0xb3
> uapi/linux/bt-bmc.h:#define __BT_BMC_IOCTL_MAGIC        0xb1
> uapi/linux/btrfs.h:#define BTRFS_IOCTL_MAGIC 0x94
> uapi/linux/f2fs.h:#define F2FS_IOCTL_MAGIC              0xf5
> uapi/linux/ipmi_bmc.h:#define __IPMI_BMC_IOCTL_MAGIC        0xB1
> uapi/linux/pfrut.h:#define PFRUT_IOCTL_MAGIC 0xEE
> uapi/rdma/rdma_user_ioctl.h:#define IB_IOCTL_MAGIC RDMA_IOCTL_MAGIC
> uapi/rdma/rdma_user_ioctl_cmds.h:#define RDMA_IOCTL_MAGIC       0x1b
> 
> The label ioctls inherited the 0x94 namespace for backward
> compatibility but as already said, it's the private namespace of btrfs.
> 

or more generally, see Documentation/userspace-api/ioctl/ioctl-number.rst.

For 0x94, it says:

0x94  all    fs/btrfs/ioctl.h                                        Btrfs filesystem
             and linux/fs.h                                          some lifted to vfs/generic

-- 
#Randy

