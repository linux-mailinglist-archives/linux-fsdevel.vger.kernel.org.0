Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3877B2DBA99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 06:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgLPF0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 00:26:12 -0500
Received: from grey.apple.relay.mailchannels.net ([23.83.208.78]:3713 "EHLO
        grey.apple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgLPF0M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 00:26:12 -0500
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3140F32069D;
        Wed, 16 Dec 2020 05:25:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a54.g.dreamhost.com (100-98-118-97.trex.outbound.svc.cluster.local [100.98.118.97])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C404C32042B;
        Wed, 16 Dec 2020 05:25:25 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from pdx1-sub0-mail-a54.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.11);
        Wed, 16 Dec 2020 05:25:26 +0000
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Name: 403281df64e7ad98_1608096326038_1764683299
X-MC-Loop-Signature: 1608096326038:524884367
X-MC-Ingress-Time: 1608096326038
Received: from pdx1-sub0-mail-a54.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a54.g.dreamhost.com (Postfix) with ESMTP id 8BCFA7EECD;
        Tue, 15 Dec 2020 21:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=gotplt.org; h=subject:to
        :cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=gotplt.org; bh=0SykCQ
        KoLwLjRG28zbQq2C0iVc8=; b=e/pzchIHMtoAGCKGupcN8Ja0A2eijaSAayMfho
        rZBUkflFUyKWevsRZOM1oew5LugLnypCvJJ2D1LtnzLMhRkSSWX0Q7Kh5RWMFDJt
        YHsFVje+091qi7qpjCR74Zr3O3XbIKCvPKgXAjuywQtyNcvU0lyk2B0Pf/KJjOTz
        TLXeo=
Received: from [192.168.1.111] (unknown [1.186.101.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: siddhesh@gotplt.org)
        by pdx1-sub0-mail-a54.g.dreamhost.com (Postfix) with ESMTPSA id D3EFE7EEDE;
        Tue, 15 Dec 2020 21:25:21 -0800 (PST)
Subject: Re: [PATCH v2] proc: Escape more characters in /proc/mounts output
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>
References: <20201215125318.2681355-1-siddhesh@gotplt.org>
 <20201216043323.GM3579531@ZenIV.linux.org.uk>
X-DH-BACKEND: pdx1-sub0-mail-a54
From:   Siddhesh Poyarekar <siddhesh@gotplt.org>
Message-ID: <b13c0b71-dd3b-4a2b-1fc7-16d6fea36d46@gotplt.org>
Date:   Wed, 16 Dec 2020 10:55:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201216043323.GM3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/16/20 10:03 AM, Al Viro wrote:
> Once more, with feeling: why bother?  What's wrong
> with using the damn strndup_user() and then doing
> whatever checks you want with the data already
> copied, living in normal kernel memory, with all
> string functions applicable, etc.?

I was trying to avoid the allocation, but I reckon it is pointless to 
micro-optimize the invalid case.  I'll send v3.

Siddhesh
