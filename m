Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA313A361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 10:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgANJFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 04:05:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33740 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANJFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:05:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id d139so1790478wmd.0;
        Tue, 14 Jan 2020 01:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
        b=jT2pbQYlBxbSSWB3OgGJslJsDx53KYYeq5/y/xT6AdHZcpVrBqQ/LBlF798yQVKCt4
         p6NcCaJa3yRmid76phu8WlvsR6MjRXcwwT17zTgo/+mswiFk679hKBhI+E1grtWXCqKz
         yi0TVg7EG2cDpuCK7YzAiAo3mxFT5zOcSsTeGJEfFHg7loA9X+FgwEi8LnLNfA0qaMpp
         2s8xGm+6/ZSMl9fTS9ArN86SEX83fQWbOQPtJHxZEz3DphrMGAhilxUO/wAOA2skHS30
         fn0gEEgm10O5ByNPJ57x3c2Ncm/LnXXm1vNhRZyCP85l8oKwjhFr2Mo9HdVXsk/uVyTj
         K84A==
X-Gm-Message-State: APjAAAVOjwbjpHvS/FSZNDi8R5umWwGxwHTk8MA0Y6HHL9wLRfnOFNaU
        EYGmgGrZD9fBLZsv4yf7LpA=
X-Google-Smtp-Source: APXvYqz4KyHtGND35ojY/631vDAbMq1Lwj5GsUP02LOCP2QEkZChrQmK2l70WkoV6DFuurTtP9+vng==
X-Received: by 2002:a1c:6404:: with SMTP id y4mr25656220wmb.143.1578992702060;
        Tue, 14 Jan 2020 01:05:02 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-194-230.dynamic.mnet-online.de. [46.244.194.230])
        by smtp.gmail.com with ESMTPSA id r68sm17701861wmr.43.2020.01.14.01.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 01:05:01 -0800 (PST)
Subject: Re: [PATCH v6 1/2] fs: New zonefs file system
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20200108083649.450834-1-damien.lemoal@wdc.com>
 <20200108083649.450834-2-damien.lemoal@wdc.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <aaacd8bc-8d91-0602-7571-355406fb3812@kernel.org>
Date:   Tue, 14 Jan 2020 10:04:59 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108083649.450834-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
