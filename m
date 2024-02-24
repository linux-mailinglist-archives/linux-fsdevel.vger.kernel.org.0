Return-Path: <linux-fsdevel+bounces-12685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95FC86287D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 00:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49AE5B213C8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0F4EB31;
	Sat, 24 Feb 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FuL6Ae3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CD12B82;
	Sat, 24 Feb 2024 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708818031; cv=none; b=M+O4T4ZKfNjOE+3sXLKg+L8jvCksWillT+SUmsmQ9HMHTLrjcCoPZbvgNeePOhr9MSyWkes+mj2q6fyxFpdF+oP+WvYcz/0Rgi5arxpCk/mqGO+OSbt2Lhfk9ecNIKiaCpWJnzdOVovpGhaali94CN/+iQFCoHMaff0ppQUQSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708818031; c=relaxed/simple;
	bh=OYw2ByYVVHvBoCVIfIWdB7pG17J1LlNmfxFwVKBACEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+s62MbiainDs+6BxUyl1tIW0pinDMqdwLa1JrX1KpVPkN8VePoEhwmXi2//i7U+Z0Z3VGSzvivN/FX3MzUEsZYcFByqMKU90vcfWvFuQzeLZprI06T9Z2sqdaV5GK5VHRQaCyx3rWKX1h6FCKUQu5hSx08m4mnlUL9Dvj9FhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FuL6Ae3f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TI5u+hB8IqJPV1NXXXiHCj1H8nEjuxpLgMV7QWNQhGk=; b=FuL6Ae3fH6sehiIobvIeA2t2bf
	cncxTnJTyw0IHXpzN8sufwgSnKg2jUMaDxJ0hATMrjfW+0n6NwP/pO6T0gtaGujbERbYn+u+0i6X+
	8MLtw8e5wY7Z3YYlPzos+/xQI4CECLE80kci01A0Uk1UR++i8zKHKujjDrmM5Ddt51en5El5gYEaL
	3cr5WzXhu7hPDrGl5hLexOaE+fhvj4RGicHqYE5LyUWSncZn16pQQ8yUZy6KXiJ9yIdClDhx5VQHG
	VQFVgO1VV4VSL+xI5ENAlFWjM5j6CqRZuTu7BpygZ4y7SqTb4TUH70Li9sgiZ0pMyaXFZSyN8LZ0/
	t57Bv54Q==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1re1cs-0000000DrjE-1TMs;
	Sat, 24 Feb 2024 23:40:14 +0000
Message-ID: <121d0ce8-e542-4a1c-85e9-0d1863f36741@infradead.org>
Date: Sat, 24 Feb 2024 15:40:11 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/20] famfs: Add include/linux/famfs_ioctl.h
Content-Language: en-US
To: John Groves <John@groves.net>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com,
 Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
 dave.hansen@linux.intel.com, gregory.price@memverge.com
References: <cover.1708709155.git.john@groves.net>
 <b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
 <8f62b688-6c14-4eab-b039-7d9a112893f8@infradead.org>
 <7onhdq4spd7mnkr5c443sbvnr7l4n34amtterg4soiey2qubyl@r2ppa6fsohnk>
 <97cde8f6-21ed-45b9-9618-568933102f05@infradead.org>
 <7rkmolss5vkdljnh6uksfkepklwofe3bkdsf36qhokyltjoxlx@xqgef734pidg>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7rkmolss5vkdljnh6uksfkepklwofe3bkdsf36qhokyltjoxlx@xqgef734pidg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/24 15:32, John Groves wrote:
> On 24/02/23 07:27PM, Randy Dunlap wrote:
>> Hi John,
>>
>> On 2/23/24 18:23, John Groves wrote:
>>>>> +
>>>>> +#define FAMFSIOC_MAGIC 'u'
>>>> This 'u' value should be documented in
>>>> Documentation/userspace-api/ioctl/ioctl-number.rst.
>>>>
>>>> and if possible, you might want to use values like 0x5x or 0x8x
>>>> that don't conflict with the ioctl numbers that are already used
>>>> in the 'u' space.
>>> Will do. I was trying to be too clever there, invoking "mu" for
>>> micron. 
>>
>> I might have been unclear about this one.
>> It's OK to use 'u' but the values 1-4 below conflict in the 'u' space:
>>
>> 'u'   00-1F  linux/smb_fs.h                                          gone
>> 'u'   20-3F  linux/uvcvideo.h                                        USB video class host driver
>> 'u'   40-4f  linux/udmabuf.h
>>
>> so if you could use
>> 'u'   50-5f
>> or
>> 'u'   80-8f
>>
>> then those conflicts wouldn't be there.
>> HTH.
>>
>>>>> +
>>>>> +/* famfs file ioctl opcodes */
>>>>> +#define FAMFSIOC_MAP_CREATE    _IOW(FAMFSIOC_MAGIC, 1, struct famfs_ioc_map)
>>>>> +#define FAMFSIOC_MAP_GET       _IOR(FAMFSIOC_MAGIC, 2, struct famfs_ioc_map)
>>>>> +#define FAMFSIOC_MAP_GETEXT    _IOR(FAMFSIOC_MAGIC, 3, struct famfs_extent)
>>>>> +#define FAMFSIOC_NOP           _IO(FAMFSIOC_MAGIC,  4)
>>
>> -- 
>> #Randy
> 
> Thanks Randy; I think I'm the one that didn't read carefully enough.
> 
> Does this look right?
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 457e16f06e04..44a44809657b 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -288,6 +288,7 @@ Code  Seq#    Include File                                           Comments
>  'u'   00-1F  linux/smb_fs.h                                          gone
>  'u'   20-3F  linux/uvcvideo.h                                        USB video class host driver
>  'u'   40-4f  linux/udmabuf.h                                         userspace dma-buf misc device
> +'u'   50-5F  linux/famfs_ioctl.h                                     famfs shared memory file system
>  'v'   00-1F  linux/ext2_fs.h                                         conflict!
>  'v'   00-1F  linux/fs.h                                              conflict!
>  'v'   00-0F  linux/sonypi.h                                          conflict!
> diff --git a/include/uapi/linux/famfs_ioctl.h b/include/uapi/linux/famfs_ioctl.h
> index 6b3e6452d02f..57521898ed57 100644
> --- a/include/uapi/linux/famfs_ioctl.h
> +++ b/include/uapi/linux/famfs_ioctl.h
> @@ -48,9 +48,9 @@ struct famfs_ioc_map {
>  #define FAMFSIOC_MAGIC 'u'
> 
>  /* famfs file ioctl opcodes */
> -#define FAMFSIOC_MAP_CREATE    _IOW(FAMFSIOC_MAGIC, 1, struct famfs_ioc_map)
> -#define FAMFSIOC_MAP_GET       _IOR(FAMFSIOC_MAGIC, 2, struct famfs_ioc_map)
> -#define FAMFSIOC_MAP_GETEXT    _IOR(FAMFSIOC_MAGIC, 3, struct famfs_extent)
> -#define FAMFSIOC_NOP           _IO(FAMFSIOC_MAGIC,  4)
> +#define FAMFSIOC_MAP_CREATE    _IOW(FAMFSIOC_MAGIC, 0x50, struct famfs_ioc_map)
> +#define FAMFSIOC_MAP_GET       _IOR(FAMFSIOC_MAGIC, 0x51, struct famfs_ioc_map)
> +#define FAMFSIOC_MAP_GETEXT    _IOR(FAMFSIOC_MAGIC, 0x52, struct famfs_extent)
> +#define FAMFSIOC_NOP           _IO(FAMFSIOC_MAGIC,  0x53)
> 
> Thank you!
> John
> 

Yes, that looks good.
Thanks.

-- 
#Randy

