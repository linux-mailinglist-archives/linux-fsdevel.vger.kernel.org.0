Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF3144940
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 02:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAVBQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 20:16:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46727 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgAVBQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:16:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id m26so4847154ljc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2020 17:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTrmpDPbM7QagWgFbn/XvaDbssQKCtZ+aK7kQ78b1YQ=;
        b=sbjgI932IVsBnwvZcFBnekfHjH6LPvKho84iI0IqHn/lre/vnHDKZVHxM1chNODhEO
         oeBlWCXMu1xE41wCdmoAkJJWr3Xo/D+ju9vZ24VZpOnhSgfRdcQ5am2PHHrxTnbqi0XX
         b6eAwer8WCvSMIGV6+9Wm90f1KZ3856dgqPB2hB+SbeEq0VAirrYLusuJK6x9OvIXK1e
         QDAc9rab8nWgGfMDGKUKmikIqpQ1Tb6qVVp8u1rUGV3i6DXFmO0XieZmSerhbsGxj1Kd
         Nom76vDbxrBnAL633zaFY9rrVrFB9Ton5m1jJHrUpOo8xzUYC7WMuWNZ+fTJ5iMxzctH
         wfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTrmpDPbM7QagWgFbn/XvaDbssQKCtZ+aK7kQ78b1YQ=;
        b=FMbjvMiqSQex9BQyRQC+nnstG+AEUJ69Q22HB+s6U+XH0PYYcFEj4lhFh9ogfqCIDg
         bgZ+HMq/Kz92X3FysLKtPX8j11eK7vgDoBIBUnTS2zmd+DLY7e9j5rI7iV+fB7O+cMny
         FU3oAVW/Uzx/dM+qsab33EV/NfAnGDckhINqugzAcbxpnyGlccblJwoENMGMJf4D+EHc
         9u27btp0TnuzPvEINKeASoY5Da2V6e3WOX3P2FNLVHZisKHKvhWIgq2qKkNVOtU5chA0
         u0dBMmIMQ9HvKtxNWDW+XpFLBgKMHch+QN/rp9byjC8hXPP92gag77dXCRcBGyZxIGym
         GAzg==
X-Gm-Message-State: APjAAAX14Q00pmGohkvo6+sW58y+96LP3YGrmvx4Gbavd7O4htE7c3Vf
        bC6vm5vieTJ7PXQAGKTn+V1abbIYSAAVF5rpGp60OQ==
X-Google-Smtp-Source: APXvYqx9Wcig2VJsMhSPvoP5661qvRVt8CMWdEp0WvbCQ34genipkG1eA/ei4esFDAtnsgj2YEIbFdJHl+MGczi/Wzs=
X-Received: by 2002:a2e:b52b:: with SMTP id z11mr18133901ljm.155.1579655807322;
 Tue, 21 Jan 2020 17:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20200120223201.241390-1-ebiggers@kernel.org> <20200120223201.241390-4-ebiggers@kernel.org>
In-Reply-To: <20200120223201.241390-4-ebiggers@kernel.org>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 21 Jan 2020 17:16:36 -0800
Message-ID: <CA+PiJmT1GPgLBYak51V04jtyDjOFPzSeaTxKryCqy3Ak6yAo6A@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] fscrypt: clarify what is meant by a per-file key
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 2:34 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Now that there's sometimes a second type of per-file key (the dirhash
> key), clarify some function names, macros, and documentation that
> specifically deal with per-file *encryption* keys.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. Feel free to add
Reviewed-by: Daniel Rosenberg <drosen@google>
