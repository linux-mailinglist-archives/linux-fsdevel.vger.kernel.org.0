Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6E105637
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfKUP41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:56:27 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35764 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfKUP4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:56:18 -0500
Received: by mail-il1-f195.google.com with SMTP id z12so3769968ilp.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 07:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i6XZTTQSHJKM+KBZCHJbpNr3leYiOU/zZyc4Kt/q1ls=;
        b=p9f61F2qEE4/QwqhzVpQxRpsxX+tV3SxRebeynsmRfBNHvoMnRcPAeQBMJ4vetLpDz
         shfSAjNsSLR8/AyOjsQjN2cfgMUQmKjudar8cuqkQT4utDF/Fg0xyKUILGxfQL2m4ykC
         v2dKDPfCeTVXelv8ErH8wWKv+orr2ysEDzISJsEE+qs4wfsyfactwDmLH8MnBWJzVSmY
         XCTDegH0huTSluHvW6LcnV5C2iycu99pwuw2Q/YxucMfTo227eo59/I8ZMNVpzMswrI3
         2Efr4431bVIGY+4pWPJ+b3TiJoIazJewBg9vmPs5YlVPxg8N869vnJ+tezxnZ3CO4XTi
         5d9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i6XZTTQSHJKM+KBZCHJbpNr3leYiOU/zZyc4Kt/q1ls=;
        b=et0VHgg2l30f+F1AI+g13pn8KdsJXw7aMFTiNcJjCKsgQ7TBYd+gqSPEcgup4YS6V5
         3+NORF3SjRKzCQC8wvO6yoKww5edTwCYZkjcaepR8tyxZkqUTSDrufEmFuyNyUIdC13f
         Yza+H7Cv/QT0b8H87INAsKRnLHcL4ofJVlOup3VOb9iMovz6Ind/rWDPybuWwhrhaiFN
         nVxD28eu71XQ8YhgkyiTARq6gGAkc+8IW1f8TkD9K2kfUSZmaEqticjh+AWDyKQF8jUg
         q05o8Z1kI4km6HMQIBVX8X3awU3URL7t4Ta8/HCj/zU+ZVm6fuTUSg4oN6ITqW+IPvYu
         ccyw==
X-Gm-Message-State: APjAAAUVnwA/QXeXXoeh05dhRPYy5GVW9dgXaCcJaE1SEI6l6FcRnwQE
        vo0QWZmOVxSwYoBv2L0DIsCzMA==
X-Google-Smtp-Source: APXvYqyBx1nTqGMRn9GsWSj0/giOcMCoKn/OjZ4stbz+xyyRba03IeYJrruyiFFcHRXe1jGKDNx4oA==
X-Received: by 2002:a05:6e02:100b:: with SMTP id n11mr10655778ilj.212.1574351776819;
        Thu, 21 Nov 2019 07:56:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 133sm1342001ila.25.2019.11.21.07.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:56:15 -0800 (PST)
Subject: Re: [PATCH] block: add iostat counters for flush requests
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <157433282607.7928.5202409984272248322.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff971ff6-9a10-c3f1-107d-4f7d378e8755@kernel.dk>
Date:   Thu, 21 Nov 2019 08:56:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157433282607.7928.5202409984272248322.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/21/19 3:40 AM, Konstantin Khlebnikov wrote:
> Requests that triggers flushing volatile writeback cache to disk (barriers)
> have significant effect to overall performance.
> 
> Block layer has sophisticated engine for combining several flush requests
> into one. But there is no statistics for actual flushes executed by disk.
> Requests which trigger flushes usually are barriers - zero-size writes.
> 
> This patch adds two iostat counters into /sys/class/block/$dev/stat and
> /proc/diskstats - count of completed flush requests and their total time.

This makes sense to me, and the "recent" discard addition already proved
that we're fine extending with more fields. Unless folks object, I'd be
happy to queue this up for 5.5.

-- 
Jens Axboe

