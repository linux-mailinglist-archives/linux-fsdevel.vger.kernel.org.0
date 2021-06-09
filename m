Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242713A1D0D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFISt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 14:49:29 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:39623 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFISt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:49:29 -0400
Received: by mail-pg1-f174.google.com with SMTP id y12so8484608pgk.6;
        Wed, 09 Jun 2021 11:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ru/2yHtNbddQUQYL2d7H9005njvNb+FjQOidp6228TU=;
        b=CB3X3RpWGBIY1JN0nAgCk6OeeBfack1A/4u3e0X2mhQb/5jq8MrFlcMMv/Mkje+NkK
         GLAN7ULmgwPUvh7TLb5NqIHW5aHbuwQ5pFQ2S6dYwztQqvEcMpv1QH9E0pxLyUArS9bg
         VwsFk2ek/7DTSphSLJGsZI/pTP6G0+WNUwSPenDeXJMOxksnyhxUnY/EGsvrcAS1mioO
         KDlU2lL3zHr+jvSpHGAmmc2I5vbz7I3DcBwEvTSHtSAhS/bdcjTpBlAbQQuSUOaLDeMd
         JSPm1EAwVG/ZHuxIo4r1n7e4Fu2MN5iVBJ9sMNCKo7isWAZJB+SKOlyVFpawUnoVGLR7
         ct1A==
X-Gm-Message-State: AOAM531tSXLzfhVeKhuxDHw/WRS8nQq/io/mY844jy722+KcDIYDx0fX
        WCO0gJKkPTMnfokgdwTMjuWcE2MbMiI=
X-Google-Smtp-Source: ABdhPJxiAC1yLkCA/hTG9C47iZ22JnDtUUMamj8n6doG+3jjOYjcpWDqeD3b+b13967xvN4s4YYedw==
X-Received: by 2002:aa7:8159:0:b029:2c5:dfd8:3ac4 with SMTP id d25-20020aa781590000b02902c5dfd83ac4mr1186986pfn.16.1623264442491;
        Wed, 09 Jun 2021 11:47:22 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s22sm262945pfe.208.2021.06.09.11.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 11:47:22 -0700 (PDT)
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ric Wheeler <ricwheeler@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
Date:   Wed, 9 Jun 2021 11:47:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YMEItMNXG2bHgJE+@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/21 11:30 AM, Matthew Wilcox wrote:
> maybe you should read the paper.
> 
> " Thiscomparison demonstrates that using F2FS, a flash-friendly file
> sys-tem, does not mitigate the wear-out problem, except inasmuch asit
> inadvertently rate limitsallI/O to the device"

It seems like my email was not clear enough? What I tried to make clear
is that I think that there is no way to solve the flash wear issue with
the traditional block interface. I think that F2FS in combination with
the zone interface is an effective solution.

What is also relevant in this context is that the "Flash drive lifespan
is a problem" paper was published in 2017. I think that the first
commercial SSDs with a zone interface became available at a later time
(summer of 2020?).

Bart.
