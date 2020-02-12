Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1BA15B278
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 22:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgBLVIS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 16:08:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42422 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBLVIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:08:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id o28so2189848qkj.9;
        Wed, 12 Feb 2020 13:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5skQ4pXUf/HDFGAeb5bLaBWEPVpcuLwc5TmCpIE/Zyo=;
        b=RSaubYsu2PWhj6d5WiWqImtwe+11ZkV5ynHfHfILKjiCGuE++75mluwkFvI8SVZwZ2
         FVcajjueWqco3jr0Ow8mWAloqkkz/nZRTVvMCaxsWYaaozSBLYtlqBPDl2d4JuFAqNKT
         4eM2bs0OP/sfoQPzSkrUIs84Z3nu+rJZqi4v7IUXscqVEZZbW98vR/RBjUUqx2TtekX0
         TdKQebQLkAL6NS0smHmAjLDkyMj9kl1d3gbFGuxjAksiARkiSvUrHsLzvzMMSA61Tl7B
         H3vZG2gITk1NdYTBU9v+AdkE/hfM87Q4MMY58PzHJjTjgVBPmQ+ApC8uSo0XfEPwidZz
         KPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5skQ4pXUf/HDFGAeb5bLaBWEPVpcuLwc5TmCpIE/Zyo=;
        b=ZgokC7Y6FrXXjUb8B8PX2v5SAVc7i2e2srbpkKx3dM/zoKuJtZcFHD4jcw4AgT7BEc
         n5aTpNgi5prO6A02lnr8BHCUySwzQkJ67y1fi0IsxtnnRnjO5Y+0EFguVEBzBhQmDi+K
         9iRJcM95OOZzryonGPlvAYNVRB7hvQl4E5XZSgPYcYN7qnhUJX5d97lrhAt/LFDtsgni
         HfXHUvIixJTJFCMutMhNBfuQz2V+65Q7taw0EHPKhzrNpNYWGVwpHkL+gPzydyqQrVvT
         bgULXjYshikcMmdinIvOrzdMIXokg1B6GPwDa+W1AUC6E5ofotQdf1EcKfDTMq3qZn8m
         d+5Q==
X-Gm-Message-State: APjAAAVbjcMtDHiT6nSQcz1jAfYIGa+6b+IlMAGA7dxzsbpS6gKxmwni
        RII/Kfa6Fk7KSB1sTKZgSKY=
X-Google-Smtp-Source: APXvYqxNOTEW/N3+A4eKLqICOc+Xj7XuhY3/asbxxLTsVO2pIzik8Myh1FUcd23UCDxfesq9IpEl8Q==
X-Received: by 2002:ae9:e10a:: with SMTP id g10mr9186036qkm.493.1581541697333;
        Wed, 12 Feb 2020 13:08:17 -0800 (PST)
Received: from localhost.localdomain (pool-74-108-111-89.nycmny.fios.verizon.net. [74.108.111.89])
        by smtp.gmail.com with ESMTPSA id t7sm32885qkm.136.2020.02.12.13.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:08:16 -0800 (PST)
Message-ID: <6b787049b965c8056d0e27360e2eaa8fa2f38b35.camel@gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
From:   david.safford@gmail.com
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     Ken Goldman <kgold@linux.ibm.com>, monty.wiseman@ge.com,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 12 Feb 2020 16:08:15 -0500
In-Reply-To: <1581462616.5125.69.camel@linux.ibm.com>
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
         <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
         <1580998432.5585.411.camel@linux.ibm.com>
         <40f780ffe2ddc879e5fa4443c098c0f1d331390f.camel@gmail.com>
         <1581366258.5585.891.camel@linux.ibm.com>
         <fab03a0b8cc9dc93f2d0db51071521ce82e2b96b.camel@gmail.com>
         <1581462616.5125.69.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-02-11 at 18:10 -0500, Mimi Zohar wrote:
> On Tue, 2020-02-11 at 11:10 -0500, david.safford@gmail.com wrote:

> > <snip>
> > 
> This new feature will require setting up some infrastructure for
> storing the partial measurement list(s) in order to validate a TPM
> quote.  Userspace already can save partial measurement list(s) without
> any kernel changes.  The entire measurement list does not need to be
> read each time.  lseek can read past the last record previously read.
>  The only new aspect is truncating the in kernel measurement list in
> order to free kernel memory.

This is a pretty important new feature.
A lot of people can't use IMA because of the memory issue.
Also, I really think we need to let administrators choose the tradeoffs
of keeping the list in memory, on a local file, or only on the 
attestation server, as best fits their use cases.
> 
> < snip> 
> 
> Until there is proof that the measurement list can be exported to a
> file before kexec, instead of carrying the measurement list across
> kexec, and a TPM quote can be validated after the kexec, there isn't a
> compelling reason for the kernel needing to truncate the measurement
> list.

If this approach doesn't work with all the kexec use cases, then it is 
useless, and the ball is in my court to prove that it does. Fortunately
I have to test that anyway for the coming TLV support.

Working on it...

dave

> Mimi
> 

