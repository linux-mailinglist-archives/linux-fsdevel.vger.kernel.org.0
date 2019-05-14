Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E401C2C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 08:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfENGGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 02:06:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45956 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENGGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 02:06:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id t24so5408301otl.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2019 23:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PXt1KR8uTPyJUn4Yxy2apR4YARPk5L8lEm2vMkzJPBM=;
        b=e91q8D7aFphaY4A6IL5QmEU/FViV57G/ehUkaEkFrK1dcpjq0tV/orbAlirGH4/L0V
         HiNO6aGwsRRgCXa9Hh5CgGQmS+70E/uhKmZPWtXXVpGjcYHJ2hDsl0yyTFjkgTK/xlmx
         PhNiLFgJYZJwyvVHfroFvFD0FW7PSkb2EPJ0qQW74bWCcU2i2RSPzx/nzo6/Od7NLPJ+
         Ond0PKkr+1PCB1r5YvqNf3Nfocj1tasDuWueMZIbWi966AHRCkQ2utNMgUMZndXBy68H
         g+ssB7URZ3eeNsnjb5ZvI8b2btqbFB0jfNIfgT8YzZ7FAnbWztIJtQChnH90RVS4ob7n
         Uq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PXt1KR8uTPyJUn4Yxy2apR4YARPk5L8lEm2vMkzJPBM=;
        b=ujqKh89KbvV3h3yYfA0xzasNj4+r0tNUgBz+lhlvzrO1aNkcEz/+iucQbuF8xwS5nd
         hp3RZV/P+010gXdzJjpC66hxT9/OZiHRdtHtzjTTKCFlOLIMZeU+v76wvso1xR0PVha3
         Q3YywC7wAig90TCcw42J3FXoi6TTjCBi4glaLA/el7ZevT1qXlOeVZqUGDr+5FjzYo9d
         qjoiZGhuRSPYEVmSQYHy81BoQgCwYyJTHR4q+KkOW0ZITgyQjLBi7eJqJ7BBgs9w208/
         GdtCRugWR8+/BJyv+6bOOtUgY3oBY1QM2GZUoBfoY/7a4t62FHTKF4iCRsLSrS0lt74U
         jhdg==
X-Gm-Message-State: APjAAAWBS6FwizEqwa6xOq3D/FV2dSqwk94z/GlNLOMLkbAWGJXz3Bcm
        B4OOi54iDziAKZh9IRRl+AVHyg==
X-Google-Smtp-Source: APXvYqz34cqK8ejkbSx+SrrTyV2DMUPTt7fPvQMKcNmaB8vAqawQFjp1e57tMQIaPu2wl3v6VjClBA==
X-Received: by 2002:a9d:638f:: with SMTP id w15mr7650121otk.16.1557813972655;
        Mon, 13 May 2019 23:06:12 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id a1sm6771206oiy.38.2019.05.13.23.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 23:06:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Arvind Sankar <niveditas98@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        initramfs@vger.kernel.org
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <20190513172007.GA69717@rani.riverdale.lan>
 <20190513175250.GC69717@rani.riverdale.lan>
 <1557772584.4969.62.camel@linux.ibm.com>
 <20190513184744.GA12386@rani.riverdale.lan>
 <1557785351.4969.94.camel@linux.ibm.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <66b57ae5-bb5a-c008-8490-2c90e050fc65@landley.net>
Date:   Tue, 14 May 2019 01:06:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557785351.4969.94.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/13/19 5:09 PM, Mimi Zohar wrote:
>> Ok, but wouldn't my idea still work? Leave the default compiled-in
>> policy set to not appraise initramfs. The embedded /init sets all the
>> xattrs, changes the policy to appraise tmpfs, and then exec's the real
>> init? Then everything except the embedded /init and the file with the
>> xattrs will be appraised, and the embedded /init was verified as part of
>> the kernel image signature. The only additional kernel change needed
>> then is to add a config option to the kernel to disallow overwriting the
>> embedded initramfs (or at least the embedded /init).
> 
> Yes and no.  The current IMA design allows a builtin policy to be
> specified on the boot command line ("ima_policy="), so that it exists
> from boot, and allows it to be replaced once with a custom policy.
>  After that, assuming that CONFIG_IMA_WRITE_POLICY is configured,
> additional rules may be appended.  As your embedded /init solution
> already replaces the builtin policy, the IMA policy couldn't currently
> be replaced a second time with a custom policy based on LSM labels.

So your design assumption you're changing other code to work around in that
instance is the policy can only be replaced once rather than having a "finalize"
option when it's set, making it immutable from then on.

Rob
