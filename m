Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64455ACB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfF2RXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jun 2019 13:23:24 -0400
Received: from lkcl.net ([217.147.94.29]:42415 "EHLO lkcl.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfF2RXY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jun 2019 13:23:24 -0400
X-Greylist: delayed 2287 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jun 2019 13:23:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lkcl.net; s=201607131;
        h=Content-Type:Cc:To:Subject:Message-ID:Date:From:MIME-Version; bh=s/sTi+hASQyPaQRLVOOh9ET0ya6bVtdjcUHl64yNEJw=;
        b=RKPqwaFSFIFMxHCBw4GHqMY/1g7FEz7d0qo3eSy8ZtoC7DxmMt9BSLvCKb5oZ9PmwTer3bGW1sgc1Yo+fJXcBI3Q4RSrGfZqhPAF4G0BKV3t6bwaoktseUAjQmbGjVlLm2BGnRSsPcHX9jwNWu4IPsi9pxRRoghqesCT8zjPfkI=;
Received: from mail-lj1-f176.google.com ([209.85.208.176])
        by lkcl.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lkcl@lkcl.net>)
        id 1hhGTS-0008P0-Rf; Sat, 29 Jun 2019 16:45:14 +0000
Received: by mail-lj1-f176.google.com with SMTP id t28so8909104lje.9;
        Sat, 29 Jun 2019 09:44:59 -0700 (PDT)
X-Gm-Message-State: APjAAAXeYxu9TidZ+kwM0+MFIZCL45e0dxzD9Jul0xAThrxOt+UTUiD6
        D82ieLKUDH2aL1MtJeSx2+FeZEFPsrSK6HnZLHs=
X-Google-Smtp-Source: APXvYqyT3rBGT+21WQD3pj3PIsLlCJsWc/KxmRIzx71GAXDRlfDfgfqr73eWhFqOZ/B2TWPMlCqEQW13yM2ujHPob5E=
X-Received: by 2002:a2e:94cb:: with SMTP id r11mr8821456ljh.212.1561826376022;
 Sat, 29 Jun 2019 09:39:36 -0700 (PDT)
MIME-Version: 1.0
From:   Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Date:   Sat, 29 Jun 2019 17:39:24 +0100
X-Gmail-Original-Message-ID: <CAPweEDxufL1SHCh2ao7600fF9+aciMhr2V_5vxQN6S8r=u2W4g@mail.gmail.com>
Message-ID: <CAPweEDxufL1SHCh2ao7600fF9+aciMhr2V_5vxQN6S8r=u2W4g@mail.gmail.com>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker merged)
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, axboe@kernel.dk,
        darrick.wong@oracle.com, david@fromorbit.com, dchinner@redhat.com,
        josef@toxicpanda.com, kent.overstreet@gmail.com,
        linux-bcache@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        viro@zeniv.linux.org.uk, zach.brown@ni.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hey linus, you made news again, all blown up and pointless again.
you're doing great: you're being honest. remember the offer i made to
put you in touch with my friend.

anecdotal story: andrew tridgell worked on the fujitsu sparc
supercomputer a couple decades ago: it had a really weird DMA ring
bus.

* memory-to-memory copy (in the same core) was 10mbytes/sec
* DMA memory-to-memory copy (in the same core) was 20mbytes/sec
* memory-memory copy (across the ring bus i.e. to another machine) was
100mbytes/sec
* DMA memory-memory copy (across the ring bus) was *200* mbytes/sec.

when andrew tried asking people, "hey everyone, we need a filesystem
that can work really well on this fast parallel system", he had to
continuously fend off "i got a great idea for in-core memory-to-memory
cacheing!!!!" suggestions, because they *just would never work*.

the point being: caches aren't always "fast".

/salutes.

l.
