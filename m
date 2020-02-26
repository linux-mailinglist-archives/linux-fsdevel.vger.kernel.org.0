Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6144617011B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 15:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBZOZP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 09:25:15 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41481 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgBZOZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:25:15 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so2509373ils.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=99t4/LSu709UOxxHgYYUFaE6oXsju8vQQ+Dan2LeyS0=;
        b=AKk/C6blVn64C2GdGSB/11TdQP23YBX8LXOs3f/XbzIXqr7hAnkujGrXxJ0GQT48Lv
         2v5ZX98cPy5pTkdPtua8t2/B0nKg9uc8DXXJrgFFNrM1ag3T47CbyZQQ/aCH3Ktr8Pxk
         uoFERM1qWTnUf9//HAleqtIGtpdyRsFlXwkO/saMKUFejE4NjFAzPQz7EIcm8ldY6mxL
         wzHwYSGXsezQVveXPAngRMU9mkVfuA2WXc77iJlvVCARQ5NAX4g4/H26RuVa6sPk/qX9
         V7FXAFJxM1RtJXLYWiCgnE1VNOnXBPFjmc+JnL1kw5r1pWsPl7338FTsvxLmLOylZZC/
         CCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99t4/LSu709UOxxHgYYUFaE6oXsju8vQQ+Dan2LeyS0=;
        b=pFU/leirGacjXbiqjrmf1/xKq9tox1XO5Ax8/Xmk4lAoZoDjZo+HtLjYhK5LkrpzB2
         XFmq3Q5o1EYNRdYuls8dtnpQw3NEBI3gFCHkcQdIFu8OpRlY6MN/1nJjBGtolAuJKRUH
         5EbD57AhV9C0biHCZoTRRKc2mHe17tmGaf0aEWW7F5yr8BgwfVmRsPfIC1qHHwaz3ye9
         aPcmYwISD/2HMuG5CfPes/SCe13h04qtNPSo9eNDgOAbX/zxJxs2wrep2ElDQYJb2ppY
         M6bjmSRYlrOXxOl3y1bLeR3NJaHfnObRl9524gtYCWcF2OjcfDXIMMMPZomeFrlyOZ50
         n+Vg==
X-Gm-Message-State: APjAAAVCUDrY2G1/JOZE0VA6HCmpvrfyY0KMef539kjcI3MEAWYgVhjR
        Kr6UMeamivjVgzJHsia6jNwxNg==
X-Google-Smtp-Source: APXvYqzJN5sYhszLLxiqSgaobFmDkIvmEoRA1VDdlBLUayiIJ2XsJh54cxRdrAFsQuKLE4ruGUvNOg==
X-Received: by 2002:a92:5e9b:: with SMTP id f27mr5359159ilg.263.1582727112384;
        Wed, 26 Feb 2020 06:25:12 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v64sm756538ila.36.2020.02.26.06.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 06:25:12 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] userspace PI passthrough via io_uring
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, io-uring@vger.kernel.org
References: <20200226083719.4389-1-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4defe33b-689e-04c1-a1d5-c2e7a572027e@kernel.dk>
Date:   Wed, 26 Feb 2020 07:25:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226083719.4389-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/26/20 1:37 AM, Bob Liu wrote:
> This RFC provides a rough implementation of a mechanism to allow
> userspace to attach protection information (e.g. T10 DIF) data to a
> disk write and to receive the information alongside a disk read.
> The interface is an extension to the io_uring interface:
> two new commands (IORING_OP_READV{WRITEV}_PI) are provided.
> The last struct iovec in the arg list is interpreted to point to a buffer
> containing the the PI data.
> 
> Patch #1 add two new commands to io_uring.
> Patch #2 introduces two helper funcs in bio-integrity.
> Patch #3 implement the PI passthrough in direct-io of block-dev.
> (Similar extensions may add to fs/direct-io.c and fs/maps/directio.c)
> Patch #4 add io_uring use space test case to liburing.

No strong feelings on the support in general, the io_uring bits are
trivial enough (once fixed up, per comments in that patch) that I
have no objections on that front.

I'd really like Martin to render an opinion on the API (PI info in
last vec), since he's the integrity guy.

-- 
Jens Axboe

