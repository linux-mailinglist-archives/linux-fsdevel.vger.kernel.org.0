Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8155708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbfFYSUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 14:20:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfFYSUW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:20:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C107D223885;
        Tue, 25 Jun 2019 18:20:11 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BFC51972E;
        Tue, 25 Jun 2019 18:20:05 +0000 (UTC)
Date:   Tue, 25 Jun 2019 14:20:04 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        gmazyland@gmail.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, scottsh@microsoft.com,
        ebiggers@google.com, jmorris@namei.org, dm-devel@redhat.com,
        mpatocka@redhat.com, agk@redhat.com
Subject: Re: [RFC PATCH v5 1/1] Add dm verity root hash pkcs7 sig validation.
Message-ID: <20190625182004.GA32075@redhat.com>
References: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
 <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619191048.20365-2-jaskarankhurana@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 25 Jun 2019 18:20:21 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 19 2019 at  3:10pm -0400,
Jaskaran Khurana <jaskarankhurana@linux.microsoft.com> wrote:

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
> 
> Signed-off-by: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>

Milan and/or others: could you please provide review and if you're OK
with this patch respond accordingly?

Thanks,
Mike
