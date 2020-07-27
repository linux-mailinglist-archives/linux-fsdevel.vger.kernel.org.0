Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167B522F68D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgG0RZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:25:41 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgG0RZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:25:40 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MC2o9-1k5MDf3aZx-00COYp; Mon, 27 Jul 2020 19:25:39 +0200
Received: by mail-qk1-f170.google.com with SMTP id 2so11868100qkf.10;
        Mon, 27 Jul 2020 10:25:38 -0700 (PDT)
X-Gm-Message-State: AOAM53133EXYITZmZGW14vx4amvBuI9bqNv3y8GMdxF943w3XFgZZ4ii
        QaobYtlLaYT0WJh+8pLguWbn8ZgdeikONE4SRYk=
X-Google-Smtp-Source: ABdhPJyHnciMJIel1lwAD5bow/zb/QGlp3YciXK2/NVdtnimMUPJo7yU6pZ4mJlHkwU8BKDS8Pa279r2z6tHPp7qb+M=
X-Received: by 2002:a37:b484:: with SMTP id d126mr23840011qkf.394.1595870737385;
 Mon, 27 Jul 2020 10:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200727162935.31714-1-rppt@kernel.org> <20200727162935.31714-5-rppt@kernel.org>
In-Reply-To: <20200727162935.31714-5-rppt@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 19:25:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Lbjdx_43-b0i1FXEfqaNPbaoXLraa2WikfPHrOZ6Kog@mail.gmail.com>
Message-ID: <CAK8P3a3Lbjdx_43-b0i1FXEfqaNPbaoXLraa2WikfPHrOZ6Kog@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] arch, mm: wire up memfd_secret system call were relevant
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EceBZqwyo4B1UVEZn/Xgzc7AE01Hrl25zqNiNRQE1nSOWMZWle+
 g7N+PnXRbCSAMr0XnZ49UfT+iW8IunuS9TPM822G37AEvmA3W7in5ND1Ye/8UnvHrrPI383
 kEGT+CmwlBf7zuvI0Sxkpzl1sWD2ck3PNJ8qOBybMEfmYFG+9s9wlKoe6v/QgUZ1P6d1R0y
 H6Ut5jTjR1+YQzurNJp/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tC2Xp4XT5xY=:L/0NRMbXw9YElq6rjWLtqI
 0Mr9VzUM7WLH9qn8aC+ng9oz0Sm/BE8sB2tVVg2loLmdQaSofHRMLqW5Y4pNJei7bc/dercWN
 Udlmt5WUOCU5zpzqvUwLUPFT1sF+o2a7pUVSA3ztLs1q3SQSiolebs104pJWejE1eanEdHu7h
 pAhPGDX0lgydu5PmjGhTyfOA8u60UZaG0ikMSmXVINfSK6/dGwD4fVJwwLUcNjdV1HKqQFsAz
 wPopjZsfVAljmtbwysL9ASZIYsxnDh+58NyIrxvgUsBHlBWS/2NqXJ+LFKj42LfOuycfr5IfT
 WxpeZ1lDMmGa+s6smQ5KisI2ySFTw6K5//f55QKlnKOakHMxaur1L1Ef7k+k+GOZPAu3QUwA4
 t8W299OnR0zZuJeJkGlWSA3Y7VfAIAIxe7nVI+nSLk7EakTipPaIfnOAX5/qMZjlyRKhNO4BI
 BH8MJ9WdtDzwQVfPL1vkRZmMy1eOT9G4EdhMn0GUm+fv59547if+HFv0N3b+biOXTql/861pT
 KHIzur9/Hbh+Yh+DJB2cE9PLgDdoAAjMk/cnxGxcvXXBv11dVaHYlwkWpZKM1inB91LtXdLLy
 RcD9NvwaM079xjiYEMzK10x5QNBWQbPw3/BgGFEC3hlmBdpws93U5bYzxakGXe+kPHcUuvRlC
 8CDFQNf2US/HaGllrd7w+cF30C/4IzgboUYrmJagytrGukMNmGcW4NUyu3nfUkvTn2kDYAEvj
 i56M62rt8WzjSv5WG1rSSs9FrJ46Gh/iFbQQR0NCTmAPCDfvWcWTDQYuBOL4SqCzbNwnXTvJ7
 Kgy40VpSpa6qgmeZpTDKScN3kXt34wbCVeakSB3aZT6XILnzTAKiComYlrxspK0Fo6uZVWuH6
 vkzqNYYGpLawOe0Ip2Ef50B7uOKtHKYGNL/mKbZgdfm/V5w7QJrno9H2Fk4Fe6BqnQudOSvK7
 E3ALx286dghNqXnZ9IkRNbDxpAQ8CTsKB8F0EmYmxlKE74AA0CKlJ
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 6:30 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Wire up memfd_secret system call on architectures that define
> ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
