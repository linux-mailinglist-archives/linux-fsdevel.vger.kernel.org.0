Return-Path: <linux-fsdevel+bounces-8010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD5782E29E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE14EB221AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 22:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C71B5BA;
	Mon, 15 Jan 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHNlsJs1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A11AAA1
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 22:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B3AC433C7;
	Mon, 15 Jan 2024 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705357909;
	bh=lFu9N+7owBnohO6lAaXpYI2oRbQwKjzA85Bkr1m1JCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VHNlsJs1UC44o6Gg47oKFydkQD88sULZBMNBG1FA3J+KhqYbPYkf5LNFRlHhPg+YK
	 Zaahorr1tZlOn+IQpOnwLjzjbr0tdrcbdS84s2w5V+NZm6orlYpohycXqFNgjwQ96k
	 E2GUF9Zs9nylrgPyl8Kup/mZtw6DnGYh0dOQ98QGwTYqqbTwUvYBXDeSiavPuwTBjn
	 w9HmFAaf/lqx5rvKJsqJ9fPUeSw3Cxwl7th8Wjt6+QuCJ9Ekf7i2jcy+xwSy+RPxQl
	 dSccbWW24bLGwZ5jjOJKinQh0sFyELujPg/i/fQr2n27wQ1kD/PxKOrZaCLWlMkyX4
	 tTw2dpIMRPGUA==
Message-ID: <0e4ecb6c-dec8-414e-b55a-53478657c461@kernel.org>
Date: Tue, 16 Jan 2024 07:31:46 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] : Current status of ZNS SSD support in file
 systems
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 naohiro.aota@wdc.com, Matias.Bjorling@wdc.com, javier.gonz@samsung.com,
 bvanassche@acm.org, slava@dubeiko.com
References: <20240115082236.151315-1-slava@dubeyko.com>
 <hqjm3bftitx2wpu74za4oq3sqifonpf7fc7mrwb4a7dbxzkm7h@stpm4dpahofc>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <hqjm3bftitx2wpu74za4oq3sqifonpf7fc7mrwb4a7dbxzkm7h@stpm4dpahofc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/16/24 02:35, Kent Overstreet wrote:
> On Mon, Jan 15, 2024 at 11:22:36AM +0300, Viacheslav Dubeyko wrote:
>> Hello,
>>
>> I would like to suggest the discussion related to current
>> status of ZNS SSD support in file systems. There is ongoing
>> process of ZNS SSD support in bcachefs, btrfs, ssdfs.
>> The primary intention is to have a meeting place among
>> file system developers and ZNS SSD manufactures for sharing
>> and discussing the status of ZNS SSD support, existing issues,
>> and potential new features.
>>
>> The goals of the discussion are:
>> (1) share the current status of ZNS SSD support,
>> (2) discuss any potential issues of ZNS SSD support in file systems,
>> (3) discuss file system's techniques required for ZNS SSD support,
>> (4) discuss potential re-using/sharing of implemented logic/primitives,
>> (5) share the priliminary estimation of having stable ZNS SSD support,
>> (6) performance, reliability estimation comparing ZNS and conventional SSDs.
>>
>> Also, it will be great to hear any news from ZNS SSD vendors
>> related to new features of ZNS SSDs (zone size, open/active zone
>> limitation, and so on). Do we have any progress with increasing
>> number of open/active zones? Any hope to have various zone sizes, etc?
>>
>> POTENTIAL ATTENDEES:
>> bcachefs - Kent Overstreet
>> btrfs - Naohiro Aota
>> ssdfs - Viacheslav Dubeyko
>> WDC - Matias Bjørling
>> Samsung - Javier González
>>
>> Anybody else would like to join the discussion?
>>
>> Thanks,
>> Slava
> 
> There's also SMR hard drives to consider. For SMR, the much bigger zones
> means that we don't want to burn entire zones on the superblock (plural;
> we need two so that one will be alive while the other is being erased).

Hmmm... The zone size of SMR drives is actually much smaller than that of ZNS
drives: 256 MB vs over 1GB for ZNS. All host-managed SMR drives that I know of
use 256 MB zone size. One exception is 128 MB zone size that some user prefer
over the regular 256 MB. Depending on the drive, this can be changed with the
FORMAT WITH PRESET command, if the drive support that command of course.

btrfs superblock (and its copies) are handled as you describe: 2 zones per copy
used as a circular write ring. The write pointer location of the zones indicate
where the latest superblock is. Sure that wastes a little space. But that is not
much considering the total number of zones of a drive. The latest 28 TB SMR
drives have over 100,000 zones.

> We've got provisions for variable sized zones, are SMR hard drives doing
> anything with this? Or perhaps for a normal, random-overwritable zone at
> the start?

No, variable zone size is not a thing with SMR. bcachefs may support it, but in
general, that makes zone management much harder and the kernel does not allow
this (blk_revalidate_disk_zones() will return an error if it sees such drive).

Host managed SMR drives generally have a small number of conventional zones
(randomly writeable) at LBA 0. Generally about 1% of the total capacity/number
of zones, so about 1000 conventional zones. This is optional though but most
drives I know have that, except the special 128MB zone size one mentioned above
which is all SMR zones.

-- 
Damien Le Moal
Western Digital Research


