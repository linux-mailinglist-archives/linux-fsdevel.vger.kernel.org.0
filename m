Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF715F9E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgBNWoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 17:44:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52771 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgBNWoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:44:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so11598836wmc.2;
        Fri, 14 Feb 2020 14:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7ou4aOAtQiWLqJ4BD11jAAJu/G6iXaCmGHQ4xMX1mZc=;
        b=EWrkNsNFuBSv2T7Ug3sOFKpxbnEFoWPO4wB1PewNRYvThfXw+P63jriKZc0yFIIpEt
         eeAQMUtyixpe005EKZAJ9sXaZLWSFbEt8DxhLqO9PPEtWmqQEIEeuwOwrbIzseeS4rzz
         fEorloHt+3aLt47aYCKq1fcjVhL1t5vNeIHC//I0oHlyvX92g7wPTAUoFM6bt+UXW4Mc
         rSS3k2gy4AGmTv3dbWbgtwEc7/XyttadMKKpXjr0gAhXQhJbsuWDpsaxJ7ztvfwFzXfC
         FbOCQShWuJk+Z3kZqWjVTOyrYgJCnGeZY1nCHxqtO9rVNVyzxcZGHgMJP4ss8WCM/ySt
         uk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7ou4aOAtQiWLqJ4BD11jAAJu/G6iXaCmGHQ4xMX1mZc=;
        b=aWhBMeQ0xQ9nsVFoL10U5U9BnJc8VBjXuHB+Dih5GSQbMtkHzBm1qD5FEposoctsg6
         /Sv/4aTYOuZ4w6MjnNVR1xR1kGC+3lC+wOQgckiw39ryxWwR7ryY2V5EY3iDDAejvxHJ
         MyYUtnvpFKEyap6JZPHSYx+K8Yy2HFmCLoYfq/Ry7zeNW5eDFd0YhN3AX6PCIrBLxuHQ
         OZncKNsQaHUC0x2I+ZCsuE4jCITfn9AmE9/mE9iM8GzqdZTcE/cFsaMLBgmd01DvCPaP
         Vt09oT5wjHTOM2ifC2WeNI28ukpuoktm6pXJD4XjpsNbR4Y+1GFTl34RSv5Iu1upUZmw
         0Etw==
X-Gm-Message-State: APjAAAWl6qGtM1YMR0NyPxQYgzfOwu3sabGd5+1XlLnSpmZXBezuawEJ
        F6jT51CatVimYl8CPmlErjU=
X-Google-Smtp-Source: APXvYqxuofMzAee/uD415SRlDInENfVScPrDk1BAWi9A+092bRg0tqff+ZLt5NEMkOGe5ol6SbOyMw==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr7026842wmk.85.1581720239259;
        Fri, 14 Feb 2020 14:43:59 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q10sm9192364wme.16.2020.02.14.14.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:43:58 -0800 (PST)
Date:   Fri, 14 Feb 2020 23:43:57 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20200214224357.yv2lwyusi3gwolp3@pali>
References: <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
 <20191016203317.GU31224@sasha-vm>
 <20191017075008.2uqgdimo3hrktj3i@pali>
 <20200213000656.hx5wdofkcpg7aoyo@pali>
 <20200213211847.GA1734@sasha-vm>
 <86151.1581718578@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86151.1581718578@turing-police>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 14 February 2020 17:16:18 Valdis Klētnieks wrote:
> On Thu, 13 Feb 2020 16:18:47 -0500, Sasha Levin said:
> 
> > >> I was hoping that it would be possible to easily use secondary FAT table
> > >> (from TexFAT extension) for redundancy without need to implement full
> > >> TexFAT, which could be also backward compatible with systems which do
> > >> not implement TexFAT extension at all. Similarly like using FAT32 disk
> > >> with two FAT tables is possible also on system which use first FAT
> > >> table.
> 
> OK.. maybe I'm not sufficiently caffeinated, but how do you use 2 FAT tables on
> a physical device and expect it to work properly on a system that uses just the
> first FAT table, if the device is set to "use second table" when you mount it?
> That sounds just too much like the failure modes of running fsck on a mounted
> filesystem....

Idea is simple. Expects that we have a clean filesystem in correct
state. We load primary/active/main FAT table (just call it FAT1) and all
changes to filesystem would be done via second non-active FAT table
(FAT2). At unmount or sync or flush buffer times, FAT2 would be copied
back to the FAT1 and filesystem would be back in clean state.

So this should not break support for implementations which use just
FAT1. And if above implementation which use both FAT1 and FAT2 "crash"
during write operations to FAT2 it may be possible to reconstruct and
repair some parts of filesystem from FAT1 (as it would contain previous
state of some filesystem parts).

Via dirty bit can be detected if proper unmount occurred or not, and
fsck implementation could do use this fact and try to do repairing
(possible by asking user what should do).

Of course if implementation use only FAT1 we cannot use FAT2 for
repairing and therefore fsck should really ask user if it should use
FAT2 for repair or not.

If implementation use only FAT1, does not crash and let filesystem in
clean/correct state then there should not be any problem for
implementation which can use both FATs as it reads main state from FAT1.
Therefore these two implementations should be compatible and problem can
happen only if they let filesystem in inconsistent state. (But if they
let it in inconsistent state, then any implementation may have troubles
and fsck is needed).

I hope that it is more clear now...

> > >By the chance, is there any possibility to release TexFAT specification?
> > >Usage of more FAT tables (even for Linux) could help with data recovery.
> >
> > This would be a major pain in the arse to pull off (even more that
> > releasing exFAT itself) because TexFAT is effectively dead and no one
> > here cares about it. It's not even the case that there are devices which
> > are now left unsupported, the whole TexFAT scheme is just dead and gone.
> >
> > Could I point you to the TexFAT patent instead
> > (https://patents.google.com/patent/US7613738B2/en)? It describes well
> > how TexFAT used to work.
> 
> I don't think anybody wants the full TexFAT support - but having a backup copy
> of the FAT would be nice in some circumstances.

Main problem is that we do not know what "full TexFAT support" means as
currently it is secret.

My original question for TexFAT was also because of NumberOfFats set to
2 is according to released exFAT specification possible only for TexFAT
volumes.

And from reading whole exFAT specification I see that better data
recovery can be achieved only by having backup copy of FAT table (and
allocation bitmap), which is limited to (currently undocumented) TexFAT
extension.

-- 
Pali Rohár
pali.rohar@gmail.com
