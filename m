Return-Path: <linux-fsdevel+bounces-26015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAEC952826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 05:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BE3285318
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF612CCB4;
	Thu, 15 Aug 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="pm5S3hKd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G3JdjC7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882292231C;
	Thu, 15 Aug 2024 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691421; cv=none; b=s7hQJauRGwz7mzGnH9KbEjub5kwPBUaKhBiq9FfuH2/fp0FUpewzH2E1VkOWvbeFin9RVt+jr+K+DX2Sf2ByDa9UC3BsucA5NZrcGDHV7G/FCIeEHkUEH5tVle5I11YtDSjRcbKZPyBbC0awvnMH4LowPJYdJGWi1tySNLrB1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691421; c=relaxed/simple;
	bh=M6YjnpmvNw00EeGqOmJgxN3F843Y4UfDXvq3cCI3kY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pT1CnVOa6Eo3XYgRQLNizvmThKvYfoyXxbPXd3HwthTxP5cV0qgGSYHW+Y97diGn5YqZxVbobzV6OqmeLj+ubG+7dwrYZV9f9fGGGymotC+5H5nkgX/lfynhzyAzvN52ESoDOdH1c9+eOrJMjRPLLaY8t2QZ55uE9wWSDhJGjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=pm5S3hKd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G3JdjC7s; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8FE97138FF32;
	Wed, 14 Aug 2024 23:10:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 23:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723691417;
	 x=1723777817; bh=yd8hIN8ro0TGxbEHyb5uWlyQKIUnGX2i3Lay/yghMRw=; b=
	pm5S3hKdg0cfvmuBOP2aMlfsAETBrdbpmlH0NmvXYbaQKGs7SWnmkqS2J//JH2Uq
	EwRjw6ZMVBb4e0xC430fffotsT+fTGZjeb0yEgJICDyVM84mjNLhEBvP8gDhVlBn
	ePf+aEH0UJRbBqbexOc9zPMf2k/Jf150UuImwQ3sejL6q0pzljoPQDmWtCmEfKf+
	IoWgNIxZ5mDk2FVF73hY93MqaT9ucJLvaReXqaVwNZA+OJUALZMFha8i/dqqMRQZ
	aZWnNqjTm3RPQS6tFUpxf3nQbnH0PN2YtegASllna/NeB8CKSONTwh5z4Sa5c+WS
	/2Cpl/5dhyVVi042CdNFQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723691417; x=
	1723777817; bh=yd8hIN8ro0TGxbEHyb5uWlyQKIUnGX2i3Lay/yghMRw=; b=G
	3JdjC7saYCaxVwQQqspCWCmVrjdXxH5i8urmkGHjoTyCGmjaKZlZ6S4r8mgrMu6g
	BskpED1kOGFM4JY+jJFzzD/4/Al5jmFPYm47whFp4aWEatdkPt1hS7ipIExBdovj
	wSiJIf8Vb5tOS0rlYMvVC0spUSpZLtGoY8PJs5OlQrzPQhw2IdHUK0Sd/SFU+I4E
	SASskDuQs3ABhn+WZDzfphcxJt8uyn23d839oDXLiD3YGQYGRmclgBljOmoBuYdm
	HeAyutasYxcw8a8JBAPgb6JwYoY7bNs7bLZmsSxThWSgaVs6NH7Uc4ZpWJ4ZLLVq
	ERsdicJjMIOy+XbnvDACQ==
X-ME-Sender: <xms:mXG9ZrlRYol_JpJjq9OlXi3jfvu5mNhvkNAjncaS7QXy3Wldi6bBrg>
    <xme:mXG9Zu0dy-B17e5mUeLCa-yYGj9FQMAUwdRxUbAzGKr8yXAwy1QzIb4EgWLagiK70
    T8LAXq5YHZ8>
X-ME-Received: <xmr:mXG9ZhoEO0eGeAYFSmjaz4v2oOkBTlB0XEqcV6HR3oifsAFWmREklvfC21q1EVy53YIl_E2DoB0r7hnknyT2FMwMVZgweig4JTHXELZJ0QpI_gU8riyOlsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqne
    cuggftrfgrthhtvghrnhepfeekhfegieegteelffegleetjeekuddvhfehjefhheeuiedt
    heeuhfekueekffehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhr
    tghpthhtoheprghuthhofhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mXG9ZjmHq_Kx-FvfhTWcj_w9qx09fhvbttDbwB4m5bK7cMy5OLZJ9g>
    <xmx:mXG9Zp2NVcGcZ-VeX9qtct8BaRRdXSfdbPK1FegYLSnx178i4e67cw>
    <xmx:mXG9Ziv2SmIQQ079FonGXywxSuehShUV24wujwDrBoa52IAEzgqs1Q>
    <xmx:mXG9ZtUDV98ddysruJJ0T3Q1OrxZzYz4N9wKEf-xkwXncMaV9bKvBw>
    <xmx:mXG9ZkRYUwMrb6PPlpWT0V0f-fuozex3m_XU8qiTZrfHYd3xuPN9WJRY>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 23:10:15 -0400 (EDT)
Message-ID: <67656e13-c816-44f0-8a69-5efa7c76a907@themaw.net>
Date: Thu, 15 Aug 2024 11:10:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] autofs: add per dentry expire timeout
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20240814090231.963520-1-raven@themaw.net>
 <20240814-darauf-schund-23ec844f4a09@brauner>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20240814-darauf-schund-23ec844f4a09@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/8/24 22:39, Christian Brauner wrote:
> On Wed, Aug 14, 2024 at 05:02:31PM GMT, Ian Kent wrote:
>> Add ability to set per-dentry mount expire timeout to autofs.
>>
>> There are two fairly well known automounter map formats, the autofs
>> format and the amd format (more or less System V and Berkley).
>>
>> Some time ago Linux autofs added an amd map format parser that
>> implemented a fair amount of the amd functionality. This was done
>> within the autofs infrastructure and some functionality wasn't
>> implemented because it either didn't make sense or required extra
>> kernel changes. The idea was to restrict changes to be within the
>> existing autofs functionality as much as possible and leave changes
>> with a wider scope to be considered later.
>>
>> One of these changes is implementing the amd options:
>> 1) "unmount", expire this mount according to a timeout (same as the
>>     current autofs default).
>> 2) "nounmount", don't expire this mount (same as setting the autofs
>>     timeout to 0 except only for this specific mount) .
>> 3) "utimeout=<seconds>", expire this mount using the specified
>>     timeout (again same as setting the autofs timeout but only for
>>     this mount).
>>
>> To implement these options per-dentry expire timeouts need to be
>> implemented for autofs indirect mounts. This is because all map keys
>> (mounts) for autofs indirect mounts use an expire timeout stored in
>> the autofs mount super block info. structure and all indirect mounts
>> use the same expire timeout.
>>
>> Now I have a request to add the "nounmount" option so I need to add
>> the per-dentry expire handling to the kernel implementation to do this.
>>
>> The implementation uses the trailing path component to identify the
>> mount (and is also used as the autofs map key) which is passed in the
>> autofs_dev_ioctl structure path field. The expire timeout is passed
>> in autofs_dev_ioctl timeout field (well, of the timeout union).
>>
>> If the passed in timeout is equal to -1 the per-dentry timeout and
>> flag are cleared providing for the "unmount" option. If the timeout
>> is greater than or equal to 0 the timeout is set to the value and the
>> flag is also set. If the dentry timeout is 0 the dentry will not expire
>> by timeout which enables the implementation of the "nounmount" option
>> for the specific mount. When the dentry timeout is greater than zero it
>> allows for the implementation of the "utimeout=<seconds>" option.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> ---
>>   fs/autofs/autofs_i.h         |  4 ++
>>   fs/autofs/dev-ioctl.c        | 97 ++++++++++++++++++++++++++++++++++--
>>   fs/autofs/expire.c           |  7 ++-
>>   fs/autofs/inode.c            |  2 +
>>   include/uapi/linux/auto_fs.h |  2 +-
>>   5 files changed, 104 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
>> index 8c1d587b3eef..77c7991d89aa 100644
>> --- a/fs/autofs/autofs_i.h
>> +++ b/fs/autofs/autofs_i.h
>> @@ -62,6 +62,7 @@ struct autofs_info {
>>   	struct list_head expiring;
>>   
>>   	struct autofs_sb_info *sbi;
>> +	unsigned long exp_timeout;
>>   	unsigned long last_used;
>>   	int count;
>>   
>> @@ -81,6 +82,9 @@ struct autofs_info {
>>   					*/
>>   #define AUTOFS_INF_PENDING	(1<<2) /* dentry pending mount */
>>   
>> +#define AUTOFS_INF_EXPIRE_SET	(1<<3) /* per-dentry expire timeout set for
>> +					  this mount point.
>> +					*/
>>   struct autofs_wait_queue {
>>   	wait_queue_head_t queue;
>>   	struct autofs_wait_queue *next;
>> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
>> index 5bf781ea6d67..f011e026358e 100644
>> --- a/fs/autofs/dev-ioctl.c
>> +++ b/fs/autofs/dev-ioctl.c
>> @@ -128,7 +128,13 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
>>   			goto out;
>>   		}
>>   
>> +		/* Setting the per-dentry expire timeout requires a trailing
>> +		 * path component, ie. no '/', so invert the logic of the
>> +		 * check_name() return for AUTOFS_DEV_IOCTL_TIMEOUT_CMD.
>> +		 */
>>   		err = check_name(param->path);
>> +		if (cmd == AUTOFS_DEV_IOCTL_TIMEOUT_CMD)
>> +			err = err ? 0 : -EINVAL;
>>   		if (err) {
>>   			pr_warn("invalid path supplied for cmd(0x%08x)\n",
>>   				cmd);
>> @@ -396,16 +402,97 @@ static int autofs_dev_ioctl_catatonic(struct file *fp,
>>   	return 0;
>>   }
>>   
>> -/* Set the autofs mount timeout */
>> +/*
>> + * Set the autofs mount expire timeout.
>> + *
>> + * There are two places an expire timeout can be set, in the autofs
>> + * super block info. (this is all that's needed for direct and offset
>> + * mounts because there's a distinct mount corresponding to each of
>> + * these) and per-dentry within within the dentry info. If a per-dentry
>> + * timeout is set it will override the expire timeout set in the parent
>> + * autofs super block info.
>> + *
>> + * If setting the autofs super block expire timeout the autofs_dev_ioctl
>> + * size field will be equal to the autofs_dev_ioctl structure size. If
>> + * setting the per-dentry expire timeout the mount point name is passed
>> + * in the autofs_dev_ioctl path field and the size field updated to
>> + * reflect this.
>> + *
>> + * Setting the autofs mount expire timeout sets the timeout in the super
>> + * block info. struct. Setting the per-dentry timeout does a little more.
>> + * If the timeout is equal to -1 the per-dentry timeout (and flag) is
>> + * cleared which reverts to using the super block timeout, otherwise if
>> + * timeout is 0 the timeout is set to this value and the flag is left
>> + * set which disables expiration for the mount point, lastly the flag
>> + * and the timeout are set enabling the dentry to use this timeout.
>> + */
>>   static int autofs_dev_ioctl_timeout(struct file *fp,
>>   				    struct autofs_sb_info *sbi,
>>   				    struct autofs_dev_ioctl *param)
>>   {
>> -	unsigned long timeout;
>> +	unsigned long timeout = param->timeout.timeout;
>> +
>> +	/* If setting the expire timeout for an individual indirect
>> +	 * mount point dentry the mount trailing component path is
>> +	 * placed in param->path and param->size adjusted to account
>> +	 * for it otherwise param->size it is set to the structure
>> +	 * size.
>> +	 */
>> +	if (param->size == AUTOFS_DEV_IOCTL_SIZE) {
>> +		param->timeout.timeout = sbi->exp_timeout / HZ;
>> +		sbi->exp_timeout = timeout * HZ;
>> +	} else {
>> +		struct dentry *base = fp->f_path.dentry;
>> +		struct inode *inode = base->d_inode;
>> +		int path_len = param->size - AUTOFS_DEV_IOCTL_SIZE - 1;
>> +		struct dentry *dentry;
>> +		struct autofs_info *ino;
>> +
>> +		if (!autofs_type_indirect(sbi->type))
>> +			return -EINVAL;
>> +
>> +		/* An expire timeout greater than the superblock timeout
>> +		 * could be a problem at shutdown but the super block
>> +		 * timeout itself can change so all we can really do is
>> +		 * warn the user.
>> +		 */
>> +		if (timeout >= sbi->exp_timeout)
>> +			pr_warn("per-mount expire timeout is greater than "
>> +				"the parent autofs mount timeout which could "
>> +				"prevent shutdown\n");
> Wouldn't it be possible to just record the lowest known per-dentry
> timeout in idk sbi->exp_lower_bound and reject sbi->exp_timeout changes
> that go below that?

Not sure I understand what your saying here.


The (amd) auto-mounted mounts are each meant to be able to expire 
independently,

according to the timeout set for each of them rather than use the global 
timeout set

in the autofs (parent) mount.


But your comment is useful because I do use a polling mechanism in user 
space to check

for expiration and the frequency of checking becomes a problem when I 
introduce this.

Setting a lower bound may make the frequency to short (for very large 
directories) and

I think there will be difficulties working out when the frequency needs 
to be reduced

after changes. But these are problems that I think can be left to user 
space, not sure

yet. For now it will be adequate to go with the default frequency based 
on the parent

mount as it is now (ie. a check frequency of one quarter of the expire 
global timeout).


Ian


