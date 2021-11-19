Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E245707A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 15:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhKSOWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 09:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhKSOWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:22:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D2FC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 06:19:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w29so18397860wra.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CcexMjZBNLCEwb0isvMRBl9q6LjY9wKO6CSmQ4SxqKs=;
        b=GSsT3LJ+VfwVLEkUAJ3qQq4FADKWRSDFklZAp0yWg2NNMGyGvPr1C9+40upDU7iUXB
         72UbR7LMKFxCNerQVP8K8NMSsBEJI9h7GsO4zj3+WSafi7hEr0IrQZdIiw5cmSfFJZu1
         7g7vX94n43eG47tY+0VykjPWLFzvy1oqNp9w+0D/d//nVhOnZfw0rDYjKQb3XqmsFoNV
         du3hQo63b+kAFBWG4KDuEPvy7uFentDQT/6D1up5Tc923gJSeomNmM+BxCLiXTc2S6DA
         ydb0VIEn2oliCcTSzySpBpL7E+YVS8TqJ5OwnAYlPuR+DSZF9W3uc1uVXhhhKgJGYaaB
         YClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CcexMjZBNLCEwb0isvMRBl9q6LjY9wKO6CSmQ4SxqKs=;
        b=SHfqldMG6dm/vuvIms97peyYnrs4OK43a4JAtOOAai5XRa9lG86AsiaoNbIzA89bCw
         eBkeDyNzGz1rmf8B05w4rdlJB2Ri4SaJhFPiIHzsgNe95rQLEP8VVRe/UVk3hOc1mb6l
         dc5vnWqgIN5/PV058RlkjgAeJHs4sSSp3Q7RCNNEalzJdlJgh7kf89aDwNuxwq+R8jNv
         fXXeboSfZPjjr/gsUeTqiCmBARkDl0Xm9AoXN9E0nm7IR40BpoE7GOILt+M3w+3VLcUl
         bGnYXbyWSxTmtPfInSkSE/NJrbDlvcWrTbyY6mR/a9WraczBJKeCYC4Xqv5jJVI4HYzw
         DiLQ==
X-Gm-Message-State: AOAM532d/Nma+uq+xZwAlFD+kLJGiFcGT6t7txQo/fj3rGGQT2oGxJpP
        oWpfWNvvoFAiPtbhXI23wDo=
X-Google-Smtp-Source: ABdhPJzpuUEXW+pjwKeq+mxHngWCA4ASsBXWhd0rHOfoPKCoXSFm37D7Ea0GCxP1u6e4nMn8XOvFaA==
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr7773017wry.306.1637331571339;
        Fri, 19 Nov 2021 06:19:31 -0800 (PST)
Received: from ?IPV6:2a02:8070:a2a8:1a00:815a:3ed0:1912:b9b7? ([2a02:8070:a2a8:1a00:815a:3ed0:1912:b9b7])
        by smtp.googlemail.com with ESMTPSA id f15sm3918494wmg.30.2021.11.19.06.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 06:19:30 -0800 (PST)
Message-ID: <b708eff4-4e2f-42a9-c2b2-22522f72ebe0@gmail.com>
Date:   Fri, 19 Nov 2021 15:19:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Reply-To: uwe.sauter.de@gmail.com
Subject: Re: Bug using new ntfs3 file system driver (5.15.2 on Arch Linux)
Content-Language: de-DE
To:     Matthew Wilcox <willy@infradead.org>
Cc:     almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <aea2a926-8ce6-fcb0-cd60-03202c30cca1@gmail.com>
 <YZei4gn1zgIc32Ii@casper.infradead.org>
From:   Uwe Sauter <uwe.sauter.de@gmail.com>
In-Reply-To: <YZei4gn1zgIc32Ii@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Am 19.11.21 um 14:13 schrieb Matthew Wilcox:
> On Fri, Nov 19, 2021 at 08:48:11AM +0100, Uwe Sauter wrote:
>> [ 1132.645038] BUG: unable to handle page fault for address: 0000000000400000
>> [ 1132.645045] #PF: supervisor instruction fetch in kernel mode
>> [ 1132.645047] #PF: error_code(0x0010) - not-present page
>> [ 1132.645050] PGD 0 P4D 0
>> [ 1132.645053] Oops: 0010 [#1] PREEMPT SMP PTI
>> [ 1132.645057] CPU: 7 PID: 429941 Comm: rsync Tainted: P           OE
>> 5.15.2-arch1-1 #1 e3bfbeb633edc604ba956e06f24d5659e31c294f
>> [ 1132.645061] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./C226 WS, BIOS P3.40 06/25/2018
>> [ 1132.645063] RIP: 0010:0x400000
> 
> Your computer was trying to execute instructions at 0x400000.  This
> smells very much like a single bit flip; ie there was a function
> pointer which should have been NULL, but actually had one bit flip
> and so the CPU jumped to somewhere that doesn't have any memory
> backing it.
> 
> Can you run memtest86, or whatever the current flavour of memory testing
> software is?
> 

As I mentioned in the description the host is equipped with ECC memory. dmesg didn't show any sign of memory error that 
I would expect from a bit flip inside RAM.

The hardware is
* ASRock Rack C226 WS mainboard
* Intel Xeon E3-1245 v3
* 4x Kingston 9965525-055.A00LF 8GB ECC memory.

Also the host has been running fine after the bug triggered for 1.5h and today again for 7h.
