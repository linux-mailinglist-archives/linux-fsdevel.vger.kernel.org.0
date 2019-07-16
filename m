Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F413A6A907
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbfGPM7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 08:59:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37185 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPM7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:59:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so20863180wrr.4;
        Tue, 16 Jul 2019 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w9BxyRWmPBlvIeLtR87nRY5VKE+s5L3fJe5sGlRHZJM=;
        b=jrBp9R2lSvz8mzkqTX5FdlapNqw8F9d8ZpJXbN3mOzvIEKGOBn3NsI2DDna5+kvejb
         CqusQJuIfUj6WOqKeRbupdtCZAX6qig9Qv/m+Nf6wcYRWBlBA1EfMWW/l0EzRdsE91ry
         53k7IVXKUcMR0ketxsgIgOy/6WaBE8/9fBnRUa/HsqO1VRgt5gPRQtzMaLdBacqGNtAj
         8FTie2M3ITO0bTG1nlg5IIGkwnsobaOHKJpSWU9lAcxILoxxb42PVgzWMgWwzLc/vD5+
         hPzfxpCtlUw4mi8WMT8jIZTn6dQrIo3QJKpHDauhCQZIQmcRt2tUPYAojf20prF3Zfws
         b9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w9BxyRWmPBlvIeLtR87nRY5VKE+s5L3fJe5sGlRHZJM=;
        b=UVYsd6S6jIJy3WJEbnEvtywxb9jbSrFE3O7Cq5NrJLsTddTzKxCKEGWkAoeuWJEnZv
         8PMpb0gSVENMCps80Ox3tmj0bLWsbBZ05Ri+ZoDKiRysfr+38gmAh36HEpSgR0P3uzjL
         dk6DZjH1M2H2IWgPlS1yUD0ytbxRalsGh+1j+VqaF+HQYiIyO8QvMpYx/CDjbedfIzJ0
         GBsxsjWiFjp4GAWtBQNNvDqz/0Q5D4w3H12l0q2L3Jq4CCsJ+UBVuxH3o/UZqzahSzv1
         UkJAza53VHr2AhNCL6sKd0iy6BkfHaWtfeSJBSZFajHi9fclivfpV3ysvZOOb1kiPYJg
         uy7g==
X-Gm-Message-State: APjAAAV/TAEwa3CrZwgdC0Lv/3qzcetvZi+4qaEVQ2Us9KAHlgoZIfJl
        YfC4j0mm41KXNVRhKaE4pWeaeEbM
X-Google-Smtp-Source: APXvYqwUNedV7nyiAJsfAYj0IfYBVVW61M2i41mNTJJt8+IhH3UY5jgZgdgze/yJYLTpoxXKih7DTA==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr35491318wru.280.1563281954206;
        Tue, 16 Jul 2019 05:59:14 -0700 (PDT)
Received: from [10.43.17.52] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g17sm14849574wrm.7.2019.07.16.05.59.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 05:59:13 -0700 (PDT)
Subject: Re: [RFC PATCH v6 0/1] Add dm verity root hash pkcs7 sig validation.
To:     Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
Cc:     ebiggers@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org,
        Scott Shell <SCOTTSH@microsoft.com>,
        Nazmus Sakib <mdsakib@microsoft.com>, mpatocka@redhat.com
References: <20190701181958.6493-1-jaskarankhurana@linux.microsoft.com>
 <MN2PR21MB12008A962D4DD8662B3614508AF20@MN2PR21MB1200.namprd21.prod.outlook.com>
 <alpine.LRH.2.21.1907121025510.66082@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <395efa90-65d8-d832-3e2b-2b8ee3794688@gmail.com>
Date:   Tue, 16 Jul 2019 14:59:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1907121025510.66082@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/07/2019 19:33, Jaskaran Singh Khurana wrote:
> 
> Hello Milan,
> 
>> Changes in v6:
>>
>> Address comments from Milan Broz and Eric Biggers on v5.
>>
>> -Keep the verification code under config DM_VERITY_VERIFY_ROOTHASH_SIG.
>>
>> -Change the command line parameter to requires_signatures(bool) which will
>> force root hash to be signed and trusted if specified.
>>
>> -Fix the signature not being present in verity_status. Merged the
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmbroz%2Flinux.git%2Fcommit%2F%3Fh%3Ddm-cryptsetup%26id%3Da26c10806f5257e255b6a436713127e762935ad3&amp;data=02%7C01%7CJaskaran.Khurana%40microsoft.com%7C18f92445e46940aeebb008d6fe50c610%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636976020210890638&amp;sdata=aY0V9%2FBz2RHryIvoftGKUGnyPp9Fsc1JY4FZbHfW4hg%3D&amp;reserved=0
>> made by Milan Broz and tested it.
>>
>>
> 
> Could you please provide feedback on this v6 version.

Hi,

I am ok with the v6 patch; I think Mike will return to it in 5.4 reviews.

But the documentation is very brief. I spent quite a long time to configure the system properly.
I think you should add more description (at least to patch header) how to use this feature in combination with system keyring.

Do I understand correctly that these steps need to be done?

 - user configures a certificate and adds it in kernel builtin keyring (I used CONFIG_SYSTEM_TRUSTED_KEYS option).
 - the dm-verity device root hash is signed directly by a key of this cert
 - the signature is uploaded to the user keyring
 - reference to signature in keyring is added as an optional dm-verity table parameter root_hash_sig_key_desc
 - optionally, require_signatures dm-verity module is set to enforce signatures.

For reference, below is the bash script I used (with unpatched veritysetup to generate working DM table), is the expected workflow here?

#!/bin/bash

NAME=test
DEV=/dev/sdc
DEV_HASH=/dev/sdd
ROOT_HASH=778fccab393842688c9af89cfd0c5cde69377cbe21ed439109ec856f2aa8a423
SIGN=sign.txt
SIGN_NAME=verity:$NAME

# get unsigned device-mapper table using unpatched veritysetup
veritysetup open $DEV $NAME $DEV_HASH $ROOT_HASH
TABLE=$(dmsetup table $NAME)
veritysetup close $NAME

# Generate self-signed CA key, must be in .config as CONFIG_SYSTEM_TRUSTED_KEYS="path/ca.pem"
#openssl req -x509 -newkey rsa:1024 -keyout ca_key.pem -out ca.pem -nodes -days 365 -set_serial 01 -subj /CN=example.com

# sign root hash directly by CA cert
echo -n $ROOT_HASH | openssl smime -sign -nocerts -noattr -binary -inkey ca_key.pem -signer ca.pem -outform der -out $SIGN

# load signature to keyring
keyctl padd user $SIGN_NAME @u <$SIGN

# add device-mapper table, now with sighed root hash optional argument
dmsetup create -r $NAME --table "$TABLE 2 root_hash_sig_key_desc $SIGN_NAME"
dmsetup table $NAME

# cleanup
dmsetup remove $NAME
keyctl clear @u


Milan
