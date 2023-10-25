Return-Path: <linux-fsdevel+bounces-1138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567377D669D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC81C20D46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F5A20B22;
	Wed, 25 Oct 2023 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IcaldLvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E55B2D60E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 09:20:05 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6ADDE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 02:20:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4097398a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698225603; x=1698830403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9LKvzwQ+kJJuy6F8sbzPBJK3ry5j/OSwVPg23+fo4o=;
        b=IcaldLvkVDGaOtNo/OYfg/78rpVL13J0ZcBeqYR3u1G79aRK+Uz5lmZnkHlh8HTu5F
         VYHVsdfFgBgz4hId659tyYcoH3O+OcFY/ED3l6DVWi1WcrabgUeHxD5Az8CfPpTtL+zG
         ZM3DoH5Rqq5ZteqVIXDav6hKsXmukSywzs08TRulWaTbHcR2ooLewjkzU6lb3qUrTw7R
         7m9WfdvYZjuzSUBez4oSk1t9wnTKwp90SehOccwcYdI/Vjy9S23CJH7QXIT9JPz9Ccni
         hOOmjfna4RJjHZSKkYYCHwrHGm8kBzYeHpHJD+rJyDJsOOw5aFS7sdipn7Mde9ptP6UV
         d1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698225603; x=1698830403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k9LKvzwQ+kJJuy6F8sbzPBJK3ry5j/OSwVPg23+fo4o=;
        b=FBJeZ2WEFHZ12mIVujKxTx3NPq4qAGlVmNAoHHuSBoywSd+7jK2jINrSgNeKFs+x7l
         QIlvtWRBzwLxO4U1kKdcuhmZKtDlAVEKIItCYj7+6OL9/x6FuUAvmfANSy50I1XLOhMs
         6QehxtVmYshdRzNzn0KFJEIunsrCKCcZlUFYPjvyh2CIlecnpzuG8vbMnuLeJsWZUU8L
         1mkhCLO7CP74XPmMqOPz32TMyObqEAO2NrD8BwxJbCLmcquLu1IZbP93rmDOsGg+x/4A
         D8Lp7IsuA4c5rlMz42bsBRz0v83/OTprRnra6J2UdlnscgNAWkcjdfhJGhHRrJXJmNhR
         SrXA==
X-Gm-Message-State: AOJu0YyzLtH+9pYrJb2YjXRl9NDbgOY8fG70GcRzUef5hfJZkkTXFo5a
	fNjXjvqy70mjUx2yKMkky7qijA==
X-Google-Smtp-Source: AGHT+IHfihGh9DaKro3ttnwboXUO0qkrr6LAJueCDPbd8CHiqmm6Eh/dzGrB6zYpq63P8X2rWNeq6A==
X-Received: by 2002:a17:90a:d24d:b0:274:c284:c83c with SMTP id o13-20020a17090ad24d00b00274c284c83cmr13222743pjw.48.1698225603087;
        Wed, 25 Oct 2023 02:20:03 -0700 (PDT)
Received: from [10.71.178.184] ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a498c00b00278ff752eacsm8133414pjh.50.2023.10.25.02.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 02:20:02 -0700 (PDT)
Message-ID: <bf7d4005-d32c-42d9-a748-a7c421130be6@bytedance.com>
Date: Wed, 25 Oct 2023 17:19:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
To: Matthew Wilcox <willy@infradead.org>
Cc: Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
 brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
 mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
 peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
 maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Peng Zhang <zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
 <20231024083258.65750-4-zhangpeng.00@bytedance.com>
 <ZTfw1nw15wijNnCB@casper.infradead.org>
From: Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <ZTfw1nw15wijNnCB@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/10/25 00:29, Matthew Wilcox 写道:
> On Tue, Oct 24, 2023 at 04:32:51PM +0800, Peng Zhang wrote:
>> +++ b/lib/maple_tree.c
>> @@ -4,6 +4,10 @@
>>    * Copyright (c) 2018-2022 Oracle Corporation
>>    * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
>>    *	    Matthew Wilcox <willy@infradead.org>
>> + *
>> + * Implementation of algorithm for duplicating Maple Tree
> 
> I thought you agreed that line made no sense, and you were just going to
> drop it?  just add your copyright, right under ours.
I'm sorry, I misunderstood your meaning last time. I will make
corrections in the next version. Are you saying that only the
following two lines are needed? This still needs to be confirmed
with Liam.
> 
>> + * Copyright (c) 2023 ByteDance
>> + * Author: Peng Zhang <zhangpeng.00@bytedance.com>
> 

