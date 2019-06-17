Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20754918A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfFQUjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 16:39:53 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48736 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUjx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:39:53 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id EE5F720BCFC5; Mon, 17 Jun 2019 13:39:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id E8F2C3010321;
        Mon, 17 Jun 2019 13:39:52 -0700 (PDT)
Date:   Mon, 17 Jun 2019 13:39:52 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     Milan Broz <gmazyland@gmail.com>
cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        ebiggers@google.com, mpatocka@redhat.com
Subject: Re: [RFC PATCH v4 1/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <ab346931-1d1b-bd2f-8314-ee4779bd44bf@gmail.com>
Message-ID: <alpine.LRH.2.21.1906171338590.64763@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190613010610.4364-1-jaskarankhurana@linux.microsoft.com> <20190613010610.4364-2-jaskarankhurana@linux.microsoft.com> <ab346931-1d1b-bd2f-8314-ee4779bd44bf@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 17 Jun 2019, Milan Broz wrote:

> On 13/06/2019 03:06, Jaskaran Khurana wrote:
> ...
>
>> Adds DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE: roothash signature *must* be
>> specified for all dm verity volumes and verification must succeed prior
>> to creation of device mapper block device.
>
> I had a quick discussion about this and one suggestion was
> to add dm-verity kernel module parameter instead of a new config option.
>
> The idea is that if you can control kernel boot commandline, you can add it
> there with the same effect (expecting that root device is on dm-verity as well).
>
> Isn't this better option or it is not going to work for you?

Seems like a better option to me, I will make the change and remove both 
the configs.

>
> Milan
>
Regards,
Jaskaran
