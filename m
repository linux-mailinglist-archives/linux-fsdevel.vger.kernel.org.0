Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8436AC31D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393055AbfIFXeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 19:34:13 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46071 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732131AbfIFXeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:34:13 -0400
Received: by mail-ot1-f54.google.com with SMTP id 41so3549600oti.12;
        Fri, 06 Sep 2019 16:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cnDgCASm2QH4ycGwqbjbqLK/pFjSbCSW5+hnSETvzZQ3svKXt4MMkS2aOHtCXavfEF
         nmWlvz4ennEc0f1E7+Pofcalie8pOCdhvsWWlEZ9sOEN33zHsmOkuweNf3jjOGhMmkL/
         pBUVywBy0WNSLQe9scLdyG6dVYVVSVb8I4VqaJ1DlOv9/Tm8ELq64gHLHyg47ONEh+R/
         y0o1NZ0k4aKOPzUvUuf+xRPJYFJFswgyLOs0rl6E4kdmVp3T7xRFpcxpZof8UAJ63c3e
         wjtxd3cQlvS1fqOJMarXox0M/UZvuuwGJtMPMFwEQy9ZEf2zKkszkqAmXUySDmAo95bY
         zBlw==
X-Gm-Message-State: APjAAAWAb+41KqMIGGRUetkedq+k8XXtHHgNjlDcSUx4BiaCDifUrqb6
        JL6e2NByHqrXf5qCZ5GTyvE=
X-Google-Smtp-Source: APXvYqwRA/sTRBH8LKky6oTfHAe/irKHfMvLqzpzDm+MS/dCPKGb5WaN6a5eWl9hHJ4yxsV/ZxcQyQ==
X-Received: by 2002:a9d:4699:: with SMTP id z25mr9739940ote.134.1567812852711;
        Fri, 06 Sep 2019 16:34:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id y6sm2570389oiy.45.2019.09.06.16.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:34:12 -0700 (PDT)
Subject: Re: [PATCH v8 03/13] nvmet: add return value to
 nvmet_add_async_event()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-4-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c9e321d6-8cb8-523e-f951-20a951bb6eed@grimberg.me>
Date:   Fri, 6 Sep 2019 16:34:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-4-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
