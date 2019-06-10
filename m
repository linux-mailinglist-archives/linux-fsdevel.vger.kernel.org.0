Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E0E3BFDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 01:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbfFJX1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 19:27:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50240 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390500AbfFJX1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 19:27:21 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id 2B7FD20B7194; Mon, 10 Jun 2019 16:27:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 25042311B1C8;
        Mon, 10 Jun 2019 16:27:21 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:27:21 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Milan Broz <gmazyland@gmail.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        ebiggers@google.com, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [RFC PATCH v3 1/1] Add dm verity root hash pkcs7 sig
 validation
In-Reply-To: <54170d18-31c7-463d-10b5-9af8b666df0f@gmail.com>
Message-ID: <alpine.LRH.2.21.1906101624350.31134@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190607223140.16979-1-jaskarankhurana@linux.microsoft.com> <20190607223140.16979-2-jaskarankhurana@linux.microsoft.com> <54170d18-31c7-463d-10b5-9af8b666df0f@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sat, 8 Jun 2019, Milan Broz wrote:

> On 08/06/2019 00:31, Jaskaran Khurana wrote:
>> The verification is to support cases where the roothash is not secured by
>
>> +	key = request_key(&key_type_user,
>> +			key_desc, NULL);
>> +	if (IS_ERR(key))
>> +		return PTR_ERR(key);
>
> You will need dependence on keyring here (kernel can be configured without it),
> try to compile it without CONFIG_KEYS selected.
>
> I think it is ok that  DM_VERITY_VERIFY_ROOTHASH_SIG can directly require CONFIG_KEYS.
> (Add depends on CONFIG_KEYS in KConfig)
>

DM_VERITY_VERIFY_ROOTHASH_SIG selects SYSTEM_DATA_VERIFICATION and 
SYSTEM_DATA_VERIFICATION selects KEYS so we should be OK here.

>
> Thanks,
> Milan
>
Thanks,
Jaskaran.
