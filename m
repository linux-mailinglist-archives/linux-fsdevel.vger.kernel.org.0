Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284BA1E5A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 01:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfENXio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 19:38:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:47037 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfENXio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 19:38:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id 203so424578oid.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kYvQT6mY9JfQHDpLNfUkCh431/BzUwth4mETG8vnTcM=;
        b=rH1kN6xjlUQPAimKjhf1g5xol5K7bxpX+XExDwea7rJ/vrEQeHR+gNLXC3ZVH4TQZ9
         nB+xK5+dfFBG+AS7/qk8hqyz2HQWexnTzW8k5LJW1xanq4EH8KofvdU+krYoB4fiF8Vt
         fPWv1qAMT3PwG44QcHmls8cQO1gCx6JOi0ZF7v60B6oUPIayDactRAml6HwN/Z9XOve5
         ipNHYxw0+3e1MrlsX6gxLtTtFC7qklUGicX7c6sNm+KGZAZRTO3CR+Vb+0+CyjD/lvna
         uv4xTwEp5X40rPribrLMqvuk4Sk3d3SkDo1lGscczxN91c6+TpmIAuOPFrsNrQ2x/hlX
         cVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kYvQT6mY9JfQHDpLNfUkCh431/BzUwth4mETG8vnTcM=;
        b=XrgAFN/C9VYC379dpakZ8XW75ciaanI9fZqazi/ciGmP4dTQJiNlR1S3WQDpD689kg
         QZ0LcHTLVQsgq1VLy0t/j7Ebzxf7m6hjjMBXX7Qm08gCkQAOYD/hPp52+SOsfh6EoM9e
         y0n11A+I42G0y9olYCPNrGYcc/qLJk/cA+wYibRHdonw2M3r/PUJurAkh8aa+WXZkerM
         pUbnt43KmZaYN45T6I4Ae9jWP4XxmiAgUqxzlJXq5g13Ig2TPAOCzMnIIY5RhhrNKS/h
         X43g4rac7McdV9GH0FoG/KdeDeMYSFym44HCF4SIPGA3PUjybyciMRozBST7XJ37Xgf3
         L+QQ==
X-Gm-Message-State: APjAAAXsYKPGjxrYnZXC3PbfBK9hMKiKDs3epqlxXqyrKaVhZ+jO1LWs
        1RGczqBbjwmJyQBD2qZx8apfvA==
X-Google-Smtp-Source: APXvYqxxe8Yr5f9XAWXGbDojS8nV2uootZLPvLP3tvJ3cgiNcLPrf4uxkN+Rr9TfiQsk/Azg0isydg==
X-Received: by 2002:aca:f189:: with SMTP id p131mr367929oih.89.1557877123450;
        Tue, 14 May 2019 16:38:43 -0700 (PDT)
Received: from [192.168.1.5] (rrcs-97-77-70-138.sw.biz.rr.com. [97.77.70.138])
        by smtp.googlemail.com with ESMTPSA id x64sm141795oia.32.2019.05.14.16.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 16:38:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Arvind Sankar <niveditas98@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <CALCETrV3b205L38xqPr6QqwGn6-vxQdPoJGUygJJpgM-JqqXfQ@mail.gmail.com>
 <1557861511.3378.19.camel@HansenPartnership.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <4da3dbda-bb76-5d71-d5c5-c03d98350ab0@landley.net>
Date:   Tue, 14 May 2019 18:39:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557861511.3378.19.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/19 2:18 PM, James Bottomley wrote:
>> I think Rob is right here.  If /init was statically built into the
>> kernel image, it has no more ability to compromise the kernel than
>> anything else in the kernel.  What's the problem here?
> 
> The specific problem is that unless you own the kernel signing key,
> which is really untrue for most distribution consumers because the
> distro owns the key, you cannot build the initrd statically into the
> kernel.  You can take the distro signed kernel, link it with the initrd
> then resign the combination with your key, provided you insert your key
> into the MoK variables as a trusted secure boot key, but the distros
> have been unhappy recommending this as standard practice.
> 
> If our model for security is going to be to link the kernel and the
> initrd statically to give signature protection over the aggregate then
> we need to figure out how to execute this via the distros.  If we
> accept that the split model, where the distro owns and signs the kernel
> but the machine owner builds and is responsible for the initrd, then we
> need to explore split security models like this proposal.

You can have a built-in and an external initrd? The second extracts over the
first? (I know because once upon a time conflicting files would append. It
sounds like the desired behavior here is O_EXCL fail and move on.)

Rob
