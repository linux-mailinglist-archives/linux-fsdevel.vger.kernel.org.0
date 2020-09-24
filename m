Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C6F277469
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgIXOz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgIXOz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:55:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EC7C0613CE;
        Thu, 24 Sep 2020 07:55:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d4so3810136wmd.5;
        Thu, 24 Sep 2020 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cxvl2MAleQcMTiG0WSrWtQ8ZVgZ+BIbKryf5RRhV2Ew=;
        b=UF9OPLc72qF28w6y+ivkNrmXc5fop6lS4sjwHWDd9rzAFwH/YxcaJyc57rdANGsIN4
         rYSEqsboWQ/6Rad3EEZAYH6sJkptJizRO8lNfWk6XYA0XKnfcTxYON3ug44BYQg9EMER
         pVgAFcgLfPn4DVLiJ3Hib3T01PXbwRe+Vojn0wE3Yok5pMEIejrXlJffXDd6qKuKAg44
         VtKof8h0scpGdPAcmiLAwTnzsODA8lRMiZPWSwQRsP90h1aLFuABF5VbrFI/sWnrFX0b
         uEmRRAQsmZaOnouVl0mGoQ3uar4fcGrE+qSzboc3C0J0BGGDyYXkJ66tiP5wIrQLNFZH
         wH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxvl2MAleQcMTiG0WSrWtQ8ZVgZ+BIbKryf5RRhV2Ew=;
        b=hTSqDBFuxLwaGxifgFSmpvbzTdTEM9PeZVn3VLkeG9V7YuGflMyrf2/22YvEnmaECP
         LOwE8IDY20r1fyOvlnnI+xIRcvzMa/H59XFnwvo5yfKlE2hXTgkydzy2A9JSLtMBoZS6
         Z1cb0nUjKWkOCVFXvTSveieyyT0WgiZA2xIAmcLePmgz+wJ31wdFtG3bHnii98flaA9V
         AmB4cbxuMzri1VYIiaqEZrfKhhtiT7gtYwZ+r5Zph0QJsTiUx+EHRmDqAeG5R/H7wU3K
         DLk1NB36E2eWK6ngBIPMjSxGEo79x0jzRYSJSadmmlXH9SMjhtIXZI9UdqshQ4AmtFut
         yhSA==
X-Gm-Message-State: AOAM530WYbpEYFUTx96mjoHRc1qwS2+CZtSQVLgCdF2LD2E17WwLzX2z
        5dZl4wdsVFF5DO2rTkZBpz0=
X-Google-Smtp-Source: ABdhPJwA7ld5rBdiNBafXko+QQDLwn3uoHLR26xm9fJkwIdPYX0Ec6468qIEwFlntmVrZ1YEq/Neew==
X-Received: by 2002:a1c:4b17:: with SMTP id y23mr5136571wma.162.1600959354790;
        Thu, 24 Sep 2020 07:55:54 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.60.68])
        by smtp.gmail.com with ESMTPSA id h76sm4156994wme.10.2020.09.24.07.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 07:55:54 -0700 (PDT)
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, cl@linux.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, david@redhat.com,
        elena.reshetova@intel.com, hpa@zytor.com, idan.yaniv@ibm.com,
        jejb@linux.ibm.com, kirill@shutemov.name,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, luto@kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, mtk.manpages@gmail.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org,
        rppt@linux.ibm.com, shuah@kernel.org, tglx@linutronix.de,
        tycho@tycho.ws, viro@zeniv.linux.org.uk, will@kernel.org,
        willy@infradead.org, x86@kernel.org
References: <20200924133513.1589-1-rppt@kernel.org>
Subject: Re: [PATCH] man2: new page describing memfd_secret() system call
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
Message-ID: <efb6d051-2104-af26-bfb0-995f4716feb2@gmail.com>
Date:   Thu, 24 Sep 2020 16:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924133513.1589-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Mike Rapoport:
 > +.PP
 > +.IR Note :
 > +There is no glibc wrapper for this system call; see NOTES.

You added a reference to NOTES, but then in notes there is nothing about 
it.  I guess you wanted to add the following to NOTES (taken from 
membarrier.2):

.PP
Glibc does not provide a wrapper for this system call; call it using
.BR syscall (2).

Cheers,

Alex
