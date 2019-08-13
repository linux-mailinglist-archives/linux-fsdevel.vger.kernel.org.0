Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E802F8B589
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 12:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfHMK0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 06:26:43 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46472 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfHMK0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:26:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id z51so19013740edz.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 03:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wKrzbHWYtDSnvIm2HdgSPVxnz2HylVYreiPed1Dst9w=;
        b=Te16tHcx5SeSyZbwS4mToRRBkrQFfxiIxURu3GhVM8rmhBEDWZXDieA1yDj+ZNeaSh
         ptD6gTjANZdOeNHjtN0oP6N5FMtx5kfxkYs1KvS/+io+h1tE3Kf9tFfpKMiqJge4Yphy
         UI7wYjz22g4gSIxBbv+LOT6r8UO6dGraTS9Mhyjx6P1rPmpXnf/M28xj+v03b7kXV5p8
         aSFINcuJRDYR77rCXPKX5xYY6THUBu7yQIzM9+lvgFChBqtbn+8DsVprFmMZVT1DkONO
         VWKhy+eD+r+7UJ9yu7RFM/V83/9vK564DNQJTySl3NEj+RruV8i1EJxDHG558gpONrGe
         1nMA==
X-Gm-Message-State: APjAAAX/UDO8N/P+SU4N07BOKdGMHxw2qvaGG67t9ilQS4pLxR0Ovjqi
        ZwTxtJeKMIKRtFSvI7vS0dI=
X-Google-Smtp-Source: APXvYqw6h609CGqf3l/dFEUIeZhlHLe7QJXtblV7D699D04hyNXlYqgV4qlH1vlgClDLtOEjcZWIrw==
X-Received: by 2002:a17:906:19ce:: with SMTP id h14mr5667849ejd.242.1565692001228;
        Tue, 13 Aug 2019 03:26:41 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id g11sm17695105ejm.86.2019.08.13.03.26.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 03:26:40 -0700 (PDT)
Subject: Re: [PATCH 09/16] zuf: readdir operation
To:     kbuild test robot <lkp@intel.com>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     kbuild-all@01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Boaz Harrosh <boazh@netapp.com>
References: <20190812164244.15580-10-boazh@netapp.com>
 <201908131749.N9ibirdS%lkp@intel.com>
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <ab0527f0-7fc5-50fe-006b-5a04f9b94828@electrozaur.com>
Date:   Tue, 13 Aug 2019 13:26:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <201908131749.N9ibirdS%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/08/2019 12:39, kbuild test robot wrote:
> Hi Boaz,
> 
<>
> 
>    fs/zuf/directory.c: In function 'zuf_readdir':
>>> fs/zuf/directory.c:86:1: warning: the frame size of 8576 bytes is larger than 8192 bytes [-Wframe-larger-than=]
>     }
>     ^
> 

Will fix thank you
Boaz
