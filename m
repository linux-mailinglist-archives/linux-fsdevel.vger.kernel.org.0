Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACF743953
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 12:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjF3K1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjF3K1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A2EE;
        Fri, 30 Jun 2023 03:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67939616F7;
        Fri, 30 Jun 2023 10:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DCEC433C0;
        Fri, 30 Jun 2023 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688120867;
        bh=fqgWG9xEz9LQRlu2zsrFniOCeXMiZg/S9PLfSW2fGh0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gK9Sul1y7wSUOD//OnFlTmuL1Z12y07fplacQhMdrwiwnwCMIxcu2bNI2szihZ9Ni
         cXghbtAgxsYhVRwvGAhzCt4Hnf933TTtEI0Xn1vFmnrigwoP+HQzrJ3E1lZufSmY2j
         3aZBmvhyZzCmCH7Ynw8BkMs+AYcyR5fMov0l6Smh4vhZcjnDmAk8bjtapJ4rMv2hrg
         zj6PGIR02SNSGhAAK+8Hn84AYsJ3HPevOF761Q/OHOmnrC4xQEHVpG896laIGsneJu
         EMXyKzsfXz4jxlcGynInxZWO2HLGSt+T6fIeUtM4IIqXf7ed8R3560m7h0s39KwTnB
         8nQX/CfnmoBvw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 2/2] selftests/proc: Do not build x86-64 tests on
 non-x86-64 builds
In-Reply-To: <fd61fd96-f06f-4a2d-8707-0e1e395c9e51@p183>
References: <20230629162301.1234157-1-bjorn@kernel.org>
 <20230629162301.1234157-3-bjorn@kernel.org>
 <fd61fd96-f06f-4a2d-8707-0e1e395c9e51@p183>
Date:   Fri, 30 Jun 2023 12:27:44 +0200
Message-ID: <871qhttfbz.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Thu, Jun 29, 2023 at 06:23:00PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> The proc-empty-vm test is x86-64 only. Remove that test from
>> non-x86-64 builds.
>>=20
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> What's the address space size on risc-v?

Different sizes are supported, 39b, 48b, and 57b:
Documentation/riscv/vm-layout.rst

Did you have anything particular in mind?
