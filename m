Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A776BAC343
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 01:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405316AbfIFXjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 19:39:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33409 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393187AbfIFXjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:39:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id g25so6106815otl.0;
        Fri, 06 Sep 2019 16:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdAQxtehqqIstpzaxZGNLX/2x6fViaxGv6dGKoG4FqE=;
        b=Q7iHA8FdMFSyB6AIBx/qOPW5Qz4JlsHz1YST1l0z6q0aS7pEBzjaCty/cpNxEdea3F
         0rEu6Z8eK2naadqtcWTFdCjrhCYMGd19c8QBqdouznXw3DZ2fJei8ywglncljCJFdho3
         eLrndLmuJVMdUZfoh/tdkzLuPIDmPVrzr+UIA8lzsDBQEpaD4N9ArXaZllmTw0VW5h26
         OT250HTDNeMtyJqN7YwaxFrhYDZNp3G6a1uqk5riQDMHfzf0jvyjSgAoK3gga/Jscv32
         C5AVFrS0rmE+gKJChKEaD7XsvRBmeAAY+fSgEP7y59+D1wo9Fm4CKo3tDO1DzAHBmQbF
         GIKQ==
X-Gm-Message-State: APjAAAW0tNTa5q7e+J8KNbw8YtE2nZ6j67wWkAsG2Ovn0kPENm3B3wCi
        HeU9x2rK8eiEf+kdSuVfnIM=
X-Google-Smtp-Source: APXvYqxmJXOqP4WdQZNRWAH817fLo9Efmn3OiH4QFJ6y1IufYKxK2MbjMXyiFWjvqTumoNuTexQ3ag==
X-Received: by 2002:a9d:5c13:: with SMTP id o19mr9494233otk.80.1567813141623;
        Fri, 06 Sep 2019 16:39:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id h4sm2260986oie.18.2019.09.06.16.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:39:00 -0700 (PDT)
Subject: Re: [PATCH v8 08/13] nvmet-core: don't check the data len for pt-ctrl
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-9-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <46920cc3-b703-134f-7a1e-f212a0ae05e7@grimberg.me>
Date:   Fri, 6 Sep 2019 16:38:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes sense to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
