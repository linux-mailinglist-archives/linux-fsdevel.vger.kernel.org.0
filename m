Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83FF34FF99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhCaLjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 07:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235091AbhCaLiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617190725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scQqCO+toL3CRSgablP3sPS1uypuNHkCnACwKnx7hQs=;
        b=Xw6YwHuX9VdSC3oQ5XKxpM48+haF5gaC5jHpyY5cNZtMhV519r27I4qo21fCDiayrK70Ie
        t0h5zsqSBOyY35y0jhqbnOlFatAqCAmj/m6JtTSEJ7H+ibB2Y+nM66lFPxJ59wNye8jWPl
        I3TcVmRQEfZOVnfNAgNeinDg73iaFVo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-HyMwgs1xPpqleueObwhl4Q-1; Wed, 31 Mar 2021 07:38:44 -0400
X-MC-Unique: HyMwgs1xPpqleueObwhl4Q-1
Received: by mail-ed1-f70.google.com with SMTP id o24so948670edt.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 04:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scQqCO+toL3CRSgablP3sPS1uypuNHkCnACwKnx7hQs=;
        b=t4F4qZNQOQHMHbIT56aUnjE14DV9eBkUnPIkF0ffeUISR4W5bQA7ulrNipaIyGgCqC
         cSMIYdBhBgYwSiLCDJVJRUpvLbWwFN+WkN+td0yEDLW2fkCFt5zrmMV/QHLiVmKp03FT
         T7+aPSQjE4P7GmPCjE1puduOFcLjkk/MLMQHA2sDIoXAVgTMdqaKSSrHopPgaebnQnsz
         CQPrctIP5DdUdyIM3QE4u2fgKpcFFLDNrSZPnTA2qK+X5Slv42c9JgGwEyo19w2N0nxC
         iyDbguhv4O8wtzjVwN1+Z+KGZiIB88o5PtjEN8942Fte2SG5CNi0fcbpgxxiwZwipCj/
         VtYA==
X-Gm-Message-State: AOAM533TprbV8R8yIq32Tt/a8Gd18ATNl4wIykOaWeDnf9ZWhftnXfSw
        nDEl+BU2uBfHm32Eu/4++s30hyVBooBGG/k28VJJb0YtHzpx1yeN5nUEbTZEezhFzj25BbUPetp
        buo8GhqoK9B1OBjGbskna1sDkkww4kTcQfUGtOw3zG+aRR3sRtKdqFqseTGEXYZ/nlhzUDlQETk
        Nolg==
X-Received: by 2002:a05:6402:2058:: with SMTP id bc24mr3120952edb.243.1617190722686;
        Wed, 31 Mar 2021 04:38:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd/KPbp/jBhXzK1yeaY7DaO2BdXjxNzol3ofoqFFADRCegBxITw7rNIfuV6YcUf5YuYpoWtQ==
X-Received: by 2002:a05:6402:2058:: with SMTP id bc24mr3120937edb.243.1617190722560;
        Wed, 31 Mar 2021 04:38:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q10sm1351627eds.67.2021.03.31.04.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 04:38:42 -0700 (PDT)
Subject: Re: [PATCH resend 0/4] vboxsf: Add support for the atomic_open
 directory-inode op
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20210301184143.29878-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <290c1c9a-ef36-8740-e136-53b37878eb20@redhat.com>
Date:   Wed, 31 Mar 2021 13:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301184143.29878-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 3/1/21 7:41 PM, Hans de Goede wrote:
> Hi Al,
> 
> Here is a resend of my patch series to add support for the atomic_open
> directory-inode op to vboxsf, since this series seems to have fallen
> through the cracks.
> 
> Note this is not just an enhancement this also fixes an actual issue
> which users are hitting, see the commit message of patch 4/4.

Ping? Can someone please review this patch set? It resolves an issue
which is actively being hit by users.

Regards,

Hans

