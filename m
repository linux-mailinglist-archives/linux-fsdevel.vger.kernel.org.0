Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B52969E922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 21:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjBUUvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 15:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjBUUvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:51:23 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31223302B3;
        Tue, 21 Feb 2023 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677012674;
        bh=N4w7g7bbMneGm4ZhMjhv9CTYknNcabj3wGfoOlMb5Zc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=kI+wXcMR6hXsTn+QR8f5sR1/1794Q6+xrneS7a5obWK88/qcS8iCO1S+SXD3kGmEn
         6jOuy/SIcFdvUXVdQgt2lVkdwszP8Ou9ICNcAE9xhTYhgpnq2ajQz5hDvkNYMCoRUT
         xPRfO+T5GS3icv0g1/j0HFG9Zw+KNbsgwkns8THE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id ADA661285D81;
        Tue, 21 Feb 2023 15:51:14 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FGjkMet321rv; Tue, 21 Feb 2023 15:51:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677012672;
        bh=N4w7g7bbMneGm4ZhMjhv9CTYknNcabj3wGfoOlMb5Zc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=ZI5rqcDpS+lxbOVqMrJXvhLWNx9advzwHK26ZLIrowuMjNn9YlbmAe31HnoDSe7H1
         AJmanRWkZ9B1Y+WmfTm08FjN1z+FoTmBFxdj+Cu6BGbMOkEo9EqRtohuo4rh043DR5
         BY3Fx6d44jyvbExWeZQ6rlhjCYVuGRDl6I4OaoOM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6110E1281F11;
        Tue, 21 Feb 2023 15:51:12 -0500 (EST)
Message-ID: <96463a32a97dc40bc30c47ddcdf19a5803de32d8.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Linux Security Summit cross-over?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 21 Feb 2023 15:51:11 -0500
In-Reply-To: <2896937.1676998541@warthog.procyon.org.uk>
References: <2896937.1676998541@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-02-21 at 16:55 +0000, David Howells wrote:
> 
> Since the first day of the LSS is the same as the final day of LSF
> and in the same venue, are there any filesystem + security subjects
> that would merit a common session?


I've got one:  Cryptographic material handling.

Subtitle could be: making keyrings more usable.

The broad problem is that the use of encryption within the kernel is
growing (from the old dm-crypt to the newer fscrypt and beyond) yet
pretty much all of our cryptographic key material handling violates the
principle of least privilege.  The latest one (which I happened to
notice being interested in TPMs) is the systemd tpm2 cryptenroll.  The
specific violation is that key unwrapping should occur as close as
possible to use: when the kernel uses a key, it should be the kernel
unwrapping it not unwrapping in user space and handing the unwrapped
key down to the kernel because that gives a way.  We got here because
in most of the old uses, the key is derived from a passphrase and the
kernel can't prompt the user, so pieces of user space have to gather
the precursor cryptographic material anyway.  However, we're moving
towards using cryptographic devices (like the TPM, key fobs and the
like) to store keys we really should be passing the wrapped key into
the kernel and letting it do the unwrap to preserve least privilege. 
dm-crypt has some support for using kernel based TPM keys (the trusted
key subsystem), but this isn't propagated into systemd-cryptenroll and
pretty much none of the other encryption systems make any attempt to
use keyrings for unwrap handling, even if they use keyrings to store
cryptographic material.

Part of the reason seems to be that the keyrings subsystem itself is
hard to use as a generic "unwrapper" since the consumer of the keys has
to know exactly the key type to consume the protected payload.  We
could possibly fix this by adding a payload accessor function so the
keyring consumer could access a payload from any key type and thus
benefit from in-kernel unwrapping, but there are likely a host of other
issues that need to be solved.  So what I'd really like to discuss is:

Given the security need for a generic in-kernel unwrapper, should we
make keyrings do this and if so, how?

Regards,

James



