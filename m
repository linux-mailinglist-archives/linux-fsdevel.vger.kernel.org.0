Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE217F98
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 20:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEHSMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 14:12:21 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34340 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEHSMV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 14:12:21 -0400
Received: by mail-qt1-f173.google.com with SMTP id j6so24342747qtq.1;
        Wed, 08 May 2019 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3EtBSWKXvWhK5ahRNqbD9aitgAQyO29KGemVXp7iPbI=;
        b=p0zgYRavLfnFw6tzfy5RxlKX+Yaq4nP5orA7fNJUfhm/WwQk9NPg0U19DrwONAJZiD
         5zjay4uKP5n4jLY/lvGu4OaU8DB5+H39KVI8kq2rdgEVdXqbLHkkmJO47BnFCcIfQB4g
         vFtfHGktCXBuZ6KyCOuOQE8EASJnmCIvVsmsFNzte4Dm3e0Q6XqBeBCi/OmkwPXxzq0v
         X3C0FlDW+rxGTqg1fuWwY0Ncaf4ZGYpEcFZUT/WE9YLXSDaJdC8Dg8VBOah9yEnmvE+Q
         t/IIgk+HQRstPF/Wizgm7lpY0JNvzavtyF2FGNCgEgVU6NzC7d67GLUTbdyXu67LbZZv
         Y7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3EtBSWKXvWhK5ahRNqbD9aitgAQyO29KGemVXp7iPbI=;
        b=Otr/t0H5J4fDi3J0g4H70qDDipbhwDzBfSHLzJ2iQ9l+hI+ZDb0opfqJ/xpvpOljdN
         gyTvufFxA5SAAKmq7VCN0xmCJySdVJxTLGv6ih8r44U08XUxo6CAGB/KG/iUweNEFf8Y
         yEExZeyV24YmzPBW1w2zrTQlY5uOCRrMgx2abJa5TsfcBLchDY6HYpTlzLacBvNy6hi6
         sWOw2LuhF2icr5exy4Tfk6X4XpOD6YovIu53bYl3sx+++JAx4OffB1RJMsjLU+MbmV8I
         07uvyAWiYn8uGPocFew5YRr8rCgjkBkG0yAIRrbBYAEeLCMan98iyJWLF/VQLcxuVNSR
         sQvQ==
X-Gm-Message-State: APjAAAWI0lfu8S95j//gZBbuWjZKacADDdlM/wg0qU4713Rq4ktEmRoO
        7yA3tHPxDkJcLpI/HYohy9nby9OgdI8=
X-Google-Smtp-Source: APXvYqyoob7gPuJlyn5s8stW5f2v6LO1MyR170RnlDAEDFVoylkYDdtKbUfyxATBcAnb7o/wAAm4qw==
X-Received: by 2002:ad4:51c2:: with SMTP id p2mr15308535qvq.64.1557339140076;
        Wed, 08 May 2019 11:12:20 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id r47sm8814874qte.70.2019.05.08.11.12.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:12:19 -0700 (PDT)
From:   Ric Wheeler <ricwheeler@gmail.com>
Subject: Re: Testing devices for discard support properly
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        lczerner@redhat.com
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area>
 <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
 <20190508011407.GQ1454@dread.disaster.area>
 <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com> <yq1a7fwlvzb.fsf@oracle.com>
 <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com> <yq15zqkluyl.fsf@oracle.com>
Message-ID: <99144ff8-4f2c-487d-a366-6294f87beb58@gmail.com>
Date:   Wed, 8 May 2019 14:12:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq15zqkluyl.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(stripped out the html junk, resending)

On 5/8/19 1:25 PM, Martin K. Petersen wrote:
>>> WRITE SAME also has an ANCHOR flag which provides a use case we
>>> currently don't have fallocate plumbing for: Allocating blocks without
>>> caring about their contents. I.e. the blocks described by the I/O are
>>> locked down to prevent ENOSPC for future writes.
>> Thanks for that detail! Sounds like ANCHOR in this case exposes
>> whatever data is there (similar I suppose to normal block device
>> behavior without discard for unused space)? Seems like it would be
>> useful for virtually provisioned devices (enterprise arrays or
>> something like dm-thin targets) more than normal SSD's?
> It is typically used to pin down important areas to ensure one doesn't
> get ENOSPC when writing journal or metadata. However, these are
> typically the areas that we deliberately zero to ensure predictable
> results. So I think the only case where anchoring makes much sense is on
> devices that do zero detection and thus wouldn't actually provision N
> blocks full of zeroes.

This behavior at the block layer might also be interesting for something 
like the VDO device (compression/dedup make it near impossible to 
predict how much space is really there since it is content specific). 
Might be useful as a way to hint to VDO about how to give users a 
promise of "at least this much" space? If the content is good for 
compression or dedup, you would get more, but never see less.

Ric


