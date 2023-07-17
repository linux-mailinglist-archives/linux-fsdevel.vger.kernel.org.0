Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F057561CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjGQLnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGQLm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:42:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D12EE4F;
        Mon, 17 Jul 2023 04:42:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4Kqp1Psbz67Lnh;
        Mon, 17 Jul 2023 19:39:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 17 Jul
 2023 12:42:48 +0100
Date:   Mon, 17 Jul 2023 12:42:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Oleg Nesterov" <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Kees Cook" <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <kvmarm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 04/35] arm64/gcs: Document the ABI for Guarded Control
 Stacks
Message-ID: <20230717124247.00001f1c@Huawei.com>
In-Reply-To: <20230716-arm64-gcs-v1-4-bf567f93bba6@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
        <20230716-arm64-gcs-v1-4-bf567f93bba6@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 16 Jul 2023 22:51:00 +0100
Mark Brown <broonie@kernel.org> wrote:

> Add some documentation of the userspace ABI for Guarded Control Stacks.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Hi Mark,

Nice document.  All I could find on a first read was one typo...

...

> +7.  ptrace extensions
> +---------------------
> +
> +* A new regset NT_ARM_GCS is defined for use with PTRACE_GETREGSET and
> +  PTRACE_SETREGSET.
> +
> +* Due to the complexity surrounding allocation and deallocation of stakcs and

stacks

> +  lack of practical application changes to the GCS configuration via ptrace
> +  are not supported.
> +

