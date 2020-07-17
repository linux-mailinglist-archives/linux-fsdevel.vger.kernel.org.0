Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2377F223B6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGQMfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 08:35:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34117 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQMfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:35:13 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alberto.milone@canonical.com>)
        id 1jwPa3-0007cK-2B
        for linux-fsdevel@vger.kernel.org; Fri, 17 Jul 2020 12:35:11 +0000
Received: by mail-wm1-f70.google.com with SMTP id g6so8706499wmk.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 05:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nBsy1ZCP03z0mPLqw5hiaGTNsdZpvurjEf5CuPMhMB8=;
        b=gXqx70mMDOTK4TOSw6OUxav3NCMi3BhLAC3yEjnu+83pTK30vC8nEO0owkiOPFJcqj
         SBINrESKL81ifzQ4Q3vsptoCSbnvDz9noCF5zsReDXBQHZl+OX1iQPEZC8W2GrvXSALc
         WZ+Oby9Q3ejbq56ml4qMuT5tCUL7z0FnD9llUQug3cdHAYcWzxyGilirdd9wMHO1vLpf
         lTOme2T+QNLT5AjxJforapqnaj4WiGJjUY9TpyQdFSKesX9BAojpWPjhs+/DRBcw55As
         Jda3Thb8NfOb+aqXklaqcKEV9oOFvFSeMOtlthyGN8iW62MwwgGMTkTc1lqqGFFTqmuh
         J4AA==
X-Gm-Message-State: AOAM531nbYngSfww6b6q89R0XP33/YITnyUO6IhgAVX7wAhq79FDyMU1
        wCEUplHLnKE0gzw4y7z79p0igt3s6pgyLd5wScNwidBTwVErfJaFMmrEtFPXzWi/sgax6zo31Wq
        IJU8QQ27xZPCD6nwcQyNKNuaj+DpxcPDy+/ps/ybLYFQ=
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr10406133wrn.9.1594989310503;
        Fri, 17 Jul 2020 05:35:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjOZKbOJcoawpdwREKO4UJrNOeHABjDLg6Z76+FjgEQ8zBKVb639piEKo7ibAhzahKwU310A==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr10406114wrn.9.1594989310294;
        Fri, 17 Jul 2020 05:35:10 -0700 (PDT)
Received: from [192.168.1.238] (dynamic-adsl-94-34-33-205.clienti.tiscali.it. [94.34.33.205])
        by smtp.gmail.com with ESMTPSA id k126sm15111227wme.17.2020.07.17.05.35.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 05:35:09 -0700 (PDT)
Subject: Fwd: [PATCH 1/1] radix-tree: do not export radix_tree_preloads as GPL
References: <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
To:     linux-fsdevel@vger.kernel.org
From:   Alberto Milone <alberto.milone@canonical.com>
Autocrypt: addr=alberto.milone@canonical.com; keydata=
 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
 NoFCMd+w
X-Forwarded-Message-Id: <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
Message-ID: <ecfc9797-5941-7ff9-629f-8f381e844b9a@canonical.com>
Date:   Fri, 17 Jul 2020 14:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ba5d59f6-2e40-d13a-ecc8-d8430a1b6a14@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org




-------- Forwarded Message --------
Subject: 	Re: [PATCH 1/1] radix-tree: do not export radix_tree_preloads
as GPL
Date: 	Fri, 17 Jul 2020 14:33:31 +0200
From: 	Alberto Milone <alberto.milone@canonical.com>
To: 	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: 	linux-fsdevel@vger.kernel.org, mingo@kernel.org




On 17/07/2020 12:43, Sebastian Andrzej Siewior wrote:
> On 2020-07-17 12:18:48 [+0200], Alberto Milone wrote:
>> Commit cfa6705d89b6 ("radix-tree: Use local_lock
>> for protection") replaced a DEFINE_PER_CPU() with an
>> EXPORT_PER_CPU_SYMBOL_GPL(), which made the
>> radix_tree_preloads symbol GPL only. All the other
>> symbols in the file are exported with EXPORT_SYMBOL().
> Is this a problem if you disable CONFIG_DEBUG_LOCK_ALLOC ?

I checked and CONFIG_DEBUG_LOCK_ALLOC is not enabled in our kernels.


