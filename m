Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10E239C02
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2019 11:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFHJLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jun 2019 05:11:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40867 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfFHJLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:11:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so4383930wre.7;
        Sat, 08 Jun 2019 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wRhHOWXbYPTgd9o6E+fWzXVTSQiB2lqpeHlQbHdnv6Y=;
        b=NAh51xEAoqQZeJs899fcX2BxvuroPDabyTqyEP1cbLvkNk78j7SsajGCd2FUFEn9pE
         GM3mkiTpIKjG2T3ZT+3E62uOmuDX4EZqkCu6mD23vkTREk6ySK38jrG5WTgdHMPDJ33R
         B6kbcHA4yuEukkpSnPTqVS96bpiIsdQRCS2qdC0z9bqK5W21iptut7P+nRBKVsUokcD7
         E9oP67WbWFxHtXK7tPN16/D6C2FZR0LLBvPMHLI3mxmLlDBUMOto8bVP6KhGhqTwEsha
         N5xaek5vhguSPRmbj9JYGqDkyGj703l/H9TlNYaSOgagrw36dhx/MQ2YSYauSs71m3oJ
         HCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wRhHOWXbYPTgd9o6E+fWzXVTSQiB2lqpeHlQbHdnv6Y=;
        b=ZcuRJtrym/CzyIyxhlWFzKbIKudz+On/DU8e1uWwHETPk68E58FJMeQg+P5LpBm/yA
         HGnOudrJ6sNykLRlf0bUL4lTlb8/ej1eELTLGNRPVFxXojg4z4uiPyJe9crCV5qIhsYK
         xgVOhQIH/+p5IT7gieuax3m1oc5Da7SzruRJ+DstE57OKl6cYlt2ubzsZDOowP7N0QXu
         enk/zGR7NVijzmHgtbaqMJIRHfOvKBtJTX/77q1YdXlq8d0iODTG5s9/Tv+lutY/Yd4v
         6BoeUx82tkvDfQPCqglBwm4IIEXH+TQ8VVG9pkwcrv7j1UDiN41I9RAZuoauHBS6+GiJ
         GY0w==
X-Gm-Message-State: APjAAAVxW9JpFUtlBiI5+R8vyBD+yySQkasqz6SBcST16cUht9BBRreA
        mRtHdgsKFiGW07AcOznN9fQ=
X-Google-Smtp-Source: APXvYqwM1/RGMYyTxmx2V0hdEZCN4VHYev4BVLwmFNnhFHp6W7idPt4B24+6it6AeMq4rfpflgd8Tg==
X-Received: by 2002:adf:bac5:: with SMTP id w5mr24577718wrg.124.1559985099809;
        Sat, 08 Jun 2019 02:11:39 -0700 (PDT)
Received: from [192.168.8.100] (37-48-58-25.nat.epc.tmcz.cz. [37.48.58.25])
        by smtp.gmail.com with ESMTPSA id p3sm5258127wrd.47.2019.06.08.02.11.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 02:11:39 -0700 (PDT)
Subject: Re: [RFC PATCH v3 1/1] Add dm verity root hash pkcs7 sig validation
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org, scottsh@microsoft.com, ebiggers@google.com,
        Mikulas Patocka <mpatocka@redhat.com>
References: <20190607223140.16979-1-jaskarankhurana@linux.microsoft.com>
 <20190607223140.16979-2-jaskarankhurana@linux.microsoft.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <54170d18-31c7-463d-10b5-9af8b666df0f@gmail.com>
Date:   Sat, 8 Jun 2019 11:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607223140.16979-2-jaskarankhurana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/06/2019 00:31, Jaskaran Khurana wrote:
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
> Adds DM_VERITY_VERIFY_ROOTHASH_SIG: roothash verification
> against the roothash signature file *if* specified, if signature file is
> specified verification must succeed prior to creation of device mapper
> block device.
> 
> Adds DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE: roothash signature *must* be
> specified for all dm verity volumes and verification must succeed prior
> to creation of device mapper block device.

AFAIK there are tools that use dm-verity internally (some container
functions in systemd can recognize and check dm-verity partitions) and with
this option we will just kill possibility to use it without signature.

Anyway, this is up to Mike and Mikulas, I guess generic distros will not
set this option.

Some minor details below:

> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index be7a6eb92abc..8a8c142bcfe1 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -61,7 +61,7 @@ obj-$(CONFIG_DM_LOG_USERSPACE)	+= dm-log-userspace.o
>  obj-$(CONFIG_DM_ZERO)		+= dm-zero.o
>  obj-$(CONFIG_DM_RAID)	+= dm-raid.o
>  obj-$(CONFIG_DM_THIN_PROVISIONING)	+= dm-thin-pool.o
> -obj-$(CONFIG_DM_VERITY)		+= dm-verity.o
> +obj-$(CONFIG_DM_VERITY)		+= dm-verity.o dm-verity-verify-sig.o

Why is this different from existing FEC extension? 
FEC uses ifdefs in header to blind functions if config is not set.

ifeq ($(CONFIG_DM_VERITY_FEC),y)
dm-verity-objs                  += dm-verity-fec.o
endif

...

> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
> new file mode 100644
> index 000000000000..1a889be76ede
> --- /dev/null
> +++ b/drivers/md/dm-verity-verify-sig.c

...

> +	key = request_key(&key_type_user,
> +			key_desc, NULL);
> +	if (IS_ERR(key))
> +		return PTR_ERR(key);

You will need dependence on keyring here (kernel can be configured without it),
try to compile it without CONFIG_KEYS selected.

I think it is ok that  DM_VERITY_VERIFY_ROOTHASH_SIG can directly require CONFIG_KEYS.
(Add depends on CONFIG_KEYS in KConfig)

Also please increase minor version of dm-verity target when adding functions, something like

@@ -1175,7 +1175,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 static struct target_type verity_target = {
        .name           = "verity",
-       .version        = {1, 4, 0},
+       .version        = {1, 5, 0},

Thanks,
Milan
