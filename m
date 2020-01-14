Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 120FA13A372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 10:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgANJG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 04:06:28 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52010 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgANJG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:06:27 -0500
Received: by mail-wm1-f52.google.com with SMTP id d73so12809812wmd.1;
        Tue, 14 Jan 2020 01:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
        b=JYvbwcqITI2Fi/O7/XR5Eg7hLuVfU7jgKRAuIBFlKGri7qHZRt6EEg1BNJK7X478lS
         zZ6APyXyR8ppnwm/SD2NyUT301ALk3qa4KBjBOYt4PK8/M2iSetbyFAmLmSriygTQzP8
         CP36U4glo1hZo29nvwflxtRxsDH7rND3xnM08QXSiZ6Q+oaYDCkl+rokY02c0o9zfSTo
         Ab2GpcfNtCJXs25Fzl4vEB8++qnQHYohjP4MPlfViQpJ2GC6obbRBaI2lBzElKeC2OrW
         BQjpQaNtBt9dm6lkfzXn9g0TzOTqEI9FrTHjUnjdOAgf5DRCqRaW7LT9/Zw09WTwo4uK
         ZcPQ==
X-Gm-Message-State: APjAAAV6Tp1eunsy/kdTcA5dYTowleD57Cnl5hFLKwz1K9t8HzVH7Q7/
        gpkdKA0QxAowKCDDzqUuZRNB4eLNeLoOyA==
X-Google-Smtp-Source: APXvYqxbFc5DHyDRvrA89uahVdPBWU7IlS2YKQPkBD/KjTRrjfJ3sDiYsXm0oM76GJCd908o8wNDNg==
X-Received: by 2002:a1c:de09:: with SMTP id v9mr25204380wmg.170.1578992785950;
        Tue, 14 Jan 2020 01:06:25 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-194-230.dynamic.mnet-online.de. [46.244.194.230])
        by smtp.gmail.com with ESMTPSA id n10sm18577333wrt.14.2020.01.14.01.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 01:06:25 -0800 (PST)
Subject: Re: [PATCH v6 2/2] zonefs: Add documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20200108083649.450834-1-damien.lemoal@wdc.com>
 <20200108083649.450834-3-damien.lemoal@wdc.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <03bdc3e8-938d-f69d-5782-47e27a59cd1a@kernel.org>
Date:   Tue, 14 Jan 2020 10:06:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108083649.450834-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
