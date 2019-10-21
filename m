Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9BDEA8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfJULOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 07:14:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36779 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfJULOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:14:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so12925954wrt.3;
        Mon, 21 Oct 2019 04:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mgMbcoY2iJpVOplEPrT2MAbeo48JMxLYHTj4MqCq1qU=;
        b=mwRpOH0wPwi/KPQsvXwxRbqS1VxWAgQjGku2mndAPqtu3tybu089S4li4nIA/cW2/l
         FteZ3XVt/o7b4jPcCB1oD8Tpt8jJmQag81MZjpH7+hEe/qF+N4TbtG6KY28nYaos3nCJ
         YmYUMPZPjlanRzT3IeLwYXYnz9aKGHcMGeuv3pAiOPx5xR09pU7I+duC7EC329TLb7mn
         1X6AfShTT4tyf0AocysLbS0RGJhQc4TRjL5NAOQaVYzDE/HRlvj9u72BC8xoIU/ESuMe
         PN+Nc+40EpBEJ4Ix5EeJUjEKGSSgLtY2rgHqPD2WVWOuPvbrAwqajAyZf2BQS6M/RgJg
         QpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mgMbcoY2iJpVOplEPrT2MAbeo48JMxLYHTj4MqCq1qU=;
        b=MqdoP1AHHbo3aVhmrks88WbHk3y7qD0Z7wSgDkhvx/liRulxXMkVN5iDXFn0JdyJyf
         e2GPQTKRCEzdSCrK847FoTK8psG8ru3Z1uDEIle1/8vUvBVht9nozEjMqoU+sgQNU+CF
         zf754uDHkE1swi6SWKbtJVwJIU56crwp5vOPr8XK8fvPt9ntd3Xdm8uPdXYetggOg/SO
         JTIcFJbF1aeOk6kY4I6koLyommsu7Hl56VmwG0IEFls8PH1v7ikDr1lfGQdPwA8k/QOo
         Am9UYP/BO26fyeGHrplePR1a0M8IocfoyHOdbGDckEs4xsrKwQICh8jZ14odi6/Mrtqr
         ljPQ==
X-Gm-Message-State: APjAAAVtucldr8V2tdpVhFcgwy7hRyBgBdqxtcipf5wL+cDwlfWOEJmE
        gfw4dFPJxPsezlEkN1qWDcc=
X-Google-Smtp-Source: APXvYqyKIYzVt9zufcyDAbXaDTwRCVxSvQ9LRWwDB4vGDpkV9mhHj3MLLzQFKqp+IGJrwRVwzBQACA==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr20268874wrq.35.1571656438614;
        Mon, 21 Oct 2019 04:13:58 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v10sm10901208wmg.48.2019.10.21.04.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 04:13:57 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:13:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
Message-ID: <20191021111357.q2lg2g43y7hrddqi@pali>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
 <CAFLxGvyFBGiDab4wxWidjRyDgWkHVfigVsHiRDB4swpB3G+hvQ@mail.gmail.com>
 <20191021105409.32okvzbslxmcjdze@pali>
 <0877502e-8369-9cfd-36e8-5a4798260cd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0877502e-8369-9cfd-36e8-5a4798260cd4@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 21 October 2019 13:08:07 Maurizio Lombardi wrote:
> Dne 21.10.2019 v 12:54 Pali Rohár napsal(a):
> > Plus there is new version of
> > this out-of-tree Samsung's exfat driver called sdfat which can be found
> > in some Android phones. 
> 
> [...]
> 
> > 
> > About that one implementation from Samsung, which was recently merged
> > into staging tree, more people wrote that code is in horrible state and
> > probably it should not have been merged. That implementation has
> > all-one-one driver FAT12, FAT16, FAT32 and exFAT which basically
> > duplicate current kernel fs/fat code.
> > 
> > Quick look at this Konstantin's patch, it looks like that code is not in
> > such bad state as staging one. It has only exFAT support (no FAT32) but
> > there is no write support (yet).
> 
> But, AFAIK, Samsung is preparing a patch that will replace the current
> staging driver with their newer sdfat driver that also has write support.
> 
> https://marc.info/?l=linux-fsdevel&m=156985252507812&w=2

Maurizio, thank you for reference! I have not caught this Samsung
activity yet! So we now we have +1 for count of exFAT drivers.

-- 
Pali Rohár
pali.rohar@gmail.com
