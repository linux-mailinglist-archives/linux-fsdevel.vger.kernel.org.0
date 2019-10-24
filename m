Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD35EE2DB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 11:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393087AbfJXJji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 05:39:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37544 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388539AbfJXJjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 05:39:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id e11so16572226wrv.4;
        Thu, 24 Oct 2019 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t1B4Upx5L3UHH8ve1wWiItXwI5Up+GeBea3yXsTkPvA=;
        b=qF+v9F05QVKtv5B5gUoCVvNSfVME4kV5eTlt2R1uArWbs575qU2tMEj2bC2IaydZSp
         L+xXvY2U4N9O6aOClEUC0qNZj2j9jwynyZCtnqAketOka7U2rfE0y/5usgqx98ATvYwR
         0jizZVABaW71ijapZ6X42ho9LaJn9w0r0bfwYppe76OZKCsMQP61ZUkNOKvyaNBCWr1f
         KXpgoEQEgsr+/ik185kGem5+Zvx2EqR17W2fLWpLVEPnMr8a8JLP/IvhP/RXpFAvB220
         o37oNycOIMzVRhS8d3AJRWPy37F1+QWHlCTwQPTAoN+RunGyQxliN1pMsn4Ho/2nXR4Q
         5zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t1B4Upx5L3UHH8ve1wWiItXwI5Up+GeBea3yXsTkPvA=;
        b=tEgdzuMk1NNz+p62h3s9O/qx+1mZH2e2Msao3CD+YEm1IeKG68+A6fhRjT7PNWe6Do
         s+TPX6EI60HbAZYRChINL9FPMWbT7UbFbUlx6ccVdQABlyammRS6307ZFjNSusZbi+dP
         b5ulkSPeLRRCEAlU7gP2inzoz370ktS6Sskz75cpn5AC6TjrFRQAoE1Td+VxBswCAFu6
         +k6pOAY874tARUfICJLw6gt4s7YXIWa/Yz+JdiN+K9+07OVqHxSVI/KBYjmTh//45bSr
         LqizryDy2OxxSWHEcjJllLkuKrlDiHHsa+6WNccQ8hAo+W+kayf5PkWztWBz1yW9gWsU
         jvSw==
X-Gm-Message-State: APjAAAXMO1ziSE1NI0+HZ2d880lMGqAmshtwyp6KVDo1AdpqBuof3q8t
        AW80G3vwoluSGPG9dMM4/70=
X-Google-Smtp-Source: APXvYqyhpkr8qJ3hxhJsygaSaVXu6ia/0VFGb7Guafugca9uJFHThI8Q89EQtjL/gKMhrtk5Nt1QYQ==
X-Received: by 2002:a5d:464f:: with SMTP id j15mr2945291wrs.366.1571909976233;
        Thu, 24 Oct 2019 02:39:36 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q22sm1895115wmj.5.2019.10.24.02.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 02:39:35 -0700 (PDT)
Date:   Thu, 24 Oct 2019 11:39:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191024093933.zocacmhle3cuq7ld@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190828160817.6250-1-gregkh@linuxfoundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 28 August 2019 18:08:17 Greg Kroah-Hartman wrote:
> The full specification of the filesystem can be found at:
>   https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification

FYI, it looks like that this released specification is just copy+paste
from exFAT patent https://patents.google.com/patent/US20150370821 which
was there publicly available for a while. And similar/same? copy was
available on the following site https://www.ntfs.com/exfat-overview.htm

-- 
Pali Rohár
pali.rohar@gmail.com
