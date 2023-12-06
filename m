Return-Path: <linux-fsdevel+bounces-5037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A28077D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DDA1F202CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74DC6EB64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JzvIDjMq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719CD51
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 09:16:59 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 23ACD2E0;
	Wed,  6 Dec 2023 17:16:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 23ACD2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1701883019; bh=1xK9gCSjF7wXrSdz7VzVSigPO/PPJV1NHs7lBJwNRbU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JzvIDjMqlxDYfJqxOd16N7RGgf2ZKqaHM5NOO5v606QZbCyRH0Qvvu9/YcboCR2ES
	 PPrXJNXg1SxYS/i2NTBVTqR+KINrrJEeIXRXS7jK9Fq8/SW3EL9BG0POvotAgtdUIf
	 D0yOjfhK+iMoCl6VinHOYO+rg2f4APjHS9Wm4hCyAc1VQ3wCoUgMSKo+2eCvq5JkJA
	 Kkz/QQSK6JDqTz4PeG62JX4DyOZib84dqarkRMVD+YrCZ5vlTx1/hdrEpWMd+OSxkB
	 YZHjb39g8Oi0eU6mB20D75XOXif0BwG85i3ChZak275N9+ZxZfltxXYUvBBupgjSGn
	 kLI7dKnHql2aA==
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, Hans de Goede
 <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH] fs: vboxsf: fix a kernel-doc warning
In-Reply-To: <bec63fe6-b9d7-4aff-bee6-d5c137554d71@infradead.org>
References: <20231206025355.31814-1-rdunlap@infradead.org>
 <0fb8fe4f-cb5d-4c74-9bdc-34ff04024f62@redhat.com>
 <bec63fe6-b9d7-4aff-bee6-d5c137554d71@infradead.org>
Date: Wed, 06 Dec 2023 10:16:58 -0700
Message-ID: <87lea7b69h.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 12/6/23 06:57, Hans de Goede wrote:
>> Hi Randy,
>> 
>> On 12/6/23 03:53, Randy Dunlap wrote:
>>> Fix function parameters to prevent kernel-doc warnings.
>>>
>>> vboxsf_wrappers.c:132: warning: Function parameter or member 'create_parms' not described in 'vboxsf_create'
>>> vboxsf_wrappers.c:132: warning: Excess function parameter 'param' description in 'vboxsf_create'
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>> Cc: Christian Brauner <brauner@kernel.org>
>> 
>> Thanks, patch looks good to me:
>> 
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> 
>> vboxsf is not really undergoing any active development,
>> can this be merged through the Documentation tree?
>> 
>> Regards,
>> 
>> Hans
>
> I have no idea, but we can ask Jon.
>
> Jon, can you merge this patch thru the Documentation tree?

I've not actually seen the patch but, yes, I should be able to do that.
Will go dig it out in a bit.

Thanks,

jon

