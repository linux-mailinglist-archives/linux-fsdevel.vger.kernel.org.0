Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1454545F68D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 22:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbhKZVkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 16:40:01 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:44876 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbhKZViB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 16:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CA8xNP+neE2k/OGopcilH6YYXXQbst/2ozJSC7D0hcw=; b=ePhS4ZA6dlcxwrSIlvH2B2wRCv
        0OuLGPQ3iNm1Ri6U1wtuvcWXJxPU9Rb3u07w+O2Be8oSMHUCtgS6awuBlEn2kFSx4QxW9vzSSGMHZ
        WnzX2um/+xGaehmzKSLt3g3Ga2hkt7r2OrX4o8N90THjTvQb1YWBn7weyCAH6+rzn+YMpGiRoMnG3
        he4x5Xhf8VE/SSqHDF532wZhUh8KGEc1tS93iL/FtkI8Gm038uRa4G6lHXmo4SlVRRO93FURY1y78
        bgoBNVMVbIEkOSa7WXFmrubFrnrr5ndjScfbLk7fvLFkqoazeEmMWT8LCa/L5mPOwcYMgh8loBbGK
        2FtXf7pQ==;
Received: from [187.183.40.251] (helo=[192.168.0.53])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mqirX-0000aF-VW; Fri, 26 Nov 2021 22:34:32 +0100
Subject: Re: [PATCH 0/3] Some improvements on panic_print
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <4b710b02-b3a7-15ef-d1b9-c636352f41d1@igalia.com>
Date:   Fri, 26 Nov 2021 18:34:16 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109202848.610874-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/11/2021 17:28, Guilherme G. Piccoli wrote:
> Hey everybody, this is a mix of a documentation fix with some additions
> to the "panic_print" syscall / parameter. The goal here is being able
> to collect all CPUs backtraces during a panic event and also
> to enable "panic_print" in a kdump event - details of the reasoning
> and design choices in the patches.
> 
> Thanks in advance for reviews!
> Cheers,
> 
> 
> Guilherme
> 

Hi everybody, is there any feedback for this series?
Thanks in advance,


Guilherme
