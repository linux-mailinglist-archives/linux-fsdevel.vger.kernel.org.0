Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4E8C468
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 00:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfHMWmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 18:42:22 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40528 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfHMWmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:42:22 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id CD4FE20B7187; Tue, 13 Aug 2019 11:49:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD4FE20B7187
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id 039FE3005457;
        Tue, 13 Aug 2019 11:49:40 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:49:39 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Mike Snitzer <snitzer@redhat.com>
cc:     gmazyland@gmail.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, scottsh@microsoft.com,
        ebiggers@google.com, jmorris@namei.org, dm-devel@redhat.com,
        mpatocka@redhat.com, agk@redhat.com
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <20190625182004.GA32075@redhat.com>
Message-ID: <alpine.LRH.2.21.1908131147390.95186@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com> <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com> <20190625182004.GA32075@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Mike,
On Tue, 25 Jun 2019, Mike Snitzer wrote:

> On Wed, Jun 19 2019 at  3:10pm -0400,
> Jaskaran Khurana <jaskarankhurana@linux.microsoft.com> wrote:
>
>> The verification is to support cases where the roothash is not secured by
>> Trusted Boot, UEFI Secureboot or similar technologies.
>> One of the use cases for this is for dm-verity volumes mounted after boot,
>> the root hash provided during the creation of the dm-verity volume has to
>> be secure and thus in-kernel validation implemented here will be used
>> before we trust the root hash and allow the block device to be created.
>>
>> The signature being provided for verification must verify the root hash and
>> must be trusted by the builtin keyring for verification to succeed.
>>
>> The hash is added as a key of type "user" and the description is passed to
>> the kernel so it can look it up and use it for verification.
>>
>> Kernel commandline parameter will indicate whether to check (only if
>> specified) or force (for all dm verity volumes) roothash signature
>> verification.
>>
>> Kernel commandline: dm_verity.verify_sig=1 or 2 for check/force root hash
>> signature validation respectively.
>>
>> Signed-off-by: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
>
> Milan and/or others: could you please provide review and if you're OK
> with this patch respond accordingly?
>

The v7 of this patch was Reviewed and Tested by Milan Broz. Could you tell 
me when this will be merged/next steps, if required I can post the patches 
again.

> Thanks,
> Mike
>
Regards,
Jaskaran
