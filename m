Return-Path: <linux-fsdevel+bounces-1633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442767DCBD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F089728170D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932031A734;
	Tue, 31 Oct 2023 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKSEaqGa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F19156C1
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 11:31:41 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1158891;
	Tue, 31 Oct 2023 04:31:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce2b6b3cb6so3721170a34.3;
        Tue, 31 Oct 2023 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698751899; x=1699356699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYGDhB/um96+OSL3bdNH6Xb1xNttdqBHEeOQYlAiy+4=;
        b=VKSEaqGanVQNrWpcmf21+Tk4hgKRzDH83SR7GX1RqcbDUxCcW84D6P96siXTiGYQrT
         0eXNjl8CyMqL+TlaO3JRZ9Ajy87IHVAlUHQKKYjC0lJ5r1vtf7Q6JNnMlhMCuYkSZQCH
         yYZjMGtfCBxYnYTxUL/lgFlEUpWNRXDPkZ7b2v5kOJRqngsy0k/oAWaRxN+gZKDvaZDE
         pp0V1oJAt7IiffnbWnpZFLAMm7Z9y4RKaJXguyGCW9R7yYkC/SY8eRqUkHgDfdePXp2w
         je92RUl54APIbkeDwgrR2en5Ge/DmiSq/Z/g7tWSbUZtlEO27sUR+EOvq96LUtPF+ibQ
         9Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751899; x=1699356699;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYGDhB/um96+OSL3bdNH6Xb1xNttdqBHEeOQYlAiy+4=;
        b=NrcK82KUZkYEtgSyKznQrpuJdPNt1wq5Odfj08ZehjOndNKw1baVZrNO3XvNDhyo2X
         +7d4mazDfG1vQFKmFulmjkDJ/gnvV36LMxsxEdGlw4cFXYFCsIA7xFoO5GYQQxWLuV99
         4Sj85gwVJsWaKe5Ycn4mlYwkR4mVAU4z/NdKmYj+RW3TYyNohuMK2utYLIEWG3YXomBl
         Uy+rUherVgf4EksI0pDtr82mKrmedkqMnD3iqig9eUySd7tdjzazn5Khjizl4qUUDYka
         /+FN2YutgSJC/zYPhYrHk+hjB4Y8UWd55DwoNKhUYjcO1pi7ov/zzbE+GuDHvYkVWs8V
         cXFQ==
X-Gm-Message-State: AOJu0YyMc7wQkxNjiQJMFuIPZ/50ahA9+dLQqqG1aQ/BxH23EuQWFJhs
	HjFke5I/hgXGL0NJ3QT4eee5MtHSqsUYNRqhgDc=
X-Google-Smtp-Source: AGHT+IHuYP72qDA7lV1u5U+Et4v2vvDxnY6s+Al6fXDbgkiWs9zjXI2/VLFe0hP5lM6ClxyT2yA6zMq4AXtgvsttkaM=
X-Received: by 2002:a05:6830:1e99:b0:6be:ea3e:367 with SMTP id
 n25-20020a0568301e9900b006beea3e0367mr13025879otr.23.1698751899308; Tue, 31
 Oct 2023 04:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:d1:0:b0:4f0:1250:dd51 with HTTP; Tue, 31 Oct 2023
 04:31:38 -0700 (PDT)
In-Reply-To: <20231031-proviant-anrollen-d2245037ce97@brauner>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev> <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f> <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area> <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
 <ZTYAUyiTYsX43O9F@dread.disaster.area> <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>
 <20231031-proviant-anrollen-d2245037ce97@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 31 Oct 2023 12:31:38 +0100
Message-ID: <CAGudoHEw+JRNB_qfdam2LM-3KLWiQu369ewQFO=hnpQ7qALmbA@mail.gmail.com>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Dave Chinner <dchinner@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, Kent Overstreet <kent.overstreet@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On 10/31/23, Christian Brauner <brauner@kernel.org> wrote:
>> The follow up including a statement about "being arsed" once more was
>> to Christian, not you and was rather "tongue in cheek".
>
> Fyi, I can't be arsed to be talked to like that.
>

Maybe there is a language or cultural barrier at play here and the
above comes off to you as inflammatory.

I assumed the tone here is rather informal. For example here is an
excerpt from your response to me in another thread:
> You're all driving me nuts. ;)

I assumed this was not a serious statement and the "being arsed" thing
was written by me in the same spirit. I find it surprising there is a
strong reaction to it, but I can only explain why.

All that said, I have some patches I intend to submit in the
foreseeable future. I am going to make sure to stick to more
professional tone.

>> Whether the patch is ready for reviews and whatnot is your call to
>> make as the author.
>
> This is basically why that patch never staid in -next. Dave said this
> patch is meaningless without his other patchs and I had no reason to
> doubt that claim nor currently the cycles to benchmark and disprove it.
>

That makes sense, thanks.

-- 
Mateusz Guzik <mjguzik gmail.com>

