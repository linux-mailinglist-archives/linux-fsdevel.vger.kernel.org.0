Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E927908B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfG2QPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 12:15:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44212 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG2QPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:15:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so28499042pgl.11;
        Mon, 29 Jul 2019 09:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2/uoNs6vHyO3yeTHZpt1irIA1A/s4WXB9GVkMSlWRRE=;
        b=h58UnGsdoWIrRoq/ZAAp4VoChpO8eIQk9rqeN8VPi42Fd7QkGPpt/VMHw02eMUiwLv
         yGPFQ6YZkPFFYZbwRRIsjLyI1AZ7aypNV4E6QzzWNSBT6qb7OjVI0tw3i1dvA1Pd0d1k
         NKnRzHu0va81fzsXhTbKWQWAKKKXEOHFxNTUoLM9NvzpQegQThYFJWmX6FgZyIUEfIXV
         +G7H8nUE3uCsAruKc/B+j2xVloXlQ1wVjQFf6dkP2w3orXZ3R31O1f6HhYpzjsXKhawP
         uymJyvnxMIbaGAsQtnIyXfuhAq95EVVFrncF/cTkIntk6IjDasN4x/kXlHjzS4H5n2sq
         5t2g==
X-Gm-Message-State: APjAAAXHgg5rIvziXlalP272ld/DoNXBLf3auPA45esoY55hHTIEYpgN
        DMsiN6rkEP9isa9VSYwna6EuR6yI
X-Google-Smtp-Source: APXvYqxvmRfMLtWjctTI+NBPENOugc0Re1KJKbTr0Q9VzZj2iX3jBmqvW9TdNQgLxS05uGk+p9MGBQ==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr111210220pjn.136.1564416908477;
        Mon, 29 Jul 2019 09:15:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:68b1:d8a0:b9e3:285e? ([2601:647:4800:973f:68b1:d8a0:b9e3:285e])
        by smtp.gmail.com with ESMTPSA id b36sm93895852pjc.16.2019.07.29.09.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 09:15:07 -0700 (PDT)
Subject: Re: [PATCH v6 00/16] nvmet: add target passthru commands support
To:     Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hannes Reinecke <hare@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <1f202de3-1122-f4a3-debd-0d169f545047@suse.de>
 <8fd8813f-f8e1-2139-13bf-b0635a03bc30@deltatee.com>
 <175fa142-4815-ee48-82a4-18eb411db1ae@grimberg.me>
 <76f617b9-1137-48b6-f10d-bfb1be2301df@deltatee.com>
 <e166c392-1548-f0bb-02bc-ced3dd85f301@grimberg.me>
 <1260e01c-6731-52f7-ae83-0b90e0345c68@deltatee.com>
 <6DF00EEF-5A9D-49C9-A27C-BE34E594D9A9@raithlin.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <322df1b1-dbba-2018-44da-c108336f8d55@grimberg.me>
Date:   Mon, 29 Jul 2019 09:15:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6DF00EEF-5A9D-49C9-A27C-BE34E594D9A9@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> This is different from multipath on say a multi-controller PCI device
>> and trying to expose both those controllers through passthru. this is
>> where the problems we are discussing come up.
> 
> I *think* there is some confusion. I *think* Sagi is talking about network multi-path (i.e. the ability for the host to connect to a controller on the target via two different network paths that fail-over as needed). I *think* Logan is talking about multi-port PCIe NVMe devices that allow namespaces to be accessed via more than one controller over PCIe (dual-port NVMe SSDs being the most obvious example of this today).

Yes, I was referring to fabrics multipathing which is somewhat
orthogonal to the backend pci multipathing (unless I'm missing
something).

>> But it's the multipath through different ports that
>>   seems important for fabrics. ie. If I have a host with a path through
>>   RDMA and a path through TCP they should both work and allow fail over.
> 
> Yes, or even two paths that are both RDMA or both TCP but which take a different path through the network from host to target.
> 
>> Our real-world use case is to support our PCI device which has a bunch
>> of vendor unique commands and isn't likely to support multiple
>> controllers in the foreseeable future.
> 
> I think solving passthru for single-port PCIe controllers would be a good start.

Me too.
