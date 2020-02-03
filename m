Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77C150927
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgBCPIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 10:08:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37532 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgBCPIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:08:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so17581597wmf.2;
        Mon, 03 Feb 2020 07:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Nb7hvXDQ9+r6z44arPAgwdnw9IiSRV2K+tFdLqVRakA=;
        b=MF++XBr92Yr19bG7DSMQJUnoADavhB7dLauTWwsd0nHeKBIHT9gBa2Zc2GDhbg2pi1
         JGd1u9Y4SZErjzXB6Vi3tSO8dLpfEqMuzylj0d1YHZRc4zzbxf9Mqx6wY/RtbQ412Wlu
         IJr7Rd4gKFxHAjmy+lz4DIkpLSkJuWmrI3ACkBraFRmqSd2nsSIFslmFUSO8mhkGQPhk
         BQ40XHAIcGTd8Pn/gjbq1JOv8NDNP151kifq7QHpbGzEVnI675Jit0HRQbB4FbiOLj+q
         kPtLdNCz1LHeHbYyZ/z8HGZEn0CKlVa5TjbvC6l9MJGC4gA6ZRGDzwFquQEKzJCi45Es
         ulNQ==
X-Gm-Message-State: APjAAAXsCHnVbCxr17/EZ2mWHkxWykOJ/RkszNUHWAgM/Sr7OcFkXrMM
        zqWgS17olBG0Xx8pwf2tN7YFO19rr1rKcA==
X-Google-Smtp-Source: APXvYqwRTWwdE7Z935cUy0RmDlJnjoUb2bB6WgF+R57y6KHiLfJeX6QYdxltCaSCIIybDdazeKqtDg==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr31061809wmc.9.1580742520124;
        Mon, 03 Feb 2020 07:08:40 -0800 (PST)
Received: from Johanness-MBP.fritz.box (ppp-46-244-208-208.dynamic.mnet-online.de. [46.244.208.208])
        by smtp.gmail.com with ESMTPSA id u8sm23826007wmm.15.2020.02.03.07.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 07:08:39 -0800 (PST)
Subject: Re: [PATCH v10 1/2] fs: New zonefs file system
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20200129131118.998939-1-damien.lemoal@wdc.com>
 <20200129131118.998939-2-damien.lemoal@wdc.com>
From:   Johannes Thumshirn <jth@kernel.org>
Message-ID: <bd8f0172-7843-b08f-10eb-399e9fd5ecf9@kernel.org>
Date:   Mon, 3 Feb 2020 16:08:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129131118.998939-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jth@kernel.org>
