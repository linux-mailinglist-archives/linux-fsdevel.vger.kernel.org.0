Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC96337616
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 15:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhCKOsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 09:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhCKOsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:48:19 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86119C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 06:48:19 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n132so22199576iod.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Mar 2021 06:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=maBOO7WosP6+l6DmgX1UwQ0O/fVFPB0FoQ0zTurHWl0=;
        b=gkzYX/HVgLNw5Y73NEEpWWaOgrvv43GVM85kjJQhktYEGLvuWKSMQeitKJi4GvA79c
         uEAwPqS30volo6MJ32Y82V3KyeCSC38tKLQmKk3nTKxCC1msLOe22CnrwO1lSLKQfWuW
         +rkHXZL1PZAJWtQrYORJ5qcTINo25QRhKVj4QdXXRlFGnca1hnsJQLhx++Kx1lZ21esw
         A4Cuea0boeFOEdDoQqj3Dc+CC/1nhg+9e9t8ZNywLVnRJpX8Z79R3Qta55x5Y40dav64
         gnURzfdBp8oPwmOiHu7wvmqgOlBqaRAW31oCe0RbLHCEAOv39edqRPwHRR0jxCV66GI4
         1JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=maBOO7WosP6+l6DmgX1UwQ0O/fVFPB0FoQ0zTurHWl0=;
        b=MUNFj7snkLTiLbOmFKzLP1toXK4MwVsaPcXFufiy+jdu+P29PM+OL2RAnK+YqASEf5
         x8gL4/rCEMIou1Rsz8nI8iwUePTrPfzH7OyoRyaYfwXy5O/RstFczp18W7OuG1RFL4c4
         gsFQETuAjZSDdkH4twqeB8xsvGmEh196OinmJqF2Zo3CorjzyZ5x43W6lApDjrZ6P1yh
         2vKLJiN097XjKE0YkTOq/WGaRoQIM+vO4RLG4S8uP2/kpYnF6MT0rxqEDqv/PVgKgZoZ
         oAGyw3EDSnli6mgHxQRmYfHF4hzaLtmVDE1mqMU69NR9feIwxty8AtHh6Lclrky8n0hN
         1teg==
X-Gm-Message-State: AOAM532DvJ16FcgwkDhwBMhR5f7OKENZE8HhCGG8JGaSNjrfjIE3rI+A
        cNlNHkTGjgwN2/bFAYA8uvKBy8uwV92UGg==
X-Google-Smtp-Source: ABdhPJxzStox16rZ3CO9GtmiQhDbKRU1imgRkL4KjkpIy0ln8EVSoVKzKdztVsoJX+Ob1VGPT0OVvw==
X-Received: by 2002:a02:6a14:: with SMTP id l20mr4104335jac.12.1615474098636;
        Thu, 11 Mar 2021 06:48:18 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k12sm1513146ios.2.2021.03.11.06.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:48:17 -0800 (PST)
Subject: Re: rename BIO_MAX_PAGES
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210311110137.1132391-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <45639533-59bd-3634-b8ba-6dea07417384@kernel.dk>
Date:   Thu, 11 Mar 2021 07:48:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210311110137.1132391-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/11/21 4:01 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this patch renames BIO_MAX_PAGES to BIO_MAX_VECS as the old name
> has been utterly wrong for a while now.  It might be a good idea
> to get this to Linus before -rc3 to minimize any merge conflicts.

Sure, better now than carry it for the next merge window and deal
with that...

-- 
Jens Axboe

