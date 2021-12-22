Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0890047D1D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Dec 2021 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbhLVMhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Dec 2021 07:37:53 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:33770 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhLVMhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8MaPpGxJgEGfhSRIWktUPu8Djx/Jd3vJZEcOcNPLJuQ=; b=iIlX9D5ZmpxcdPauNLWoUmXHzS
        8vtQjJHZizUdOJ9GIJOBrpuZMTr+W4eLIfSnahX4eM304VvQGMH8NpfidPqxTyZhDaRuGpC83qDGH
        IW/AMwPg3Hz3HscPK1NBNQSPk83j5X828tLNL/Qd7e23y8H8cnFuQzzY+LXjaCD3179cvkyDDQ9oE
        wFyWvb8Ej8lHmhRpzJHF0PyRQvNzurq7BvO9v56V0CzeeErVDNRLu0qsVqAi1UjJfVkBLjdveywDk
        vFD1sKnsJaVfvUDxM1VpFAi+h8Sbdi3FzOIEcO8OTDj3ICHTMWQqSfThWOCev50j+HHT28XHWMtxb
        g2vyvZCw==;
Received: from 200-153-146-242.dsl.telesp.net.br ([200.153.146.242] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n00s3-0003eR-DI; Wed, 22 Dec 2021 13:37:27 +0100
Subject: Re: [PATCH 2/3] panic: Add option to dump all CPUs backtraces in
 panic_print
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com, siglesias@igalia.com,
        kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-3-gpiccoli@igalia.com>
 <20211130051206.GB89318@shbuild999.sh.intel.com>
 <6f269857-2cbe-b4dd-714a-82372dc3adfc@igalia.com>
 <Yb+R/OVeBkdYLWeH@bombadil.infradead.org>
 <911e81d3-5ffe-b936-f668-bf1f6a9b6cfb@igalia.com>
 <20211221154816.4a7472c55073d06df0c25f74@linux-foundation.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <1758d4a0-6158-01b1-7460-c8ffd091d3dc@igalia.com>
Date:   Wed, 22 Dec 2021 09:37:13 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221154816.4a7472c55073d06df0c25f74@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/12/2021 20:48, Andrew Morton wrote:
>[...]
> 
> They'll turn up on ozlabs after I've tested it all then uploaded.  I do
> this a couple of times a week, approx.
> 

OK, thank you Andrew. Will I get some ping when that happens, through
some bot or anything? I'm waiting them to show up in linux-next tree so
to start a backport to an in-house kernel and starting using them.

Cheers,


Guilherme
