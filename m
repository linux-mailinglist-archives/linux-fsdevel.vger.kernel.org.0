Return-Path: <linux-fsdevel+bounces-13770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C087E873AF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B67A282B71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA33135A52;
	Wed,  6 Mar 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="po9PMpUb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AE1353F4
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709739780; cv=none; b=t82Dp/U2odSxtw0B7h/ln0o5jbquWJ6oTa5iyBrfPp7Bn1nvA1PORLls4kmh8hTwnvzC6b1F6ler93FiNB6NioK6doL3/F2mLIMjUSEF9DwNM46aXahnl3ngu1foBFC73J1bV4KVaKlgeWQ+GGbVGY9p+xyM/wOn6KJg+e9ErRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709739780; c=relaxed/simple;
	bh=L6NtDTi6IxuJr2HEz9+NlQdI/czBfiDG2fLUsEkz3Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Br12YOSjO8Q/LSE6I4dudyNQwAntJfde2hm/9AeAuTP2FgGGBFQZBmAG0QBdyszPYhgl1OBaQERtbikJkgzrO7YqPt0qPtdZ0Z4uz6Cg8ZiscS5j5+JGkLcL19OwYd0Qz4ws0WUDy07x/qalsNzKHtqoIFbXs0TFWy0csYdnXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=po9PMpUb; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id hB3GraV3cHXmAhtPwrRVWl; Wed, 06 Mar 2024 15:42:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id htPvr1uFFjNGXhtPwrQDbc; Wed, 06 Mar 2024 15:42:52 +0000
X-Authority-Analysis: v=2.4 cv=XKc2SxhE c=1 sm=1 tr=0 ts=65e88efc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=6VED1VvVYjxIH-aiRFQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lmpKyOPFUzJ+LEJ4c5jaCXB0zx3UWJMtP0zgRHJSV20=; b=po9PMpUbR2G7GPleV01kCDx0FG
	4KF3gs0ABvVJ7iyALWRBsG0EncGjNCUrVEvX5FdPlWlGFktr5FO3ylw206TI6DwTlml15J8xfb6ei
	5f/9XzMPQnre/GH874iMFN+/OTBe7toLCN04YHRHotRE7RNZOuyZFTKGaCRel9CQrdwMg8KGKrPMf
	cQ0Sy/HcmGLDFNx+zZQ1rD+lStj7Ezecvdmg4ytztNR1v5rR9Ub8ewLVxYr7J8uL4YuFHG7n2z9gQ
	lvLWxCb01Vu87+N6MjBTJOYlHecKC2Lc5NBrP601G1NA2WgpdGID5bu1W30My5F/loENuEi6L4Asw
	id3pXPzA==;
Received: from [201.172.172.225] (port=37704 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhtPv-000nwp-0p;
	Wed, 06 Mar 2024 09:42:51 -0600
Message-ID: <34889a1a-4c8f-4c4d-865a-f947569f8d9c@embeddedor.com>
Date: Wed, 6 Mar 2024 09:42:50 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] fsnotify: Avoid -Wflex-array-member-not-at-end
 warning
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZeeaRuTpuxInH6ZB@neat> <202403051548.045B16BF@keescook>
 <CAOQ4uxg185+i+n_mnXsEaxXYJ1SseDH6RtGreTJDhjkOt6mmSA@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAOQ4uxg185+i+n_mnXsEaxXYJ1SseDH6RtGreTJDhjkOt6mmSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhtPv-000nwp-0p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:37704
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLegc+vMlbaFNp/Ssbj0RBgPGqJ0bbM7TGUkrRLZjUS77FTA4jNHj6KYOuMUSkDgu0WK9SHB0CeqXMbIkH3RWpRbZKIJ6PGgmbKMUf+sOgWKSOe2aJkk
 /CWxK0oOLNliQ6Y0VZA9SiVHW+T08AzDwdvMYd8eLs7ShZwGSxOM9JPnlzhjlgS6peqfu7qpNCwJ1JvQ16bK/BX7r3vgewNkx4u7vCC98mR6pQz5l2GrcqlM



On 3/6/24 01:36, Amir Goldstein wrote:
> On Wed, Mar 6, 2024 at 1:52 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Tue, Mar 05, 2024 at 04:18:46PM -0600, Gustavo A. R. Silva wrote:
>>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>>> ready to enable it globally.
>>>
>>> There is currently a local structure `f` that is using a flexible
>>> `struct file_handle` as header for an on-stack place-holder for the
>>> flexible-array member `unsigned char f_handle[];`.
>>>
>>> struct {
>>>        struct file_handle handle;
>>>        u8 pad[MAX_HANDLE_SZ];
>>> } f;
>>
>> This code pattern is "put a flex array struct on the stack", but we have
>> a macro for this now:
>>
>> DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ);
>>
>> And you can even include the initializer:
>>
>> _DEFINE_FLEX(struct file_handle, handle, f_handle, MAX_HANDLE_SZ,
>>               = { .handle_bytes = MAX_HANDLE_SZ });
>>
> 
> Indeed that looks much nicer.


Yeah, I'll probably wait for this to land before I send a v2:

https://lore.kernel.org/linux-hardening/20240306010746.work.678-kees@kernel.org/

Thanks
--
Gustavo

