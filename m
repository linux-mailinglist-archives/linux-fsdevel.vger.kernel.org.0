Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE307707F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbfGZRoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 13:44:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36954 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbfGZRoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 13:44:37 -0400
Received: by mail-io1-f68.google.com with SMTP id q22so106424391iog.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=XGiRMPASSfpdv0nLL5//ERFqTc1sdi81IJlbfjhUYF4=;
        b=lWH35tpTOr5GOyTvTY9XSo4VEIu3yVKwo0RN1ErJc1Fwrascs6Yyf72FAMPXvWD7z2
         0UcuLBoHkpCi4jJTuCoXWHJzJ9imt5qSUNCyFNwG4Bev/EAaP4hBJdD5wx/xdIyCLHhL
         NVwnJ4Tn6I8gWQufCRs0/vkMGIamZYubPkCA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XGiRMPASSfpdv0nLL5//ERFqTc1sdi81IJlbfjhUYF4=;
        b=mhZegXlS4QoP23fYSuY52RBDlN6Pn9u1Ci9NQJWr5NuXKve9Kw5lylDxoMK3tQgWu5
         k6QbzDJPz+t2EJo7DPYM4yV3+SyCYs+t/wcp0/yiFAfRTLsXtWY4KRIgwqLar4/pbOES
         AVBwOIx9XdZtDqN6+qAcQasoDezkoGSmgEOp//NioCuSPUjBFCMrHyf0TbU9VVyAnEJ8
         RrN6Vdj2LJL97h4z52aE+igHV2wSbDNv4zbsD1G8gE7OUJOWk6MH3rQGsfMOauB+sreX
         dMGkfmip95t/pgAmJpH20qzElDe5wlCi7CaV0rXpzA0cGqaMAaAioizQp4T1+vpnoAau
         WVag==
X-Gm-Message-State: APjAAAWnwYbtu6xgwOzW7e3wCYUBY1nbBcaUbajPwiHHlJDVs1NrFC5Q
        jc/DdHETMSE7dX/b2fVUB6sBC679y1o=
X-Google-Smtp-Source: APXvYqydGamD77yN6D4R8mBX9gBg5TFDwl5rrLfOfm/lRaJMQ1nBUPwhofNlYy7qDVSduUADzrrjRg==
X-Received: by 2002:a02:914c:: with SMTP id b12mr53261639jag.105.1564163076802;
        Fri, 26 Jul 2019 10:44:36 -0700 (PDT)
Received: from [10.10.7.141] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id h8sm49606627ioq.61.2019.07.26.10.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 10:44:36 -0700 (PDT)
Subject: Re: UDF filesystem image with Write-Once UDF Access Type
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.com>, Roald Strauss <mr_lou@dewfall.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190712100224.s2chparxszlbnill@pali>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <35c0e9f3-b3b6-96c3-e339-2267a3abde9b@digidescorp.com>
Date:   Fri, 26 Jul 2019 12:44:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190712100224.s2chparxszlbnill@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 7/12/19 5:02 AM, Pali Rohár wrote:
> In my opinion without support for additional layer, kernel should treat
> UDF Write-Once Access Type as read-only mount for userspace. And not
> classic read/write mount.
>
> ...
>
> It seems that udf.ko does not support updating VAT table, so probably it
> should treat also filesystem with VAT as read-only too.
>

I thinkb085fbe2ef7fa7489903c45271ae7b7a52b0f9ab  <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/udf?h=v5.1&id=b085fbe2ef7fa7489903c45271ae7b7a52b0f9ab>, deployed in 4.20,
does both of the things you want.

One case I ran across today that Windows handles, but Linux doesn't,
is write-protection via flags in the DomainIdentifier fields of the
Logical Volume Descriptor and File Set Descriptor. Linux allows
RW mount when those are marked protected, but Windows forces RO mount.


Regards,
------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

