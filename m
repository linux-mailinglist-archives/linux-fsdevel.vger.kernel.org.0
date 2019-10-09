Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D571D16F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfJIRiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 13:38:52 -0400
Received: from mout01.posteo.de ([185.67.36.65]:36954 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731984AbfJIRiw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:38:52 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2D25A160060
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 19:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570642730; bh=wl+8kYqTGoimE4Y+On1+KvrUA4uigqtIsvDP/Uojwkg=;
        h=Subject:To:From:Date:From;
        b=O53cxRk6azzVvO7HQytWM8S5fpiLikShe+/kWPO90Ba23TXcjBtc/4l05au9MQCE7
         cbHDn8J0lmYVcmkXkBBffOfuNJm1OX5/7k2xaqzmOpZ5KsOWyBCee3rDhDq/+9uLbk
         obXVQl/TXGatUBAIOVMwqC3HlAer3pqzYF+dwhQlAuwpS5/9QQt93ERne5uZdzUyR4
         gUaGqUh0VQOE//RPFrn7DzsjmTwETOc5Wd55GMmlut84ELueNQyS/pLzFVeX1QOY6y
         z0Bxs7XTOL56kOzgRq3vFzEgRaeVFHWrDlr4voi/Th92sFvXtF3ZFTBmvJ1rd9uQde
         p+Z1NYhqJ4ADA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pLzs1G2cz6tm5;
        Wed,  9 Oct 2019 19:38:49 +0200 (CEST)
Subject: Re: [PATCH 0/6] Various exfat fixes
To:     Nikolay Borisov <nborisov@suse.com>, linux-fsdevel@vger.kernel.org
References: <20191009133157.14028-1-philipp.ammann@posteo.de>
 <3739116d-89a8-9e89-f692-c8abe4c0dedf@suse.com>
From:   Philipp Ammann <philipp.ammann@posteo.de>
Message-ID: <27e44390-5845-275c-7d4b-1e6fe51d902d@posteo.de>
Date:   Wed, 9 Oct 2019 19:38:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3739116d-89a8-9e89-f692-c8abe4c0dedf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 09.10.19 um 19:36 schrieb Nikolay Borisov:
>  From the same pull :
> 
> "
> No, please use kernel-sdfat. It shouldn't be very hard to get it working
> on 4.18. exfat-nofuse has a lot of issues, don't use it.
> "
> 

...which is this discussion here: https://lkml.org/lkml/2019/9/15/135
The version in mainline is exfat, not sdfat.
