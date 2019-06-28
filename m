Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FFD5A78F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 01:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfF1X13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 19:27:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53018 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1X13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:27:29 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id 07D5F2007697; Fri, 28 Jun 2019 16:27:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id DD9873007AB2;
        Fri, 28 Jun 2019 16:27:28 -0700 (PDT)
Date:   Fri, 28 Jun 2019 16:27:28 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Eric Biggers <ebiggers@kernel.org>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mpatocka@redhat.com, gmazyland@gmail.com
Subject: Re: [RFC PATCH v5 0/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <20190628203450.GD103946@gmail.com>
Message-ID: <alpine.LRH.2.21.1906281552350.26685@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com> <20190628040041.GB673@sol.localdomain> <alpine.LRH.2.21.1906281242110.2789@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter> <20190628203450.GD103946@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Eric,

On Fri, 28 Jun 2019, Eric Biggers wrote:

>> In a datacenter like environment, this will protect the system from below
>> attacks:
>>
>> 1.Prevents attacker from deploying scripts that run arbitrary executables on the system.
>> 2.Prevents physically present malicious admin to run arbitrary code on the
>>   machine.
>>
>> Regards,
>> Jaskaran
>
> So you are trying to protect against people who already have a root shell?
>
> Can't they just e.g. run /usr/bin/python and type in some Python code?
>
> Or run /usr/bin/curl and upload all your secret data to their server.
>
> - Eric
>

You are correct, it would not be feasible for a general purpose distro, 
but for embedded systems and other cases where there is a more tightly 
locked-down system.

Regards,
Jaskaran.
