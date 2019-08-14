Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50E8D691
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfHNOug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 10:50:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33382 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNOug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:50:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id q20so30065666otl.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2019 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cWx0cFqnOpCViIJ4tMHIiuLTvCAxlz9fs3eE3H38dRE=;
        b=lXrxUu2GbQ/3WBKNQg6bGoE9vwtRUCP4SFYSH0scEDD89DaRziNNmLBjE0vttmjUe/
         O4oi/JbfzfFG5Xw+9gyej9xa8Hxo6VT5l/5Uhu6Ny65juAt0JRUAzvszKia3iSP6nh2r
         cE0Ny9xPzGSah2fDAN6DN8EjpM8B6mh5i7nhJfiWPFDueWS5tsen90BhvNf8os6QfOaB
         R9wxOqDAIO9Yz9t6d1bMDRQ3gDdzZeohh4mmfilwhiOUUe/mDlQ6e3WFeK9AEwQGx/YF
         rY1tFBsimehN69v0SOIHFcLiMcb9eRNPzSfZvNrcyjLsWDG+3r2rJKdeGRUyQs6JW23U
         vFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cWx0cFqnOpCViIJ4tMHIiuLTvCAxlz9fs3eE3H38dRE=;
        b=tM7h4LaD7ZriDV9+MMqz3kj76D9I9vJozu9K+siK72qwsBwJM1wlu3YbHE4TPuIU4S
         u7QJfqXzSjsT6vJngNO/qhgvEfi8xhLH8uM193fBxinScPcU9oigxhOWIYLZ2joSX8pp
         8gJTTZp3B0Dc9wJ0h7XOxrF3j+c1tyWk1AA+quzS2a///fzYiQrxxh6cU7aQ24sGYQZK
         ISY2vuruulTZH2AacMUsqiMw4Lw8xbOGnrZ4FQyRPVQkMGkW8URwxDLHqKIG/sqJIOsL
         0qX0ZUo8FvFZdO53ZH82UC+hTcLLzFR/hcJTcew0Tbr8RRh2PHJR6XETUBXiwo/jihe8
         cWfw==
X-Gm-Message-State: APjAAAX0RNljDVVdjcHeUIZ/1Dx4MqbOW961tVTSZLUP0tMp8qBVJO2L
        zE5cSD2gW4yi1mpCztRI7DQ8/h9cUh1V1Q==
X-Google-Smtp-Source: APXvYqzQoRGPHjcNHC/V15omIqsc2Ze631e9qimSe/1ZAhI9YzS7mHKxHhdIL75MIuw/sd9unwIaTQ==
X-Received: by 2002:a5e:834d:: with SMTP id y13mr288968iom.79.1565794234700;
        Wed, 14 Aug 2019 07:50:34 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e22sm101663iog.2.2019.08.14.07.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 07:50:33 -0700 (PDT)
Subject: Re: [PATCH RESEND] block: annotate refault stalls from IO submission
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190808190300.GA9067@cmpxchg.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ad47b61-e917-16cc-95a0-18e070b6b4e0@kernel.dk>
Date:   Wed, 14 Aug 2019 08:50:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808190300.GA9067@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/19 1:03 PM, Johannes Weiner wrote:
> psi tracks the time tasks wait for refaulting pages to become
> uptodate, but it does not track the time spent submitting the IO. The
> submission part can be significant if backing storage is contended or
> when cgroup throttling (io.latency) is in effect - a lot of time is
> spent in submit_bio(). In that case, we underreport memory pressure.
> 
> Annotate submit_bio() to account submission time as memory stall when
> the bio is reading userspace workingset pages.

Applied for 5.4.

-- 
Jens Axboe

