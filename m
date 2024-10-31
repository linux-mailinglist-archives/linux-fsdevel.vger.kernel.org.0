Return-Path: <linux-fsdevel+bounces-33369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D89B831C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 20:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1688D1C22707
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F56D1CB32F;
	Thu, 31 Oct 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CO847FxM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255719D089;
	Thu, 31 Oct 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401931; cv=none; b=Jf44UpFTWdoTL7LVgagz9rm0wa9MqFqRLerw55ywFXvZmMZ0WqOkVQwVVP3PJg/2kS4MOxVMR+hgldO7yx8MaaJWQg9eCRwfpgsxXRR4KXiHROuoJaym3IrqaycMJcOWdtkOujPI43Zwx421jR3MwfduwFhYerN86cTJCgZvk2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401931; c=relaxed/simple;
	bh=2ZpWWwgTmjp68SUfsUHTWPgHi2hxjOIEwTbMNUcwUEM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s7Aw/B+tnaXsdYn5efkXorf1ttgt+wZ2751khd0zekxwmWlOvYj7AVobuY7Xpa7X/CQcISxgC2tP4DlAd57ITVgJzfs7fTABSkSqsGWcNSmT5Ufdf1P6E5x5amkIL2HZYE14OyNILGEQCJQ4NwVtN/UUEix0wdLaEXLUuczXgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CO847FxM; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+aMdUrek5lqvlZKodKKva4xJumBiFz9JBAG3043NKoA=; b=CO847FxMlLq3zPRRQ1yey0VkO/
	n7wcRKBMqedbA68kbbGyCA/yTfr4oa8dmGiTLm07L2X8aUo74Z2Ri7nTciOBhRNw+4lPO15zr548k
	F3MYeNSqHOy3wG5O9FODJoMeij0nFXfqwMDWFBy1psKRz9FG7C1CV2cJDgmlA/l/YyuBRmP9D41SE
	YpuXV8qQJ5RRHPHPZzrF93L4GNIpeMth1R1DZLzHGrPU1S+qouQuVRS8eODyaM35Wp+8f89xQxFxA
	QYAovVJ3JSk8nfqvSQvTNDMNj9LmMNQ0gYj9Ckya7vAK9AVgrkGanuzUcoFDGOPbguPlBIfnmjN3n
	exCpwDkw==;
Received: from [189.78.222.89] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6aaB-00098s-KT; Thu, 31 Oct 2024 20:11:47 +0100
Message-ID: <3386dc35-3ed1-4aab-abd2-42adfa25ddd9@igalia.com>
Date: Thu, 31 Oct 2024 16:11:39 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/9] tmpfs: Expose filesystem features via sysfs
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com, kernel-dev@igalia.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@suse.de>, llvm@lists.linux.dev,
 linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
 <20241021-tonyk-tmpfs-v8-8-f443d5814194@igalia.com>
 <20241031051822.GA2947788@thelio-3990X>
 <c104f427-f9d9-498c-a719-ed6bf118226d@igalia.com>
Content-Language: en-US
In-Reply-To: <c104f427-f9d9-498c-a719-ed6bf118226d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 31/10/2024 14:31, André Almeida escreveu:
> Hi Nathan,
> 
> Em 31/10/2024 02:18, Nathan Chancellor escreveu:
>> Hi André,
>>

[...]

>> If there is any patch I can test or further information I can provide, I
>> am more than happy to do so.
>>

I found the issue, was just the DEVICE_ macro that I wasn't supposed to 
use inside of tmpfs, this diff solved the error for me, I will send a 
proper patch in a moment:

-- >8 --

diff --git a/mm/shmem.c b/mm/shmem.c
index 971e6f1184a5..db52c34d5020 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5551,12 +5551,21 @@ EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);

  #if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
  #if IS_ENABLED(CONFIG_UNICODE)
-static DEVICE_STRING_ATTR_RO(casefold, 0444, "supported");
+static ssize_t casefold_show(struct kobject *kobj, struct 
kobj_attribute *a,
+                       char *buf)
+{
+               return sysfs_emit(buf, "supported\n");
+}
+static struct kobj_attribute tmpfs_attr_casefold = {
+               .attr = { .name = "casefold", .mode = 0444 },
+               .show = casefold_show,
+               .store = NULL,
+};
  #endif

  static struct attribute *tmpfs_attributes[] = {
  #if IS_ENABLED(CONFIG_UNICODE)
-       &dev_attr_casefold.attr.attr,
+       &tmpfs_attr_casefold.attr,
  #endif
         NULL
  };

