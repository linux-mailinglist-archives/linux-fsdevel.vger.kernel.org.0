Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA625825A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfF0MR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 08:17:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38161 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfF0MR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:17:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so2309746wrs.5;
        Thu, 27 Jun 2019 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8o+V9On0cYn/aqt2ZcRkFPjvUM6HJYXypZNhKOE3H1E=;
        b=Z3vNLv2Kk05ZzRZ+UH0G+dSj+W0LCAkYmCmgFW89H9gTfJoaGg7iKukKDCVXTXinfr
         T4qBQrGiQzCd7sTH0sSk7Pryv157+wiNjZ3hRdcpVRrCeVJu7vPP7sbPoZoAAT7f50hn
         JIHDNBXvVrv77LuujV65KSFnfNXhoKd1vq3CPBUinsuz3khDif+39F5TqYnBCHG9DiKN
         40vdE8hagRxHi9jlZTNZxpotPyme9lS/zSzHzqvgTpjda+XZhB11osgOEJdCJeXptT6r
         7+n9RspuTzRyMhcleXb/F64yUN2WEbCOyKP4bDchQ2Q9ZjfnbeiRzEFNsC6HqeTAPWEO
         DJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8o+V9On0cYn/aqt2ZcRkFPjvUM6HJYXypZNhKOE3H1E=;
        b=DdE+ZhuFZ+STNESysoeyzJOjAgv2n2GckJzddRcFljpWBtgqbKiuru7cmmOSSpM870
         +JZOHBGe1iEaoF50b0qeXPBBknPneN7FZWDCQ1rZK8PipP0aL+Dma/GVRbJgpkJZ5hFk
         rjm8xEPVv8q/ByIPAythah9sysBe/e17GdiL4IYcPDX3Nk9BfGrUSB6N1zuOA7Xn8oVZ
         CxDLwWycov6YeAJm3o8zXEVIHNdmMkn3/fP/Fc1QjTjIaE52KNdLYM3GKIHKwnIAy3c6
         Xb3Cfne4cYrx7kNUV2M5tYkXqnsmNhYcu93CLCVIROQ6hQsWHbzAaYztsg/tHXMSKm1Y
         DIvw==
X-Gm-Message-State: APjAAAWzWmOvoahj7zC6thsqZEA7PuC9R8yvl7VYqIxYgsFqcWhFQA15
        Ddoc3JaHP3WqGl4q9Mui5XY=
X-Google-Smtp-Source: APXvYqxdfGoJ3zQKfAekSI1xKH1yAH1nJAdq2mMehz804mTtSesrSQBNHMr19TjP3cCubARAC/wh3A==
X-Received: by 2002:adf:eacd:: with SMTP id o13mr3017975wrn.91.1561637846022;
        Thu, 27 Jun 2019 05:17:26 -0700 (PDT)
Received: from [10.43.17.24] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q1sm3920249wmq.25.2019.06.27.05.17.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 05:17:25 -0700 (PDT)
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig validation.
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org, scottsh@microsoft.com, ebiggers@google.com,
        mpatocka@redhat.com
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
 <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <568f2532-e46b-5ac7-4fc5-c96983702f2d@gmail.com>
Date:   Thu, 27 Jun 2019 14:17:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I tried to test test the patch, two comments below.

On 19/06/2019 21:10, Jaskaran Khurana wrote:
> The verification is to support cases where the roothash is not secured by
> Trusted Boot, UEFI Secureboot or similar technologies.
> One of the use cases for this is for dm-verity volumes mounted after boot,
> the root hash provided during the creation of the dm-verity volume has to
> be secure and thus in-kernel validation implemented here will be used
> before we trust the root hash and allow the block device to be created.
> 
> The signature being provided for verification must verify the root hash and
> must be trusted by the builtin keyring for verification to succeed.
> 
> The hash is added as a key of type "user" and the description is passed to 
> the kernel so it can look it up and use it for verification.
> 
> Kernel commandline parameter will indicate whether to check (only if 
> specified) or force (for all dm verity volumes) roothash signature 
> verification.
> 
> Kernel commandline: dm_verity.verify_sig=1 or 2 for check/force root hash
> signature validation respectively.

1) I think the switch should be just boolean - enforce signatures for all dm-verity targets
(with default to false/off).

The rest should be handled by simple logic - if the root_hash_sig_key_desc option
is specified, the signature MUST be validated in the constructor, all errors should cause
failure (bad reference in keyring, bad signature, etc).

(Now it ignores for example bad reference to the keyring, this is quite misleading.)

If a user wants to activate a dm-verity device without a signature, just remove
optional argument referencing the signature.
(This is not possible with dm_verity.verify_sig set to true/on.)


2) All DM targets must provide the same mapping table status ("dmsetup table"
command) as initially configured.
The output of the command should be directly usable as mapping table constructor.

Your patch is missing that part, I tried to fix it, add-on patch is here
https://git.kernel.org/pub/scm/linux/kernel/git/mbroz/linux.git/commit/?h=dm-cryptsetup&id=a26c10806f5257e255b6a436713127e762935ad3
(feel free to fold it in your patch)


Thanks,
Milan
