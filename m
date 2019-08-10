Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38AB88D9D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 22:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfHJUri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Aug 2019 16:47:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33253 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfHJUrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:47:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so145672199otl.0;
        Sat, 10 Aug 2019 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5j1WOyiF8SuI/K9sc0sg2QlEKDu+SHpvsRnF7h1iTVg=;
        b=KUr9xOzWnC/gL8k9K0IAZ4y9qVw4oXDTy8DYpXm3gjKZggxFIUKEBAgU2GqTIBCffP
         8rb6vgW2Jz5mcHtGIQlBE2HcHKb9cCJaWwmN96EW9C/yx+TJabHxWCTRtQ6AklX0Rarn
         lumHFQluwWtdQGT2PISpMAzTKQmR5Gxnumrg7hsiJnlLVf2M5tYVPoo7RktMBEiRj2EP
         QEt6dEgQNFUPSzyQbitXnYd1Gy/fKCrutWwL1MJ7QGhLWfd+iNzm4rX9Y3Pzvm4Y9VFT
         H9UyBc4OoePbB4F0vCCoAd7+QnP/eesVF+IQl64BjmbJ2zNl0QvOeA58B9pjatPHIEix
         kHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5j1WOyiF8SuI/K9sc0sg2QlEKDu+SHpvsRnF7h1iTVg=;
        b=TbDej6UYdk2PxoSjvuO7+PC1jvAD2zJiKsMc6zmQuY+XUlGNGXfjKixYAt7VY5tYCY
         CN0onQ3qag4rJx03o71IZOIFhvIHPxBXH6TZC2limYyBNx9OPDKJswV2yp7MfWZs9aha
         JlexM9HqfTxOPYDXqFL343APIs5uKspILRlLRmPRrFvq7l79IgM27fS46U+6YBCVcvkZ
         Qcl+YkHd4yjKrSRcTXVHrUrI/axbHu+vKB1bMa9Z0df8aRDveisp2oDcISjtYd/TGDu5
         aej+dBSJCAzntwmd4R8RkRtfrqinPvqxszY32so+DhIPN/DtNC5L9O9SKl+MMeI+x72C
         R6Ww==
X-Gm-Message-State: APjAAAUmgRRFvhKtQ5p15gSgyk5nuafjfJqPdQHYKq29E5c0tcke1Gno
        K40QlircZTXm6ee11vXz/4q+fCQo//Qg914N0sA6yw==
X-Google-Smtp-Source: APXvYqzcwCc7bIeiO/j07C8FaJX6CnNQvE3nUs/oCycy00nyxBs+rjvzo05eebzsq6aum8gP9IL47hR8VLp/QFLCS0U=
X-Received: by 2002:a5e:8210:: with SMTP id l16mr27792136iom.240.1565470041896;
 Sat, 10 Aug 2019 13:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-5-deepa.kernel@gmail.com>
 <eb2027cdccc0a0ff0a9d061fa8dd04a927c63819.camel@codethink.co.uk>
In-Reply-To: <eb2027cdccc0a0ff0a9d061fa8dd04a927c63819.camel@codethink.co.uk>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 10 Aug 2019 13:47:10 -0700
Message-ID: <CABeXuvrFze2-vDWyoFApoHK=yRWEZaNiYCy_DR+q3GZhty+MWg@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 04/20] mount: Add mount warning for impending
 timestamp expiry
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This doesn't seem like a helpful way to log the time.  Maybe use
> time64_to_tm() to convert to "broken down" time and then print it with
> "%ptR"... but that wants struct rtc_time.  If you apply the attached
> patch, however, you should then be able to print struct tm with
> "%ptT".

OK. Will print a more user friendly date string here.

Thanks,
-Deepa
