Return-Path: <linux-fsdevel+bounces-20327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1440E8D17E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128261C2493C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD12516B729;
	Tue, 28 May 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cl7TD5xg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EEF16B72D;
	Tue, 28 May 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890297; cv=none; b=Cg8E8JldQK/YcIVsJnUQlcjqjq5FKIBshjRiH2JvlQ/RCHX2aX21IvC7BSOii5kGRaKLY2kd3KJFYGVRiAOYwsRTGxN13bi5KPeGZ+hpqNuTedduNqPx2w1Ojm3oHl2DUxPeP3C5hrigi7UIj4FKPUi3SjzFCHRkPbUiA5G2zr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890297; c=relaxed/simple;
	bh=6hx438n+um4riiI14Idj1dDSnLV0yA9H9UwD+GzRrc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRYheXCShhGEg87BVCxkai7hjtFvQcfHTctCIzypIuUpWPfOSz+bLoDCnlT2LE5Re0ALujfI2HelXYV1c2tHeZ4m+E+8D/bFI1zhaOxB9yWUqert+3lShOK0AY/DOQGeKwETpcnNn9zUTYJC4o/YOSTx+vJ2zA3PzXGsf+iJTao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cl7TD5xg; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716890291; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GXy9MUCK5VGEeup/BbpcBg8zahF6no6zu65zqg0I4xs=;
	b=Cl7TD5xgG7SNnKhwCtrYG9xMqUBYe8wDcdEjxE36Cqe15bMVQr2EAj+CWNQ1ZVUxrGU/EGBOE8vA7N4Iv85LWxWa9mrPv/u+w3EX/DzqtEgF8aUZHKHndoQylAIghY8loYz+nxxEBUv7yL4/wCgw/DLgXmM45xteQWLOdJa6rg8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7PIbQB_1716890289;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7PIbQB_1716890289)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 17:58:11 +0800
Message-ID: <9666141f-ad0f-4224-ac48-eba63145c61e@linux.alibaba.com>
Date: Tue, 28 May 2024 17:58:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Christian Brauner <brauner@kernel.org>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, winters.zc@antgroup.com
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
 <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
 <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
 <ce886be9-41d3-47b6-82e9-57d8f1f3421f@linux.alibaba.com>
 <20240528-pegel-karpfen-fd16814adc50@brauner>
 <36c14658-2c38-4515-92e1-839553971477@linux.alibaba.com>
 <20240528-umstritten-liedchen-30e6ca6632b2@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240528-umstritten-liedchen-30e6ca6632b2@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/28 17:32, Christian Brauner wrote:
> On Tue, May 28, 2024 at 05:13:04PM +0800, Gao Xiang wrote:
>> Hi Christian,
>>
>> On 2024/5/28 16:43, Christian Brauner wrote:
>>> On Tue, May 28, 2024 at 12:02:46PM +0800, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2024/5/28 11:08, Jingbo Xu wrote:
>>>>>
>>>>>
>>>>> On 5/28/24 10:45 AM, Jingbo Xu wrote:
>>>>>>
>>>>>>
>>>>>> On 5/27/24 11:16 PM, Miklos Szeredi wrote:
>>>>>>> On Fri, 24 May 2024 at 08:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>>>
>>>>>>>> 3. I don't know if a kernel based recovery mechanism is welcome on the
>>>>>>>> community side.  Any comment is welcome.  Thanks!
>>>>>>>
>>>>>>> I'd prefer something external to fuse.
>>>>>>
>>>>>> Okay, understood.
>>>>>>
>>>>>>>
>>>>>>> Maybe a kernel based fdstore (lifetime connected to that of the
>>>>>>> container) would a useful service more generally?
>>>>>>
>>>>>> Yeah I indeed had considered this, but I'm afraid VFS guys would be
>>>>>> concerned about why we do this on kernel side rather than in user space.
>>>>
>>>> Just from my own perspective, even if it's in FUSE, the concern is
>>>> almost the same.
>>>>
>>>> I wonder if on-demand cachefiles can keep fds too in the future
>>>> (thus e.g. daemonless feature could even be implemented entirely
>>>> with kernel fdstore) but it still has the same concern or it's
>>>> a source of duplication.
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>>
>>>>>> I'm not sure what the VFS guys think about this and if the kernel side
>>>>>> shall care about this.
>>>
>>> Fwiw, I'm not convinced and I think that's a big can of worms security
>>> wise and semantics wise. I have discussed whether a kernel-side fdstore
>>> would be something that systemd would use if available multiple times
>>> and they wouldn't use it because it provides them with no benefits over
>>> having it in userspace.
>>
>> As far as I know, currently there are approximately two ways to do
>> failover mechanisms in kernel.
>>
>> The first model much like a fuse-like model: in this mode, we should
>> keep and pass fd to maintain the active state.  And currently,
>> userspace should be responsible for the permission/security issues
>> when doing something like passing fds.
>>
>> The second model is like one device-one instance model, for example
>> ublk (If I understand correctly): each active instance (/dev/ublkbX)
>> has their own unique control device (/dev/ublkcX).  Users could
>> assign/change DAC/MAC for each control device.  And failover
>> recovery just needs to reopen the control device with proper
>> permission and do recovery.
>>
>> So just my own thought, kernel-side fdstore pseudo filesystem may
>> provide a DAC/MAC mechanism for the first model.  That is a much
>> cleaner way than doing some similar thing independently in each
>> subsystem which may need DAC/MAC-like mechanism.  But that is
>> just my own thought.
> 
> The failover mechanism for /dev/ublkcX could easily be implemented using
> the fdstore. The fact that they rolled their own thing is orthogonal to
> this imho. Implementing retrieval policies like this in the kernel is
> slowly advancing into /proc/$pid/fd/ levels of complexity. That's all
> better handled with appropriate policies in userspace. And cachefilesd
> can similarly just stash their fds in the fdstore.

Ok, got it.  I just would like to know what kernel fdstore
currently sounds like (since Miklos mentioned it so I wonder
if it's feasible since it can benefit to non-fuse cases).
I think userspace fdstore works for me (unless some other
interesting use cases for evaluation later).

Jingbo has an internal requirement for fuse, that is a pure
fuse stuff, and that is out of my scope though.

Thanks,
Gao Xiang

