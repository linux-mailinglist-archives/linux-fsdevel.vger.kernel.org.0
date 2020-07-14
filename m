Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1278E21FDB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgGNTq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGNTq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:46:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE1C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 12:46:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q15so5759wmj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+nhb8t+PcCGgrvEP7+xA95vECJY7ytHwfjLM8rFWcjg=;
        b=ACa837lvtgOPzzxubzSWWRre6AhL5cLq7zh2kfGiVKrpzVh5U2+g6Yurmm05G+mCuq
         Or6eDkDY2lx3TT1PRm3KvTH12TZO4bMi3OjaZOTqcwwRN47701s/M+VPqtm2bKJ46JTh
         ieqG871ZQVDlPuJYPpuTsMxP7/NvYG8z1c3ZaqsrOM63kxo8MCAvO94Fxe1P6+oZnkQT
         Ogb7eALNcIh7dS+nj+Y9H6+XpFGM4lhmURIvmQUF3CIptP2w7fVmtUnDT4KU418Po4ZH
         ZpAQHOxxSPOckGot7FYaIsFaSxfGeixdSRyUyHI/dcnZnpQCFCvLZXLzPftzdQ8N/o+i
         bDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+nhb8t+PcCGgrvEP7+xA95vECJY7ytHwfjLM8rFWcjg=;
        b=Tmr62Dm2vzmrbF4cXMJTeJ/CU1v9qnDZuwM92nehaCvmZkIpowl5Bd9cJca4P0i2lK
         cFj3BnJu6mKfjNhxoIdovo2eUFCYJGwnqATGWN3OCAKkBcFD5+xbljOSh7I96y2IBjqI
         zqTTHWZdS7FLCeBwzd5e637VILDhH08V24rg6sQqRPwYtejF/r/A34CROgL9wdJJlEuQ
         S6Bctbyq6qDz6Waq3YGhU8tQqACh7PjbE1yzk6s8U7c8dawA5CAmDB1GCgYGUvcpM4IA
         uFsuq6W0TtXLNhElSHvkcOCEJKEqBJrAcrlicrSg9cofiLZnkms1j5Dq8yiIo+9eYW48
         Sq9g==
X-Gm-Message-State: AOAM533CyT6xTXdmLecgRZPKlcAnlpyI9BAgCTHyXKDNMjKgdHKoYDEa
        t4Lr8BG9BGjC877HUC3WBEEoeVNMY1Y=
X-Google-Smtp-Source: ABdhPJx2aOZTkkzB2Ng+2LM18kD5LI0aYZrmjJk5E8pQdUq64Fp1xIOc/dAB0msFcZNcuDnZSxVaFg==
X-Received: by 2002:a1c:a986:: with SMTP id s128mr5294826wme.121.1594749278131;
        Tue, 14 Jul 2020 10:54:38 -0700 (PDT)
Received: from ?IPv6:2a00:a040:196:431d:6203:64fa:e313:fb47? ([2a00:a040:196:431d:6203:64fa:e313:fb47])
        by smtp.googlemail.com with ESMTPSA id j14sm30081677wrs.75.2020.07.14.10.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 10:54:37 -0700 (PDT)
Subject: Re: Unexpected behavior from xarray - Is it expected?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <9c7b1024-d81e-6038-7e01-6747c897d79e@plexistor.com>
 <20200714134627.GC12769@casper.infradead.org>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <338db3b4-17cd-959b-3a45-8cf406cc8ed1@plexistor.com>
Date:   Tue, 14 Jul 2020 20:54:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714134627.GC12769@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/07/2020 16:46, Matthew Wilcox wrote:
> On Tue, Jul 14, 2020 at 02:24:18PM +0300, Boaz Harrosh wrote:
<>
>> But in the case that I have entered a *single* xa_store() *at index 0*, but then try
>> to GET a range 0-Y I get these unexpected results:
>> 	xas_next() will return the same entry repeatedly
> 
> I thought this was fixed in commit 91abab83839aa2eba073e4a63c729832fdb27ea1
> Do you have that commit in your tree?
> 

Haa! so so sorry. You are right I am on a Linux-v5.3 based tree and only
v5.4 contains this fix.

(I will carry the workaround for older Kernels on user-machines)

Sorry for the noise
Boaz
