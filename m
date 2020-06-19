Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB120125B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbgFSPwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393189AbgFSPXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A039C061794
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 08:23:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so4568713pfc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zzBeoYkChCcVAStYW7riry6t3ZsDx2Q3uCHI24rM2Uw=;
        b=nnSCFoxYQ6AUSpPl6es7No4L1LX1qK6aUh3FwEFvx+WeSsOtxLwXhsHLAvFM6kig2O
         SV245MBqVFTqZWl4g3U9QzuwU+oxj1v4jxKS4r1RDH+Qe5p83thMMXeebnx9oe8xnYCb
         JB2UmXJ3oVZgULEcF+krwdSlyupQk5jtNrhcK6Nc+joMLRC6xJKI75lYwqECAxKxnoXM
         f3tq2NmFzCnozoFNNfLnQJAFoM3fuj8Btgjq+HaI7KEw09q7MV5+F0nuwFqYDD6r1fbJ
         WE53xOFEsZNg8/DJUR3WUCPMVi4E5ZjdMjRveodE4idwaRFNR5TaFOFR+50U7OAgJ0Mo
         1E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zzBeoYkChCcVAStYW7riry6t3ZsDx2Q3uCHI24rM2Uw=;
        b=ecTdPh5iR3xTjPrDiis/aXBOuny3A2zXLXwvpz/xnuUZ2R/uC/4gEwz6h+YjAj9RHx
         Ez7YNaWrJWp8eLXlSLBgwTc4wz08ThJt/7BTjZhZQ+WJhbTdp2JwyCWAXJgLHdLXkICO
         I5SXv+W6m5/NY257RXTOE6OVi/sjOGK3AxZP+fYRjni5hbgBX27G2rKrbqB+dJ0R73Od
         fTHuW6/tx9bsq3hBAXWayagvhVjXHNKFEskLcAxfozWU9YInov06admgJ7/hiAsPOmtP
         ni/83m8DU7AjmyqxJZ2jYvQ6wSIvtCcOeb/fZVrQwPnn6LW8u4K9AY0k9eacT4eGii7O
         6vaA==
X-Gm-Message-State: AOAM530YF0mIvuJkCTXX7lIi2ydOSKz6+g391RbnEJQ8iWeDGrrAx/Nm
        k6jHxH/BIw6IzDz19Qd8WjtFlDgTId++nw==
X-Google-Smtp-Source: ABdhPJwvjmildVQ458MWHvwKJ1J5ToeoGRI4YFBGf+vUIXbuLmaFSHrHXTi8H577NG+qCE8UU1yEIw==
X-Received: by 2002:a63:525a:: with SMTP id s26mr1423522pgl.155.1592580209702;
        Fri, 19 Jun 2020 08:23:29 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a8sm2864224pga.64.2020.06.19.08.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 08:23:29 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: add support for zone-append
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        javier.gonz@samsung.com, linux-aio@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200619152208.GA62406@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5bb1ba8-4738-3f8b-a8b7-839792cbfbf6@kernel.dk>
Date:   Fri, 19 Jun 2020 09:23:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619152208.GA62406@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/20 9:22 AM, Alexey Dobriyan wrote:
>> 	uint64_t val = cqe->res; // assuming non-error here
>>
>> 	if (cqe->flags & IORING_CQE_F_ZONE_FOO)
>> 		val |= (cqe->flags >> 16) << 32ULL;
> 
> Jens, ULL in shift doesn't do anything for widening the result.
> You need
> 
> 	val |= (uint64_t)(cqe->flags >> 16) << 32;

You're right of course, guess I should check my in-mail code a bit
better :-)

-- 
Jens Axboe

