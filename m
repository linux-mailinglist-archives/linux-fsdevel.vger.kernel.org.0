Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53979483FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfFQNb0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 09:31:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52359 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQNb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:31:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so9297363wms.2;
        Mon, 17 Jun 2019 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TK/taqnh4uTdUXYrgyPWRNDtNYlU83EQagbd52Vya7Q=;
        b=ENOJaDIcKIyM2ugEwPbDz5yXeyQ4yLGFt0UoLTW/SfFBEE1GI2WZm4B05Cd7QL89vm
         i0uC0fZ45h8c9+AtE188tELX/cImyDiX8JOdrOjRAPst2wYL72WdZkzlsLKHDbKwO88A
         fBFmMZpUnBGo/OcqPiFLq31dtZ7vEz5ltwwm5fW1BBQoxHLdm68UDAUY0eWDPuCJUMO6
         7HRMfUWEw3KrXVWJwrHfxbWhDffWtoEfx2r//PsTOBcWzfEFH4v6yI6qU44K4tN05rq5
         SPtgc4Ts8aT7Zs16DyZAZzSzKhli314JMqBmSk3V1umqS0zyyySyltYGB4IxrHJrp70g
         7cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TK/taqnh4uTdUXYrgyPWRNDtNYlU83EQagbd52Vya7Q=;
        b=ERJf3MjkwqXu3lyNHDZGXS21aN6FzW2T1u9voYJoCUw7R0JmHFXRdKRdaJWW0SAANN
         KZLoEhXuQCmOEs1c+W8ATnDrVZ9b1KLee0LfrWEQSyxF93Y73073coDz7np+WA4ulRGy
         GhQABTAxTiPYMuOD7u1rBnbROvFbp75jpEdbuD5gATVekIerbKmmGgHq0+n8kXGkgDnP
         QORMBsEsioOMtlALc97PI3kY51aPnE7rVIPJ5zM8Xo3+uI4okus6sZLPWTu1RBxViOHi
         CxrwiveEjYGJLG9cnMsh/3EaQSWnOxiYacc4prusne69RXQbgCz2Tz9SwJcTcGxp5S5m
         bcdQ==
X-Gm-Message-State: APjAAAU2ovnyxBO+cUCHkpal4xIa3rMSP7zvqrr7pTKDOJb/1CiZQPjg
        L+aZuJ/dFevy554l5jbOZ6Q=
X-Google-Smtp-Source: APXvYqzEgy4mPVF+JIAdiL5lPe21YfSxEYStzjxJIEXrMdKSlb4M+1ecnl0Nvbc2TqZFJIsyNWZttw==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr18910782wmc.106.1560778283508;
        Mon, 17 Jun 2019 06:31:23 -0700 (PDT)
Received: from [172.22.36.64] (redhat-nat.vtp.fi.muni.cz. [78.128.215.6])
        by smtp.gmail.com with ESMTPSA id q12sm8027900wrp.50.2019.06.17.06.31.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 06:31:23 -0700 (PDT)
Subject: Re: [RFC PATCH v4 1/1] Add dm verity root hash pkcs7 sig validation.
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org, scottsh@microsoft.com, ebiggers@google.com,
        mpatocka@redhat.com
References: <20190613010610.4364-1-jaskarankhurana@linux.microsoft.com>
 <20190613010610.4364-2-jaskarankhurana@linux.microsoft.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <ab346931-1d1b-bd2f-8314-ee4779bd44bf@gmail.com>
Date:   Mon, 17 Jun 2019 15:31:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190613010610.4364-2-jaskarankhurana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/06/2019 03:06, Jaskaran Khurana wrote:
...

> Adds DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE: roothash signature *must* be
> specified for all dm verity volumes and verification must succeed prior
> to creation of device mapper block device.

I had a quick discussion about this and one suggestion was
to add dm-verity kernel module parameter instead of a new config option.

The idea is that if you can control kernel boot commandline, you can add it
there with the same effect (expecting that root device is on dm-verity as well).

Isn't this better option or it is not going to work for you?

Milan
