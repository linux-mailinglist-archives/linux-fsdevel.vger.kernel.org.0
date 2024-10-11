Return-Path: <linux-fsdevel+bounces-31671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8F4999F74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8ED287E6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727AA20C489;
	Fri, 11 Oct 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTArbzVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650119413B;
	Fri, 11 Oct 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637016; cv=none; b=PWXwwuVveH9+r1LGgUT8Ru4oettGPZ2kZy9uMRrCqCOlUjMLd5XUcVXnzYPP/Di5urqCUL3IIoecOK7TB3IIYkax9nH9EzNKwpZFj8wqWykKkylJmCK+36pFdcnd88gmHjHv1sqIL7Phj+vlXocqcI0qyNA3t/eisLH6AoO2n/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637016; c=relaxed/simple;
	bh=O8UMgy4NK3I9Ac3Z4UxYDyPfUUZlGgk3rritssUgmSE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tARUZFXjkRilAgHZolZI8wwyzUbDh0CI/KW8wpDk9KE24GW/KY6Jv8mHIiUtXJbigOEXUPgOzZ5zMFXvo/sVA4VwsG0QxIpFxZrsNooxoa92JsY7TxLX3YvFRvPgoPNYEILUwhSKWdT7ed0yb4tyMFWZ2zT7v/rVg++4OttSb9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTArbzVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7DBC4CEC3;
	Fri, 11 Oct 2024 08:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728637016;
	bh=O8UMgy4NK3I9Ac3Z4UxYDyPfUUZlGgk3rritssUgmSE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZTArbzVFqv+vzi6Ln/obGoDSQd75fU7AS/1J/rnwZ9ku7vVaqKOt4oBS7JFJl97LO
	 yfC4gpjRIdwLUVcsR9aNXaQ6VxmcJjgqc03c2XxyAheP9pjPRqKKdIVrJRezZcmW7+
	 u7ukKjQBckULxox8wj4bRRfYoIAOsNmJ8L6ZPg91RV4KwaOr43dORcPYh54BY6GKfA
	 7jcHaXhmB6Yr6s1PdvDKz/PoD24aPBKaeXx1xn1bWJCfC7unyVJ9J60SyCACrCVTR6
	 7nFcVxyZz16BTAgYSUOGucG0jGiJ+vlDb+LhwhTgc1Ntryp70OhvnjbNbVa8XXHbce
	 XYBaxpbPM8g0g==
Message-ID: <94166f32-7ff9-46d2-83c9-4df2a787fe25@kernel.org>
Date: Fri, 11 Oct 2024 16:56:47 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
 Josef Bacik <josef@toxicpanda.com>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "Darrick J . Wong" <djwong@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Tejun Heo <tj@kernel.org>, akpm@linux-foundation.org,
 Christian Brauner <brauner@kernel.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 cgroups@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, linux-doc@vger.kernel.org,
 linux-xfs@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] fs/writeback: convert wbc_account_cgroup_owner to take a
 folio
To: Matthew Wilcox <willy@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240926140121.203821-1-kernel@pankajraghav.com>
 <ZvVrmBYTyNL3UDyR@casper.infradead.org> <ZvstH7UHpdnnDxW6@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZvstH7UHpdnnDxW6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/1 6:58, Jaegeuk Kim wrote:
> On 09/26, Matthew Wilcox wrote:
>> On Thu, Sep 26, 2024 at 04:01:21PM +0200, Pankaj Raghav (Samsung) wrote:
>>> Convert wbc_account_cgroup_owner() to take a folio instead of a page,
>>> and convert all callers to pass a folio directly except f2fs.
>>>
>>> Convert the page to folio for all the callers from f2fs as they were the
>>> only callers calling wbc_account_cgroup_owner() with a page. As f2fs is
>>> already in the process of converting to folios, these call sites might
>>> also soon be calling wbc_account_cgroup_owner() with a folio directly in
>>> the future.
>>
>> I was hoping for more from f2fs.  I still don't have an answer from them
>> whether they're going to support large folios.  There's all kinds of
>> crud already in these functions like:
>>
>>          f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
>>                          page_folio(fio->page)->index, fio, GFP_NOIO);
>>
>> and this patch is making it worse, not better.  A series of patches
>> which at least started to spread folios throughout f2fs would be better.
>> I think that struct f2fs_io_info should have its page converted to
>> a folio, for example.  Although maybe not; perhaps this structure can
>> carry data which doesn't belong to a folio that came from the page cache.
>> It's very hard to tell because f2fs is so mind-numbingly complex and
>> riddled with stupid abstraction layers.
> 
> Hah, I don't think it's too complex at all tho, there's a somewhat complexity to
> support file-based encryption, compression, and fsverity, which are useful

I agree w/ Jaegeuk.

> for Android users. Well, I don't see any strong needs to support large folio,
> but some requests exist which was why we had to do some conversion.
> 
>>
>> But I don't know what the f2fs maintainers have planned.  And they won't
>> tell me despite many times of asking.

I supported large folio in f2fs by using a hacking way /w iomap fwk, it can
only be enabled in very limited condition, after some seqread tests, I can
see performance gain in server environment, but none in android device, and
in addition, there is a memory leak bug which can cause out-of-memory issue.
Unlucky, I have no slots to dig into these issues recently.

Thanks,



