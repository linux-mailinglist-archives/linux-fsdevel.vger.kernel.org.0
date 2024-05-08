Return-Path: <linux-fsdevel+bounces-19045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BEF8BF9B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB51BB21750
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123B768EF;
	Wed,  8 May 2024 09:42:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F898757FF;
	Wed,  8 May 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161374; cv=none; b=D+D3NI34tCvpsnKNnbqq3qAdDdtygqaWGbnLNVad8ANXF8KEtteHp0xyJRJqSZT0uuF+2X/sS+WgIOoK5QH/xNxLVm3ykWlniaJ624KMvsPrUeVE8rz5eGjKzGZToybrZe6bJV9tVwYob3AvzZJJ3iv1o+lL/Y3+gZQrLjpxjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161374; c=relaxed/simple;
	bh=YHhb3E66PGlQl+ORWKOgBzytmosAOuM1TfPsevoH4HQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pNVhwPNozauyvTKDYNlZvPHoTN9AFHHEEkuKvysxRA8VGvpcD0MXn7wOanNTFH/L5eHHNfAZLaAYvfP9wkyKSY3yhe1L63b3nM4faqX61gRIh5zPFA4CsHcc78B+MbQAPlLnMAuOJRJj0xRrlEj9/huEgI2kxII0COUwA6LCkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VZ9DM2lFHz4f3kKj;
	Wed,  8 May 2024 17:42:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AE2D11A016E;
	Wed,  8 May 2024 17:42:48 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDHmBEXSTtmpt9aMA--.1934S2;
	Wed, 08 May 2024 17:42:48 +0800 (CST)
Subject: Re: WARNING in fuse_request_end
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lee bruce <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org,
 yue sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
 syzkaller@googlegroups.com
References: <CABOYnLwAe+hVUNe+bsYeKJJQ-G9svs7dR2ymZDh0PsfqFNMm2A@mail.gmail.com>
 <2625b40f-b6c5-2359-33fe-5c81e9a925a9@huaweicloud.com>
 <CAJfpegvGhtLSxOHUQQ95a3skqEgEPt+MzpBT8vOOdqWcRxPR5Q@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <58f13e47-4765-fce4-daf4-dffcc5ae2330@huaweicloud.com>
Date: Wed, 8 May 2024 17:42:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJfpegvGhtLSxOHUQQ95a3skqEgEPt+MzpBT8vOOdqWcRxPR5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDHmBEXSTtmpt9aMA--.1934S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw18Cw17ZF1kCF4DArWrXwb_yoWxtFg_ur
	47uryvkF15Jr18uFWrtF1rKr98AFWkA3Z7WwsrAFy3AayUZ3yxZryYvr1rGr43Gw45JFn5
	u3s8ua98KFyYgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 5/8/2024 4:21 PM, Miklos Szeredi wrote:
> On Tue, 7 May 2024 at 15:30, Hou Tao <houtao@huaweicloud.com> wrote:
>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 3ec8bb5e68ff5..840cefdf24e26 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1814,6 +1814,7 @@ static void fuse_resend(struct fuse_conn *fc)
>>
>>         list_for_each_entry_safe(req, next, &to_queue, list) {
>>                 __set_bit(FR_PENDING, &req->flags);
>> +               clear_bit(FR_SENT, &req->flags);
>>                 /* mark the request as resend request */
>>                 req->in.h.unique |= FUSE_UNIQUE_RESEND;
>>         }
>>
> ACK, fix looks good.
>
> Would you mind resending it as a proper patch?

Thanks for the ACK. Will post it.
>
> Thanks,
> Miklos
>
> .


