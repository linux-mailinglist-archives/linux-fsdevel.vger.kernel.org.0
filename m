Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD01F66A91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 12:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfGLKC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 06:02:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52132 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfGLKC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:02:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so8348453wma.1;
        Fri, 12 Jul 2019 03:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=PVznxIgOJnlqE5rODHHWrAxuxQ+5+E+kFPlhzOL7qDQ=;
        b=R5+1/qjJl+3YpWHEZkTpsk6puFGtmsVkY5J/NsogQ9vzS73dYa5eMD1VPNun0oQVxB
         DMQdhzY+mxoY5oUQEf1795qpNPPNrcmNJjtqBM9zhDfBx5g5lbHkastxQUmnrJHEtB+Z
         Epalw+tOcRhh4Wx3blUcayWABvfKFmyXJi+8HThkOiCIEF5nSQI1NJQNpjCXtok4Bbc/
         5eQ4F2viDXDKsciFyVWNrHJ8GtGdVzYN4wnp3Q3pnEsxirfMhSuzV/kHlT/dzV1OX7DY
         ezPW2OvCzNCZmdvMGPiIjEf6loEEs1LkZdSCna6xvTZ63rSWAoxgWBmMdNR+1EEBSWcn
         ToSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=PVznxIgOJnlqE5rODHHWrAxuxQ+5+E+kFPlhzOL7qDQ=;
        b=ftxuXImbxRhv869ishbDFz2fLr9OgEA4kBSupIuzw3zQrta5OAIiYWXaDpD3c/Y8TS
         dNqTqAhLpVK+3YdNAlnyxMbXhI8Yzw+4q3q/delHmU+NeFstuczijms5OSPvYAyE4Mnj
         aCc7nslN37Obg+5F+xEEv22Y9EFs6k3XAiyYQi+oJKWoKZouZylAxCfp315Cx8SmhnTQ
         rt2ouBfcZPHRT3aOHPm0pgO1FVRL0jtnwVhKSUPTO4llkreHYhrGI4u4kJAfmjGMh1qH
         UPLJBECkBS0ICb70QaPVUpB2WDvVBImSKTAFYpGZs/fzR9B9QENHBXkbOVJYbn+267UA
         lg0g==
X-Gm-Message-State: APjAAAXD52jen4YI5eflc4/BzkwNQZfzc5ZTuWN83cDsScEWNzra37AX
        Nod1Ul6coQFXo+njNhx6k48=
X-Google-Smtp-Source: APXvYqwVkDbIqxSOP3zyc1XG88KVHvtUgjV3NOM+MrukPDAWPxbvgfn0l1J6GpoxNmOM+sWy/8SFMQ==
X-Received: by 2002:a05:600c:20ca:: with SMTP id y10mr8792513wmm.72.1562925746299;
        Fri, 12 Jul 2019 03:02:26 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i13sm8047696wrr.73.2019.07.12.03.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 03:02:25 -0700 (PDT)
Date:   Fri, 12 Jul 2019 12:02:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.com>,
        "Steven J. Magnani" <steve.magnani@digidescorp.com>,
        Roald Strauss <mr_lou@dewfall.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: UDF filesystem image with Write-Once UDF Access Type
Message-ID: <20190712100224.s2chparxszlbnill@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I had discussion with Roald and based on his tests, Linux kernel udf.ko
driver mounts UDF filesystem image with Write-Once UDF Access Type as
normal read/write filesystem.

I think this is a bug as Write-Once Access Type is defined that existing
blocks on filesystem cannot be rewritten. Only new blocks can be
appended after end of device. Basically it means special HW support from
underlying media, e.g. for optical medias packet-writing technique (or
ability to burn new session) and CDROM_LAST_WRITTEN ioctl to locate
"current" end of device.

In my opinion without support for additional layer, kernel should treat
UDF Write-Once Access Type as read-only mount for userspace. And not
classic read/write mount.

If you want to play with Write-Once Access Type, use recent version of
mkudffs and choose --media-type=cdr option, which generates UDF
filesystem suitable for CD-R (Write-Once Access Type with VAT and other
UDF options according to UDF specification).

Also in git master of udftools has mkduffs now new option --read-only
which creates UDF image with Read-Only Access Type.

It seems that udf.ko does not support updating VAT table, so probably it
should treat also filesystem with VAT as read-only too.

-- 
Pali Rohár
pali.rohar@gmail.com
