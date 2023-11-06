Return-Path: <linux-fsdevel+bounces-2082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F77E20A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 13:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C7DB20DB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4B41A735;
	Mon,  6 Nov 2023 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C61199B7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 12:04:01 +0000 (UTC)
Received: from out0-197.mail.aliyun.com (out0-197.mail.aliyun.com [140.205.0.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5FDDF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 04:03:58 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=winters.zc@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.VGJr.pv_1699272234;
Received: from 30.46.227.128(mailfrom:winters.zc@antgroup.com fp:SMTPD_---.VGJr.pv_1699272234)
          by smtp.aliyun-inc.com;
          Mon, 06 Nov 2023 20:03:55 +0800
Message-ID: <728ea460-089e-4b2a-a4b7-575b578c8ff6@antgroup.com>
Date: Mon, 06 Nov 2023 20:03:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] fuse: Introduce sysfs APIs to flush or resend
 pending requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
References: <20231031144043.68534-1-winters.zc@antgroup.com>
 <CAJfpegtjNj+W1F4j_eBAij_yYLsC9A3=LgNvUymSykHR5EvvoA@mail.gmail.com>
 <2a2bf87a-87ba-40d2-8d10-c4960efbd11f@antgroup.com>
 <CAJfpegtZKrDz-NTq7-Edb7GSm7GSParoxBr7e7kEodfR8c8CMA@mail.gmail.com>
From: "=?UTF-8?B?6LW15pmo?=" <winters.zc@antgroup.com>
In-Reply-To: <CAJfpegtZKrDz-NTq7-Edb7GSm7GSParoxBr7e7kEodfR8c8CMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2023/11/6 下午6:39, Miklos Szeredi 写道:
> On Mon, 6 Nov 2023 at 10:57, 赵晨 <winters.zc@antgroup.com> wrote:
> 
>> So, based on my understanding, resend is adequate, but flush can offer
>> more convenience. I would like to inquire about your preference
>> regarding the two APIs. Should I do some verification and remove the
>> flush API, and then resend this patchset?
> 
> I think it would be best to make it easy for the server to flush all
> requests using the resend API and discard the flush API.
> 
> One idea to make it easy to distinguish between normal and resent
> requests is to set the high bit of unique.
> 
> Thanks,
> Miklos

OK, thank you Miklos! I will try making and testing these modifications.

Best Regards,
Zhao Chen

