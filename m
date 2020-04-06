Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B13919F5C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 14:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDFM2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 08:28:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59896 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgDFM2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:28:51 -0400
Received: from mail-qv1-f71.google.com ([209.85.219.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jLQrw-0005wm-Qe
        for linux-fsdevel@vger.kernel.org; Mon, 06 Apr 2020 12:28:48 +0000
Received: by mail-qv1-f71.google.com with SMTP id f4so13232450qvu.19
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 05:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OF5+/9Hx0SVxloqW+AsVqfRADYJTfKE7xEAXHE0ATtQ=;
        b=cbmMVvIgfl5eZbTqAkyLYDEPUYSJrr805Z3lBLz2KhjM0YUHOgXtVcbFrZB/Znp8NV
         Nv73KDHq5W7KgK3hLh3uGja4bdpHVoifLR3ncCBmMyRUiznqUrrGKr/0zqxGMtXK/cPL
         BtCSnq1ppshkLROt/1NIcm31/B4YdMMBJUwdi8KpRLdDJsIh1uK0hpUvFUU7gNYxWL7o
         XHUHeLJEXMOar7Qpy3cddLjp3M6GY+OjI7sgeXAitZ43HU6lztEer+fR4Ea2ddv04Djx
         x1SFGoD3vnRb9uYvV3jDWfymrRBNFrKzzSPNc9oO8gGG6zn+uVYuQKkYRxv1HOsVURCk
         UH1w==
X-Gm-Message-State: AGi0PuZhmpIiH155pFF/tM7XH3XE68LZpkABfVMil7ckSENZdBgTqD2T
        Qa+3LmJbW/gjYVMbPwVFizWXFho9YgIbkDgGnTaWHqvOXrj4BojTfQXcfFcbQ3Tsjhkds5T/v8P
        0371TZh2RZHHnX1+1MTCRrcd2RnbIgh1qRI75W/mkClU=
X-Received: by 2002:a05:620a:48:: with SMTP id t8mr9118376qkt.21.1586176128009;
        Mon, 06 Apr 2020 05:28:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJYLiXAu6E02kHBhfDM1nCHxnL13FHkbN3p7Z/eOEFCi3eXhdf202hvNJRK1IZo1qiltey8FA==
X-Received: by 2002:a05:620a:48:: with SMTP id t8mr9118359qkt.21.1586176127806;
        Mon, 06 Apr 2020 05:28:47 -0700 (PDT)
Received: from [192.168.1.75] (201-27-34-233.dsl.telesp.net.br. [201.27.34.233])
        by smtp.gmail.com with ESMTPSA id g187sm14076243qkf.115.2020.04.06.05.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:28:47 -0700 (PDT)
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, yzaikin@google.com, tglx@linutronix.de,
        penguin-kernel@I-love.SAKURA.ne.jp, vbabka@suse.cz,
        rdunlap@infradead.org, willy@infradead.org, kernel@gpiccoli.net,
        dvyukov@google.com
References: <20200327223646.20779-1-gpiccoli@canonical.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com>
Date:   Mon, 6 Apr 2020 09:28:41 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200327223646.20779-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew / Kees, sorry for the ping.
Is there anything else missing in this patch? What are the necessary
steps to get it merged?

Thanks in advance,


Guilherme
