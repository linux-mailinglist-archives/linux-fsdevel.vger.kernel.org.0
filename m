Return-Path: <linux-fsdevel+bounces-10507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA684BCE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 19:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8743C28378A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA13134BA;
	Tue,  6 Feb 2024 18:25:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB0134A6;
	Tue,  6 Feb 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243937; cv=none; b=e3WElZ/GB5d5+LGKWH4bR3d+k29ugM8/yDSYVxs9p2F6+S1g94BL70ip8Cx6epdcPawDZZx6uGslWKt/Tl9Ofya9AFVT3Av4lHwGIR4lPhYxD+KsT+uVqUC7Qw1NYUZ9Rlc4/7VuzCJn3VF58qkAhhd5h2ny1Et+Qe4bBapACM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243937; c=relaxed/simple;
	bh=boIl8+TYOpv1nFJrU868vTSHC6Kp2anwFIqbK6Q1jnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7V4qBwBwBYVe1cuyHF+zurJ8S6V8X+KzaSBFcaqk91HA1XlRshFUbz3Qzitfe/WZsu/GTPynGJHuCegUcV2M8ujiPk7YrMEHb6hkL/F2MeT/MuSU4Vvp+slkha+yv3DtOlkhVBd0Y+lZ5Gv9zBEpk7JRoNHGPqh2CguZpxLng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e054f674b3so1014973b3a.1;
        Tue, 06 Feb 2024 10:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707243935; x=1707848735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7OPD6Ab0mIup3vmBPQkMwBWi3PgXlH+8pyREPGDz9Y=;
        b=v0VIUnmQovpz5l4ulIwG6WSY84OFbOLPOITXpZM/Wh2/MTChsWWreQqXpfVDBwnOMT
         V/zXnBHQ0mBLUrolXC+WS/9vcuKTg6esBC6XvWcZkCSnjcbJOrLhIC8lWz1NTl94MlKF
         fsD1qHEn6kce1SOQAfy6NW7nh1/yjGvEyTyCS/j2XNrhbjAp9x/vMHXQ/aJVk1MEkU1a
         Ru1ScSyenlHs8y+/b8R7n2JL/r3XYYHn6XOmZCXSL8+u7xhubOiW/PVOz2vpCV2g79/p
         AriwvCA7/8sW0KotNEJMBJSqz8LXShRBrt1drveGPHTxHHq9vUSUOnqhq+hav3V09AwW
         tmXw==
X-Gm-Message-State: AOJu0YxAF6aURDegRiVu9+V4Bou6LXz781QJz2jDFCjDT7CycUSDiaoK
	ZRx+c3AhHQ4VydFy29iYHmSpbumxYwyhhdDAyAvfmNKJ3GWM0Rkb
X-Google-Smtp-Source: AGHT+IHzeykEQwnsURnDGMQmcK034wo8Yyz29Yv15z5NhGJQqVfCW8LjcHZxg3Cogyua2OkJdCQNZw==
X-Received: by 2002:a05:6a00:189f:b0:6e0:450c:4a2b with SMTP id x31-20020a056a00189f00b006e0450c4a2bmr439535pfh.9.1707243934774;
        Tue, 06 Feb 2024 10:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMbyrLJfHQlzb/E9hQ/ZbCWDLa3IOdY4U9HOq7NNOjTVJ1tXcrmZy1lk4iBD49XYCVEVLJFX9PaGoVp/eLzaE4vlc3kngGwCQLOPXloNsqBwyyb1jLJ40PK0WnujNyqVhKrpnUMbBKWv0mGY7yCGZil7/9d1fM5DXQnlR65q+JKPj2NTZb
Received: from ?IPV6:2620:0:1000:8411:cdf4:99a4:cfef:d785? ([2620:0:1000:8411:cdf4:99a4:cfef:d785])
        by smtp.gmail.com with ESMTPSA id du23-20020a056a002b5700b006e053870d46sm2265781pfb.124.2024.02.06.10.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 10:25:34 -0800 (PST)
Message-ID: <abced0b9-5a0c-4627-b53b-10b0a461c564@acm.org>
Date: Tue, 6 Feb 2024 10:25:32 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Restore data lifetime support
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20240202203926.2478590-1-bvanassche@acm.org>
 <20240206-kunden-postfach-7fb32cb79486@brauner>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240206-kunden-postfach-7fb32cb79486@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 05:35, Christian Brauner wrote:
> On Thu, 11 Jan 2024 17:22:40 +1100, David Disseldorp wrote:
>> If initrd_start cpio extraction fails, CONFIG_BLK_DEV_RAM triggers
>> fallback to initrd.image handling via populate_initrd_image().
>> The populate_initrd_image() call follows successful extraction of any
>> built-in cpio archive at __initramfs_start, but currently performs
>> built-in archive extraction a second time.
>>
>> Prior to commit b2a74d5f9d446 ("initramfs: remove clean_rootfs"),
>> the second built-in initramfs unpack call was used to repopulate entries
>> removed by clean_rootfs(), but it's no longer necessary now the contents
>> of the previous extraction are retained.
>>
>> [...]
> 
> I've pulled this in. There was a minor merge-conflict with
> fs/iomap/buffer_write.c that I've resolved. Please double-check that
> it's sane. I'll treat this branch as stable by Friday since I know you
> want to rely on it.

Thanks! The patches on the vfs.rw branch look good to me and pass my regression
tests.

> We can do it right now but I reckon that there might still be an ack or
> two incoming that you wanted.
I'm not sure acks will be incoming despite earlier promises. The following
was promised almost two years ago: "If at some point there's a desire to
actually try and upstream this support, then we'll be happy to review that
patchset." [ ... ] "As I've said multiple times, whenever code is available,
it'll be reviewed and discussed."

Sources:
* https://lore.kernel.org/linux-block/ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk/,
   March 2022.
* https://lore.kernel.org/linux-block/95588225-b2af-72b6-2feb-811a3b346f9f@kernel.dk/,
   March 2022.

Bart.

