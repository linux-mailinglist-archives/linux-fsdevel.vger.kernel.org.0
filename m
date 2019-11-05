Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF2F01F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390019AbfKEP4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 10:56:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34654 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389918AbfKEP4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:56:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id e4so14550187pgs.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XJsNFwwu/Jlc0782LDjp8YTgvefXfXVL1aCF2AU/E8g=;
        b=YC3ddAr4UdMhHKju55t/KzWOVycmq5e0nLbh8V+2V27jOLCD1mPETt2q2qkDMtFvXk
         b9j2uAop9Xq2J/+zt+LlJ4WrHmrLjL8IUXPrTvGC2YqgjNVPVATP1yeOWf8OR5n6It1u
         iADfOJ5OXYpcDOkKEI4IHSj7dD4N4wVECKIdfev45eXq1eAR9l71SWPvaYo/sQn7tVO2
         yjXhAairdX8rx49VY1RR9SVQjOHSSyXJwKw0VIU+Z8gZgSEhmVbiA/nf+FA2Asu66oMe
         k5m3GIymIo6mP74AOUIsh6+Qd27uJz3gK32eIlcVUf210WxtTIlBoqc3pDdN82ytGfYN
         2TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XJsNFwwu/Jlc0782LDjp8YTgvefXfXVL1aCF2AU/E8g=;
        b=PNHcodbo2G95zNbRGhkZ8g/4HfvHHrSF8jyyaUcse53fo8VyxOPAqNQTLqn2io2zKC
         WEHampJM8vsHZ/2ju6fVVkwfypnOOcxvT4DKw7lruFXKDvy6F2N6uQmspjG1VIJuvLYx
         5PnPBhjix8O22LHyCqo12dmPBI6XnVkQz8O2q9vdRRX90uSEsIygpdwqmqEBT84MDhGo
         oK4l/ESWx8imc4ejd+s2UXzbO9a57xNNc8gNzu1Q7SxNI0nu7ql8OShR8S1kjTSiddLc
         6TTHLOBEFY++tLHaoGrGZfy6LK3ySV74h6aPIse8uwLAQcoHUHm89CKSvg0kvqDPE1IN
         poxQ==
X-Gm-Message-State: APjAAAWsP0ZRFcIFb8uUPzlRx8b2M+WA4Vj62xw2PaOY9dqzKmuYdNyJ
        G6KInCcviI9Vg9p6y4MN6pjuSA==
X-Google-Smtp-Source: APXvYqx865TcFioge9LAZA+i1UxRYOyJHhiIep6k07mIyKrFbOEQ1QQaUbGriZKXguMbJA39nlmSZQ==
X-Received: by 2002:a65:6482:: with SMTP id e2mr3901602pgv.20.1572969389855;
        Tue, 05 Nov 2019 07:56:29 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id x2sm7984553pfn.167.2019.11.05.07.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:56:29 -0800 (PST)
Subject: Re: [PATCH] afs: xattr: use scnprintf
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org, Jan Kara <jack@suse.cz>
References: <20191105154850.187723-1-salyzyn@android.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <2e530f62-89bc-4314-8e78-e5cc049c5d69@android.com>
Date:   Tue, 5 Nov 2019 07:56:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105154850.187723-1-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/5/19 7:48 AM, Mark Salyzyn wrote:
> sprintf and snprintf are fragile in future maintenance, switch to
> using scnprintf to ensure no accidental Use After Free conditions
> are introduced.

Urrrk Out of band stack access ...

-- Mark

