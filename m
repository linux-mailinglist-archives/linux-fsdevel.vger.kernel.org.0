Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E70B39BE8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFHIqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jun 2019 04:46:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32971 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfFHIqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jun 2019 04:46:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so4385597wru.0;
        Sat, 08 Jun 2019 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3N/XFRIaKbINErkXA+aSRWo990wI94tbeX8s5X2Uaok=;
        b=Yzk2WxKg7rUSYJvzOSUtot05gkixTAjFdinc4pTAR6dcHnA/TbGQmOlDbabUzd/7h5
         5oiu8LoTp/om2qc+qhknzxPaexWfTNo4VA/XIUzNQnc8OLpUeGT0O9sX65q5YPXcvMVa
         paHoegJQx0Rtbbges9CoF5JW5ZQwedsgBjKvwuUvMWv+FbyKv64RDQdzvZwz3wRe5zwk
         nWAJ8jnePsqSc9CnJdRxjjalJQRjPSVf3wG9P5MdG20Wbv/fH9he9Hx+kFCE77fIrvvT
         pfVxE3tU5XhjT7I+oQ86XffBGfwNdqb4cSFjiIctNbhVHjv6oUl9MbkzUg6U3NMYvonF
         gACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3N/XFRIaKbINErkXA+aSRWo990wI94tbeX8s5X2Uaok=;
        b=Z5BKsuyv7OySoCpateYTUdGja11rWI1DlSuf2ETF3To//mYYX/+B149IXllaXOCL2F
         wZ9vn48rMUPLwwOfO7s0sViX5VGRryGUwJfnQJl1so0PtUSR8eThMRHMYYK9ZGDtaUUB
         cj8ZLIHe2LeqGhG0Ws4zieIop35YjFMs6e3rw5TdGPzW5VLT5iq4DwixBWkP7UQ1T3Rn
         DTeEPwRXZ/rjg9UwxS9hKOuAg4Y81NZuxo8vvCexi45K/8ZFwXMG1dlUZkgOAPq5Arpo
         9KkHZPOEh4jk6Bao5XBqbwpWj1jRKVDimf/I3JFpgZUPoebNb9s9LiVeZDflxnRmJ21n
         aJXQ==
X-Gm-Message-State: APjAAAXhZB4+5wZfAf6xLpAF5o6nYzXjlLhkH7cJ7z8bOjG7isDx/S7J
        IFWx62C04IFo7a+0mjQKmAXwY4CztHg=
X-Google-Smtp-Source: APXvYqzN5HNc4x2T6imkzJNU+3V1TV0C0bzXb7kG4XLciS740u6uhJE5AUd2bEetnnwapCXYtIdpAw==
X-Received: by 2002:adf:db02:: with SMTP id s2mr1363063wri.326.1559983582470;
        Sat, 08 Jun 2019 01:46:22 -0700 (PDT)
Received: from [192.168.8.100] (37-48-58-25.nat.epc.tmcz.cz. [37.48.58.25])
        by smtp.gmail.com with ESMTPSA id v24sm3089236wmj.26.2019.06.08.01.46.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 01:46:21 -0700 (PDT)
Subject: Re: [RFC PATCH v3 0/1] Add dm verity root hash pkcs7 sig validation.
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org, scottsh@microsoft.com, ebiggers@google.com,
        mpatocka@redhat.com
References: <20190607223140.16979-1-jaskarankhurana@linux.microsoft.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <3f9f2df1-c811-18d4-2665-0ffddb7a7f0e@gmail.com>
Date:   Sat, 8 Jun 2019 10:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607223140.16979-1-jaskarankhurana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/06/2019 00:31, Jaskaran Khurana wrote:
> This patch set adds in-kernel pkcs7 signature checking for the roothash of
> the dm-verity hash tree.
> The verification is to support cases where the roothash is not secured by
> Trusted Boot, UEFI Secureboot or similar technologies.

...
>  drivers/md/Kconfig                |  23 ++++++
>  drivers/md/Makefile               |   2 +-
>  drivers/md/dm-verity-target.c     |  34 +++++++-
>  drivers/md/dm-verity-verify-sig.c | 132 ++++++++++++++++++++++++++++++
>  drivers/md/dm-verity-verify-sig.h |  30 +++++++

Please could you also modify Documentation/device-mapper/verity.txt and
describe the new table parameter?

It would be also nice to have a reference example how to configure it,
including how to create the signature file.

Milan
